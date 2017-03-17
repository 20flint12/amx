MODULE_NAME='Daikin_ModBus_COMM_1'
(DEV vdvModbus, DEV DEVICE, DEV MVP[], INTEGER KEYPAD[])

#include 'Miscc.axi'



DEFINE_DEVICE

vdvDebug  = 33406:1:0;

DEFINE_VARIABLE

VOLATILE INTEGER STATUS_ALARM, STATUS_ALARM_
VOLATILE INTEGER STATUS_
VOLATILE INTEGER STATUS_POWER 
VOLATILE INTEGER STATUS_SKOROST_CURRENT
VOLATILE INTEGER STATUS_TEMP_1
VOLATILE INTEGER STATUS_TEMP_2
VOLATILE INTEGER STATUS_TEMP_3
VOLATILE INTEGER STATUS_TEMP_4
VOLATILE INTEGER ALARM [14]

VOLATILE CHAR  STRING_NOT_ANSWER[100]
VOLATILE CHAR  SEND_NOT_ANSWER[100]
volatile integer Close_SEND_COMMAND



VOLATILE INTEGER I, A, D
VOLATILE char I_FANKOIL

DEFINE_CONSTANT


(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)

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
       Send_Command vdvModbus, "'ADDPRIORITYCOMMAND = ', Format('%02X', DeviceAddress), Format('%02X', $10), Format('%04X', RegisterAddress), Format('%04X', 1 /* QuantityOfRegisters */), Format('%02X', 2 /* QuantityOfRegisters * 2 */), Format('%04X', Value)";
}


Define_Call 'ModBus - Process Answer' (Char Function, Char Device, Integer Address, Integer Value)
{
    local_var volatile SINTEGER siValue;
    
    siValue = Type_Cast(Value);
    
	// TODO : Process answers there
       SEND_STRING 0 , "'SEND_VALUE',Device, Value"
	Select
	{
		// Обработка ответа от устройства с адресом $10 на запрос функции 4 с регистровым адресом $1400
		Active (Function == 4 && Address == 0009) : // Питание
		{STATUS_POWER  = Value & $0800 	STATUS_ = value	}
		
		Active (Function == 3 && Address == 0007) : // Скорость вентилятора
		{STATUS_SKOROST_CURRENT  = Value
		SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD[4]),',0,',ITOA (Value),' %'"}
		
		Active (Function == 3 && Address == 0003) : // ТЗаданная температура приточного воздуха 
		{
		STATUS_TEMP_1 = Value
		SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD[3]),',0,',TemperatureToStr(STATUS_TEMP_1), ' C'"}
		
		Active (Function == 4 && Address == 0002) : // Температура наружного воздуха 
		{
		STATUS_TEMP_2 = Value
		SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD[5]),',0,',TemperatureToStr(STATUS_TEMP_2), ' C'"}
		
		Active (Function == 4 && Address == 0003) : // Температура приточного воздуха 
		{
		STATUS_TEMP_3 = Value
		SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD[6]),',0,',TemperatureToStr(STATUS_TEMP_3), ' C'"}
		
		Active (Function == 4 && Address == 0004) : // Температура обратного теплоносителя
		{
		STATUS_TEMP_4 = Value
		SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD[7]),',0,',TemperatureToStr(STATUS_TEMP_4), ' C'"}
		
		Active (Function == 4 && Address == 0000) : // Авария 1
		{
		STATUS_ALARM = Value 
		ALARM[1]  = Value & $0000  // наличие аварии приточного вентилятор	
		ALARM[2]  = Value & $0001  //наличие аварии двигателя            	
		ALARM[3]  = Value & $0002  // наличие аварии засорения фильтра    	
		ALARM[4]  = Value & $0004 // наличие аварии ККБ                  	
		ALARM[5]  = Value & $0008  // наличие аварии Пуск вне графика     	
		ALARM[6]  = Value & $0010  // наличие аварии Угроза по воздуху    	
		ALARM[7]  = Value & $0020  // наличие аварии Угроза по воде       	
		ALARM[8]  = Value & $0040  // наличие аварии Недогрев             	
		ALARM[9]  = Value & $0080  // наличие аварии Макс. кол-во угроз   	
		ALARM[10] = Value & $0100  // наличие аварии Стоп при раб. по графику 	
		}                                                                                                                        
		
		Active (Function == 4 && Address == 0001) : // Авария 2
		{
		STATUS_ALARM_ = Value
		ALARM[11]  = Value & $0000  // наличие аварии Датчик Тпрв   
		ALARM[12]  = Value & $0001  // наличие аварии Датчик Тнв    
		ALARM[13]  = Value & $0002  // наличие аварии Датчик Тобр   
		ALARM[14]  = Value & $0004  // наличие аварии AirEl         
		}                                                                                                                               
		
		
		
	}
}



