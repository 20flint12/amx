PROGRAM_NAME='NewModbusProject'
(***********************************************************)
(*  FILE REVISION: Rev 2                                   *)
(*  REVISION DATE: 03/22/2017  AT: 21:39:33                *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(*  FILE REVISION: Rev 1                                   *)
(*  REVISION DATE: 03/22/2017  AT: 21:37:31                *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(*  FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 03/18/2017  AT: 09:59:49                *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(***********************************************************)
(* System Type : Netlinx                                   *)
(***********************************************************)

#INCLUDE 'SubRoutines.axs'


/*
IP 193.178.251.2

44421 ftp
44422 22 порт
44423 telnet 
44480 web
41319 рабочий 
*/


#include 'Misc.axi'


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvModbus  = 5001:2:0;
vdvModbus = 33001:1:0;
//vdvDebug  = 32999:1:0;

dvPanel = 11001:1:1;
IPAD    = 11001:1:1;

Lutron 	   = 5001:1:0;
vdv_LUTRON = 33001:1:1




DEFINE_CONSTANT

(*------------ Short description ------------------------*)
CHAR PROGRAM_DESCRIPTION[] = 'Prepared for testing'

/*
Outdoor temperature (BT1) 40004
Flow temperature (BT2) 40008
Return temperature (BT3) 40012
Hot water, top (BT7) 40013
Hot water middle (BT6) 40014
Brine in (BT10) 40015
Brine out (BT11) 40016
Room temperature (BT50) 40033
Degree minutes 43005
*/

INTEGER REG_BT1  = 40004
INTEGER REG_BT2  = 40008
INTEGER REG_BT3  = 40012	// !!!
INTEGER REG_BT7  = 40013
INTEGER REG_BT6  = 40014
INTEGER REG_BT10 = 40015
INTEGER REG_BT11 = 40016
INTEGER REG_BT50 = 40033
//INTEGER REG_DEGREE = 43005
INTEGER REG_ALARM = 45001 //	Alarm number

INTEGER UP_INC   = 5
INTEGER DN_INC   = 5

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//BT1 Outdoor temp Outdoor temperature 40004 °C s16 10 R
INTEGER REG_OUTDOOR_TEMPERATURE  = 40004
//BT50 Room Temp S1 40033 °C s16 10 R
INTEGER REG_ROOM_TEMPERATURE  = 40033
//Room sensor setpoint S1 Sets the room temperature setpoint for the system 47398 °C s16 10 R/W
INTEGER REG_ROOM_TEMPERATURE_SETPOINT  = 47398
//Hot water mode 0=Economy 1=Normal 2=Luxury 47041 s8 1 R/W
INTEGER REG_HOT_WATER_MODE  = 47041
//HW Comfort hotwater temperature The desired hotwater temperature 48148 °C s8 10 R/W
INTEGER REG_COMFORT_HOTWATER_TEMPERATURE  = 48148



//Alarm lower room temp.
//Lowers the room temperature during red light alarms to notify the occupants of the
//building that something is the matter 0=Off 1=On 47388 u8 1 R/W
//Alarm lower HW temp.
//Lowers the hot water temperature during red light alarms to notify the occupants of
//the building that something is the matter 0=Off 1=On 47389 u8 1 R/W



// ############################################################################
DEFINE_VARIABLE

VOLATILE INTEGER VAR_BT1
VOLATILE INTEGER VAR_BT2
VOLATILE INTEGER VAR_BT3
VOLATILE INTEGER VAR_BT7
VOLATILE INTEGER VAR_BT6
VOLATILE INTEGER VAR_BT10
VOLATILE INTEGER VAR_BT11
VOLATILE INTEGER VAR_BT50
VOLATILE INTEGER VAR_ALARM
                  
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VOLATILE SINTEGER VAR_OUTDOOR_TEMPERATURE
VOLATILE INTEGER VAR_ROOM_TEMPERATURE
PERSISTENT INTEGER VAR_ROOM_TEMPERATURE_SETPOINT
PERSISTENT INTEGER VAR_HOT_WATER_MODE
PERSISTENT INTEGER VAR_COMFORT_HOTWATER_TEMPERATURE

PERSISTENT CHAR Lutron_buffer[1000]


// Touch Panel Buttons
VOLATILE INTEGER controlPanelButtons[] =
{
    139,	// btn_p1_defaul
    140,	// btn_p1_up
    141, 	// btn_p1_down
    142,	// btn_p2_defaul
    143, 	// btn_p2_up
    144,  	// btn_p2_down
    145, 	// btn_p3_1
    146, 	// btn_p3_2
    147 	// btn_p3_3
}		  
		   
		   
		   
(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
		   
(* ***************************** ModBus ************************************ *)

// ModBus
Define_Call 'ModBus - RS485 2-wire cable' (Char bValue) 
{ 
    If (bValue) 
	Send_Command vdvModbus, 'RS485_2WIRE = ON'; 
    Else 
	Send_Command vdvModbus, 'RS485_2WIRE = OFF'; 
}


Define_Call 'ModBus - Call Function' (Char Function, Char Device, Integer Address, 
				      Integer QuantityOrValue) 
{ 
    If (Function == 5 && QuantityOrValue == 1) QuantityOrValue = $FF00;   
    Send_Command vdvModbus, "'ADDCOMMAND = ', Format('%02X', Device), 
			    Format('%02X', Function), Format('%04X', Address), 
			    Format('%04X', QuantityOrValue)"; 
}


Define_Call 'ModBus - Call Function Priority' (Char Function, Char Device, Integer Address, 
					       Integer QuantityOrValue) 
{ 
    If (Function == 5 && QuantityOrValue == 1) QuantityOrValue = $FF00;   
    Send_Command vdvModbus, "'ADDPRIORITYCOMMAND = ', 
			    Format('%02X', Device), Format('%02X', Function), 
			    Format('%04X', Address), Format('%04X', QuantityOrValue)"; 
}


// ****************************************************************************
Define_Call 'Modbus - Write Multiple Coils' (Char DeviceAddress, 
					     Integer StartRegisterAddress, 
					     Integer QuantityOfCoils, Char Coils[])
{
    If (QuantityOfCoils && QuantityOfCoils <= $07B0) // <=1968
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
	If (i % 8 != 1) 
	{ 
	    sData = "sData, Format('%02X', bData)"; 
	}	   
	Send_Command vdvModbus, "'ADDCOMMAND = ', sData";
    }
}


Define_Call 'Modbus - Write Multiple Coils - Single coil' (Char DeviceAddress, Integer RegisterAddress, Char Coil)
{
    Send_Command vdvModbus, "'ADDCOMMAND = ', Format('%02X', DeviceAddress), 
			    Format('%02X', $0F), Format('%04X', RegisterAddress), 
			    Format('%04X', 1 /* QuantityOfCoils */), 
			    Format('%02X', 1 /* bByteCount */), 
			    Format('%02X', (Coil > 0))";
}


Define_Call 'Modbus - Write Multiple Registers' (Char DeviceAddress, Integer StartRegisterAddress, Integer QuantityOfRegisters, Integer Values[])
{
    If (QuantityOfRegisters && QuantityOfRegisters <= $7B) // <=1968
    {
	local_var volatile Char    sData[512];
	local_var volatile Integer i;
	
	sData = "Format('%02X', DeviceAddress), Format('%02X', $10), 
	         Format('%04X', StartRegisterAddress), 
		 Format('%04X', QuantityOfRegisters), Format('%02X', QuantityOfRegisters * 2)";

	For (i = 1; i <= QuantityOfRegisters; i++)
		sData = "sData, Format('%04X', Values[i])";
	
	Send_Command vdvModbus, "'ADDCOMMAND = ', sData";
    }
}


Define_Call 'Modbus - Write Multiple Registers - Single register' (Char DeviceAddress, Integer RegisterAddress, Integer Value)
{
    Send_Command vdvModbus, "'ADDCOMMAND = ', Format('%02X', DeviceAddress), 
			    Format('%02X', $10), Format('%04X', RegisterAddress), 
			    Format('%04X', 1 /* QuantityOfRegisters */), 
			    Format('%02X', 2 /* QuantityOfRegisters * 2 */), 
			    Format('%04X', Value)";
    //send_string 0, "'####################'";			    
}


Define_Call 'ModBus - Process Answer' (Char Function, Char Device, Integer Address, Integer Value)
{
    LOCAL_VAR CHAR cText[100]
    
    // TODO : Process answers there
    Select
    {
	// Обработка ответа от устройства
	Active (Function == 3 && Address == REG_OUTDOOR_TEMPERATURE)  : {
	    VAR_OUTDOOR_TEMPERATURE = Value
	    TemperatureText(dvPanel, 1, VAR_OUTDOOR_TEMPERATURE)	    
	} 	
	Active (Function == 3 && Address == REG_ROOM_TEMPERATURE)  : {
	    VAR_ROOM_TEMPERATURE = Value
    	    TemperatureText(dvPanel, 2, VAR_ROOM_TEMPERATURE)	    	    
	}	
	Active (Function == 3 && Address == REG_ROOM_TEMPERATURE_SETPOINT) : {
	    VAR_ROOM_TEMPERATURE_SETPOINT  = Value
    	    TemperatureText(dvPanel, 3, VAR_ROOM_TEMPERATURE_SETPOINT)	    
	}	
	Active (Function == 3 && Address == REG_HOT_WATER_MODE) : {
	    VAR_HOT_WATER_MODE  = Value
    	    HotWaterModeText(dvPanel, 4, VAR_HOT_WATER_MODE)	    
	    
	    // ****************************************************************
	    if( VAR_HOT_WATER_MODE == 0 ) { [dvPanel,145] = 1 }
	    else { [dvPanel,145] = 0 }

	    if( VAR_HOT_WATER_MODE == 1 ) { [dvPanel,146] = 1 }
	    else { [dvPanel,146] = 0 }

	    if( VAR_HOT_WATER_MODE == 2 ) { [dvPanel,147] = 1 }
	    else { [dvPanel,147] = 0 }
	    // ****************************************************************
	    
	}	
	Active (Function == 3 && Address == REG_COMFORT_HOTWATER_TEMPERATURE)  : {
	    VAR_COMFORT_HOTWATER_TEMPERATURE  = Value 	    
	    cText = "ITOA(VAR_COMFORT_HOTWATER_TEMPERATURE),'°C'"     
	    SEND_COMMAND dvPanel, "'^TXT-5,0,', cText"
	}
	Active (Function == 3 && Address == REG_BT10) : {
	    VAR_BT10 = Value 
	    SEND_COMMAND dvPanel, "'^TXT-6,0,', ITOA(VAR_BT10)"
	}
	Active (Function == 3 && Address == REG_BT11) : {
	    VAR_BT11 = Value 
	    SEND_COMMAND dvPanel, "'^TXT-7,0,', ITOA(VAR_BT11)"	 
	}
	Active (Function == 3 && Address == REG_BT3) : {
	    VAR_BT3 = Value 
	    SEND_COMMAND dvPanel, "'^TXT-8,0,', ITOA(VAR_BT3)"
	}
	Active (Function == 3 && Address == REG_ALARM) : {
	    VAR_ALARM = Value 
	    if( VAR_ALARM == 0 )
	    {
		SEND_COMMAND dvPanel, "'^TXT-9,0,', ITOA(VAR_ALARM)"
	    }
	    else
	    {
		SEND_COMMAND dvPanel, "'^TXT-9,0,The boiler has reported an error please check your equip. Code:', ITOA(VAR_ALARM)"
	    }	    
	}
	
    }                                                                        
}


(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT



BUTTON_EVENT [vdv_LUTRON, 200] //Калитка
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 17',$0D";
	SEND_STRING 0, "'KBP, [1:6:1], 17',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 201] //Дорожки
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 9',$0D";
	SEND_STRING 0, "'KBP, [1:6:1], 09',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 202] //Дальние
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:06:1], 10',$0D";
	SEND_STRING 0, "'KBP, [1:06:1], 10',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 203] //Вход спа
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 1',$0D";
	SEND_STRING 0, "'KBP, [1:6:1], 1',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 204] //Беседка 1
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 18',$0D";
	SEND_STRING 0, "'KBP, [1:6:1], 18',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 205] //Беседка 2
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 19',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 19',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 206] //Беседка 3
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 20',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 20',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 207] //Беседка 4
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 21',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 21',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 208] //Прожектор
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 2',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 2',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 209] //Ель 1
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 11',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 11',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 210] //Ель 2
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 12',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 12',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 211] //Ель 3
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 13',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 13',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 212] //Ворота
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 22',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 22',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 213] //Гараж 1
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 14',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 14',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 214] //Гараж 2
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 6',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 6',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 216] //Гараж 2 закрыть
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 7',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 7',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 217] //Гараж 1 закрыть
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 15',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 15',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 218] //Ворота закрыть
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 23',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 23',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 219] //Туман
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
		[IPAD,203] = 1;
		send_string 0, 'ON'
	    }
	    ACTIVE (FIND_STRING (Lutron_buffer,'[01:06:01], 000',1)):
	    {
		[IPAD,203] = 0;
		send_string 0, 'OFF'
	    }
	}
    }
}*/

