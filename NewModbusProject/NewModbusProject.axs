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


/*
IP 193.178.251.2

44421 ftp
44422 22 ����
44423 telnet
44480 web
41319 �������
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
//IPAD    = 11001:1:1;


#INCLUDE 'Lutron_routines.axs'



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
//BT1 Outdoor temp Outdoor temperature 40004 �C s16 10 R
INTEGER REG_OUTDOOR_TEMPERATURE  = 40004
//BT50 Room Temp S1 40033 �C s16 10 R
INTEGER REG_ROOM_TEMPERATURE  = 40033
//Room sensor setpoint S1 Sets the room temperature setpoint for the system 47398 �C s16 10 R/W
INTEGER REG_ROOM_TEMPERATURE_SETPOINT  = 47398
//Hot water mode 0=Economy 1=Normal 2=Luxury 47041 s8 1 R/W
INTEGER REG_HOT_WATER_MODE  = 47041
//HW Comfort hotwater temperature The desired hotwater temperature 48148 �C s8 10 R/W
INTEGER REG_COMFORT_HOTWATER_TEMPERATURE  = 48148
//BT6 Hot Water load 40014 �C s16 10 R
INTEGER REG_HOTWATER_LOAD  = 40014

//Alarm lower room temp.
//Lowers the room temperature during red light alarms to notify the occupants of the
//building that something is the matter 0=Off 1=On 47388 u8 1 R/W
//Alarm lower HW temp.
//Lowers the hot water temperature during red light alarms to notify the occupants of
//the building that something is the matter 0=Off 1=On 47389 u8 1 R/W


ch_heating_temperature_up	= 130
ch_heating_temperature_down	= 131
ch_heating_temperature_ok 	= 132
ch_heating_temperature_view 	= 133
ch_heating_normal		= 135
ch_heating_economy		= 136
//ch_heating_economy		= 137

ch_hotwater_temperature_up	= 140
ch_hotwater_temperature_down	= 141
ch_hotwater_temperature_ok	= 142
ch_hotwater_temperature_view	= 143
ch_hotwater_mode_economy	= 145
ch_hotwater_mode_normal		= 146
ch_hotwater_mode_luxury		= 147
ch_hotwater_1_hour		= 148
ch_hotwater_2_hour		= 149
ch_hotwater_5_hour		= 150

ch_alarm_message 		= 160


addr_outdoor_temperature	= 1
addr_room_temperature		= 2
addr_room_temperature_setpoint	= 3
addr_hotwater_mode		= 4
addr_comfort_hotwater_temperature = 5
addr_hotwater_load		= 5
addr_brine_in			= 6
addr_brine_out			= 7
addr_return_temperature 	= 8
addr_alarm_number 		= 9
addr_alarm_message 		= 10
addr_lux_timer			= 20

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
VOLATILE INTEGER VAR_PREP_ROOM_TEMPERATURE_SETPOINT

PERSISTENT INTEGER VAR_HOT_WATER_MODE
PERSISTENT INTEGER VAR_COMFORT_HOTWATER_TEMPERATURE
VOLATILE INTEGER VAR_PREP_COMFORT_HOTWATER_TEMPERATURE

PERSISTENT INTEGER VAR_TERM_LUXURY

INTEGER VAR_HOTWATER_LOAD


// Touch Panel Buttons
VOLATILE INTEGER controlPanelButtons[] =
{
    ch_heating_temperature_up,
    ch_heating_temperature_down,
    ch_heating_temperature_ok,
    ch_heating_temperature_view,
    ch_heating_normal,
    ch_heating_economy,

    ch_hotwater_temperature_up,
    ch_hotwater_temperature_down,
    ch_hotwater_temperature_ok,
    ch_hotwater_temperature_view,
    ch_hotwater_mode_economy,
    ch_hotwater_mode_normal,
    ch_hotwater_mode_luxury,
    ch_hotwater_1_hour,
    ch_hotwater_2_hour,
    ch_hotwater_5_hour,

    ch_alarm_message
}


SINTEGER CURR_MINUTE
SINTEGER LAST_MINUTE

PERSISTENT SINTEGER TIMER_MINUTES
PERSISTENT SINTEGER SET_MINUTES


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

#INCLUDE 'SubRoutines.axs'


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
	bData = $00; 
	For (i = 1; i <= QuantityOfCoils; i++) 
	{ 
	    bData = bData | (Bits[(i - 1) % 8 + 1] * Coils[i]); 
	    If (i % 8 == 0) 
	    { 
		sData = "sData, Format('%02X', bData)"; bData = $00; 
	    } 
	}
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
	// ��������� ������ �� ����������
	Active (Function == 3 && Address == REG_OUTDOOR_TEMPERATURE)  : {
	    VAR_OUTDOOR_TEMPERATURE = Value
	    TemperatureText(dvPanel, addr_outdoor_temperature, VAR_OUTDOOR_TEMPERATURE)
	}
	Active (Function == 3 && Address == REG_ROOM_TEMPERATURE)  : {
	    VAR_ROOM_TEMPERATURE = Value
    	    TemperatureText(dvPanel, addr_room_temperature, VAR_ROOM_TEMPERATURE)
	}
	Active (Function == 3 && Address == REG_ROOM_TEMPERATURE_SETPOINT) : {
	    VAR_ROOM_TEMPERATURE_SETPOINT  = Value
    	    //TemperatureText(dvPanel, addr_room_temperature_setpoint, VAR_ROOM_TEMPERATURE_SETPOINT)

	    if( VAR_PREP_ROOM_TEMPERATURE_SETPOINT == 0 ) { VAR_PREP_ROOM_TEMPERATURE_SETPOINT = VAR_ROOM_TEMPERATURE_SETPOINT; }

	    send_string 0, "'111111111111'";
	    if( VAR_PREP_ROOM_TEMPERATURE_SETPOINT == VAR_ROOM_TEMPERATURE_SETPOINT )
	    {
		//send_string 0, "'22222222222'";
		[dvPanel, ch_heating_temperature_view] = 1;
	    }
	    else
	    {
		//send_string 0, "'33333333333333333'";
		[dvPanel, ch_heating_temperature_view] = 0;
	    }
	    TemperatureText(dvPanel, addr_room_temperature_setpoint, VAR_PREP_ROOM_TEMPERATURE_SETPOINT)

       	    if( VAR_ROOM_TEMPERATURE_SETPOINT <= 190 and VAR_ROOM_TEMPERATURE_SETPOINT > 160 )	// 19.0 grad
	    {
		[dvPanel, ch_heating_normal] = 1;
		[dvPanel, ch_heating_economy] = 0;
	    }
	    else
	    if( VAR_ROOM_TEMPERATURE_SETPOINT <= 160 )	// 16.0 grad
	    {
		[dvPanel, ch_heating_normal] = 0;
		[dvPanel, ch_heating_economy] = 1;
	    }
	    else
	    if( VAR_ROOM_TEMPERATURE_SETPOINT >= 190 )
	    {
		[dvPanel, ch_heating_normal] = 0;
		[dvPanel, ch_heating_economy] = 0;	    
	    }

	}
	Active (Function == 3 && Address == REG_HOT_WATER_MODE) : {
	    VAR_HOT_WATER_MODE  = Value
    	    HotWaterModeText(dvPanel, addr_hotwater_mode, VAR_HOT_WATER_MODE)

	    // ****************************************************************
	    if( VAR_HOT_WATER_MODE == 0 ) { [dvPanel,ch_hotwater_mode_economy] = 1 }
	    else { [dvPanel,ch_hotwater_mode_economy] = 0 }

	    if( VAR_HOT_WATER_MODE == 1 ) { [dvPanel,ch_hotwater_mode_normal] = 1 }
	    else { [dvPanel,ch_hotwater_mode_normal] = 0 }

	    if( VAR_HOT_WATER_MODE == 2 ) { [dvPanel,ch_hotwater_mode_luxury] = 1 }
	    else { [dvPanel,ch_hotwater_mode_luxury] = 0 }

	    IF( VAR_TERM_LUXURY == 1 ) [dvPanel, ch_hotwater_1_hour] = 1;
	    ELSE
	    IF( VAR_TERM_LUXURY == 2 ) [dvPanel, ch_hotwater_2_hour] = 1;
	    ELSE
	    IF( VAR_TERM_LUXURY == 3 ) [dvPanel, ch_hotwater_5_hour] = 1;
	    ELSE
	    {
		[dvPanel, ch_hotwater_1_hour] = 0;
		[dvPanel, ch_hotwater_2_hour] = 0;
		[dvPanel, ch_hotwater_5_hour] = 0;
	    }
	    // ****************************************************************
	}
	Active (Function == 3 && Address == REG_COMFORT_HOTWATER_TEMPERATURE)  : {
	    VAR_COMFORT_HOTWATER_TEMPERATURE  = Value
	    if( VAR_PREP_COMFORT_HOTWATER_TEMPERATURE == 0 ) { VAR_PREP_COMFORT_HOTWATER_TEMPERATURE = VAR_COMFORT_HOTWATER_TEMPERATURE; }

    	    if( VAR_PREP_COMFORT_HOTWATER_TEMPERATURE == VAR_COMFORT_HOTWATER_TEMPERATURE )
	    {
		[dvPanel, ch_hotwater_temperature_view] = 1;
	    }
	    else
	    {
		[dvPanel, ch_hotwater_temperature_view] = 0;
	    }
	    cText = "ITOA(VAR_PREP_COMFORT_HOTWATER_TEMPERATURE),'�C'"
	    SEND_COMMAND dvPanel, "'^TXT-5,0,', cText"
	    // ****************************************************************
	}
	Active (Function == 3 && Address == REG_HOTWATER_LOAD)  : {
	    VAR_HOTWATER_LOAD  = Value
	    TemperatureText(dvPanel, addr_hotwater_load, VAR_HOTWATER_LOAD)
	    // ****************************************************************
	}
	Active (Function == 3 && Address == REG_BT10) : {
	    VAR_BT10 = Value
	    //SEND_COMMAND dvPanel, "'^TXT-6,0,', ITOA(VAR_BT10)"
	    TemperatureText(dvPanel, addr_brine_in, VAR_BT10)
	}
	Active (Function == 3 && Address == REG_BT11) : {
	    VAR_BT11 = Value
	    //SEND_COMMAND dvPanel, "'^TXT-7,0,', ITOA(VAR_BT11)"
	    TemperatureText(dvPanel, addr_brine_out, VAR_BT11)
	}
	Active (Function == 3 && Address == REG_BT3) : {
	    VAR_BT3 = Value
	    //SEND_COMMAND dvPanel, "'^TXT-8,0,', ITOA(VAR_BT3)"
	    TemperatureText(dvPanel, addr_return_temperature, VAR_BT3)
	    
	}
	Active (Function == 3 && Address == REG_ALARM) : {
	    VAR_ALARM = Value
	    SEND_COMMAND dvPanel, "'^TXT-9,0,', ITOA(VAR_ALARM)"

	    if( VAR_ALARM == 0 )
	    {
		//SEND_COMMAND dvPanel, "'^TXT-9,0,', ITOA(VAR_ALARM)"
		[dvPanel, ch_alarm_message] = 0;
		//cText = "'Code:', ITOA(VAR_ALARM)"
		//SimpleText(dvPanel, addr_alarm_message, cText)
		SimpleText(dvPanel, addr_alarm_message, "")
	    }
	    else
	    {
		//SEND_COMMAND dvPanel, "'^TXT-9,0,The boiler has reported an error please check your equip. Code:', ITOA(VAR_ALARM)"
		[dvPanel, ch_alarm_message] = 1;
		//cText = "'Code:', ITOA(VAR_ALARM), ' ', AlarmList[VAR_ALARM].cAlarmTextDisplay"
		cText = "'Code:', ITOA(VAR_ALARM), ' The boiler has reported an error!'"
		SimpleText(dvPanel, addr_alarm_message, cText)
	    }
	}

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
	//Send_Command Data.Device, "'VDVDEBUG = ', itoa(vdvDebug.Number), ':', itoa(vdvDebug.Port), ':', itoa(vdvDebug.System)"; // �������� ������������ ��������������� ��������� �� ����� vdvDebug
	//Send_Command Data.Device, 'VDVDEBUG = 0:1:0';

	// ���������/���������� ������ ����������� ����������� ���������� ����������.
	// Send_Command Data.Device, "'DEBUG = OFF'"; // ��������� ����� ����������� ����������� ���������� ����������
	Send_Command Data.Device, "'DEBUG = ON'"; // �������� ����� ����������� ����������� ���������� ����������

	// ������� ������, � ������� ����� ���������� ��� ��������� � ���� ����������� �� ������� ������
	// �������� �� ���������: Modbus
	// ��������, 'Modbus[1]: Connecton ON'
	// Send_Command Data.Device, 'DEBUGSTRING = Modbus[1]'; // �������� ������ �� "Modbus[1]"


	// ********************************************************************
	// ������ ���������� � ������ ������
	// ********************************************************************
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
	send_string 0,"'>>> btnEVT [dvTP,',ITOA(PUSH_CHANNEL),']'"
	Send_String 0,"'>>> Button ',ITOA(BUTTON.INPUT.CHANNEL),' of dvTp was pushed'"

	SWITCH(PUSH_CHANNEL)
	{
	    // REG_ROOM_TEMPERATURE_SETPOINT ##################################
	    CASE ch_heating_temperature_ok:
	    {
		if( VAR_PREP_ROOM_TEMPERATURE_SETPOINT != 0 )
		{
		    send_string 0, "'ch_heating_temperature_ok'";
		    Call 'Modbus - Write Multiple Registers - Single register' (1, REG_ROOM_TEMPERATURE_SETPOINT, VAR_PREP_ROOM_TEMPERATURE_SETPOINT);
		}
	    }
	    CASE ch_heating_temperature_up:
	    {
		if( VAR_PREP_ROOM_TEMPERATURE_SETPOINT != 0 )
		{
		    send_string 0, "'ch_heating_temperature_up'";
		    IF( (VAR_PREP_ROOM_TEMPERATURE_SETPOINT + UP_INC) >= 250) { VAR_PREP_ROOM_TEMPERATURE_SETPOINT = 250 }
		    ELSE { VAR_PREP_ROOM_TEMPERATURE_SETPOINT = (VAR_PREP_ROOM_TEMPERATURE_SETPOINT + UP_INC) }
		    TemperatureText(dvPanel, addr_room_temperature_setpoint, VAR_PREP_ROOM_TEMPERATURE_SETPOINT);
		    if( VAR_PREP_ROOM_TEMPERATURE_SETPOINT == VAR_ROOM_TEMPERATURE_SETPOINT ) { [dvPanel, ch_heating_temperature_view] = 1 }
		    else { [dvPanel, ch_heating_temperature_view] = 0 }
		}
	    }
	    CASE ch_heating_temperature_down:
	    {
		if( VAR_PREP_ROOM_TEMPERATURE_SETPOINT != 0 )
		{
		    send_string 0, "'ch_heating_temperature_down'";
		    IF( (VAR_PREP_ROOM_TEMPERATURE_SETPOINT - DN_INC) <= 100) { VAR_PREP_ROOM_TEMPERATURE_SETPOINT = 100 }
		    ELSE { VAR_PREP_ROOM_TEMPERATURE_SETPOINT = (VAR_PREP_ROOM_TEMPERATURE_SETPOINT - DN_INC) }
		    TemperatureText(dvPanel, addr_room_temperature_setpoint, VAR_PREP_ROOM_TEMPERATURE_SETPOINT);
		    if( VAR_PREP_ROOM_TEMPERATURE_SETPOINT == VAR_ROOM_TEMPERATURE_SETPOINT ) { [dvPanel, ch_heating_temperature_view] = 1 }
		    else { [dvPanel, ch_heating_temperature_view] = 0 }
		}
	    }

    	    //  #############################################
	    CASE ch_hotwater_1_hour:
	    {
		send_string 0, "'ch_hotwater_1_hour'";
		SET_MINUTES = 60;
		TIMER_MINUTES = 0;
		VAR_TERM_LUXURY = 1;
		[dvPanel, ch_hotwater_1_hour] = 1;
		[dvPanel, ch_hotwater_2_hour] = 0;
		[dvPanel, ch_hotwater_5_hour] = 0;
		SEND_COMMAND dvPanel, "'^TXT-20,0,', ITOA(TIMER_MINUTES), ' minutes'"
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 2)
	    }
	    CASE ch_hotwater_2_hour:
	    {
		send_string 0, "'ch_hotwater_2_hour'";
		SET_MINUTES = 120;
		TIMER_MINUTES = 0;
		VAR_TERM_LUXURY = 2;
		[dvPanel, ch_hotwater_1_hour] = 0;
		[dvPanel, ch_hotwater_2_hour] = 1;
		[dvPanel, ch_hotwater_5_hour] = 0;
		SEND_COMMAND dvPanel, "'^TXT-20,0,', ITOA(TIMER_MINUTES), ' minutes'"
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 2)
	    }
	    CASE ch_hotwater_5_hour:
	    {
		send_string 0, "'ch_hotwater_5_hour'";
		SET_MINUTES = 300;
		TIMER_MINUTES = 0;
		VAR_TERM_LUXURY = 3;
		[dvPanel, ch_hotwater_1_hour] = 0;
		[dvPanel, ch_hotwater_2_hour] = 0;
		[dvPanel, ch_hotwater_5_hour] = 1;
		SEND_COMMAND dvPanel, "'^TXT-20,0,', ITOA(TIMER_MINUTES), ' minutes'"
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 2)
	    }

	    // REG_COMFORT_HOTWATER_TEMPERATURE ###############################
	    CASE ch_hotwater_temperature_ok:
	    {
		if( VAR_PREP_COMFORT_HOTWATER_TEMPERATURE != 0 )
		{
		    send_string 0, "'ch_hotwater_temperature_ok'";
		    //Call 'Modbus - Write Multiple Registers - Single register' (1, REG_COMFORT_HOTWATER_TEMPERATURE, 55)
		    Call 'Modbus - Write Multiple Registers - Single register' (1, REG_COMFORT_HOTWATER_TEMPERATURE, VAR_PREP_COMFORT_HOTWATER_TEMPERATURE);
		}
	    }
	    CASE ch_hotwater_temperature_up:
	    {
		if( VAR_PREP_COMFORT_HOTWATER_TEMPERATURE != 0 )
		{
		    IF( (VAR_PREP_COMFORT_HOTWATER_TEMPERATURE + 1) >= 65) { VAR_PREP_COMFORT_HOTWATER_TEMPERATURE = 65 }
		    ELSE { VAR_PREP_COMFORT_HOTWATER_TEMPERATURE = (VAR_PREP_COMFORT_HOTWATER_TEMPERATURE + 1) }
		    SEND_COMMAND dvPanel, "'^TXT-5,0,', ITOA(VAR_PREP_COMFORT_HOTWATER_TEMPERATURE),'�C'"
		    if( VAR_PREP_COMFORT_HOTWATER_TEMPERATURE == VAR_COMFORT_HOTWATER_TEMPERATURE ) { [dvPanel, ch_hotwater_temperature_view] = 1 }
		    else { [dvPanel, ch_hotwater_temperature_view] = 0 }
		}
	    }
	    CASE ch_hotwater_temperature_down:
	    {
		if( VAR_PREP_COMFORT_HOTWATER_TEMPERATURE != 0 )
		{
		    IF( (VAR_PREP_COMFORT_HOTWATER_TEMPERATURE - 1) <= 45) { VAR_PREP_COMFORT_HOTWATER_TEMPERATURE = 45 }
		    ELSE { VAR_PREP_COMFORT_HOTWATER_TEMPERATURE = (VAR_PREP_COMFORT_HOTWATER_TEMPERATURE - 1) }
		    SEND_COMMAND dvPanel, "'^TXT-5,0,', ITOA(VAR_PREP_COMFORT_HOTWATER_TEMPERATURE),'�C'"
		    if( VAR_PREP_COMFORT_HOTWATER_TEMPERATURE == VAR_COMFORT_HOTWATER_TEMPERATURE ) { [dvPanel, ch_hotwater_temperature_view] = 1 }
		    else { [dvPanel, ch_hotwater_temperature_view] = 0 }
		}
	    }

	    // REG_HOT_WATER_MODE #############################################
	    CASE ch_hotwater_mode_economy:
	    {
		SET_MINUTES = -1;	// stop timer
		SEND_COMMAND dvPanel, "'^TXT-20,0,', ' stopped'"
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 0);
		//send_string 0, "'btn_economy'";
	    }
	    CASE ch_hotwater_mode_normal:
	    {
		SET_MINUTES = -1;	// stop timer
		SEND_COMMAND dvPanel, "'^TXT-20,0,', ' stopped'"
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 1);
	    }
	    /*
	    CASE ch_hotwater_mode_luxury:
	    {
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 2);
	    }
	    */

	    CASE ch_heating_normal:
	    {
		VAR_PREP_ROOM_TEMPERATURE_SETPOINT = 190;
		send_string 0, "'ch_heating_normal'";
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_ROOM_TEMPERATURE_SETPOINT, VAR_PREP_ROOM_TEMPERATURE_SETPOINT);
    		[dvPanel, ch_heating_normal] = 1;
		[dvPanel, ch_heating_economy] = 0;
	    }
	    CASE ch_heating_economy:
	    {
		VAR_PREP_ROOM_TEMPERATURE_SETPOINT = 160;
		send_string 0, "'ch_heating_economy'";
		Call 'Modbus - Write Multiple Registers - Single register' (1, REG_ROOM_TEMPERATURE_SETPOINT, VAR_PREP_ROOM_TEMPERATURE_SETPOINT);
    		[dvPanel, ch_heating_normal] = 0;
		[dvPanel, ch_heating_economy] = 1;
	    }
	    
	}
    }
}


