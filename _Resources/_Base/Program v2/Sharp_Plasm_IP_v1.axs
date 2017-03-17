MODULE_NAME='Sharp_Plasm_IP_v1' (DEV MVP[], dev DEVICE, dev vdvDEVICE, CHAR Dev_IP[], integer BUTTONS[], char Command_IP[][])
                                                                                
DEFINE_VARIABLE
VOLATILE Char DEV_COMMAND_BUFFER[455]// Буфер команды
VOLATILE INTEGER DEV_CONNECTED, btnIndex, mvpIndex
VOLATILE INTEGER DEV_srv_Port = 10002


                                                                                
DEFINE_CALL 'DEV_COMMAND' (CHAR STR_COMMAND[300])
{
    DEV_COMMAND_BUFFER="STR_COMMAND, $0D"
    CALL 'OPEN_DEV' 
}

DEFINE_CALL 'OPEN_DEV'
{
    IF (DEV_CONNECTED = 0) 
	IP_CLIENT_OPEN (DEVICE.Port, Dev_IP ,DEV_srv_Port,1)
    ELSE 
	CALL 'DEV_SENDSTRING' ("DEV_COMMAND_BUFFER")
}    

DEFINE_CALL 'DEV_SENDSTRING' (CHAR STR[])
{
    IF (DEV_CONNECTED  = 1) 
    { 
        SET_PULSE_TIME(6) PULSE [MVP[mvpIndex], btnIndex]
	SEND_STRING DEVICE,"STR"
	Wait 10 'IP'  IP_CLIENT_CLOSE (DEVICE.Port)
    }
}
									     
									     
DEFINE_EVENT

DATA_EVENT[DEVICE]          //   ----  событие клиента DEV ----
{ONERROR:{DEV_CONNECTED = 0}
 ONLINE:{DEV_CONNECTED = 1 CALL 'DEV_SENDSTRING' ("DEV_COMMAND_BUFFER")}
 OFFLINE:{DEV_CONNECTED = 0}
 STRING: { } }                    
                                                                             
BUTTON_EVENT[MVP,BUTTONS]
{
	PUSH:
	{
		
		btnIndex = GET_LAST(BUTTONS)
		mvpIndex = GET_LAST(MVP)
		CALL 'DEV_COMMAND' (Command_IP [btnIndex])
	}
	HOLD[3,REPEAT]:
	{
		
		btnIndex = GET_LAST(BUTTONS)
		mvpIndex = GET_LAST(MVP)
		CALL 'DEV_COMMAND' (Command_IP [btnIndex])
	}
}


