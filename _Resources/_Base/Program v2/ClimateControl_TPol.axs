MODULE_NAME='ClimateControl_TPol' 
(DEV MVP[], INTEGER BUTTONS [], DEV vdvTemp, INTEGER NumRelay, 
LONG temprige_SAVE, SINTEGER temprige, char temprige_string [10])

#include 'Misc.axi'

DEFINE_VARIABLE

volatile sinteger TempMax = 360
volatile sinteger TempMin = 160
volatile LONG TempOFF = 9990

DEFINE_START

IF (temprige_SAVE = 0) 
{
temprige_SAVE = 200 
SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE), 4)"
}  


DEFINE_EVENT

DATA_EVENT[MVP]
{ONLINE:
{

   LOCAL_VAR INTEGER NUM_PANEL
  
   NUM_PANEL = GET_LAST (MVP)
   WAIT (NumRelay)
   {SEND_COMMAND MVP[NUM_PANEL], "'^TXT-',ITOA (BUTTONS [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE), 4)"}
}}

BUTTON_EVENT [MVP, BUTTONS [1]]
{PUSH:{
IF (temprige_SAVE < TempMax)  { 
			    temprige_SAVE = temprige_SAVE + 5
			    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE), 4)"
			      }
      }
}

BUTTON_EVENT [MVP, BUTTONS [2]]
{PUSH:{
IF (temprige_SAVE > TempMin)  
                            {
			    temprige_SAVE = temprige_SAVE - 5
			    SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE), 4)"
			    } 
      }
}


DEFINE_PROGRAM

wait 100
{
	IF (temprige != TempOFF) 
	{
	    If (temprige >= temprige_SAVE + 4) 
		    {ON[vdvTemp, NumRelay] } // разность температуры, при которой происходит вкл.сервопривода
	    else
		    {
		    If (temprige <= temprige_SAVE - 4) {OFF[vdvTemp, NumRelay]}  // разность температуры, при которой происходит вкл. сервопривода
		    }
	}
}  