BUTTON_EVENT[dvPanel,195]
{
    PUSH:
    {
	/*
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
	*/
	
	SEND_LEVEL dvPanel, 8, 55
	SEND_LEVEL dvPanel, 9, 100
    }
}


LEVEL_EVENT[dvPanel,8]
{
    STACK_VAR CHAR cTemp[2000]

    //IF (LEVEL.VALUE >= COOL_POINT)
    //{
	//ON[RELAY,FAN]
    //}

    //cTemp = AlarmText( 1 )
    Send_String 0,"'******** LEVEL_EVENT= ',ITOA(LEVEL.VALUE),' **************** ', AlarmList[2].cAlarmTextDisplay"

    //Send_String 0,"'******** LEVEL_EVENT= ',ITOA(LEVEL.VALUE),' ****************'"    

}







/* ######################################################################### */
DEFINE_MODULE 'module Modbus Master' mdl_Modbus (dvModbus, vdvModbus);



(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

send_string 0,"'Programm starting... Description: ',PROGRAM_DESCRIPTION"
//SEND_STRING 0,"'  Running ',AXS_NAME,' v',AXS_VER"

VAR_PREP_ROOM_TEMPERATURE_SETPOINT = 0


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM



Wait 300 'Modbus Requests'
{
    // Read values
    // TODO ��������� �������� 4 � ���������� � ������� $10 ����������� �������� ������� � ������ $1400 � ��������� 20 ���� ������
    // �.�. ������� ������ �� ��������� $1400, $1401, ..., $1412
    // (����� 20 ��������, ������� ���� ����� ���������� � ������� 'ModBus - Process Answer'

    send_string 0, "'=== Wait 300 ==='";

    wait 0
    {
	send_string 0, "'=== Wait 0 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_OUTDOOR_TEMPERATURE, 1);
	//SEND_COMMAND dvPanel, "'^TXT-1,0,', 'wait...'"
	SimpleText(dvPanel, addr_outdoor_temperature, 'wait...')
    }
    wait 25
    {
	send_string 0, "'=== Wait 25 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_ROOM_TEMPERATURE, 1);
	//SEND_COMMAND dvPanel, "'^TXT-2,0,', 'wait...'"
	SimpleText(dvPanel, addr_room_temperature, 'wait...')
    }
    wait 50
    {
	send_string 0, "'=== Wait 50 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_ROOM_TEMPERATURE_SETPOINT, 1);
	//SEND_COMMAND dvPanel, "'^TXT-3,0,', 'wait...'"
	SimpleText(dvPanel, addr_room_temperature_setpoint, 'wait...')
    }
    wait 75
    {
	send_string 0, "'=== Wait 75 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_HOT_WATER_MODE, 1);
	//SEND_COMMAND dvPanel, "'^TXT-4,0,', 'wait...'"
	SimpleText(dvPanel, addr_hotwater_mode, 'wait...')
    }
    wait 100
    {
	send_string 0, "'=== Wait 100 ==='";
	//Call 'ModBus - Call Function' (3, 1, REG_COMFORT_HOTWATER_TEMPERATURE, 1);
	Call 'ModBus - Call Function' (3, 1, REG_HOTWATER_LOAD, 1);
	SimpleText(dvPanel, addr_comfort_hotwater_temperature, 'wait...')
    }
    wait 125
    {
	send_string 0, "'=== Wait 125 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_BT10, 1);
	SimpleText(dvPanel, addr_brine_in, 'wait...')
    }
    wait 150
    {
	send_string 0, "'=== Wait 150 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_BT11, 1);
	SimpleText(dvPanel, addr_brine_out, 'wait...')
    }
    wait 200
    {
	send_string 0, "'=== Wait 200 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_BT3, 1);
	SimpleText(dvPanel, addr_return_temperature, 'wait...')
    }
    wait 225
    {
	send_string 0, "'=== Wait 225 ==='";
	Call 'ModBus - Call Function' (3, 1, REG_ALARM, 1);
	SimpleText(dvPanel, addr_alarm_number, 'wait...')
    }

}



Wait 200
{
    IF( SET_MINUTES != -1 )
    {
	CURR_MINUTE = TIME_TO_MINUTE (TIME)

	IF( CURR_MINUTE != LAST_MINUTE )
	{
	    LAST_MINUTE = CURR_MINUTE;
	    TIMER_MINUTES = TIMER_MINUTES + 1
	}
	Send_String 0,"'******** CURR_MINUTE= ',ITOA(CURR_MINUTE),' ****************',ITOA(TIMER_MINUTES)"

	IF( TIMER_MINUTES >= SET_MINUTES )
	{
	    SET_MINUTES = -1;	// stop timer

	    SEND_COMMAND dvPanel, "'^TXT-20,0,', ' stopped'"
	    Call 'Modbus - Write Multiple Registers - Single register' (1, REG_HOT_WATER_MODE, 0) // Economy

    	    [dvPanel, ch_hotwater_1_hour] = 0;
	    [dvPanel, ch_hotwater_2_hour] = 0;
	    [dvPanel, ch_hotwater_5_hour] = 0;
	}
	ELSE
	{
	    SEND_COMMAND dvPanel, "'^TXT-20,0,', ITOA(TIMER_MINUTES), ' / ', ITOA(SET_MINUTES), ' minutes'"
	}
    }
    ELSE
    {
	VAR_TERM_LUXURY = 0;
	[dvPanel, ch_hotwater_1_hour] = 0;
	[dvPanel, ch_hotwater_2_hour] = 0;
	[dvPanel, ch_hotwater_5_hour] = 0;
    }

}



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
