PROGRAM_NAME='Main'
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
#include 'AUTO_CLIMAT.axi'
#include 'Channel.axi'
#include 'Misc.axi'
#include 'KEYPAD_HW_port_2'
#include 'Keypad_Port_3'
#include 'Text'


// роутер порт 50081 логин admin пароль fedorslava
// Лицензия на iPad tpc-0-zfia-etua
// Лицензия на iPhone TPC-4-OMBP-SNXD
// пароль на вайфай fedorslavavitachiv2014OK


DEFINE_DEVICE

//////////// System 1 /////////////////////////////
// NI-4000 IP 192.168.1.51 ID 5001
// COM2    IP 192.168.1.52 ID 5002 
// DS8 (1) IP 192.168.1.53 ID 5003 				    
// DS8 (2) IP 192.168.1.54 ID 5004				    
// DS8 (3) IP 192.168.1.55 ID 5005
// REL12(1)IP 192.168.1.56 ID 5006				    
// REL12(2)IP 192.168.1.57 ID 5007				    
// REL12(3)IP 192.168.1.58 ID 5008				    
                      


// IP control

DreamBox_1  = 0:41:0 // DREAMBOX SAT 800HD
DUNE        = 0:44:0 // POPCORN IP PORT
WEBBOX      = 0:45:0 // SMA WEBBOX
HWI         = 0:40:0 // HomeWork Server


// NI контролер

MATRIX4x4    = 5001:1:1   // KEY DIGITAL
SHARP_1      = 5001:2:1   // SHARP TV
SHARP_2      = 5001:3:1   // SHARP TV 
AVR_PIONEER  = 5001:4:1   // AVR PIONEER  

REL       = 5001:8:1  // ПОРТ РЕЛЕ

IR1_1     = 5001:9:1   // APPLE TV
IR1_2     = 5001:10:1  // SAMSUNG TV
IR1_3     = 5001:11:1  // DUNE
IR1_4     = 5001:12:1  // 
IR1_5     = 5001:13:1  // гостевая спальня/СЗ
IR1_6     = 5001:14:1  // спальня
IR1_7     = 5001:15:1  // столовая 
IR1_8     = 5001:16:1  // гостинная
                
IO        = 5001:17:1 // ПОРТ СУХОЙ КОНТАКТ

// платы расширения
LUTRON       = 1:1:1

IO_PROTE4KA  = 4:1:1  //1 Протечка Подвал  
                      //2 Протечка Котельная  
                      //3 Протечка Гардероб 1 эт
                      //4 Протечка СУ 1 эт
                      //5 Протечка Кухня
                      //6 Протечка СУ 2 эт
                      //7 Протечка СУ основной
                      //8 Протечка Комната персонала
                      //9 
                      //10
// RS-232              
DMX512 = 5002:1:1  // Управление DMX LED RGB
 
// темпреатурные датчики
DS8_1 = 5003:1:1  // 
DS8_2 = 5004:1:1  // 
DS8_3 = 5005:1:1  // 
    
// реле
REL12_1 = 5006:1:1  // 
REL12_2 = 5007:1:1  // 
REL12_3 = 5008:1:1  // 
      
 
// Panels
// All Zone - (климат)
MVP1_1 = 11001:1:1 // iPad 1
MVP2_1 = 11002:1:1 // iPad 2
MVP3_1 = 11003:1:1 // iPad 3
MVP4_1 = 11004:1:1 // iPad 4

// Lutron LIGHT 
MVP1_2 = 11001:2:1 // iPad 1
MVP2_2 = 11002:2:1 // iPad 2
MVP3_2 = 11003:2:1 // iPad 3
MVP4_2 = 11004:2:1 // iPad 4

// мультирум
MVP1_3 = 11001:3:1 // iPad 1
MVP2_3 = 11002:3:1 // iPad 2
MVP3_3 = 11003:3:1 // iPad 3
MVP4_3 = 11004:3:1 // iPad 4


// Виртуальные устройства
vdvDebug                   = 32999:1:0 
vdvTempControl             = 33000:1:1 // температурные датчики, реле, управление теплыми полами и отоплением 
vdvRGB                     = 33001:1:1 // RGB подсветка
vdvPanelLevelPioneer       = 33002:1:1 // уровень громкости для AVR Pioneer 
vdvSharp1                  = 33003:1:1 // 
vdvSharp2                  = 33004:1:1 // 


vdvModbus = 33005:1:1
vdvCondition = 33006:1:1



// к Lutron
vdvHW_KEYPAD1  = 35001:1:1    // 
vdvHW_KEYPAD2  = 35002:1:1    // 
vdvHW_KEYPAD3  = 35003:1:1    // 
vdvHW_KEYPAD4  = 35004:1:1    // 
vdvHW_KEYPAD5  = 35005:1:1    // 
vdvHW_KEYPAD6  = 35006:1:1    // 
vdvHW_KEYPAD7  = 35007:1:1    // 
vdvHW_KEYPAD8  = 35008:1:1    // 
vdvHW_KEYPAD9  = 35009:1:1    // 
vdvHW_KEYPAD10 = 35010:1:1    // 
vdvHW_KEYPAD11 = 35011:1:1    // 
vdvHW_KEYPAD12 = 35012:1:1    // 
vdvHW_KEYPAD13 = 35013:1:1    // 
vdvHW_KEYPAD14 = 35014:1:1    // 
vdvHW_KEYPAD15 = 35015:1:1    // 
vdvHW_KEYPAD16 = 35016:1:1    // 
vdvHW_KEYPAD17 = 35017:1:1    // 
vdvHW_KEYPAD18 = 35018:1:1    // 
vdvHW_KEYPAD19 = 35019:1:1    // 
vdvHW_KEYPAD20 = 35020:1:1    // 
vdvHW_KEYPAD21 = 35021:1:1    // 
vdvHW_KEYPAD22 = 35022:1:1    // 
                    
vdvDIMM       = 35000:1:1     //



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(* change this according to your channels *)
INTEGER nRed__Channel_LED1	= 1
INTEGER nGreenChannel_LED1	= 2
INTEGER nBlue_Channel_LED1	= 3
INTEGER WHITE_Channel_LED1	= 4

INTEGER nRed__Channel_LED2	= 5
INTEGER nGreenChannel_LED2	= 6
INTEGER nBlue_Channel_LED2	= 7
INTEGER WHITE_Channel_LED2	= 8



(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

dev dvPanelClimat [4] = {MVP1_1, MVP2_1, MVP3_1, MVP4_1} // All Zone - (климат)
dev dvLutronLight2[4] = {MVP1_2, MVP2_2, MVP3_2, MVP4_2} // Lutron Light
dev dvMultirum[4]     = {MVP1_3, MVP2_3, MVP3_3, MVP4_3} // мультирум

DEV vdvHW_KEYPADS[]=
{
	vdvHW_KEYPAD1,
	vdvHW_KEYPAD2,
	vdvHW_KEYPAD3,
	vdvHW_KEYPAD4,
	vdvHW_KEYPAD5,
	vdvHW_KEYPAD6,
	vdvHW_KEYPAD7,
	vdvHW_KEYPAD8,
	vdvHW_KEYPAD9,
	vdvHW_KEYPAD10,
	vdvHW_KEYPAD11,
	vdvHW_KEYPAD12,
	vdvHW_KEYPAD13,
	vdvHW_KEYPAD14,
	vdvHW_KEYPAD15,
	vdvHW_KEYPAD16,
	vdvHW_KEYPAD17,
	vdvHW_KEYPAD18,
	vdvHW_KEYPAD19,
	vdvHW_KEYPAD20,
	vdvHW_KEYPAD21,
	vdvHW_KEYPAD22,
        vdvRGB	    
}                   

// переменные мультирума ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

VOLATILE CHAR IP_DREAMBOX_1 []  = {'192.168.1.106'} // IP адресс спутника
VOLATILE CHAR IP_AVR_PIONEER [] = {'192.168.1.107'} // IP адресс AVR пионера
VOLATILE CHAR IP_DUNE []     = {'192.168.1.105'} // IP адресс попкорна Кинотеатр

// переменные мультирума ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

volatile integer WEBBOX_OnLine = 0
VOLATILE CHAR    WEBBOX_IP[15] = '192.168.1.168'
volatile integer WEBBOX_Port = 502



volatile INTEGER AVR_Port = 23

volatile INTEGER     AVR_OnLine
volatile INTEGER    DUNE_OnLine
volatile INTEGER    SHARP1_OnLine
volatile INTEGER    Select_Audio_Video_Effects



volatile INTEGER OFFSET0    = 0
volatile INTEGER OFFSET50   = 50
volatile INTEGER OFFSET79   = 79
volatile INTEGER OFFSET100  = 100
volatile INTEGER OFFSET200  = 200
volatile INTEGER OFFSET300  = 300
volatile INTEGER OFFSET400  = 400
volatile INTEGER OFFSET500  = 500
volatile INTEGER OFFSET600  = 600
volatile INTEGER OFFSET700  = 700
volatile INTEGER OFFSET800  = 800
volatile INTEGER OFFSET840  = 840
volatile INTEGER OFFSET900  = 900
volatile INTEGER OFFSET1000  = 1000
volatile INTEGER OFFSET1100  = 1100
volatile INTEGER OFFSET1200  = 1200
volatile INTEGER OFFSET1300  = 1300
volatile INTEGER OFFSET1400  = 1400
volatile INTEGER OFFSET1500  = 1500
volatile INTEGER OFFSET1600  = 1600
volatile INTEGER OFFSET1700  = 1700
volatile INTEGER OFFSET1800  = 1800
volatile INTEGER OFFSET1900  = 1900
volatile INTEGER OFFSET2000  = 2000
volatile INTEGER OFFSET2100  = 2100
                              
volatile INTEGER PULSE_TIME_1 = 1
volatile INTEGER PULSE_TIME_2 = 2
volatile INTEGER PULSE_TIME_3 = 3

PERSISTENT CHAR STATUS_SOURSE [5] [3]
PERSISTENT CHAR STATUS_TV [5] [3]
volatile INTEGER TIME_ON_TV = 110

// переменные климата ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
volatile char     TempLevel_ch   [30][10]
volatile sinteger TempLevel_int  [30]
volatile sinteger TempLevel_ylica
volatile sinteger Pogrewnost_int [30] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
volatile INTEGER  Relay24 [40] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38}
PERSISTENT LONG temprige_SAVE [30]

// Протечка воды  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
PERSISTENT INTEGER ZatopCase 
PERSISTENT INTEGER ZatopZone 
PERSISTENT CHAR ZatopTime [10]
PERSISTENT CHAR ZatopData [15]

// Подогрев воронок //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
PERSISTENT sinteger SAVE_TEMPRIJE_UP 
PERSISTENT sinteger SAVE_TEMPRIJE_DN 

// Кондиционер //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
PERSISTENT sinteger SAVE_TEMPRIJE_COND_UP 
PERSISTENT sinteger SAVE_TEMPRIJE_COND_DN 
PERSISTENT CHAR REJIM_COND[4] 
PERSISTENT INTEGER CASE_BUTTON_COND[4]
PERSISTENT INTEGER PAUSE_CASE_COND [4]
PERSISTENT INTEGER PAUSE_START [4]
volatile SINTEGER nHour

// Таймер генератора //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
PERSISTENT INTEGER _TIMER_ON 
PERSISTENT INTEGER _SELECT_DAY 
PERSISTENT SINTEGER _DAY
PERSISTENT INTEGER _TIMER_DAY 
PERSISTENT CHAR WorkTime[10]
PERSISTENT CHAR WorkData[10]
PERSISTENT CHAR _TIMER_TIME [10]
PERSISTENT INTEGER _LAST_STATE_GENERATOR

