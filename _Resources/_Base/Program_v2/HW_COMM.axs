MODULE_NAME='HW_COMM' 
(DEV dvHW, DEV vdvHW_STR, DEV vdvHW[], CHAR HWAddress[][], INTEGER DEVICE_OnLine, INTEGER NUM_LED_TO_PANEL[],DEV vdvONLINE_S1)

DEFINE_VARIABLE
VOLATILE CHAR HW_BUFFER[3048] = ""
VOLATILE CHAR vdvBufferString[4048] = ""
volatile INTEGER a = 0, b = 0, c, d, i, f, g, t
VOLATILE INTEGER _BUSY_QUEUE = 0
VOLATILE CHAR DEVICE_IP[] = '192.168.4.3'
VOLATILE INTEGER DEVICE_Port = 23
VOLATILE CHAR CMD_SEND [100]
VOLATILE integer VIRTUAL_PANEL = 2
VOLATILE integer VIRTUAL_PANEL_NUM[2]

(*
Press Keypad | #DEVICE,2,4,3<CR><LF>         | This command (3) presses button  number 1 of a keypad (2) ,,,,, command (43) releases  
Dimmer %     | #OUTPUT,1,1,75,01:30<CR><LF>  | This command sets a dimmer (1) level to 75% with a 1 minute and 30 second fade time  
Monitoring   | #MONITORING,4,1<CR><LF>       | LED Monitoring 3, Zone Level Monitoring 4
GET LED state| ?DEVICE,2,81,9<CR><LF>        | GET LED status 1 Button 9 action

*)






DEFINE_FUNCTION INTEGER GET_KEYPAD_INDEX(CHAR KEYPAD_ADR[])
{
	STACK_VAR INTEGER nIndex
	for(nIndex = LENGTH_ARRAY(HWAddress); nIndex > 0; nIndex--)
		if(COMPARE_STRING(HWAddress[nIndex],KEYPAD_ADR))
			return nIndex
	return 0;
}



DEFINE_FUNCTION ConnectToDEVICE()
{if(DEVICE_OnLine=1){IP_CLIENT_CLOSE(dvHW.Port)DEVICE_OnLine=0 b=0} WAIT 100 'ONLINE' {IP_CLIENT_OPEN(dvHW.Port, DEVICE_IP, DEVICE_Port,1)}}


DEFINE_START
CREATE_BUFFER dvHW, HW_BUFFER
CREATE_BUFFER vdvHW_STR, vdvBufferString

for(i = 1; i <= VIRTUAL_PANEL; i++) 
	{
	VIRTUAL_PANEL_NUM[i] = LENGTH_ARRAY (vdvHW) - VIRTUAL_PANEL + i 
	}


DEFINE_EVENT


