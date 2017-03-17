MODULE_NAME='LUTRON_DIMMER_v2'

                      (DEV LUTRON, 
		       DEV  vdvlevel,
		       DEV dvPanels[],
                       integer leveL_DIMMER[],
		       integer BUTTON_DIMMER_QUesions[],
		       integer BUTTON_STATUS_OFF[],
		       CHAR HW_DIMMERS[][],
		       integer FADE_TIME,
		       integer DELAY_TIME
		       )

define_device




DEFINE_VARIABLE

volatile CHAR LUTRON_BUFFER [1000]
volatile INTEGER A, B, C, D,E
volatile SINTEGER SECOND 
volatile integer TIMER
volatile INTEGER TIMER_Status = 2
volatile INTEGER WAIT_STATUS
volatile INTEGER DIMMER_SWITCH = 1
volatile INTEGER leveL_ONLINE [4] = {1,2,3,4}


DEFINE_CONSTANT


DEFINE_FUNCTION INTEGER GET_KEYPAD_INDEX(CHAR DIMMER_ADR[])
{
	STACK_VAR INTEGER nIndex
	
	for(nIndex = LENGTH_ARRAY(HW_DIMMERS); nIndex > 0; nIndex--)
		if(COMPARE_STRING(HW_DIMMERS[nIndex],DIMMER_ADR))
			return nIndex
	return 0;
}



DEFINE_START

CREATE_BUFFER LUTRON, LUTRON_BUFFER 


SET_VIRTUAL_LEVEL_COUNT (vdvlevel, length_array(HW_DIMMERS)) // make it have 30 levels

FOR  (A = 1 ; A <= (length_array(dvPanels)) ; A++)
FOR  (B = 1 ;  B <= (length_array(HW_DIMMERS)) ; B++)
{
   COMBINE_LEVELS (vdvlevel,B, dvPanels[A],leveL_DIMMER[B])
}

FOR  (C = 1 ; C <= (length_array(dvPanels)) ; C++)
FOR  (D = 1 ;  D <= (length_array(BUTTON_STATUS_OFF)) ; D++)
{
   COMBINE_CHANNELS (vdvlevel,BUTTON_STATUS_OFF[D], dvPanels[C],BUTTON_STATUS_OFF[D])
}



DEFINE_EVENT

(*
LEVEL_EVENT [vdvlevel,leveL_ONLINE]
{
             LOCAL_VAR volatile INTEGER ZoneDIMMER
	     
             ZoneDIMMER = GET_LAST(leveL_ONLINE)
             Send_String LUTRON, "'FADEDIM,',ITOA(Level.Value),',',ITOA(FADE_TIME),',',ITOA(DELAY_TIME),',[',HW_DIMMERS[ZoneDIMMER],']',$0D, $0A"
} 
*)

BUTTON_EVENT [vdvlevel,BUTTON_STATUS_OFF]
{
PUSH:
        {
	    LOCAL_VAR volatile INTEGER ZoneDIMMER
	    
             ZoneDIMMER = GET_LAST(BUTTON_STATUS_OFF)
             Send_String LUTRON, "'FADEDIM,',ITOA(0),',',ITOA(FADE_TIME),',',ITOA(DELAY_TIME),',[',HW_DIMMERS[ZoneDIMMER],']',$0D, $0A"
             Send_String 0, "'FADEDIM,0,',ITOA(FADE_TIME),',',ITOA(DELAY_TIME),',[',HW_DIMMERS[ZoneDIMMER],']',$0D, $0A"
	}
}


BUTTON_EVENT [dvPanels,BUTTON_DIMMER_QUesions]
{
PUSH:
        {
	    LOCAL_VAR volatile INTEGER ZoneDIMMER_OFF
	     
             ZoneDIMMER_OFF = GET_LAST(BUTTON_DIMMER_QUesions)
	     Send_String LUTRON,"'RDL, [',HW_DIMMERS[ZoneDIMMER_OFF],']',$0D, $0A"
	}
}


DATA_EVENT[vdvlevel]

{
	STRING:
	{
		LOCAL_VAR VOLATILE CHAR CMD[100]
		LOCAL_VAR VOLATILE CHAR DIMMER[20]
		LOCAL_VAR VOLATILE INTEGER numDIMMER
		LOCAL_VAR VOLATILE INTEGER levelDIMMER
		
		
		CMD = REMOVE_STRING(DATA.Text,':',1)
		SELECT
		{
			ACTIVE(FIND_STRING(CMD,'DIMMER_STATUS',1)):
			{
				DIMMER = REMOVE_STRING(DATA.TEXT,'],',1)
				DIMMER = LEFT_STRING  (DIMMER,LENGTH_STRING(DIMMER)-2)
				SEND_STRING 0 , "'DIMMER=',DIMMER"
				numDIMMER = GET_KEYPAD_INDEX(DIMMER)
				levelDIMMER = ATOI (DATA.TEXT )* 255/100
				SEND_LEVEL vdvlevel, numDIMMER, levelDIMMER
				IF (ATOI (DATA.TEXT) = 0) {ON[vdvlevel,BUTTON_STATUS_OFF[numDIMMER]]} ELSE {OFF[vdvlevel,BUTTON_STATUS_OFF[numDIMMER]]}
				SEND_STRING 0, "'LEVEL_DIMMER - ',ITOA (numDIMMER),'; LEVEL - ', DATA.TEXT"
			}
		}
	}
}

DEFINE_PROGRAM