// RGB подсветка 
(* the actual string is 8 long, *)
(* but we don't need the last 2 chars, *)
(* because it's the hue *)
CHAR strHexColor[6]

(* fill these up with the values *)
INTEGER nRed   [3]
INTEGER nGreen [3]
INTEGER nBlue  [3]
INTEGER nWhite [3]

// Вентиляция
VOLATILE INTEGER RELAY_VENTIL = 8
VOLATILE INTEGER IO_VENTIL    = 6
PERSISTENT CHAR SAVE_REJIM_VENT [4]
PERSISTENT sinteger SAVE_TEMPRIJE_VENT_DN 


////  	При загрузке управление DVR
VOLATILE INTEGER DVR_SELECT_
VOLATILE SINTEGER MINUTE_
VOLATILE INTEGER DVR_TIMER_OK



//// Выключение приборов в зависимости от нагрузки 

VOLATILE float SUMM_PARAM_[50]
PERSISTENT float FASE_[3]
VOLATILE INTEGER CASE_WAIT_FASE_A_MAX
VOLATILE INTEGER CASE_WAIT_FASE_A_MIN

/// Переменные для авторежима

PERSISTENT INTEGER AUTO_REJIM_HOME
VOLATILE   INTEGER REJIM [3]


(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)


(*+++++++ теплый пол  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
DEFINE_MODULE  'ClimateControl_TPol' BatRoom1 // комната персонала
(dvPanelClimat, KEYPAD_CLIMATE1, vdvTempControl, Relay24[1], temprige_SAVE[1], TempLevel_int[16], TempLevel_ch[16])
                                                        
DEFINE_MODULE  'ClimateControl_TPol' BatRoom2 // СУ персонала
(dvPanelClimat, KEYPAD_CLIMATE2, vdvTempControl, Relay24[2], temprige_SAVE[2], TempLevel_int[12], TempLevel_ch[12])
                                                        
DEFINE_MODULE  'ClimateControl_TPol' BatRoom3 // СУ 1 эт гостевой
(dvPanelClimat, KEYPAD_CLIMATE3, vdvTempControl, Relay24[3], temprige_SAVE[3], TempLevel_int[18], TempLevel_ch[18])
                                                        
DEFINE_MODULE  'ClimateControl_TPol' BatRoom4 // Гостинная камин
(dvPanelClimat, KEYPAD_CLIMATE4, vdvTempControl, Relay24[4], temprige_SAVE[4], TempLevel_int[8], TempLevel_ch[8])

DEFINE_MODULE  'ClimateControl_TPol' BatRoom4 // Гостинная ДТ
(dvPanelClimat, KEYPAD_CLIMATE20, vdvTempControl, Relay24[26], temprige_SAVE[26], TempLevel_int[9], TempLevel_ch[9])
                                                                          
DEFINE_MODULE  'ClimateControl_TPol' BatRoom5 // столовая                 
(dvPanelClimat, KEYPAD_CLIMATE5, vdvTempControl, Relay24[5], temprige_SAVE[5], TempLevel_int[1], TempLevel_ch[1])
                                                                          
DEFINE_MODULE  'ClimateControl_TPol' BatRoom6 // кухня                    
(dvPanelClimat, KEYPAD_CLIMATE6, vdvTempControl, Relay24[6], temprige_SAVE[6], TempLevel_int[4], TempLevel_ch[4])
                                                                          
DEFINE_MODULE  'ClimateControl_TPol' BatRoom7 // прихожая                 
(dvPanelClimat, KEYPAD_CLIMATE7, vdvTempControl, Relay24[7], temprige_SAVE[7], TempLevel_int[2], TempLevel_ch[2])
                                                                          
DEFINE_MODULE  'ClimateControl_TPol' BatRoom8 // гардероб                 
(dvPanelClimat, KEYPAD_CLIMATE8, vdvTempControl, Relay24[8], temprige_SAVE[8], TempLevel_int[6], TempLevel_ch[6])
                                                                          
DEFINE_MODULE  'ClimateControl_TPol' BatRoom9 // СУ гостевой              
(dvPanelClimat, KEYPAD_CLIMATE9, vdvTempControl, Relay24[13], temprige_SAVE[13], TempLevel_int[5], TempLevel_ch[5])
                                                                          
DEFINE_MODULE  'ClimateControl_TPol' BatRoom10 // СУ основной             
(dvPanelClimat, KEYPAD_CLIMATE10, vdvTempControl, Relay24[14], temprige_SAVE[14], TempLevel_int[3], TempLevel_ch[3])
                                                                        
(*+++++++ отопление  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
DEFINE_MODULE  'ClimateControl' BatRoom11 // комната персонала
(dvPanelClimat, KEYPAD_CLIMATE11, vdvTempControl, Relay24[9], temprige_SAVE[9], TempLevel_int[17], TempLevel_ch[17])
                                       
DEFINE_MODULE  'ClimateControl_Vent' BatRoom12 // Гостинная ДТ+камин
(dvPanelClimat, KEYPAD_CLIMATE12, vdvTempControl, Relay24[10], Relay24[25], temprige_SAVE[10], TempLevel_int[13], TempLevel_ch[13])
                                       
DEFINE_MODULE  'ClimateControl_Vent' BatRoom13 // столовая
(dvPanelClimat, KEYPAD_CLIMATE13, vdvTempControl, Relay24[11], Relay24[21], temprige_SAVE[11], TempLevel_int[11], TempLevel_ch[11])
                                       
DEFINE_MODULE  'ClimateControl' BatRoom14 // кухня
(dvPanelClimat, KEYPAD_CLIMATE14, vdvTempControl, Relay24[12], temprige_SAVE[12], TempLevel_int[22], TempLevel_ch[22])
                                       
DEFINE_MODULE  'ClimateControl' BatRoom15 // гостевая
(dvPanelClimat, KEYPAD_CLIMATE15, vdvTempControl, Relay24[15], temprige_SAVE[15], TempLevel_int[19], TempLevel_ch[19])
                                       
DEFINE_MODULE  'ClimateControl_Vent' BatRoom16 // зимний сад
(dvPanelClimat, KEYPAD_CLIMATE16, vdvTempControl, Relay24[16], Relay24[23], temprige_SAVE[16], TempLevel_int[14], TempLevel_ch[14])
                                       
DEFINE_MODULE  'ClimateControl' BatRoom17 // спортзал терасса
(dvPanelClimat, KEYPAD_CLIMATE17, vdvTempControl, Relay24[17], temprige_SAVE[17], TempLevel_int[20], TempLevel_ch[20])
                                       
DEFINE_MODULE  'ClimateControl_Vent' BatRoom18 // СУ основной
(dvPanelClimat, KEYPAD_CLIMATE18, vdvTempControl, Relay24[18], Relay24[24], temprige_SAVE[18], TempLevel_int[7], TempLevel_ch[7])
                                       
DEFINE_MODULE  'ClimateControl' BatRoom19 // Спальня основная
(dvPanelClimat, KEYPAD_CLIMATE19, vdvTempControl, Relay24[19], temprige_SAVE[19], TempLevel_int[21], TempLevel_ch[21])

DEFINE_MODULE  'ClimateControl' BatRoom19 // Котельная
(dvPanelClimat, KEYPAD_CLIMATE21, vdvTempControl, Relay24[28], temprige_SAVE[28], TempLevel_int[10], TempLevel_ch[10])

DEFINE_MODULE  'ClimateControl' BatRoom19 // Кладовая
(dvPanelClimat, KEYPAD_CLIMATE22, vdvTempControl, Relay24[27], temprige_SAVE[27], TempLevel_int[23], TempLevel_ch[23])


// DEFINE_MODULE 'Podogrev_Voronok' Podogrev_Voronok // Подогрев воронок
// (dvPanelClimat, KEYPAD_PodogrevVoronoc, vdvTempControl, KEYPAD_RELAY[7],   TempLevel_ylica,  SAVE_TEMPRIJE_UP, SAVE_TEMPRIJE_DN  )
                                                                                       
DEFINE_MODULE 'Energetika_Generator' Energetika_Generator
(dvPanelClimat, KEYPAD_ENERGETIKA, vdvTempControl, IO, WorkTime, WorkData, _TIMER_ON, _TIMER_TIME, _TIMER_DAY, _SELECT_DAY, _DAY, _LAST_STATE_GENERATOR)
                                                                                       

DEFINE_MODULE 'HW_COMM' HW_COMM(LUTRON, vdvHW_KEYPADS, HW_KEYPADS)                        

DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE1  (vdvHW_KEYPAD1,  dvLutronLight2, PANEL1_BUTTONS,  LUTRON_OnLine) // виртуальная панель 1 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE2  (vdvHW_KEYPAD2,  dvLutronLight2, PANEL2_BUTTONS,  LUTRON_OnLine) // Спальня гост балкон
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE3  (vdvHW_KEYPAD3,  dvLutronLight2, PANEL3_BUTTONS,  LUTRON_OnLine) // Подвал 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE4  (vdvHW_KEYPAD4,  dvLutronLight2, PANEL4_BUTTONS,  LUTRON_OnLine) // Тамбур вход в дом
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE5  (vdvHW_KEYPAD5,  dvLutronLight2, PANEL5_BUTTONS,  LUTRON_OnLine) // Котельная 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE6  (vdvHW_KEYPAD6,  dvLutronLight2, PANEL6_BUTTONS,  LUTRON_OnLine) // Коридор
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE7  (vdvHW_KEYPAD7,  dvLutronLight2, PANEL7_BUTTONS,  LUTRON_OnLine) // Комната персонала 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE8  (vdvHW_KEYPAD8,  dvLutronLight2, PANEL8_BUTTONS,  LUTRON_OnLine) // Комната персонала СУ
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE9  (vdvHW_KEYPAD9,  dvLutronLight2, PANEL9_BUTTONS,  LUTRON_OnLine) // Гостинная у окна 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE10 (vdvHW_KEYPAD10, dvLutronLight2, PANEL10_BUTTONS, LUTRON_OnLine) // Гостинная под лесницей
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE11 (vdvHW_KEYPAD11, dvLutronLight2, PANEL11_BUTTONS, LUTRON_OnLine) // Спальня хоз. 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE12 (vdvHW_KEYPAD12, dvLutronLight2, PANEL12_BUTTONS, LUTRON_OnLine) // СУ хозяйский
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE13 (vdvHW_KEYPAD13, dvLutronLight2, PANEL13_BUTTONS, LUTRON_OnLine) // Спальня гостевая 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE14 (vdvHW_KEYPAD14, dvLutronLight2, PANEL14_BUTTONS, LUTRON_OnLine) // Спальня гостевая СУ
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE15 (vdvHW_KEYPAD15, dvLutronLight2, PANEL15_BUTTONS, LUTRON_OnLine) // Спортзал 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE16 (vdvHW_KEYPAD16, dvLutronLight2, PANEL16_BUTTONS, LUTRON_OnLine) // Зимний сад
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE17 (vdvHW_KEYPAD17, dvLutronLight2, PANEL17_BUTTONS, LUTRON_OnLine) // Кухня                             
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE18 (vdvHW_KEYPAD18, dvLutronLight2, PANEL18_BUTTONS, LUTRON_OnLine) // Зимний сад балкон                          
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE19 (vdvHW_KEYPAD19, dvLutronLight2, PANEL19_BUTTONS, LUTRON_OnLine) // Зимний сад возле СЗ                          
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE20 (vdvHW_KEYPAD20, dvLutronLight2, PANEL20_BUTTONS, LUTRON_OnLine) // Спальня хоз справа у кровати                          
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE21 (vdvHW_KEYPAD21, dvLutronLight2, PANEL21_BUTTONS, LUTRON_OnLine) // СУ хоз. балкон                                         
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_RELISE22 (vdvHW_KEYPAD22, dvLutronLight2, PANEL22_BUTTONS, LUTRON_OnLine) // вирт панель 2                                       
                                                                                                                        
DEFINE_MODULE 'LUTRON_DIMMER_v2' LUTRON_DIMMER_v2 (LUTRON, vdvRGB, dvLutronLight2, leveL_DIMMER, BUTTON_DIMMER_QUesions, BUTTON_STATUS_OFF, HW_DIMMERS, FADE_TIME, DELAY_TIME) // виртуальная

///  аудио видео  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// Управление спутниковым тюнером Enigma2
DEFINE_MODULE 'DREAMBOX_800HD' DREAMBOX_800HD1
(dvMultirum, DreamBox_1, BUTTONS_DREAMBOX, KEYPAD_DREEMBOX_FAV, KEYPAD_DREEMBOX_TYPE, 
IP_DREAMBOX_1, MasFavSat_ChannelName, MasFavSat_ChannelButton)

DEFINE_MODULE 'KEYDIGITAL_KD_HDMSW4X4' KEYDIGITAL_KD_HDMSW4X4 (MATRIX4x4, dvMultirum, KEYPAD_KEYDIGITAL_1) /// Управление матричным комутатором KEY DIGITAL

DEFINE_MODULE 'Sharp_Plasm_RS_v1' Sharp_Plasm_RS_v1 (SHARP_1, vdvSharp1, dvMultirum, KEYPAD_SHARP_1) /// Управление телевизором Sharp
DEFINE_MODULE 'Sharp_Plasm_RS_v1' Sharp_Plasm_RS_v1 (SHARP_2, vdvSharp2, dvMultirum, KEYPAD_SHARP_2) /// Управление телевизором Sharp

DEFINE_MODULE 'MODULE_IR_V1' IR_101     (IR1_1, dvMultirum, KEYPAD_APPLETV,     OFFSET600, PULSE_TIME_3)          // Управление Apple TV
DEFINE_MODULE 'MODULE_IR_PULSE_V1' IR_11 (IR1_2, dvMultirum, KEYPAD_DVR,   OFFSET700, PULSE_TIME_1)          // Управление Samsung TV  
DEFINE_MODULE 'MODULE_IR_V1' IR_101     (IR1_3, dvMultirum, KEYPAD_DUNE_MR,     OFFSET200, PULSE_TIME_1)          // Управление DUNE в МР


DEFINE_MODULE 'AVR_RS_CONTROL' Pioneer_76 (AVR_PIONEER, vdvPanelLevelPioneer, dvMultirum, KEYPAD_PIONEER)

DEFINE_MODULE 'DUNE_IP_CONTROL_v1' DUNE_ (dvMultirum, DUNE, IP_DUNE, KEYPAD_DUNE_CINEMA, COMMAND_IR_DUNE)

///  данные SMA WEBBOX  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DEFINE_MODULE 'module_SMA_WEBBOX_v1' module_SMA_WEBBOX_v1 (WEBBOX, vdvModbus, vdvDebug, dvPanelClimat, WEBBOX_IP, WEBBOX_Port, WEBBOX_OnLine, KEYPAD_SMA_WEBBOX, KEYPAD_SMA_WEBBOX_2, IO, SUMM_PARAM_)


DEFINE_MODULE 'Module_Cond_Rejim' Module_Cond_Rejim (dvPanelClimat, vdvCondition, KEYPAD_REJIM_TEMP, TempLevel_ylica, SAVE_TEMPRIJE_COND_UP, SAVE_TEMPRIJE_COND_DN, REJIM_COND )
                                                                                       
DEFINE_MODULE 'Module_Condition_v1' Module_Condition_v1 (dvPanelClimat, vdvCondition, IR1_8, KEYPAD_CONDITION_1, CASE_BUTTON_COND[1], REJIM_COND, PAUSE_CASE_COND[1], PAUSE_START[1] )
DEFINE_MODULE 'Module_Condition_v1' Module_Condition_v1 (dvPanelClimat, vdvCondition, IR1_6, KEYPAD_CONDITION_2, CASE_BUTTON_COND[2], REJIM_COND, PAUSE_CASE_COND[2], PAUSE_START[2] )
DEFINE_MODULE 'Module_Condition_v1' Module_Condition_v1 (dvPanelClimat, vdvCondition, IR1_7, KEYPAD_CONDITION_3, CASE_BUTTON_COND[3], REJIM_COND, PAUSE_CASE_COND[3], PAUSE_START[3] )
DEFINE_MODULE 'Module_Condition_v1' Module_Condition_v1 (dvPanelClimat, vdvCondition, IR1_5, KEYPAD_CONDITION_4, CASE_BUTTON_COND[4], REJIM_COND, PAUSE_CASE_COND[4], PAUSE_START[4] )
                                                                                                                                                                               

DEFINE_MODULE 'Module_Ventil_Dom_v1' Module_Ventil_Dom_v1 
(dvPanelClimat, KEYPAD_VENTIL, REL, RELAY_VENTIL, IO, IO_VENTIL, TempLevel_ylica, SAVE_REJIM_VENT, SAVE_TEMPRIJE_VENT_DN  )
                                                                                       
    
DEFINE_START

IF (FASE_[1] = 0) {FASE_[1] = 6 FASE_[2] = 6 FASE_[3] = 6 }

COMBINE_LEVELS (vdvRGB, nRed__Channel_LED1, DMX512, nRed__Channel_LED1, dvLutronLight2 [1], nRed__Channel_LED1, dvLutronLight2 [2], nRed__Channel_LED1, dvLutronLight2 [3], nRed__Channel_LED1)
COMBINE_LEVELS (vdvRGB, nGreenChannel_LED1, DMX512, nGreenChannel_LED1, dvLutronLight2 [1], nGreenChannel_LED1, dvLutronLight2 [2], nGreenChannel_LED1, dvLutronLight2 [3], nGreenChannel_LED1)
COMBINE_LEVELS (vdvRGB, nBlue_Channel_LED1, DMX512, nBlue_Channel_LED1, dvLutronLight2 [1], nBlue_Channel_LED1, dvLutronLight2 [2], nBlue_Channel_LED1, dvLutronLight2 [3], nBlue_Channel_LED1)
COMBINE_LEVELS (vdvRGB, WHITE_Channel_LED1, DMX512, WHITE_Channel_LED1, dvLutronLight2 [1], WHITE_Channel_LED1, dvLutronLight2 [2], WHITE_Channel_LED1, dvLutronLight2 [3], WHITE_Channel_LED1)
                                                                      
COMBINE_LEVELS (vdvRGB, nRed__Channel_LED2, DMX512, nRed__Channel_LED2, dvLutronLight2 [1], nRed__Channel_LED1, dvLutronLight2 [2], nRed__Channel_LED1, dvLutronLight2 [3], nRed__Channel_LED1)
COMBINE_LEVELS (vdvRGB, nGreenChannel_LED2, DMX512, nGreenChannel_LED2, dvLutronLight2 [1], nGreenChannel_LED1, dvLutronLight2 [2], nGreenChannel_LED1, dvLutronLight2 [3], nGreenChannel_LED1)
COMBINE_LEVELS (vdvRGB, nBlue_Channel_LED2, DMX512, nBlue_Channel_LED2, dvLutronLight2 [1], nBlue_Channel_LED1, dvLutronLight2 [2], nBlue_Channel_LED1, dvLutronLight2 [3], nBlue_Channel_LED1)
COMBINE_LEVELS (vdvRGB, WHITE_Channel_LED2, DMX512, WHITE_Channel_LED2, dvLutronLight2 [1], WHITE_Channel_LED1, dvLutronLight2 [2], WHITE_Channel_LED1, dvLutronLight2 [3], WHITE_Channel_LED1)
                                                                      
COMBINE_LEVELS (vdvRGB, 9,  DMX512, 9 , dvLutronLight2 [1],  9, dvLutronLight2 [2],  9, dvLutronLight2 [3],  9)
COMBINE_LEVELS (vdvRGB, 10, DMX512, 10, dvLutronLight2 [1], 10, dvLutronLight2 [2], 10, dvLutronLight2 [3], 10)
COMBINE_LEVELS (vdvRGB, 11, DMX512, 11, dvLutronLight2 [1], 11, dvLutronLight2 [2], 11, dvLutronLight2 [3], 11)
COMBINE_LEVELS (vdvRGB, 12, DMX512, 12, dvLutronLight2 [1], 12, dvLutronLight2 [2], 12, dvLutronLight2 [3], 12)
COMBINE_LEVELS (vdvRGB, 13, DMX512, 13, dvLutronLight2 [1], 13, dvLutronLight2 [2], 13, dvLutronLight2 [3], 13)
COMBINE_LEVELS (vdvRGB, 14, DMX512, 14, dvLutronLight2 [1], 14, dvLutronLight2 [2], 14, dvLutronLight2 [3], 14)
COMBINE_LEVELS (vdvRGB, 15, DMX512, 15, dvLutronLight2 [1], 15, dvLutronLight2 [2], 15, dvLutronLight2 [3], 15)
COMBINE_LEVELS (vdvRGB, 16, DMX512, 16, dvLutronLight2 [1], 16, dvLutronLight2 [2], 16, dvLutronLight2 [3], 16)
COMBINE_LEVELS (vdvRGB, 17, DMX512, 17, dvLutronLight2 [1], 17, dvLutronLight2 [2], 17, dvLutronLight2 [3], 17)
COMBINE_LEVELS (vdvRGB, 18, DMX512, 18, dvLutronLight2 [1], 18, dvLutronLight2 [2], 18, dvLutronLight2 [3], 18)
COMBINE_LEVELS (vdvRGB, 19, DMX512, 19, dvLutronLight2 [1], 19, dvLutronLight2 [2], 19, dvLutronLight2 [3], 19)
COMBINE_LEVELS (vdvRGB, 20, DMX512, 20, dvLutronLight2 [1], 20, dvLutronLight2 [2], 20, dvLutronLight2 [3], 20)
COMBINE_LEVELS (vdvRGB, 21, DMX512, 21, dvLutronLight2 [1], 21, dvLutronLight2 [2], 21, dvLutronLight2 [3], 21)
COMBINE_LEVELS (vdvRGB, 22, DMX512, 22, dvLutronLight2 [1], 22, dvLutronLight2 [2], 22, dvLutronLight2 [3], 22)
COMBINE_LEVELS (vdvRGB, 23, DMX512, 23, dvLutronLight2 [1], 23, dvLutronLight2 [2], 23, dvLutronLight2 [3], 23)
COMBINE_LEVELS (vdvRGB, 24, DMX512, 24, dvLutronLight2 [1], 24, dvLutronLight2 [2], 24, dvLutronLight2 [3], 24)
COMBINE_LEVELS (vdvRGB, 25, DMX512, 25, dvLutronLight2 [1], 25, dvLutronLight2 [2], 25, dvLutronLight2 [3], 25)
COMBINE_LEVELS (vdvRGB, 26, DMX512, 26, dvLutronLight2 [1], 26, dvLutronLight2 [2], 26, dvLutronLight2 [3], 26)
COMBINE_LEVELS (vdvRGB, 27, DMX512, 27, dvLutronLight2 [1], 27, dvLutronLight2 [2], 27, dvLutronLight2 [3], 27)
COMBINE_LEVELS (vdvRGB, 28, DMX512, 28, dvLutronLight2 [1], 28, dvLutronLight2 [2], 28, dvLutronLight2 [3], 28)
COMBINE_LEVELS (vdvRGB, 29, DMX512, 29, dvLutronLight2 [1], 29, dvLutronLight2 [2], 29, dvLutronLight2 [3], 29)
COMBINE_LEVELS (vdvRGB, 30, DMX512, 30, dvLutronLight2 [1], 30, dvLutronLight2 [2], 30, dvLutronLight2 [3], 30)
                                                                             

COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[1],  REL,  1) COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[1],  dvPanelClimat [1],  KEYPAD_RELAY[1],  dvPanelClimat [2],  KEYPAD_RELAY[1],  dvPanelClimat [3],  KEYPAD_RELAY[1])  // генератор Start
COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[2],  REL,  2) COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[2],  dvPanelClimat [1],  KEYPAD_RELAY[2],  dvPanelClimat [2],  KEYPAD_RELAY[2],  dvPanelClimat [3],  KEYPAD_RELAY[2])  // генератор Manual
COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[3],  REL,  3) COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[3],  dvPanelClimat [1],  KEYPAD_RELAY[3],  dvPanelClimat [2],  KEYPAD_RELAY[3],  dvPanelClimat [3],  KEYPAD_RELAY[3])  // генератор Auto
COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[4],  REL,  4) COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[4],  dvPanelClimat [1],  KEYPAD_RELAY[4],  dvPanelClimat [2],  KEYPAD_RELAY[4],  dvPanelClimat [3],  KEYPAD_RELAY[4])  // генератор Reset
COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[5],  REL,  5) COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[5],  dvPanelClimat [1],  KEYPAD_RELAY[5],  dvPanelClimat [2],  KEYPAD_RELAY[5],  dvPanelClimat [3],  KEYPAD_RELAY[5])  // Насос
COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[6],  REL,  6) COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[6],  dvPanelClimat [1],  KEYPAD_RELAY[6],  dvPanelClimat [2],  KEYPAD_RELAY[6],  dvPanelClimat [3],  KEYPAD_RELAY[6])  // Запорный клапан воды
COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[7],  REL,  7) COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[7],  dvPanelClimat [1],  KEYPAD_RELAY[7],  dvPanelClimat [2],  KEYPAD_RELAY[7],  dvPanelClimat [3],  KEYPAD_RELAY[7])  // воронки
COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[8],  REL,  8) COMBINE_CHANNELS (vdvTempControl, KEYPAD_RELAY[8],  dvPanelClimat [1],  KEYPAD_RELAY[8],  dvPanelClimat [2],  KEYPAD_RELAY[8],  dvPanelClimat [3],  KEYPAD_RELAY[8])  // 
                                                                                                                                  
                                                                           
Set_Virtual_Level_Count(vdvTempControl, 30); // У нас 30 температурных уровня

