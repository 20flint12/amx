PROGRAM_NAME='Modbus'
(***********************************************************)
(* System Type : Netlinx                                   *)
(***********************************************************)


#include 'Misc.axi'


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


dvModbus  = 5001:2:0;

vdvModbus = 33001:1:0;

vdvDebug  = 32999:1:0;

panel = 11001:1:1;



DEFINE_CONSTANT



DEFINE_VARIABLE

VOLATILE INTEGER VAR_1
VOLATILE INTEGER VAR_2
VOLATILE INTEGER VAR_3
VOLATILE INTEGER VAR_4
VOLATILE INTEGER VAR_5
VOLATILE INTEGER VAR_6
VOLATILE INTEGER VAR_7
VOLATILE INTEGER VAR_8
VOLATILE INTEGER VAR_9
                   
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
		// Обработка ответа от устройства с адресом $10 на запрос функции 4 с регистровым адресом $1400
		Active (Function == 3 && Address == 40004) : { VAR_1 = Value }
		Active (Function == 3 && Address == 40008) : { VAR_2 = Value }
		Active (Function == 3 && Address == 40012) : { VAR_3 = Value }
		Active (Function == 3 && Address == 40013) : { VAR_4 = Value }
		Active (Function == 3 && Address == 40014) : { VAR_5 = Value }
		Active (Function == 3 && Address == 40015) : { VAR_6 = Value }
		Active (Function == 3 && Address == 40016) : { VAR_7 = Value }
		Active (Function == 3 && Address == 40033) : { VAR_8 = Value }
		Active (Function == 3 && Address == 43005) : { VAR_9 = Value }
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
		Send_Command Data.Device, 'SERIAL = 0000';


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
		// Если необходимо изменить конфигурацию порта, то это необходимо сделать через отравление конфигурационной строки в vdvModBus.
		// Например: Send_Command dvModbus, 'SET BAUD 38400,N,7,2 485 DISABLE';
		Send_Command Data.Device, 'SET BAUD 9600,N,8,1 485 ENABLE';


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
		Send_Command Data.Device, 'RS485_2WIRE = OFF'; // Для работы по двухпроводной RS485 шине


		// *****************************************************************************************************************************************
		// Задание интервала ожидания ответа от устройства (в миллисекундах!!!)
		// *****************************************************************************************************************************************
		// Значение может быть от 100 и более. При значении менее 100мс оно автоматически заменяется на 100мс.
		// Значение по умолчанию: 1000мс
		Send_Command Data.Device, 'ANSWER_TIMEOUT = 6000';


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


		// *****************************************************************************************************************************************
		// Запрос информации о версии модуля
		// *****************************************************************************************************************************************
		// Выводится информация о версии модуля ModBus.
		// Поддерживается начиная с версии 2.0
		// Пример сообщений в окне Диагностики:
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

	// Прочитать функцией 4 у устройства с адресом $10 регистровые значения начиная с адреса $1400 в количесте 20 штук подряд
	// Т.е. прийдют ответы от регистров $1400, $1401, ..., $1412 (итого 20 значений, которые надо будет обработать в функции 'ModBus - Process Answer'
	Call 'ModBus - Call Function' (3, 1, 40004, 1); //Outdoortemperature
	wait 10 Call 'ModBus - Call Function' (3, 1, 40008, 1); //Flowtemperature
	send_string 0, "'Flowtemperature'";
	wait 15 Call 'ModBus - Call Function' (3, 1, 40012, 1); //Returntemperature
	send_string 0, "'Returntemperature'";
	wait 20 Call 'ModBus - Call Function' (3, 1, 40013, 1); //Hotwater,top
	send_string 0, "'Hotwater,top'";
	wait 25 Call 'ModBus - Call Function' (3, 1, 40014, 1); //Hotwatermiddle
	send_string 0, "'Hotwatermiddle'";	
	wait 30 Call 'ModBus - Call Function' (3, 1, 40015, 1); //Brinein
	send_string 0, "'Brinein'";
	wait 35 Call 'ModBus - Call Function' (3, 1, 40016, 1); //Brineout
	send_string 0, "'Brineout'";
	wait 40 Call 'ModBus - Call Function' (3, 1, 40033, 1); //Roomtemperature
	send_string 0, "'Roomtemperature'";
	wait 45 Call 'ModBus - Call Function' (3, 1, 43005, 1); //Degreeminutes
	send_string 0, "'Degreeminutes'";
	
	//Wait 25 Call 'ModBus - Call Function' (3, 1, 40004, 1);
	//Wait 15 Call 'ModBus - Call Function' (3, 1 , 40004, 1);
	//Wait 40 Call 'ModBus - Call Function' (3, 1, 40014, 1);
	//Wait 60 Call 'ModBus - Call Function' (3, 1, 40016, 1);
	//Wait 30 Call 'ModBus - Call Function' (3, 1, 40018, 1);
	//Wait 35 Call 'ModBus - Call Function' (3, 1, 40033, 1);     

}

SEND_COMMAND Panel,"'^TXT-1,0,',ITOA(var_1)"
SEND_COMMAND Panel,"'^TXT-2,0,',ITOA(var_2)"
SEND_COMMAND Panel,"'^TXT-3,0,',ITOA(var_3)"
SEND_COMMAND Panel,"'^TXT-4,0,',ITOA(var_4)"
SEND_COMMAND Panel,"'^TXT-5,0,',ITOA(var_5)"
SEND_COMMAND Panel,"'^TXT-6,0,',ITOA(var_6)"
SEND_COMMAND Panel,"'^TXT-7,0,',ITOA(var_7)"
SEND_COMMAND Panel,"'^TXT-8,0,',ITOA(var_8)"
SEND_COMMAND Panel,"'^TXT-9,0,',ITOA(var_9)"

//SEND_STRING 11001:1:1, "ITOA(var_1)";


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