BUTTON_EVENT [vdv_LUTRON, 220] //Въезд
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 3',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 03',$0D"
    }
}

DATA_EVENT[Lutron]
{
    ONLINE:
    {
	SEND_COMMAND Lutron,'SET BAUD 9600,N,8,1'
	SEND_STRING  Lutron,"'KLMON',$0D" 
	WAIT 20 
	{
	    SEND_STRING  Lutron,"'RKLS,[01:06:01]',13"
	}
    }
}



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
	If (iPos) Set_Length_String(Data.Text, iPos - 1);

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
		
		Call 'ModBus - Process Answer' ( hextoi(Mid_String(Data.Text, 1, 2)), 
						 hextoi(Mid_String(Data.Text, 4, 2)), 
						 hextoi(Mid_String(Data.Text, 7, 4)), 
						 hextoi(Mid_String(Data.Text, 12, 4)) );
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
		
		/*
		send_string 0, "'+@@@@@@@@@@@@@@@@@@@@@@===> ', Data.Text, ' ',
				Mid_String(Data.Text, 1, 2), '-', 
				Mid_String(Data.Text, 3, 2), '-', 
				Mid_String(Data.Text, 5, 4)";  
				
		*/
		
		if ( hextoi(Mid_String(Data.Text, 3, 2)) == $10 )
		{
		    //send_string 0, "'+&&&&&&&&&&&&&&&&&&&&&&===> ', Mid_String(Data.Text, 5, 4), ' !!!'";
		    // Resend request
		    Call 'ModBus - Call Function' (3, 1, hextoi(Mid_String(Data.Text, 5, 4)), 1);		    
		    
		    //SEND_COMMAND dvPanel, "'^TXT-3,0,', 'wait...'"		    
		    //Call 'ModBus - Call Function' (3, 1, REG_ROOM_TEMPERATURE_SETPOINT, 1);		    
		    send_string 0, "'=============>>>>>>>>>>>>>>'";		    		    
		}
				
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
	//Send_Command Data.Device, "'VDVDEBUG = ', itoa(vdvDebug.Number), ':', itoa(vdvDebug.Port), ':', itoa(vdvDebug.System)"; // Включить дублирование диагностических сообщений на адрес vdvDebug
	//Send_Command Data.Device, 'VDVDEBUG = 0:1:0';    

	// Включение/выключение режима отображания расширенной отладочной информации.
	// Send_Command Data.Device, "'DEBUG = OFF'"; // Выключить режим отображания расширенной отладочной информации
	Send_Command Data.Device, "'DEBUG = ON'"; // Включить режим отображания расширенной отладочной информации

	// Задание строки, с которой будут начинаться все сообщения в окне Диагностики от данного модуля
	// Значение по умолчанию: Modbus
	// Например, 'Modbus[1]: Connecton ON'
	// Send_Command Data.Device, 'DEBUGSTRING = Modbus[1]'; // Поменять начало на "Modbus[1]"


	// ********************************************************************
	// Запрос информации о версии модуля
	// ********************************************************************
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