COMBINE_LEVELS (vdvTempControl, 1, DS8_1, 1)
COMBINE_LEVELS (vdvTempControl, 2, DS8_1, 2)
COMBINE_LEVELS (vdvTempControl, 3, DS8_1, 3)
COMBINE_LEVELS (vdvTempControl, 4, DS8_1, 4)
COMBINE_LEVELS (vdvTempControl, 5, DS8_1, 5)
COMBINE_LEVELS (vdvTempControl, 6, DS8_1, 6)
COMBINE_LEVELS (vdvTempControl, 7, DS8_1, 7)
COMBINE_LEVELS (vdvTempControl, 8, DS8_1, 8)
                                         
COMBINE_LEVELS (vdvTempControl, 9,  DS8_2, 1)
COMBINE_LEVELS (vdvTempControl, 10, DS8_2, 2)
COMBINE_LEVELS (vdvTempControl, 11, DS8_2, 3)
COMBINE_LEVELS (vdvTempControl, 12, DS8_2, 4)
COMBINE_LEVELS (vdvTempControl, 13, DS8_2, 5)
COMBINE_LEVELS (vdvTempControl, 14, DS8_2, 6)
COMBINE_LEVELS (vdvTempControl, 15, DS8_2, 7)
COMBINE_LEVELS (vdvTempControl, 16, DS8_2, 8)
                                         
