PROGRAM_NAME='Modbus'
(***********************************************************)
(* System Type : Netlinx                                   *)
(***********************************************************)


#include 'Misc.axi'


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

Lutron 	  = 5001:1:0;
dvModbus  = 5001:2:0;
vdvModbus = 33001:1:0;
vdvDebug  = 32999:1:0;
IPAD      = 11001:1:1;

vdv_LUTRON = 33001:1:1


DEFINE_CONSTANT



DEFINE_VARIABLE
           
VOLATILE FLOAT VAR_1
VOLATILE FLOAT VAR_2
VOLATILE FLOAT VAR_3
VOLATILE FLOAT VAR_4
VOLATILE FLOAT VAR_5
VOLATILE FLOAT VAR_6
VOLATILE FLOAT VAR_7
VOLATILE FLOAT VAR_8
VOLATILE FLOAT VAR_9
VOLATILE FLOAT VAR_10

VOLATILE FLOAT VAR_1_ex
VOLATILE FLOAT VAR_2_ex
VOLATILE FLOAT VAR_3_ex
VOLATILE FLOAT VAR_4_ex
VOLATILE FLOAT VAR_5_ex
VOLATILE FLOAT VAR_6_ex
VOLATILE FLOAT VAR_7_ex
VOLATILE FLOAT VAR_8_ex
VOLATILE FLOAT VAR_9_ex

VOLATILE FLOAT VAR_EX[100]
VOLATILE INTEGER i=2

PERSISTENT CHAR Lutron_buffer[1000]
PERSISTENT CHAR Lutron_device_buffer[1000]


                   
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
		Active (Function == 3 && Address == 40004) : { VAR_1 = Value}
		Active (Function == 3 && Address == 40008) : { VAR_2 = Value }
		Active (Function == 3 && Address == 40012) : { VAR_3 = Value }
		Active (Function == 3 && Address == 40013) : { VAR_4 = Value }
		Active (Function == 3 && Address == 40014) : { VAR_5 = Value }
		Active (Function == 3 && Address == 44035) : { VAR_6 = Value }
		Active (Function == 3 && Address == 40016) : { VAR_7 = Value }
		Active (Function == 3 && Address == 40033) : { VAR_8 = Value }
		Active (Function == 3 && Address == 43005) : { VAR_9 = Value }
		Active (Function == 3 && Address == 45001) : { VAR_10 = Value }
	}                                                                        
}



(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT [vdv_LUTRON, 100] //�������
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 17',$0D";
	    SEND_STRING 0, "'KBP, [1:6:1], 17',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 101] //�������
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 9',$0D";
	    SEND_STRING 0, "'KBP, [1:6:1], 09',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 102] //�������
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:06:1], 10',$0D";
	    SEND_STRING 0, "'KBP, [1:06:1], 10',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 103] //���� ���
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 1',$0D";
	    SEND_STRING 0, "'KBP, [1:6:1], 1',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 104] //������� 1
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 18',$0D";
	    SEND_STRING 0, "'KBP, [1:6:1], 18',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 105] //������� 2
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 19',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 19',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 106] //������� 3
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 20',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 20',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 107] //������� 4
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 21',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 21',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 108] //���������
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 2',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 2',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 109] //��� 1
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 11',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 11',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 110] //��� 2
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 12',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 12',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 111] //��� 3
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 13',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 13',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 112] //������
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 22',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 22',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 113] //����� 1
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 14',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 14',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 114] //����� 2
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 6',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 6',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 116] //����� 2 �������
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 7',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 7',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 117] //����� 1 �������
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 15',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 15',$0D"
	}
}

BUTTON_EVENT [vdv_LUTRON, 118] //������ �������
{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 23',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 23',$0D"
	}
}
BUTTON_EVENT [vdv_LUTRON, 119] //�����

{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 4',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 04',$0D"
	}
}

/*DATA_EVENT [Lutron_buffer]
{
    STRING:
	{
	    SELECT
		{
		 ACTIVE (FIND_STRING (Lutron_buffer,'[01:06:01], 100',1)):
		    {
			[IPAD,103] = 1;
			send_string 0, 'ON'
		    }
		 ACTIVE (FIND_STRING (Lutron_buffer,'[01:06:01], 000',1)):
		    {
			[IPAD,103] = 0;
			send_string 0, 'OFF'
		    }
		}
	}

}*/
BUTTON_EVENT [vdv_LUTRON, 120] //�����

