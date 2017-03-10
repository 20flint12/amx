PROGRAM_NAME='Modbus'
(***********************************************************)
(* System Type : Netlinx                                   *)
(***********************************************************)


#include 'Misc.axi'


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


dvModbus  = 5001:2:1;

vdvModbus = 33101:1:1

vdvDebug  = 32999:1:1


DEFINE_CONSTANT



DEFINE_VARIABLE



(* ************************************* ModBus ************************************* *)

// ModBus
Define_Call 'ModBus - RS485 2-wire cable'     (Char bValue) { If (bValue) Send_Command vdvModbus, 'RS485_2WIRE = ON'; Else Send_Command vdvModbus, 'RS485_2WIRE = OFF'; }

Define_Call 'ModBus - Call Function'          (Char Function, Char Device, Integer Address, Integer QuantityOrValue) { If (Function == 5 && QuantityOrValue == 1) QuantityOrValue = $FF00;   Send_Command vdvModbus, "'ADDCOMMAND = ',         Format('%02X', Device), Format('%02X', Function), Format('%04X', Address), Format('%04X', QuantityOrValue)"; }
Define_Call 'ModBus - Call Function Priority' (Char Function, Char Device, Integer Address, Integer QuantityOrValue) { If (Function == 5 && QuantityOrValue == 1) QuantityOrValue = $FF00;   Send_Command vdvModbus, "'ADDPRIORITYCOMMAND = ', Format('%02X', Device), Format('%02X', Function), Format('%04X', Address), Format('%04X', QuantityOrValue)"; }



Define_Call 'Modbus - Write Multiple Coils' (Char DeviceAddress, Integer StartRegisterAddress, Integer QuantityOfCoils, Char Coils[])
{
	If (QuantityOfCoils && QuantityOfCoils <= $07B0)
	{
		local_var volatile Char    Bits[8];
		local_var volatile Char    bByteCount;
		local_var volatile Char    bData;
		local_var volatile Char    sData[512];
		local_var volatile Integer i;
		
    	Bits = "$01, $02, $04, $08, $10, $20, $40, $80";
		bByteCount = Type_Cast((QuantityOfCoils - 1) / 8 + 1);
		sData = "Format('%02X', DeviceAddress), Format('%02X', $0F), Format('%04X', StartRegisterAddress), Format('%04X', QuantityOfCoils), Format('%02X', bByteCount)";
		bData = $00; For (i = 1; i <= QuantityOfCoils; i++) { bData = bData | (Bits[(i - 1) % 8 + 1] * Coils[i]); If (i % 8 == 0) { sData = "sData, Format('%02X', bData)"; bData = $00; } }
		If (i % 8 != 1) { sData = "sData, Format('%02X', bData)"; }
		
		Send_Command vdvModbus, "'ADDCOMMAND = ', sData";
	}
}

Define_Call 'Modbus - Write Multiple Coils - Single coil' (Char DeviceAddress, Integer RegisterAddress, Char Coil)
{
	Send_Command vdvModbus, "'ADDCOMMAND = ', Format('%02X', DeviceAddress), Format('%02X', $0F), Format('%04X', RegisterAddress), Format('%04X', 1 /* QuantityOfCoils */), Format('%02X', 1 /* bByteCount */), Format('%02X', (Coil > 0))";
}



Define_Call 'Modbus - Write Multiple Registers' (Char DeviceAddress, Integer StartRegisterAddress, Integer QuantityOfRegisters, Integer Values[])
{
	If (QuantityOfRegisters && QuantityOfRegisters <= $7B)
	{
		local_var volatile Char    sData[512];
		local_var volatile Integer i;
		
		sData = "Format('%02X', DeviceAddress), Format('%02X', $10), Format('%04X', StartRegisterAddress), Format('%04X', QuantityOfRegisters), Format('%02X', QuantityOfRegisters * 2)";
	
		For (i = 1; i <= QuantityOfRegisters; i++)
			sData = "sData, Format('%04X', Values[i])";
		
		Send_Command vdvModbus, "'ADDCOMMAND = ', sData";
	}
}

Define_Call 'Modbus - Write Multiple Registers - Single register' (Char DeviceAddress, Integer RegisterAddress, Integer Value)
{
	Send_Command vdvModbus, "'ADDCOMMAND = ', Format('%02X', DeviceAddress), Format('%02X', $10), Format('%04X', RegisterAddress), Format('%04X', 1 /* QuantityOfRegisters */), Format('%02X', 2 /* QuantityOfRegisters * 2 */), Format('%04X', Value)";
}





