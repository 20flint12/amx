MODULE_NAME='Energetika_Generator'
(DEV MVP[], INTEGER BUTTONS[], DEV RELAY, DEV IO, CHAR WorkTime[], CHAR WorkData[], INTEGER _TIMER_ON, CHAR _TIMER_TIME[], INTEGER _TIMER_DAY, INTEGER _SELECT_DAY, SINTEGER DAY_,INTEGER _LAST_STATE_GENERATOR )
                                                                                       


DEFINE_TYPE

STRUCTURE TIMER
{
INTEGER ONOFF
char HOURS [2]
char MINUTE [2]
}



                                             
DEFINE_VARIABLE
                        

VOLATILE INTEGER IO_1 = 1 // Генератор заведен/заглушен
VOLATILE INTEGER IO_2 = 2 // 
VOLATILE INTEGER IO_3 = 3 // Разрешение на команду Авто  2 раза через 10 сек
VOLATILE INTEGER IO_4 = 4 // Разрешение на команду Сброс 2 раза через 10 сек
VOLATILE INTEGER IO_5 = 5 // Нет основного ввода
VOLATILE INTEGER IO_6 = 6 // Уровень бака                                      
VOLATILE INTEGER IO_7 = 7 // Калитка
VOLATILE INTEGER IO_8 = 8 // Сигнализация                                                         

VOLATILE INTEGER RELAY_1 = 91 // Старт
VOLATILE INTEGER RELAY_2 = 92 // Ручной
VOLATILE INTEGER RELAY_3 = 93 // Авто
VOLATILE INTEGER RELAY_4 = 94 // Сброс               
                                
VOLATILE TIMER SAVE_TIMERS

VOLATILE INTEGER CHANGE_ONOFF
VOLATILE CHAR CHANGE_HOURS[2]
VOLATILE CHAR CHANGE_MINUTE[2]


VOLATILE INTEGER SHOW_HOURSMINUTE
VOLATILE INTEGER INTEGER_HOURSMINUTE





DEFINE_START

IF (_TIMER_TIME = '') {_TIMER_TIME = '00:00:00'}

SAVE_TIMERS.HOURS = FORMAT('%02d',TIME_TO_HOUR (_TIMER_TIME))
SAVE_TIMERS.MINUTE = FORMAT('%02d',TIME_TO_MINUTE (_TIMER_TIME)) 

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(*+++++    генератор    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
// Реле генератора
BUTTON_EVENT [MVP, BUTTONS[ 8]] {PUSH:{ SET_PULSE_TIME (10) PULSE[RELAY, RELAY_1]}}  // Старт
BUTTON_EVENT [MVP, BUTTONS[ 9]] {PUSH:{ SET_PULSE_TIME (10) PULSE[RELAY, RELAY_2]}}  // Ручной
BUTTON_EVENT [MVP, BUTTONS[10]] {PUSH:{ SET_PULSE_TIME (10) PULSE[RELAY, RELAY_3]}}  // Авто
BUTTON_EVENT [MVP, BUTTONS[11]] {PUSH:{ SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4]}}  // Сброс     
                                                                        
CHANNEL_EVENT [IO, IO_1] // Запись последнего включения
{
ON:{  

WorkTime = LEFT_STRING (TIME, 5)
WorkData = "itoa(DATE_TO_DAY(LDATE)),'.',itoa(DATE_TO_MONTH(LDATE)),'.',itoa(DATE_TO_YEAR(LDATE))"
SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS[28]),',0,',WorkTime" // Время
SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS[29]),',0,',WorkData" // Дата

_SELECT_DAY = _TIMER_DAY
DAY_ = day_of_week( DATE )
}
OFF:{
_SELECT_DAY = _TIMER_DAY
DAY_ = day_of_week( DATE )
}
}

CHANNEL_EVENT [IO, IO_3] {ON:{ 
SET_PULSE_TIME (10) PULSE[RELAY, RELAY_3] WAIT 120 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_3]}
WAIT 1800 {
IF (![IO, IO_1]) 
{
SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4] 
WAIT 120 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4]}
WAIT 240 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_3]} 
WAIT 360 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_3]}
}
}}} // Разрешение на команду Авто  2 раза через 10 сек

