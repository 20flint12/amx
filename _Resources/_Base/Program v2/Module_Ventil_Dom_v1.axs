MODULE_NAME='Module_Ventil_Dom_v1'
(DEV MVP[], INTEGER BUTTONS[], DEV RELAY, INTEGER NUM_RELAY, DEV IO, INTEGER NUM_IO,  
sinteger Temprige, CHAR SAVE_REJIM_VENT[4],  sinteger SAVE_TEMPRIJE_DN)
                                                                                       


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

volatile INTEGER VENTIL_ALARM

volatile sinteger TempMaxDN = 400
volatile sinteger TempMinDN = -400

volatile sinteger     TempOFF   = 9990
////  	Авто управление вентилятором
VOLATILE INTEGER VENTIL_TIMER
VOLATILE SINTEGER MINUTE_
VOLATILE INTEGER VENTIL_STATUS
VOLATILE INTEGER VENTIL_AUTO

DEFINE_FUNCTION ON_VENTIL ()
{
CANCEL_WAIT 'RELAY_2'
IF (![IO, NUM_IO]) {SET_PULSE_TIME (20) PULSE [RELAY, NUM_RELAY] 
	WAIT 600 'RELAY_2' { IF (![IO, NUM_IO]) {SET_PULSE_TIME (20) PULSE [RELAY, NUM_RELAY] 
		WAIT 600 'RELAY_2' { IF (![IO, NUM_IO]) {SET_PULSE_TIME (20) PULSE [RELAY, NUM_RELAY] 
			WAIT 300 'RELAY_2' { IF (![IO, NUM_IO]) {VENTIL_ALARM = 1}}
			}}}}}
}

DEFINE_FUNCTION OFF_VENTIL ()
{

CANCEL_WAIT 'RELAY_2'
IF ([IO, NUM_IO]) {
SET_PULSE_TIME (20) PULSE [RELAY, NUM_RELAY] 
}
}


(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_START

IF (SAVE_REJIM_VENT = '') {SAVE_REJIM_VENT = 'OFF'}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


CHANNEL_EVENT [IO, NUM_IO]
{
ON: {CANCEL_WAIT 'RELAY_2' VENTIL_ALARM = 0}
OFF:{CANCEL_WAIT 'RELAY_2'}
}

BUTTON_EVENT [MVP, BUTTONS[1]] // Включить вентил
{PUSH:{SAVE_REJIM_VENT = 'ON' VENTIL_AUTO = 0 CANCEL_WAIT 'RELAY_2' ON_VENTIL()}}

BUTTON_EVENT [MVP, BUTTONS[2]] // Выключить вентил
{PUSH:{SAVE_REJIM_VENT = 'OFF' CANCEL_WAIT 'RELAY_2' OFF_VENTIL() VENTIL_AUTO = 0}}

BUTTON_EVENT [MVP, BUTTONS[7]] // Включить вентил на авто
{PUSH:{ SAVE_REJIM_VENT = 'AUTO' CANCEL_WAIT 'RELAY_2'  VENTIL_AUTO = 0}}

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

DATA_EVENT[MVP]
{ONLINE:
{
   LOCAL_VAR INTEGER NUM_PANEL
  
   NUM_PANEL = GET_LAST (MVP)
   WAIT (Num_Relay)
   {
   SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',ITOA (BUTTONS [3]),',0,',itoa(SAVE_TEMPRIJE_DN/10) ,' C'"
   }
}}



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


wait 1800
{
    
    SWITCH (SAVE_REJIM_VENT)
    {
	CASE 'ON'  :{ IF (![IO, NUM_IO] && VENTIL_ALARM = 0) ON_VENTIL() }
	CASE 'OFF' :{ IF ([IO, NUM_IO]) OFF_VENTIL()}
	CASE 'AUTO':
		{  
		SELECT
		    {
		    ACTIVE (Temprige =  TempOFF):{IF ([IO, NUM_IO]) OFF_VENTIL() VENTIL_AUTO = 0}
		    ACTIVE (Temprige >=  SAVE_TEMPRIJE_DN)    :   {VENTIL_AUTO = 0 IF (![IO, NUM_IO] && VENTIL_ALARM = 0) ON_VENTIL()}
		    ACTIVE (Temprige <   SAVE_TEMPRIJE_DN - 5):   {IF (VENTIL_AUTO = 0) {VENTIL_STATUS = 1 VENTIL_TIMER = 10 MINUTE_ = TIME_TO_MINUTE( TIME ) VENTIL_AUTO = 1 ON_VENTIL()} }
		    }
		}
    }
}  


Wait 100
{
IF ( VENTIL_AUTO = 1)
{
IF (MINUTE_ != TIME_TO_MINUTE ( TIME ))
				    {
				    MINUTE_ = TIME_TO_MINUTE( TIME )
				    VENTIL_TIMER = VENTIL_TIMER - 1
				    IF (VENTIL_TIMER = 0) 
				    {
					SWITCH (VENTIL_STATUS)
					{
					    CASE 0:{ IF (![IO, NUM_IO] && VENTIL_ALARM = 0) ON_VENTIL() VENTIL_STATUS = 1 VENTIL_TIMER = 15 MINUTE_ = TIME_TO_MINUTE( TIME ) } //  Включить Вентилятор
					    CASE 1:{ IF ([IO, NUM_IO]) OFF_VENTIL()                     VENTIL_STATUS = 0 VENTIL_TIMER = 15 MINUTE_ = TIME_TO_MINUTE( TIME ) } //  Выключить Вентилятор
					}
				    }}
}
}





WAIT 2
{
[MVP, BUTTONS[1]] = (SAVE_REJIM_VENT = 'ON')
[MVP, BUTTONS[2]] = (SAVE_REJIM_VENT = 'OFF')
[MVP, BUTTONS[5]] = [IO, NUM_IO]
[MVP, BUTTONS[6]] = (VENTIL_ALARM = 1)
[MVP, BUTTONS[7]] = (SAVE_REJIM_VENT = 'AUTO')
}






(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