Define_Call 'ModBus - Process Answer' (Char Function, Char Device, Integer Address, Integer Value)
{
	// TODO : Process answers there

	Select
	{
		// ��������� ������ �� ���������� � ������� $10 �� ������ ������� 4 � ����������� ������� $1400
		Active (Function == 4 && Device == $10 && Address == $1400) : { }
	}
}





(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT


DATA_EVENT [vdvModbus]
{
	COMMAND:
	{
		/* If you need to analize sent packet
		local_var volatile Char    SentPacket[256], SentPacketHex[512];
		local_var volatile Integer iPos;

		iPos = Find_String(Data.Text, '; ON_COMMAND = ', 1);
		If (iPos)
		{
			SentPacketHex = Right_String(Data.Text, Length_String(Data.Text) - iPos + 1 - Length_String('; ON_COMMAND = '));
			SentPacket    = GetDataFromHex(SentPacketHex);

			Data.Text     = Left_String(Data.Text, iPos - 1);
		}
		Else
		{
			Clear_Buffer SentPacketHex;
			Clear_Buffer SentPacket;
		}
		*/
		local_var volatile Integer iPos;

		iPos = Find_String(Data.Text, '; ON_COMMAND = ', 1);
		If (iPos)
			Set_Length_String(Data.Text, iPos - 1);


		Select
		{
			Active (RemoveCmdLeft(Data.Text, 'VALUE = ')):
			{
				// REGISTER VALUE RECEIVED FROM DEVICE
				
				// Received data from Device
				// VALUE = 04 01 000A 000F
				// Where:
				//   04   - Function
				//   01   - Device address
				//   000A - Register address
				//   000F - Register value
				
				Call 'ModBus - Process Answer' (hextoi(Mid_String(Data.Text, 1, 2)), hextoi(Mid_String(Data.Text, 4, 2)), hextoi(Mid_String(Data.Text, 7, 4)), hextoi(Mid_String(Data.Text, 12, 4)));
			}


			Active (RemoveCmdLeft(Data.Text, 'ANSWER = ')):
			{
				// FULL RESPONSE THAT RECEIVED ON THE REQUEST
				
				/*
				local_var volatile Char Answer[256], AnswerHex[512];

				AnswerHex = Data.Text;
				Answer    = GetDataFromHex(AnswerHex);

				// TODO : Process answer from AnswerHex or Answer. Example: AnswerHex = '1004020001'
				// TODO : or wait For same 'VALUE = ' messages
				*/
			}


			Active (RemoveCmdLeft(Data.Text, 'WRONG_ANSWER = ')):
			{
				// FULL RESPONSE THAT RECEIVED FROM OTHER DEVICE OR FROM OTHER FUNCTION
				
				/*
				local_var volatile Char Answer[256], AnswerHex[512];

				AnswerHex = Data.Text;
				Answer    = GetDataFromHex(AnswerHex);

				// TODO : Process answer from AnswerHex or Answer. Example: AnswerHex = '1004020001'
				// TODO : or wait For same 'VALUE = ' messages
				*/
			}


			Active (RemoveCmdFull(Data.Text, 'ANSWER_TIMEOUT')):
			{
				// TODO : Didn't receive answer On command/request
			}


			Active (RemoveCmdLeft(Data.Text, 'REQUEST_ERROR = ')):
			{
				// TODO : See error code in Data.Text
			}


			Active (RemoveCmdLeft(Data.Text, 'CRC_ERROR = ')):
			{
				// TODO : Wrong answer packet in Hex is in Data.Text
			}
		}
	}


	ONLINE:
	{
		// *************************************************************************************
		// �������� �� ���������� ��� ������, ����� ������� ����� ��������������� ������ 5 �����
		// *************************************************************************************
		Send_Command Data.Device, 'SERIAL = 0000';


		(***********************************************************)
		(* To setup of com-port configuration use this command     *)
		(* that have to be sent to virtual device                  *)
		(* 'SET BAUD 9600,N,8,1 485 DISABLE' (always use           *)
		(* Note: "485 DISABLE" and 'RS485_2WIRE = ON' for 2-wire   *)
		(*       connection                                        *)
		(***********************************************************)
		// ��� ���������������� �������� COM-�����
		// ��� �������������� ����������� ��� ������ AMX Com-������ ����������� ���������� ������������ ������� "485 DISABLE" � ������� 'RS485_2WIRE = ON' ��� 
		// ���������� "���" ������������ ������� (������� ����)
		// ���� ���������� �������� ������������ �����, �� ��� ���������� ������� ����� ���������� ���������������� ������ � vdvModBus.
		// ��������: Send_Command dvModbus, 'SET BAUD 38400,N,7,2 485 DISABLE';
		Send_Command Data.Device, 'SET BAUD 9600,N,8,1 485 ENABLE';


		(***********************************************************)
		(* This module works with RTU type of ModBus protocol      *)
		(***********************************************************)
		(* To correctly work with 2-wire RS485 interface send a    *)
		(* next command to vdvModBus:                              *)
		(* 'RS485_2WIRE = ON' (by default 'RS485_2WIRE = OFF')     *)
		(***********************************************************)
		// ������ ������� ���������� ��� ���������� ��������� "���" �������, �.�. � ��� �������, ����� � Com-���� ����������� ������������ �������.
		// ���� ���������� ������ ����� ������ IC-Com2, �� ��� ��������� ����� �����������.
		// ����������� ������������ Com-�����:
		// Send_Command Data.Device, 'SET BAUD 9600,N,8,1 485 DISABLE';
		// "485 DISABLE" - ��� ���������, ��� ������ AMX Com-������ ���� ������ �������� � ��������������� ������ (RS422) � ��� ���������� ���������
		// "���" ������������ ������� � ������������ ������ �������.
		Send_Command Data.Device, 'RS485_2WIRE = ON'; // ��� ������ �� ������������� RS485 ����


		// *****************************************************************************************************************************************
		// ������� ��������� �������� ������ �� ���������� (� �������������!!!)
		// *****************************************************************************************************************************************
		// �������� ����� ���� �� 100 � �����. ��� �������� ����� 100�� ��� ������������� ���������� �� 100��.
		// �������� �� ���������: 1000��
		Send_Command Data.Device, 'ANSWER_TIMEOUT = 3000';


		// ������� ����������, �� ������� ����� ������������� ��� ���������, ���������� ������� � ���� �����������.
		// �� ��������� ������������ ���������
		// ��� ���������� ������������ ������� ����� ��������� 0:1:0 : Send_Command Data.Device, 'VDVDEBUG = 0:1:0';
		Send_Command Data.Device, "'VDVDEBUG = ', itoa(vdvDebug.Number), ':', itoa(vdvDebug.Port), ':', itoa(vdvDebug.System)"; // �������� ������������ ��������������� ��������� �� ����� vdvDebug

		// ���������/���������� ������ ����������� ����������� ���������� ����������.
		// Send_Command Data.Device, "'DEBUG = OFF'"; // ��������� ����� ����������� ����������� ���������� ����������
		Send_Command Data.Device, "'DEBUG = ON'"; // �������� ����� ����������� ����������� ���������� ����������

		// ������� ������, � ������� ����� ���������� ��� ��������� � ���� ����������� �� ������� ������
		// �������� �� ���������: Modbus
		// ��������, 'Modbus[1]: Connecton ON'
		// Send_Command Data.Device, 'DEBUGSTRING = Modbus[1]'; // �������� ������ �� "Modbus[1]"


		// *****************************************************************************************************************************************
		// ������ ���������� � ������ ������
		// *****************************************************************************************************************************************
		// ��������� ���������� � ������ ������ ModBus.
		// �������������� ������� � ������ 2.0
		// ������ ��������� � ���� �����������:
		//   ModBus: Module Version - 2.0
		// Send_Command Data.Device, 'VERSION?';
	}
}





(***********************************************************)
(*                                                         *)
(*                MODULES GO HERE                          *)
(*                                                         *)
(***********************************************************)


DEFINE_MODULE 'module Modbus Master' mdl_Modbus (dvModbus, vdvModbus);



(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


Wait 100 'Modbus Requests'
{
	// Read values

	// ��������� �������� 4 � ���������� � ������� $10 ����������� �������� ������� � ������ $1400 � ��������� 20 ���� ������
	// �.�. ������� ������ �� ��������� $1400, $1401, ..., $1412 (����� 20 ��������, ������� ���� ����� ���������� � ������� 'ModBus - Process Answer'
	Call 'ModBus - Call Function' (3, 1, 40004, 1);
	//Wait 25 Call 'ModBus - Call Function' (3, 1, 40004, 1); 
	//Wait 15 Call 'ModBus - Call Function' (3, 1 , 40004, 1);
	//Wait 40 Call 'ModBus - Call Function' (3, 1, 40014, 1);
	//Wait 60 Call 'ModBus - Call Function' (3, 1, 40016, 1);
	//Wait 30 Call 'ModBus - Call Function' (3, 1, 40018, 1);
	//Wait 35 Call 'ModBus - Call Function' (3, 1, 40033, 1);
             

}





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
