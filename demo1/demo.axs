PROGRAM_NAME='Main_Roma'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)

#INCLUDE 'Channel_port_1'

DEFINE_DEVICE

AVR = 5001:1:1 // Pioneer

IR1 = 5001:5:1 // Panasonic 

SAT1 = 5001:7:1 // Tuner sat

DUNE = 5001:6:1 // Dune1

IPAD1 = 11001:1:1

IPAD2 = 11002:1:1

IPAD3 = 11003:1:1

RELAY1 = 5001:4:1

IO = 5001:9:1

vdvLevel = 33003:1:1 // Виртуальное устройтво

vuplus = 0:1180:1 //lan of 

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV ALL_MVP [3] = {IPAD1, IPAD2, IPAD3}

PERSISTENT INTEGER RELAY_STATUS[4]
PERSISTENT CHAR RUN_START  [15]
PERSISTENT CHAR RUN_FINISH [15]

VOLATILE INTEGER IO_STATUS[4]
VOLATILE INTEGER VALUE_VOLUME

VOLATILE CHAR MUTE [3]
VOLATILE CHAR Buffer_AVR [500]
//VOLATILE CHAR POWER_Pio [3]

VOLATILE INTEGER vuplus_case

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_START

IF (RELAY_STATUS[1] = 1) {ON[RELAY1, 1]}

IF (MUTE ='') {MUTE = 'OFF'}

CREATE_BUFFER  AVR, Buffer_AVR


COMBINE_LEVELS (vdvLevel, 401, ALL_MVP [1], 401, ALL_MVP [2], 401, ALL_MVP [3], 401 )
COMBINE_LEVELS (vdvLevel, 402, ALL_MVP [1], 402, ALL_MVP [2], 402, ALL_MVP [3], 402 )



//IF (POWER_Pio ='') {POWER_Pio = 'OFF'}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(******  Panasonic TV  *****************************)

BUTTON_EVENT [ALL_MVP, BUTTON_PANASONIC] 
{PUSH:{ 
	SET_PULSE_TIME(1) PULSE[IR1,BUTTON.INPUT.CHANNEL - 300]
      } 
HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[IR1,BUTTON.INPUT.CHANNEL - 300]}} //  Control Panasonic 



(******  Sat Tuner  *****************************)