CHANNEL_EVENT [IO, IO_4] {ON:{ SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4] WAIT 120 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4]}}} // Разрешение на команду Сброс 2 раза через 10 сек



DATA_EVENT [IO]
{
ONLINE:{ 
IF ([IO, IO_1] && [IO, IO_4]) {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4] WAIT 120 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4]}}
ELSE {
IF (![IO, IO_1] && [IO, IO_3]) {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_3] WAIT 120 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_3]}}
} 
}}


(*+++++    таймер генератора    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)

DATA_EVENT [MVP]
{ONLINE:{
SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS[28]),',0,',WorkTime" // Время
SEND_COMMAND MVP,"'^TXT-',ITOA (BUTTONS[29]),',0,',WorkData" // Дата
SEND_COMMAND MVP,"'^TXT-',itoa(BUTTONS[15]),',0,',SAVE_TIMERS.HOURS"                                 
SEND_COMMAND MVP,"'^TXT-',itoa(BUTTONS[18]),',0,',SAVE_TIMERS.MINUTE"    

}}

BUTTON_EVENT [MVP,BUTTONS[12]] // отобразить состояние
{PUSH:                           
    {   
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    CHANGE_HOURS  = SAVE_TIMERS.HOURS
    CHANGE_MINUTE = SAVE_TIMERS.MINUTE
    SHOW_HOURSMINUTE = 0
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW0'"                 
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[14]),',0,%SW0'"                 
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[16]),',0,%SW0'"                 
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[17]),',0,%SW0'"                 
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[19]),',0,%SW0'"                 
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"                                
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"                             
}}                                                                                 
                                 
BUTTON_EVENT [MVP,BUTTONS[13]]  // сохранить
{PUSH:                           
    {  
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (LENGTH_STRING(CHANGE_HOURS)=1) SAVE_TIMERS.HOURS="'0',CHANGE_HOURS" ELSE SAVE_TIMERS.HOURS=CHANGE_HOURS  
    IF (LENGTH_STRING(CHANGE_MINUTE)=1) SAVE_TIMERS.MINUTE="'0',CHANGE_MINUTE" ELSE SAVE_TIMERS.MINUTE=CHANGE_MINUTE  
    SHOW_HOURSMINUTE = 0
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[14]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[16]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[17]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[19]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',SAVE_TIMERS.HOURS"                                 
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',SAVE_TIMERS.MINUTE"    
    _TIMER_TIME = "SAVE_TIMERS.HOURS,':',SAVE_TIMERS.MINUTE,':','00'"
    _SELECT_DAY = _TIMER_DAY
    DAY_ = day_of_week( DATE )
}}                               
                                 
BUTTON_EVENT [MVP,BUTTONS[14]] // час +
{PUSH:                           
    {  
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (INTEGER_HOURSMINUTE >= 23) 
    {
    INTEGER_HOURSMINUTE = 0 
    CHANGE_HOURS = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"
    }
    else
    {
    INTEGER_HOURSMINUTE = INTEGER_HOURSMINUTE + 1
    CHANGE_HOURS = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"
    }} 
HOLD [3,REPEAT]:
    { 
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (INTEGER_HOURSMINUTE >= 23) 
    {
    INTEGER_HOURSMINUTE = 0 
    CHANGE_HOURS = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"
    }
    else
    {
    INTEGER_HOURSMINUTE = INTEGER_HOURSMINUTE + 1
    CHANGE_HOURS = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"
    }
}}                             
                                 
BUTTON_EVENT [MVP,BUTTONS[15]]  // включить часы
{PUSH:                           
    {
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    INTEGER_HOURSMINUTE  =  atoi( CHANGE_HOURS)
    SHOW_HOURSMINUTE = 1
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[14]),',0,%SW1'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[16]),',0,%SW1'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[17]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[19]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"  
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
    
}}                               
                                 
