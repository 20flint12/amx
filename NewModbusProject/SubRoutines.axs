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
DEFINE_DEVICE



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

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
  //CHAR    MayBeDueTo[500]
}



(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE



_Alarm AlarmList[500] 
/*=
{
   {1, 'uj155426367', 'JOHN', 'DOE', '0.01'},    
   {2, 'gh155426367', 'JOHN', 'DOE', '0.01'}    
}
*/

/*
DEFINE_FUNCTION CHAR[2000] AlarmText(INTEGER iAlarmNo)
{
    STACK_VAR CHAR cTemp[2000]
    STACK_VAR INTEGER nLoop
    
    // Loop the command and escape it
    FOR (nLoop = 1; nLoop <= LENGTH_ARRAY(AlarmList); nLoop++)
    //for (loop = 1; loop <= max_length_array(controllerProperties); loop++)
    {
	Send_String 0,"'######### nLoop= ', ITOA(nLoop)"
    
	// Grab characters and process it based on state machine
	IF( AlarmList[nLoop].iAlarmNo == iAlarmNo )
	{
	    cTemp =  AlarmList[nLoop].cAlarmTextDisplay
	    Send_String 0,"'######### iAlarmNo= ', ITOA(iAlarmNo), ' ****************', cTemp"
	    
	    // cTemp is done
	    RETURN cTemp;
	}    
    }    
    
    RETURN '--- UNKNOUN CODE ---';
}
*/









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

/*
Wait 17
{
    //CHAR TimeStr[ ] = '9:30:08'
    //SINTEGER nMinute
    CURR_MINUTE = TIME_TO_MINUTE (TIME)
    IF( CURR_MINUTE != LAST_MINUTE )
    {
	LAST_MINUTE = CURR_MINUTE;
	TIMER_MINUTES = TIMER_MINUTES + 1
    }
    Send_String 0,"'******** CURR_MINUTE= ',ITOA(CURR_MINUTE),' ****************',ITOA(TIMER_MINUTES)"
}
*/


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

