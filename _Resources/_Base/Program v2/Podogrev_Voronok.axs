MODULE_NAME='Podogrev_Voronok'
(DEV MVP[], INTEGER BUTTONS[], DEV RELAY, INTEGER NUM_RELAY,  sinteger Temprige, sinteger SAVE_TEMPRIJE_UP, sinteger SAVE_TEMPRIJE_DN  )
                                                                                       


DEFINE_VARIABLE

volatile sinteger TempMaxUP = 50
volatile sinteger TempMinUP = 10

volatile sinteger TempMaxDN = -10
volatile sinteger TempMinDN = -70

volatile LONG TempOFF = 9990


DEFINE_START

IF (SAVE_TEMPRIJE_UP = 0)  {SAVE_TEMPRIJE_UP = 20}
IF (SAVE_TEMPRIJE_DN = 0) {SAVE_TEMPRIJE_DN = -20}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[MVP]
{ONLINE:
{
   LOCAL_VAR INTEGER NUM_PANEL
  
   NUM_PANEL = GET_LAST (MVP)
   WAIT (Num_Relay)
   {
   SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',ITOA (BUTTONS [1]),',0,',itoa(SAVE_TEMPRIJE_UP/10) ,' C'"
   SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',ITOA (BUTTONS [3]),',0,',itoa(SAVE_TEMPRIJE_DN/10) ,' C'"
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
			    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [1]),',0,',itoa(SAVE_TEMPRIJE_UP/10) ,' C'"
			    } 
      }
}

BUTTON_EVENT [MVP, BUTTONS [3]]
{PUSH:{
IF (SAVE_TEMPRIJE_DN < TempMaxDN)  { 
			    SAVE_TEMPRIJE_DN = SAVE_TEMPRIJE_DN + 10
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
	    IF ( temprige > SAVE_TEMPRIJE_UP )         {OFF[RELAY, NUM_RELAY]}
	    ELSE {
	            IF ( temprige < SAVE_TEMPRIJE_DN ) {OFF[RELAY, NUM_RELAY]}
	            ELSE { ON[RELAY, NUM_RELAY] }
		 }
	}
	Else
	{
	if ([RELAY, NUM_RELAY]) {OFF[RELAY, NUM_RELAY]}
	}
}  




(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
