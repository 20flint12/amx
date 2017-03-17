MODULE_NAME='CoolMaster_COMM' (DEV dvCM, DEV vdvCM[],DEV vdvString, DEV MVP[], INTEGER RAZNICA_DEV_FR_BL )


DEFINE_VARIABLE

volatile CHAR    Buff[2000]
volatile CHAR    Buffer[2000]
volatile CHAR    Buffer_String[2000]
volatile CHAR    Streeng_To_Device [100]
volatile integer NUM_QUETIONS_READ
volatile integer STAT_BLOCK_QUESTION

volatile SINTEGER SECOND 
volatile integer TIMER
volatile INTEGER TIMER_Status = 30
volatile INTEGER WAIT_STATUS

DEFINE_FUNCTION ProcessParsing (CHAR TXT[2000])

{
 LOCAL_VAR volatile INTEGER NUMBER_BL
 
 
while (length_string(txt)<>0)
{

// НОМЕР БЛОКА
NUMBER_BL = RAZNICA_DEV_FR_BL + ATOI (MID_STRING (txt,1,3))

SEND_STRING NUMBER_BL:1:1, "MID_STRING (txt,5,3)"               SEND_STRING 0, "MID_STRING (txt,5,3)" // POWER  
SEND_STRING NUMBER_BL:1:1, "'T:',MID_STRING (txt,9,3)"          SEND_STRING 0, "'T:',MID_STRING (txt,9,3)" // TEMPERATURE
SEND_STRING NUMBER_BL:1:1, "'R:',MID_STRING (txt,13,6)"         SEND_STRING 0, "'R:',MID_STRING (txt,13,6)" // ROOM
SEND_STRING NUMBER_BL:1:1, "MID_STRING (txt,20,4)"              SEND_STRING 0, "MID_STRING (txt,20,4)" // РЕЖИМ
SEND_STRING NUMBER_BL:1:1, "MID_STRING (txt,25,4)"              SEND_STRING 0, "MID_STRING (txt,25,4)" // СКОРОСТЬ
SEND_STRING NUMBER_BL:1:1, "'E:',MID_STRING (txt,30,2)"         SEND_STRING 0, "'E:',MID_STRING (txt,30,2)" // Ошибка                      
                                                                   

IF ( find_string (txt,"$0D,$0A",1) ) {} else return

send_string  0, txt
 remove_string (txt,"$0D,$0A",1)                
}
}

DEFINE_FUNCTION ProcessON     (CHAR num [3])
{
send_string vdvString, "'on 00',num,$0D,$0A"
}
DEFINE_FUNCTION ProcessOFF     (CHAR num [3])
{
send_string vdvString, "'off 00',num,$0D,$0A"
}
DEFINE_FUNCTION ProcessALLON   ()
{
send_string vdvString, "'allon ',$0D,$0A"
}
DEFINE_FUNCTION ProcessALLOFF  () 
{
send_string vdvString, "'alloff ',$0D,$0A"
}



DEFINE_FUNCTION ProcessCOOL     (CHAR num [3])
{
send_string vdvString, "'cool 00',num,$0D,$0A"
}
DEFINE_FUNCTION ProcessDRY     (CHAR num [3])
{
send_string vdvString, "'dry 00',num,$0D,$0A"
}
DEFINE_FUNCTION ProcessHEAT    (CHAR num [3])
{
send_string vdvString, "'heat 00',num,$0D,$0A"
}
DEFINE_FUNCTION ProcessFAN     (CHAR num [3])
{
send_string vdvString, "'fan 00',num,$0D,$0A"
}


DEFINE_FUNCTION ProcessLOW     (CHAR num [3])
{
send_string vdvString, "'fspeed 00',num,' l',$0D,$0A" //
}
DEFINE_FUNCTION ProcessMEDIUM     (CHAR num [3])
{
send_string vdvString, "'fspeed 00',num,' m',$0D,$0A" // 
}
DEFINE_FUNCTION ProcessHIGH     (CHAR num [3])
{
send_string vdvString, "'fspeed 00',num,' h',$0D,$0A" // 
}
DEFINE_FUNCTION ProcessAUTO    (CHAR num [3])
{
send_string vdvString, "'fspeed 00',num,' a',$0D,$0A" // 
}


DEFINE_FUNCTION ProcessTPLUS     (CHAR num [3])
{
send_string vdvString, "'temp 00',num,' +1',$0D,$0A"    // 
}
DEFINE_FUNCTION ProcessTMINUS     (CHAR num [3])
{
send_string vdvString, "'temp 00',num,' -1',$0D,$0A"    // 
}

DEFINE_FUNCTION ProcessTEMIN     (CHAR num [3])
{
send_string vdvString, "'temp 00',num,' 18',$0D,$0A"    // 
}

DEFINE_FUNCTION ProcessTEMAX     (CHAR num [3])
{
send_string vdvString, "'temp 00',num,' 29',$0D,$0A"    // 
}




DEFINE_FUNCTION ProcessVAMauto     (CHAR num [3])
{
send_string vdvString, "'vam 00',num,' a',$0D,$0A" //
}
DEFINE_FUNCTION ProcessVAMlow     (CHAR num [3])
{
send_string vdvString, "'vam 00',num,' l',$0D,$0A" //
}
DEFINE_FUNCTION ProcessVAMLOWr     (CHAR num [3])
{
send_string vdvString, "'vam 00',num,' L',$0D,$0A" //
}
DEFINE_FUNCTION ProcessVAMhigh     (CHAR num [3])
{
send_string vdvString, "'vam 00',num,' h',$0D,$0A" //
}
DEFINE_FUNCTION ProcessVAMHIGHr     (CHAR num [3])
{
send_string vdvString, "'vam 00',num,' H',$0D,$0A" //
}



