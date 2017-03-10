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

vdvModbus = 33101:1:0;

vdvDebug  = 32999:1:0;



DEFINE_CONSTANT



DEFINE_VARIABLE

VOLATILE INTEGER VALUE_PARAM[100]

(* ************************************* ModBus ************************************* *)

// ModBus
Define_Call 'ModBus - RS485 2-wire cable'     (Char bValue) { If (bValue) Send_Command vdvModbus, 'RS485_2WIRE = ON'; Else Send_Command vdvModbus, 'RS485_2WIRE = OFF'; }

Define_Call 'ModBus - Call Function'          (Char Function, Char Device, Integer Address, Integer QuantityOrValue) { If (Function == 5 && QuantityOrValue == 1) QuantityOrValue = $FF00;   Send_Command vdvModbus, "'ADDCOMMAND = ',         Format('%02X', Device), Format('%02X', Function), Format('%04X', Address), Format('%04X', QuantityOrValue)"; }
Define_Call 'ModBus - Call Function Priority' (Char Function, Char Device, Integer Address, Integer QuantityOrValue) { If (Function == 5 && QuantityOrValue == 1) QuantityOrValue = $FF00;   Send_Command vdvModbus, "'ADDPRIORITYCOMMAND = ', Format('%02X', Device), Format('%02X', Function), Format('%04X', Address), Format('%04X', QuantityOrValue)"; }

Define_Call 'Modbus - Write Multiple Coils' (Char Device, Integer Address, Integer QuantityOfCoils, Char Coils[])
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
		sData = "Format('$02X', Device), Format('$02X', $0F), Format('$04X', Address), Format('$04X', QuantityOfCoils), Format('$02X', bByteCount)";
		bData = $00; For (i = 1; i <= QuantityOfCoils; i++) { bData = bData | (Bits[(i - 1) % 8 + 1] * Coils[i]); If (i % 8 == 0) { sData = "sData, Format('$02X', bData)"; bData = $00; } }
		If (i % 8 != 1) { sData = "sData, Format('$02X', bData)"; }
		
		Send_Command vdvModbus, "'ADDCOMMAND = ', sData";
		SEND_STRING 0, "'ADDCOMMAND = ', sData";
	}
}

Define_Call 'Modbus - Write Multiple Registers' (Char Device, Integer Address, Integer QuantityOfRegisters, Integer Registers[])
{
	If (QuantityOfRegisters && QuantityOfRegisters <= $7B)
	{
		local_var volatile Char    sData[512];
		local_var volatile Integer i;
		
		sData = "Format('$02X', Device), Format('$02X', $10), Format('$04X', Address), Format('$04X', QuantityOfRegisters), Format('$02X', QuantityOfRegisters * 2)";
	
		For (i = 1; i <= QuantityOfRegisters; i++)
			sData = "sData, Format('$04X', Registers[i])";
		
		Send_Command vdvModbus, "'ADDCOMMAND = ', sData";
		SEND_STRING 0, "'ADDCOMMAND = ', sData";
	}
}





