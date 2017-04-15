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


#IF_NOT_DEFINED dvPanel
    //#WARN 'RMS: This Device Needs to be Defined in your Main Program: dvPanel'
#END_IF



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE



SINTEGER CURR_MINUTE
SINTEGER LAST_MINUTE
INTEGER TIMER_MINUTES





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

DEFINE_FUNCTION ButtonText(DEV dvDevice, INTEGER nButton, CHAR cText[])
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

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


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



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

