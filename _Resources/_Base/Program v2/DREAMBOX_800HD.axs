MODULE_NAME='DREAMBOX_800HD' 
(DEV MVP[], dev DreamBox, integer BUTTONS[], integer KEYPAD_BUTTON_CH[], integer KEYPAD_BUTTON_FILE[], 
CHAR IP[], CHAR MasStation[][][], CHAR MasChannel[][][])
                                                                              
(*********************************************************************************)
(*                                 УСТРОЙСТВА                                    *)
(*********************************************************************************)

DEFINE_DEVICE
                                                                             
(*********************************************************************************)
(*                                 ПЕРЕМЕННЫЕ                                    *)
(*********************************************************************************)
DEFINE_VARIABLE

volatile INTEGER COUNT_Zone, COUNT_sourse, COUNT_Zone_, COUNT_sourse_, nPanel, COUNT 
VOLATILE integer Page_1 = 1
integer i 

VOLATILE INTEGER NUMB_CHANNEL_ON_PAGE = 20 // КОЛЛИЧЕСТВО СТРОК НА СТРАНИЦЕ
VOLATILE INTEGER LENTH_PAGE [30] // КОЛЛИЧЕСТВО СТРАНИЦ В ПАПКЕ
VOLATILE INTEGER NUM_FILE = 1 // ТЕКУЩАЯ ПАПКА
VOLATILE INTEGER NUM_PAGE = 1 // ТЕКУЩАЯ СТРАНИЦА
VOLATILE INTEGER NUM_CHANNEL // НОМЕР КАНАЛА
VOLATILE INTEGER PAGE_UP
VOLATILE INTEGER PAGE_DOWN


integer mvp_set
Integer case_channel
integer A,B,C,D,E
                                                                                
(*********************************************************************************)
(*                                   КОД ЗАПУСКА                                 *)
(*********************************************************************************)

DEFINE_FUNCTION ProcessNameStations ( INTEGER FILE, INTEGER PAGE)
{

    local_var volatile integer COUNT_ST
    
    SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [23]),',1'"
    SEND_COMMAND MVP,"'^TXT-',itoa (KEYPAD_BUTTON_CH[23]),',0,',ITOA(PAGE)" 
    SELECT                                                                  
    {                                                                
    ACTIVE(LENTH_PAGE[FILE] = 1):                    {SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [21]),',0'" PAGE_UP=0 SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [22]),',0'" PAGE_DOWN=0}
    ACTIVE(PAGE = 1):                                {SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [21]),',1'" PAGE_UP=1 SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [22]),',0'" PAGE_DOWN=0}
    ACTIVE(LENTH_PAGE[FILE] = PAGE):                 {SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [21]),',0'" PAGE_UP=0 SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [22]),',1'" PAGE_DOWN=1}
    ACTIVE((LENTH_PAGE[FILE] != PAGE)&& (PAGE != 1)):{SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [21]),',1'" PAGE_UP=1 SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [22]),',1'" PAGE_DOWN=1}    
    }  
    
    FOR (COUNT_ST = 1 ; COUNT_ST <= NUMB_CHANNEL_ON_PAGE ; COUNT_ST++)
    {
    IF (LENGTH_STRING(MasStation[FILE][(PAGE - 1) * NUMB_CHANNEL_ON_PAGE + COUNT_ST]) > 0) 
       {
       SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [COUNT_ST]),',1'" 
       SEND_COMMAND MVP,"'^UNI-',itoa (KEYPAD_BUTTON_CH [COUNT_ST]),',0,',MasStation[FILE][(PAGE - 1) * NUMB_CHANNEL_ON_PAGE + COUNT_ST]"
       }
    ELSE
       {
       SEND_COMMAND MVP,"'^SHO-',itoa (KEYPAD_BUTTON_CH [COUNT_ST]),',0'"
       }
    }
}



DEFINE_START