DATA_EVENT [dvPanel]
{
    ONLINE:
	send_string 0, "'Welcome Panel...'";
    OFFLINE:
	send_string 0, "'Panel offline...'";
}

BUTTON_EVENT[dvPanel, controlPanelButtons]
{
    PUSH:
    {
	send_string 0,"'btnEVT [dvTP,',ITOA(PUSH_CHANNEL),']'"
	Send_String 0,"'Button ',ITOA(BUTTON.INPUT.CHANNEL),' of dvTp was pushed'"
	
	SWITCH(PUSH_CHANNEL)
	{
	    // REG_ROOM_TEMPERATURE_SETPOINT ##################################
	    CASE 139:
	    {
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_ROOM_TEMPERATURE_SETPOINT, 190)		
	    }	
	    CASE 140: //controlPanelButtons[0]:	// btn_p1_up
	    {
		send_string 0, "'btn_p1_up 140'";
		IF( (VAR_ROOM_TEMPERATURE_SETPOINT + UP_INC) >= 250) { VAR_ROOM_TEMPERATURE_SETPOINT = 250 }
		ELSE { VAR_ROOM_TEMPERATURE_SETPOINT = (VAR_ROOM_TEMPERATURE_SETPOINT + UP_INC) } 
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_ROOM_TEMPERATURE_SETPOINT, VAR_ROOM_TEMPERATURE_SETPOINT)		
	    }	
	    CASE 141:	// btn_p1_down
	    {
		send_string 0, "'btn_p1_down 141'";
		IF( (VAR_ROOM_TEMPERATURE_SETPOINT - DN_INC) <= 100) { VAR_ROOM_TEMPERATURE_SETPOINT = 100 }
		ELSE { VAR_ROOM_TEMPERATURE_SETPOINT = (VAR_ROOM_TEMPERATURE_SETPOINT - DN_INC) } 
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_ROOM_TEMPERATURE_SETPOINT, VAR_ROOM_TEMPERATURE_SETPOINT)		
	    }
	    
	    // REG_COMFORT_HOTWATER_TEMPERATURE ###############################
	    CASE 142:
	    { 	    	    
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_COMFORT_HOTWATER_TEMPERATURE, 55)		
	    }
	    CASE 143:	// btn_p2_up
	    { 	    	    
		send_string 0, "'btn_p2_up 143'";
		IF( (VAR_COMFORT_HOTWATER_TEMPERATURE + 1) >= 65) { VAR_COMFORT_HOTWATER_TEMPERATURE = 65 }
		ELSE { VAR_COMFORT_HOTWATER_TEMPERATURE = (VAR_COMFORT_HOTWATER_TEMPERATURE + 1) } 
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_COMFORT_HOTWATER_TEMPERATURE,VAR_COMFORT_HOTWATER_TEMPERATURE)		
	    }
	    CASE 144:	// btn_p2_down
	    {
		send_string 0, "'btn_p2_down 144'";
		IF( (VAR_COMFORT_HOTWATER_TEMPERATURE - 1) <= 45) { VAR_COMFORT_HOTWATER_TEMPERATURE = 45 }
		ELSE { VAR_COMFORT_HOTWATER_TEMPERATURE = (VAR_COMFORT_HOTWATER_TEMPERATURE - 1) } 
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_COMFORT_HOTWATER_TEMPERATURE, VAR_COMFORT_HOTWATER_TEMPERATURE)		
	    }
	    
	    // REG_HOT_WATER_MODE #############################################
	    CASE 145:	// economy
	    { 	    	    	    
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 0)		
		send_string 0, "'btn_economy'";
	    }
	    CASE 146:	// normal
	    {
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 1)		
	    }
	    CASE 147:	// luxury
	    {
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 2)		
	    }	    	    
	    
	}    
    }
}