{
    PUSH:
	{
	    SEND_STRING Lutron, "'KBP, [1:6:1], 3',$0D";
	    SEND_STRING 0, "'KBP, [01:06:01], 03',$0D"
	}
}

DATA_EVENT[Lutron]
{ONLINE:{

SEND_COMMAND Lutron,'SET BAUD 9600,N,8,1'
SEND_STRING  Lutron,"'KLMON',$0D" 
WAIT 20 
{SEND_STRING  Lutron,"'RKLS,[01:06:01]',13"}

}}
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
			    wait 1 SEND_COMMAND IPAD,"'^TXT-10,0,ERROR CONNECT MODBUS'"
			}// TODO : Didn't receive answer On command/request


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
		Send_Command Data.Device, 'RS485_2WIRE = OFF'; // ��� ������ �� ������������� RS485 ����


		// *****************************************************************************************************************************************
		// ������� ��������� �������� ������ �� ���������� (� �������������!!!)
		// *****************************************************************************************************************************************
		// �������� ����� ���� �� 100 � �����. ��� �������� ����� 100�� ��� ������������� ���������� �� 100��.
		// �������� �� ���������: 1000��
		Send_Command Data.Device, 'ANSWER_TIMEOUT = 6000';


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


DEFINE_MODULE 'module Modbus Master' mdl_Modbus (dvModbus, vdvModbus);
DEFINE_START

COMBINE_CHANNELS (vdv_LUTRON, 100, ipad, 100)
COMBINE_CHANNELS (vdv_LUTRON, 101, ipad, 101)
COMBINE_CHANNELS (vdv_LUTRON, 102, ipad, 102)
COMBINE_CHANNELS (vdv_LUTRON, 103, ipad, 103)
COMBINE_CHANNELS (vdv_LUTRON, 104, ipad, 104)
COMBINE_CHANNELS (vdv_LUTRON, 105, ipad, 105)
COMBINE_CHANNELS (vdv_LUTRON, 106, ipad, 106)
COMBINE_CHANNELS (vdv_LUTRON, 107, ipad, 107)
COMBINE_CHANNELS (vdv_LUTRON, 108, ipad, 108)
COMBINE_CHANNELS (vdv_LUTRON, 109, ipad, 109)
COMBINE_CHANNELS (vdv_LUTRON, 110, ipad, 110)
COMBINE_CHANNELS (vdv_LUTRON, 111, ipad, 111)
COMBINE_CHANNELS (vdv_LUTRON, 112, ipad, 112)
COMBINE_CHANNELS (vdv_LUTRON, 113, ipad, 113)
COMBINE_CHANNELS (vdv_LUTRON, 114, ipad, 114)
COMBINE_CHANNELS (vdv_LUTRON, 115, ipad, 115)
COMBINE_CHANNELS (vdv_LUTRON, 116, ipad, 116)
COMBINE_CHANNELS (vdv_LUTRON, 117, ipad, 117)
COMBINE_CHANNELS (vdv_LUTRON, 118, ipad, 118)
COMBINE_CHANNELS (vdv_LUTRON, 119, ipad, 119)
COMBINE_CHANNELS (vdv_LUTRON, 120, ipad, 120)
COMBINE_CHANNELS (vdv_LUTRON, 121, ipad, 121)
COMBINE_CHANNELS (vdv_LUTRON, 122, ipad, 122)
COMBINE_CHANNELS (vdv_LUTRON, 123, ipad, 123)  
COMBINE_CHANNELS (vdv_LUTRON, 124, ipad, 124)  

CREATE_BUFFER Lutron, Lutron_buffer;

DEFINE_PROGRAM