COMBINE_LEVELS (vdvTempControl, 17, DS8_3, 1)
COMBINE_LEVELS (vdvTempControl, 18, DS8_3, 2)
COMBINE_LEVELS (vdvTempControl, 19, DS8_3, 3)
COMBINE_LEVELS (vdvTempControl, 20, DS8_3, 4)
COMBINE_LEVELS (vdvTempControl, 21, DS8_3, 5)
COMBINE_LEVELS (vdvTempControl, 22, DS8_3, 6)
COMBINE_LEVELS (vdvTempControl, 23, DS8_3, 7)
COMBINE_LEVELS (vdvTempControl, 24, DS8_3, 8)
                                         
// 
COMBINE_CHANNELS (vdvTempControl, 1, REL12_1, 1)  
COMBINE_CHANNELS (vdvTempControl, 2, REL12_1, 2)  
COMBINE_CHANNELS (vdvTempControl, 3, REL12_1, 3)  
COMBINE_CHANNELS (vdvTempControl, 4, REL12_1, 4)  
COMBINE_CHANNELS (vdvTempControl, 5, REL12_1, 5)  
COMBINE_CHANNELS (vdvTempControl, 6, REL12_1, 6)  
COMBINE_CHANNELS (vdvTempControl, 7, REL12_1, 7)  
COMBINE_CHANNELS (vdvTempControl, 8, REL12_1, 8)  
COMBINE_CHANNELS (vdvTempControl, 9, REL12_1, 9)  
COMBINE_CHANNELS (vdvTempControl, 10, REL12_1, 10)  
COMBINE_CHANNELS (vdvTempControl, 11, REL12_1, 11)  
COMBINE_CHANNELS (vdvTempControl, 12, REL12_1, 12)  
                                                                                       
COMBINE_CHANNELS (vdvTempControl, 13, REL12_2, 1)  
COMBINE_CHANNELS (vdvTempControl, 14, REL12_2, 2)  
COMBINE_CHANNELS (vdvTempControl, 15, REL12_2, 3)  
COMBINE_CHANNELS (vdvTempControl, 16, REL12_2, 4)  
COMBINE_CHANNELS (vdvTempControl, 17, REL12_2, 5)  
COMBINE_CHANNELS (vdvTempControl, 18, REL12_2, 6)  
COMBINE_CHANNELS (vdvTempControl, 19, REL12_2, 7)  
COMBINE_CHANNELS (vdvTempControl, 20, REL12_2, 8)  
COMBINE_CHANNELS (vdvTempControl, 21, REL12_2, 9)  
COMBINE_CHANNELS (vdvTempControl, 22, REL12_2, 10)  
COMBINE_CHANNELS (vdvTempControl, 23, REL12_2, 11)  
COMBINE_CHANNELS (vdvTempControl, 24, REL12_2, 12)  
COMBINE_CHANNELS (vdvTempControl, 25, REL12_2, 8, REL12_2, 10)  

COMBINE_CHANNELS (vdvTempControl, 26, REL12_3, 1)  
COMBINE_CHANNELS (vdvTempControl, 27, REL12_3, 2)  
COMBINE_CHANNELS (vdvTempControl, 28, REL12_3, 3)  
COMBINE_CHANNELS (vdvTempControl, 29, REL12_3, 4)  
COMBINE_CHANNELS (vdvTempControl, 30, REL12_3, 5)  
COMBINE_CHANNELS (vdvTempControl, 31, REL12_3, 6)  
COMBINE_CHANNELS (vdvTempControl, 32, REL12_3, 7)  
COMBINE_CHANNELS (vdvTempControl, 33, REL12_3, 8)  
COMBINE_CHANNELS (vdvTempControl, 34, REL12_3, 9)  
COMBINE_CHANNELS (vdvTempControl, 35, REL12_3, 10)  
COMBINE_CHANNELS (vdvTempControl, 36, REL12_3, 11)  
COMBINE_CHANNELS (vdvTempControl, 37, REL12_3, 12) 

                                                                                                                                                       
                                  
COMBINE_CHANNELS (vdvTempControl,  1,  dvPanelClimat [1],  1,  dvPanelClimat [2],  1,  dvPanelClimat [3],  1)  
COMBINE_CHANNELS (vdvTempControl,  2,  dvPanelClimat [1],  2,  dvPanelClimat [2],  2,  dvPanelClimat [3],  2)  
COMBINE_CHANNELS (vdvTempControl,  3,  dvPanelClimat [1],  3,  dvPanelClimat [2],  3,  dvPanelClimat [3],  3)  
COMBINE_CHANNELS (vdvTempControl,  4,  dvPanelClimat [1],  4,  dvPanelClimat [2],  4,  dvPanelClimat [3],  4)  
COMBINE_CHANNELS (vdvTempControl,  5,  dvPanelClimat [1],  5,  dvPanelClimat [2],  5,  dvPanelClimat [3],  5)  
COMBINE_CHANNELS (vdvTempControl,  6,  dvPanelClimat [1],  6,  dvPanelClimat [2],  6,  dvPanelClimat [3],  6)  
COMBINE_CHANNELS (vdvTempControl,  7,  dvPanelClimat [1],  7,  dvPanelClimat [2],  7,  dvPanelClimat [3],  7)  
COMBINE_CHANNELS (vdvTempControl,  8,  dvPanelClimat [1],  8,  dvPanelClimat [2],  8,  dvPanelClimat [3],  8)  
COMBINE_CHANNELS (vdvTempControl,  9,  dvPanelClimat [1],  9,  dvPanelClimat [2],  9,  dvPanelClimat [3],  9)  
COMBINE_CHANNELS (vdvTempControl, 10, dvPanelClimat [1],  10, dvPanelClimat [2],  10, dvPanelClimat [3],  10)  
COMBINE_CHANNELS (vdvTempControl, 11, dvPanelClimat [1],  11, dvPanelClimat [2],  11, dvPanelClimat [3],  11)  
COMBINE_CHANNELS (vdvTempControl, 12, dvPanelClimat [1],  12, dvPanelClimat [2],  12, dvPanelClimat [3],  12)  
                                                                                       
COMBINE_CHANNELS (vdvTempControl, 13, dvPanelClimat [1], 13, dvPanelClimat [2], 13, dvPanelClimat [3], 13) 
COMBINE_CHANNELS (vdvTempControl, 14, dvPanelClimat [1], 14, dvPanelClimat [2], 14, dvPanelClimat [3], 14) 
COMBINE_CHANNELS (vdvTempControl, 15, dvPanelClimat [1], 15, dvPanelClimat [2], 15, dvPanelClimat [3], 15) 
COMBINE_CHANNELS (vdvTempControl, 16, dvPanelClimat [1], 16, dvPanelClimat [2], 16, dvPanelClimat [3], 16) 
COMBINE_CHANNELS (vdvTempControl, 17, dvPanelClimat [1], 17, dvPanelClimat [2], 17, dvPanelClimat [3], 17) 
COMBINE_CHANNELS (vdvTempControl, 18, dvPanelClimat [1], 18, dvPanelClimat [2], 18, dvPanelClimat [3], 18) 
COMBINE_CHANNELS (vdvTempControl, 19, dvPanelClimat [1], 19, dvPanelClimat [2], 19, dvPanelClimat [3], 19) 
COMBINE_CHANNELS (vdvTempControl, 20, dvPanelClimat [1], 20, dvPanelClimat [2], 20, dvPanelClimat [3], 20) 
COMBINE_CHANNELS (vdvTempControl, 21, dvPanelClimat [1], 21, dvPanelClimat [2], 21, dvPanelClimat [3], 21) 
COMBINE_CHANNELS (vdvTempControl, 22, dvPanelClimat [1], 22, dvPanelClimat [2], 22, dvPanelClimat [3], 22)  
COMBINE_CHANNELS (vdvTempControl, 23, dvPanelClimat [1], 23, dvPanelClimat [2], 23, dvPanelClimat [3], 23)  
COMBINE_CHANNELS (vdvTempControl, 24, dvPanelClimat [1], 24, dvPanelClimat [2], 24, dvPanelClimat [3], 24)  
COMBINE_CHANNELS (vdvTempControl, 25, dvPanelClimat [1], 25, dvPanelClimat [2], 25, dvPanelClimat [3], 25)  
                                                                                             
