MODULE_NAME='HW_COMM' (DEV dvHW, DEV vdvHW[], CONSTANT CHAR HWAddress[][])

DEFINE_VARIABLE
VOLATILE CHAR HW_BUFFER[2048] = ""
VOLATILE CHAR HW_QUEUE_BUFFER[1024] = ""

VOLATILE INTEGER _BUSY_QUEUE = 0
VOLATILE INTEGER c


DEFINE_FUNCTION INTEGER GET_KEYPAD_INDEX(CHAR KEYPAD_ADR[])
{
	STACK_VAR INTEGER nIndex
	for(nIndex = LENGTH_ARRAY(HWAddress); nIndex > 0; nIndex--)
		if(COMPARE_STRING(HWAddress[nIndex],KEYPAD_ADR))
			return nIndex
	return 0;
}

DEFINE_FUNCTION ProccessMessage(CHAR MESSAGE[])
{
	LOCAL_VAR VOLATILE CHAR CMD[20]
	LOCAL_VAR VOLATILE CHAR KEYPAD[20]
	STACK_VAR INTEGER nKEYPAD
	STACK_VAR INTEGER DIMMER
	
	
	CMD = REMOVE_STRING(MESSAGE,',',1)
	SELECT
	{
		ACTIVE(FIND_STRING(CMD,'KLS',1)):
		{
			KEYPAD = REMOVE_STRING(MESSAGE,'], ',1)
			if(LENGTH_STRING(KEYPAD) > 0)
			{
				Send_String 0, "'Key leds status for ',KEYPAD"
				REMOVE_STRING(KEYPAD,'[',1)
				KEYPAD = LEFT_STRING(KEYPAD, LENGTH_STRING(KEYPAD)-3)
				nKEYPAD = GET_KEYPAD_INDEX(KEYPAD)
				if(nKEYPAD)
					SEND_STRING vdvHW[nKEYPAD], "'KEYPAD_STATUS:',LEFT_STRING(MESSAGE,24)"
			}
		}
		ACTIVE(FIND_STRING(CMD,'DL',1)):
		{
		
			REMOVE_STRING(MESSAGE,'[',1)
			
			if(LENGTH_STRING(MESSAGE) > 0)
			{
				Send_String 0, "'status dimmer ',MESSAGE"
				SEND_STRING vdvHW[LENGTH_ARRAY(vdvHW)], "'DIMMER_STATUS:',MESSAGE"
			}
		}
		
	}
}

DEFINE_FUNCTION ParseHomeWorksMessages()
{
	LOCAL_VAR VOLATILE CHAR Message[100]
	STACK_VAR INTEGER nLen
	
	Message = REMOVE_STRING(HW_BUFFER,"$0D",1)
	nLen = LENGTH_STRING(Message) 
	while(nLen > 0)
	{
		if(nLen > 1)
			ProccessMessage(Message)
		Message = REMOVE_STRING(HW_BUFFER,"$0D",1)
		nLen = LENGTH_STRING(Message) 
	}	
}

DEFINE_FUNCTION AddToHomeWorksQueue(CHAR CMD[50])
{
	HW_QUEUE_BUFFER = "HW_QUEUE_BUFFER , CMD"
}

DEFINE_FUNCTION SendHomeWorksQueue()
{
	LOCAL_VAR VOLATILE CHAR cCmd[50]
	If(!_BUSY_QUEUE && LENGTH_STRING(HW_QUEUE_BUFFER))
	{
		cCmd = Remove_String(HW_QUEUE_BUFFER,"$0D",1)
		Send_String dvHW,"cCmd"
		_BUSY_QUEUE = 1 
		Wait 2
		_BUSY_QUEUE = 0
	}
}

DEFINE_START
CREATE_BUFFER dvHW, HW_BUFFER

Wait 70
{
FOR  (c = 1 ;  c < (length_array(vdvHW)) ; c++)
{AddToHomeWorksQueue("'RKLS,[',HWAddress[C],']',13")}
}


DEFINE_EVENT

DATA_EVENT[vdvHW]
{
	ONLINE:
	{
		(*
		STACK_VAR INTEGER nKEYPAD
		STACK_VAR INTEGER maxKEYPAD
		maxKEYPAD = LENGTH_ARRAY (vdvHW)
		nKEYPAD = GET_LAST(vdvHW)
		IF (maxKEYPAD = nKEYPAD) {} else
		{AddToHomeWorksQueue("'RKLS,[',HWAddress[nKEYPAD],']',13")}
		*)
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
			{
				AddToHomeWorksQueue("'KBP, [',HWAddress[nKEYPAD],'], ',DATA.TEXT,13")
				AddToHomeWorksQueue("'RKLS,[',HWAddress[nKEYPAD],']',13")
			}
		        ACTIVE(FIND_STRING(CMD,'RELISE_BUTTON',1)):
			{
				AddToHomeWorksQueue("'KBR, [',HWAddress[nKEYPAD],'], ',DATA.TEXT,13")
				AddToHomeWorksQueue("'RKLS,[',HWAddress[nKEYPAD],']',13")
			}

		}
	}
}

DATA_EVENT[dvHW]
{
	ONLINE:
	{
		SEND_COMMAND dvHW, "'SET BAUD 9600,N,8,1'"
		wait 8 {SEND_STRING dvHW,"'KLMON',13" wait 8 { SEND_STRING dvHW,"'DLMON',13"}}
	}
	STRING:
	{
		ParseHomeWorksMessages()
	}
}

DEFINE_PROGRAM

wait 1
SendHomeWorksQueue()