wait 10
{
if (var_1>3000)
{
VAR_EX[1]=(65535-VAR_1)/10;
VAR_1_EX=(65535-VAR_1)/10;
}
else
{
VAR_EX[1] = VAR_1/10;
}
VAR_EX[2] = VAR_2/10;
VAR_EX[3] = VAR_3/10;
VAR_EX[4] = VAR_4/10;
VAR_EX[5] = VAR_5/10;
VAR_EX[6] = VAR_6/10;
VAR_EX[7] = VAR_7/10;
VAR_EX[8] = VAR_8/10;
VAR_EX[9] = VAR_9/10;

VAR_2_ex = VAR_2/10;
VAR_3_ex = VAR_3/10;
VAR_4_ex = VAR_4/10;
VAR_5_ex = VAR_5/10;
VAR_6_ex = VAR_6/10;
VAR_7_ex = VAR_7/10;
VAR_8_ex = VAR_8/10;
VAR_9_ex = VAR_9/10;
}

Wait 5
{
IF (FIND_STRING (Lutron_buffer, "$0D",1)) 
    {
        REMOVE_STRING (Lutron_buffer,"$0D",1);
	REMOVE_STRING (Lutron_buffer,'KLS, [01:06:01], ',1);
	SEND_STRING 0, Lutron_buffer;
	//SEND_STRING 0, Lutron_device_buffer;
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 1, 1),'1'))
	{
	    [vdv_LUTRON,103] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 1, 1),'0'))   
	{
	    [vdv_LUTRON,103] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 2, 1),'1'))
	{
	    [vdv_LUTRON,108] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 2, 1),'0'))   
	{
	    [vdv_LUTRON,108] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 3, 1),'1'))
	{
	    [vdv_LUTRON,120] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 3, 1),'0'))   
	{
	    [vdv_LUTRON,120] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 4, 1),'1'))
	{
	    [vdv_LUTRON,119] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 4, 1),'0'))   
	{
	    [vdv_LUTRON,119] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 6, 1),'1'))
	{
	    [vdv_LUTRON,114] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 6, 1),'0'))   
	{
	    [vdv_LUTRON,114] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 9, 1),'1'))
	{
	    [vdv_LUTRON,101] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 9, 1),'0'))   
	{
	    [vdv_LUTRON,101] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 10, 1),'1'))
	{
	    [vdv_LUTRON,102] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 10, 1),'0'))   
	{
	    [vdv_LUTRON,102] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 11, 1),'1'))
	{
	    [vdv_LUTRON,109] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 11, 1),'0'))   
	{
	    [vdv_LUTRON,109] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 12, 1),'1'))
	{
	    [vdv_LUTRON,110] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 12, 1),'0'))   
	{
	    [vdv_LUTRON,110] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 13, 1),'1'))
	{
	    [vdv_LUTRON,111] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 13, 1),'0'))   
	{
	    [vdv_LUTRON,111] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 14, 1),'1'))
	{
	    [vdv_LUTRON,113] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 14, 1),'0'))   
	{
	    [vdv_LUTRON,113] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 17, 1),'1'))
	{
	    [vdv_LUTRON,100] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 17, 1),'0'))   
	{
	    [vdv_LUTRON,100] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 18, 1),'1'))
	{
	    [vdv_LUTRON,104] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 18, 1),'0'))   
	{
	    [vdv_LUTRON,104] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 19, 1),'1'))
	{
	    [vdv_LUTRON,105] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 19, 1),'0'))   
	{
	    [vdv_LUTRON,105] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 20, 1),'1'))
	{
	    [vdv_LUTRON,106] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 20, 1),'0'))   
	{
	    [vdv_LUTRON,106] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 21, 1),'1'))
	{
	    [vdv_LUTRON,107] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 21, 1),'0'))   
	{
	    [vdv_LUTRON,107] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 22, 1),'1'))
	{
	    [vdv_LUTRON,112] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 22, 1),'0'))   
	{
	    [vdv_LUTRON,112] = 0;
	}
    }    
    CLEAR_BUFFER Lutron_buffer;
}