BUTTON_EVENT [MVP,BUTTONS[16]] // час - 
{PUSH:                           
    {     
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (INTEGER_HOURSMINUTE < 1) 
    {
    INTEGER_HOURSMINUTE = 23 
    CHANGE_HOURS = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"
    }
    else
    {
    INTEGER_HOURSMINUTE = INTEGER_HOURSMINUTE - 1
    CHANGE_HOURS = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"
    }}
HOLD [3,REPEAT]:
    { 
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (INTEGER_HOURSMINUTE < 1) 
    {
    INTEGER_HOURSMINUTE = 23 
    CHANGE_HOURS = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"
    }
    else
    {
    INTEGER_HOURSMINUTE = INTEGER_HOURSMINUTE - 1
    CHANGE_HOURS = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[15]),',0,',CHANGE_HOURS"
    }
}}                               
                                 
BUTTON_EVENT [MVP,BUTTONS[17]] // минуты +
{PUSH:                        
    {
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (INTEGER_HOURSMINUTE >= 59) 
    {
    INTEGER_HOURSMINUTE = 0 
    CHANGE_MINUTE = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"
    }
    else
    {
    INTEGER_HOURSMINUTE = INTEGER_HOURSMINUTE + 1
    CHANGE_MINUTE = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"
    }}
HOLD [3,REPEAT]:
    {
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (INTEGER_HOURSMINUTE >= 59) 
    {
    INTEGER_HOURSMINUTE = 0 
    CHANGE_MINUTE = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"
    }
    else
    {
    INTEGER_HOURSMINUTE = INTEGER_HOURSMINUTE + 1
    CHANGE_MINUTE = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"
    }
}}

BUTTON_EVENT [MVP,BUTTONS[18]] // включить минуты
{PUSH:                        
    {
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    INTEGER_HOURSMINUTE  =  atoi( CHANGE_MINUTE)
    SHOW_HOURSMINUTE = 2
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[14]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[16]),',0,%SW0'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[17]),',0,%SW1'"
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[19]),',0,%SW1'"
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"  
    SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
}}

BUTTON_EVENT [MVP,BUTTONS[19]] // минуты -
{PUSH:                        
    {
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (INTEGER_HOURSMINUTE = 0) 
    {
    INTEGER_HOURSMINUTE = 59 
    CHANGE_MINUTE = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"
    }
    else
    {
    INTEGER_HOURSMINUTE = INTEGER_HOURSMINUTE - 1
    CHANGE_MINUTE = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"
    }}
HOLD [3,REPEAT]:
    {
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)
    IF (INTEGER_HOURSMINUTE = 0) 
    {
    INTEGER_HOURSMINUTE = 59 
    CHANGE_MINUTE = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"
    }
    else
    {
    INTEGER_HOURSMINUTE = INTEGER_HOURSMINUTE - 1
    CHANGE_MINUTE = itoa(INTEGER_HOURSMINUTE)
    SEND_COMMAND MVP[NUM_PANEL],"'^TXT-',itoa(BUTTONS[18]),',0,',CHANGE_MINUTE"
    }
}}

BUTTON_EVENT [MVP,BUTTONS[20]] // Вкл. режим
{PUSH:{
_TIMER_ON = 1
}}

BUTTON_EVENT [MVP,BUTTONS[21]] // Выкл. режим
{PUSH:{
_TIMER_ON = 0
}}


BUTTON_EVENT [MVP,BUTTONS[22]] // 1 день
{PUSH:{
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)

_TIMER_DAY = 1
SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
}}           
BUTTON_EVENT [MVP,BUTTONS[23]] // 2 день
{PUSH:{
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)

_TIMER_DAY = 2
SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
}}           
BUTTON_EVENT [MVP,BUTTONS[24]] // 3 день
{PUSH:{
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)

_TIMER_DAY = 3
SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
}}           
BUTTON_EVENT [MVP,BUTTONS[25]] // 4 день
{PUSH:{
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)

_TIMER_DAY = 4
SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
}}           
BUTTON_EVENT [MVP,BUTTONS[26]] // 5 день
{PUSH:{
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)

_TIMER_DAY = 5
SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
}}           
BUTTON_EVENT [MVP,BUTTONS[27]] // 6 день
{PUSH:{
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)

_TIMER_DAY = 6
SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
}}           
                  