DEFINE_FUNCTION ProcessSTATNUM     (CHAR num [3])
{
send_string vdvString, "'stat 00',num,$0D,$0A"
}
DEFINE_FUNCTION ProcessSTAT0     ()
{
send_string vdvString, "'stat',$0D,$0A"
}
DEFINE_FUNCTION ProcessSTAT2 ()
{
send_string vdvString, "'stat2',$0D,$0A"
}


DEFINE_START

Create_Buffer vdvString, Buffer_String

buff = ''
TIMER = TIMER_Status


DEFINE_EVENT


DATA_EVENT[MVP]
{
	ONLINE:
	{ProcessSTAT0()	}
}

DATA_EVENT[vdvCM]
{
	ONLINE:
	{
	}
	COMMAND:
	{
		LOCAL_VAR VOLATILE CHAR CMD[32]
		LOCAL_VAR VOLATILE CHAR nCONDITIONER[3]
		
		CMD = DATA.TEXT
		nCONDITIONER = ITOA (data.device.number  - RAZNICA_DEV_FR_BL)
		SEND_STRING 0 , "'fffff', ITOA (data.device.number  - RAZNICA_DEV_FR_BL)"
		
		SELECT
		{
		    ACTIVE(FIND_STRING(CMD,'BLON'  ,1)):{ ProcessON    (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'BLOFF' ,1)):{ ProcessOFF   (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'COOL'  ,1)):{ ProcessCOOL  (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'DRY'   ,1)):{ ProcessDRY   (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'HEAT'  ,1)):{ ProcessHEAT  (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'FAN'   ,1)):{ ProcessFAN   (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'LOW'   ,1)):{ ProcessLOW   (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'MEDIUM',1)):{ ProcessMEDIUM(nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'HIGH'  ,1)):{ ProcessHIGH  (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'AUTOB' ,1)):{ ProcessAUTO  (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'TPLUS' ,1)):{ ProcessTPLUS (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'TMINUS',1)):{ ProcessTMINUS(nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'STAT0' ,1)):{ ProcessSTAT0 () }                                                        
		    ACTIVE(FIND_STRING(CMD,'STAT2' ,1)):{ ProcessSTAT2 () }
		    ACTIVE(FIND_STRING(CMD,'ALLON' ,1)):{ ProcessALLON () ProcessSTAT0()}
		    ACTIVE(FIND_STRING(CMD,'ALLOFF',1)):{ ProcessALLOFF() ProcessSTAT0()}
		    ACTIVE(FIND_STRING(CMD,'STAT3' ,1)):{ ProcessSTATNUM(nCONDITIONER)}                  
		    ACTIVE(FIND_STRING(CMD,'AUTOV'  ,1)):{ ProcessVAMauto (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'VAMLI'  ,1)):{ ProcessVAMLOW  (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'VAMLR'  ,1)):{ ProcessVAMLOWr (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'VAMHI'  ,1)):{ ProcessVAMHIGH (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'VAMHR'  ,1)):{ ProcessVAMHIGHr(nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'TEMAX'  ,1)):{ ProcessTEMAX   (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		    ACTIVE(FIND_STRING(CMD,'TEMIN'  ,1)):{ ProcessTEMIN   (nCONDITIONER) ProcessSTATNUM(nCONDITIONER)}
		}                                                                                              
	}
}

DATA_EVENT[dvCM]
{
	ONLINE:
	{
		WAIT 20 SEND_COMMAND dvCM, "'SET BAUD 9600,N,8,1'"
	}
	STRING:
	{
	    CHAR buff_d [2000]
		
		
	    Buff ="Buff, Data.Text"
		
	    IF (FIND_STRING (Buff,"$0D,$0A,'OK',$0D,$0A",1))
			       {
		                 Buff = REMOVE_STRING (Buff,"$0D,$0A,'OK',$0D,$0A",1)
				 buff_d = LEFT_STRING (buff, LENGTH_STRING(Buff) - 7)
		                 buff   = ''
		                 IF (FIND_STRING (buff_d,'stat',1))
		                                 {
						 REMOVE_STRING (buff_d,"$0D,$0A",1)
						 ProcessParsing (buff_d)	
						 }		
			        }
        }	
}

DEFINE_PROGRAM
(*
IF (SECOND != TIME_TO_SECOND( TIME )) 
{
SECOND = TIME_TO_SECOND( TIME )
TIMER = TIMER - 1
If (TIMER = 0) {ProcessSTAT0() SEND_STRING 0,"'SEND:',itoa(TIMER)" TIMER = TIMER_Status WAIT_STATUS = 1}
If (TIMER = TIMER_Status - 2) { SEND_STRING 0,"'WAIT0:',itoa(TIMER)" WAIT_STATUS = 0}
}
*)
WAIT 2
{IF (Buffer_String <> '')
{
Streeng_To_Device = REMOVE_STRING(Buffer_String, "$0D,$0A",1)
SEND_STRING dvCM, Streeng_To_Device
IF (FIND_STRING (Buffer_String, "$0D,$0A",1) = 0 ) {Buffer_String = ''}
}}


WAIT 30 {
	    ProcessSTATNUM(ITOA (STAT_BLOCK_QUESTION) )
	    IF (STAT_BLOCK_QUESTION < 6) {STAT_BLOCK_QUESTION = STAT_BLOCK_QUESTION + 1 } ELSE {STAT_BLOCK_QUESTION = 0}
	}




