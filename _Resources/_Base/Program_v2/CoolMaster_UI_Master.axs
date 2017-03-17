MODULE_NAME='CoolMaster_UI_Master' (DEV vdvCM, DEV MVP[], INTEGER BUTTONS[])

DEFINE_VARIABLE

VOLATILE INTEGER POWER 


DEFINE_EVENT


DATA_EVENT [vdvCM]
{STRING:
        {
	LOCAL_VAR CHAR CMD [50]
	    
	CMD = Data.Text
		
		SELECT
		{
		    ACTIVE(FIND_STRING(CMD,'ON' ,1)):{ON[MVP,BUTTONS[1]] OFF[MVP,BUTTONS[2]] send_string 0, "'ON'" POWER = 1}
		    ACTIVE(FIND_STRING(CMD,'OFF' ,1)):{ON[MVP,BUTTONS[2]] OFF[MVP,BUTTONS[1]] send_string 0, "'OFF'" POWER = 0}
		    ACTIVE(FIND_STRING(CMD,'Cool' ,1)):{
		                                     ON[MVP,BUTTONS[3]] OFF[MVP,BUTTONS[4]] 
						     OFF[MVP,BUTTONS[5]] OFF[MVP,BUTTONS[6]] 
						     if (POWER = 1) {SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[17]),',1,1,0'"} ELSE {SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[17]),',5,5,0'"}
						     }
		    ACTIVE(FIND_STRING(CMD,'Dry' ,1)):{
		                                     ON[MVP,BUTTONS[4]] OFF[MVP,BUTTONS[3]] 
						     OFF[MVP,BUTTONS[5]] OFF[MVP,BUTTONS[6]]
						     if (POWER = 1) {SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[17]),',2,2,0'"} ELSE {SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[17]),',5,5,0'"}
						     }
		    ACTIVE(FIND_STRING(CMD,'Heat' ,1)):{
						     ON[MVP,BUTTONS[5]] OFF[MVP,BUTTONS[4]] 
						     OFF[MVP,BUTTONS[3]] OFF[MVP,BUTTONS[6]]
						     if (POWER = 1) {SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[17]),',3,3,0'"} ELSE {SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[17]),',5,5,0'"}
						     }
		    ACTIVE(FIND_STRING(CMD,'Fan' ,1)):{
		                                     ON[MVP,BUTTONS[6]] OFF[MVP,BUTTONS[3]] 
						     OFF[MVP,BUTTONS[4]] OFF[MVP,BUTTONS[5]]
						     if (POWER = 1) {SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[17]),',4,4,0'"} ELSE {SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[17]),',5,5,0'"}
						     }
		    ACTIVE(FIND_STRING(CMD,'Low' ,1)):{ 
						    ON[MVP,BUTTONS[7]] OFF[MVP,BUTTONS[8]] 
						    OFF[MVP,BUTTONS[9]] OFF[MVP,BUTTONS[10]]
						    SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[18]),',1,1,0'"
		                                     }
		    ACTIVE(FIND_STRING(CMD,'Med' ,1)):{ 
						    ON[MVP,BUTTONS[8]] OFF[MVP,BUTTONS[7]] 
						    OFF[MVP,BUTTONS[9]] OFF[MVP,BUTTONS[10]]
						    SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[18]),',2,2,0'" 
						     }
		    ACTIVE(FIND_STRING(CMD,'High' ,1)):{ 
						    ON[MVP,BUTTONS[9]] OFF[MVP,BUTTONS[8]] 
						    OFF[MVP,BUTTONS[7]] OFF[MVP,BUTTONS[10]]
						    SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[18]),',3,3,0'"
		                                     }
		    ACTIVE(FIND_STRING(CMD,'Auto' ,1)):{ 
						    ON[MVP,BUTTONS[10]] OFF[MVP,BUTTONS[8]] 
						    OFF[MVP,BUTTONS[9]] OFF[MVP,BUTTONS[7]]
						    SEND_COMMAND MVP,"'^ANI-',itoa(BUTTONS[18]),',4,4,0'" 
		                                     }
		    ACTIVE(FIND_STRING(CMD,'T:' ,1)):{REMOVE_STRING (CMD,'T:' ,1) SEND_COMMAND MVP,"'^TXT-',itoa(BUTTONS[19]),',0,',CMD"}
		    ACTIVE(FIND_STRING(CMD,'R:' ,1)):{REMOVE_STRING (CMD,'R:' ,1) SEND_COMMAND MVP,"'^TXT-',itoa(BUTTONS[20]),',0,',CMD"}
		    ACTIVE(FIND_STRING(CMD,'E:' ,1)):{REMOVE_STRING (CMD,'E:' ,1) If (CMD = 'OK'){OFF [MVP,BUTTONS[13]] SEND_COMMAND MVP,"'^TXT-',itoa(BUTTONS[1]),',0,',CMD"} else {ON [MVP,BUTTONS[13]]  SEND_COMMAND MVP,"'^TXT-',itoa(BUTTONS[1]),',0,',CMD"} }
		}
        }
}


BUTTON_EVENT[MVP,BUTTONS]
{PUSH:
{
	local_var volatile INTEGER btnIndex
	
	
	btnIndex = GET_LAST(BUTTONS)
	switch (btnIndex)
	{
		case 1:  {SEND_COMMAND vdvCM,'BLON'  } 
		case 2:  {SEND_COMMAND vdvCM,'BLOFF' }
		case 3:  {SEND_COMMAND vdvCM,'COOL'  }
		case 4:  {SEND_COMMAND vdvCM,'DRY'   }
		case 5:  {SEND_COMMAND vdvCM,'HEAT'  }
		case 6:  {SEND_COMMAND vdvCM,'FAN'   }
		case 7:  {SEND_COMMAND vdvCM,'LOW'   }
		case 8:  {SEND_COMMAND vdvCM,'MEDIUM'}
		case 9:  {SEND_COMMAND vdvCM,'HIGH'  }
		case 10: {SEND_COMMAND vdvCM,'AUTO'  }
		case 11: {SEND_COMMAND vdvCM,'TPLUS' }
		case 12: {SEND_COMMAND vdvCM,'TMINUS'}	
		case 13: {SEND_COMMAND vdvCM,'STAT0' }
		case 14: {SEND_COMMAND vdvCM,'STAT2' }
		case 15: {SEND_COMMAND vdvCM,'ALLON' }
		case 16: {SEND_COMMAND vdvCM,'ALLOFF'}
		case 17: {SEND_COMMAND vdvCM,'STAT3' } // запрос состояния кондиционера
		case 18: {SEND_COMMAND vdvCM,'' }
		case 19: {SEND_COMMAND vdvCM,'' }
		case 20: {SEND_COMMAND vdvCM,'' }
	}                
}                     
}