COMBINE_CHANNELS (vdvTempControl, 26, dvPanelClimat [1], 26, dvPanelClimat [2], 26, dvPanelClimat [3], 26) 
COMBINE_CHANNELS (vdvTempControl, 27, dvPanelClimat [1], 27, dvPanelClimat [2], 27, dvPanelClimat [3], 27) 
COMBINE_CHANNELS (vdvTempControl, 28, dvPanelClimat [1], 28, dvPanelClimat [2], 28, dvPanelClimat [3], 28) 
COMBINE_CHANNELS (vdvTempControl, 29, dvPanelClimat [1], 29, dvPanelClimat [2], 29, dvPanelClimat [3], 29) 
COMBINE_CHANNELS (vdvTempControl, 30, dvPanelClimat [1], 30, dvPanelClimat [2], 30, dvPanelClimat [3], 30) 
COMBINE_CHANNELS (vdvTempControl, 31, dvPanelClimat [1], 31, dvPanelClimat [2], 31, dvPanelClimat [3], 31) 
COMBINE_CHANNELS (vdvTempControl, 32, dvPanelClimat [1], 32, dvPanelClimat [2], 32, dvPanelClimat [3], 32) 
COMBINE_CHANNELS (vdvTempControl, 33, dvPanelClimat [1], 33, dvPanelClimat [2], 33, dvPanelClimat [3], 33) 
COMBINE_CHANNELS (vdvTempControl, 34, dvPanelClimat [1], 34, dvPanelClimat [2], 34, dvPanelClimat [3], 34) 
COMBINE_CHANNELS (vdvTempControl, 35, dvPanelClimat [1], 35, dvPanelClimat [2], 35, dvPanelClimat [3], 35)  
COMBINE_CHANNELS (vdvTempControl, 36, dvPanelClimat [1], 36, dvPanelClimat [2], 36, dvPanelClimat [3], 36)  
COMBINE_CHANNELS (vdvTempControl, 37, dvPanelClimat [1], 37, dvPanelClimat [2], 37, dvPanelClimat [3], 37) 
                                    

COMBINE_CHANNELS (vdvTempControl, KEYPAD_ZATOP[4], dvPanelClimat [1], KEYPAD_ZATOP[4], dvPanelClimat [2], KEYPAD_ZATOP[4], dvPanelClimat [3], KEYPAD_ZATOP[4])  
                                                 
IF (STATUS_SOURSE [1] = '') 
{
STATUS_SOURSE [1] = 'OFF'
STATUS_SOURSE [2] = 'OFF'
STATUS_SOURSE [3] = 'OFF'
STATUS_SOURSE [4] = 'OFF'
STATUS_SOURSE [5] = 'OFF'
}         

//----- открыть сервер для загрузки программы --------------------------------------------------------------------------------////////////////////////////////////////////////////////        
IP_SERVER_OPEN (HWI.PORT, 245, IP_TCP)


DEFINE_FUNCTION START_NEW_REJIM_AUTO ()
{

/// ВЫПОЛНЕНИЕ АВТО РЕЖИМА КЛИМАТА ТЕМПЕРАТУРНЫЙ РЕЖИМ 1 
    IF (AUTO_REJIM_HOME != 0)
    {
    SELECT
    {
    ACTIVE (TempLevel_ylica >=  250):                   	{IF (REJIM[1] != 1) {REJIM[1] = 1 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >=  160 && TempLevel_ylica <  250):	{IF (REJIM[1] != 2) {REJIM[1] = 2 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >=  120 && TempLevel_ylica <  160):	{IF (REJIM[1] != 3) {REJIM[1] = 3 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >=  050 && TempLevel_ylica <  120):	{IF (REJIM[1] != 4) {REJIM[1] = 4 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >=  000 && TempLevel_ylica <  050):	{IF (REJIM[1] != 5) {REJIM[1] = 5 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >= -050 && TempLevel_ylica <  000):	{IF (REJIM[1] != 6) {REJIM[1] = 6 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >= -140 && TempLevel_ylica < -050):	{IF (REJIM[1] != 7) {REJIM[1] = 7 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica <  -140):                  		{IF (REJIM[1] != 8) {REJIM[1] = 8 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
                                                                                                                        
    }
    }

/// ВЫПОЛНЕНИЕ АВТО РЕЖИМА КЛИМАТА ТЕМПЕРАТУРНЫЙ РЕЖИМ 2 
WAIT 100
{
    IF (AUTO_REJIM_HOME != 0)
    {
    SELECT
    {
    ACTIVE (TempLevel_ylica >=  160):                   	{IF (REJIM[2] != 1) {REJIM[2] = 1 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica >=  050 && TempLevel_ylica <  160):	{IF (REJIM[2] != 2) {REJIM[2] = 2 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica >=  000 && TempLevel_ylica <  050):	{IF (REJIM[2] != 3) {REJIM[2] = 3 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica >= -050 && TempLevel_ylica <  000):	{IF (REJIM[2] != 4) {REJIM[2] = 4 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica >= -140 && TempLevel_ylica < -050):	{IF (REJIM[2] != 5) {REJIM[2] = 5 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica <  -140):                  		{IF (REJIM[2] != 6) {REJIM[2] = 6 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
                                                                                                                              
    }
    }
}

/// ВЫПОЛНЕНИЕ АВТО РЕЖИМА КЛИМАТА ТЕМПЕРАТУРНЫЙ РЕЖИМ 3 
WAIT 150
{
    IF (AUTO_REJIM_HOME != 0)
    {
    SELECT
    {
    ACTIVE (TempLevel_ylica >=  000):                   	{IF (REJIM[3] != 1) {REJIM[3] = 1 AUTO_3 (AUTO_REJIM_HOME, REJIM[3] )}}
    ACTIVE (TempLevel_ylica <   000):                  		{IF (REJIM[3] != 2) {REJIM[3] = 2 AUTO_3 (AUTO_REJIM_HOME, REJIM[3] )}}
                                                                                                                              
    }
    }
}
}




(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//////  Выбор авторежима климат контроля
BUTTON_EVENT [dvPanelClimat, KEYPAD_CLIMATE_AUTO[1]] {PUSH:{ AUTO_REJIM_HOME = 1 REJIM[1] = 0 REJIM[2] = 0 START_NEW_REJIM_AUTO ()}} // Авто стандарт
BUTTON_EVENT [dvPanelClimat, KEYPAD_CLIMATE_AUTO[2]] {PUSH:{ AUTO_REJIM_HOME = 2 REJIM[1] = 0 REJIM[2] = 0 START_NEW_REJIM_AUTO ()}} // Авто + гости
BUTTON_EVENT [dvPanelClimat, KEYPAD_CLIMATE_AUTO[3]] {PUSH:{ AUTO_REJIM_HOME = 3 REJIM[1] = 0 REJIM[2] = 0 START_NEW_REJIM_AUTO ()}} // АВТО + гости + персонал
BUTTON_EVENT [dvPanelClimat, KEYPAD_CLIMATE_AUTO[4]] {PUSH:{ AUTO_REJIM_HOME = 4 REJIM[1] = 0 REJIM[2] = 0 START_NEW_REJIM_AUTO ()}} // АВТО ЭКОНОМ                    
                                                                                 
BUTTON_EVENT [dvPanelClimat, KEYPAD_CLIMATE_AUTO[5]] 
    {PUSH:{ 
		 AUTO_REJIM_HOME = 0 REJIM[1] = 0 REJIM[2] = 0 
		 DO_PUSH (vdvCondition, KEYPAD_CONDITION_1[41])  // Гостиная 1 эт кондиционер
	WAIT 20 {DO_PUSH (vdvCondition, KEYPAD_CONDITION_4[41])} // Гостевая 2 эт кондиционер
	WAIT 40 {DO_PUSH (vdvCondition, KEYPAD_CONDITION_3[41])} // Столовая 1 эт кондиционер
    }} // Выключить режим авто
                                                                                
										

BUTTON_EVENT [dvPanelClimat, KEYPAD_CLIMATE_CLOSE]  // Открытие комнат климата
{PUSH:{ 
      LOCAL_VAR INTEGER CASE_PANEL
      LOCAL_VAR INTEGER CASE_BUTTONS

	CASE_PANEL   = GET_LAST (dvPanelClimat)
	CASE_BUTTONS = GET_LAST (KEYPAD_CLIMATE_CLOSE)
	
	IF (AUTO_REJIM_HOME = 0)
	{
	    SWITCH (CASE_BUTTONS)
	    {
	    CASE 1:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[CenterMain]_1_Climat_Room'" }
	    CASE 2:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Room_Map'" }
	    CASE 3:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Room_Cond_Stolovaja'" }
	    CASE 4:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Room_Cond_Gost'" }
	    CASE 5:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Room_Cond_Sport'" }
	    CASE 6:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Room_Cond_Spalnja'" }
	    CASE 7:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Room_Otoplenie'" }
	    CASE 8:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Room_TepluiPol'" }
	    CASE 9:{ SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Room_Conditioner'" }
	         
	    }
	} ELSE {SEND_COMMAND dvPanelClimat[CASE_PANEL], "'@PPN-[SabClimat]_Climat_Wait'"}
}}




CHANNEL_EVENT [IO, 8] // ДВЕРНОЙ ВЫЗОВ
{
ON:{
    CANCEL_WAIT 'DOR'
    SEND_COMMAND dvMultirum, "'TPCNotify-A visitor is at the Door'"
    SEND_COMMAND dvMultirum, "'@PPN-[CenterMain]_4_Vorota'"
    SEND_COMMAND dvMultirum, "'@SOU-Dorbell.mp3'" 
    WAIT 20 'DOR' {SEND_COMMAND dvMultirum, "'@SOU-Dorbell.mp3'"
	    WAIT 20 'DOR' {SEND_COMMAND dvMultirum, "'@SOU-Dorbell.mp3'"
		WAIT 20 'DOR' {SEND_COMMAND dvMultirum, "'@SOU-Dorbell.mp3'" SEND_COMMAND dvMultirum, "'@PPN-[CenterMain]_4_Vorota'"
    }}}
}}




(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone спальня ************************************)
(*******        ***************************)

BUTTON_EVENT [dvMultirum, KEYPAD_MAKROS_1]   //  управление макросами
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE_
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV DEVICE

      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_1)
      CASE_ZONE_ = 1
      DEVICE = SHARP_1
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК SAT 
      CASE 2:  //  ИСТОЧНИК Popcorn
      CASE 3:  //  ИСТОЧНИК Apple TV
      CASE 4:  //  ИСТОЧНИК Videoregistrator
             { 
             IF (STATUS_SOURSE[CASE_ZONE_] = 'OFF')
		{
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'POWR1   ',$0D" (*ON TV*) WAIT TIME_ON_TV { SEND_STRING DEVICE, "'IAVD4   ',$0D"  } (*HDMI 1 TV*)
		DO_PUSH(dvMultirum[1],KEYPAD_KEYDIGITAL_1[CASE_ZONE_][CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
		} ELSE 
		    {
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'IAVD4   ',$0D"   (*HDMI 1 TV*)
		DO_PUSH(dvMultirum[1],KEYPAD_KEYDIGITAL_1[CASE_ZONE_][CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
		    }
             }
      CASE 5: //  ЭФИРНОЕ ТВ
             { 
             IF (STATUS_SOURSE[CASE_ZONE_] = 'OFF')
		{
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'POWR1   ',$0D" (*ON TV*) WAIT TIME_ON_TV { SEND_STRING DEVICE, "'ITVD    ',$0D"  } (*DIGITAL TV*)
		} ELSE 
		    {
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'ITVD    ',$0D"   (*DIGITAL TV*)
		    }
             }
      CASE 15: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE_] = 'OFF'
	     SEND_STRING DEVICE, "'VOLM10  ',$0D"  
	     SEND_STRING DEVICE, "'ITVD    ',$0D"
	     WAIT 60 { SEND_STRING DEVICE, "'POWR0   ',$0D" }
             }
      }
      }
}

(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone кинотеатр ************************************)
(*******        ***************************)

BUTTON_EVENT [dvMultirum, KEYPAD_MAKROS_5]   //  управление макросами
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE_
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV DEVICE

      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_5)
      CASE_ZONE_ = 4
      DEVICE = SHARP_2
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК SAT 
      CASE 2:  //  ИСТОЧНИК MediaTank
      CASE 3:  //  ИСТОЧНИК Apple TV
      CASE 4:  //  ИСТОЧНИК Videoregistrator
             { 
             IF (STATUS_SOURSE[CASE_ZONE_] = 'OFF')
		{
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'POWR1   ',$0D" (*ON TV*) WAIT TIME_ON_TV { SEND_STRING DEVICE, "'IAVD4   ',$0D"  } (*HDMI 1 TV*)
	        DO_PUSH(dvMultirum[1],KEYPAD_PIONEER [1])  (* включить усилитель*) Wait 50 {DO_PUSH(dvMultirum[1],KEYPAD_PIONEER [4])}(* вход мультирума*)
		DO_PUSH(dvMultirum[1],KEYPAD_KEYDIGITAL_1[CASE_ZONE_][CASE_BUTTONS]) // ВЫХОД 1 ВХОД i                                                     
		} ELSE 
		    {
		    IF (STATUS_SOURSE[CASE_ZONE_] = "'S05'") 
			{
			DO_PUSH(dvMultirum[1],KEYPAD_PIONEER [1])  (* включить усилитель*) Wait 50 {DO_PUSH(dvMultirum[1],KEYPAD_PIONEER [4])}(* вход мультирума*)
			} ELSE {DO_PUSH(dvMultirum[1],KEYPAD_PIONEER [4])}(* вход мультирума*)
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'IAVD4   ',$0D"   (*HDMI 1 TV*)
		DO_PUSH(dvMultirum[1],KEYPAD_KEYDIGITAL_1[CASE_ZONE_][CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
		    }
             }
      CASE 5: //  ЭФИРНОЕ ТВ
             { 
             IF (STATUS_SOURSE[CASE_ZONE_] = 'OFF')
		{
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'POWR1   ',$0D" (*ON TV*) WAIT TIME_ON_TV { SEND_STRING DEVICE, "'ITVD    ',$0D"  } (*DIGITAL TV*)
		} ELSE 
		    {
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'ITVD    ',$0D"   (*DIGITAL TV*)
		DO_PUSH(dvMultirum[1],KEYPAD_PIONEER [2]) 
		    }
             }
      CASE 6: //  Электроника
             { 
             IF (STATUS_SOURSE[CASE_ZONE_] = 'OFF')
		{
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'POWR1   ',$0D" (*ON TV*) WAIT TIME_ON_TV { SEND_STRING DEVICE, "'IAVD4   ',$0D"  } (*HDMI 1 TV*)
	        DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[1]) (* включить усилитель*) Wait 50 {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[6])}(* вход Dune*)
		} ELSE 
		    {
		    IF (STATUS_SOURSE[CASE_ZONE_] = "'S05'") 
			{
			DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[1]) (* включить усилитель*) Wait 50 {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[6])}(* вход Dune*)
			} ELSE {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[6])}(* вход Dune*)
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'IAVD4   ',$0D"   (*HDMI 1 TV*)
		    }
             }
      CASE 7: //  Медиа стойка
             { 
             IF (STATUS_SOURSE[CASE_ZONE_] = 'OFF')
		{
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'POWR1   ',$0D" (*ON TV*) WAIT TIME_ON_TV { SEND_STRING DEVICE, "'IAVD4   ',$0D"  } (*HDMI 1 TV*)
	        DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[1]) (* включить усилитель*) Wait 50 {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[5])}(* вход DVR*)
		} ELSE 
		    {
		    IF (STATUS_SOURSE[CASE_ZONE_] = "'S05'") 
			{
			DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[1]) (* включить усилитель*) Wait 50 {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[5])}(* вход DVR*)
			} ELSE {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[5])}(* вход Dune*)
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'IAVD4   ',$0D"   (*HDMI 1 TV*)
		    }
             }
      CASE 8: //  PC 
             { 
             IF (STATUS_SOURSE[CASE_ZONE_] = 'OFF')
		{
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'POWR1   ',$0D" (*ON TV*) WAIT TIME_ON_TV { SEND_STRING DEVICE, "'IAVD4   ',$0D"  } (*HDMI 1 TV*)
	        DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[1]) (* включить усилитель*) Wait 50 {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[7])}(* вход SAT*)
		} ELSE 
		    {
		    IF (STATUS_SOURSE[CASE_ZONE_] = "'S05'") 
			{
			DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[1]) (* включить усилитель*) Wait 50 {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[7])}(* вход SAT*)
			} ELSE {DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[7])}(* вход Dune*)
		STATUS_SOURSE[CASE_ZONE_] = "'S',FORMAT('%02d',CASE_BUTTONS)"
		SEND_STRING DEVICE, "'IAVD4   ',$0D"   (*HDMI 1 TV*)
		    }
             }
      CASE 15: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE_] = 'OFF'
	     SEND_STRING DEVICE, "'VOLM10  ',$0D"  
	     SEND_STRING DEVICE, "'ITVD    ',$0D"
	     WAIT 60 { SEND_STRING DEVICE, "'POWR0   ',$0D" }
	     DO_PUSH(dvMultirum[1],KEYPAD_PIONEER [2])  (* выключить усилитель*)
             }
      }
      }
}

