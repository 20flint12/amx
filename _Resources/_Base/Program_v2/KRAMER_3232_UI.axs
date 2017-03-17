MODULE_NAME='KRAMER_3232_UI' (DEV vdvDAS, DEV MVP[], INTEGER CHANNELS[],INTEGER VolumeLevel, INTEGER LEVEL_VAL, INTEGER SELECT_SOURSE, INTEGER BASY_SOURSE[])

DEFINE_CONSTANT

DEFINE_VARIABLE
volatile INTEGER nPanel,I,A, F
volatile integer SWITH_PWR, SWITH_SRC, SWITH_DND, SWITH_WHM, SWITH_MUT
volatile INTEGER WAIT_STATUS = 20

DEFINE_FUNCTION SELECT_SOURSE_BASY ()
{
FOR (F=1 ; F<24 ; F++)
{
IF (BASY_SOURSE[F] = VolumeLevel) {  BASY_SOURSE[F] = 0   BREAK    }
}
}



DEFINE_START

SET_VIRTUAL_LEVEL_COUNT(vdvDAS,1)


for(nPanel = 1; nPanel <= LENGTH_ARRAY(MVP); nPanel++)
	COMBINE_LEVELS(vdvDAS, 1, MVP[nPanel], VolumeLevel)

DEFINE_EVENT

DATA_EVENT[vdvDAS]
{
	ONLINE:
	{  Wait 40 {SEND_LEVEL vdvDAS, 1,  LEVEL_VAL}
	}
	STRING:
	{
		CHAR Cmd[30]
		
		Cmd = REMOVE_STRING(Data.Text,':',1)
		if(LENGTH_STRING(Cmd))
		{
			CHAR TEMP[30]
			CHAR Param [5]
			Param = Data.Text
			SELECT
			{
				ACTIVE(FIND_STRING(Cmd,'SOURCE:',1)):
				{
					IF ( FIND_STRING(Param,'-',1)) {SELECT_SOURSE = 0  SELECT_SOURSE_BASY ()    } ELSE 
					{SELECT_SOURSE = ATOI(Param)    
					IF (BASY_SOURSE[SELECT_SOURSE] = 0) {SELECT_SOURSE_BASY ()  BASY_SOURSE[SELECT_SOURSE] = VolumeLevel}
					}
				}
			}
		}
	}
}