BUTTON_EVENT [MVP,BUTTONS[30]] // 0 день
{PUSH:{
    LOCAL_VAR INTEGER NUM_PANEL
    
    NUM_PANEL = GET_LAST (MVP)

_TIMER_DAY = 0
SEND_COMMAND MVP[NUM_PANEL],"'^BMF-',itoa(BUTTONS[13]),',0,%SW1'"
}}           
                  

CHANNEL_EVENT [RELAY, RELAY_1]
{ON:{_LAST_STATE_GENERATOR = RELAY_1}}

CHANNEL_EVENT [RELAY, RELAY_2]
{ON:{_LAST_STATE_GENERATOR = RELAY_2}}

CHANNEL_EVENT [RELAY, RELAY_3]
{ON:{_LAST_STATE_GENERATOR = RELAY_3}}

CHANNEL_EVENT [RELAY, RELAY_4]
{ON:{_LAST_STATE_GENERATOR = RELAY_4}}



DEFINE_PROGRAM

Wait 1
{
IF (_TIMER_ON = 1)
{

IF (_SELECT_DAY = 0)
{IF (TIME = _TIMER_TIME) 
{  _SELECT_DAY = _TIMER_DAY
wait 10 {
SET_PULSE_TIME (10) PULSE[RELAY, RELAY_2] WAIT 30 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_1]} 
wait 400 {
IF (![IO, IO_1]) 
{
SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4] 
WAIT 120 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4]}
WAIT 240 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_2]} 
WAIT 360 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_2]}
WAIT 400 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_1]}
}}
WAIT 1800 {SET_PULSE_TIME (10) PULSE[RELAY, RELAY_4]}
}}}}
}


Wait 2
{
IF (_TIMER_ON = 1)
{
IF (DAY_ != day_of_week( DATE ))
				    {
				    DAY_ = day_of_week( DATE )
				    _SELECT_DAY = _SELECT_DAY - 1
				    IF (_SELECT_DAY > 100) _SELECT_DAY = 0
				    }
}
}


WAIT 5 {
[MVP, BUTTONS[1]] = [IO, IO_1] // Генератор заведен/заглушен
//[MVP, BUTTONS[2]] = [IO, IO_2] // Заряд батареи ниже 25%
[MVP, BUTTONS[3]] = [IO, IO_3] // Разрешение на команду Авто  2 раза через 10 сек
[MVP, BUTTONS[4]] = [IO, IO_4] // Разрешение на команду Сброс 2 раза через 10 сек
[MVP, BUTTONS[5]] = [IO, IO_5] // Нет основного ввода
[MVP, BUTTONS[6]] = [IO, IO_6] // Уровень бака                                    
[MVP, BUTTONS[7]] = [IO, IO_8] // Сигнализация 


[MVP, BUTTONS[ 8]] = (_LAST_STATE_GENERATOR = RELAY_1) // Ручной
[MVP, BUTTONS[ 9]] = (_LAST_STATE_GENERATOR = RELAY_2) // Авто
[MVP, BUTTONS[10]] = (_LAST_STATE_GENERATOR = RELAY_3) // Старт
[MVP, BUTTONS[11]] = (_LAST_STATE_GENERATOR = RELAY_4) // Сброс   
}                                               

wait 2
{
[MVP,BUTTONS[15]] = (SHOW_HOURSMINUTE = 1)
[MVP,BUTTONS[18]] = (SHOW_HOURSMINUTE = 2)
[MVP,BUTTONS[20]] = (_TIMER_ON = 1)
[MVP,BUTTONS[21]] = (_TIMER_ON = 0)


[MVP,BUTTONS[22]] = (_TIMER_DAY = 1)
[MVP,BUTTONS[23]] = (_TIMER_DAY = 2)
[MVP,BUTTONS[24]] = (_TIMER_DAY = 3)
[MVP,BUTTONS[25]] = (_TIMER_DAY = 4)
[MVP,BUTTONS[26]] = (_TIMER_DAY = 5)
[MVP,BUTTONS[27]] = (_TIMER_DAY = 6)
[MVP,BUTTONS[30]] = (_TIMER_DAY = 0)
                                
}



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