BUTTON_EVENT[dvPanel,195]
{
    PUSH:
    {
	send_string 0,"'SEND_COMMAND dvPanel, *********************************'"
    
	//Deletes any existing data list at address 1
	SEND_COMMAND dvPanel, "' ^LDD-100'"
	//Creates new 5-column data list at port 1, address 1 named "my music"
	SEND_COMMAND dvPanel, "' ^LDN-100,1,2,my music'"
	//Specifies column types for the data list at address 1 starting at column 1
	SEND_COMMAND dvPanel, "' ^LDT-100,1,0,0,0,0,3'"
	    
	//Adds rows to the data list at address 1
	SEND_COMMAND dvPanel, "' ^LDA-100,0,01,The Shins"'"
	SEND_COMMAND dvPanel, "' ^LDA-100,0,02,The Shins, Chutes Too Narrow, "Mine High Horse", "10,2"'"
	SEND_COMMAND dvPanel, "' ^LDA-100,0,03,The Shins, Chutes Too Narrow, So Says I,"10,3"'"
	SEND_COMMAND dvPanel, "' ^LDA-100,0,04,The Shins'"
	SEND_COMMAND dvPanel, "' ^LDA-777,0,05,The Shins, Chutes Too Narrow, Saint Simon, "10,5"'"
	//SEND_COMMAND dvPanel, "' ^LDA-1,0,06,The Shins, Chutes Too Narrow, Fighting in a Sack,"10,6"'"
	//SEND_COMMAND dvPanel, "' ^LDA-1,0,07,The Shins, Chutes Too Narrow, Pink Bullets, "10,7"'"
	//SEND_COMMAND dvPanel, "' ^LDA-1,0,08,The Shins, Chutes Too Narrow, Turn a Square,"10,8"'"
	//SEND_COMMAND dvPanel, "' ^LDA-1,0,09,The Shins, Chutes Too Narrow, Gone for Good, "10,9"'"
	
	//Updates the view at address 2
	SEND_COMMAND dvPanel, "' ^LVU-100'"
	
	if( [dvPanel,195] == 0 ) 
	{
	    [dvPanel,195] = 1
	}
	else 
	{
	    [dvPanel,195] = 0
	}
	
    }
}    

