MODULE_NAME='ClimateControl_Vent' 
(DEV MVP[], INTEGER BUTTONS [], DEV vdvTemp, INTEGER NumRelay, INTEGER NumRelayVentil,  
LONG temprige_SAVE, SINTEGER temprige, char temprige_string [10])

#include 'Misc.axi'

DEFINE_VARIABLE

volatile sinteger TempMax = 300
volatile sinteger TempMin = 180
volatile LONG TempOFF = 9990

////  	Авто управление вентилятором
VOLATILE INTEGER VENTIL_TIMER
VOLATILE SINTEGER MINUTE_
VOLATILE INTEGER VENTIL_STATUS
VOLATILE INTEGER VENTIL_AUTO


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
		    {ON[vdvTemp, NumRelay] VENTIL_AUTO = 0 OFF[vdvTemp, NumRelayVentil]} // разность температуры, при которой происходит вкл.сервопривода
	    else
		    {
		    If (temprige <= temprige_SAVE - 4) {OFF[vdvTemp, NumRelay]}  // разность температуры, при которой происходит вкл. сервопривода
		    If (temprige <= temprige_SAVE - 15) {IF (VENTIL_AUTO = 0) {ON[vdvTemp, NumRelayVentil] VENTIL_STATUS = 1 VENTIL_TIMER = 10 MINUTE_ = TIME_TO_MINUTE( TIME ) VENTIL_AUTO = 1  } } // разность температуры, при которой происходит вкл. вентилятора
		    }
	}
}  

Wait 100
{
IF ( VENTIL_AUTO = 1)
{
IF (MINUTE_ != TIME_TO_MINUTE ( TIME ))
				    {
				    MINUTE_ = TIME_TO_MINUTE( TIME )
				    VENTIL_TIMER = VENTIL_TIMER - 1
				    SWITCH (VENTIL_STATUS)
				    {
					CASE 0:{IF ([vdvTemp, NumRelayVentil])  {OFF[vdvTemp, NumRelayVentil]} IF (VENTIL_TIMER = 0) {VENTIL_STATUS = 1 VENTIL_TIMER = 10 ON[vdvTemp, NumRelayVentil]}   } //  Включить Вентилятор
					CASE 1:{IF (![vdvTemp, NumRelayVentil]) {ON[vdvTemp, NumRelayVentil]}  IF (VENTIL_TIMER = 0) {VENTIL_STATUS = 0 VENTIL_TIMER = 5 OFF[vdvTemp, NumRelayVentil]}   } //  Включить Вентилятор
				    }
				    }
}
}


