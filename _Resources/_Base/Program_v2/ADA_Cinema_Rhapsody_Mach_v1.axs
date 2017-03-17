MODULE_NAME='ADA_Cinema_Rhapsody_Mach_v1'
(DEV DEVICE_CONTROL, DEV vdvVOLUME, DEV MVP[], INTEGER KEYPAD[], INTEGER LEVEL_VAL)

DEFINE_DEVICE


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER B, I

DEFINE_CONSTANT

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)




DEFINE_START

for(B = 1; B <= LENGTH_ARRAY(MVP); B++)
	COMBINE_LEVELS(vdvVOLUME, KEYPAD[1], MVP[B], KEYPAD[1])



(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

                       
BUTTON_EVENT[MVP, KEYPAD[1]]{PUSH:{ SEND_LEVEL vdvVOLUME, KEYPAD[1], 36 WAIT 20 {SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $01, $08, $0C, $FF"}}} // OFF

BUTTON_EVENT[MVP, KEYPAD[3]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $70, $83, $FF" }} // Input 1 
BUTTON_EVENT[MVP, KEYPAD[4]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $71, $84, $FF"}} // Input 2 
BUTTON_EVENT[MVP, KEYPAD[5]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $72, $85, $FF"}} // Input 3 
BUTTON_EVENT[MVP, KEYPAD[6]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $73, $86, $FF"}} // Input 4 
BUTTON_EVENT[MVP, KEYPAD[7]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $74, $87, $FF"}} // Input 5  
BUTTON_EVENT[MVP, KEYPAD[8]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $75, $88, $FF"}} // Input 6  
BUTTON_EVENT[MVP, KEYPAD[9]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $76, $89, $FF"}} // Input 7  
BUTTON_EVENT[MVP,KEYPAD[10]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $77, $8A, $FF"}} // Input 8  
                                                                                                                                           
BUTTON_EVENT[MVP, KEYPAD[12]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $35, $48, $FF"}} //  Discrete Cinema EX/ES	
BUTTON_EVENT[MVP, KEYPAD[13]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $33, $46, $FF"}} //  Discrete Cinema	        
BUTTON_EVENT[MVP, KEYPAD[14]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $13, $27, $3D, $FF"}} //  DTS Neo:6 Movie	        
BUTTON_EVENT[MVP, KEYPAD[15]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $13, $2B, $41, $FF"}} //  DTS Neo:6 Music	        
BUTTON_EVENT[MVP, KEYPAD[16]]{PUSH:{SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $10, $5C, $6F, $FF"}} //  Stereo 5                   
                                                                                              

                      
    	        
 

level_event[vdvVOLUME, KEYPAD[1]]
{
LEVEL_VAL = level.value
SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $11, LEVEL_VAL, $FF"
SEND_STRING DEVICE_CONTROL,"$FF, $03, $00, $12, LEVEL_VAL, $FF"
}

BUTTON_EVENT[MVP, KEYPAD[17]]{PUSH:{ LEVEL_VAL = 0 SEND_LEVEL vdvVOLUME, KEYPAD[1], LEVEL_VAL }} // Выкл. звук
BUTTON_EVENT[MVP, KEYPAD[18]]
    {
    PUSH:{ 
	    IF (LEVEL_VAL >= 180)  {LEVEL_VAL = 180} 
				    else 
		                   {LEVEL_VAL = LEVEL_VAL + 3 SEND_LEVEL vdvVOLUME, KEYPAD[1] , LEVEL_VAL}
    }
    HOLD[4, REPEAT]:{ 
	    IF (LEVEL_VAL >= 180)  {LEVEL_VAL = 180} 
				    else 
		                   {LEVEL_VAL = LEVEL_VAL + 3 SEND_LEVEL vdvVOLUME, KEYPAD[1] , LEVEL_VAL}
    }
    }

BUTTON_EVENT[MVP, KEYPAD[19]]
    {
    PUSH:{ 
	    IF (LEVEL_VAL <= 0)  {LEVEL_VAL = 0} 
				    else 
		                   {LEVEL_VAL = LEVEL_VAL - 3 SEND_LEVEL vdvVOLUME, KEYPAD[1] , LEVEL_VAL}
    }
    HOLD[4, REPEAT]:{ 
	    IF (LEVEL_VAL <= 0)  {LEVEL_VAL = 0} 
				    else 
		                   {LEVEL_VAL = LEVEL_VAL - 3 SEND_LEVEL vdvVOLUME, KEYPAD[1] , LEVEL_VAL}
    }
    }
 
BUTTON_EVENT[MVP, KEYPAD[20]]{PUSH:{ SEND_LEVEL vdvVOLUME, KEYPAD[1], 144}} // 80%
BUTTON_EVENT[MVP, KEYPAD[21]]{PUSH:{ SEND_LEVEL vdvVOLUME, KEYPAD[1], 126}} // 70%
BUTTON_EVENT[MVP, KEYPAD[22]]{PUSH:{ SEND_LEVEL vdvVOLUME, KEYPAD[1], 108}} // 60%
BUTTON_EVENT[MVP, KEYPAD[23]]{PUSH:{ SEND_LEVEL vdvVOLUME, KEYPAD[1], 90}}  // 50%
BUTTON_EVENT[MVP, KEYPAD[24]]{PUSH:{ SEND_LEVEL vdvVOLUME, KEYPAD[1], 63 }} // 35%
BUTTON_EVENT[MVP, KEYPAD[25]]{PUSH:{ SEND_LEVEL vdvVOLUME, KEYPAD[1], 36 }} // 20%
                       
		       
		       
		     
DATA_EVENT[DEVICE_CONTROL]
{
	ONLINE:
	{
	WAIT 50 { Send_Command DEVICE_CONTROL, 'SET BAUD 19200,N,8,1' 
	 SEND_LEVEL vdvVOLUME, KEYPAD[1], 72
	}
}}
  
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


WAIT 2
{
[MVP, KEYPAD[17]] = (LEVEL_VAL = 0)


}
(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