/* ######################################################################### */
DEFINE_MODULE 'module Modbus Master' mdl_Modbus (dvModbus, vdvModbus);



(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

send_string 0,"'Programm starting... Description: ',PROGRAM_DESCRIPTION"
//SEND_STRING 0,"'  Running ',AXS_NAME,' v',AXS_VER"

COMBINE_CHANNELS (vdv_LUTRON, 200, ipad, 200)
COMBINE_CHANNELS (vdv_LUTRON, 201, ipad, 201)
COMBINE_CHANNELS (vdv_LUTRON, 202, ipad, 202)
COMBINE_CHANNELS (vdv_LUTRON, 203, ipad, 203)
COMBINE_CHANNELS (vdv_LUTRON, 204, ipad, 204)
COMBINE_CHANNELS (vdv_LUTRON, 205, ipad, 205)
COMBINE_CHANNELS (vdv_LUTRON, 206, ipad, 206)
COMBINE_CHANNELS (vdv_LUTRON, 207, ipad, 207)
COMBINE_CHANNELS (vdv_LUTRON, 208, ipad, 208)
COMBINE_CHANNELS (vdv_LUTRON, 209, ipad, 209)
COMBINE_CHANNELS (vdv_LUTRON, 210, ipad, 210)
COMBINE_CHANNELS (vdv_LUTRON, 211, ipad, 211)
COMBINE_CHANNELS (vdv_LUTRON, 212, ipad, 212)
COMBINE_CHANNELS (vdv_LUTRON, 213, ipad, 213)
COMBINE_CHANNELS (vdv_LUTRON, 214, ipad, 214)
COMBINE_CHANNELS (vdv_LUTRON, 215, ipad, 215)
COMBINE_CHANNELS (vdv_LUTRON, 216, ipad, 216)
COMBINE_CHANNELS (vdv_LUTRON, 217, ipad, 217)
COMBINE_CHANNELS (vdv_LUTRON, 218, ipad, 218)
COMBINE_CHANNELS (vdv_LUTRON, 219, ipad, 219)
COMBINE_CHANNELS (vdv_LUTRON, 220, ipad, 220)
COMBINE_CHANNELS (vdv_LUTRON, 221, ipad, 221)
COMBINE_CHANNELS (vdv_LUTRON, 222, ipad, 222)
COMBINE_CHANNELS (vdv_LUTRON, 223, ipad, 223)  
COMBINE_CHANNELS (vdv_LUTRON, 224, ipad, 224)  

CREATE_BUFFER Lutron, Lutron_buffer;



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


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
	    [vdv_LUTRON,203] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 1, 1),'0'))   
	{
	    [vdv_LUTRON,203] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 2, 1),'1'))
	{
	    [vdv_LUTRON,208] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 2, 1),'0'))   
	{
	    [vdv_LUTRON,208] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 3, 1),'1'))
	{
	    [vdv_LUTRON,220] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 3, 1),'0'))   
	{
	    [vdv_LUTRON,220] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 4, 1),'1'))
	{
	    [vdv_LUTRON,219] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 4, 1),'0'))   
	{
	    [vdv_LUTRON,219] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 6, 1),'1'))
	{
	    [vdv_LUTRON,214] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 6, 1),'0'))   
	{
	    [vdv_LUTRON,214] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 9, 1),'1'))
	{
	    [vdv_LUTRON,201] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 9, 1),'0'))   
	{
	    [vdv_LUTRON,201] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 10, 1),'1'))
	{
	    [vdv_LUTRON,202] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 10, 1),'0'))   
	{
	    [vdv_LUTRON,202] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 11, 1),'1'))
	{
	    [vdv_LUTRON,209] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 11, 1),'0'))   
	{
	    [vdv_LUTRON,209] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 12, 1),'1'))
	{
	    [vdv_LUTRON,210] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 12, 1),'0'))   
	{
	    [vdv_LUTRON,210] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 13, 1),'1'))
	{
	    [vdv_LUTRON,211] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 13, 1),'0'))   
	{
	    [vdv_LUTRON,211] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 14, 1),'1'))
	{
	    [vdv_LUTRON,213] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 14, 1),'0'))   
	{
	    [vdv_LUTRON,213] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 17, 1),'1'))
	{
	    [vdv_LUTRON,200] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 17, 1),'0'))   
	{
	    [vdv_LUTRON,200] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 18, 1),'1'))
	{
	    [vdv_LUTRON,204] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 18, 1),'0'))   
	{
	    [vdv_LUTRON,204] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 19, 1),'1'))
	{
	    [vdv_LUTRON,205] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 19, 1),'0'))   
	{
	    [vdv_LUTRON,205] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 20, 1),'1'))
	{
	    [vdv_LUTRON,206] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 20, 1),'0'))   
	{
	    [vdv_LUTRON,206] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 21, 1),'1'))
	{
	    [vdv_LUTRON,207] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 21, 1),'0'))   
	{
	    [vdv_LUTRON,207] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 22, 1),'1'))
	{
	    [vdv_LUTRON,212] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 22, 1),'0'))   
	{
	    [vdv_LUTRON,212] = 0;
	}
    }    
    CLEAR_BUFFER Lutron_buffer;
}