BUTTON_EVENT [dvMultirum, KEYPAD_MAKROS_5[20]]   //  управление макросами
{
PUSH:{Select_Audio_Video_Effects = 1}


HOLD[20]:
{
	LOCAL_VAR INTEGER NUM_MVP

	NUM_MVP = GET_LAST (dvMultirum)
	Select_Audio_Video_Effects = 2
	SEND_COMMAND dvMultirum[NUM_MVP],"'@PPN-[Sourse]_Cinema_Video_1'"
}
RELEASE:
{
	LOCAL_VAR INTEGER NUM_MVP

	IF (Select_Audio_Video_Effects = 1) 
			{
			NUM_MVP = GET_LAST (dvMultirum)
	                DO_PUSH (dvMultirum[1], KEYPAD_PIONEER[53])
			SEND_COMMAND dvMultirum[NUM_MVP],"'@PPN-[Sourse]_Cinema_Video_2'"
			}
}
}






(*+++++   Работа с Лутроном  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
DATA_EVENT [HWI]
    {
    OFFLINE: { IP_SERVER_OPEN (HWI.PORT, 245, IP_TCP) }
    STRING:  { SEND_STRING LUTRON, data.text          } // 
    }

DATA_EVENT [LUTRON]//
    {
    STRING: { SEND_STRING HWI, data.text }
    }

(*+++++   RGB подсветка проба  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
DATA_EVENT [DMX512] {ONLINE:{wait 30 SEND_COMMAND DMX512, 'DT10'}}

CUSTOM_EVENT[dvLutronLight2,201,1012]      // Fill Color
{
  local_var integer i
     
     i = 1
   
    (* Remove the hex color prefix *)
    REMOVE_STRING(CUSTOM.TEXT, '#', 1)
    (* fill it up *)
    strHexColor = CUSTOM.TEXT
    (* convert it *)
    nRed   [i] = HEXTOI(LEFT_STRING(strHexColor, 2))
    nGreen [i] = HEXTOI(MID_STRING(strHexColor, 3, 2))
    nBlue  [i] = HEXTOI(RIGHT_STRING(strHexColor, 2))
    (* send it out over RS232 *)
    SEND_LEVEL vdvRGB, nRed__Channel_LED1, nRed  [i]
    SEND_LEVEL vdvRGB, nGreenChannel_LED1, nGreen  [i]
    SEND_LEVEL vdvRGB, nBlue_Channel_LED1, nBlue  [i]
    
}

(* i have NO idea if this kills the frame *)
(* edit: guess not *)
BUTTON_EVENT[dvLutronLight2,201]
{
    (* but this works pretty well *)
    HOLD[1,REPEAT]:
    {
	(* first copy the value to an invisible button *)
	SEND_COMMAND dvLutronLight2, "'^BMC-',itoa (button.input.channel),',0,0,93,1,CF'"
	(* then get that value *)
	SEND_COMMAND dvLutronLight2,"'?BCF-',itoa (button.input.channel),',0'"
    }
} 

(*+++++    протечка воды    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
DATA_EVENT [IO_PROTE4KA]
{ONLINE:
 { 
 Wait 10 {
	IF ([vdvTempControl, KEYPAD_ZATOP[4]] && (ZatopCase = 0)) 
		{ON[vdvTempControl, KEYPAD_RELAY[5]] ON[vdvTempControl, KEYPAD_RELAY[6]] SEND_COMMAND dvPanelClimat, "'^SHO-',itoa(KEYPAD_ZATOP[1]),',0'" }
	else
	{SEND_COMMAND dvPanelClimat, "'^SHO-',itoa(KEYPAD_ZATOP[1]),',1'"}
	}
 }
}

DATA_EVENT [IR1_2]
{ONLINE:
 { 
	DVR_SELECT_ = 9
	MINUTE_ = TIME_TO_MINUTE( TIME )
	DVR_TIMER_OK = 1
 }
}


CHANNEL_EVENT [IO_PROTE4KA, 1]
CHANNEL_EVENT [IO_PROTE4KA, 2]
CHANNEL_EVENT [IO_PROTE4KA, 3]
CHANNEL_EVENT [IO_PROTE4KA, 4]
CHANNEL_EVENT [IO_PROTE4KA, 5]
CHANNEL_EVENT [IO_PROTE4KA, 6]
CHANNEL_EVENT [IO_PROTE4KA, 7]
CHANNEL_EVENT [IO_PROTE4KA, 8]
{OFF:                  
 { 
  ZatopZone = CHANNEL.CHANNEL
  SendTextToPanels (dvPanelClimat, KEYPAD_ZATOP[4], NAME_ZONE [ZatopZone])
 }
}






BUTTON_EVENT [vdvTempControl, KEYPAD_RELAY[5]]
{PUSH:{                                
    IF ([vdvTempControl, KEYPAD_RELAY[5]]) 
	    {OFF[vdvTempControl, KEYPAD_RELAY[5]]} 
    ELSE 
	    { 
	    IF ([vdvTempControl, KEYPAD_ZATOP[4]])   {ON[vdvTempControl, KEYPAD_RELAY[5]] ZatopCase = 0}
	    }
}}

BUTTON_EVENT [vdvTempControl, KEYPAD_RELAY[6]]
{PUSH:{                                
    IF ([vdvTempControl, KEYPAD_RELAY[6]]) 
	    {OFF[vdvTempControl, KEYPAD_RELAY[6]]} 
    ELSE 
	    { 
	    IF ([vdvTempControl, KEYPAD_ZATOP[4]])   {ON[vdvTempControl, KEYPAD_RELAY[6]] ZatopCase = 0}
	    }
}}


BUTTON_EVENT [vdvTempControl, KEYPAD_RELAY[7]]
{PUSH:{                                
    IF ([vdvTempControl, KEYPAD_RELAY[7]]) 
	    {
	    OFF[vdvTempControl, KEYPAD_RELAY[7]]
	    } 
    ELSE 
	    { 
	    ON[vdvTempControl, KEYPAD_RELAY[7]]
	    }
    }
}





CHANNEL_EVENT [vdvTempControl, KEYPAD_RELAY[5]]
CHANNEL_EVENT [vdvTempControl, KEYPAD_RELAY[6]]
{ON:
{
SEND_COMMAND dvPanelClimat, "'^SHO-',itoa(KEYPAD_ZATOP[1]),',0'"
}}

CHANNEL_EVENT [vdvTempControl, KEYPAD_ZATOP[4]]
{
    OFF:{
        OFF[vdvTempControl, KEYPAD_RELAY[5]]
	OFF[vdvTempControl, KEYPAD_RELAY[6]]
	ZatopCase = 1
	ZatopTime = LEFT_STRING (TIME, 5)
	ZatopData = "itoa(DATE_TO_DAY(LDATE)),'.',itoa(DATE_TO_MONTH(LDATE)),'.',itoa(DATE_TO_YEAR(LDATE))"
	SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_ZATOP[2]),',0,',ZatopTime"
	SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_ZATOP[3]),',0,',ZatopData"
	SEND_COMMAND dvPanelClimat, "'^SHO-',itoa(KEYPAD_ZATOP[1]),',1'"
    }
}

(*+++++    Текущее состояние системы при онлайне панели    ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)

// Реле температурок
BUTTON_EVENT [vdvTempControl, Relay24]
{PUSH:{                                    
IF ([vdvTempControl,button.input.channel]) {OFF[vdvTempControl,button.input.channel]} else {ON[vdvTempControl,button.input.channel]}
}} 



DATA_EVENT [dvPanelClimat]
{
 ONLINE:
 {
   local_var integer NumPanel
   LOCAL_VAR integer Numindex
   
   NumPanel = GET_LAST (dvPanelClimat)
   FOR (Numindex=1 ; Numindex <= 24 ; Numindex++)
   {
    SEND_COMMAND dvPanelClimat[NumPanel],"'^TXT-',itoa (Numindex),',0,', TempLevel_ch [Numindex] ,' C'" // вывод температуры
   }
   SEND_COMMAND dvPanelClimat[NumPanel],"'^TXT-',ITOA (KEYPAD_ZATOP[2]),',0,',ZatopTime"
   SEND_COMMAND dvPanelClimat[NumPanel],"'^TXT-',ITOA (KEYPAD_ZATOP[3]),',0,',ZatopData"
   SendTextToPanels (dvPanelClimat, KEYPAD_ZATOP[4], NAME_ZONE [ZatopZone])
	
    IF ([vdvTempControl, KEYPAD_ZATOP[4]] && (ZatopCase = 0)) 
		{SEND_COMMAND dvPanelClimat, "'^SHO-',itoa(KEYPAD_ZATOP[1]),',0'"}
    else
	        {SEND_COMMAND dvPanelClimat, "'^SHO-',itoa(KEYPAD_ZATOP[1]),',1'"}
 }
}

(*+++++   Температурные уровни (24 шт)   ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
LEVEL_EVENT [vdvTempControl, 1]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 1
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 2]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 2
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 3]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 3
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 4]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 4
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 5]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 5
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 6]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 6
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 7]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 7
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 8]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 8
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 9]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 9
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 10]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 10
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 11]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 11
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 12]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 12
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 13]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 13
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 14]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 14
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 15]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 15
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 16]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 16
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 17]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 17
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 18]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 18
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 19]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 19
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 20]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 20
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 22]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 21
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 21]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 22
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 23]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 23
	
	IF (Level.Value != 9990)
	{
	TempLevel_int [IndexTemp] = Level.Value + Pogrewnost_int[1]
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_int [IndexTemp]), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_int [IndexTemp]) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_int [IndexTemp])
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