Wait 100 'Modbus Requests'
{
	// Read values
	// ��������� �������� 4 � ���������� � ������� $10 ����������� �������� ������� � ������ $1400 � ��������� 20 ���� ������
	// �.�. ������� ������ �� ��������� $1400, $1401, ..., $1412 (����� 20 ��������, ������� ���� ����� ���������� � ������� 'ModBus - Process Answer'
	wait 10 Call 'ModBus - Call Function'  (3, 1, 40004, 1); //Outdoortemperature
	wait 20 Call 'ModBus - Call Function'  (3, 1, 40008, 1); //Flowtemperature
	wait 30 Call 'ModBus - Call Function'  (3, 1, 40012, 1); //Returntemperature
	wait 40 Call 'ModBus - Call Function'  (3, 1, 40013, 1); //Hotwater,top
	wait 50 Call 'ModBus - Call Function'  (3, 1, 40014, 1); //Hotwatermiddle
	wait 60 Call 'ModBus - Call Function'  (3, 1, 40015, 1); //Brinein
	wait 70 Call 'ModBus - Call Function'  (3, 1, 40016, 1); //Brineout
	wait 80 Call 'ModBus - Call Function'  (3, 1, 40033, 1); //Roomtemperature
	wait 90 Call 'ModBus - Call Function'  (3, 1, 43005, 1); //Degreeminutes
	wait 100 Call 'ModBus - Call Function'  (3, 1, 45001, 1); //Code of error
	
}
wait 50
{ 
    if(VAR_EX[i]<3000)
    {
	SEND_COMMAND IPAD,"'^TXT-',itoa(i),',0,',FORMAT('%5.1f', VAR_EX[i]),' �'"
	SEND_STRING 0,"'^TXT-',itoa(i),',0,',FORMAT('%5.1f', VAR_EX[i]),' �'"
    }
    
    else
    {
	SEND_COMMAND IPAD,"'^TXT-',itoa(i),',0,UNUSED!'"
	SEND_STRING 0,"'^TXT-',itoa(i),',0,UNUSED!'"
    }
    
    i=i+1;
    if (i=10){i=2}
    
    if(VAR_EX[1]<3000)
    {
	SEND_COMMAND IPAD,"'^TXT-1,0,',FORMAT('%5.1f', VAR_EX[1]),' �'"
	SEND_STRING 0,"'^TXT-1,0,',FORMAT('%5.1f', VAR_EX[1]),' �'"
    }
    
    else
    {
    SEND_COMMAND IPAD,"'^TXT-1,0,-',FORMAT('%5.1f', VAR_1_EX),' �'"
    SEND_STRING 0,"'^TXT-1,0,-',FORMAT('%5.1f', VAR_1_EX),' �'"
    /*
	���������� ������������� ����������
    */
    }

/*
    if (VAR_1_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-1,0,',FORMAT('%5.1f', VAR_1_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-1,0,UNUSED!'"
	}
    
    if (VAR_2_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-2,0,',FORMAT('%5.1f', VAR_2_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-2,0,UNUSED!'"
	}
    
    if (VAR_3_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-3,0,',FORMAT('%5.1f', VAR_3_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-3,0,UNUSED!'"
	}
    
    if (VAR_4_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-4,0,',FORMAT('%5.1f', VAR_4_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-4,0,UNUSED!'"
	}
	
    if (VAR_5_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-5,0,',FORMAT('%5.1f', VAR_5_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-5,0,UNUSED!'"
	}
	
    if (VAR_6_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-6,0,',FORMAT('%5.1f', VAR_6_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-6,0,UNUSED!'"
	}
	
    if (VAR_7_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-7,0,',FORMAT('%5.1f', VAR_7_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-7,0,UNUSED!'"
	}
	
    if (VAR_8_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-8,0,',FORMAT('%5.1f', VAR_8_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-8,0,UNUSED!'"
	}
	
    if (VAR_9_ex<3000)
	{
	    SEND_COMMAND IPAD,"'^TXT-9,0,',FORMAT('%5.1f', VAR_9_ex),' �'"
	}
    else
	{
	    wait 100 SEND_COMMAND IPAD,"'^TXT-9,0,UNUSED!'"
	}*/
}


    if (var_10=0)
    {
	wait 100 SEND_COMMAND IPAD,"'^TXT-11,0,',FTOA(var_10)"
	wait 100 SEND_COMMAND IPAD,"'^TXT-10,0, '"
    }
    else
    {
	wait 100 SEND_COMMAND IPAD,"'^TXT-11,0, Error Code: ',FTOA(var_10)"
	wait 100 SEND_COMMAND IPAD,"'^TXT-10,0,The boiler has reported an error please check your equip. Code:',FTOA(var_10)"
    }





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