Wait 300 'Modbus Requests'
{       
    // Read values
    // TODO Прочитать функцией 4 у устройства с адресом $10 регистровые значения начиная с адреса $1400 в количесте 20 штук подряд
    // Т.е. прийдют ответы от регистров $1400, $1401, ..., $1412 
    // (итого 20 значений, которые надо будет обработать в функции 'ModBus - Process Answer'

    send_string 0, "'=== Wait 300 ==='";	

    wait 0
    {
	send_string 0, "'=== Wait 0 ==='";	
	Call 'ModBus - Call Function' (3, 1, REG_OUTDOOR_TEMPERATURE, 1);
	//send_string 0, "'Outdoor temperature'";
	SEND_COMMAND dvPanel, "'^TXT-1,0,', 'wait...'"
    }
    wait 25
    {	
	send_string 0, "'=== Wait 25 ==='";	
	Call 'ModBus - Call Function' (3, 1, REG_ROOM_TEMPERATURE, 1);
	//send_string 0, "'Call','Room temperature (BT50) 40033'";	
	SEND_COMMAND dvPanel, "'^TXT-2,0,', 'wait...'"
    }
    wait 50
    {
	send_string 0, "'=== Wait 50 ==='";	
	Call 'ModBus - Call Function' (3, 1, REG_ROOM_TEMPERATURE_SETPOINT, 1);
	//send_string 0, "'REG_ROOM_TEMPERATURE_SETPOINT'";
	SEND_COMMAND dvPanel, "'^TXT-3,0,', 'wait...'"
    }
    wait 75
    {
	send_string 0, "'=== Wait 75 ==='";	
	Call 'ModBus - Call Function' (3, 1, REG_HOT_WATER_MODE, 1);
	SEND_COMMAND dvPanel, "'^TXT-4,0,', 'wait...'"
    }    
    wait 100
    {	
	send_string 0, "'=== Wait 100 ==='";	
	Call 'ModBus - Call Function' (3, 1, REG_COMFORT_HOTWATER_TEMPERATURE, 1);
	SEND_COMMAND dvPanel, "'^TXT-5,0,', 'wait...'"
    }
    wait 125
    {
	send_string 0, "'=== Wait 125 ==='";	
	Call 'ModBus - Call Function' (3, 1, REG_BT10, 1);
	SEND_COMMAND dvPanel, "'^TXT-6,0,', 'wait...'"	
    }    
    wait 150
    {
	send_string 0, "'=== Wait 150 ==='";	
	Call 'ModBus - Call Function' (3, 1, REG_BT11, 1);
	SEND_COMMAND dvPanel, "'^TXT-7,0,', 'wait...'"	
    }    
    wait 200
    {
	send_string 0, "'=== Wait 200 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_BT3, 1); 
	SEND_COMMAND dvPanel, "'^TXT-8,0,', 'wait...'"	
    }	
    wait 225
    {
	send_string 0, "'=== Wait 225 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_ALARM, 1);
	SEND_COMMAND dvPanel, "'^TXT-9,0,', 'wait...'"	
    }
    
}









/*
Wait 100 'Write Modbus Requests'
{
    Call 'Modbus - Write Multiple Registers - Single register' (1, REG_BT3, 190)		
}
*/

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