DEFINE_FUNCTION power_STATUS (Integer Value)
{

}

DEFINE_START




(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


BUTTON_EVENT [MVP, KEYPAD] // Блок № 1
{PUSH:{

LOCAL_VAR INTEGER NUM_BUTTON

NUM_BUTTON = GET_LAST (KEYPAD)

SWITCH (NUM_BUTTON)
    {
CASE 1:{ // ON
	Call 'Modbus - Write Multiple Registers - Single register' (111, 1, 1);
	WAIT 2 {Call 'ModBus - Call Function' (4, 111, 9, 1)}
}

CASE 2:{ // Off
	Call 'Modbus - Write Multiple Registers - Single register' (111, 1, 2);
	WAIT 2 {Call 'ModBus - Call Function' (4, 111, 9, 1)}
}


CASE 3:{ // ТЕМП +
IF (STATUS_TEMP_1 < 300)  
{ 
	STATUS_TEMP_1 = STATUS_TEMP_1 + 10
	Call 'Modbus - Write Multiple Registers - Single register' (111, 3, STATUS_TEMP_1)
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 3, 1)}
}
ELSE
{
	STATUS_TEMP_1 = 300
	Call 'Modbus - Write Multiple Registers - Single register' (111, 3, STATUS_TEMP_1)
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 3, 1)}
}
}


CASE 4:{ // ТЕМП -
IF (STATUS_TEMP_1 > 10)  
{ 
	STATUS_TEMP_1 = STATUS_TEMP_1 - 10
	Call 'Modbus - Write Multiple Registers - Single register' (111, 3, STATUS_TEMP_1)
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 3, 1)}
}
ELSE
{
	STATUS_TEMP_1 = 10
	Call 'Modbus - Write Multiple Registers - Single register' (111, 3, STATUS_TEMP_1)
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 3, 1)}
}
}

CASE 5:{ // СКОРОСТЬ +
IF (STATUS_SKOROST_CURRENT < 100)  
{ 
	STATUS_SKOROST_CURRENT = STATUS_SKOROST_CURRENT + 10
	Call 'Modbus - Write Multiple Registers - Single register' (111, 7, STATUS_SKOROST_CURRENT)
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 7, 1)}
}
else 
{ 
	STATUS_SKOROST_CURRENT = 100
	Call 'Modbus - Write Multiple Registers - Single register' (111, 7, STATUS_SKOROST_CURRENT)
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 7, 1)}
}
}


CASE 6:{ // СКОРОСТЬ -
IF (STATUS_SKOROST_CURRENT > 0)  
{ 
	STATUS_SKOROST_CURRENT = STATUS_SKOROST_CURRENT - 10
	Call 'Modbus - Write Multiple Registers - Single register' (111, 7, STATUS_SKOROST_CURRENT)
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 7, 1)}
}
else 
{ 
	STATUS_SKOROST_CURRENT = 0
	Call 'Modbus - Write Multiple Registers - Single register' (111, 7, STATUS_SKOROST_CURRENT)
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 7, 1)}
}
}