BUTTON_EVENT [ALL_MVP, 101] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,1]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,1]}} //  power         = 1  
BUTTON_EVENT [ALL_MVP, 102] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,2]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,2]}} //  Mute          = 2
BUTTON_EVENT [ALL_MVP, 103] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,3]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,3]}} //  _1            = 3
BUTTON_EVENT [ALL_MVP, 104] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,4]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,4]}} //  _2            = 4
BUTTON_EVENT [ALL_MVP, 105] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,5]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,5]}} //  _3            = 5
BUTTON_EVENT [ALL_MVP, 106] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,6]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,6]}} //  _4            = 6
BUTTON_EVENT [ALL_MVP, 107] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,7]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,7]}} //  _5            = 7
BUTTON_EVENT [ALL_MVP, 108] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,8]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,8]}} //  _6            = 8
BUTTON_EVENT [ALL_MVP, 109] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,9]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,9]}} //  _7            = 9
BUTTON_EVENT [ALL_MVP, 110] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,10]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,10]}} //_8            = 10 
BUTTON_EVENT [ALL_MVP, 111] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,11]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,11]}} //_9            = 11 
BUTTON_EVENT [ALL_MVP, 112] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,12]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,12]}} //_0            = 12 
BUTTON_EVENT [ALL_MVP, 113] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,13]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,13]}} //Vol_UP        = 13 
BUTTON_EVENT [ALL_MVP, 114] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,14]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,14]}} //Vol_DN        = 14 
BUTTON_EVENT [ALL_MVP, 115] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,15]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,15]}} //Menu          = 15 
BUTTON_EVENT [ALL_MVP, 116] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,16]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,16]}} //TV_Portal     = 16 
BUTTON_EVENT [ALL_MVP, 117] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,17]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,17]}} //Play          = 17    
BUTTON_EVENT [ALL_MVP, 118] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,18]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,18]}} //Pause         = 18 
BUTTON_EVENT [ALL_MVP, 119] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,19]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,19]}} //Stop          = 19 
BUTTON_EVENT [ALL_MVP, 120] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,20]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,20]}} //Rac           = 20 
BUTTON_EVENT [ALL_MVP, 121] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,21]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,21]}} //FAST_REVERSE  = 21 
BUTTON_EVENT [ALL_MVP, 122] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,22]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,22]}} //FAST_FORWARD  = 22 
BUTTON_EVENT [ALL_MVP, 123] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,23]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,23]}} //FAST_REVERSE  = 23 
BUTTON_EVENT [ALL_MVP, 124] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,24]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,24]}} //FAST_FORWARD  = 24 
BUTTON_EVENT [ALL_MVP, 125] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,25]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,25]}} //Red           = 25 
BUTTON_EVENT [ALL_MVP, 126] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,26]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,26]}} //Green         = 26 
BUTTON_EVENT [ALL_MVP, 127] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,27]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,27]}} //Yellow        = 27 
BUTTON_EVENT [ALL_MVP, 128] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,28]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,28]}} //Blue          = 28 
BUTTON_EVENT [ALL_MVP, 129] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,29]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,29]}} //Guide         = 29 
BUTTON_EVENT [ALL_MVP, 130] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,30]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,30]}} //Exit          = 30 
BUTTON_EVENT [ALL_MVP, 131] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,31]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,31]}} //UP            = 31 
BUTTON_EVENT [ALL_MVP, 132] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,32]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,32]}} //v             = 32 
BUTTON_EVENT [ALL_MVP, 133] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,33]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,33]}} //REVERSE       = 33    
BUTTON_EVENT [ALL_MVP, 134] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,34]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,34]}} //FORWARD       = 34 
BUTTON_EVENT [ALL_MVP, 135] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,35]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,35]}} //Ok            = 35 
BUTTON_EVENT [ALL_MVP, 136] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,36]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,36]}} //TVRadio       = 36 
BUTTON_EVENT [ALL_MVP, 137] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,37]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,37]}} //Media         = 37 
BUTTON_EVENT [ALL_MVP, 138] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,38]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,38]}} //Back          = 38 
BUTTON_EVENT [ALL_MVP, 139] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,39]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,39]}} //ProgUP        = 39 
BUTTON_EVENT [ALL_MVP, 140] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,40]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,40]}} //ProgDN        = 40 
BUTTON_EVENT [ALL_MVP, 141] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,41]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,41]}} //List          = 41 
BUTTON_EVENT [ALL_MVP, 142] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,42]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,42]}} //info          = 42 
BUTTON_EVENT [ALL_MVP, 143] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,43]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,43]}} //optUP         = 43 
BUTTON_EVENT [ALL_MVP, 144] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,44]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,44]}} //Vol           = 44 
BUTTON_EVENT [ALL_MVP, 145] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,45]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,45]}} //Subtitle      = 45 
BUTTON_EVENT [ALL_MVP, 146] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,46]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,46]}} //TEXT          = 46 
BUTTON_EVENT [ALL_MVP, 147] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,47]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,47]}} //TXTUP         = 47 
BUTTON_EVENT [ALL_MVP, 148] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,48]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,48]}} //Book          = 48 
BUTTON_EVENT [ALL_MVP, 149] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,49]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,49]}} //Sourse        = 49    
BUTTON_EVENT [ALL_MVP, 150] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,50]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,50]}} //Sleep         = 50 
BUTTON_EVENT [ALL_MVP, 151] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,51]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,51]}} //VFormat       = 51    
BUTTON_EVENT [ALL_MVP, 152] {PUSH:{SET_PULSE_TIME(1) PULSE[SAT1,52]} HOLD[2, REPEAT]:{SET_PULSE_TIME(1) PULSE[SAT1,52]}} //Wide          = 52 
                                                                                                                           
////// управление реле

BUTTON_EVENT [ALL_MVP, RELAY_[1]] 
{PUSH:{
ON [relay1,1]    
}} //включаем реле 1 на порту 4

BUTTON_EVENT [ALL_MVP, RELAY_[2]] 
{PUSH:{
OFF [relay1,1]
}} //включаем реле 1 на порту 4

BUTTON_EVENT [ALL_MVP, RELAY_[3]] 
{PUSH:{
IF ( [relay1,1] ) {OFF [relay1,1]} ELSE {ON [relay1,1]}
}} //включаем выключаем реле 1 на порту 4


CHANNEL_EVENT [relay1,1]
{
ON: {RELAY_STATUS[1] = 1}
OFF:{RELAY_STATUS[1] = 0}
}