FOR (B = 1 ; B <= LENGTH_ARRAY(MasStation) ; B++)
{  
D = 0
IF (LENGTH_ARRAY(MasStation[B]) <= NUMB_CHANNEL_ON_PAGE) {LENTH_PAGE[B] = 1}
ELSE 
{
C = LENGTH_ARRAY(MasStation[B]) SEND_STRING 0, "'C=',ITOA(C)"
WHILE (C >= NUMB_CHANNEL_ON_PAGE)
{
C = C - NUMB_CHANNEL_ON_PAGE
D = D+1
SEND_STRING 0, "'D=',ITOA(D)"
}
IF (C = 0) { LENTH_PAGE[B] = D} ELSE {IF (C < NUMB_CHANNEL_ON_PAGE) {LENTH_PAGE[B] = D + 1}}

}
SEND_STRING 0, "'LENTH [',ITOA(B),']=',ITOA(LENTH_PAGE[B])"
}

 									  
(*********************************************************************************)
(*                                     СОБЫТИЯ                                   *)
(*********************************************************************************)
DEFINE_EVENT


DATA_EVENT[DreamBox]  
{ 
ONLINE:  { 

if (a = 1)
{
ON[MVP[mvp_set],BUTTONS[case_channel]]
SWITCH(case_channel)
{
//////////////////////////////////////////КНОПКИ ПУЛЬТА///////////////////////////////////////////
case 1:        //Blue 
{send_string DreamBox,"'GET /web/remotecontrol?command=401 HTTP/1.1',13,10,13,10"   }                                                                    
case 2:        //bouquet down              
{send_string DreamBox,"'GET /web/remotecontrol?command=403 HTTP/1.1',13,10,13,10"   }                              
case 3:        //bouquet up                       
{send_string DreamBox,"'GET /web/remotecontrol?command=402 HTTP/1.1',13,10,13,10"   }                              
case 4:        //exit                   
{send_string DreamBox,"'GET /web/remotecontrol?command=174 HTTP/1.1',13,10,13,10"   }                              
case 5:        //up                                      
{send_string DreamBox,"'GET /web/remotecontrol?command=103 HTTP/1.1',13,10,13,10"   }                              
case 6:        //down                                    
{send_string DreamBox,"'GET /web/remotecontrol?command=108 HTTP/1.1',13,10,13,10"   }                              
case 7:        //power                                     
{send_string DreamBox,"'GET /web/remotecontrol?command=116 HTTP/1.1',13,10,13,10"   }                              
case 8:        //0                      
{send_string DreamBox,"'GET /web/remotecontrol?command=11  HTTP/1.1',13,10,13,10"   }                              
case 9:        //1                    
{send_string DreamBox,"'GET /web/remotecontrol?command=2   HTTP/1.1',13,10,13,10"   }                              
case 10:       //2                       
{send_string DreamBox,"'GET /web/remotecontrol?command=3   HTTP/1.1',13,10,13,10"   }                              
case 11:       //3                       
{send_string DreamBox,"'GET /web/remotecontrol?command=4   HTTP/1.1',13,10,13,10"   }                              
case 12:       //4                     
{send_string DreamBox,"'GET /web/remotecontrol?command=5   HTTP/1.1',13,10,13,10"   }                              
case 13:       //5                      
{send_string DreamBox,"'GET /web/remotecontrol?command=6   HTTP/1.1',13,10,13,10"   }                              
case 14:       //6                       
{send_string DreamBox,"'GET /web/remotecontrol?command=7   HTTP/1.1',13,10,13,10"   }                              
case 15:       //7                       
{send_string DreamBox,"'GET /web/remotecontrol?command=8   HTTP/1.1',13,10,13,10"   }                              
case 16:       //8                       
{send_string DreamBox,"'GET /web/remotecontrol?command=9   HTTP/1.1',13,10,13,10"   }                              
case 17:       //9                       
{send_string DreamBox,"'GET /web/remotecontrol?command=10  HTTP/1.1',13,10,13,10"   }                              
case 18:       //previous                       
{send_string DreamBox,"'GET /web/remotecontrol?command=412 HTTP/1.1',13,10,13,10"   }                              
case 19:       //next                     
{send_string DreamBox,"'GET /web/remotecontrol?command=407 HTTP/1.1',13,10,13,10"   }                              
case 20:       //green                      
{send_string DreamBox,"'GET /web/remotecontrol?command=399 HTTP/1.1',13,10,13,10"   }                              
case 21:       // video                      
{send_string DreamBox,"'GET /web/remotecontrol?command=393 HTTP/1.1',13,10,13,10"   }                              
case 22:       //help                    
{send_string DreamBox,"'GET /web/remotecontrol?command=138 HTTP/1.1',13,10,13,10"   }                              
case 23:       //info          
{send_string DreamBox,"'GET /web/remotecontrol?command=358 HTTP/1.1',13,10,13,10"   }                              
case 24:       //menu         
{send_string DreamBox,"'GET /web/remotecontrol?command=139 HTTP/1.1',13,10,13,10"   }                              
case 25:       //left         
{send_string DreamBox,"'GET /web/remotecontrol?command=105 HTTP/1.1',13,10,13,10"   }                              
case 26:       //right          
{send_string DreamBox,"'GET /web/remotecontrol?command=106 HTTP/1.1',13,10,13,10"   }                              
case 27:       //mute                 
{send_string DreamBox,"'GET /web/remotecontrol?command=113 HTTP/1.1',13,10,13,10"   }                              
case 28:       //ok          
{send_string DreamBox,"'GET /web/remotecontrol?command=352 HTTP/1.1',13,10,13,10"   }                              
case 29:       //pvr         
{send_string DreamBox,"'GET /web/remotecontrol?command=366 HTTP/1.1',13,10,13,10"   }                              
case 30:       //pause          
{send_string DreamBox,"'GET /web/remotecontrol?command=103 HTTP/1.1',13,10,13,10"   }                              
case 31:       //play          
{send_string DreamBox,"'GET /web/remotecontrol?command=164 HTTP/1.1',13,10,13,10"   }                              
case 32:       //rec          
{send_string DreamBox,"'GET /web/remotecontrol?command=167 HTTP/1.1',13,10,13,10"   }                              
case 33:       //red          
{send_string DreamBox,"'GET /web/remotecontrol?command=398 HTTP/1.1',13,10,13,10"   }                              
case 34:       //stop          
{send_string DreamBox,"'GET /web/remotecontrol?command=103 HTTP/1.1',13,10,13,10"   }                              
case 35:       //tv           
{send_string DreamBox,"'GET /web/remotecontrol?command=377 HTTP/1.1',13,10,13,10"   }                              
case 36:       //radio         
{send_string DreamBox,"'GET /web/remotecontrol?command=385 HTTP/1.1',13,10,13,10"   }                              
case 37:       //up         
{send_string DreamBox,"'GET /web/remotecontrol?command=103 HTTP/1.1',13,10,13,10"   }                              
case 38:       //vol down         
{send_string DreamBox,"'GET /web/remotecontrol?command=114 HTTP/1.1',13,10,13,10"   }                              
case 39:       //vol up        
{send_string DreamBox,"'GET /web/remotecontrol?command=115 HTTP/1.1',13,10,13,10"   }                              
case 40:       //yellow          
{send_string DreamBox,"'GET /web/remotecontrol?command=400 HTTP/1.1',13,10,13,10"   }
//////////////////////////////////////СЕРВИСНЫЕ КОМАНДЫ///////////////////////////////////////////
case 41:       //Выключение(Standby)                
{send_string DreamBox,"'GET /web/powerstate?newstate=0    HTTP/1.1',13,10,13,10"    }
case 42:       //Глубокое выключение(Deepstandby)                     
{send_string DreamBox,"'GET /web/powerstate?newstate=1    HTTP/1.1',13,10,13,10"    }
case 43:       //Перезагрузка(Reboot)                 
{send_string DreamBox,"'GET /web/powerstate?newstate=2    HTTP/1.1',13,10,13,10"    }
case 44:       //Restart Enigma2                  
{send_string DreamBox,"'GET /web/powerstate?newstate=3    HTTP/1.1',13,10,13,10"    }
case 45:       //Пробуждение  Wake-up                
{send_string DreamBox,"'GET /web/powerstate?newstate=116  HTTP/1.1',13,10,13,10"    }
}}
else 
{
if (i=1)
{
ON[MVP[mvp_set],KEYPAD_BUTTON_CH[case_channel]]
send_string 0, "'PAN=',itoa(mvp_set),' BUT=',itoa(KEYPAD_BUTTON_CH[case_channel])"
send_string DreamBox,"'GET /web/zap?sRef=',MasChannel[NUM_FILE][NUM_CHANNEL],' HTTP/1.1',13,10,13,10"
}
}
IP_CLIENT_CLOSE(DreamBox.Port)
} 
OFFLINE: 
{
Wait 10
{
OFF[MVP[mvp_set],KEYPAD_BUTTON_CH[case_channel]]
OFF[MVP[mvp_set],BUTTONS[case_channel]]
} a=0 i=0
} //IP_CLIENT_CLOSE(DreamBox.Port) ConnectToDevice()
ONERROR: {a=0 i=0} // ConnectToDevice() если подключение выдало ошибку, переподключиться
}

									     
BUTTON_EVENT [MVP,BUTTONS]
{PUSH:{
a=1
mvp_set      = GET_LAST(MVP)
case_channel = GET_LAST(BUTTONS)
IP_CLIENT_OPEN(DreamBox.Port,IP,80,1)
}}

