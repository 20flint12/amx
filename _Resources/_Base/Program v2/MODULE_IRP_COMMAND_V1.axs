MODULE_NAME='MODULE_IRP_COMMAND_V1' (DEV IRPort, DEV MVP[], INTEGER BUTTONS[], INTEGER OFFSET, INTEGER PULSE_TIME)

DEFINE_VARIABLE



DEFINE_EVENT


BUTTON_EVENT [MVP,BUTTONS]    
{
PUSH:   {
         Send_Command IRPort, "'IRP-',ITOA(button.input.channel - OFFSET),',',ITOA(PULSE_TIME),',',ITOA(1)" 
        }
HOLD[4,REPEAT]:{
       Send_Command IRPort, "'IRP-',ITOA(button.input.channel - OFFSET),',',ITOA(PULSE_TIME),',',ITOA(1)"
	}
}