CASE 7:{ // Сброс Аварий
	SET_PULSE_TIME (10) PULSE[MVP, KEYPAD[7]]
	Call 'Modbus - Write Multiple Registers - Single register' (111, 1, $40);
	WAIT 2 {Call 'ModBus - Call Function' (3, 111, 0, 2)}
       }
    }
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
		STRING_NOT_ANSWER = Data.Text
		If (iPos)
			 {
			  Set_Length_String(Data.Text, iPos - 1);
			  REMOVE_STRING (STRING_NOT_ANSWER, '; ON_COMMAND = ', 1);
			 }
                
                      
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
				
				(*IF (STRING_NOT_ANSWER != SEND_NOT_ANSWER) 
				{
				Send_Command vdvModbus, "'ADDPRIORITYCOMMAND = ', STRING_NOT_ANSWER";
				SEND_STRING 0, "'ADDCOMMAND = ', STRING_NOT_ANSWER";
				SEND_NOT_ANSWER = STRING_NOT_ANSWER
				}*)
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
		Send_Command Data.Device, 'SERIAL = 4632'; // 

		
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
		//Send_Command Data.Device, 'SET BAUD 9600,N,8,1 485 DISABLE';


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
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

wait 2
{
[MVP, KEYPAD[1]] = ( STATUS_POWER = $0800)
[MVP, KEYPAD[2]] = ( STATUS_POWER = 0)

}

WAIT 10 {


[MVP,KEYPAD[8]]   = (ALARM[1] != 0)
[MVP,KEYPAD[9]]   = (ALARM[2] != 0)
[MVP,KEYPAD[10]]  = (ALARM[3] != 0)
[MVP,KEYPAD[11]]  = (ALARM[4] != 0)
[MVP,KEYPAD[12]]  = (ALARM[5] != 0)
[MVP,KEYPAD[13]]  = (ALARM[6] != 0)
[MVP,KEYPAD[14]]  = (ALARM[7] != 0)
[MVP,KEYPAD[15]]  = (ALARM[8] != 0)
[MVP,KEYPAD[16]]  = (ALARM[9] != 0)
[MVP,KEYPAD[17]]  = (ALARM[10]!= 0)
[MVP,KEYPAD[18]]  = (ALARM[11]!= 0)
[MVP,KEYPAD[19]]  = (ALARM[12]!= 0)
[MVP,KEYPAD[20]]  = (ALARM[13]!= 0)
[MVP,KEYPAD[21]]  = (ALARM[14]!= 0)
                          









[MVP, KEYPAD[22]] = (	ALARM[1] || ALARM[11] ||  
			ALARM[2] || ALARM[12] ||  
                        ALARM[3] || ALARM[13] ||  
                        ALARM[4] || ALARM[14] ||  
                        ALARM[5] || ALARM[6]  ||         
                        ALARM[7] || ALARM[8]  ||   
                        ALARM[9] || ALARM[10] )
	}



WAIT 50
    {
		Call 'ModBus - Call Function' (4, 111, 9, 1) // Обратка состояние вентиляции
	WAIT 5 {Call 'ModBus - Call Function' (3, 111, 3, 1) // температура приточного воздуха 
	WAIT 5 {Call 'ModBus - Call Function' (3, 111, 7, 1) // Скорость
	WAIT 5 {Call 'ModBus - Call Function' (4, 111, 0, 1) // Аварии 1
	WAIT 5 {Call 'ModBus - Call Function' (4, 111, 1, 1) // Аварии 2
	WAIT 5 {Call 'ModBus - Call Function' (4, 111, 2, 1) // Температура наружного воздуха
	WAIT 5 {Call 'ModBus - Call Function' (4, 111, 3, 1) // Температура приточного воздуха 
	WAIT 5 {Call 'ModBus - Call Function' (4, 111, 4, 1) // Температура обратного теплоносителя 
	}}}}}}}                                       
    }
 

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