DATA_EVENT[vdvHW]
{
	ONLINE:
	{
	}
	COMMAND:
	{
		LOCAL_VAR VOLATILE CHAR CMD[32]
		STACK_VAR INTEGER nKEYPAD
		
		CMD = REMOVE_STRING(DATA.TEXT,':',1)
		nKEYPAD = GET_LAST(vdvHW)
		
		SELECT
		{
			ACTIVE(FIND_STRING(CMD,'PUSH_BUTTON',1)):
			{                               // ,5,1,3<CR><LF>
				SEND_STRING vdvHW_STR,"'#DEVICE,',HWAddress[nKEYPAD],',',DATA.TEXT,',3',$0D, $0A"
			}
		        ACTIVE(FIND_STRING(CMD,'RELISE_BUTTON',1)):
			{
				SEND_STRING vdvHW_STR,"'#DEVICE,',HWAddress[nKEYPAD],',',DATA.TEXT,',4',$0D, $0A"
			}
		        ACTIVE(FIND_STRING(CMD,'STATUS_LED',1)):
			{
				SEND_STRING vdvHW_STR,"'?DEVICE,',HWAddress[nKEYPAD],',',DATA.TEXT,',9',$0D, $0A"
			}

		}
	}
}
DATA_EVENT[dvHW]
{
	ONLINE:{ DEVICE_OnLine=0 } 
	OFFLINE:{DEVICE_OnLine=0 B = 1 cancel_wait 'ONLINE'  IP_CLIENT_CLOSE(dvHW.Port) ConnectToDEVICE()}
	ONERROR:{if(DEVICE_OnLine=1){DEVICE_OnLine=0 B = 1 cancel_wait 'ONLINE' IP_CLIENT_CLOSE(dvHW.Port)} cancel_wait 'ONLINE' ConnectToDEVICE()}
	STRING :{
		//ParseHomeWorksMessages()
		LOCAL_VAR CHAR Masseger [100]
	LOCAL_VAR VOLATILE CHAR MESSAGE_SEND[40]
	LOCAL_VAR VOLATILE CHAR CMD[40]
	LOCAL_VAR VOLATILE CHAR KEYPAD[20]
	LOCAL_VAR VOLATILE CHAR NumBut[20]
	
	STACK_VAR INTEGER nKEYPAD
	STACK_VAR INTEGER DIMMER
		
		SEND_STRING 0 , "'+++',DATA.TEXT"
		IF ( DEVICE_OnLine=0 ) 
		{
		    IF (FIND_STRING (DATA.TEXT,'login:',1) > 0) // 2,81,9,1<CR>
			    { wait 10 { SEND_STRING dvHW,"'AMX',$0D,$0A" SEND_STRING 0,"'AMX',$0D,$0A"}}
			    
		    IF (FIND_STRING (DATA.TEXT,'password:',1) > 0) // 2,81,9,1<CR>
			    {wait 10 { SEND_STRING dvHW,"'AMX',$0D,$0A" SEND_STRING 0,"'AMX',$0D,$0A"
	                     wait 30 { SEND_STRING dvHW,"'#MONITORING,4,1',$0D,$0A" DEVICE_OnLine=1 wait 40 {B = 2}} //  Monitoring Led State Keypad
			    }}
		}
		while (FIND_STRING(HW_BUFFER,"$0D, $0A",1))
		{
		    Masseger = REMOVE_STRING(HW_BUFFER,"$0D, $0A",1)
	
		    IF (FIND_STRING (Masseger,'~DEVICE,',1) > 0) // 2,81,9,1<CR>
			    {
				REMOVE_STRING(Masseger,'~DEVICE,',1)
				KEYPAD = REMOVE_STRING(Masseger,',',1) KEYPAD = LEFT_STRING (KEYPAD, LENGTH_STRING (KEYPAD) -1)  // KEYPAD = 2
				SEND_STRING 0, "'KEYPAD = ', KEYPAD"
				MESSAGE_SEND = Masseger
				REMOVE_STRING(Masseger,',',1)                                                   // MESSAGE = 81,9,1<CR>
				nKEYPAD = GET_KEYPAD_INDEX(KEYPAD)
				SEND_STRING 0, "'nKEYPAD = ',ITOA( nKEYPAD)"
				if(nKEYPAD)
				SEND_STRING vdvHW[nKEYPAD], "'KEYPAD_STATUS:',MESSAGE_SEND"  // KEYPAD_STATUS: 81,9,1<CR>
			    }
			    
		}
		}
}




DEFINE_PROGRAM

if (a=0) {a=1 wait 100 'start'{ IP_CLIENT_OPEN(dvHW.Port, DEVICE_IP, DEVICE_Port,1) }}


WAIT 1
{IF (vdvBufferString <> '' && DEVICE_OnLine = 1)
{
CMD_SEND = REMOVE_STRING(vdvBufferString, "$0D,$0A",1)
SEND_STRING dvHW, CMD_SEND
SEND_STRING 0, CMD_SEND
IF (FIND_STRING (vdvBufferString, "$0D,$0A",1)=0) {vdvBufferString = ''}
}}

wait 2	
    {
	if (B = 2  &&  DEVICE_OnLine = 1)
		{ B = 1
		    wait 20
			    {
			    for(f = 1; f <= LENGTH_ARRAY(vdvHW); f++)
			    SEND_STRING vdvHW[f], "'KEYPAD_QWETIONS:0'"
			    }
		}
    }