LEVEL_EVENT [vdvTempControl, 24]  // 
 { 
	LOCAL_VAR INTEGER  IndexTemp
	LOCAL_VAR SINTEGER Level_Temp_sint
	IndexTemp = 24
	
	IF (Level.Value != 9990)
	{
	TempLevel_ylica = Level.Value
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TemperatureToStr(TempLevel_ylica), ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TemperatureToStr(TempLevel_ylica) ,' C'" // вывод температуры
        TempLevel_ch [IndexTemp]  = TemperatureToStr(TempLevel_ylica)
	}
	else
	{
	TempLevel_int [IndexTemp] = Level.Value
        TempLevel_ch [IndexTemp]  = "'??,?'"
	Send_String              0,"'T',    itoa (IndexTemp),' = ',TempLevel_ch [IndexTemp], ' C'"; // строка в диагностику
	SEND_COMMAND dvPanelClimat,"'^TXT-',itoa (IndexTemp),',0,',TempLevel_ch [IndexTemp], ' C'" // вывод температуры
	}
}

///// Отключение фазы A

BUTTON_EVENT [dvPanelClimat, KEYPAD_FASE [1]]
{PUSH:{
IF (FASE_[1] < 9)  { 
			    FASE_[1] = FASE_[1] + 1
			    SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [1]),',0,',itoa(FASE_[1]) ,' kW'"
			      }
      }
}

BUTTON_EVENT [dvPanelClimat, KEYPAD_FASE [2]]
{PUSH:{
IF (FASE_[1] > 3)  
                            {
			    FASE_[1] = FASE_[1] - 1
			    SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [1]),',0,',itoa(FASE_[1]) ,' kW'"
			    } 
      }
}


///// Отключение фазы B

BUTTON_EVENT [dvPanelClimat, KEYPAD_FASE [3]]
{PUSH:{
IF (FASE_[2] < 9)  { 
			    FASE_[2] = FASE_[2] + 1
			    SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [3]),',0,',itoa(FASE_[2]) ,' kW'"
			      }
      }
}

BUTTON_EVENT [dvPanelClimat, KEYPAD_FASE [4]]
{PUSH:{
IF (FASE_[2] > 3)  
                            {
			    FASE_[2] = FASE_[2] - 1
			    SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [3]),',0,',itoa(FASE_[2]) ,' kW'"
			    } 
      }
}


///// Отключение фазы C

BUTTON_EVENT [dvPanelClimat, KEYPAD_FASE [5]]
{PUSH:{
IF (FASE_[3] < 9)  { 
			    FASE_[3] = FASE_[3] + 1
			    SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [5]),',0,',itoa(FASE_[3]) ,' kW'"
			      }
      }
}

BUTTON_EVENT [dvPanelClimat, KEYPAD_FASE [6]]
{PUSH:{
IF (FASE_[3] > 3)  
                            {
			    FASE_[3] = FASE_[3] - 1
			    SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [5]),',0,',itoa(FASE_[3]) ,' kW'"
			    } 
      }
}

BUTTON_EVENT [dvPanelClimat, KEYPAD_FASE [9]]
{PUSH:{
SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [1]),',0,',itoa(FASE_[1]) ,' kW'"
SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [3]),',0,',itoa(FASE_[2]) ,' kW'"
SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_FASE [5]),',0,',itoa(FASE_[3]) ,' kW'"
}}                                                                  

                                         
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)


DEFINE_PROGRAM



WAIT 1
{



[dvPanelClimat, KEYPAD_ZATOP[1]] = (
![IO_PROTE4KA,  1] || ![IO_PROTE4KA,  2] || ![IO_PROTE4KA,  3] || ![IO_PROTE4KA,  4] || 
![IO_PROTE4KA,  5] || ![IO_PROTE4KA,  6] || ![IO_PROTE4KA,  7] || ![IO_PROTE4KA,  8] 
) 
[vdvTempControl, KEYPAD_ZATOP[4]] = (
[IO_PROTE4KA,  1] && [IO_PROTE4KA,  2] && [IO_PROTE4KA,  3] && [IO_PROTE4KA,  4] && 
[IO_PROTE4KA,  5] && [IO_PROTE4KA,  6] && [IO_PROTE4KA,  7] && [IO_PROTE4KA,  8] 
) 

[dvPanelClimat ,   KEYPAD_IO_CARD[1]] = [IO_PROTE4KA,  1 ]
[dvPanelClimat ,   KEYPAD_IO_CARD[2]] = [IO_PROTE4KA,  2 ]
[dvPanelClimat ,   KEYPAD_IO_CARD[3]] = [IO_PROTE4KA,  3 ]
[dvPanelClimat ,   KEYPAD_IO_CARD[4]] = [IO_PROTE4KA,  4 ]
[dvPanelClimat ,   KEYPAD_IO_CARD[5]] = [IO_PROTE4KA,  5 ]
[dvPanelClimat ,   KEYPAD_IO_CARD[6]] = [IO_PROTE4KA,  6 ]
[dvPanelClimat ,   KEYPAD_IO_CARD[7]] = [IO_PROTE4KA,  7 ]
[dvPanelClimat ,   KEYPAD_IO_CARD[8]] = [IO_PROTE4KA,  8 ]
[dvPanelClimat ,   KEYPAD_IO_CARD[9]] = [IO_PROTE4KA,  9 ]
[dvPanelClimat ,  KEYPAD_IO_CARD[10]] = [IO_PROTE4KA,  10]
                                                          
(************************ Zone 1 Зал ************************************)
[dvMultirum, KEYPAD_MAKROS_1[1]]  =  (STATUS_SOURSE [1] = 'S01')
[dvMultirum, KEYPAD_MAKROS_1[2]]  =  (STATUS_SOURSE [1] = 'S02')
[dvMultirum, KEYPAD_MAKROS_1[3]]  =  (STATUS_SOURSE [1] = 'S03')
[dvMultirum, KEYPAD_MAKROS_1[4]]  =  (STATUS_SOURSE [1] = 'S04')
[dvMultirum, KEYPAD_MAKROS_1[5]]  =  (STATUS_SOURSE [1] = 'S05')

[dvMultirum, KEYPAD_MAKROS_1[15]] =  (STATUS_SOURSE [1] = 'OFF')

(************************ Zone 2 Кинотеатр ************************************)
[dvMultirum, KEYPAD_MAKROS_5[1]]  =  (STATUS_SOURSE [4] = 'S01')
[dvMultirum, KEYPAD_MAKROS_5[2]]  =  (STATUS_SOURSE [4] = 'S02')
[dvMultirum, KEYPAD_MAKROS_5[3]]  =  (STATUS_SOURSE [4] = 'S03')
[dvMultirum, KEYPAD_MAKROS_5[4]]  =  (STATUS_SOURSE [4] = 'S04')
[dvMultirum, KEYPAD_MAKROS_5[5]]  =  (STATUS_SOURSE [4] = 'S05')
[dvMultirum, KEYPAD_MAKROS_5[6]]  =  (STATUS_SOURSE [4] = 'S06')
[dvMultirum, KEYPAD_MAKROS_5[7]]  =  (STATUS_SOURSE [4] = 'S07')
[dvMultirum, KEYPAD_MAKROS_5[8]]  =  (STATUS_SOURSE [4] = 'S08')

[dvMultirum, KEYPAD_MAKROS_5[15]] =  (STATUS_SOURSE [4] = 'OFF')

[dvPanelClimat, KEYPAD_CLIMATE_AUTO[1]]  =  (AUTO_REJIM_HOME = 1) // Авто стандарт
[dvPanelClimat, KEYPAD_CLIMATE_AUTO[2]]  =  (AUTO_REJIM_HOME = 2) // Авто + гости
[dvPanelClimat, KEYPAD_CLIMATE_AUTO[3]]  =  (AUTO_REJIM_HOME = 3) // АВТО + гости + персонал
[dvPanelClimat, KEYPAD_CLIMATE_AUTO[4]]  =  (AUTO_REJIM_HOME = 4) // АВТО ЭКОНОМ                    
[dvPanelClimat, KEYPAD_CLIMATE_AUTO[5]]  =  (AUTO_REJIM_HOME = 0) // Выключить режим авто
                                                              
                                   

}