CHANNEL_EVENT [IO,1]
{
ON: {IO_STATUS[1] = 1 RUN_START = TIME  RUN_finish = ''   SEND_COMMAND ALL_MVP, "'^TXT-71,0,', RUN_START "  SEND_COMMAND ALL_MVP, "'^TXT-72,0,', RUN_finish"  }
OFF:{IO_STATUS[1] = 0 RUN_finish = TIME SEND_COMMAND ALL_MVP, "'^TXT-72,0,', RUN_finish "   }
}                     

DATA_EVENT [ALL_MVP]
    {
	ONLINE:{SEND_COMMAND ALL_MVP, "'^TXT-71,0,', RUN_START " SEND_COMMAND ALL_MVP, "'^TXT-72,0,', RUN_finish "}

    }

//////// управление AVR по RS-232 порту
 

DATA_EVENT [AVR] // после загрузки контролера во всех портах происходит событие ONLINE. 
    {
	ONLINE:{ WAIT 50 { Send_Command AVR, "'SET BAUD 9600,N,8,1'" }}

	STRING:{
	    LOCAL_VAR Char TEXT_INPUT [100]
	    LOCAL_VAR Char TEXT_SEND [10]
	
	    WHILE ( FIND_STRING (Buffer_AVR, "$0D,$0A", 1 ) > 0 )  //Ищем в буфере маркер $0D$0A
		{
		TEXT_INPUT = REMOVE_STRING (Buffer_AVR, "$0D,$0A", 1 ) // FL022020204D555445204F4646202020$0D$0AMUT1$0D$0A
		IF ( LENGTH_STRING (TEXT_INPUT) < 15 )
			{
			SELECT
			    {
			    ACTIVE ( FIND_STRING (TEXT_INPUT, 'VOL', 1 )):
				    {
				    REMOVE_STRING (TEXT_INPUT, 'VOL', 1 )
				    TEXT_SEND = LEFT_STRING (TEXT_INPUT, 3)
				    SEND_COMMAND ALL_MVP, "'^TXT-401,0,', TEXT_SEND "
				    VALUE_VOLUME =  ATOI (TEXT_SEND)
				    SEND_LEVEL vdvLevel, 401, VALUE_VOLUME
				    } 
			    ACTIVE ( FIND_STRING (TEXT_INPUT, 'MUT', 1 )):
				    {
				    REMOVE_STRING (TEXT_INPUT, 'MUT', 1 )
				    TEXT_SEND = LEFT_STRING (TEXT_INPUT, 1)
					SWITCH (TEXT_SEND)
					{
					CASE '0':{ON[ALL_MVP, BUTTON_AVR[9]]} // ON MUTE
					CASE '1':{OFF[ALL_MVP, BUTTON_AVR[9]]} // OFF MUTE
					}
				    } 
			    ACTIVE ( FIND_STRING (TEXT_INPUT, 'PWR', 1 )):
				    {
				    REMOVE_STRING (TEXT_INPUT, 'PWR', 1 )
				    TEXT_SEND = LEFT_STRING (TEXT_INPUT, 1)
					SWITCH (TEXT_SEND)
					{
					CASE '0':{ON[ALL_MVP, BUTTON_AVR[1]] OFF[ALL_MVP, BUTTON_AVR[2]]} // ON POWER
					CASE '1':{OFF[ALL_MVP, BUTTON_AVR[1]] ON[ALL_MVP, BUTTON_AVR[2]]} // OFF POWER
					}
				     }
			    
			    }
		}
	}
    }
}    

// когда пройдет событие онлайн в порту RS-232, выставляем скорость порта 9600

BUTTON_EVENT[ALL_MVP, BUTTON_AVR[1]]{PUSH:{
SEND_STRING AVR, "'PO',$0D(*перевод каретки*)"  
Wait 2 {
SEND_STRING AVR, "'PO',$0D(*перевод каретки*)"
}}} //    вкл.  усилитель           
BUTTON_EVENT[ALL_MVP, BUTTON_AVR[2]]{PUSH:{ SEND_STRING AVR, "'PF',$0D(*перевод каретки*)" }}  //    выкл. усилитель           


// Input

BUTTON_EVENT[ALL_MVP, BUTTON_AVR[3]]{PUSH:{ SEND_STRING AVR, "'25FN',$0D(*перевод каретки*)" }}  //   выбор входа HDMI1         
BUTTON_EVENT[ALL_MVP, BUTTON_AVR[4]]{PUSH:{ SEND_STRING AVR, "'04FN',$0D(*перевод каретки*)" }}  //   выбор входа HDMI2         
BUTTON_EVENT[ALL_MVP, BUTTON_AVR[5]]{PUSH:{ SEND_STRING AVR, "'15FN',$0D(*перевод каретки*)" }}  //   выбор входа HDMI3         

