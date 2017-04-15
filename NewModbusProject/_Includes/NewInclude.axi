PROGRAM_NAME='NewInclude'

DEFINE_DEVICE


#IF_NOT_DEFINED dvPanel
#WARN 'RMS: This Device Needs to be Defined in your Main Program: dvPanel'
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
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

LEVEL_EVENT [ dvPanel, 8 ]
{
    //IF (LEVEL.VALUE >= COOL_POINT)
    //{
	//ON[RELAY,FAN]
    //}

    Send_String 0,"'******** LEVEL_EVENT= ',ITOA(LEVEL.VALUE),' ****************',ITOA(TIMER_MINUTES)"

}

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









