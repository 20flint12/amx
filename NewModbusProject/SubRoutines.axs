PROGRAM_NAME='SubRoutines'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)

//http://microsin.net/programming/avr/ring-buffer.html

DEFINE_DEVICE


#IF_NOT_DEFINED dvPanel
    //#WARN 'RMS: This Device Needs to be Defined in your Main Program: dvPanel'
    dvPanel    = 11001:1:1;
#END_IF



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

INTEGER BUF_SIZE = 32 //размер буфера обязательно равен степени двойки!
INTEGER BUF_MASK = BUF_SIZE-1
 

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE


// Alarm list type
STRUCTURE _Alarm
{
  //INTEGER iAlarmNo
  CHAR    cAlarmTextDisplay[500]
  CHAR    cCause[500]
  //CHAR	HeatPumpAction[500]
}


// Temperatures array type
STRUCTURE _Temperature
{
  //FLOAT fRoomTemperature
  //FLOAT fOutdoorTemperature
  INTEGER fRoomTemperature;
  INTEGER fOutdoorTemperature;

  TIME  tDateMark;
  //CHAR  tDateMark[100];
  CHAR  cTextDisplay[500];
}



(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

_Alarm AlarmList[500]

SINTEGER CURR_HOUR
PERSISTENT SINTEGER LAST_HOUR

PERSISTENT INTEGER idxIN = 0;
PERSISTENT INTEGER idxOUT = 0;
PERSISTENT _Temperature TemperatureArr[BUF_SIZE]

INTEGER i;
CHAR    sData[1024];
INTEGER idxGET;

#IF_NOT_DEFINED VAR_ROOM_TEMPERATURE
    VOLATILE INTEGER VAR_ROOM_TEMPERATURE
#END_IF
#IF_NOT_DEFINED VAR_OUTDOOR_TEMPERATURE
    VOLATILE SINTEGER VAR_OUTDOOR_TEMPERATURE
#END_IF


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION ButtonImage(DEV dvDevice, INTEGER nButton, CHAR cImage[])
{
    SEND_COMMAND dvDevice, "'^BMP-',ITOA(nButton),',0,',cImage"
}

DEFINE_FUNCTION ButtonDynamicImage(DEV dvDevice, INTEGER nButton, CHAR cImage[])
{
    SEND_COMMAND dvDevice, "'^BBR-',ITOA(nButton),',0,',cImage"
}

DEFINE_FUNCTION SimpleText(DEV dvDevice, INTEGER nButton, CHAR cText[])
{
    SEND_COMMAND dvDevice, "'^TXT-',ITOA(nButton),',0,',cText"
}

DEFINE_FUNCTION TemperatureText(DEV dvDevice, INTEGER iAddrCode, SINTEGER Temperature)
{
    LOCAL_VAR CHAR cText[20]
    //cText = "ITOA(Temperature),'°C', '++++'"

    LOCAL_VAR SINTEGER rest

    rest = Temperature % 5;
    if( rest < 3 )
    {
	Temperature = Temperature - rest
    }
    else
    {
	Temperature = Temperature - rest + 5
    }

    cText = "ITOA(Temperature/10), '.', ITOA(ABS_VALUE(Temperature%10)),'°C'"
    SEND_COMMAND dvDevice, "'^TXT-',ITOA(iAddrCode),',0,',cText"
}

DEFINE_FUNCTION HotWaterModeText(DEV dvDevice, INTEGER iAddrCode, INTEGER hot_water_mode)
{
    LOCAL_VAR CHAR cText[20]
    IF(hot_water_mode == 0) cText = "'Economy'"
    else if(hot_water_mode == 1) cText = "'Normal'"
    else if(hot_water_mode == 2) cText = "'Luxury'"
    else cText = "'unknoun'"
    SEND_COMMAND dvDevice, "'^TXT-',ITOA(iAddrCode),',0,',cText"
}






(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

AlarmList[1].cAlarmTextDisplay = 'Sensor flt:BT1'
AlarmList[1].cCause = 'No contact with the sensor. (Temperature sensor, Outdoor)'

AlarmList[3].cAlarmTextDisplay = 'Sensor flt:BT3'
AlarmList[3].cCause = 'No contact with the sensor. (Temperature sensor, Heating medium return))'

AlarmList[181].cAlarmTextDisplay = 'Problems at periodic increasing'
AlarmList[181].cCause = 'Periodic hot water in- Only information crease did not reach the stop temperature in 5 hours.'

AlarmList[182].cAlarmTextDisplay = 'Load monitor active'
AlarmList[182].cCause = 'Measured power consumption exceeds set fuse size in menu 5.1.12.'


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

Wait 50 // every 5 sec
{
    local_var volatile Integer i;
    local_var volatile Integer idxGET;
    local_var volatile Integer bData;
    local_var volatile Char    sData[1024];
    local_var volatile Char    sData2[512];
    local_var volatile Char    sData3[512];

    if( VAR_ROOM_TEMPERATURE != 0 and VAR_OUTDOOR_TEMPERATURE != 0 ) // only while valid temperatures
    {
	CURR_HOUR = TIME_TO_HOUR (TIME)	
	IF( CURR_HOUR != LAST_HOUR )
	{
	    LAST_HOUR = CURR_HOUR;
	    Send_String 0,"'1 +++++++++++++++++++ idxIN=',ITOA(idxIN),' idxOUT=',ITOA(idxOUT)";
	    TemperatureArr[idxIN+1].fRoomTemperature = VAR_ROOM_TEMPERATURE; //RANDOM_NUMBER(100);
	    TemperatureArr[idxIN+1].fOutdoorTemperature = VAR_OUTDOOR_TEMPERATURE;
	    TemperatureArr[idxIN+1].tDateMark = LDATE;
	    idxIN = idxIN + 1;
	    idxIN = idxIN & BUF_MASK;	
	    Send_String 0,"'2 +++++++++++++++++++ idxIN=',ITOA(idxIN),' idxOUT=',ITOA(idxOUT)";
	}
	Send_String 0,"'******** CURR_HOUR= ',ITOA(CURR_HOUR),' **************** LAST_HOUR=',ITOA(LAST_HOUR)"
    }
    
    sData = "";
    sData2 = "";
    sData3 = "";
    For (i = 1; i < BUF_SIZE; i++) 
    { 
	idxGET = (idxIN + i - 1) & BUF_MASK + 1;
	Send_String 0, "'idxGET = ', Format('%d ', idxGET)";
	bData = TemperatureArr[idxGET].fRoomTemperature; 
	sData = "sData, Format('%03d ', bData)"; 
	SEND_LEVEL dvPanel, i+10, bData
	
	bData = TemperatureArr[idxGET].fOutdoorTemperature; 
	sData2 = "sData2, Format('%03d ', bData)"; 
	SEND_LEVEL dvPanel, i+50, bData

	bData = TemperatureArr[idxGET].tDateMark; 
	sData3 = "sData3, ' ', bData";
    }
    Send_String 0, "'fRoomTemperature =    ', sData";
    Send_String 0, "'fOutdoorTemperature = ', sData2";
    Send_String 0, "'tDateMark =           ', sData3";
}




(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