BUTTON_EVENT[ALL_MVP, BUTTON_AVR[6]]
{
    PUSH:{ SEND_STRING AVR, "'VU',$0D(*перевод каретки*)" }  
    HOLD[2, REPEAT]:{ SEND_STRING AVR, "'VU',$0D(*перевод каретки*)" }
}  //   Vol Up         

BUTTON_EVENT[ALL_MVP, BUTTON_AVR[7]]{PUSH:{ SEND_STRING AVR, "'VD',$0D(*перевод каретки*)" }  HOLD[2, REPEAT]:{ SEND_STRING AVR, "'VD',$0D(*перевод каретки*)" }}  //   Vol Dn        


BUTTON_EVENT[ALL_MVP, BUTTON_AVR[9]]{PUSH:{ 
IF (MUTE = 'ON') {SEND_STRING AVR, "'MF',$0D" MUTE = 'OFF'} ELSE {SEND_STRING AVR, "'MO',$0D" MUTE = 'ON'}
}}  //   Mute ON OFF         
                              
BUTTON_EVENT[ALL_MVP, BUTTON_AVR[8]]{PUSH:{ SEND_STRING AVR, "'MZ',$0D(*перевод каретки*)" }}  //   Mute Toggle         

LEVEL_EVENT [vdvLevel, 402]
{
SELECT
    {
    ACTIVE ( LEVEL.VALUE < 10): { SEND_STRING AVR, "'00', Itoa( LEVEL.VALUE) ,'VL',$0D(*перевод каретки*)" }
    ACTIVE ( LEVEL.VALUE < 100):{ SEND_STRING AVR, "'0',  Itoa( LEVEL.VALUE) ,'VL',$0D(*перевод каретки*)" }
    ACTIVE ( LEVEL.VALUE < 200):{ SEND_STRING AVR, "      Itoa( LEVEL.VALUE) ,'VL',$0D(*перевод каретки*)" }
    }
}

BUTTON_EVENT [ALL_MVP, 400]                           //При касании уровня отправляем на устройство текущее значение громкости
{PUSH:{ SEND_LEVEL vdvLevel, 402, VALUE_VOLUME }}

//Макрос для кино

BUTTON_EVENT[ALL_MVP,101]
{PUSH:{ 
    SEND_STRING AVR, "'PO',$0D" wait 5 {SEND_STRING AVR, "'PO',$0D"}  //Включаем ресивер        
    wait 100    {
    SEND_STRING AVR, "'25FN',$0D" //выбирем вход
    VALUE_VOLUME =  50
    SEND_LEVEL vdvLevel, 402, VALUE_VOLUME
     } 
    ON [relay1, 3]
    SET_PULSE_TIME(5) PULSE[SAT1,1]


} } //   выбор входа HDMI1 


CHANNEL_EVENT [IO, 2]   //Вырубаем кинотеатр по сработке сухого контакта 2
{
    ON:{
	    SEND_STRING AVR, "'PF',$0D"
	    OFF [relay1, 3]
	    SET_PULSE_TIME(5) PULSE[SAT1,2]
        }
}

(**********   Control IP  *************************************************)

BUTTON_EVENT[ALL_MVP, BUTTON_vuplus]
{PUSH:{
    vuplus_case = GET_LAST (BUTTON_vuplus)

    IP_CLIENT_OPEN ( vuplus.port, '192.168.1.4', 8080, 1 )
}
}

DATA_EVENT [vuplus]
    {
    ONLINE: {
    
    SWITCH (vuplus_case)
    {
	CASE 1 : { SEND_STRING vuplus, "'PRIVET', $0D" }
	CASE 2 : { SEND_STRING vuplus, "'PING', $0D" }
	CASE 3 : { SEND_STRING vuplus, "'PONG', $0D" }
    }
    IP_CLIENT_CLOSE (vuplus.port)
    
    }
    }
    

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


WAIT 1
{
[ALL_MVP, RELAY_[1]] = [RELAY1,1]
[ALL_MVP, RELAY_[2]] = ![RELAY1,1]
[ALL_MVP, RELAY_[3]] = [RELAY1,1]
[ALL_MVP, IO_[1]]    = (IO_STATUS[1] = 1)
//[ALL_MVP, BUTTON_AVR[9]] = (MUTE = 'ON')
}





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