BUTTON_EVENT [MVP,KEYPAD_BUTTON_FILE] 
{PUSH:{
LOCAL_VAR INTEGER NUMB_PANNEL
LOCAL_VAR INTEGER NUMB_BUTTON


NUMB_PANNEL = GET_LAST (NUMB_PANNEL)
NUMB_BUTTON  = GET_LAST (KEYPAD_BUTTON_FILE)
IF (![MVP,KEYPAD_BUTTON_FILE[NUMB_BUTTON]])
{
NUM_FILE  =  NUMB_BUTTON  
NUM_PAGE  = 1
ProcessNameStations(NUM_FILE, NUM_PAGE)
}
}}


BUTTON_EVENT [MVP,KEYPAD_BUTTON_CH] 
{PUSH:{
LOCAL_VAR INTEGER NUMB_PANNEL
LOCAL_VAR INTEGER NUMB_BUTTON

NUMB_PANNEL = GET_LAST (MVP)
NUMB_BUTTON = GET_LAST (KEYPAD_BUTTON_CH)
mvp_set = NUMB_PANNEL
case_channel = GET_LAST (KEYPAD_BUTTON_CH)
 SWITCH (NUMB_BUTTON)
 {
      CASE 1:
      CASE 2:
      CASE 3:
      CASE 4:
      CASE 5:
      CASE 6:
      CASE 7:
      CASE 8:
      CASE 9:
      CASE 10:
      CASE 11:
      CASE 12:
      CASE 13:
      CASE 14:
      CASE 15:
      CASE 16:
      CASE 17:
      CASE 18:
      CASE 19:
      CASE 20:
	    {
		    NUM_CHANNEL = (NUM_PAGE - 1) * NUMB_CHANNEL_ON_PAGE + NUMB_BUTTON   //
		    i=1
                    IP_CLIENT_OPEN(DreamBox.Port,IP,80,1)
		   }
      CASE 21: {IF (NUM_PAGE <  LENTH_PAGE[NUM_FILE]) {NUM_PAGE = NUM_PAGE + 1  ProcessNameStations(NUM_FILE, NUM_PAGE)}} //  Страница Вперед
      CASE 22: {IF (NUM_PAGE > 1)                     {NUM_PAGE = NUM_PAGE - 1  ProcessNameStations(NUM_FILE, NUM_PAGE)}} //  Страница Назад       
      CASE 23:  
             {
	      ProcessNameStations(NUM_FILE, NUM_PAGE)
	     }
      CASE 24: {IF (PAGE_UP   = 1) {NUM_PAGE = NUM_PAGE + 1  ProcessNameStations(NUM_FILE, NUM_PAGE)}} //  Страница Вперед
      CASE 25: {IF (PAGE_DOWN = 1) {NUM_PAGE = NUM_PAGE - 1  ProcessNameStations(NUM_FILE, NUM_PAGE)}} //  Страница Назад       

 }
}}        

DATA_EVENT[MVP]
{
ONLINE:
{
   LOCAL_VAR INTEGER NUMB_PANNEL

   NUMB_PANNEL = GET_LAST (MVP)
    WAIT (10)
    {ProcessNameStations(NUM_FILE, NUM_PAGE)}
}}



                                                                             
(*********************************************************************************)
(*                                 ФАКТИЧЕСКАЯ ПРОГРАММА                         *)
(*********************************************************************************)
DEFINE_PROGRAM


WAIT 2
{
FOR (E = 1 ; E <= LENGTH_ARRAY(KEYPAD_BUTTON_FILE) ; E++)
{[MVP,KEYPAD_BUTTON_FILE[E]] = (NUM_FILE = E)}
}

                                                                             
(*********************************************************************************)
(*                                   ЗАВЕРШЕНИЕ ПРОГРАММЫ                        *)
(*                                                                               *)
(*********************************************************************************)