Define_Call 'ModBus - Process Answer' (Char Function, Char Device, Integer Address, Integer Value)
{
	// TODO : Process answers there
        SEND_STRING 0, "'F:', ITOA (Function), ' A:', ITOA (Address), 'V:', ITOA (Value) "
	Select
	{
		// Обработка ответа от устройства с адресом $10 на запрос функции 4 с регистровым адресом $1400
		Active (Function == 3 && Device == 1 && Address == 40004) : {  VALUE_PARAM[1]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40005) : {  VALUE_PARAM[2]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40006) : {  VALUE_PARAM[3]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40007) : {  VALUE_PARAM[4]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40008) : {  VALUE_PARAM[5]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40009) : {  VALUE_PARAM[6]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40010) : {  VALUE_PARAM[7]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40011) : {  VALUE_PARAM[8]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40012) : {  VALUE_PARAM[9]  = Value    }
		Active (Function == 3 && Device == 1 && Address == 40013) : {  VALUE_PARAM[10] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40014) : {  VALUE_PARAM[11] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40015) : {  VALUE_PARAM[12] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40016) : {  VALUE_PARAM[13] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40017) : {  VALUE_PARAM[14] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40018) : {  VALUE_PARAM[15] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40019) : {  VALUE_PARAM[16] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40020) : {  VALUE_PARAM[17] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40021) : {  VALUE_PARAM[18] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40022) : {  VALUE_PARAM[19] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40033) : {  VALUE_PARAM[20] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40034) : {  VALUE_PARAM[21] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40035) : {  VALUE_PARAM[22] = Value    }
		Active (Function == 3 && Device == 1 && Address == 40036) : {  VALUE_PARAM[23] = Value    }
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
		// Заменить на правильный код модуля, иначе система будет перезагружаться каждые 5 минут
		// *************************************************************************************
		Send_Command Data.Device, 'SERIAL = 4032';


		(***********************************************************)
		(* To setup of com-port configuration use this command     *)
		(* that have to be sent to virtual device                  *)
		(* 'SET BAUD 9600,N,8,1 485 DISABLE' (always use           *)
		(* Note: "485 DISABLE" and 'RS485_2WIRE = ON' for 2-wire   *)
		(*       connection                                        *)
		(***********************************************************)
		// Для конфигурирования скорости COM-порта
		// Для двухпроводного подключения для родных AMX Com-портов обязательно необходимо использовать команду "485 DISABLE" и команду 'RS485_2WIRE = ON' для 
		// подавления "эха" отправленной посылки (описана ниже)
		Send_Command Data.Device, 'SET BAUD 9600,N,8,1 485 ENABLE';

		Send_Command Data.Device, 'ANSWER_TIMEOUT = 2000';
		(***********************************************************)
		(* This module works with RTU type of ModBus protocol      *)
		(***********************************************************)
		(* To correctly work with 2-wire RS485 interface send a    *)
		(* next command to vdvModBus:                              *)
		(* 'RS485_2WIRE = ON' (by default 'RS485_2WIRE = OFF')     *)
		(***********************************************************)
		// Данная функция необходима для правильной обработки "эха" посылки, т.е. в тех случаях, когда в Com-порт возращается отправленная посылка.
		// Если происходит работа через модуль IC-Com2, то эхо удаляется самим устройством.
		// Стандартная конфигурация Com-порта:
		// Send_Command Data.Device, 'SET BAUD 9600,N,8,1 485 DISABLE';
		// "485 DISABLE" - это правильно, для родных AMX Com-портов порт всегда работает в полнодуплексном режиме (RS422) и для правильной обработки
		// "эха" отправленной посылки и используется данная команда.
		Send_Command Data.Device, 'RS485_2WIRE = ON'; // Для работы по двухпроводной RS485 шине


		// Если необходимо изменить конфигурацию порта, то это можно сделать через несколько секунд после появления в OnLine устройства dvModbus путем
		// прямой посылки в него прямой конфирационной строки.
		// Например: Send_Command dvModbus, 'SET BAUD 38400,N,7,2 485 DISABLE';


		// Задание устройства, на которое будут дублироваться все сообщения, посылаемые модулем в окно Диагностики.
		// По умолчанию дублирование отключено
		// Для отключения дублирования послать адрес устройтва 0:1:0 : Send_Command Data.Device, 'VDVDEBUG = 0:1:0';
		Send_Command Data.Device, "'VDVDEBUG = ', itoa(vdvDebug.Number), ':', itoa(vdvDebug.Port), ':', itoa(vdvDebug.System)"; // Включить дублирование диагностических сообщений на адрес vdvDebug

		// Включение/выключение режима отображания расширенной отладочной информации.
		// Send_Command Data.Device, "'DEBUG = OFF'"; // Выключить режим отображания расширенной отладочной информации
		Send_Command Data.Device, "'DEBUG = ON'"; // Включить режим отображания расширенной отладочной информации

		// Задание строки, с которой будут начинаться все сообщения в окне Диагностики от данного модуля
		// Значение по умолчанию: Modbus
		// Например, 'Modbus[1]: Connecton ON'
		// Send_Command Data.Device, 'DEBUGSTRING = Modbus[1]'; // Поменять начало на "Modbus[1]"
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

	// Прочитать функцией 4 у устройства с адресом $10 регистровые значения начиная с адреса $1400 в количесте 20 штук подряд
	// Т.е. прийдют ответы от регистров $1400, $1401, ..., $1412 (итого 20 значений, которые надо будет обработать в функции 'ModBus - Process Answer'
	Wait  5 Call 'ModBus - Call Function' (3, 1, 40004, 1);
	//Wait 25 Call 'ModBus - Call Function' (3, 1, 40004, 1); 
	//Wait 15 Call 'ModBus - Call Function' (3, 1 , 40004, 1);
	//Wait 40 Call 'ModBus - Call Function' (3, 1, 40014, 1);
	//Wait 60 Call 'ModBus - Call Function' (3, 1, 40016, 1);
	//Wait 30 Call 'ModBus - Call Function' (3, 1, 40018, 1);
	//Wait 35 Call 'ModBus - Call Function' (3, 1, 40033, 1);
             

}
(*

Wait 10 'Modbus Requests'
{
	// Read values
        IF ( i > 256) {i = 1} ELSE { i = i + 1}
	// Прочитать функцией 4 у устройства с адресом $10 регистровые значения начиная с адреса $1400 в количесте 20 штук подряд
	// Т.е. прийдют ответы от регистров $1400, $1401, ..., $1412 (итого 20 значений, которые надо будет обработать в функции 'ModBus - Process Answer'
	Call 'ModBus - Call Function' (3, i, 1, 1);
	WAIT 5 {Call 'ModBus - Call Function' (4, i, 1, 1)}
}


*)

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
