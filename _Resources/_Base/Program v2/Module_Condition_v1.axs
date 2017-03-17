MODULE_NAME='Module_Condition_v1'
(DEV MVP[], DEV vdvDevice, DEV IR, INTEGER BUTTONS[], INTEGER CASE_BUTTON, CHAR REJIM [], INTEGER PAUSE_CASE, INTEGER PAUSE_START )
                                                                                       
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
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER index

DEFINE_FUNCTION ON_BUTTON (INTEGER BTN)
    {
	OFF [vdvDevice, BUTTONS]
	ON [vdvDevice, BUTTONS[BTN]]
    }

DEFINE_FUNCTION SHOW_BUTTON (CHAR TXT[])
    {
	SWITCH (TXT)
	{
	CASE 'COOL':{
		    SEND_COMMAND MVP, "'^SHO-', itoa(BUTTONS[1]),'.',itoa(BUTTONS[20]),',1'"
		    SEND_COMMAND MVP, "'^SHO-',itoa(BUTTONS[21]),'.',itoa(BUTTONS[40]),',0'"
		    }
	CASE 'HEAT':{
		    SEND_COMMAND MVP, "'^SHO-',itoa(BUTTONS[21]),'.',itoa(BUTTONS[40]),',1'"
		    SEND_COMMAND MVP, "'^SHO-', itoa(BUTTONS[1]),'.',itoa(BUTTONS[20]),',0'"
		    }
	}
    }





DEFINE_START

for(index = 1; index<=LENGTH_ARRAY(BUTTONS); index++)
{
COMBINE_CHANNELS (vdvDevice, BUTTONS[index], MVP[1], BUTTONS[index], MVP[2], BUTTONS[index], MVP[3], BUTTONS[index])  
}
WAIT 300 {IF (PAUSE_CASE = 0) ON_BUTTON(CASE_BUTTON)}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT [vdvDevice, BUTTONS]
{PUSH:{
	CASE_BUTTON = GET_LAST(BUTTONS)
	ON_BUTTON(CASE_BUTTON)
	SET_PULSE_TIME(10) PULSE [IR,CASE_BUTTON]
	PAUSE_CASE = 0
}}


DATA_EVENT[MVP]
{ONLINE:{ SHOW_BUTTON (REJIM)}}

DATA_EVENT [vdvDevice]
{
COMMAND:{
	SWITCH (DATA.TEXT)
		{
		CASE 'COND_COOL':   {
				     SHOW_BUTTON (REJIM)
				     SET_PULSE_TIME(10) PULSE [IR,41]
				     wait 300
				        {
					    SELECT
					    {
					    ACTIVE (CASE_BUTTON <= 20):{SET_PULSE_TIME(10) PULSE [IR,CASE_BUTTON] ON_BUTTON(CASE_BUTTON)}
					    ACTIVE (CASE_BUTTON <= 40):{CASE_BUTTON = CASE_BUTTON - 20 SET_PULSE_TIME(10) PULSE [IR,CASE_BUTTON] ON_BUTTON(CASE_BUTTON)}
					    ACTIVE (CASE_BUTTON  = 41):{}
					    }
				        }
				    }
		CASE 'COND_HEAT':   {
				     SHOW_BUTTON (REJIM)
				     SET_PULSE_TIME(10) PULSE [IR,41] 
				     wait 300
				        {
					    SELECT
					    {
					    ACTIVE (CASE_BUTTON <= 20):{CASE_BUTTON = CASE_BUTTON + 20 SET_PULSE_TIME(10) PULSE [IR,CASE_BUTTON]  ON_BUTTON(CASE_BUTTON)}
					    ACTIVE (CASE_BUTTON <= 40):{SET_PULSE_TIME(10) PULSE [IR,CASE_BUTTON] ON_BUTTON(CASE_BUTTON)}
					    ACTIVE (CASE_BUTTON  = 41):{}
					    }
				        }
				    }
				    
		}
	}

}




(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

WAIT 50 
{
	SWITCH (PAUSE_START)
	{
	    CASE 1: { // Выключить кондиционер
				    PAUSE_CASE = 1 PAUSE_START = 0
				    ON_BUTTON(41)
				    SET_PULSE_TIME(10) PULSE [IR,41]
		    }
	    CASE 2: { // Включить кондиционер
				    PAUSE_CASE = 0 PAUSE_START = 0
				    ON_BUTTON(CASE_BUTTON)
				    SET_PULSE_TIME(10) PULSE [IR,CASE_BUTTON]
		    }
	}


}



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
