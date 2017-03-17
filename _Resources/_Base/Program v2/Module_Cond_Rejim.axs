MODULE_NAME='Module_Cond_Rejim'
(DEV MVP[], DEV vdvDevice, INTEGER BUTTONS[], sinteger Temprige, sinteger SAVE_TEMPRIJE_UP, sinteger SAVE_TEMPRIJE_DN, CHAR REJIM [] )
                                                                                       


DEFINE_VARIABLE

volatile sinteger TempMaxUP = 250
volatile sinteger TempMinUP = 60

volatile sinteger TempMaxDN = 240
volatile sinteger TempMinDN = 50


volatile LONG TempOFF = 9990


DEFINE_START

IF (SAVE_TEMPRIJE_UP = 0)  {SAVE_TEMPRIJE_UP = 100}
IF (SAVE_TEMPRIJE_DN = 0)  {SAVE_TEMPRIJE_DN = 50}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[MVP]
{ONLINE:
{
   LOCAL_VAR INTEGER NUM_PANEL
  
   WAIT 20
   {
   SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [1]),',0,',itoa(SAVE_TEMPRIJE_UP/10) ,' C'"
   SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [3]),',0,',itoa(SAVE_TEMPRIJE_DN/10) ,' C'"
   }
}}



BUTTON_EVENT [MVP, BUTTONS [1]]
{PUSH:{
IF (SAVE_TEMPRIJE_UP < TempMaxUP)  { 
			    SAVE_TEMPRIJE_UP = SAVE_TEMPRIJE_UP + 10
			    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [1]),',0,',itoa(SAVE_TEMPRIJE_UP/10) ,' C'"
			      }
      }
}

BUTTON_EVENT [MVP, BUTTONS [2]]
{PUSH:{
IF (SAVE_TEMPRIJE_UP > TempMinUP)  
                            {
			    SAVE_TEMPRIJE_UP = SAVE_TEMPRIJE_UP - 10
	                    IF (SAVE_TEMPRIJE_UP <= SAVE_TEMPRIJE_DN)  
                                            {
					    SAVE_TEMPRIJE_DN = SAVE_TEMPRIJE_UP - 10
					    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [3]),',0,',itoa(SAVE_TEMPRIJE_DN/10) ,' C'"
					    }
			    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [1]),',0,',itoa(SAVE_TEMPRIJE_UP/10) ,' C'"
			    } 
      }
}

BUTTON_EVENT [MVP, BUTTONS [3]]
{PUSH:{
IF (SAVE_TEMPRIJE_DN < TempMaxDN)  { 
			    SAVE_TEMPRIJE_DN = SAVE_TEMPRIJE_DN + 10
			    IF (SAVE_TEMPRIJE_DN >= SAVE_TEMPRIJE_UP)  
					    {
					    SAVE_TEMPRIJE_UP = SAVE_TEMPRIJE_DN + 10
			                    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [1]),',0,',itoa(SAVE_TEMPRIJE_UP/10) ,' C'"
					    }
			    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [3]),',0,',itoa(SAVE_TEMPRIJE_DN/10) ,' C'"
			      }
      }
}

BUTTON_EVENT [MVP, BUTTONS [4]]
{PUSH:{
IF (SAVE_TEMPRIJE_DN > TempMinDN)  
                            {
			    SAVE_TEMPRIJE_DN = SAVE_TEMPRIJE_DN - 10
			    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [3]),',0,',itoa(SAVE_TEMPRIJE_DN/10) ,' C'"
			    } 
      }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

wait 100
{
	IF (Temprige != TempOFF) 
	{
	    IF ( temprige > SAVE_TEMPRIJE_UP )         {IF (REJIM != 'COOL') {REJIM = 'COOL' SEND_COMMAND vdvDevice, "'COND_COOL'"}}
	    ELSE {
	            IF ( temprige < SAVE_TEMPRIJE_DN ) {IF (REJIM != 'HEAT') {REJIM = 'HEAT' SEND_COMMAND vdvDevice, "'COND_HEAT'"}}
		 }
	}
}  




(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
