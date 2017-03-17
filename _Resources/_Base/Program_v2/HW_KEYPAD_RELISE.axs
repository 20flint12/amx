MODULE_NAME='HW_KEYPAD_RELISE' (DEV vdvHW, DEV dvTP[], INTEGER BUTTONS[], INTEGER DEVICE_OnLine)



DEFINE_VARIABLE
VOLATILE INTEGER LAST_WAIT_STATUS_LED

VOLATILE INTEGER I, A, B, D

DEFINE_FUNCTION ShowStatus( CHAR KEYPAD_STATUS[40])  // 81,9,1<CR>
{
	STACK_VAR CHAR    btnIndex_Char [3]
	STACK_VAR CHAR    btnFunc_Char [3]
	STACK_VAR CHAR    btnStatus_Char [1]
	STACK_VAR INTEGER btnIndex_Int
	
	
	SEND_STRING 0, "'KEYPAD_STATUS =', KEYPAD_STATUS" // 81,9,1<CR>
	btnIndex_Char = REMOVE_STRING(KEYPAD_STATUS,',',1) btnIndex_Char = LEFT_STRING (btnIndex_Char, LENGTH_STRING (btnIndex_Char) -1)  // btnIndex_Char = 81
	btnFunc_Char = REMOVE_STRING(KEYPAD_STATUS,',',1)
	IF (btnFunc_Char = '9,') 
	{
	btnStatus_Char = LEFT_STRING(KEYPAD_STATUS,1)   // btnIndex_Char = 1
        btnIndex_Int = atoi (btnIndex_Char) - 80
	SEND_STRING 0, "'btnIndex_Char =', btnIndex_Char"
	SEND_STRING 0, "'btnStatus_Char =', btnStatus_Char"
	IF (btnStatus_Char = '1') { ON[vdvHW,BUTTONS[btnIndex_Int]] } ELSE { OFF [vdvHW,BUTTONS[btnIndex_Int]] }
	}
}

DEFINE_START

		    FOR (I=1 ; I <= LENGTH_ARRAY (dvTP) ; I++)
                   {
                    FOR (A=1 ; A <= 10 ; A++)
                       {
                    combine_channels (vdvHW, BUTTONS[A], dvTP[I], BUTTONS[A]) // 
                        }
		    }


DEFINE_EVENT

BUTTON_EVENT[vdvHW,BUTTONS]
{
	PUSH:
	{
		STACK_VAR INTEGER btnIndex
		btnIndex = GET_LAST(BUTTONS)
		SEND_COMMAND vdvHW,"'PUSH_BUTTON:',ITOA(btnIndex)"
		SEND_STRING 0,"'PUSH_BUTTON:',ITOA(btnIndex)"
	}
	RELEASE:
	{
		STACK_VAR INTEGER btnIndex
		btnIndex = GET_LAST(BUTTONS)
		
		
		switch(btnIndex)
		{
		CASE 18:
		CASE 19:{SEND_COMMAND vdvHW,"'RELISE_BUTTON:',ITOA(btnIndex)"}
		}
	}
	
}


BUTTON_EVENT[dvTP,BUTTONS[18]]
{
	PUSH:
	{
		SEND_COMMAND vdvHW,"'PUSH_BUTTON:18'"
	}
	RELEASE:
	{
		SEND_COMMAND vdvHW,"'RELISE_BUTTON:18'"
	}
}

BUTTON_EVENT[dvTP,BUTTONS[19]]
{
	PUSH:
	{
		SEND_COMMAND vdvHW,"'PUSH_BUTTON:19'"
	}
	RELEASE:
	{
		SEND_COMMAND vdvHW,"'RELISE_BUTTON:19'"
	}
}


DATA_EVENT[vdvHW]  // KEYPAD_STATUS: 81,9,1<CR>
{
	ONLINE:{
		    LAST_WAIT_STATUS_LED = (DATA.DEVICE.NUMBER - 33200)*10
	}
	STRING:
	{
		LOCAL_VAR VOLATILE CHAR CMD[20]
		CMD = REMOVE_STRING(DATA.Text,':',1)
		SELECT
		{
			ACTIVE(FIND_STRING(CMD,'KEYPAD_STATUS',1)):
			{
				ShowStatus(DATA.TEXT)
			}
			ACTIVE(FIND_STRING(CMD,'KEYPAD_QWETIONS',1)):
			{
			 B = 2
			}
		}
	}
}

DEFINE_PROGRAM

WAIT 20 { 
	IF (B = 2) { B = 1
			WAIT LAST_WAIT_STATUS_LED {   
			SEND_COMMAND vdvHW,"'STATUS_LED:81'" 
			SEND_COMMAND vdvHW,"'STATUS_LED:83'" 
			SEND_COMMAND vdvHW,"'STATUS_LED:85'" 
			SEND_COMMAND vdvHW,"'STATUS_LED:86'" 
			SEND_COMMAND vdvHW,"'STATUS_LED:87'" 
			SEND_COMMAND vdvHW,"'STATUS_LED:88'" 
			SEND_COMMAND vdvHW,"'STATUS_LED:89'" 
			SEND_COMMAND vdvHW,"'STATUS_LED:90'" 
			}
}}


