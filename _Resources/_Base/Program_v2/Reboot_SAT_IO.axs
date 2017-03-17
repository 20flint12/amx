MODULE_NAME='Reboot_SAT_IO'
(DEV IO, DEV MVP[], INTEGER BUTTONS[])
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/04/2006  AT: 11:33:16        *)
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
DEFINE_VARIABLE

VOLATILE INTEGER TIMER_STATUS_ON
VOLATILE INTEGER TIMER_WAIT = 70
VOLATILE SINTEGER SECOND_
VOLATILE INTEGER TIMER_SELECT_


(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT [MVP, BUTTONS]
    {
    PUSH:   {
            TIMER_SELECT_ = TIMER_WAIT  TIMER_STATUS_ON = 1  
	    SEND_COMMAND MVP,"'^TXT-',itoa (BUTTONS[1]),',0,',itoa (TIMER_SELECT_),' sec'" 
	    SET_PULSE_TIME(50) PULSE[IO, 2]  
	    }
    }


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

Wait 2
{
IF ( TIMER_STATUS_ON = 1)
{
IF (SECOND_ != TIME_TO_SECOND ( TIME ))
				    {
				    SECOND_ = TIME_TO_SECOND( TIME )
				    TIMER_SELECT_ = TIMER_SELECT_ - 1
				    SWITCH (TIMER_SELECT_)
				    {
					CASE 0:{TIMER_STATUS_ON = 0 }
				    }
				    SEND_COMMAND MVP,"'^TXT-',itoa (BUTTONS[1]),',0,',itoa (TIMER_SELECT_),' sec'"    
				    }
}
}



wait 2
{
[MVP,BUTTONS[1]] = (TIMER_STATUS_ON = 1)
}                     