BUTTON_EVENT[MVP,CHANNELS]
{PUSH:{
	local_var volatile INTEGER btnIndex
	btnIndex = GET_LAST(CHANNELS)
	switch (btnIndex)
	{		
	        case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
	        case 9:
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
		case 21:
		case 22:
		case 23:
		{
		    IF (btnIndex = 0)
		    {
		    Send_Command vdvDAS,"'SOURCE:',ITOA(btnIndex)"
		    Wait 5{
		    LEVEL_VAL = 45
		      SEND_LEVEL vdvDAS, 1 , LEVEL_VAL
		    }}
		    Send_Command vdvDAS,"'SOURCE:',ITOA(btnIndex)" 
		}
		case 33:
		{
		    IF (btnIndex != 0)
		    {LEVEL_VAL = 45
		      SEND_LEVEL vdvDAS, 1 , LEVEL_VAL
		    }
		    Send_Command vdvDAS,"'SOURCE:-'" 
		}
		case 34:		
		{
		   IF (LEVEL_VAL = 0) {LEVEL_VAL =  48SEND_LEVEL vdvDAS, 1 , LEVEL_VAL} else {LEVEL_VAL = 0 SEND_LEVEL vdvDAS, 1 , LEVEL_VAL}
		}  
		case 35:{Send_Command vdvDAS,"'STATUS'" }
		case 36:{ IF (SELECT_SOURSE != 0) {
		IF (LEVEL_VAL >= 127)  {LEVEL_VAL = 127} else 
		    { {LEVEL_VAL = LEVEL_VAL + 3} }
		      SEND_LEVEL vdvDAS, 1 , LEVEL_VAL
		      }}
		case 37:{ IF (SELECT_SOURSE != 0) {
		IF (LEVEL_VAL <= 0)  {LEVEL_VAL = 0} else {LEVEL_VAL = LEVEL_VAL - 3} }
		      SEND_LEVEL vdvDAS, 1 , LEVEL_VAL
		      }
		case 38:{IF (SELECT_SOURSE != 0) {SEND_LEVEL vdvDAS, 1 , 60}} // 50%
		case 39:{IF (SELECT_SOURSE != 0) {SEND_LEVEL vdvDAS, 1 , 78}} // 65%
		case 40:{IF (SELECT_SOURSE != 0) {SEND_LEVEL vdvDAS, 1 , 96}} // 80%
		case 41:{IF (SELECT_SOURSE != 0) {SEND_LEVEL vdvDAS, 1 , 108}}// 90%
		case 42:{IF (SELECT_SOURSE != 0) {SEND_LEVEL vdvDAS, 1 , 48}} // 40%
		case 43:{IF (SELECT_SOURSE != 0) {SEND_LEVEL vdvDAS, 1 , 81}} // 30%
	}            
    }
HOLD[4,REPEAT]:{
	local_var volatile INTEGER btnIndex
	btnIndex = GET_LAST(CHANNELS)
	switch (btnIndex)
	{		
		case 36:{ IF (SELECT_SOURSE != 0) {
		IF (LEVEL_VAL >= 127)  {LEVEL_VAL = 127} else 
		    { {LEVEL_VAL = LEVEL_VAL + 3} }
		      SEND_LEVEL vdvDAS, 1 , LEVEL_VAL
		      }}
		case 37:{ IF (SELECT_SOURSE != 0) {
		IF (LEVEL_VAL <= 0)  {LEVEL_VAL = 0} else {LEVEL_VAL = LEVEL_VAL - 3} }
		      SEND_LEVEL vdvDAS, 1 , LEVEL_VAL
		      }
	}            
    }

}

LEVEL_EVENT[vdvDAS,1]{LEVEL_VAL = Level.Value}

DEFINE_PROGRAM


WAIT 1 
{
[MVP,CHANNELS[1]] =  (SELECT_SOURSE = 1)
[MVP,CHANNELS[2]] =  (SELECT_SOURSE = 2)
[MVP,CHANNELS[3]] =  (SELECT_SOURSE = 3)
[MVP,CHANNELS[4]] =  (SELECT_SOURSE = 4)
[MVP,CHANNELS[5]] =  (SELECT_SOURSE = 5)
[MVP,CHANNELS[6]] =  (SELECT_SOURSE = 6)
[MVP,CHANNELS[7]] =  (SELECT_SOURSE = 7)
[MVP,CHANNELS[8]] =  (SELECT_SOURSE = 8)
[MVP,CHANNELS[9]] =  (SELECT_SOURSE = 9)
[MVP,CHANNELS[10]] = (SELECT_SOURSE = 10)
[MVP,CHANNELS[11]] = (SELECT_SOURSE = 11)
[MVP,CHANNELS[12]] = (SELECT_SOURSE = 12)
[MVP,CHANNELS[13]] = (SELECT_SOURSE = 13)
[MVP,CHANNELS[14]] = (SELECT_SOURSE = 14)
[MVP,CHANNELS[15]] = (SELECT_SOURSE = 15)
[MVP,CHANNELS[16]] = (SELECT_SOURSE = 16)
[MVP,CHANNELS[17]] = (SELECT_SOURSE = 17)
[MVP,CHANNELS[18]] = (SELECT_SOURSE = 18)
[MVP,CHANNELS[19]] = (SELECT_SOURSE = 19)
[MVP,CHANNELS[20]] = (SELECT_SOURSE = 20)
[MVP,CHANNELS[21]] = (SELECT_SOURSE = 21)
[MVP,CHANNELS[22]] = (SELECT_SOURSE = 22)
[MVP,CHANNELS[23]] = (SELECT_SOURSE = 23)
                                  
[MVP,CHANNELS[33]] = (SELECT_SOURSE = 0)

[MVP,CHANNELS[34]] = (LEVEL_VAL = 0 || LEVEL_VAL = 1)

}           