///// таймер на включение Ок

Wait 2
{
IF ( DVR_TIMER_OK = 1)
{
IF (MINUTE_ != TIME_TO_MINUTE ( TIME ))
				    {
				    MINUTE_ = TIME_TO_MINUTE( TIME )
				    DVR_SELECT_ = DVR_SELECT_ - 1
				    SWITCH (DVR_SELECT_)
				    {
					CASE 6:{SET_PULSE_TIME (2) PULSE[IR1_2, 19]}
					CASE 3:{SET_PULSE_TIME (2) PULSE[IR1_2, 19]}
					CASE 0:{DVR_TIMER_OK = 0 SET_PULSE_TIME (2) PULSE[IR1_2, 19]}
				    }
				    }
}
}


///// Отключение фазы A


Wait 30
    {
	SELECT
	{
	ACTIVE ( SUMM_PARAM_[21] > FASE_[1] ) :
	    {
	    IF (CASE_WAIT_FASE_A_MAX = 0) 
		    {
		    CASE_WAIT_FASE_A_MAX = 1 
		    WAIT 200 'FASE_A_MAX' { 
		    IF([vdvTempControl, KEYPAD_RELAY[7]])   { OFF[vdvTempControl, KEYPAD_RELAY[7]] wait 100 {CASE_WAIT_FASE_A_MAX = 0}} 
							    else 
							    { IF(PAUSE_CASE_COND [1] = 0) {PAUSE_START[1] = 1 wait 100 {CASE_WAIT_FASE_A_MAX = 0}}}
					    }
		    }
	    //CASE_WAIT_FASE_A_MIN = 0 CANCEL_WAIT 'FASE_A_MIN'
	    }
	ACTIVE ( SUMM_PARAM_[21] < FASE_[1] ) :
	    {
	    CASE_WAIT_FASE_A_MAX = 0 CANCEL_WAIT 'FASE_A_MAX'
	    }
	ACTIVE ( SUMM_PARAM_[21] < (FASE_[1] - 2) ) :
	    {
	    IF(PAUSE_CASE_COND [1] = 1) {PAUSE_START[1] = 1 }
	    }
	}
    }


/// ВЫПОЛНЕНИЕ АВТО РЕЖИМА КЛИМАТА ТЕМПЕРАТУРНЫЙ РЕЖИМ 1 
WAIT 6000
{
    IF (AUTO_REJIM_HOME != 0)
    {
    SELECT
    {
    ACTIVE (TempLevel_ylica >=  250):                   	{IF (REJIM[1] != 1) {REJIM[1] = 1 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >=  160 && TempLevel_ylica <  250):	{IF (REJIM[1] != 2) {REJIM[1] = 2 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >=  120 && TempLevel_ylica <  160):	{IF (REJIM[1] != 3) {REJIM[1] = 3 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >=  050 && TempLevel_ylica <  120):	{IF (REJIM[1] != 4) {REJIM[1] = 4 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >=  000 && TempLevel_ylica <  050):	{IF (REJIM[1] != 5) {REJIM[1] = 5 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >= -050 && TempLevel_ylica <  000):	{IF (REJIM[1] != 6) {REJIM[1] = 6 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica >= -140 && TempLevel_ylica < -050):	{IF (REJIM[1] != 7) {REJIM[1] = 7 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
    ACTIVE (TempLevel_ylica <  -140):                  		{IF (REJIM[1] != 8) {REJIM[1] = 8 AUTO_1 (AUTO_REJIM_HOME, REJIM[1] )}}
                                                                                                                        
    }
    }
}

/// ВЫПОЛНЕНИЕ АВТО РЕЖИМА КЛИМАТА ТЕМПЕРАТУРНЫЙ РЕЖИМ 2 
WAIT 6000
{
    IF (AUTO_REJIM_HOME != 0)
    {
    SELECT
    {
    ACTIVE (TempLevel_ylica >=  160):                   	{IF (REJIM[2] != 1) {REJIM[2] = 1 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica >=  050 && TempLevel_ylica <  160):	{IF (REJIM[2] != 2) {REJIM[2] = 2 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica >=  000 && TempLevel_ylica <  050):	{IF (REJIM[2] != 3) {REJIM[2] = 3 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica >= -050 && TempLevel_ylica <  000):	{IF (REJIM[2] != 4) {REJIM[2] = 4 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica >= -140 && TempLevel_ylica < -050):	{IF (REJIM[2] != 5) {REJIM[2] = 5 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
    ACTIVE (TempLevel_ylica <  -140):                  		{IF (REJIM[2] != 6) {REJIM[2] = 6 AUTO_2 (AUTO_REJIM_HOME, REJIM[2] )}}
                                                                                                                              
    }
    }
}

/// ВЫПОЛНЕНИЕ АВТО РЕЖИМА КЛИМАТА ТЕМПЕРАТУРНЫЙ РЕЖИМ 3 
WAIT 6000
{
    IF (AUTO_REJIM_HOME != 0)
    {
    SELECT
    {
    ACTIVE (TempLevel_ylica >=  000):                   	{IF (REJIM[3] != 1) {REJIM[3] = 1 AUTO_3 (AUTO_REJIM_HOME, REJIM[3] )}}
    ACTIVE (TempLevel_ylica <   000):                  		{IF (REJIM[3] != 2) {REJIM[3] = 2 AUTO_3 (AUTO_REJIM_HOME, REJIM[3] )}}
                                                                                                                              
    }
    }
}



DEFINE_FUNCTION AUTO_1 (INTEGER AUTO_, INTEGER REJ )

{
// Гостиная
temprige_SAVE[4]  = AUTO_1_GOST_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE4 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[4]) , 4)"
temprige_SAVE[26] = AUTO_1_GOST_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE20[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[26]), 4)"
temprige_SAVE[10] = AUTO_1_GOST_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE12[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[10]), 4)"
                                                          
// столовая
temprige_SAVE[5]  = AUTO_1_STOL_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE5 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[5]) , 4)"
temprige_SAVE[11] = AUTO_1_STOL_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE13[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[11]), 4)"
                                                          
// гостевая 2 этаж
temprige_SAVE[15] = AUTO_1_GOST2E_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE15[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[15]), 4)"
                                                          
// спортзал
temprige_SAVE[17] = AUTO_1_SPORT_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE17[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[17]), 4)"
                                                          
// спальня 2 этаж основная
temprige_SAVE[19] = AUTO_1_OSN_SPAL_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE19[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[19]), 4)"
                                                          

SWITCH (REJIM_COND)
    {
    CASE 'COOL': 
		{
		DO_PUSH (vdvCondition, KEYPAD_CONDITION_1[AUTO_1_GOST_KOND_COOL     [AUTO_][REJ]])
    wait 40 {	DO_PUSH (vdvCondition, KEYPAD_CONDITION_3[AUTO_1_STOL_KOND_COOL     [AUTO_][REJ]])}
    wait 80 {	DO_PUSH (vdvCondition, KEYPAD_CONDITION_4[AUTO_1_GOST2E_KOND_COOL   [AUTO_][REJ]])}
    wait 120{	DO_PUSH (vdvCondition, KEYPAD_CONDITION_2[AUTO_1_OSN_SPAL_KOND_COOL [AUTO_][REJ]])}
		}                                   
    
    CASE 'HEAT': 
		{
		DO_PUSH (vdvCondition, KEYPAD_CONDITION_1[AUTO_1_GOST_KOND_HEAT     [AUTO_][REJ]])
    wait 40 {	DO_PUSH (vdvCondition, KEYPAD_CONDITION_3[AUTO_1_STOL_KOND_HEAT     [AUTO_][REJ]])}
    wait 80 {	DO_PUSH (vdvCondition, KEYPAD_CONDITION_4[AUTO_1_GOST2E_KOND_HEAT   [AUTO_][REJ]])}
    wait 120{	DO_PUSH (vdvCondition, KEYPAD_CONDITION_2[AUTO_1_OSN_SPAL_KOND_HEAT [AUTO_][REJ]])}
		}                                       
    }
}



DEFINE_FUNCTION AUTO_2 (INTEGER AUTO_, INTEGER REJ )
{
// СУ 1 эт гостевой
temprige_SAVE[3]  = AUTO_2_SY1GOST_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE3 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[3]) , 4)"

// Кухня
temprige_SAVE[6]  = AUTO_2_KYHNJA_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE6 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[6]) , 4)"
temprige_SAVE[12] = AUTO_2_KYHNJA_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE14[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[12]), 4)"

// Комната персонала
temprige_SAVE[1]  = AUTO_2_PRSON_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE1 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[1]) , 4)"
temprige_SAVE[9]  = AUTO_2_PRSON_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE11[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[9]), 4)"

// СУ персонала
temprige_SAVE[2]  = AUTO_2_SYPRSON_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE2 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[2]) , 4)"

// СУ гостевой 2 эт
temprige_SAVE[13]  = AUTO_2_SY2GOST_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE9 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[13]) , 4)"

// Зимний сад
temprige_SAVE[16] = AUTO_2_ZIMSAD_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE16[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[16]), 4)"

// СУ основной 2 эт
temprige_SAVE[14] = AUTO_2_SY2OSN_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE10[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[14]) , 4)"
temprige_SAVE[18] = AUTO_2_SY2OSN_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE18[1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[18]), 4)"
}


DEFINE_FUNCTION AUTO_3 (INTEGER AUTO_, INTEGER REJ )
{
// Тамбур
temprige_SAVE[7]  = AUTO_3_TAMBUR_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE7 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[7]) , 4)"

// Гардероб
temprige_SAVE[8]  = AUTO_3_GARDEROB_POL[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE8 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[8]) , 4)"

// Кладовая
temprige_SAVE[27]  = AUTO_3_KLADOVAJA_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE22 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[27]) , 4)"

// Котельнаяxd
temprige_SAVE[28]  = AUTO_3_KOTELN_BAT[AUTO_][REJ]  SEND_COMMAND dvPanelClimat,"'^TXT-',ITOA (KEYPAD_CLIMATE21 [1]),',0,',RIGHT_STRING( TemperatureToStr(temprige_SAVE[28]) , 4)"
}





