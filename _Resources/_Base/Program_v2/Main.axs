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

#include 'Keypad_Port_1.axi'
#include 'Keypad_Port_2.axi'
#include 'Keypad_Port_3.axi'
#include 'Keypad_Port_4.axi'
#include 'Keypad_Port_6.axi'
#include 'Channel_Zone.axi'
#include 'Misc.axi'
#include 'Integra_Port_6.axi'


DEFINE_DEVICE

//                                         _1             _2                  _3
// IR1   6001  192.168.4.39  Кинотеатр    | Strong       |                   |                  |
// IR2   6002  192.168.4.40  Зал (бас)    | AV  NAD      |                   | TV Зал (бас)     |
// IR3   6003  192.168.4.41  Зал (бас)    | DVD NAD      | FM NAD            |                  |
// IR4   6004  192.168.4.42  Спаль (хоз)  | AV PIONEER   | DVD Pioneer       | TV Спаль (хоз)   |
// IR5   6005  192.168.4.43  Спаль (дочь) |              |                   | TV Спаль (дочь)  |
// IR6   6006  192.168.4.44  Спаль (сын)  | CD центр     |                   | TV Спаль (сын)   |
// IR7   6007  192.168.4.45  Серверная    | TV бильярд   | TV Спортзал       |                  |
// IR8   6008  192.168.4.46  Серверная    | TV кухня     | TV Зал (вх)       |                  |
// IR9   6009  192.168.4.47  Серверная    |              | TV Бассейн        |                  |
// IR10  6010  192.168.4.48  Серверная    |              |                   |                  |
// IR11  6011  192.168.4.49  Серверная    | TV Кабинет(д)| TV Кабинет (хоз)  |                  |
// IR12  6012  192.168.4.50  Серверная    |              | TV Зимн.сад       |                  |
                                                                                              
// RS1   6101  192.168.4.51  Кинотеатр    | Runco (Proj) |                   | 
// RS2   6102  192.168.4.52  Серверная    | FM Tuner 1   | FM Tuner 2        | 
// RS3   6103  192.168.4.53  Серверная    | CoolMaster   | Audio 3232        | 
// RS4   6104  192.168.4.54  Серверная    | Power Contr. |                   | 
                                                                           

// MSD-431   1001  192.168.4.27 Кинотеатр
// MSD-431   1002  192.168.4.28 Бильярдная  
// MSD-431   1003  192.168.4.29 Спортзал
// MSD-431   1004  192.168.4.30 Кухня
// MSD-701   1005  192.168.4.31 Столовая 
// MSD-431   1006  192.168.4.32 Зал 
// MSD-431   1007  192.168.4.33 Басейн 
// MSD-701   1008  192.168.4.34 Спальня хозяина
// MSD-431   1009  192.168.4.35 СУ хозяна 
// MSD-431   1010  192.168.4.36 Спальня дочери 
// MSD-431   1011  192.168.4.37 Спальня сына 
// MSD-431   1012  192.168.4.38 Зимний сад                   
                      
// NXR-ZGW   1201  192.168.4.55 КИНОТЕАТР
// MIO-R4    1101  Cпальня хозяина
// MIO-R4    1102  Cпальня дочери
// MIO-R4    1103  Cпальня сына
// MIO-R4    1104  Кинотетар
           



lutron  = 0:81:1

             
// RS-232

TUNER_1      = 6102:1:1  // NUVO Tuner 1
TUNER_2      = 6102:2:1  // NUVO Tuner 2

KRAMER_AUDIO = 6103:2:1  // Kramer 32x32 AUDIO

dvModbus_1   = 6104:1:1  // Вентиляция

KRAMER_HDMI  = 5001:1:1  // Kramer 16x16 HDMI
KRAMER_SP50  = 5001:2:1  // PL 50 Kramer
Coolmaster   = 5001:7:1  // Coolmaster
dvSatel      = 5001:3:1  // Satel Integra LCD
                     // AMX(mini10)   - СпецРазъём(слева-направо): 1-1, 2-2, 3-3, 5-5
                     // AMX(DB9,мама) - СпецРазъём(слева-направо): 5-1, 2-2, 3-3, 7-5

// IO ports
IO       = 5001:17:1  //


// RELAY ports
RELAY       = 5001:8:1  //    реле 1 - управление воротами входными


// IR ports
IR1       = 5001:9 :1  // Openbox S9 (Input 1)
IR2       = 5001:10:1  // Openbox S9 (Input 2)
IR3       = 5001:11:1  // Openbox S9 (Input 3)
IR4       = 5001:12:1  // Openbox S9 (Input 4)
IR5       = 5001:13:1  // Openbox S9 (Input 5)
IR6       = 5001:14:1  // StrongDTV 
IR7       = 5001:15:1  // Apple TV        
IR8       = 5001:16:1  // HK        
                 

// Контролер системы 2

COM_S1_1    = 5001:1:2 // ADA 
RUNCO_1     = 6101:1:1 // RUNCO

IR_s1_1     = 5001:2:2  // Openbox S9
IR_s1_2     = 5001:3:2  // BluRay
// IO ports
IO_S1       = 5001:5:2  //



// Блоки Расширения ИК
                 
// IR1 
IR1_1      = 6001:1:1 // 
IR1_2      = 6001:2:1 // iNext
IR1_3      = 6001:3:1 // 
IR1_4      = 6001:4:1 // 
                
// IR2 
IR2_1      = 6002:1:1 // AV NAD S170i
IR2_2      = 6002:2:1 // DVD NAD S570
IR2_3      = 6002:3:1 // FM NAD S400
IR2_4      = 6002:4:1 // 
                
// IR3 
IR3_1      = 6003:1:1 // 
IR3_2      = 6003:2:1 // 
IR3_3      = 6003:3:1 // 
IR3_4      = 6003:4:1 // 
                
// IR4 
IR4_1      = 6004:1:1 // DVD Pioneer DV-320
IR4_2      = 6004:2:1 // AV Pioneer PDP-R04E
IR4_3      = 6004:3:1 // 
IR4_4      = 6004:4:1 // 
                
// IR5 
IR5_1      = 6005:1:1 // 
IR5_2      = 6005:2:1 // 
IR5_3      = 6005:3:1 // 
IR5_4      = 6005:4:1 // 
                
// IR6 
IR6_1      = 6006:1:1 // CD Panasonic
IR6_2      = 6006:2:1 // 
IR6_3      = 6006:3:1 // 
IR6_4      = 6006:4:1 // 
                
// IR7 
IR7_1      = 6007:1:1 // 
IR7_2      = 6007:2:1 // 
     
// IR8 
IR8_1      = 6008:1:1 // 
IR8_2      = 6008:2:1 // 
     
// IR9 
IR9_1      = 6009:1:1 // 
IR9_2      = 6009:2:1 // 
     
// IR10 
IR10_1      = 6010:1:1 // 
IR10_2      = 6010:2:1 // 
     
// IR11 
IR11_1      = 6011:1:1 // 
IR11_2      = 6011:2:1 // 
     
// IR12 
IR12_1      = 6012:1:1 // 
IR12_2      = 6012:2:1 // 
     

// Panels
// All Zone 
MVP1_1 = 11001:1:1 // iPad 1
MVP2_1 = 11002:1:1 // iPad 2
MVP3_1 = 11003:1:1 // iPad 3
MVP4_1 = 11004:1:1 // iPad 4
MVP5_1 = 11005:1:1 // iPad 5

MVP11_1 = 1001:1:1 // MSD-431  Кинотеатр
MVP12_1 = 1002:1:1 // MSD-431  Бильярдная  
MVP13_1 = 1003:1:1 // MSD-431  Спортзал
MVP14_1 = 1004:1:1 // MSD-431  Кухня
MVP15_1 = 1005:1:1 // MSD-701  Столовая 
MVP16_1 = 1006:1:1 // MSD-431  Зал 
MVP17_1 = 1007:1:1 // MSD-431  Басейн 
MVP18_1 = 1008:1:1 // MSD-701  Спальня хозяина
MVP19_1 = 1009:1:1 // MSD-431  СУ хозяна 
MVP20_1 = 1010:1:1 // MSD-431  Спальня дочери 
MVP21_1 = 1011:1:1 // MSD-431  Спальня сына 
MVP22_1 = 1012:1:1 // MSD-431  Зимний сад          
                              
// Lutron liGHT 
MVP1_2 = 11001:2:1 // iPad 1
MVP2_2 = 11002:2:1 // iPad 2
MVP3_2 = 11003:2:1 // iPad 3
MVP4_2 = 11004:2:1 // iPad 4
MVP5_2 = 11005:2:1 // iPad 5

MVP11_2 = 1001:2:1 // MSD-431
MVP12_2 = 1002:2:1 // MSD-431
MVP13_2 = 1003:2:1 // MSD-431
MVP14_2 = 1004:2:1 // MSD-431
MVP15_2 = 1005:2:1 // MSD-701
MVP16_2 = 1006:2:1 // MSD-431
MVP17_2 = 1007:2:1 // MSD-431
MVP18_2 = 1008:2:1 // MSD-701
MVP19_2 = 1009:2:1 // MSD-431
MVP20_2 = 1010:2:1 // MSD-431
MVP21_2 = 1011:2:1 // MSD-431
MVP22_2 = 1012:2:1 // MSD-431


// CoolMaster
MVP1_3 = 11001:3:1 // iPad 1
MVP2_3 = 11002:3:1 // iPad 2
MVP3_3 = 11003:3:1 // iPad 3
MVP4_3 = 11004:3:1 // iPad 4
MVP5_3 = 11005:3:1 // iPad 5

MVP11_3 = 1001:3:1 // MSD-431
MVP15_3 = 1005:3:1 // MSD-701
MVP18_3 = 1008:3:1 // MSD-701
MVP21_3 = 1011:3:1 // MSD-431
MVP22_3 = 1012:3:1 // MSD-431

              
// Cinema
MVP1_4 = 11001:4:1 // iPad 1
MVP2_4 = 11002:4:1 // iPad 2
MVP3_4 = 11003:4:1 // iPad 3
MVP4_4 = 11004:4:1 // iPad 4
MVP5_4 = 11005:4:1 // iPad 5

MVP11_4 = 1001:4:1 // MSD-431
MVP15_4 = 1005:4:1 // MSD-701
MVP18_4 = 1008:4:1 // MSD-701

// All Zone - (MCE)
MVP1_5 = 11001:5:1 // iPad 1
MVP2_5 = 11002:5:1 // iPad 2
MVP3_5 = 11003:5:1 // iPad 3
MVP4_5 = 11004:5:1 // iPad 4
MVP5_5 = 11005:5:1 // iPad 5

MVP11_5 = 1001:5:1 // MSD-431
MVP12_5 = 1002:5:1 // MSD-431
MVP13_5 = 1003:5:1 // MSD-431
MVP14_5 = 1004:5:1 // MSD-431
MVP15_5 = 1005:5:1 // MSD-701
MVP16_5 = 1006:5:1 // MSD-431
MVP17_5 = 1007:5:1 // MSD-431
MVP18_5 = 1008:5:1 // MSD-701
MVP19_5 = 1009:5:1 // MSD-431
MVP20_5 = 1010:5:1 // MSD-431
MVP21_5 = 1011:5:1 // MSD-431
MVP22_5 = 1012:5:1 // MSD-431
              
	      
// Охранка
MVP1_6 = 11001:6:1 // iPad 1
MVP2_6 = 11002:6:1 // iPad 2
MVP3_6 = 11003:6:1 // iPad 3
MVP4_6 = 11004:6:1 // iPad 4
MVP5_6 = 11005:6:1 // iPad 5

MVP15_6 = 1005:6:1 // MSD-701
MVP18_6 = 1008:6:1 // MSD-701

	      
// OpenBox 1 
MVP1_11 = 11001:11:1 // iPad 1
MVP2_11 = 11002:11:1 // iPad 2
MVP3_11 = 11003:11:1 // iPad 3
MVP4_11 = 11004:11:1 // iPad 4
MVP5_11 = 11005:11:1 // iPad 5
                  
MVP11_11 = 1001:11:1 // MSD-431
MVP12_11 = 1002:11:1 // MSD-431
MVP13_11 = 1003:11:1 // MSD-431
MVP14_11 = 1004:11:1 // MSD-431
MVP15_11 = 1005:11:1 // MSD-701
MVP16_11 = 1006:11:1 // MSD-431
MVP17_11 = 1007:11:1 // MSD-431
MVP18_11 = 1008:11:1 // MSD-701
MVP19_11 = 1009:11:1 // MSD-431
MVP20_11 = 1010:11:1 // MSD-431
MVP21_11 = 1011:11:1 // MSD-431
MVP22_11 = 1012:11:1 // MSD-431
                
// OpenBox 2
MVP1_12 = 11001:12:1 // iPad 1
MVP2_12 = 11002:12:1 // iPad 2
MVP3_12 = 11003:12:1 // iPad 3
MVP4_12 = 11004:12:1 // iPad 4
MVP5_12 = 11005:12:1 // iPad 5

MVP11_12 = 1001:12:1 // MSD-431
MVP12_12 = 1002:12:1 // MSD-431
MVP13_12 = 1003:12:1 // MSD-431
MVP14_12 = 1004:12:1 // MSD-431
MVP15_12 = 1005:12:1 // MSD-701
MVP16_12 = 1006:12:1 // MSD-431
MVP17_12 = 1007:12:1 // MSD-431
MVP18_12 = 1008:12:1 // MSD-701
MVP19_12 = 1009:12:1 // MSD-431
MVP20_12 = 1010:12:1 // MSD-431
MVP21_12 = 1011:12:1 // MSD-431
MVP22_12 = 1012:12:1 // MSD-431
               
// OpenBox 3   
MVP1_13 = 11001:13:1 // iPad 1
MVP2_13 = 11002:13:1 // iPad 2
MVP3_13 = 11003:13:1 // iPad 3
MVP4_13 = 11004:13:1 // iPad 4
MVP5_13 = 11005:13:1 // iPad 5

MVP11_13 = 1001:13:1 // MSD-431
MVP12_13 = 1002:13:1 // MSD-431
MVP13_13 = 1003:13:1 // MSD-431
MVP14_13 = 1004:13:1 // MSD-431
MVP15_13 = 1005:13:1 // MSD-701
MVP16_13 = 1006:13:1 // MSD-431
MVP17_13 = 1007:13:1 // MSD-431
MVP18_13 = 1008:13:1 // MSD-701
MVP19_13 = 1009:13:1 // MSD-431
MVP20_13 = 1010:13:1 // MSD-431
MVP21_13 = 1011:13:1 // MSD-431
MVP22_13 = 1012:13:1 // MSD-431
                 
// OpenBox 4
MVP1_14 = 11001:14:1 // iPad 1
MVP2_14 = 11002:14:1 // iPad 2
MVP3_14 = 11003:14:1 // iPad 3
MVP4_14 = 11004:14:1 // iPad 4
MVP5_14 = 11005:14:1 // iPad 5

MVP11_14 = 1001:14:1 // MSD-431
MVP12_14 = 1002:14:1 // MSD-431
MVP13_14 = 1003:14:1 // MSD-431
MVP14_14 = 1004:14:1 // MSD-431
MVP15_14 = 1005:14:1 // MSD-701
MVP16_14 = 1006:14:1 // MSD-431
MVP17_14 = 1007:14:1 // MSD-431
MVP18_14 = 1008:14:1 // MSD-701
MVP19_14 = 1009:14:1 // MSD-431
MVP20_14 = 1010:14:1 // MSD-431
MVP21_14 = 1011:14:1 // MSD-431
MVP22_14 = 1012:14:1 // MSD-431
                
                  
// OpenBox 5
MVP1_15 = 11001:15:1 // iPad 1
MVP2_15 = 11002:15:1 // iPad 2
MVP3_15 = 11003:15:1 // iPad 3
MVP4_15 = 11004:15:1 // iPad 4
MVP5_15 = 11005:15:1 // iPad 5

MVP11_15 = 1001:15:1 // MSD-431
MVP12_15 = 1002:15:1 // MSD-431
MVP13_15 = 1003:15:1 // MSD-431
MVP14_15 = 1004:15:1 // MSD-431
MVP15_15 = 1005:15:1 // MSD-701
MVP16_15 = 1006:15:1 // MSD-431
MVP17_15 = 1007:15:1 // MSD-431
MVP18_15 = 1008:15:1 // MSD-701
MVP19_15 = 1009:15:1 // MSD-431
MVP20_15 = 1010:15:1 // MSD-431
MVP21_15 = 1011:15:1 // MSD-431
MVP22_15 = 1012:15:1 // MSD-431
 

// Пульты управления
// Спальня хозяина 
MIOR4_01_01 = 1101:1:1  // мультирум
MIOR4_01_02 = 1101:2:1  // свет
MIOR4_01_06 = 1101:6:1  // Спутник
MIOR4_01_11 = 1101:11:1 // Источники

// Спальня дочери 
MIOR4_02_01 = 1102:1:1  // мультирум
MIOR4_02_02 = 1102:2:1  // свет
MIOR4_02_06 = 1102:6:1  // Спутник
MIOR4_02_11 = 1102:11:1 // Источники

// Спальня сына 
MIOR4_03_01 = 1103:1:1  // мультирум
MIOR4_03_02 = 1103:2:1  // свет
MIOR4_03_06 = 1103:6:1  // Спутник
MIOR4_03_11 = 1103:11:1 // Источники

// Кинотеатр
MIOR4_04_02 = 1104:2:1  // свет
MIOR4_04_04 = 1104:4:1  // кинотеатр
                  
// ВИРТУАЛЬНЫЕ УСТРОЙСТВА

vdvDEVCANNEL_1 = 33001:1:1 // NUVO FM TUNER 1
vdvDEVCANNEL_2 = 33002:1:1 // NUVO FM TUNER 2
vdvKRAMER_HDMI = 33003:1:1 // KRAMER HDMI
vdvCinema      = 33004:1:1 // Cinema virtual device
vdvFeedback    = 33005:1:1 // Feedback

// Виртуальные устройства для мультирум
vdvZONE_1  = 33101:1:1 // Зона 1
vdvZONE_2  = 33102:1:1 // Зона 2
vdvZONE_3  = 33103:1:1 // Зона 3
vdvZONE_4  = 33104:1:1 // Зона 4
vdvZONE_5  = 33105:1:1 // Зона 5
vdvZONE_6  = 33106:1:1 // Зона 6
vdvZONE_7  = 33107:1:1 // Зона 7
vdvZONE_8  = 33108:1:1 // Зона 8
vdvZONE_9  = 33109:1:1 // Зона 9
vdvZONE_10 = 33110:1:1 // Зона 10
vdvZONE_11 = 33111:1:1 // Зона 11
vdvZONE_12 = 33112:1:1 // Зона 12
vdvZONE_13 = 33113:1:1 // Зона 13
vdvZONE_14 = 33114:1:1 // Зона 14
vdvZONE_15 = 33115:1:1 // Зона 15
vdvZONE_16 = 33116:1:1 // Зона 16
vdvZONE_STR = 33117:1:1 // Буфер для парсинга команд

// Виртуальные устройства для кондиционера

vdvString = 34201:1:1

vdvDEV1_0 = 34200:1:1
vdvDEV1_1 = 34201:1:1
vdvDEV1_2 = 34202:1:1
vdvDEV1_3 = 34203:1:1
vdvDEV1_4 = 34204:1:1
vdvDEV1_5 = 34205:1:1
vdvDEV1_6 = 34206:1:1

// к Lutron
vdvHW_KEYPAD0  = 33300:1:1    // 
vdvHW_KEYPAD1  = 33201:1:1    // 
vdvHW_KEYPAD2  = 33202:1:1    // 
vdvHW_KEYPAD3  = 33203:1:1    // 
vdvHW_KEYPAD4  = 33204:1:1    // 
vdvHW_KEYPAD5  = 33205:1:1    // 
vdvHW_KEYPAD6  = 33206:1:1    // 
vdvHW_KEYPAD7  = 33207:1:1    // 
vdvHW_KEYPAD8  = 33208:1:1    // 
vdvHW_KEYPAD9  = 33209:1:1    // 
vdvHW_KEYPAD10 = 33210:1:1    // 
vdvHW_KEYPAD11 = 33211:1:1    // 
vdvHW_KEYPAD12 = 33212:1:1    // 
vdvHW_KEYPAD13 = 33213:1:1    // 
vdvHW_KEYPAD14 = 33214:1:1    // 
vdvHW_KEYPAD15 = 33215:1:1    // 
vdvHW_KEYPAD16 = 33216:1:1    // 
vdvHW_KEYPAD17 = 33217:1:1    // 
vdvHW_KEYPAD18 = 33218:1:1    // 
vdvHW_KEYPAD19 = 33219:1:1    // 
vdvHW_KEYPAD20 = 33220:1:1    // 
vdvHW_KEYPAD21 = 33221:1:1    // 
vdvHW_KEYPAD22 = 33222:1:1    // 
vdvHW_KEYPAD23 = 33223:1:1    // 
vdvHW_KEYPAD24 = 33224:1:1    // 
vdvHW_KEYPAD25 = 33225:1:1    // 
vdvHW_KEYPAD26 = 33226:1:1    // 
vdvHW_KEYPAD27 = 33227:1:1    // 
vdvHW_KEYPAD28 = 33228:1:1    // 
vdvHW_KEYPAD29 = 33229:1:1    // 
vdvHW_KEYPAD30 = 33230:1:1    // 

                 
vdvSatel     = 34300:1:1
vdvONLINE_S1 = 34301:1:1  
vdvModbus_1  = 34302:1:1


                                         
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT



(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

dev dvPanelAllZone[]= {MVP1_1, MVP2_1, MVP3_1, MVP4_1, MVP5_1, MVP11_1, MVP12_1, MVP13_1, MVP14_1, MVP15_1, MVP16_1, MVP17_1, MVP18_1, MVP19_1, MVP20_1, MVP21_1, MVP22_1} // All Zone
DEV dvLutronLight2[]= {MVP1_2, MVP2_2, MVP3_2, MVP4_2, MVP5_2, MVP15_2, MVP18_2, MVP11_2, MVP14_2, MVP16_2, MVP17_2, MVP21_2, MVP22_2} // Lutron Light
dev dvCoolMaster  []= {MVP1_3, MVP2_3, MVP3_3, MVP4_3, MVP5_3, MVP15_3, MVP18_3, MVP11_3, MVP21_3, MVP22_3} // Coolmaster
dev dvCinema      []= {MVP1_4, MVP2_4, MVP3_4, MVP4_4, MVP5_4, MVP11_4, MVP15_4, MVP18_4} // Cinema
dev dvAlarmMas     []= {MVP1_6, MVP2_6, MVP3_6, MVP4_6, MVP5_6, MVP15_6, MVP18_6} // Integra 1
dev dvAlarmMas_Send_[]= {MVP1_1, MVP2_1, MVP3_1, MVP4_1, MVP5_1, MVP15_1, MVP18_1} // Integra 2
                                              
dev dvPanelZone_1  []= {MVP1_11, MVP2_11, MVP3_11, MVP4_11, MVP5_11, MVP11_11, MVP12_11, MVP13_11, MVP14_11, MVP15_11, MVP16_11, MVP17_11, MVP18_11, MVP19_11, MVP20_11, MVP21_11, MVP22_11} // 
dev dvPanelZone_2  []= {MVP1_12, MVP2_12, MVP3_12, MVP4_12, MVP5_12, MVP11_12, MVP12_12, MVP13_12, MVP14_12, MVP15_12, MVP16_12, MVP17_12, MVP18_12, MVP19_12, MVP20_12, MVP21_12, MVP22_12} // 
dev dvPanelZone_3  []= {MVP1_13, MVP2_13, MVP3_13, MVP4_13, MVP5_13, MVP11_13, MVP12_13, MVP13_13, MVP14_13, MVP15_13, MVP16_13, MVP17_13, MVP18_13, MVP20_13, MVP21_13, MVP22_13} // 
dev dvPanelZone_4  []= {MVP1_14, MVP2_14, MVP3_14, MVP4_14, MVP5_14, MVP11_14, MVP12_14, MVP13_14, MVP14_14, MVP15_14, MVP16_14, MVP17_14, MVP18_14, MVP20_14, MVP21_14, MVP22_14} // 
dev dvPanelZone_5  []= {MVP1_15, MVP2_15, MVP3_15, MVP4_15, MVP5_15, MVP11_15, MVP12_15, MVP13_15, MVP14_15, MVP15_15, MVP16_15, MVP17_15, MVP18_15, MVP20_15, MVP21_15, MVP22_15} // 
                                                                                                                                                                                         
DEV MVP_MCE1 [] =  {MVP1_5, MVP2_5, MVP3_5, MVP4_5, MVP5_5, MVP11_5, MVP12_5, MVP13_5, MVP14_5, MVP15_5, MVP16_5, MVP17_5, MVP18_5, MVP19_5, MVP20_5, MVP21_5, MVP22_5} // For MCE Server


DEV ALL_PORT_1001[]  =  { MVP11_1, MVP11_2, MVP11_3, MVP11_4,  MVP11_5,  MVP11_11, MVP11_12, MVP11_13, MVP11_14, MVP11_15}
DEV ALL_PORT_1002[]  =  { MVP12_1, MVP12_5, MVP12_11,MVP12_12, MVP12_13, MVP12_14, MVP12_15}
DEV ALL_PORT_1003[]  =  { MVP13_1, MVP13_5, MVP13_11,MVP13_12, MVP13_13, MVP13_14, MVP13_15}
DEV ALL_PORT_1004[]  =  { MVP14_1, MVP14_2, MVP14_5, MVP14_11, MVP14_12, MVP14_13, MVP14_14, MVP14_15}
DEV ALL_PORT_1005[]  =  { MVP15_1, MVP15_2, MVP15_3, MVP15_4,  MVP15_5,  MVP15_11, MVP15_12, MVP15_13, MVP15_14, MVP15_15}
DEV ALL_PORT_1006[]  =  { MVP16_1, MVP16_2, MVP16_5, MVP16_11, MVP16_12, MVP16_13, MVP16_14, MVP16_15}
DEV ALL_PORT_1007[]  =  { MVP17_1, MVP17_2, MVP17_5, MVP17_11, MVP17_12, MVP17_13, MVP17_14, MVP17_15}
DEV ALL_PORT_1008[]  =  { MVP18_1, MVP18_2, MVP18_3, MVP18_4,  MVP18_5,  MVP18_11, MVP18_12, MVP18_13, MVP18_14, MVP18_15}
DEV ALL_PORT_1009[]  =  { MVP19_1, MVP19_5, MVP19_11,MVP19_12, MVP19_13, MVP19_14, MVP19_15}
DEV ALL_PORT_1010[]  =  { MVP20_1, MVP20_5, MVP20_11,MVP20_12, MVP20_13, MVP20_14, MVP20_15}
DEV ALL_PORT_1011[]  =  { MVP21_1, MVP21_2, MVP21_3, MVP21_5,  MVP21_11, MVP21_12, MVP21_13, MVP21_14, MVP21_15}
DEV ALL_PORT_1012[]  =  { MVP22_1, MVP22_2, MVP22_3, MVP22_5,  MVP22_11, MVP22_12, MVP22_13, MVP22_14, MVP22_15}
                                                                                                                   
// масив пультов управления
DEV MIO_SOURSE_11[] = {MIOR4_01_11, MIOR4_02_11, MIOR4_03_11}
DEV MIO_BO_1[] = {MIOR4_01_11}
DEV MIO_BO_2[] = {MIOR4_02_11}
DEV MIO_SOURSE_6[] = {MIOR4_01_06, MIOR4_02_06, MIOR4_03_06}
DEV MIO_CINEMA_4[] = {MIOR4_04_04}




DEV ZONE_ALL[] = 
{
vdvZONE_1,
vdvZONE_2,
vdvZONE_3,
vdvZONE_4,
vdvZONE_5,
vdvZONE_6,
vdvZONE_7,
vdvZONE_8,
vdvZONE_9,
vdvZONE_10,
vdvZONE_11,
vdvZONE_12 
}

DEV VDV[] = 
{
	vdvDEV1_0, 
	vdvDEV1_1, 
	vdvDEV1_2, 
	vdvDEV1_3, 
	vdvDEV1_4, 
	vdvDEV1_5, 
	vdvDEV1_6
}               

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
	vdvHW_KEYPAD23,
	vdvHW_KEYPAD24,
	vdvHW_KEYPAD25,
	vdvHW_KEYPAD26,
	vdvHW_KEYPAD27,
	vdvHW_KEYPAD28,
	vdvHW_KEYPAD29,
	vdvHW_KEYPAD30 
}                   

VOLATILE INTEGER ON_line_HW

volatile INTEGER OFFSET0    = 0
volatile INTEGER OFFSET50   = 50
volatile INTEGER OFFSET100  = 100
volatile INTEGER OFFSET200  = 200
volatile INTEGER OFFSET300  = 300
volatile INTEGER OFFSET400  = 400
volatile INTEGER OFFSET500  = 500
volatile INTEGER OFFSET600  = 600
volatile INTEGER OFFSET700  = 700
volatile INTEGER OFFSET800  = 800
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

volatile INTEGER SOURSE_HDMI16x16[16]
VOLATILE INTEGER INDEX_I,  INDEX_V

PERSISTENT CHAR STATUS_SOURSE [12] [3]
PERSISTENT CHAR STATUS_TV [12] [3]
volatile INTEGER TIME_ON_TV_50 = 50
volatile INTEGER TIME_ON_TV_60 = 90
volatile INTEGER TIME_ON_TV_70 = 100
volatile INTEGER TIME_ON_TV_80 = 110
volatile INTEGER TIME_ON_TV_90 = 120
                                 

// состояние зон мультирума
PERSISTENT INTEGER VOLUME_ZONE_MR [32]
PERSISTENT INTEGER SELECT_ZONE_MR [32]
PERSISTENT INTEGER BASY_SOURSE    [32]

PERSISTENT INTEGER BASY_SOURSE_HDMI [16]

PERSISTENT CHAR CINEMA_POWER  [4]
PERSISTENT CHAR CINEMA_SOURSE [5]
PERSISTENT INTEGER VOLUME_AVR  // громкость в кинотеатре


///// переменные к пультам управления MIOR4
// Пульт в спальни хозяина

VOLATILE INTEGER SAVE_1_NUM_PAGE_

///////////////////////// переменные к охранной сигнализации

// Описание массивов для состояний групп, зон, неисправностей и выходов

VOLATILE INTEGER Channel_ALARM
VOLATILE INTEGER ALARM_SOUND
VOLATILE SINTEGER  time_sxxx


// Partitions state
persistent Char Partitions_Armed[32];                       // Partitions armed (with suppressed status)
persistent Char Partitions_EntryTime[32];                   // Partitions with entry time
persistent Char Partitions_ExitTime_More10secs[32];         // Partitions with exit time >10sec.
persistent Char Partitions_ExitTime_Less10secs[32];         // Partitions with exit time <10sec.
persistent Char Partitions_Alarm[32];                       // Partitions with alarm
persistent Char Partitions_FireAlarm[32];                   // Partitions with fire alarm
persistent Char Partitions_AlarmMemory[32];                 // Partitions with alarm memory
persistent Char Partitions_FireAlarmMemory[32];             // Partitions with fire alarm memory
persistent Char Partitions_Really_Armed[32];                // Partitions really armed (without suppressed status)
persistent Char Partitions_TempBlocked[32];                 // Partitions temporary blocked (partitions type 1)
persistent Char Partitions_Blocked[32];                     // Partitions blocked for guard round
persistent Char Partitions_Arming_Mode_2[32];               // Partitions with arming mode 2
persistent Char Partitions_Arming_Mode_3[32];               // Partitions with arming mode 3
persistent Char Partitions_1st_Code_Entered[32];            // Partitions with 1st code entered


// Zones state
persistent Char Zones_Violation[128];                       // Zones violation
persistent Char Zones_Tamper[128];                          // Zones tamper
persistent Char Zones_Alarm[128];                           // Zones alarm
persistent Char Zones_AlarmMemory[128]                      // Zones tamper alarm
persistent Char Zones_TamperAlarm[128];                     // Zones alarm memory
persistent Char Zones_TamperAlarmMemory[128];               // Zones tamper alarm memory
persistent Char Zones_Bypass[128];                          // Zones bypasses
persistent Char Zones_Trouble_NoViolation[128];             // Zones "no violation" trouble
persistent Char Zones_Trouble_LongViolation[128];           // Zones "long violation" trouble


// Troubles
// Packet 0x54
persistent Char Troubles_Zones[128];                        // Troubles of zones
persistent Char Troubles_Expanders_AC[64];                  // AC troubles of expanders
persistent Char Troubles_Expanders_BATT[64];                // BATT troubles of expanders
persistent Char Troubles_Expanders_NO_BATT[64];             // NO BATT troubles of expanders
persistent Char Troubles_System[24];                        // System troubles - See description below
persistent Char Troubles_Synoptic_AC[8];                    // AC troubles of synoptic tables
persistent Char Troubles_Synoptic_BATT[8];                  // BATT troubles of synoptic tables
persistent Char Troubles_Synoptic_NO_BATT[8];               // NO BATT troubles of synoptic tables

// Packet 0x57
persistent Char Troubles_Head_A_Proximity[64];              // Troubles of head A of proximity card readers
persistent Char Troubles_Head_B_Proximity[64];              // Troubles of head B of proximity card readers
persistent Char Troubles_Expanders_Overload[64];            // Overload of expanders supply outputs
persistent Char Troubles_Expanders_ShortCircut[16];         // Addressable zone expanders short circut or jammed ACU-100 modules

// Packet 0x59
persistent Char Troubles_ExpandersNoCommunication[64];      // Expanders with no communication
persistent Char Troubles_SwitcherooedExpanders[64];         // Switcherooed expanders
persistent Char Troubles_LcdKeypadsNoCommunication[8];      // LCD keypads with no communication
persistent Char Troubles_SwitcherooedLcdKeypads[8];         // Switcherooed LCD keypads
persistent Char Troubles_ETHM_NoNetwork[8];                 // ETHM-1 modules with no network cable

// Packet 0x58 - If there is no ACU-100 modules in the system, the packet 0x58 is not sent
persistent Char Troubles_JamLevel_ACU100[112];              // Jam level of ACU-100 modules
persistent Char Troubles_RadioDevicesLowBattery[112];       // Radio devices with low battery
persistent Char Troubles_RadioDevicesNoCommunication[112];  // Radio devices with no communication
persistent Char Troubles_RadioOutputsNoCommunication[112];  // Radio outputs with no communication


// Outputs state
persistent Char Outputs_State[128];                         // Outputs state


// Описание вспомогательных флагов, значения получаются в ежесекундном пакете времени

// Flags
persistent Char Flag_ServiceMode;                           // Service mode flag
persistent Char Flag_Trouble;                               // General trouble flag



// Описание элементов массива Troubles_System:
// [01] - OUT1 trouble
// [02] - OUT2 trouble
// [03] - OUT3 trouble
// [04] - OUT4 trouble
// [05] - +KPD trouble
// [06] - +EX1 or +EX2 trouble
// [07] - BATT trouble
// [08] - AC trouble
// [09] - DT1 trouble
// [10] - DT2 trouble
// [11] - DTM trouble
// [12] - RTC trouble
// [13] - no DTR signal
// [14] - no BATT present
// [15] - external modem initialization trouble
// [16] - external model command (ATE0V1Q0H0S0=0) trouble
// [17] - no voltage on telephone line
// [18] - bad signal on telephone line
// [19] - no signal on telephone line
// [20] - monitoring to station 1 trouble
// [21] - monitoring to station 2 trouble
// [22] - EEPROM memory trouble
// [23] - RAM memory trouble




(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)

DEFINE_CONSTANT
                    
VOLATILE INTEGER CONST_MCS_ON = 2001 // ON  NUVO 
VOLATILE INTEGER CONST_MCS_OF = 2002 // OFF NUVO 
                    
VOLATILE INTEGER CONST_MCS_1 = 2011 // ON Sourse A on NUVO
VOLATILE INTEGER CONST_MCS_2 = 2012 // ON Sourse B on NUVO
VOLATILE INTEGER CONST_MCS_3 = 2013 // ON Sourse C on NUVO
VOLATILE INTEGER CONST_MCS_4 = 2014 // ON Sourse D on NUVO

VOLATILE INTEGER T_WAIT = 1800



VOLATILE CHAR POPUP_SOURSE [7] [20] = 
	{
	    '[Sourse]_Sat_01',
	    '[Sourse]_Sat_02',
	    '[Sourse]_Sat_03',
	    '[Sourse]_Sat_04',
	    '[Sourse]_Sat_05',
	    '[Sourse]_Strong_01',
	    '[Sourse]_AppleTV'            
	}

VOLATILE CHAR PAGE_ZONE [10] [20] = 
	{
	    '_Main_Z1_1',             // 1
	    '_Main_Z2_1',             // 2
	    '_Main_Z3_1',             // 3
	    '_Main_Z4_1'              // 4
	}                                     


VOLATILE CHAR PAGE_SOURSE [20] [20] = 
	{
	    '[Sourse]_Sat',             // 1
	    '[Sourse]_Sat',             // 2
	    '[Sourse]_Sat',             // 3
	    '[Sourse]_Sat',             // 4
	    '[Sourse]_Sat',             // 5
	    '[Sourse]_Strong_01',       // 6
	    '[Sourse]_AppleTV',         // 7     
	    '',                         // 8     
	    '',                         // 9     
	    '',                         // 10     
	    '',                         // 11     
	    '',                         // 12     
	    '',                         // 13     
	    '',                         // 14     
	    '',                         // 15     
	    '',                         // 16     
	    '',                         // 17     
	    ''                          // 18     
	}                                  

VOLATILE CHAR AUDIO_ZONE [20] [200] = 
	{
	    '04110438043B044C044F04400434043D0430044F',                  // 1 Бильярдная
	    '0421043F043E0440044204370430043B',                          // 2 Спортзал
	    '0421042300200445043E0437044F04350432',                      // 3 СУ хозяев
	    '0421043F0430043B044C043D044F00200445043E0437044F04350432',  // 4 Спальня хозяев
	    '041A04430445043D044F',                                      // 5 Кухня
	    '04210442043E043B043E04320430044F',                          // 6 Столовая
	    '04170430043B',                                              // 7 Зал    
	    '0421043F0430043B044C043D044F00200441044B043D0430',          // 8 Спальня сына    
	    '0421043F0430043B044C043D044F00200434043E0447043504400438',  // 9 Спальня дочери    
	    '04170438043C043D043804390020044104300434',                  // 10 Зимний сад    
	    '041104300441044104350439043D',                              // 11 Бассейн        
	    '',                         // 12     
	    '',                         // 13     
	    '',                         // 14     
	    '',                         // 15     
	    '',                         // 16     
	    '',                         // 17     
	    ''                          // 18     
	}                                  

VOLATILE CHAR VIDEO_ZONE [20] [200] = 
	{
	    '', // 1  
	    '', // 2  
	    '', // 3  
	    '', // 4  
	    '04110438043B044C044F04400434043D0430044F',                        // 5 Бильярдная
	    '0421043F043E0440044204370430043B',                                // 6 Спортзал
	    '041A04430445043D044F',                                            // 7 Кухня
	    '04210442043E043B043E04320430044F',                                // 8 Столовая
	    '04170430043B',                                                    // 9 Зал
	    '041104300441044104350439043D',                                    // 10 Бассейн
	    '0421043F0430043B044C043D044F00200445043E0437044F04350432',        // 11 Спальня хозяев     
	    '0421043F0430043B044C043D044F00200434043E0447043504400438',        // 12 Спальня дочери      
	    '041A043004310438043D0435044200200434043E0447043504400438',        // 13 Кабинет дочери    
	    '041A043004310438043D0435044200200445043E0437044F0438043D0430',    // 14 Кабинет хозяина    
	    '0421043F0430043B044C043D044F00200441044B043D0430',                // 15 Спальня сына
	    '04170438043C043D043804390020044104300434',                        // 16 Зимний сад        
	    '',                         // 17     
	    '',                         // 18     
	    ''                          // 19     
	}                                  

VOLATILE CHAR AUDIO_ZONE_NUMB [20] [3] = 
	{
	    '005',  // 1 Бильярдная         
	    '008',  // 2 Спортзал
	    '110',  // 3 СУ хозяев
	    '109',  // 4 Спальня хозяев
	    '102',  // 5 Кухня
	    '104',  // 6 Столовая
	    '104',  // 7 Зал     
	    '209',  // 8 Спальня сына          
	    '204',  // 9 Спальня дочери      
	    '213',  // 10 Зимний сад         
	    '107',  // 11 Бассейн        
	    '',     // 12       
	    '',     // 13     
	    '',     // 14     
	    ''      // 15     
	}                                  

VOLATILE CHAR VIDEO_ZONE_NUMB [20] [3] = 
	{
	    '', // 1  
	    '', // 2  
	    '', // 3  
	    '', // 4  
	    '005',  // 5 Бильярдная
	    '008',  // 6 Спортзал
	    '102',  // 7 Кухня
	    '104',  // 8 Столовая
	    '104',  // 9 Зал
	    '107',  // 10 Бассейн
	    '109',  // 11 Спальня хозяев     
	    '204',  // 12 Спальня дочери      
	    '206',  // 13 Кабинет дочери    
	    '207',  // 14 Кабинет хозяина    
	    '209',  // 15 Спальня сына
	    '213',  // 16 Зимний сад        
	    '',     // 17     
	    '',     // 18     
	    ''      // 19     
	}                                  






// RS управление
DEFINE_MODULE 'NUVO_Tuner' NUVO_Tuner_1 (TUNER_1, dvPanelZone_1, vdvDEVCANNEL_1, KEYPAD_TUNER, MasFMRadioKiev)
DEFINE_MODULE 'NUVO_Tuner' NUVO_Tuner_2 (TUNER_2, dvPanelZone_2, vdvDEVCANNEL_2, KEYPAD_TUNER, MasFMRadioKiev)
DEFINE_MODULE 'KRAMER_VS_16x16HDMI_v2' KRAMER_VS_16x16HDMI_v2 (KRAMER_HDMI, vdvKRAMER_HDMI, dvPanelAllZone, KEYPAD_HDMI_KRAMER, SOURSE_HDMI16x16, BASY_SOURSE_HDMI)

DEFINE_MODULE 'Reboot_SAT_Kramer' Reboot_SAT_Kramer_1 (KRAMER_SP50, dvPanelAllZone, KEYPAD_SP50_KRAMER_1, CHANNEL_OFF_SAT[1])
DEFINE_MODULE 'Reboot_SAT_Kramer' Reboot_SAT_Kramer_2 (KRAMER_SP50, dvPanelAllZone, KEYPAD_SP50_KRAMER_2, CHANNEL_OFF_SAT[2])
DEFINE_MODULE 'Reboot_SAT_Kramer' Reboot_SAT_Kramer_3 (KRAMER_SP50, dvPanelAllZone, KEYPAD_SP50_KRAMER_3, CHANNEL_OFF_SAT[3])
DEFINE_MODULE 'Reboot_SAT_Kramer' Reboot_SAT_Kramer_4 (KRAMER_SP50, dvPanelAllZone, KEYPAD_SP50_KRAMER_4, CHANNEL_OFF_SAT[4])
DEFINE_MODULE 'Reboot_SAT_Kramer' Reboot_SAT_Kramer_5 (KRAMER_SP50, dvPanelAllZone, KEYPAD_SP50_KRAMER_5, CHANNEL_OFF_SAT[5])
                                                                                                                        
DEFINE_MODULE 'Reboot_SAT_IO' Reboot_SAT_Kramer_6 (IO_S1, dvCinema, KEYPAD_SP50_IO_____6)

DEFINE_MODULE 'module Modbus Master' mdl_Modbus (dvModbus_1, vdvModbus_1)
DEFINE_MODULE 'Daikin_ModBus_COMM_1' mdl_Modbus   (vdvModbus_1, dvModbus_1, dvPanelAllZone, KEYPAD_VENT_MODBUS)   // 1-6 адреса                    


//======================= AMX Multirum ===============================================================================================
DEFINE_MODULE 'KRAMER_3232_COMM' KRAMER_3232_COMM (KRAMER_AUDIO, ZONE_ALL, vdvZONE_STR)

DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_1,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_1,   VolumeLevel[1],   VOLUME_ZONE_MR[1],   SELECT_ZONE_MR[1], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_2,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_2,   VolumeLevel[2],   VOLUME_ZONE_MR[2],   SELECT_ZONE_MR[2], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_3,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_3,   VolumeLevel[3],   VOLUME_ZONE_MR[3],   SELECT_ZONE_MR[3], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_4,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_4,   VolumeLevel[4],   VOLUME_ZONE_MR[4],   SELECT_ZONE_MR[4], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_5,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_5,   VolumeLevel[5],   VOLUME_ZONE_MR[5],   SELECT_ZONE_MR[5], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_6,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_6,   VolumeLevel[6],   VOLUME_ZONE_MR[6],   SELECT_ZONE_MR[6], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_7,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_7,   VolumeLevel[7],   VOLUME_ZONE_MR[7],   SELECT_ZONE_MR[7], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_8,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_8,   VolumeLevel[8],   VOLUME_ZONE_MR[8],   SELECT_ZONE_MR[8], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_9,   dvPanelAllZone, KEYPAD_AUDIO_MAKROS_9,   VolumeLevel[9],   VOLUME_ZONE_MR[9],   SELECT_ZONE_MR[9], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_10,  dvPanelAllZone, KEYPAD_AUDIO_MAKROS_10,  VolumeLevel[10],  VOLUME_ZONE_MR[10],  SELECT_ZONE_MR[10], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_11,  dvPanelAllZone, KEYPAD_AUDIO_MAKROS_11,  VolumeLevel[11],  VOLUME_ZONE_MR[11],  SELECT_ZONE_MR[11], BASY_SOURSE)
DEFINE_MODULE 'KRAMER_3232_UI'   KRAMER_3232_UI  (vdvZONE_12,  dvPanelAllZone, KEYPAD_AUDIO_MAKROS_12,  VolumeLevel[12],  VOLUME_ZONE_MR[12],  SELECT_ZONE_MR[12], BASY_SOURSE)
                                                                                                                                                          
                                                                                                                       
																    
// ИК управление
// контролер
DEFINE_MODULE 'MODULE_IR_V1' SAT_1     (IR1, dvPanelZone_1, KEYPAD_OPENBOX,    OFFSET200, PULSE_TIME_1)      // Openbox Input 1
DEFINE_MODULE 'MODULE_IR_V1' SAT_2     (IR2, dvPanelZone_2, KEYPAD_OPENBOX,    OFFSET200, PULSE_TIME_1)      // Openbox Input 2
DEFINE_MODULE 'MODULE_IR_V1' SAT_3     (IR3, dvPanelZone_3, KEYPAD_OPENBOX,    OFFSET200, PULSE_TIME_1)      // Openbox Input 3
DEFINE_MODULE 'MODULE_IR_V1' SAT_4     (IR4, dvPanelZone_4, KEYPAD_OPENBOX,    OFFSET200, PULSE_TIME_1)      // Openbox Input 4
DEFINE_MODULE 'MODULE_IR_V1' SAT_5     (IR5, dvPanelZone_5, KEYPAD_OPENBOX,    OFFSET200, PULSE_TIME_1)      // Openbox Input 5
DEFINE_MODULE 'MODULE_IR_V1' STRONG    (IR6, dvPanelZone_1, KEYPAD_STRONG_DTV, OFFSET300, PULSE_TIME_1)      // STRONG
DEFINE_MODULE 'MODULE_IR_V1' APPLETV_1 (IR7, dvPanelZone_1, KEYPAD_APPLETV,    OFFSET400, PULSE_TIME_2)      // Apple TV
DEFINE_MODULE 'MODULE_IR_V1' HK        (IR8, dvPanelZone_1, KEYPAD_HARMAN_AV,  OFFSET0,   PULSE_TIME_2)      // HKARDON AVR
                                        
DEFINE_MODULE 'MODULE_IR_V1' STRONG    (IR6, MIO_SOURSE_11, KEYPAD_STRONG_DTV, OFFSET300, PULSE_TIME_1)      // STRONG    MIO
DEFINE_MODULE 'MODULE_IR_V1' APPLETV_1 (IR7, MIO_SOURSE_11, KEYPAD_APPLETV,    OFFSET400, PULSE_TIME_2)      // Apple TV  MIO
					
// IR4 МОДУЛЬ 

DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' AVR_02    (IR2_1, dvPanelZone_1, KEYPAD_AVR_NAD,  OFFSET1100, PULSE_TIME_2)    // 
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' DVD_03    (IR3_1, dvPanelZone_1, KEYPAD_DVD_NAD,  OFFSET1000, PULSE_TIME_2)    // 
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' RAD_03    (IR3_2, dvPanelZone_1, KEYPAD_FM_NAD,   OFFSET1500, PULSE_TIME_2)    // 
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' DVD_03    (IR3_1, MIO_SOURSE_11, KEYPAD_DVD_NAD,  OFFSET1000, PULSE_TIME_2)    // MIO
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' RAD_03    (IR3_2, MIO_SOURSE_11, KEYPAD_FM_NAD,   OFFSET1500, PULSE_TIME_2)    // MIO
                                                 
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' AVR_04    (IR4_1, dvPanelZone_1, KEYPAD_AVR_PIONEER,  OFFSET1300, PULSE_TIME_2)    // 
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' RAD_04    (IR4_2, dvPanelZone_1, KEYPAD_DVD_PIONEER,  OFFSET1200, PULSE_TIME_2)    // 
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' AVR_04    (IR4_1, MIO_SOURSE_11, KEYPAD_AVR_PIONEER,  OFFSET1300, PULSE_TIME_2)    // MIO
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' RAD_04    (IR4_2, MIO_SOURSE_11, KEYPAD_DVD_PIONEER,  OFFSET1200, PULSE_TIME_2)    // MIO
                                                
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' CD__06    (IR6_1, dvPanelZone_1, KEYPAD_CD_PANASONIC,  OFFSET1400, PULSE_TIME_2)    // 
                                           

DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_01    (IR7_1, dvPanelZone_1,  KEYPAD_LG,         OFFSET500,  PULSE_TIME_1)    // Zone 01 LG 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_02    (IR7_2, dvPanelZone_2,  KEYPAD_LG,         OFFSET500,  PULSE_TIME_2)    // Zone 02 LG 2
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_03    (IR8_1, dvPanelZone_1,  KEYPAD_BENK,       OFFSET600,  PULSE_TIME_2)    // Zone 03 BENK 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_04    (IR8_2, dvPanelZone_1,  KEYPAD_SONY,       OFFSET700,  PULSE_TIME_2)    // Zone 04 SONY 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_05    (IR2_3, dvPanelZone_1,  KEYPAD_PANASONIC,  OFFSET800,  PULSE_TIME_2)    // Zone 05 PANASONIC1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_06    (IR9_2, dvPanelZone_3,  KEYPAD_LG,         OFFSET500,  PULSE_TIME_2)    // Zone 06 LG 3
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_07    (IR4_1, dvPanelZone_1,  KEYPAD_PIONEER_TV, OFFSET800,  PULSE_TIME_2)    // Zone 07 PIONEER 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_08    (IR5_3, dvPanelZone_2,  KEYPAD_BENK,       OFFSET600,  PULSE_TIME_2)    // Zone 08 BENK 2
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_09    (IR11_1, dvPanelZone_2, KEYPAD_SONY,       OFFSET700,  PULSE_TIME_2)    // Zone 09 SONY 2
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_10    (IR11_2, dvPanelZone_1, KEYPAD_TV_JVC,     OFFSET1500, PULSE_TIME_2)    // Zone 10 JVC 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_11    (IR6_3, dvPanelZone_1,  KEYPAD_SAMSUNG,    OFFSET100,  PULSE_TIME_2)    // Zone 11 SAMSUNG 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_12    (IR12_2, dvPanelZone_2, KEYPAD_SAMSUNG,    OFFSET100,  PULSE_TIME_2)    // Zone 12 SAMSUNG 2
                                                                                                                
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_03    (IR8_1, MIO_BO_1,  KEYPAD_BENK,       OFFSET600,  PULSE_TIME_2)    // MIO Zone 03 BENK 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_03    (IR5_3, MIO_BO_2,  KEYPAD_BENK,       OFFSET600,  PULSE_TIME_2)    // MIO Zone 08 BENK 2
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_04    (IR8_2, MIO_SOURSE_11,  KEYPAD_SONY,       OFFSET700,  PULSE_TIME_2)    // MIO Zone 04 SONY 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_05    (IR2_3, MIO_SOURSE_11,  KEYPAD_PANASONIC,  OFFSET800,  PULSE_TIME_2)    // MIO Zone 05 PANASONIC1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_07    (IR4_1, MIO_SOURSE_11,  KEYPAD_PIONEER_TV, OFFSET800,  PULSE_TIME_2)    // MIO Zone 07 PIONEER 1
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' TV_11    (IR6_3, MIO_SOURSE_11,  KEYPAD_SAMSUNG,    OFFSET100,  PULSE_TIME_2)    // Zone 11 SAMSUNG 1




// Cinema 
DEFINE_MODULE 'Runco_LS_4_5' Runco_LS_4_5 (RUNCO_1, dvCinema, KEYPAD_RUNCO)
DEFINE_MODULE 'Runco_LS_4_5' Runco_LS_4_5 (RUNCO_1, MIO_CINEMA_4, KEYPAD_RUNCO)

DEFINE_MODULE 'ADA_Cinema_Rhapsody_Mach_v1' ADA_Cinema (COM_S1_1, vdvCinema, dvCinema, KEYPAD_ADA_AVR, VOLUME_AVR)
DEFINE_MODULE 'ADA_Cinema_Rhapsody_Mach_v1' ADA_Cinema (COM_S1_1, vdvCinema, MIO_CINEMA_4, KEYPAD_ADA_AVR, VOLUME_AVR)


DEFINE_MODULE 'MODULE_IR_V1' SAT_Cinema       (IR_s1_1, dvCinema, KEYPAD_OPENBOX_CINEMA ,    OFFSET200, PULSE_TIME_1)      // Openbox Cinema
DEFINE_MODULE 'MODULE_IR_V1' BR_Cinema        (IR_s1_2, dvCinema, KEYPAD_BR_PIONEER_CINEMA , OFFSET400, PULSE_TIME_1)      // BLURAY  Cinema
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' STRONG_Cinema    (IR1_1,   dvCinema, KEYPAD_STRONG_DTV_CINEMA , OFFSET300, PULSE_TIME_3)      // STRONG  Cinema
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' INEXT_CINEMA     (IR1_2,   dvCinema, KEYPAD_INEXT_CINEMA ,      OFFSET500, PULSE_TIME_3)      // INEXT   CINEMA



DEFINE_MODULE 'MODULE_IR_V1' SAT_Cinema       (IR_s1_1, MIO_CINEMA_4, KEYPAD_OPENBOX_CINEMA ,    OFFSET200, PULSE_TIME_1)      // Openbox Cinema
DEFINE_MODULE 'MODULE_IR_V1' BR_Cinema        (IR_s1_2, MIO_CINEMA_4, KEYPAD_BR_PIONEER_CINEMA , OFFSET400, PULSE_TIME_1)      // BLURAY  Cinema
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' STRONG_Cinema    (IR1_1,   MIO_CINEMA_4, KEYPAD_STRONG_DTV_CINEMA , OFFSET300, PULSE_TIME_3)      // STRONG  Cinema
DEFINE_MODULE 'MODULE_IRP_COMMAND_V1' INEXT_CINEMA     (IR1_2,   MIO_CINEMA_4, KEYPAD_INEXT_CINEMA ,      OFFSET500, PULSE_TIME_3)      // INEXT   CINEMA


DEFINE_MODULE 'CoolMaster_COMM' CoolMaster_COMM     (CoolMaster, VDV, vdvString, dvCoolMaster, RAZNICA_DEV_FR_BL )


DEFINE_MODULE 'CoolMaster_UI_Master'    Block00    (vdvDEV1_0, dvCoolMaster, BLOCK101_BUTTONS)  // Зимний сад возле ком. сына   
DEFINE_MODULE 'CoolMaster_UI_Master'    Block01    (vdvDEV1_1, dvCoolMaster, BLOCK102_BUTTONS)  // Зимний сад возле домофона     
DEFINE_MODULE 'CoolMaster_UI_Master'    Block02    (vdvDEV1_2, dvCoolMaster, BLOCK103_BUTTONS)  // Зимний сад середина
DEFINE_MODULE 'CoolMaster_UI_Master'    Block03    (vdvDEV1_3, dvCoolMaster, BLOCK104_BUTTONS)  // Спальня сына   
DEFINE_MODULE 'CoolMaster_UI_Master'    Block04    (vdvDEV1_4, dvCoolMaster, BLOCK105_BUTTONS)  // Спальня хозяина
DEFINE_MODULE 'CoolMaster_UI_Master'    Block05    (vdvDEV1_5, dvCoolMaster, BLOCK106_BUTTONS)  // Зимний сад возле кухни         
DEFINE_MODULE 'CoolMaster_UI_Master'    Block06    (vdvDEV1_6, dvCoolMaster, BLOCK107_BUTTONS)  // Кинотеатр   

//// Управление Lutron
DEFINE_MODULE 'HW_COMM' HW_COMM(lutron, vdvHW_KEYPAD0, vdvHW_KEYPADS, HW_KEYPADS, ON_line_HW, NUM_LED_PANEL, vdvONLINE_S1)                        

DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD1,  dvLutronLight2,  PANEL1_BUTTONS , ON_line_HW)    // Холл 0 эт
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD2,  dvLutronLight2,  PANEL2_BUTTONS , ON_line_HW)    // Кинотетар
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD3,  dvLutronLight2,  PANEL3_BUTTONS , ON_line_HW)    // Коридор цоколь 007 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD4,  dvLutronLight2,  PANEL4_BUTTONS , ON_line_HW)    // Зал для тениса
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD5,  dvLutronLight2,  PANEL5_BUTTONS , ON_line_HW)    // Прихожая 101
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD6,  dvLutronLight2,  PANEL6_BUTTONS , ON_line_HW)    // Кухня
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD7,  dvLutronLight2,  PANEL7_BUTTONS , ON_line_HW)    // Гостинная у прихожей
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD8,  dvLutronLight2,  PANEL8_BUTTONS , ON_line_HW)    // Гостинная у кухни
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD9,  dvLutronLight2,  PANEL9_BUTTONS , ON_line_HW)    // Гостинная на колоне
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD10,  dvLutronLight2,  PANEL10_BUTTONS , ON_line_HW)  // Гостинная у бассейна
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD11,  dvLutronLight2,  PANEL11_BUTTONS , ON_line_HW)  // Спальня хоз.
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD12,  dvLutronLight2,  PANEL12_BUTTONS , ON_line_HW)  // Спальня хоз. у кровати слева
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD13,  dvLutronLight2,  PANEL13_BUTTONS , ON_line_HW)  // Спальня хоз. у кровати справа
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD14,  dvLutronLight2,  PANEL14_BUTTONS , ON_line_HW)  // Спальня хоз. вход
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD15,  dvLutronLight2,  PANEL15_BUTTONS , ON_line_HW)  // Коридор у гаража
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD16,  dvLutronLight2,  PANEL16_BUTTONS , ON_line_HW)  // Гараж
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD17,  dvLutronLight2,  PANEL17_BUTTONS , ON_line_HW)  // Бассейн у гостинной
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD18,  dvLutronLight2,  PANEL18_BUTTONS , ON_line_HW)  // Бассейн у сауны
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD19,  dvLutronLight2,  PANEL19_BUTTONS , ON_line_HW)  // Бассейн на улицу
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD20,  dvLutronLight2,  PANEL20_BUTTONS , ON_line_HW)  // Бассейн у спальни
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD21,  dvLutronLight2,  PANEL21_BUTTONS , ON_line_HW)  // Холл балкон у кабинета
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD22,  dvLutronLight2,  PANEL22_BUTTONS , ON_line_HW)  // Спальня сына у входа
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD23,  dvLutronLight2,  PANEL23_BUTTONS , ON_line_HW)  // Спальня сына у кровати слева
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD24,  dvLutronLight2,  PANEL24_BUTTONS , ON_line_HW)  // Спальня сына у кровати справа
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD25,  dvLutronLight2,  PANEL25_BUTTONS , ON_line_HW)  // Спальня сына у зимнего сада 
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD26,  dvLutronLight2,  PANEL26_BUTTONS , ON_line_HW)  // Зимний сад у спальни
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD27,  dvLutronLight2,  PANEL27_BUTTONS , ON_line_HW)  // Зимний сад у бара
DEFINE_MODULE 'HW_KEYPAD_RELISE' HW_KEYPAD_UI_1(vdvHW_KEYPAD28,  dvLutronLight2,  PANEL28_BUTTONS , ON_line_HW)  // Зимний сад по центру                     
DEFINE_MODULE 'HW_KEYPAD_RELISE_VIRTUAL' HW_KEYPAD_UI_1(vdvHW_KEYPAD29, dvLutronLight2,  PANEL29_BUTTONS, ON_line_HW)  // 
DEFINE_MODULE 'HW_KEYPAD_RELISE_VIRTUAL' HW_KEYPAD_UI_1(vdvHW_KEYPAD30, dvLutronLight2,  PANEL30_BUTTONS, ON_line_HW)  //                       
                                                                                             
DEFINE_MODULE 'module Satel Integra LCD' mdlSatelIntegraLCD
(
	// Devices
	dvSatel, vdvSatel,

	// Partitions state
	Partitions_Armed,
	Partitions_EntryTime,
	Partitions_ExitTime_More10secs,
	Partitions_ExitTime_Less10secs,
	Partitions_Alarm,
	Partitions_FireAlarm,
	Partitions_AlarmMemory,
	Partitions_FireAlarmMemory,
	Partitions_Really_Armed,
	Partitions_TempBlocked,
	Partitions_Blocked,
	Partitions_Arming_Mode_2,
	Partitions_Arming_Mode_3,
	Partitions_1st_Code_Entered,

	// Zones state
	Zones_Violation,
	Zones_Tamper,
	Zones_Alarm,
	Zones_AlarmMemory,
	Zones_TamperAlarm,
	Zones_TamperAlarmMemory,
	Zones_Bypass,
	Zones_Trouble_NoViolation,
	Zones_Trouble_LongViolation,

	// Troubles
	Troubles_Zones,
	Troubles_Expanders_AC,
	Troubles_Expanders_BATT,
	Troubles_Expanders_NO_BATT,
	Troubles_System,
	Troubles_Synoptic_AC,
	Troubles_Synoptic_BATT,
	Troubles_Synoptic_NO_BATT,
	Troubles_Head_A_Proximity,
	Troubles_Head_B_Proximity,
	Troubles_Expanders_Overload,
	Troubles_Expanders_ShortCircut,
	Troubles_ExpandersNoCommunication,
	Troubles_SwitcherooedExpanders,
	Troubles_LcdKeypadsNoCommunication,
	Troubles_SwitcherooedLcdKeypads,
	Troubles_ETHM_NoNetwork,
	Troubles_JamLevel_ACU100,
	Troubles_RadioDevicesLowBattery,
	Troubles_RadioDevicesNoCommunication,
	Troubles_RadioOutputsNoCommunication,

	// Outputs state
	Outputs_State,

	// Flags
	Flag_ServiceMode,
	Flag_Trouble
)

// Partitions
Define_Call 'Satel - Arm'         (Char Password[], Char sPartitionNumbers[]) { Send_Command vdvSatel, "'ARM = [',         Password, '] ', sPartitionNumbers"; }
Define_Call 'Satel - Disarm'      (Char Password[], Char sPartitionNumbers[]) { Send_Command vdvSatel, "'DISARM = [',      Password, '] ', sPartitionNumbers"; }
Define_Call 'Satel - Clear Alarm' (Char Password[], Char sPartitionNumbers[]) { Send_Command vdvSatel, "'CLEAR_ALARM = [', Password, '] ', sPartitionNumbers"; }

// Zones
Define_Call 'Satel - Bypass'      (Char Password[], Char sZoneNumbers[]) { Send_Command vdvSatel, "'BYPASS = [',   Password, '] ', sZoneNumbers"; }
Define_Call 'Satel - UnBypass'    (Char Password[], Char sZoneNumbers[]) { Send_Command vdvSatel, "'UNBYPASS = [', Password, '] ', sZoneNumbers"; }

// Outputs
Define_Call 'Satel - Outputs On'  (Char Password[], Char sOutputNumbers[]) { Send_Command vdvSatel, "'OUTPUTS_ON = [',  Password, '] ', sOutputNumbers"; }
Define_Call 'Satel - Outputs Off' (Char Password[], Char sOutputNumbers[]) { Send_Command vdvSatel, "'OUTPUTS_OFF = [', Password, '] ', sOutputNumbers"; }

// Misc
Define_Call 'Satel - Get Troubles status' (Char Password[]) { Send_Command vdvSatel, "'GET_TROUBLES = [', Password, ']'"; }
Define_Call 'Satel - Get Outputs status'  (Char Password[]) { Send_Command vdvSatel, "'GET_OUTPUTS = [',  Password, ']'"; }



(* ************************************* Module auxiliary commands ************************************* *)

// Set default password
Define_Call 'Satel - Set Default Password' (Char Password[]) { Send_Command vdvSatel, "'DEFAULT_PASSWORD = [', Password, ']'"; }





Define_Call 'Satel - Process changes' (Char sData[])
{
	local_var volatile Char    sNumbersON[512], sNumbersOFF[512];
	local_var volatile Integer iNumbersON[128], iNumbersOFF[128];

	Extract_Numbers (sData, sNumbersON, sNumbersOFF, iNumbersON, iNumbersOFF);

	// Example of sData:
	// sData = 'PARTITIONS_STATE_CHANGES Armed = ON[1,2,12] OFF[3,4,15]'
	// It means that partitions 1,2,12 were armed and partitions 3,4,15 were disarmed
	// Arrays sNumbersON, sNumbersOFF, iNumbersON, iNumbersOFF consist data as described below:

	// Array sNumbersON  consists from STRING  data with ON  numbers, example sNumbersON  = '1,2,12'
	// Array iNumbersON  consists from INTEGER data with ON  numbers, example iNumbersON  = {1,2,12}

	// Array sNumbersOFF consists from STRING  data with OFF numbers, example sNumbersOFF = '3,4,15'
	// Array iNumbersOFF consists from INTEGER data with OFF numbers, example iNumbersOFF = {3,4,15}


    Select
    {

        (* *********************** Partitions *********************** *)

        Active (RemoveCmd(sData, 'PARTITIONS_STATE_CHANGES ')):
        {
	        Select
	        {
	        	// Example
	            // Active (RemoveCmd(sData, 'Armed '))               : Call 'Satel - Send changes' ('Поставленые на охрану группы - ', 'Снятые с охраны группы - ', sNumbersON, sNumbersOFF);

	            Active (RemoveCmd(sData, 'Armed '))               : {} // TODO - Armed partitions (with suppressed status)
	            Active (RemoveCmd(sData, 'Really_Armed '))        : {} // TODO - Really armed partitions (without suppressed status)
	            Active (RemoveCmd(sData, 'EntryTime '))           : {} // TODO - Partitions with entry time
	            Active (RemoveCmd(sData, 'ExitTime_More10secs ')) : {} // TODO - Partitions with exit time >10sec.
	            Active (RemoveCmd(sData, 'ExitTime_Less10secs ')) : {} // TODO - Partitions with exit time <10sec.
	            Active (RemoveCmd(sData, 'FireAlarm '))           : {} // TODO - Partitions with fire alarm
	            Active (RemoveCmd(sData, 'AlarmMemory '))         : {} // TODO - Partitions with alarm memory
	            Active (RemoveCmd(sData, 'FireAlarmMemory '))     : {} // TODO - Partitions with fire alarm memory
	            Active (RemoveCmd(sData, '1st_Code '))            : {} // TODO - Partitions with 1st code entered
	            Active (RemoveCmd(sData, 'TempBlocked '))         : {} // TODO - Partitions temporary blocked (partitions type 1)
	            Active (RemoveCmd(sData, 'Blocked '))             : {} // TODO - Partitions blocked for guard round
	            Active (RemoveCmd(sData, 'Arming_Mode_2 '))       : {} // TODO - Partitions with arming mode 2
	            Active (RemoveCmd(sData, 'Arming_Mode_3 '))       : {} // TODO - Partitions with arming mode 3
		    Active (RemoveCmd(sData, 'Alarm '))               : 
		    {
		    //if (iNumbersON[1] = 1 OR iNumbersON[2] = 1) {SEND_COMMAND vdvSatelChan, "'ALARMPON'" DO_PUSH(MVP_MASS[1],KEYPAD_MAKROSS[7][7])}
		    //if (iNumbersON[1] = 2 OR iNumbersON[2] = 2) {SEND_COMMAND vdvSatelChan, "'ALARMHON'"}
		    } // TODO - Partitions with alarm
	        }
        }


        (* *********************** Zones *********************** *)

        Active (RemoveCmd(sData, 'ZONES_STATE_CHANGES ')):
        {
	        Select
	        {
	            Active (RemoveCmd(sData, 'Violation '))             : {} // TODO - Zones violation
	            Active (RemoveCmd(sData, 'Tamper '))                : {} // TODO - Zones tamper
	            Active (RemoveCmd(sData, 'Alarm '))                 : {} // TODO - Zones alarm
	            Active (RemoveCmd(sData, 'TamperAlarm '))           : {} // TODO - Zones tamper alarm
	            Active (RemoveCmd(sData, 'AlarmMemory '))           : {} // TODO - Zones alarm memory
	            Active (RemoveCmd(sData, 'TamperAlarmMemory '))     : {} // TODO - Zones tamper alarm memory
	            Active (RemoveCmd(sData, 'ByPass '))                : {} // TODO - Zones bypasses
	            Active (RemoveCmd(sData, 'Trouble_NoViolation '))   : {} // TODO - Zones "no violation" trouble
	            Active (RemoveCmd(sData, 'Trouble_LongViolation ')) : {} // TODO - Zones "long violation" trouble
	        }
        }


        (* *********************** Troubles *********************** *)

        Active (RemoveCmd(sData, 'TROUBLES_STATE_CHANGES ')):
        {
	        Select
	        {
	        	// PacketType == $54: // Troubles of zones, AC and BATT troubles of expanders, system troubles, AC and BATT troubles of synoptic tables
	            Active (RemoveCmd(sData, 'Zones '))                       : {} // TODO - Troubles of zones
	            Active (RemoveCmd(sData, 'Expanders_AC '))                : {} // TODO - AC troubles of expanders
	            Active (RemoveCmd(sData, 'Expanders_BATT '))              : {} // TODO - BATT troubles of expanders
	            Active (RemoveCmd(sData, 'Expanders_NO_BATT '))           : {} // TODO - NO BATT troubles of expanders
	            Active (RemoveCmd(sData, 'System '))                      : {} // TODO - System troubles
	            Active (RemoveCmd(sData, 'Synoptic_AC '))                 : {} // TODO - AC troubles of synoptic tables
	            Active (RemoveCmd(sData, 'Synoptic_BATT '))               : {} // TODO - BATT troubles of synoptic tables
	            Active (RemoveCmd(sData, 'Synoptic_NO_BATT '))            : {} // TODO - NO BATT troubles of synoptic tables

	        	// PacketType == $57: // Troubles of heads A and B of proximity card readers, overload of expanders supply outputs, addressable zone expanders short circut or jammed ACU-100 modules
	            Active (RemoveCmd(sData, 'Head_A_Proximity '))            : {} // TODO - Troubles of head A of proximity card readers
	            Active (RemoveCmd(sData, 'Head_B_Proximity '))            : {} // TODO - Troubles of head B of proximity card readers
	            Active (RemoveCmd(sData, 'Expanders_Overload '))          : {} // TODO - Overload of expanders supply outputs
	            Active (RemoveCmd(sData, 'Expanders_ShortCircut '))       : {} // TODO - Addressable zone expanders short circut or jammed ACU-100 modules

	        	// PacketType == $59: // Expanders with no communication and switcherooed, LCD keypads with no communication and switcherooed, ETHM-1 modules with no network cable
	            Active (RemoveCmd(sData, 'ExpandersNoCommunication '))    : {} // TODO - Expanders with no communication
	            Active (RemoveCmd(sData, 'SwitcherooedExpanders '))       : {} // TODO - Switcherooed expanders
	            Active (RemoveCmd(sData, 'LcdKeypadsNoCommunication '))   : {} // TODO - LCD keypads with no communication
	            Active (RemoveCmd(sData, 'SwitcherooedLcdKeypads '))      : {} // TODO - Switcherooed LCD keypads
	            Active (RemoveCmd(sData, 'ETHM_NoNetwork '))              : {} // TODO - ETHM-1 modules with no network cable

	        	// PacketType == $58: // Jam level of ACU-100 modules, radio devices with low battery and no communication, radio outputs with no communication
	            Active (RemoveCmd(sData, 'JamLevel_ACU100 '))             : {} // TODO - Jam level of ACU-100 modules
	            Active (RemoveCmd(sData, 'RadioDevicesLowBattery '))      : {} // TODO - Radio devices with low battery
	            Active (RemoveCmd(sData, 'RadioDevicesNoCommunication ')) : {} // TODO - Radio devices with no communication
	            Active (RemoveCmd(sData, 'RadioOutputsNoCommunication ')) : {} // TODO - Radio outputs with no communication
	        }
        }


        (* *********************** Outputs *********************** *)

        Active (RemoveCmd(sData, 'OUTPUTS_STATE_CHANGES ')):
        {
	        Select
	        {
	            Active (RemoveCmd(sData, 'Outputs ')) : {} // TODO - Outputs state
	        }
        }


        (* *********************** Flags *********************** *)

        Active (RemoveCmd(sData, 'FLAG_STATE_CHANGES ')):
        {
	        Select
	        {
	            Active (RemoveCmd(sData, 'ServiceMode = ')) : {} // TODO - Service mode state changes. sData == 'ON' or 'OFF'
	            Active (RemoveCmd(sData, 'Trouble = '))     : {} // TODO - Trouble state changes. sData == 'ON' or 'OFF'
	        }
        }
    }
}



Define_Function Extract_Numbers (Char sData[], Char sNumbersON[], Char sNumbersOFF[], Integer iNumbersON[], Integer iNumbersOFF[])
{
	local_var volatile Char    sNumbers[512], Trash[16];
	local_var volatile Integer i, iPos1, iPos2;

	sNumbersON = "";
	Set_Length_Array(iNumbersON, 0);

	sNumbersOFF = "";
	Set_Length_Array(iNumbersOFF, 0);

	iPos1 = Find_String(sData, 'ON[', 1);
	If (iPos1)
	{
		iPos1 = iPos1 + 2;
		iPos2 = Find_String(sData, ']', iPos1);
		If (iPos2)
			sNumbersON = Mid_String(sData, iPos1, iPos2 - iPos1 + 1);

		sNumbers = sNumbersON;
		While (Length_String(sNumbers))
		{
			Set_Length_Array(iNumbersON, Length_Array(iNumbersON) + 1);
			iNumbersON[Length_Array(iNumbersON)] = atoi(sNumbers);
			Trash = Remove_String(sNumbers, ',', 1); If (Length_String(Trash) == 0) sNumbers = "";
		}
	}

	iPos1 = Find_String(sData, 'OFF[', 1);
	If (iPos1)
	{
		iPos1 = iPos1 + 3;
		iPos2 = Find_String(sData, ']', iPos1);
		If (iPos2)
			sNumbersOFF = Mid_String(sData, iPos1, iPos2 - iPos1 + 1);

		sNumbers = sNumbersOFF;
		While (Length_String(sNumbers))
		{
			Set_Length_Array(iNumbersOFF, Length_Array(iNumbersOFF) + 1);
			iNumbersOFF[Length_Array(iNumbersOFF)] = atoi(sNumbers);
			Trash = Remove_String(sNumbers, ',', 1); If (Length_String(Trash) == 0) sNumbers = "";
		}
	}
}


















DEFINE_FUNCTION StatusCinemaON (integer NUM_PAN) // Отображение инфо на панели, когда включен ДК 
{
SEND_COMMAND dvCinema[NUM_PAN], "'^SHO-1,1'" // Показать кнопки источников и громкости
SEND_COMMAND dvCinema[NUM_PAN], "'^SHO-2,0'" // Скрыть кнопку включения кинотеатра
}

DEFINE_FUNCTION StatusCinemaOFF (integer NUM_PAN) // Отображение инфо на панели, когда выключен ДК 
{
SEND_COMMAND dvCinema[NUM_PAN], "'^SHO-1,0'" // Скрыть кнопки источников и громкости
SEND_COMMAND dvCinema[NUM_PAN], "'^SHO-2,1'" // Показать кнопку включения кинотеатра
}


DEFINE_FUNCTION OPEN_SOURSE_VIDEO (integer CASE_PANEL_,integer CASE_BUTTONS_,integer CASE_HDMI_ZONE_)
{
   IF (BASY_SOURSE_HDMI[CASE_BUTTONS_] = 0 || BASY_SOURSE_HDMI[CASE_BUTTONS_] = CASE_HDMI_ZONE_)   
				    {SEND_COMMAND dvPanelAllZone[CASE_PANEL_],"'@PPN-',POPUP_SOURSE[CASE_BUTTONS_]"} 
			ELSE 
				    {SEND_COMMAND dvPanelAllZone[CASE_PANEL_],"'@PPN-[Sourse]_Basy'"  SEND_COMMAND dvPanelAllZone[CASE_PANEL_],"'^UNI-2001,0,', VIDEO_ZONE[BASY_SOURSE_HDMI[CASE_BUTTONS_]]"  SEND_COMMAND dvPanelAllZone[CASE_PANEL_],"'^TXT-2002,0,', VIDEO_ZONE_NUMB[BASY_SOURSE_HDMI[CASE_BUTTONS_]]"}
}

DEFINE_FUNCTION OPEN_SOURSE_VIDEO_MIO_1 (DEV PANEL_,integer CASE_BUTTONS_,integer CASE_HDMI_ZONE_)
{
   IF (BASY_SOURSE_HDMI[CASE_BUTTONS_] = 0 || BASY_SOURSE_HDMI[CASE_BUTTONS_] = CASE_HDMI_ZONE_)   
				    {SEND_COMMAND PANEL_,"'PAGE-',PAGE_SOURSE[CASE_BUTTONS_]"} 
			ELSE 
				    {SEND_COMMAND PANEL_,"'PAGE-[Sourse]_Basy'"}
}

DEFINE_FUNCTION SEND_TXT_AUDIO_ZONE (integer PANEL_NUMBER_, integer ZONE_NUMBER_)
{
SEND_COMMAND dvPanelAllZone[PANEL_NUMBER_],"'@PPN-[Sourse]_Basy'"  
SEND_COMMAND dvPanelAllZone[PANEL_NUMBER_],"'^UNI-2001,0,', AUDIO_ZONE[BASY_SOURSE[ZONE_NUMBER_]]"  
SEND_COMMAND dvPanelAllZone[PANEL_NUMBER_],"'^TXT-2002,0,', AUDIO_ZONE_NUMB[BASY_SOURSE[ZONE_NUMBER_]]"
}

DEFINE_FUNCTION SEND_TXT_AUDIO_ZONE_ALL ()
{
FOR (INDEX_I = 15 ; INDEX_I < 23 ; INDEX_I++) 
    {
    IF ( BASY_SOURSE[INDEX_I] != 0 ) 
	    {
	    SEND_COMMAND dvPanelAllZone,"'^UNI-',ITOA (KEYPAD_AUDIO[INDEX_I - 14]) ,',0,', AUDIO_ZONE[BASY_SOURSE[INDEX_I]]" SEND_COMMAND dvPanelAllZone,"'^TXT-',ITOA (KEYPAD_AUDIO_NUM[INDEX_I - 14]) ,',0,', AUDIO_ZONE_NUMB[BASY_SOURSE[INDEX_I]]"  
	    }
	    {
	    SEND_COMMAND dvPanelAllZone,"'^TXT-',ITOA (KEYPAD_AUDIO[INDEX_I - 14]) ,',0, '" SEND_COMMAND dvPanelAllZone,"'^TXT-',ITOA (KEYPAD_AUDIO[INDEX_I - 14]) ,',0,'"  
	    }
    }
}

DEFINE_FUNCTION SEND_TXT_VIDEO_ZONE_ALL ()
{
FOR (INDEX_V = 1 ; INDEX_V < 8 ; INDEX_V++) 
    {
    IF ( BASY_SOURSE_HDMI[INDEX_V] != 0 ) 
	    {
	    SEND_COMMAND dvPanelAllZone,"'^UNI-',ITOA (KEYPAD_VIDEO[INDEX_V]) ,',0,', VIDEO_ZONE[BASY_SOURSE_HDMI[INDEX_V]]" SEND_COMMAND dvPanelAllZone,"'^TXT-',ITOA (KEYPAD_VIDEO_NUM[INDEX_V]) ,',0,', VIDEO_ZONE_NUMB[BASY_SOURSE_HDMI[INDEX_V]]"  
	    }
	    ELSE
	    {
	    SEND_COMMAND dvPanelAllZone,"'^TXT-',ITOA (KEYPAD_VIDEO[INDEX_V]) ,',0, '" SEND_COMMAND dvPanelAllZone,"'^TXT-',ITOA (KEYPAD_VIDEO_NUM[INDEX_V]) ,',0,'"  
	    }
    }
}




DEFINE_START


IF (CINEMA_POWER = '') { CINEMA_POWER = 'OFF'}
IF (CINEMA_POWER = 'ON') {ON[IO_S1, 1]}

IF (STATUS_SOURSE [1] = '') 
{
STATUS_SOURSE [1] = 'OFF'
STATUS_SOURSE [2] = 'OFF'
STATUS_SOURSE [3] = 'OFF'
STATUS_SOURSE [4] = 'OFF'
STATUS_SOURSE [5] = 'OFF'
STATUS_SOURSE [6] = 'OFF'
STATUS_SOURSE [7] = 'OFF'
STATUS_SOURSE [8] = 'OFF'
STATUS_SOURSE [9] = 'OFF'
STATUS_SOURSE [10] = 'OFF'
STATUS_SOURSE [11] = 'OFF'
STATUS_SOURSE [12] = 'OFF'
}                 




(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)



DEFINE_EVENT

///////////////////////////////////////////////////////////
//////////   Открыть карту видео аудио зон ////////////////
///////////////////////////////////////////////////////////



BUTTON_EVENT [dvPanelAllZone, KEYPAD_ZONE_MAP [1]]
{PUSH: 
    {
    SEND_TXT_AUDIO_ZONE_ALL ()
    }
}

BUTTON_EVENT [dvPanelAllZone, KEYPAD_ZONE_MAP [2]]
{PUSH: 
    {
    SEND_TXT_VIDEO_ZONE_ALL ()
    }
}



///////////////////////////////////////////////////////////
//////////   Управление охранной сигнализ   ////////////////
///////////////////////////////////////////////////////////

CHANNEL_EVENT [dvAlarmMas, Zone_Save_Alarm [15]]
{
ON: {CANCEL_WAIT 'ALARM_SOUND' ALARM_SOUND = 0 WAIT 600 'ALARM_SOUND' {ALARM_SOUND = 1}}
OFF:{ALARM_SOUND = 0}
}

BUTTON_EVENT [dvAlarmMas, Macros_ALARM [1]]
{PUSH: {IF(ALARM_SOUND = 0) {ALARM_SOUND = 1} ELSE {ALARM_SOUND = 0}}
}



DATA_EVENT[vdvSatel]
{
	ONLINE:
	{
		// *************************************************************************************
		// Заменить на правильный код модуля, иначе система будет перезагружаться каждые 5 минут
		// *************************************************************************************
		Send_Command Data.Device, 'SERIAL = 4632';

		// Задание пароля для автоматического опроса состояний выходов (Outputs) и неисправностей (Troubles)
		// Если пароль не пуской, то модуль автоматически опрашивает эти состояния каждые 10 секунд
		// Если пароль пустой, то модуль автоматически не опрашивает эти состояния
		Call 'Satel - Set Default Password' ('');

		// Задание устройства, на которое будут дублироваться все сообщения, посылаемые модулем в окно Диагностики.
		// По умолчанию дублирование отключено
		// Для отключения дублирования послать адрес устройтва 0:1:0 : Send_Command Data.Device, 'VDVDEBUG = 0:1:0';
		// Send_Command Data.Device, "'VDVDEBUG = ', GetDeviceAsText(vdvDebug)";

		// Включение/выключение режима отображания расширенной отладочной информации.
		// Send_Command Data.Device, "'DEBUG = OFF'"; // Выключить режим отображания расширенной отладочной информации
		Send_Command Data.Device, 'DEBUG = OFF';

		// Включение/выключение режима отображания расширенной отладочной информации по пакетам.
		// В данном случае в окне Диагностики будут отображаться данные по всем пакетам, получаемым от охранной централи
		// Send_Command Data.Device, 'DEBUG_EXT = OFF'; // Выключить режим отображания расширенной отладочной информации по пакетам
		// Send_Command Data.Device, 'DEBUG_EXT = ON';  // Включить режим отображания расширенной отладочной информации по пакетам

		// Задание строки, с которой будут начинаться все сообщения в окне Диагностики от данного модуля
		// Значение по умолчанию: Satel
		// Например, 'Satel[1]: Connecton ON'
		// Send_Command Data.Device, 'DEBUGSTRING = Satel[1]'; // Поменять начало на "Satel[1]"
	}

    STRING:
    {
    	Call 'Satel - Process changes' (Data.Text);
    }

    COMMAND:
    {
        Select
        {
			Active (RemoveCmd(Data.Text, 'CONNECTION = ')):
			{
				// Обработать новое состояние связи с централью
				// Считается, что связь с охранной централью пропала, если от нее не приходят пакеты в течение 3 секунд
				// Новое значение находится в Data.Text. Data.Text = 'ON' или 'OFF'
				// Satel_ConnectionStatus = (Data.Text == 'ON');
			}
        }
    }
}

BUTTON_EVENT [dvAlarmMas,Zone_Save_Pass] //                
{push:{   
	
         Channel_ALARM = button.input.channel
	 SEND_COMMAND dvAlarmMas[GET_LAST(dvAlarmMas)],'@AKP-;ENTER PASSWORD'
}}

DATA_EVENT [dvPanelAllZone]
{
STRING:
{
LOCAL_VAR CHAR txt[100]

SEND_STRING 0, "'STR_SEND= ', data.text"
txt = data.text
if (REMOVE_STRING(txt, 'KEYP-', 1))
{
SEND_STRING 0, "'PASS= ',txt"

SWITCH(Channel_ALARM)
{
case  1:{Call 'Satel - Arm' (txt, '1')}     // 
case  2:{Call 'Satel - Arm' (txt, '2')}     // 
case  3:{Call 'Satel - Arm' (txt, '3')}     // 
case  4:{Call 'Satel - Arm' (txt, '4')}     // 
case  5:{Call 'Satel - Arm' (txt, '5')}     // 
case  6:{Call 'Satel - Arm' (txt, '6')}     // 
case  7:{Call 'Satel - Arm' (txt, '7')}     // 
case  8:{Call 'Satel - Arm' (txt, '8')}     // 
case  9:{Call 'Satel - Arm' (txt, '9')}     // 
case 10:{Call 'Satel - Arm' (txt, '10')}    // 
case 11:{Call 'Satel - Arm' (txt, '11')}    // 
case 12:{Call 'Satel - Arm' (txt, '12')}    // 
case 13:{Call 'Satel - Arm' (txt, '13')}    // 
case 15:{Call 'Satel - Arm' (txt, '1,2,3,4,5,6,7,8,9,10,11,12,13')}    // 
                                  

case 21:{Call 'Satel - Disarm' (txt, '1')  Call 'Satel - Clear Alarm' (txt, '1')}     // 
case 22:{Call 'Satel - Disarm' (txt, '2')  Call 'Satel - Clear Alarm' (txt, '2')}     // 
case 23:{Call 'Satel - Disarm' (txt, '3')  Call 'Satel - Clear Alarm' (txt, '3')}     // 
case 24:{Call 'Satel - Disarm' (txt, '4')  Call 'Satel - Clear Alarm' (txt, '4')}     // 
case 25:{Call 'Satel - Disarm' (txt, '5')  Call 'Satel - Clear Alarm' (txt, '5')}     // 
case 26:{Call 'Satel - Disarm' (txt, '6')  Call 'Satel - Clear Alarm' (txt, '6')}     // 
case 27:{Call 'Satel - Disarm' (txt, '7')  Call 'Satel - Clear Alarm' (txt, '7')}     // 
case 28:{Call 'Satel - Disarm' (txt, '8')  Call 'Satel - Clear Alarm' (txt, '8')}     // 
case 29:{Call 'Satel - Disarm' (txt, '9')  Call 'Satel - Clear Alarm' (txt, '9')}     // 
case 30:{Call 'Satel - Disarm' (txt, '10') Call 'Satel - Clear Alarm' (txt, '10')}    // 
case 31:{Call 'Satel - Disarm' (txt, '11') Call 'Satel - Clear Alarm' (txt, '11')}    // 
case 32:{Call 'Satel - Disarm' (txt, '12') Call 'Satel - Clear Alarm' (txt, '12')}    // 
case 33:{Call 'Satel - Disarm' (txt, '13') Call 'Satel - Clear Alarm' (txt, '13')}    // 
case 35:{Call 'Satel - Disarm' (txt, '1,2,3,4,5,6,7,8,9,10,11,12,13') Call 'Satel - Clear Alarm' (txt, '1,2,3,4,5,6,7,8,9,10,11,12,13')}    // 
                                  

case 41:{Call 'Satel - Clear Alarm' (txt, '1')  }     // 
case 42:{Call 'Satel - Clear Alarm' (txt, '2')  }     // 
case 43:{Call 'Satel - Clear Alarm' (txt, '3')  }     // 
case 44:{Call 'Satel - Clear Alarm' (txt, '4')  }     // 
case 45:{Call 'Satel - Clear Alarm' (txt, '5')  }     // 
case 46:{Call 'Satel - Clear Alarm' (txt, '6')  }     // 
case 47:{Call 'Satel - Clear Alarm' (txt, '7')  }     // 
case 48:{Call 'Satel - Clear Alarm' (txt, '8')  }     // 
case 49:{Call 'Satel - Clear Alarm' (txt, '9')  }     // 
case 50:{Call 'Satel - Clear Alarm' (txt, '10') }    // 
case 51:{Call 'Satel - Clear Alarm' (txt, '11') }    // 
case 52:{Call 'Satel - Clear Alarm' (txt, '12') }    // 
case 53:{Call 'Satel - Clear Alarm' (txt, '13') }    // 
case 55:{Call 'Satel - Clear Alarm' (txt, '1,2,3,4,5,6,7,8,9,10,11,12,13')}    // 
                                  

}                                     
Channel_ALARM = 0
}}}






///////////////////////////////////////////////////////////
//////////   Управление входными воротами   ////////////////
///////////////////////////////////////////////////////////


BUTTON_EVENT [dvLutronLight2, 2001] // открыть
{
    PUSH:{
      OFF[RELAY, 2]
      SET_PULSE_TIME (10) PULSE[dvLutronLight2, 2001]
      SET_PULSE_TIME (20) PULSE[RELAY, 1]
}}

BUTTON_EVENT [dvLutronLight2, 2002] // закрыть
{
    PUSH:{
      OFF[RELAY, 1]
      SET_PULSE_TIME (10) PULSE[dvLutronLight2, 2002]
      SET_PULSE_TIME (20) PULSE[RELAY, 2]
}}



///////////////////////////////////////////////////////////
//////////   Управление светом с пультов   ////////////////
///////////////////////////////////////////////////////////

BUTTON_EVENT [MIOR4_04_02, PANEL2_BUTTONS] // Кинотеатр
{
    PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL2_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD2,"'PUSH_BUTTON:',ITOA(CASE_BUTTONS)"
	}
    RELEASE:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL2_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD2,"'RELISE_BUTTON:',ITOA(CASE_BUTTONS)"
	}
}


BUTTON_EVENT [MIOR4_03_02, PANEL2_BUTTONS] // Спальня сына
{
    PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL2_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD22,"'PUSH_BUTTON:',ITOA(CASE_BUTTONS)"
	}
    RELEASE:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL2_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD22,"'RELISE_BUTTON:',ITOA(CASE_BUTTONS)"
	}
}

BUTTON_EVENT [MIOR4_01_02, PANEL1_BUTTONS] // Спальня хозяина
{
    PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL1_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD14,"'PUSH_BUTTON:',ITOA(CASE_BUTTONS)"
	}
    RELEASE:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL1_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD14,"'RELISE_BUTTON:',ITOA(CASE_BUTTONS)"
	}
}


BUTTON_EVENT [MIOR4_01_02, PANEL2_BUTTONS] // Кухня
{
    PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL2_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD6,"'PUSH_BUTTON:',ITOA(CASE_BUTTONS)"
	}
    RELEASE:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL2_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD6,"'RELISE_BUTTON:',ITOA(CASE_BUTTONS)"
	}
}

BUTTON_EVENT [MIOR4_01_02, PANEL3_BUTTONS] // Столовая
{
    PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL3_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD7,"'PUSH_BUTTON:',ITOA(CASE_BUTTONS)"
	}
    RELEASE:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL3_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD7,"'RELISE_BUTTON:',ITOA(CASE_BUTTONS)"
	}
}

BUTTON_EVENT [MIOR4_01_02, PANEL4_BUTTONS] // Зал
{
    PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL4_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD9,"'PUSH_BUTTON:',ITOA(CASE_BUTTONS)"
	}
    RELEASE:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL4_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD9,"'RELISE_BUTTON:',ITOA(CASE_BUTTONS)"
	}
}


BUTTON_EVENT [MIOR4_01_02, PANEL30_BUTTONS] // Шторы
{
    PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS

      CASE_BUTTONS = GET_LAST (PANEL30_BUTTONS)
      SEND_COMMAND vdvHW_KEYPAD30,"'PUSH_BUTTON:',ITOA(CASE_BUTTONS)"
	}
}





///////////////////////////////////////////////////////////////////////////////
///////////     Управление с пульта MIO кинотетар        /////////////////////
///////////////////////////////////////////////////////////////////////////////

BUTTON_EVENT [MIO_CINEMA_4, KEYPAD_MAKROS_CINEMA] // Выбрать зону мультирум
{PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR INTEGER CASE_PANEL

      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_CINEMA)
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  Включить кинотетар 
	    {
	    CINEMA_POWER = 'ON'
	    DO_PUSH(dvCinema[1],KEYPAD_RUNCO[1])   (*Включить проектор*) Wait 300 'ON_CINEMA' {DO_PUSH(dvCinema[1],KEYPAD_RUNCO[3])} // HDMI 1
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[3])  WAIT 20 {SEND_LEVEL vdvCinema, KEYPAD_ADA_AVR[1], 36}   // Включить ada
	    ON [IO_S1, 1]
	    SET_PULSE_TIME (4) PULSE[IR_s1_2, 51] // ON BR
	    }
      CASE 2:  //  Выключить кинотеатр  
	    {
	    CINEMA_POWER = 'OFF'
	    SEND_COMMAND MIOR4_04_04, "'PAGE-[Zone]_Main_Z2_1'"
	    DO_PUSH(dvCinema[1],KEYPAD_RUNCO[2])
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[1])   // OFF ada
	    OFF [IO_S1, 1]
	    SET_PULSE_TIME (4) PULSE[IR_s1_2, 52] // OFF BR
	    }
      CASE 6:  //  Вход Спутник
	    {
	    IF (CINEMA_POWER = 'ON') {
	    CINEMA_SOURSE = 'SAT'
	    SEND_COMMAND MIOR4_04_04, "'PAGE-[Sourse]_Sat'"
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[4])   // Input 2
	    SET_PULSE_TIME (2) PULSE[IR_s1_2,49] // Pause BR
	    }}
      CASE 7:  //  Вход Цифра       
	    {
	    IF (CINEMA_POWER = 'ON') {
	    CINEMA_SOURSE = 'DTV'
	    SEND_COMMAND MIOR4_04_04, "'PAGE-[Sourse]_Strong_01'"
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[5])   // Input 3
	    SET_PULSE_TIME (2) PULSE[IR_s1_2,49] // Pause BR
	    }}
      CASE 8:  //  Вход BR      
	    {
	    IF (CINEMA_POWER = 'ON') {
	    IF (CINEMA_SOURSE != 'BR')
	    {
	    CINEMA_SOURSE = 'BR'
	    SEND_COMMAND MIOR4_04_04, "'PAGE-[Sourse]_BR'"
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[3])   // Input 1
	    wait 10 {DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[10])}
	    wait 20 {DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[3])}
	    }
	    ELSE {SEND_COMMAND MIOR4_04_04, "'PAGE-[Sourse]_BR'"}
	    }}
      CASE 9:  //  Вход INEXT
	    {
	    IF (CINEMA_POWER = 'ON') {
	    CINEMA_SOURSE = 'INT'
	    SEND_COMMAND MIOR4_04_04, "'PAGE-[Sourse]INEXT'"
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[6])   // Input 2
	    SET_PULSE_TIME (2) PULSE[IR_s1_2,49] // Pause BR
	    }}
	CASE 13:  //  Вкл усилителя    
	    {
	    ON[IO_S1, 1]	
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[3])
	    }
	CASE 14:  //  Выкл усилителя    
	    {
	    OFF[IO_S1, 1]	
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[1])
	    }
}}}

BUTTON_EVENT [MIO_CINEMA_4, KEYPAD_MAKROS_CINEMA[17]] // громкость выкл
{PUSH:{
	DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[17])
	}
}

BUTTON_EVENT [MIO_CINEMA_4, KEYPAD_MAKROS_CINEMA[18]] // громкость +
{PUSH:{
	DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[18])
	}
HOLD[3, REPEAT]:{
		    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[18])
		}
}

BUTTON_EVENT [MIO_CINEMA_4, KEYPAD_MAKROS_CINEMA[19]] // громкость -
{PUSH:{
	DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[19])
	}
HOLD[3, REPEAT]:{
		    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[19])
		}
}


///////////////////////////////////////////////////////////////////////////////
///////////     Управление с пульта MIO спальня хозяина   /////////////////////
///////////////////////////////////////////////////////////////////////////////


DATA_EVENT [MIOR4_01_01]
{
ONLINE:{ WAIT 50 { SEND_COMMAND MIOR4_01_01, "'PAGE-Main'"  SAVE_1_NUM_PAGE_ = 1}} 
}

BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_1] // Выбрать зону мультирум
{PUSH:{
	SWITCH (BUTTON.INPUT.CHANNEL)
	    {
	    CASE 1:{ SAVE_1_NUM_PAGE_ = 7 SEND_COMMAND MIOR4_01_01, "'PAGE-', PAGE_ZONE [1]"} // спальня хoзяина
	    CASE 2:{ SAVE_1_NUM_PAGE_ = 3 SEND_COMMAND MIOR4_01_01, "'PAGE-', PAGE_ZONE [2]"} // кухня
	    CASE 3:{ SAVE_1_NUM_PAGE_ = 4 SEND_COMMAND MIOR4_01_01, "'PAGE-', PAGE_ZONE [3]"} // столовая
	    CASE 4:{ SAVE_1_NUM_PAGE_ = 5 SEND_COMMAND MIOR4_01_01, "'PAGE-', PAGE_ZONE [4]"} // зал
	    CASE 10:{ SAVE_1_NUM_PAGE_ = 1 SEND_COMMAND MIOR4_01_01, "'PAGE-Main'"} // зал
	    }                                                                    
    }}

BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_2] // Выбрать источник в спальне хoзяина зона № 7
{PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR DEV IR_AVR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_2)
      CASE_HDMI_ZONE  = 11
      CASE_ZONE  = 7
      IR_AVR = IR4_1
      
              SWITCH (CASE_BUTTONS)
              {
              CASE 1:  //  ИСТОЧНИК Cпутник1 
              CASE 2:  //  ИСТОЧНИК Cпутник2
              CASE 3:  //  ИСТОЧНИК Cпутник3
              CASE 4:  //  ИСТОЧНИК Cпутник4
              CASE 5:  //  ИСТОЧНИК Cпутник5
              CASE 6:  //  ИСТОЧНИК DTV      
              CASE 7:  //  ИСТОЧНИК APPLE TV
                     { 
                     IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
			     {
			     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
			     SET_PULSE_TIME (5) PULSE[IR_AVR, 16] (*ON TV*) WAIT 60 {SET_PULSE_TIME (3) PULSE[IR_AVR, 125] WAIT 10 { SET_PULSE_TIME (3) PULSE[IR_AVR, 4] }} (*HDMI 1 TV*)
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
			     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_01_01, CASE_BUTTONS, CASE_HDMI_ZONE)
			     } ELSE {
			     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
			     SET_PULSE_TIME (5) PULSE[IR_AVR, 4]  (*HDMI 1 TV*)
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
			     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_01_01, CASE_BUTTONS, CASE_HDMI_ZONE)
			            }
                     }
              CASE 17: //  ИСТОЧНИК TV
                     { 
                     IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
			     {
			     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
			     SEND_COMMAND MIOR4_01_01, "'PAGE-_TV_Z07'"
			     SET_PULSE_TIME (5) PULSE[IR_AVR, 16] (*ON TV*) WAIT 60 {SET_PULSE_TIME (3) PULSE[IR_AVR, 125] WAIT 10 { SET_PULSE_TIME (3) PULSE[IR_AVR, 107] }} (*HDMI 1 TV*)
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
			     } ELSE {
			     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
			     SEND_COMMAND MIOR4_01_01, "'PAGE-_TV_Z07'"
			     SET_PULSE_TIME (5) PULSE[IR_AVR, 107]  (*TV 1 TV*)
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
			            }
                     }
              CASE 16: //  ИСТОЧНИК DVD
                     { 
                     IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
			     {
			     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
			     SEND_COMMAND MIOR4_01_01, "'PAGE-_PIONEER_DVD'"
			     SET_PULSE_TIME (5) PULSE[IR_AVR, 16] (*ON TV*) WAIT 60 {SET_PULSE_TIME (3) PULSE[IR_AVR, 125] WAIT 10 { SET_PULSE_TIME (3) PULSE[IR_AVR, 2] }} (*HDMI 1 TV*)
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
			     } ELSE {
			     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
			     SEND_COMMAND MIOR4_01_01, "'PAGE-_PIONEER_DVD'"
			     SET_PULSE_TIME (5) PULSE[IR_AVR, 2]  (*TV 1 TV*)
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
			     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
			            }
                     }
      }
      }
}

BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_3] // Выбрать источник в кухне зона № 3
{PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_3)
      CASE_HDMI_ZONE  = 7
      CASE_ZONE  = 3
      IR = IR8_1
      
            SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 8] (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_01_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 8]  (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_01_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 4]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 4]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 16: //  ИСТОЧНИК DVD
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 7]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 7]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      }
      }
}

BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_4] // Выбрать источник в столовой зона № 4
{PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_4)
      CASE_HDMI_ZONE  = 8
      CASE_ZONE  = 4
      IR = IR8_2
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 19] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 28] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_01_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 28]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_01_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_TV_Z04'"
	     SET_PULSE_TIME (5) PULSE[IR, 19] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 24] } (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_TV_Z04'"
	     SET_PULSE_TIME (3) PULSE[IR, 24]   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      }
      }
}

BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_5] // Выбрать источник в столовой зона № 4
{PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_5)
      CASE_HDMI_ZONE  = 9
      CASE_ZONE  = 5
      IR = IR2_3

      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 11] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (5) PULSE[IR2_1, 2] (*OFF avr*)
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_01_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 11]   (*HDMI 1 TV*)
	     SET_PULSE_TIME (5) PULSE[IR2_1, 2] (*OFF avr*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_01_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 16: //  ИСТОЧНИК RADIO
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_NAD_FM'"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 10] } (*TV 1 TV*)
	     SET_PULSE_TIME (5) PULSE[IR2_1, 1] (*ON AVR*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR2_1, 21] } (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	      STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_NAD_FM'"
	     SET_PULSE_TIME (3) PULSE[IR, 3]   (*TV 1 TV*)
	     SET_PULSE_TIME (3) PULSE[IR2_1, 10]
	     WAIT 10 { SET_PULSE_TIME (5) PULSE[IR2_1, 1] (*ON AVR*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR2_1, 21] }} (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 17: //  ИСТОЧНИК DVD
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_NAD_DVD'"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 10] } (*TV 1 TV*)
	     SET_PULSE_TIME (5) PULSE[IR2_1, 1] (*ON AVR*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR2_1, 8] } (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (3) PULSE[IR3_1, 1]
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_01_01, "'PAGE-_NAD_DVD'"
	     SET_PULSE_TIME (3) PULSE[IR, 10]   (*TV 1 TV*)
	     SET_PULSE_TIME (3) PULSE[IR2_1, 8]
	     WAIT 10 { SET_PULSE_TIME (5) PULSE[IR2_1, 1] (*ON AVR*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR2_1, 8] }} (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
     	     SET_PULSE_TIME (3) PULSE[IR3_1, 1]
	            }
             }
      }
}}



BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[1]] // Выключить зону мультирум
{PUSH:{
	SWITCH (SAVE_1_NUM_PAGE_)
	    {
	    CASE 7:{  // спальня хoзяина
		    SEND_COMMAND MIOR4_01_01, "'PAGE-', PAGE_ZONE [1]"
		    STATUS_SOURSE[7] = 'OFF'
		    SET_PULSE_TIME (5) PULSE[IR4_1, 17] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[11][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i                   
		   }
	    CASE 3:{  // кухня
		    SEND_COMMAND MIOR4_01_01, "'PAGE-', PAGE_ZONE [2]"
		    STATUS_SOURSE[3] = 'OFF'
		    SET_PULSE_TIME (5) PULSE[IR8_1, 1] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[7][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
		   }
	    CASE 4:{  // Столовая
		    SEND_COMMAND MIOR4_01_01, "'PAGE-', PAGE_ZONE [3]"
		    STATUS_SOURSE[4] = 'OFF'
		    SET_PULSE_TIME (5) PULSE[IR8_2, 20] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[8][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [33]) // ВЫХОД 1 ВХОД i 
		    } 
	    CASE 5:{  // Зал
		    STATUS_SOURSE[5] = 'OFF'
		    SEND_COMMAND MIOR4_01_01, "'PAGE-', PAGE_ZONE [4]"
		    SET_PULSE_TIME (5) PULSE[IR2_3, 2] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[9][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33])     // ВЫХОД 1 ВХОД i 
		    SET_PULSE_TIME (3) PULSE[IR2_1, 2]
		    SET_PULSE_TIME (3) PULSE[IR3_1, 2]
		    }
	    }
    }}

BUTTON_EVENT [MIOR4_01_06,  KEYPAD_MAKROS_11[10]] // Перезагрузка спутников
{
PUSH:{
    
	SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_1[1])  } // спутник 1
	    CASE 'S02':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_2[1])  } // спутник 2
	    CASE 'S03':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_3[1])  } // спутник 3
	    CASE 'S04':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_4[1])  } // спутник 4
	    CASE 'S05':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_5[1])  } // спутник 5
	    }                                                          
    }
}
 
    
BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[11]] // Выключить зону спальня хоз
{PUSH:{
		    STATUS_SOURSE[7] = 'OFF'
		    SET_PULSE_TIME (5) PULSE[IR4_1, 17] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[11][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i                   
}}


BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[12]] // Выключить зону кухня
{PUSH:{
		    STATUS_SOURSE[3] = 'OFF'
		    SET_PULSE_TIME (5) PULSE[IR8_1, 1] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[7][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
}}

BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[13]] // Выключить зону кухня
{PUSH:{
		    STATUS_SOURSE[4] = 'OFF'
		    SET_PULSE_TIME (5) PULSE[IR8_2, 20] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[8][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [33]) // ВЫХОД 1 ВХОД i 
}}

BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[14]] // Выключить зону кухня
{PUSH:{
		    STATUS_SOURSE[5] = 'OFF'
		    SET_PULSE_TIME (5) PULSE[IR2_3, 2] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[9][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33])     // ВЫХОД 1 ВХОД i 
		    SET_PULSE_TIME (3) PULSE[IR2_1, 2]
		    SET_PULSE_TIME (3) PULSE[IR3_1, 2]
}}


BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[2]] // Громкость + 
{
PUSH:{
	SWITCH (SAVE_1_NUM_PAGE_)
	    {
	    CASE 7:{  // спальня хoзяина
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_4[36]) 
		   }
	    CASE 3:{  // Кухня
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_5[36]) 
		   }
	    CASE 4:{  // Столовая
		    Send_Command IR8_2, "'IRP-14,2,1'" 
		   }
	    CASE 5:{  // зал
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_7[36]) 
		   }
	    }                                                                    
    }
HOLD [3, REPEAT]:{
	SWITCH (SAVE_1_NUM_PAGE_)
	    {
	    CASE 7:{  // спальня хoзяина
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_4[36]) 
		   }
	    CASE 3:{  // Кухня
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_5[36]) 
		   }
	    CASE 4:{  // Столовая
		    Send_Command IR8_2, "'IRP-14,2,1'" 
		   }
	    CASE 5:{  // зал
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_7[36]) 
		   }
	    }                                                                    
    }
}


BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[3]] // Громкость -
{
PUSH:{
	SWITCH (SAVE_1_NUM_PAGE_)
	    {
	    CASE 7:{  // спальня хoзяина
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_4[37]) 
		   }
	    CASE 3:{  // Кухня
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_5[37]) 
		   }
	    CASE 4:{  // Столовая
		    Send_Command IR8_2, "'IRP-15,2,1'" 
		   }
	    CASE 5:{  // зал
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_7[37]) 
		   }
	    }                                                                    
    }
HOLD [3, REPEAT]:{
	SWITCH (SAVE_1_NUM_PAGE_)
	    {
	    CASE 7:{  // спальня хoзяина
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_4[37]) 
		   }
	    CASE 3:{  // Кухня
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_5[37]) 
		   }
	    CASE 4:{  // Столовая
		    Send_Command IR8_2, "'IRP-15,2,1'" 
		   }
	    CASE 5:{  // зал
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_7[37]) 
		   }
	    }                                                                    
    }
}


BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[4]] // Громкость off
{
PUSH:{
	SWITCH (SAVE_1_NUM_PAGE_)
	    {
	    CASE 7:{  // спальня хoзяина
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_4[34]) 
		   }
	    CASE 3:{  // Кухня
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_5[34]) 
		   }
	    CASE 4:{  // столовая
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_6[34]) 
		   }
	    CASE 5:{  // зал
		    DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_7[34]) 
		   }
	    }                                                                    
    }
}


BUTTON_EVENT [MIOR4_01_01, KEYPAD_MAKROS_11[5]] // Громкость off TV
{
PUSH:{
	SWITCH (SAVE_1_NUM_PAGE_)
	    {
	    CASE 7:{ Send_Command IR4_1, "'IRP-8,3,1'" } // спальня хoзяина
	    CASE 3:{ Send_Command IR8_1, "'IRP-32,3,1'" } // кухня
	    CASE 4:{ Send_Command IR8_2, "'IRP-18,3,1'" } // столовая
	    CASE 5:{ Send_Command IR2_1, "'IRP-5,3,1'" } // зал
	    }                                                                    
    }
HOLD [3, REPEAT]:{
	SWITCH (SAVE_1_NUM_PAGE_)
	    {
	    CASE 3:{ Send_Command IR4_1, "'IRP-6,32,1'" } // кухня
	    }                                                                    
    }
}


BUTTON_EVENT [MIOR4_01_06, KEYPAD_OPENBOX] // управление спутниками
{
PUSH:{
    LOCAL_VAR INTEGER NUM_BUTTONS
    
    NUM_BUTTONS = BUTTON.INPUT.CHANNEL - 200
	SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, NUM_BUTTONS] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, NUM_BUTTONS] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, NUM_BUTTONS] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, NUM_BUTTONS] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, NUM_BUTTONS] } // спутник 5
	    }
    }
HOLD [4]:{
    LOCAL_VAR INTEGER NUM_BUTTONS
    
    NUM_BUTTONS = BUTTON.INPUT.CHANNEL - 200
	SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ TO[IR1, NUM_BUTTONS] } // спутник 1
	    CASE 'S02':{ TO[IR2, NUM_BUTTONS] } // спутник 2
	    CASE 'S03':{ TO[IR3, NUM_BUTTONS] } // спутник 3
	    CASE 'S04':{ TO[IR4, NUM_BUTTONS] } // спутник 4
	    CASE 'S05':{ TO[IR5, NUM_BUTTONS] } // спутник 5
	    }
	}
}


BUTTON_EVENT [MIOR4_01_06, KEYPAD_OPENBOX_MACRO[1]] // SAT 1 List + 
{
    PUSH:   { CANCEL_WAIT 'SAT_1' 
	SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, 29] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, 29] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, 29] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, 29] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, 29] } // спутник 5
	    }
	    }
HOLD [4]:{

	SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ TO[IR1,  29] } // спутник 1
	    CASE 'S02':{ TO[IR2,  29] } // спутник 2
	    CASE 'S03':{ TO[IR3,  29] } // спутник 3
	    CASE 'S04':{ TO[IR4,  29] } // спутник 4
	    CASE 'S05':{ TO[IR5,  29] } // спутник 5
	    }                  
	}
    RELEASE:{ 
	WAIT 5 'SAT_1' {
	    SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1,  23] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2,  23] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3,  23] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4,  23] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5,  23] } // спутник 5
	    }  }
	    }
}  
    
   
BUTTON_EVENT [MIOR4_01_06, KEYPAD_OPENBOX_MACRO[2]] // SAT 1 List -
{
    PUSH:   {  CANCEL_WAIT 'SAT_1'
	SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, 32] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, 32] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, 32] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, 32] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, 32] } // спутник 5
	    } 
	    }
HOLD [4]:{
	SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ TO[IR1,  32] } // спутник 1
	    CASE 'S02':{ TO[IR2,  32] } // спутник 2
	    CASE 'S03':{ TO[IR3,  32] } // спутник 3
	    CASE 'S04':{ TO[IR4,  32] } // спутник 4
	    CASE 'S05':{ TO[IR5,  32] } // спутник 5
	    }                  
	}
    RELEASE:{ 
	WAIT 5 'SAT_1' {
	    SWITCH (STATUS_SOURSE [SAVE_1_NUM_PAGE_])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1,  23] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2,  23] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3,  23] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4,  23] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5,  23] } // спутник 5
	    }  }
	    }
}   
    
BUTTON_EVENT [MIOR4_01_06,  KEYPAD_MAKROS_11[10]] // Перезагрузка спутников
{
PUSH:{
    
	SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_1[1])  } // спутник 1
	    CASE 'S02':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_2[1])  } // спутник 2
	    CASE 'S03':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_3[1])  } // спутник 3
	    CASE 'S04':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_4[1])  } // спутник 4
	    CASE 'S05':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_5[1])  } // спутник 5
	    }                                                   
    }
}
 

///////////////////////////////////////////////////////////////////////////////
///////////     макрокоманды упр. спутником  //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [dvPanelZone_1, KEYPAD_OPENBOX_MACRO[1]] // SAT 1 List + 
{
    PUSH:   { CANCEL_WAIT 'SAT_01' SET_PULSE_TIME(1)  PULSE[IR1, 29] }
    HOLD[4]:{ TO[IR1, 29]}
    RELEASE:{ WAIT 5 'SAT_01' {SET_PULSE_TIME(1)  PULSE[IR1, 23]} }
}

BUTTON_EVENT [dvPanelZone_1, KEYPAD_OPENBOX_MACRO[2]] // SAT 1 List -
{
    PUSH:   { CANCEL_WAIT 'SAT_01' SET_PULSE_TIME(1)  PULSE[IR1, 32] }
    HOLD[4]:{ TO[IR1, 32]}
    RELEASE:{ WAIT 5 'SAT_01' {SET_PULSE_TIME(1)  PULSE[IR1, 23]} }
}

BUTTON_EVENT [dvPanelZone_2, KEYPAD_OPENBOX_MACRO[1]] // SAT 2 List + 
{
    PUSH:   { CANCEL_WAIT 'SAT_02' SET_PULSE_TIME(1)  PULSE[IR2, 29] }
    HOLD[4]:{ TO[IR2, 29]}
    RELEASE:{ WAIT 5 'SAT_02' {SET_PULSE_TIME(1)  PULSE[IR2, 23]} }
}

BUTTON_EVENT [dvPanelZone_2, KEYPAD_OPENBOX_MACRO[2]] // SAT 2 List -
{
    PUSH:   { CANCEL_WAIT 'SAT_02' SET_PULSE_TIME(1)  PULSE[IR2, 32] }
    HOLD[4]:{ TO[IR2, 32]}
    RELEASE:{ WAIT 5 'SAT_02' {SET_PULSE_TIME(1)  PULSE[IR2, 23]} }
}

BUTTON_EVENT [dvPanelZone_3, KEYPAD_OPENBOX_MACRO[1]] // SAT 3 List + 
{
    PUSH:   { CANCEL_WAIT 'SAT_03' SET_PULSE_TIME(1)  PULSE[IR3, 29] }
    HOLD[4]:{ TO[IR3, 29]}
    RELEASE:{ WAIT 5 'SAT_03' {SET_PULSE_TIME(1)  PULSE[IR3, 23]} }
}

BUTTON_EVENT [dvPanelZone_3, KEYPAD_OPENBOX_MACRO[2]] // SAT 3 List -
{
    PUSH:   { CANCEL_WAIT 'SAT_03' SET_PULSE_TIME(1)  PULSE[IR3, 32] }
    HOLD[4]:{ TO[IR3, 32]}
    RELEASE:{ WAIT 5 'SAT_03' {SET_PULSE_TIME(1)  PULSE[IR3, 23]} }
}

BUTTON_EVENT [dvPanelZone_4, KEYPAD_OPENBOX_MACRO[1]] // SAT 4 List + 
{
    PUSH:   { CANCEL_WAIT 'SAT_04' SET_PULSE_TIME(1)  PULSE[IR4, 29] }
    HOLD[4]:{ TO[IR4, 29]}
    RELEASE:{ WAIT 5 'SAT_04' {SET_PULSE_TIME(1)  PULSE[IR4, 23]} }
}

BUTTON_EVENT [dvPanelZone_4, KEYPAD_OPENBOX_MACRO[2]] // SAT 4 List -
{
    PUSH:   { CANCEL_WAIT 'SAT_04' SET_PULSE_TIME(1)  PULSE[IR4, 32] }
    HOLD[4]:{ TO[IR4, 32]}
    RELEASE:{ WAIT 5 'SAT_04' {SET_PULSE_TIME(1)  PULSE[IR4, 23]} }
}

BUTTON_EVENT [dvPanelZone_5, KEYPAD_OPENBOX_MACRO[1]] // SAT 5 List + 
{
    PUSH:   { CANCEL_WAIT 'SAT_05' SET_PULSE_TIME(1)  PULSE[IR5, 29] }
    HOLD[4]:{ TO[IR5, 29]}
    RELEASE:{ WAIT 5 'SAT_05' {SET_PULSE_TIME(1)  PULSE[IR5, 23]} }
}

BUTTON_EVENT [dvPanelZone_5, KEYPAD_OPENBOX_MACRO[2]] // SAT 5 List -
{
    PUSH:   { CANCEL_WAIT 'SAT_05' SET_PULSE_TIME(1)  PULSE[IR5, 32] }
    HOLD[4]:{ TO[IR5, 32]}
    RELEASE:{ WAIT 5 'SAT_05' {SET_PULSE_TIME(1)  PULSE[IR5, 23]} }
}

BUTTON_EVENT [dvCinema, KEYPAD_OPENBOX_MACRO[1]] // SAT CINEMA List + 
{
    PUSH:   { CANCEL_WAIT 'SAT_CI' SET_PULSE_TIME(1)  PULSE[IR_s1_1, 29] }
    HOLD[4]:{ TO[IR_s1_1, 29]}
    RELEASE:{ WAIT 5 'SAT_CI' {SET_PULSE_TIME(1)  PULSE[IR_s1_1, 23]} }
}

BUTTON_EVENT [dvCinema, KEYPAD_OPENBOX_MACRO[2]] // SAT CINEMA List -
{
    PUSH:   { CANCEL_WAIT 'SAT_CI' SET_PULSE_TIME(1)  PULSE[IR_s1_1, 32] }
    HOLD[4]:{ TO[IR_s1_1, 32]}
    RELEASE:{ WAIT 5 'SAT_CI' {SET_PULSE_TIME(1)  PULSE[IR_s1_1, 23]} }
}

///////////////////////////////////////////////////////////////////////////////
///////////     Управление с пульта MIO спальня дочери   /////////////////////
///////////////////////////////////////////////////////////////////////////////


BUTTON_EVENT [MIOR4_02_01, KEYPAD_MAKROS_3] // Выбрать источник в спальне дочери зона № 8
{PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_3)
      CASE_HDMI_ZONE  = 12
      CASE_ZONE  = 8
      IR = IR5_3
      
            SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 8] (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_02_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 8]  (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_02_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_02_01, "'PAGE-[Sourse]_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 4]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_02_01, "'PAGE-[Sourse]_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 4]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 16: //  ИСТОЧНИК DVD
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_02_01, "'PAGE-[Sourse]_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 7]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_02_01, "'PAGE-[Sourse]_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 7]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      }
      }
}


BUTTON_EVENT [MIOR4_02_01, KEYPAD_MAKROS_11[1]] // Выключить зону мультирум
{PUSH:{
		    SEND_COMMAND MIOR4_02_01, "'PAGE-[Zone]_Main_Z2_1'"
		    STATUS_SOURSE[8] = 'OFF'
		    SET_PULSE_TIME (5) PULSE[IR5_3, 1] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[12][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
    }}

BUTTON_EVENT [MIOR4_02_01, KEYPAD_MAKROS_11[2]] // Громкость + 
{
PUSH:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_9[36]) 
    }
HOLD [4, REPEAT]:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_9[36]) 
    }
}


BUTTON_EVENT [MIOR4_02_01, KEYPAD_MAKROS_11[3]] // Громкость -
{
PUSH:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_9[37]) 
    }
HOLD [4, REPEAT]:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_9[37]) 
    }
}


BUTTON_EVENT [MIOR4_02_01, KEYPAD_MAKROS_11[4]] // Громкость off
{
PUSH:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_9[34]) 
    }
}

BUTTON_EVENT [MIOR4_02_01, KEYPAD_MAKROS_11[5]] // Громкость off TV
{
PUSH:{
      Send_Command IR5_3, "'IRP-32,3,1'" } // сп дочери
HOLD [3, REPEAT]:{
      Send_Command IR5_3, "'IRP-32,3,1'" } // сп дочери
}

BUTTON_EVENT [MIOR4_02_06, KEYPAD_OPENBOX] // управление спутниками
{
PUSH:{
    LOCAL_VAR INTEGER NUM_BUTTONS
    
    NUM_BUTTONS = BUTTON.INPUT.CHANNEL - 200
	SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, NUM_BUTTONS] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, NUM_BUTTONS] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, NUM_BUTTONS] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, NUM_BUTTONS] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, NUM_BUTTONS] } // спутник 5
	    }
    }
HOLD [4]:{
    LOCAL_VAR INTEGER NUM_BUTTONS
    
    NUM_BUTTONS = BUTTON.INPUT.CHANNEL - 200
	SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ TO[IR1, NUM_BUTTONS] } // спутник 1
	    CASE 'S02':{ TO[IR2, NUM_BUTTONS] } // спутник 2
	    CASE 'S03':{ TO[IR3, NUM_BUTTONS] } // спутник 3
	    CASE 'S04':{ TO[IR4, NUM_BUTTONS] } // спутник 4
	    CASE 'S05':{ TO[IR5, NUM_BUTTONS] } // спутник 5
	    }
	}
}


BUTTON_EVENT [MIOR4_02_06, KEYPAD_OPENBOX_MACRO[1]] // SAT 1 List + 
{
    PUSH:   { CANCEL_WAIT 'SAT_2'
	SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, 29] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, 29] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, 29] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, 29] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, 29] } // спутник 5
	    }
	    }
HOLD [4]:{

	SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ TO[IR1,  29] } // спутник 1
	    CASE 'S02':{ TO[IR2,  29] } // спутник 2
	    CASE 'S03':{ TO[IR3,  29] } // спутник 3
	    CASE 'S04':{ TO[IR4,  29] } // спутник 4
	    CASE 'S05':{ TO[IR5,  29] } // спутник 5
	    }                  
	}
    RELEASE:{ 
	WAIT 5 'SAT_2' {
	    SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1,  23] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2,  23] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3,  23] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4,  23] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5,  23] } // спутник 5
	    }  }
	    }
}  
    
   
BUTTON_EVENT [MIOR4_02_06, KEYPAD_OPENBOX_MACRO[2]] // SAT 1 List -
{
    PUSH:   { CANCEL_WAIT 'SAT_2'
	SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, 32] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, 32] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, 32] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, 32] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, 32] } // спутник 5
	    } 
	    }
HOLD [4]:{
	SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ TO[IR1,  32] } // спутник 1
	    CASE 'S02':{ TO[IR2,  32] } // спутник 2
	    CASE 'S03':{ TO[IR3,  32] } // спутник 3
	    CASE 'S04':{ TO[IR4,  32] } // спутник 4
	    CASE 'S05':{ TO[IR5,  32] } // спутник 5
	    }                  
	}
    RELEASE:{ 
	WAIT 5 'SAT_2' {
	    SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1,  23] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2,  23] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3,  23] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4,  23] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5,  23] } // спутник 5
	    }  }
	    }
}   
    
BUTTON_EVENT [MIOR4_02_06,  KEYPAD_MAKROS_11[10]] // Перезагрузка спутников
{
PUSH:{
    
	SWITCH (STATUS_SOURSE [8])
	    { 
	    CASE 'S01':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_1[1])  } // спутник 1
	    CASE 'S02':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_2[1])  } // спутник 2
	    CASE 'S03':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_3[1])  } // спутник 3
	    CASE 'S04':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_4[1])  } // спутник 4
	    CASE 'S05':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_5[1])  } // спутник 5
	    }                                                   
    }
}
 


///////////////////////////////////////////////////////////////////////////////
///////////     Управление с пульта MIO спальня сына      /////////////////////
///////////////////////////////////////////////////////////////////////////////
      
      

BUTTON_EVENT [MIOR4_03_01, KEYPAD_MAKROS_3] // Выбрать источник в спальне сына зона № 11
{PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_3)
      CASE_HDMI_ZONE  = 15
      CASE_ZONE  = 11
      IR = IR6_3
      
            SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 2] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_03_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 2]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO_MIO_1 (MIOR4_03_01, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_03_01, "'PAGE-[Sourse]_TV_Z03'"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 7] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SEND_COMMAND MIOR4_03_01, "'PAGE-[Sourse]_TV_Z03'"
	     SET_PULSE_TIME (3) PULSE[IR, 7]   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      }
      }
}

BUTTON_EVENT [MIOR4_03_01, KEYPAD_MAKROS_11[1]] // Выключить зону мультирум
{PUSH:{
		    SEND_COMMAND MIOR4_03_01, "'PAGE-[Zone]_Main_Z2_1'"
		    STATUS_SOURSE[11] = 'OFF'
	            SET_PULSE_TIME (5) PULSE[IR6_3, 37] (*OFF TV*)
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[15][17])      // ВЫХОД 1 ВХОД i 
		    DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [33]) // ВЫХОД 1 ВХОД i 
    }}

BUTTON_EVENT [MIOR4_03_01, KEYPAD_MAKROS_11[2]] // Громкость + 
{
PUSH:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_8[36]) 
    }
HOLD [3, REPEAT]:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_8[36]) 
    }
}


BUTTON_EVENT [MIOR4_03_01, KEYPAD_MAKROS_11[3]] // Громкость -
{
PUSH:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_8[37]) 
    }
HOLD [3, REPEAT]:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_8[37]) 
    }
}


BUTTON_EVENT [MIOR4_03_01, KEYPAD_MAKROS_11[4]] // Громкость off
{
PUSH:{
	DO_PUSH (dvPanelAllZone[1], KEYPAD_AUDIO_MAKROS_8[34]) 
    }
}

BUTTON_EVENT [MIOR4_03_01, KEYPAD_MAKROS_11[5]] // Громкость off TV
{
PUSH:{
      Send_Command IR6_3, "'IRP-22,3,1'" } // кухня
}


BUTTON_EVENT [MIOR4_03_06, KEYPAD_OPENBOX] // управление спутниками
{
PUSH:{
    LOCAL_VAR INTEGER NUM_BUTTONS
    
    NUM_BUTTONS = BUTTON.INPUT.CHANNEL - 200
	SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, NUM_BUTTONS] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, NUM_BUTTONS] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, NUM_BUTTONS] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, NUM_BUTTONS] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, NUM_BUTTONS] } // спутник 5
	    }
    }
HOLD [4]:{
    LOCAL_VAR INTEGER NUM_BUTTONS
    
    NUM_BUTTONS = BUTTON.INPUT.CHANNEL - 200
	SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ TO[IR1, NUM_BUTTONS] } // спутник 1
	    CASE 'S02':{ TO[IR2, NUM_BUTTONS] } // спутник 2
	    CASE 'S03':{ TO[IR3, NUM_BUTTONS] } // спутник 3
	    CASE 'S04':{ TO[IR4, NUM_BUTTONS] } // спутник 4
	    CASE 'S05':{ TO[IR5, NUM_BUTTONS] } // спутник 5
	    }
	}
}



BUTTON_EVENT [MIOR4_03_06, KEYPAD_OPENBOX_MACRO[1]] // SAT 1 List + 
{
    PUSH:   {  CANCEL_WAIT 'SAT_3'
	SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, 29] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, 29] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, 29] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, 29] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, 29] } // спутник 5
	    }
	    }
HOLD [4]:{

	SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ TO[IR1,  29] } // спутник 1
	    CASE 'S02':{ TO[IR2,  29] } // спутник 2
	    CASE 'S03':{ TO[IR3,  29] } // спутник 3
	    CASE 'S04':{ TO[IR4,  29] } // спутник 4
	    CASE 'S05':{ TO[IR5,  29] } // спутник 5
	    }                  
	}
    RELEASE:{ 
	WAIT 5 'SAT_3' {
	    SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1,  23] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2,  23] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3,  23] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4,  23] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5,  23] } // спутник 5
	    }  }
	    }
}  
    
   
BUTTON_EVENT [MIOR4_03_06, KEYPAD_OPENBOX_MACRO[2]] // SAT 1 List -
{
    PUSH:   { CANCEL_WAIT 'SAT_3'
	SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1, 32] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2, 32] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3, 32] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4, 32] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5, 32] } // спутник 5
	    } 
	    }
HOLD [4]:{
	SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ TO[IR1,  32] } // спутник 1
	    CASE 'S02':{ TO[IR2,  32] } // спутник 2
	    CASE 'S03':{ TO[IR3,  32] } // спутник 3
	    CASE 'S04':{ TO[IR4,  32] } // спутник 4
	    CASE 'S05':{ TO[IR5,  32] } // спутник 5
	    }                  
	}
    RELEASE:{ 
	WAIT 5 'SAT_3' {
	    SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ SET_PULSE_TIME (1) PULSE[IR1,  23] } // спутник 1
	    CASE 'S02':{ SET_PULSE_TIME (1) PULSE[IR2,  23] } // спутник 2
	    CASE 'S03':{ SET_PULSE_TIME (1) PULSE[IR3,  23] } // спутник 3
	    CASE 'S04':{ SET_PULSE_TIME (1) PULSE[IR4,  23] } // спутник 4
	    CASE 'S05':{ SET_PULSE_TIME (1) PULSE[IR5,  23] } // спутник 5
	    }  }
	    }
}   
    
BUTTON_EVENT [MIOR4_03_06,  KEYPAD_MAKROS_11[10]] // Перезагрузка спутников
{
PUSH:{
    
	SWITCH (STATUS_SOURSE [11])
	    { 
	    CASE 'S01':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_1[1])  } // спутник 1
	    CASE 'S02':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_2[1])  } // спутник 2
	    CASE 'S03':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_3[1])  } // спутник 3
	    CASE 'S04':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_4[1])  } // спутник 4
	    CASE 'S05':{ DO_PUSH(dvPanelAllZone[1], KEYPAD_SP50_KRAMER_5[1])  } // спутник 5
	    }                                                   
    }
}
 






///////////////////////////////////////////////////////////////////////////////
///////////          режим холод тепло       //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


BUTTON_EVENT [dvCoolMaster, BLOCK_BUTTONS[1]] // режим холод
{PUSH:{
IF ( ![dvCoolMaster, BLOCK_BUTTONS[1]] && ![dvCoolMaster, BLOCK_BUTTONS[2]] )
    {
    ON[dvCoolMaster, BLOCK_BUTTONS[1]]
    DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[1])
                                
    WAIT 100	{
        DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[3])
        DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[3])
        DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[3])
        DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[3])
        DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[3])
        DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[3])
        DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[3])
        WAIT 100	{
            DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[2])
	    WAIT 30	{ OFF[dvCoolMaster, BLOCK_BUTTONS[1]] }
			}
		}
    }
}}

BUTTON_EVENT [dvCoolMaster, BLOCK_BUTTONS[2]] // режим тепло
{PUSH:{
IF ( ![dvCoolMaster, BLOCK_BUTTONS[1]] && ![dvCoolMaster, BLOCK_BUTTONS[2]] )
    {
    ON[dvCoolMaster, BLOCK_BUTTONS[2]]
    DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[1])
    DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[1])
                                
    WAIT 100	{
        DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[5])
        DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[5])
        DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[5])
        DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[5])
        DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[5])
        DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[5])
        DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[5])
        WAIT 100	{
            DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[2])
            DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[2])
	    WAIT 30	{ OFF[dvCoolMaster, BLOCK_BUTTONS[2]] }
			}
		}
    }
}}

BUTTON_EVENT [dvCoolMaster, BLOCK_BUTTONS[3]] // Включить конд 
{PUSH:{
    IF (![dvCoolMaster, BLOCK_BUTTONS[3]] && ![dvCoolMaster, BLOCK_BUTTONS[4]])
    {
        SET_PULSE_TIME (30) PULSE[dvCoolMaster, BLOCK_BUTTONS[3]]
        DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[1])
        DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[1])
        DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[1])
        DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[1])
        DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[1])
        DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[1])
        DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[1])
    }
}}

BUTTON_EVENT [dvCoolMaster, BLOCK_BUTTONS[4]] // Выключить конд 
{PUSH:{
    IF (![dvCoolMaster, BLOCK_BUTTONS[3]] && ![dvCoolMaster, BLOCK_BUTTONS[4]])
    {
        SET_PULSE_TIME (30) PULSE[dvCoolMaster, BLOCK_BUTTONS[4]]
        DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[2])
        DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[2])
        DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[2])
        DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[2])
        DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[2])
        DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[2])
        DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[2])
    }
}}


BUTTON_EVENT [dvCoolMaster, BLOCK_BUTTONS[5]] // Запрос состояния конд
{PUSH:{
        DO_PUSH (dvCoolMaster[1], BLOCK101_BUTTONS[17])
        DO_PUSH (dvCoolMaster[1], BLOCK102_BUTTONS[17])
        DO_PUSH (dvCoolMaster[1], BLOCK103_BUTTONS[17])
        DO_PUSH (dvCoolMaster[1], BLOCK104_BUTTONS[17])
        DO_PUSH (dvCoolMaster[1], BLOCK105_BUTTONS[17])
        DO_PUSH (dvCoolMaster[1], BLOCK106_BUTTONS[17])
        DO_PUSH (dvCoolMaster[1], BLOCK107_BUTTONS[17])
}}



(************************ Главная страница панелей настенных панелей ************************************)

DATA_EVENT [dvPanelAllZone]
{ONLINE:{
    LOCAL_VAR INTEGER NUM_PANEL

    NUM_PANEL   = GET_LAST (dvPanelAllZone)
    WAIT 10{
    SWITCH (NUM_PANEL)
    {
	CASE 7: { SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z01_Main'" (*MSD-431 1002 Бильярдная        *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 8: { SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z02_Main'" (*MSD-431 1003 Спортзал          *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 9: { SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z05_Main'" (*MSD-431 1004 Кухня             *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 10:{ SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Main_Z04_'"(*MSD-701 1005 Столовая          *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 11:{ SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z07_Main'" (*MSD-431 1006 Зал               *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 12:{ SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z11_Main'" (*MSD-431 1007 Басейн            *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 13:{ SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Main_Z07_'"(*MSD-701 1008 Спальня хозяина   *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 14:{ SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z03_Main'" (*MSD-431 1009 СУ хозяна         *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 15:{ SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z09_Main'" (*MSD-431 1010 Спальня дочери    *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 16:{ SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z08_Main'" (*MSD-431 1011 Спальня сына      *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
	CASE 17:{ SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'PAGE-Z10_Main'" (*MSD-431 1012 Зимний сад        *) DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) WAIT 10 {SEND_COMMAND dvPanelAllZone[NUM_PANEL], "'@PPX'"}}
    }}                                                                                        
}
}


BUTTON_EVENT [ALL_PORT_1001, 0]
{PUSH:{cancel_wait '1'   WAIT  T_WAIT '1'   {(*SEND_COMMAND ALL_PORT_1001[1], "'PAGE-Z01_Main'" DO_PUSH(MVP_MCE1[6], CONST_MCS_OF)*)}     }}  // 1001 Кинотетар
BUTTON_EVENT [ALL_PORT_1002, 0]                                                                               
{PUSH:{cancel_wait '2'   WAIT  T_WAIT '2'   {SEND_COMMAND ALL_PORT_1002[1], "'PAGE-Z01_Main'" DO_PUSH(MVP_MCE1[7], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1002[1], "'@PPX'"} }    }} // 1002 Бильярдная
BUTTON_EVENT [ALL_PORT_1003, 0]                                                                               
{PUSH:{cancel_wait '3'   WAIT  T_WAIT '3'   {SEND_COMMAND ALL_PORT_1003[1], "'PAGE-Z02_Main'" DO_PUSH(MVP_MCE1[8], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1003[1], "'@PPX'"}}     }} // 1003 Спортзал   
BUTTON_EVENT [ALL_PORT_1004, 0]                                                                               
{PUSH:{cancel_wait '4'   WAIT  T_WAIT '4'   {SEND_COMMAND ALL_PORT_1004[1], "'PAGE-Z05_Main'" DO_PUSH(MVP_MCE1[9], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1004[1], "'@PPX'"}}     }} // 1004 Кухня
BUTTON_EVENT [ALL_PORT_1005, 0]                                                                               
{PUSH:{cancel_wait '5'   WAIT  T_WAIT '5'   {SEND_COMMAND ALL_PORT_1005[1], "'PAGE-Main_Z04_'" DO_PUSH(MVP_MCE1[10], CONST_MCS_OF)WAIT 10 {SEND_COMMAND ALL_PORT_1005[1], "'@PPX'"}}    }} // 1005 Столовая
BUTTON_EVENT [ALL_PORT_1006, 0]                                                                               
{PUSH:{cancel_wait '6'   WAIT  T_WAIT '6'   {SEND_COMMAND ALL_PORT_1006[1], "'PAGE-Z07_Main'" DO_PUSH(MVP_MCE1[11], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1006[1], "'@PPX'"} }   }} // 1006 Зал
BUTTON_EVENT [ALL_PORT_1007, 0]                                                                               
{PUSH:{cancel_wait '7'   WAIT  T_WAIT '7'   {SEND_COMMAND ALL_PORT_1007[1], "'PAGE-Z11_Main'" DO_PUSH(MVP_MCE1[12], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1007[1], "'@PPX'"}}    }} // 1007 Бассейн
BUTTON_EVENT [ALL_PORT_1008, 0]                                                                               
{PUSH:{cancel_wait '8'   WAIT  T_WAIT '8'   {SEND_COMMAND ALL_PORT_1008[1], "'PAGE-Main_Z07_'" DO_PUSH(MVP_MCE1[13], CONST_MCS_OF)WAIT 10 {SEND_COMMAND ALL_PORT_1008[1], "'@PPX'"}}    }} // 1008 Спальня Хозяев
BUTTON_EVENT [ALL_PORT_1009, 0]                                                                               
{PUSH:{cancel_wait '9'   WAIT  T_WAIT '9'   {SEND_COMMAND ALL_PORT_1009[1], "'PAGE-Z03_Main'" DO_PUSH(MVP_MCE1[14], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1009[1], "'@PPX'"}}    }} // 1009 СУ хозяев
BUTTON_EVENT [ALL_PORT_1010, 0]                                                                               
{PUSH:{cancel_wait '10'   WAIT  T_WAIT '10' {SEND_COMMAND ALL_PORT_1010[1], "'PAGE-Z09_Main'" DO_PUSH(MVP_MCE1[15], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1010[1], "'@PPX'"}}    }} // 1010 Спальня дочери
BUTTON_EVENT [ALL_PORT_1011, 0]                                                                                                
{PUSH:{cancel_wait '11'   WAIT  T_WAIT '11' {SEND_COMMAND ALL_PORT_1011[1], "'PAGE-Z08_Main'" DO_PUSH(MVP_MCE1[16], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1011[1], "'@PPX'"}}    }} // 1011 Спальня сына 
BUTTON_EVENT [ALL_PORT_1012, 0]                                                                                                
{PUSH:{cancel_wait '12'   WAIT  T_WAIT '12' {SEND_COMMAND ALL_PORT_1012[1], "'PAGE-Z10_Main'" DO_PUSH(MVP_MCE1[17], CONST_MCS_OF) WAIT 10 {SEND_COMMAND ALL_PORT_1012[1], "'@PPX'"}}    }} // 1012 Зимний сад
                                                                                                                               





(************************ УПРАВЛЕНИЕ Кинотеатром ************************************)

// Управление кинотетаром

DATA_EVENT [dvCinema]
{
ONLINE:{
      LOCAL_VAR INTEGER CASE_PANEL
	
      CASE_PANEL = GET_LAST (dvCinema)
      
      SWITCH (CINEMA_POWER)
      {
      CASE 'ON':    {StatusCinemaON  (CASE_PANEL)}
      CASE 'OFF':   {StatusCinemaOFF (CASE_PANEL)}
      }
      
}}

BUTTON_EVENT [dvCinema, KEYPAD_MAKROS_CINEMA]   //  управление макросами
{
PUSH:{
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR INTEGER CASE_PANEL

      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_CINEMA)
      CASE_PANEL = GET_LAST (dvCinema)
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  Открыть страницу кинотеатра 
	    {
              SWITCH (CINEMA_POWER)
              {
              CASE 'ON':    {StatusCinemaON  (CASE_PANEL)}
              CASE 'OFF':   {StatusCinemaOFF (CASE_PANEL)}
              }
	    SEND_COMMAND dvCinema[CASE_PANEL],"'PAGE-Main_VIDEO_CINEMA'"
	    }
      CASE 2:  //  Включить кинотетар 
	    {
	    CINEMA_POWER = 'ON'
	    StatusCinemaON  (CASE_PANEL)
	    DO_PUSH(dvCinema[1],KEYPAD_RUNCO[1])   (*Включить проектор*) Wait 300 'ON_CINEMA' {DO_PUSH(dvCinema[1],KEYPAD_RUNCO[3])} // HDMI 1
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[3])  WAIT 20 {SEND_LEVEL vdvCinema, KEYPAD_ADA_AVR[1], 36}   // Включить ada
	    ON [IO_S1, 1]
	    DO_PUSH(dvCinema[1],KEYPAD_BR_PIONEER_CINEMA[51]) // BR ON
	    }
      CASE 3:  //  Выключить кинотеатр  
	    {
	    CINEMA_POWER = 'OFF'
	    StatusCinemaOFF (CASE_PANEL)
	    SEND_COMMAND dvCinema[CASE_PANEL], "'@PPX'"
	    DO_PUSH(dvCinema[1],KEYPAD_RUNCO[2])
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[1])   // OFF ada
	    OFF [IO_S1, 1]
	    DO_PUSH(dvCinema[1],KEYPAD_BR_PIONEER_CINEMA[52]) // BR OFF
	    }
      CASE 6:  //  Вход Спутник
	    {
	    IF (CINEMA_POWER = 'ON') {
	    CINEMA_SOURSE = 'SAT'
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[4])   // Input 2
	    SET_PULSE_TIME (2) PULSE[IR_s1_2,49] // Pause BR
	    }}
      CASE 7:  //  Вход Цифра       
	    {
	    IF (CINEMA_POWER = 'ON') {
	    CINEMA_SOURSE = 'DTV'
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[5])   // Input 3
	    SET_PULSE_TIME (2) PULSE[IR_s1_2,49] // Pause BR
	    }}
      CASE 8:  //  Вход BR      
	    {
	    IF (CINEMA_POWER = 'ON') {
	    IF (CINEMA_SOURSE != 'BR')
	    {
	    CINEMA_SOURSE = 'BR'
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[3])   // Input 1
	    wait 10 {DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[10])}
	    wait 20 {DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[3])}
	    }}}
      CASE 9:  //  Вход inext       
	    {
	    IF (CINEMA_POWER = 'ON') {
	    CINEMA_SOURSE = 'INT'
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[6])   // Input 4
	    SET_PULSE_TIME (2) PULSE[IR_s1_2,49] // Pause BR
	    }}
	CASE 15:  //  Перезагрузка Спутника     
	    {
	    SET_PULSE_TIME(50) PULSE[IO_S1, 2]
	    SET_PULSE_TIME(50) PULSE[dvCinema, KEYPAD_MAKROS_CINEMA[15]]
	    }
	    CASE 16:  //  Вкл усилителя    
	    {
	    ON[IO_S1, 1]	
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[3])
	    }
	    CASE 17:  //  Выкл усилителя    
	    {
	    OFF[IO_S1, 1]	
	    DO_PUSH(dvCinema[1],KEYPAD_ADA_AVR[1])
	    }


}}}

DATA_EVENT [IO_S1]
{ONLINE:{ WAIT 50 {IF (CINEMA_POWER = 'ON') ON[IO_S1, 1]}}}



(************************ УПРАВЛЕНИЕ Audio Media Serverom ************************************)



BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_1]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON                                         
    LOCAL_VAR INTEGER NUM_SOURSE                                        
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_1)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 1             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) }  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON) }     }  // 
    }        
}}


BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_2]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_2)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 2             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON) }     }  // 
    }        
}}


BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_3]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_3)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 3             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}

BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_4]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_4)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 4             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}
BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_5]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_5)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 5             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}
BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_6]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_6)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 6             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}
BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_7]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_7)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 7             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}
BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_8]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_8)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 8             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}
BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_9]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_9)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 9             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}
BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_10]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_10)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 10             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF)}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}
BUTTON_EVENT [dvPanelAllZone, KEYPAD_AUDIO_MAKROS_11]               //           
{PUSH:{                                                               
    LOCAL_VAR INTEGER NUM_PANEL                         
    LOCAL_VAR INTEGER NUM_BUTTON    
    LOCAL_VAR INTEGER NUM_SOURSE          
    LOCAL_VAR INTEGER NUM_ZONE                                       
                                                           
    NUM_PANEL   = GET_LAST (dvPanelAllZone)                 
    NUM_BUTTON  = GET_LAST (KEYPAD_AUDIO_MAKROS_11)                
    NUM_SOURSE  = NUM_BUTTON - 14             
    NUM_ZONE  = 11             
    
    SWITCH (NUM_BUTTON)
    {  
	CASE 33:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SET_PULSE_TIME (3) PULSE [IR8, 2]}  // Выключить 
	CASE 15:
	CASE 16:
	CASE 17:
	CASE 18:{DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SET_PULSE_TIME (3) PULSE [IR8, 1] IF (BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE) {DO_PUSH (dvPanelZone_1[1], KEYPAD_TUNER[NUM_SOURSE][33]) SEND_COMMAND dvPanelAllZone[NUM_PANEL],"'@PPN-[Sourse]_FM0', ITOA (NUM_SOURSE)" } ELSE {SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}}  // источник 1
	CASE 19:
	CASE 20:
	CASE 21:
	CASE 22:{SET_PULSE_TIME (3) PULSE [IR8, 1] IF ((BASY_SOURSE[NUM_BUTTON] = 0 || BASY_SOURSE[NUM_BUTTON] = NUM_ZONE)) {DO_PUSH(MVP_MCE1[NUM_PANEL], NUM_SOURSE - 4 + 2010)} ELSE {DO_PUSH(MVP_MCE1[NUM_PANEL], CONST_MCS_OF) SEND_TXT_AUDIO_ZONE (NUM_PANEL, NUM_BUTTON)}     }  // 
    }        
}}






(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 1 бильярдная ************************************)
(*******    ***************************)

BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_1]   //  управление макросами в Zone 1 бильярдная
{
PUSH:{
      LOCAL_VAR INTEGER CASE_PANEL
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR

      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_1)
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_HDMI_ZONE  = 5
      CASE_ZONE  = 1
      IR = IR7_1
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-1,7,1'" WAIT 10{ Send_Command IR, "'IRP-1,7,1'" } (*ON TV*) WAIT 120 { Send_Command IR, "'IRP-3,5,1'" WAIT 20 { Send_Command IR, "'IRP-3,5,1'" }} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_1 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-3,3,1'"   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_1 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-1,7,1'" WAIT 10{ Send_Command IR, "'IRP-1,7,1'" } (*ON TV*) WAIT 120 { Send_Command IR, "'IRP-5,5,1'" WAIT 20 { Send_Command IR, "'IRP-5,5,1'" }} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_1 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-5,3,1'"   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_1 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     Send_Command IR, "'IRP-2,7,1'" WAIT 10{ Send_Command IR, "'IRP-2,7,1'" } (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_1 [33]) // ВЫХОД 1 ВХОД i 
	     
             }
      }
      }
}


(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 2 спортзал ************************************)
(*******    ***************************)

BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_2]   //  управление макросами в Zone 2 спортзал
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_2)
      CASE_HDMI_ZONE  = 6
      CASE_ZONE  = 2
      IR = IR7_2
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-1,7,1'" WAIT 10{ Send_Command IR, "'IRP-1,7,1'" } (*ON TV*) WAIT 120 { Send_Command IR, "'IRP-3,5,1'" WAIT 20 { Send_Command IR, "'IRP-3,5,1'" }} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_2 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-3,3,1'"   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_2 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-1,7,1'" WAIT 10{ Send_Command IR, "'IRP-1,7,1'" } (*ON TV*) WAIT 120 { Send_Command IR, "'IRP-5,5,1'" WAIT 20 { Send_Command IR, "'IRP-5,5,1'" }} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_2 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-5,3,1'"   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_2 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     Send_Command IR, "'IRP-2,7,1'" WAIT 10{ Send_Command IR, "'IRP-2,7,1'" } (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_2 [33]) // ВЫХОД 1 ВХОД i 
	     
             }
      }
      }
}


(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 3 кухня ************************************)
(*******    ***************************)

BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_3]   //  управление макросами В Zone 3 кухня
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_3)
      CASE_HDMI_ZONE  = 7
      CASE_ZONE  = 3
      IR = IR8_1
      
            SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 8] (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 8]  (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 4]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 4]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 16: //  ИСТОЧНИК DVD
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 7]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 7]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_5 [33]) // ВЫХОД 1 ВХОД i 
             }
      }
      }
}

(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 4 столовая ************************************)
(*******    ***************************)

BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_4]   //  управление макросами В Zone 4 столовая
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_4)
      CASE_HDMI_ZONE  = 8
      CASE_ZONE  = 4
      IR = IR8_2
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 19] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 28] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 28]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 19] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 24] } (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 24]   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (5) PULSE[IR, 20] (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_6 [33]) // ВЫХОД 1 ВХОД i 
	     
             }
      }
      }
}

(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 5 зал ************************************)
(*******    ***************************)

BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_5]   //  управление макросами В Zone 5 зал
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_5)
      CASE_HDMI_ZONE  = 9
      CASE_ZONE  = 5
      IR = IR2_3
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 11] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (5) PULSE[IR2_1, 2] (*OFF avr*)
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 11]   (*HDMI 1 TV*)
	     SET_PULSE_TIME (5) PULSE[IR2_1, 2] (*OFF avr*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 16: //  ИСТОЧНИК RADIO
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 10] } (*TV 1 TV*)
	     SET_PULSE_TIME (5) PULSE[IR2_1, 1] (*ON AVR*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR2_1, 21] } (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	      STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 3]   (*TV 1 TV*)
	     SET_PULSE_TIME (3) PULSE[IR2_1, 10]
	     WAIT 10 { SET_PULSE_TIME (5) PULSE[IR2_1, 1] (*ON AVR*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR2_1, 21] }} (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 17: //  ИСТОЧНИК DVD
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 10] } (*TV 1 TV*)
	     SET_PULSE_TIME (5) PULSE[IR2_1, 1] (*ON AVR*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR2_1, 8] } (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (3) PULSE[IR3_1, 1]
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 10]   (*TV 1 TV*)
	     SET_PULSE_TIME (3) PULSE[IR2_1, 8]
	     WAIT 10 { SET_PULSE_TIME (5) PULSE[IR2_1, 1] (*ON AVR*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR2_1, 8] }} (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
     	     SET_PULSE_TIME (3) PULSE[IR3_1, 1]
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (5) PULSE[IR, 2] (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_7 [33]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (3) PULSE[IR2_1, 2]
	     SET_PULSE_TIME (3) PULSE[IR3_1, 2]
             }
      }
      }
}


(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 6 бассейн ************************************)
(*******    ***************************)

BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_6]   //  управление макросами В Zone 6 бассейн
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_6)
      CASE_HDMI_ZONE  = 10
      CASE_ZONE  = 6
      IR = IR9_2
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-1,7,1'" WAIT 10{ Send_Command IR, "'IRP-1,7,1'" } (*ON TV*) WAIT 120 { Send_Command IR, "'IRP-4,5,1'" WAIT 20 { Send_Command IR, "'IRP-4,5,1'" }} (*HDMI 2 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_11 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (3) PULSE [IR8, 1]
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-4,3,1'"    (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_11 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (3) PULSE [IR8, 1]
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-1,7,1'" WAIT 10{ Send_Command IR, "'IRP-1,7,1'" } (*ON TV*) WAIT 120 { Send_Command IR, "'IRP-5,5,1'" WAIT 20 { Send_Command IR, "'IRP-5,5,1'" }} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_11 [33]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (3) PULSE [IR8, 2]
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     Send_Command IR, "'IRP-5,3,1'"   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_11 [33]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (3) PULSE [IR8, 2]
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     Send_Command IR, "'IRP-2,5,1'" WAIT 10{ Send_Command IR, "'IRP-2,7,1'" } (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_11 [33]) // ВЫХОД 1 ВХОД i 
	     SET_PULSE_TIME (3) PULSE [IR8, 2]
             }
      }
      }
}

(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 7 спальня хозяина ************************************)
(*******    ***************************)


BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_7]   //  управление макросами В Zone 7 спальня хозяина
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR DEV IR_AVR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_7)
      CASE_HDMI_ZONE  = 11
      CASE_ZONE  = 7
      IR_AVR = IR4_1
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR_AVR, 16] (*ON TV*) WAIT 60 {SET_PULSE_TIME (3) PULSE[IR_AVR, 125] WAIT 10 { SET_PULSE_TIME (3) PULSE[IR_AVR, 4] }} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR_AVR, 4]  (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR_AVR, 16] (*ON TV*) WAIT 60 {SET_PULSE_TIME (3) PULSE[IR_AVR, 125] WAIT 10 { SET_PULSE_TIME (3) PULSE[IR_AVR, 107] }} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR_AVR, 107]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 16: //  ИСТОЧНИК DVD
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR_AVR, 16] (*ON TV*) WAIT 60 {SET_PULSE_TIME (3) PULSE[IR_AVR, 125] WAIT 10 { SET_PULSE_TIME (3) PULSE[IR_AVR, 2] }} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR_AVR, 2]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (5) PULSE[IR_AVR, 17] (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_4 [33]) // ВЫХОД 1 ВХОД i 
	     
             }
      }
      }
}



(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 8 спальня дочери ************************************)
(*******    ***************************)


BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_8]   //  управление макросами В Zone 8 спальня дочери
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_8)
      CASE_HDMI_ZONE  = 12
      CASE_ZONE  = 8
      IR = IR5_3
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5)   PULSE[IR, 8]  (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 8]  (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 4]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 4]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 16: //  ИСТОЧНИК DVD
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 7]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 7]  (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_9 [33]) // ВЫХОД 1 ВХОД i 
	     
             }
      }
      }
}


(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 9 кабинет дочери ************************************)
(*******    ***************************)


BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_9]   //  управление макросами В Zone 9 кабинет дочери
{ 
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_9)
      CASE_HDMI_ZONE  = 13
      CASE_ZONE  = 9
      IR = IR11_1
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 19] (*ON TV*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR, 28] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 28]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 19] (*ON TV*) WAIT 40 { SET_PULSE_TIME (3) PULSE[IR, 24] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 24]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (3) PULSE[IR, 20]   (*OFF*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
             }
      }
      }
}


(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 10 кабинет хозяина ************************************)
(*******    ***************************)


BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_10]   //  управление макросами В Zone 10 кабинет хозяина
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_10)
      CASE_HDMI_ZONE  = 14
      CASE_ZONE  = 10
      IR = IR11_2
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 32] WAIT 10 { SET_PULSE_TIME (5) PULSE[IR, 32]} (*ON TV*) WAIT 50 { SET_PULSE_TIME (3) PULSE[IR, 37] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 37]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 3] WAIT 10 { SET_PULSE_TIME (5) PULSE[IR, 3]} (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 3]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (3) PULSE[IR,33]   (*OFF*)
	     WAIT 10 {SET_PULSE_TIME (3) PULSE[IR,33]}   (*OFF*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
             }
      }
      }
}

(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 11 спальня сына ************************************)
(*******    ***************************)

BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_11]   //  управление макросами В Zone 11 спальня сына
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_11)
      CASE_HDMI_ZONE  = 15
      CASE_ZONE  = 11
      IR = IR6_3
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 2] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 2]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 7] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 7]   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (5) PULSE[IR, 37] (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_8 [33]) // ВЫХОД 1 ВХОД i 
	     
             }
      }
      }
}

(************************ УПРАВЛЕНИЕ МАКРОСАМИ В Zone 12 Зимний сад ************************************)
(*******    ***************************)


BUTTON_EVENT [dvPanelAllZone, KEYPAD_MAKROS_12]   //  управление макросами В Zone 12 Зимний сад
{
PUSH:{
      LOCAL_VAR INTEGER CASE_ZONE
      LOCAL_VAR INTEGER CASE_HDMI_ZONE
      LOCAL_VAR INTEGER CASE_BUTTONS
      LOCAL_VAR DEV IR
      LOCAL_VAR INTEGER CASE_PANEL
      
      CASE_PANEL   = GET_LAST (dvPanelAllZone)
      CASE_BUTTONS = GET_LAST (KEYPAD_MAKROS_12)
      CASE_HDMI_ZONE  = 16
      CASE_ZONE  = 12
      IR = IR12_2
      
      
      SWITCH (CASE_BUTTONS)
      {
      CASE 1:  //  ИСТОЧНИК Cпутник1 
      CASE 2:  //  ИСТОЧНИК Cпутник2
      CASE 3:  //  ИСТОЧНИК Cпутник3
      CASE 4:  //  ИСТОЧНИК Cпутник4
      CASE 5:  //  ИСТОЧНИК Cпутник5
      CASE 6:  //  ИСТОЧНИК DTV      
      CASE 7:  //  ИСТОЧНИК APPLE TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 2] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_10 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 2]   (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][CASE_BUTTONS])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_10 [CASE_BUTTONS]) // ВЫХОД 1 ВХОД i 
	     OPEN_SOURSE_VIDEO (CASE_PANEL, CASE_BUTTONS, CASE_HDMI_ZONE)
	            }
             }
      CASE 17: //  ИСТОЧНИК TV
             { 
             IF (STATUS_SOURSE[CASE_ZONE] = 'OFF')
	     {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (5) PULSE[IR, 1] (*ON TV*) WAIT TIME_ON_TV_80 { SET_PULSE_TIME (3) PULSE[IR, 7] } (*HDMI 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_10 [33]) // ВЫХОД 1 ВХОД i 
	     } ELSE {
	     STATUS_SOURSE[CASE_ZONE] = "'S',FORMAT('%02d',CASE_BUTTONS)"
	     SET_PULSE_TIME (3) PULSE[IR, 7]   (*TV 1 TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_10 [33]) // ВЫХОД 1 ВХОД i 
	            }
             }
      CASE 20: //  Выключить
             { 
	     STATUS_SOURSE[CASE_ZONE] = 'OFF'
	     SET_PULSE_TIME (5) PULSE[IR, 37] (*OFF TV*)
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_HDMI_KRAMER[CASE_HDMI_ZONE][17])      // ВЫХОД 1 ВХОД i 
	     DO_PUSH(dvPanelAllZone[1],KEYPAD_AUDIO_MAKROS_10 [33]) // ВЫХОД 1 ВХОД i 
	     
             }
      }
      }
}

///////// Скорость порту крамер PL50
DATA_EVENT [KRAMER_SP50]
{
ONLINE:{WAIT 50 {SEND_COMMAND KRAMER_SP50,'SET BAUD 115200,N,8,1' }}
} 



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

Wait 1
{

(************************ Zone1 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_1[1]]  =  (STATUS_SOURSE [1] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_1[2]]  =  (STATUS_SOURSE [1] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_1[3]]  =  (STATUS_SOURSE [1] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_1[4]]  =  (STATUS_SOURSE [1] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_1[5]]  =  (STATUS_SOURSE [1] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_1[6]]  =  (STATUS_SOURSE [1] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_1[7]]  =  (STATUS_SOURSE [1] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_1[8]]  =  (STATUS_SOURSE [1] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_1[17]] =  (STATUS_SOURSE [1] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_1[20]] =  (STATUS_SOURSE [1] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_1[19]] =  (STATUS_SOURSE [1] = 'S01' || STATUS_SOURSE [1] = 'S02' || STATUS_SOURSE [1] = 'S03' || STATUS_SOURSE [1] = 'S04' || STATUS_SOURSE [1] = 'S05')

(************************ Zone2 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_2[1]]  =  (STATUS_SOURSE [2] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_2[2]]  =  (STATUS_SOURSE [2] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_2[3]]  =  (STATUS_SOURSE [2] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_2[4]]  =  (STATUS_SOURSE [2] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_2[5]]  =  (STATUS_SOURSE [2] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_2[6]]  =  (STATUS_SOURSE [2] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_2[7]]  =  (STATUS_SOURSE [2] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_2[8]]  =  (STATUS_SOURSE [2] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_2[17]] =  (STATUS_SOURSE [2] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_2[20]] =  (STATUS_SOURSE [2] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_2[19]] =  (STATUS_SOURSE [2] = 'S01' || STATUS_SOURSE [2] = 'S02' || STATUS_SOURSE [2] = 'S03' || STATUS_SOURSE [2] = 'S04' || STATUS_SOURSE [2] = 'S05')
                                                   
(************************ Zone3 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_3[1]]  =  (STATUS_SOURSE [3] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_3[2]]  =  (STATUS_SOURSE [3] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_3[3]]  =  (STATUS_SOURSE [3] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_3[4]]  =  (STATUS_SOURSE [3] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_3[5]]  =  (STATUS_SOURSE [3] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_3[6]]  =  (STATUS_SOURSE [3] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_3[7]]  =  (STATUS_SOURSE [3] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_3[8]]  =  (STATUS_SOURSE [3] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_3[16]] =  (STATUS_SOURSE [3] = 'S16')
[dvPanelAllZone, KEYPAD_MAKROS_3[17]] =  (STATUS_SOURSE [3] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_3[20]] =  (STATUS_SOURSE [3] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_3[19]] =  (STATUS_SOURSE [3] = 'S01' || STATUS_SOURSE [3] = 'S02' || STATUS_SOURSE [3] = 'S03' || STATUS_SOURSE [3] = 'S04' || STATUS_SOURSE [3] = 'S05')
                                                         
(************************ Zone4 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_4[1]]  =  (STATUS_SOURSE [4] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_4[2]]  =  (STATUS_SOURSE [4] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_4[3]]  =  (STATUS_SOURSE [4] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_4[4]]  =  (STATUS_SOURSE [4] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_4[5]]  =  (STATUS_SOURSE [4] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_4[6]]  =  (STATUS_SOURSE [4] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_4[7]]  =  (STATUS_SOURSE [4] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_4[8]]  =  (STATUS_SOURSE [4] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_4[17]] =  (STATUS_SOURSE [4] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_4[20]] =  (STATUS_SOURSE [4] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_4[19]] =  (STATUS_SOURSE [4] = 'S01' || STATUS_SOURSE [4] = 'S02' || STATUS_SOURSE [4] = 'S03' || STATUS_SOURSE [4] = 'S04' || STATUS_SOURSE [4] = 'S05')
                                                         
(************************ Zone5 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_5[1]]  =  (STATUS_SOURSE [5] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_5[2]]  =  (STATUS_SOURSE [5] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_5[3]]  =  (STATUS_SOURSE [5] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_5[4]]  =  (STATUS_SOURSE [5] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_5[5]]  =  (STATUS_SOURSE [5] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_5[6]]  =  (STATUS_SOURSE [5] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_5[7]]  =  (STATUS_SOURSE [5] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_5[8]]  =  (STATUS_SOURSE [5] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_5[16]] =  (STATUS_SOURSE [5] = 'S16')
[dvPanelAllZone, KEYPAD_MAKROS_5[17]] =  (STATUS_SOURSE [5] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_5[20]] =  (STATUS_SOURSE [5] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_5[19]] =  (STATUS_SOURSE [5] = 'S01' || STATUS_SOURSE [5] = 'S02' || STATUS_SOURSE [5] = 'S03' || STATUS_SOURSE [5] = 'S04' || STATUS_SOURSE [5] = 'S05')
                                                         
(************************ Zone6 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_6[1]]  =  (STATUS_SOURSE [6] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_6[2]]  =  (STATUS_SOURSE [6] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_6[3]]  =  (STATUS_SOURSE [6] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_6[4]]  =  (STATUS_SOURSE [6] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_6[5]]  =  (STATUS_SOURSE [6] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_6[6]]  =  (STATUS_SOURSE [6] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_6[7]]  =  (STATUS_SOURSE [6] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_6[8]]  =  (STATUS_SOURSE [6] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_6[17]] =  (STATUS_SOURSE [6] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_6[20]] =  (STATUS_SOURSE [6] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_6[19]] =  (STATUS_SOURSE [6] = 'S01' || STATUS_SOURSE [6] = 'S02' || STATUS_SOURSE [6] = 'S03' || STATUS_SOURSE [6] = 'S04' || STATUS_SOURSE [6] = 'S05')
                                                         
(************************ Zone7 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_7[1]]  =  (STATUS_SOURSE [7] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_7[2]]  =  (STATUS_SOURSE [7] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_7[3]]  =  (STATUS_SOURSE [7] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_7[4]]  =  (STATUS_SOURSE [7] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_7[5]]  =  (STATUS_SOURSE [7] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_7[6]]  =  (STATUS_SOURSE [7] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_7[7]]  =  (STATUS_SOURSE [7] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_7[8]]  =  (STATUS_SOURSE [7] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_7[16]] =  (STATUS_SOURSE [7] = 'S16')
[dvPanelAllZone, KEYPAD_MAKROS_7[17]] =  (STATUS_SOURSE [7] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_7[20]] =  (STATUS_SOURSE [7] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_7[19]] =  (STATUS_SOURSE [7] = 'S01' || STATUS_SOURSE [7] = 'S02' || STATUS_SOURSE [7] = 'S03' || STATUS_SOURSE [7] = 'S04' || STATUS_SOURSE [7] = 'S05')
                                                         
(************************ Zone8 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_8[1]]  =  (STATUS_SOURSE [8] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_8[2]]  =  (STATUS_SOURSE [8] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_8[3]]  =  (STATUS_SOURSE [8] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_8[4]]  =  (STATUS_SOURSE [8] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_8[5]]  =  (STATUS_SOURSE [8] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_8[6]]  =  (STATUS_SOURSE [8] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_8[7]]  =  (STATUS_SOURSE [8] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_8[8]]  =  (STATUS_SOURSE [8] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_8[16]] =  (STATUS_SOURSE [8] = 'S16')
[dvPanelAllZone, KEYPAD_MAKROS_8[17]] =  (STATUS_SOURSE [8] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_8[20]] =  (STATUS_SOURSE [8] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_8[19]] =  (STATUS_SOURSE [8] = 'S01' || STATUS_SOURSE [8] = 'S02' || STATUS_SOURSE [8] = 'S03' || STATUS_SOURSE [8] = 'S04' || STATUS_SOURSE [8] = 'S05')
                                                         
(************************ Zone9 ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_9[1]]  =  (STATUS_SOURSE [9] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_9[2]]  =  (STATUS_SOURSE [9] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_9[3]]  =  (STATUS_SOURSE [9] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_9[4]]  =  (STATUS_SOURSE [9] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_9[5]]  =  (STATUS_SOURSE [9] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_9[6]]  =  (STATUS_SOURSE [9] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_9[7]]  =  (STATUS_SOURSE [9] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_9[8]]  =  (STATUS_SOURSE [9] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_9[16]] =  (STATUS_SOURSE [9] = 'S16')
[dvPanelAllZone, KEYPAD_MAKROS_9[17]] =  (STATUS_SOURSE [9] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_9[20]] =  (STATUS_SOURSE [9] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_9[19]] =  (STATUS_SOURSE [9] = 'S01' || STATUS_SOURSE [9] = 'S02' || STATUS_SOURSE [9] = 'S03' || STATUS_SOURSE [9] = 'S04' || STATUS_SOURSE [9] = 'S05')
                                                         
(************************ Zone10  ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_10[1]]  =  (STATUS_SOURSE [10] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_10[2]]  =  (STATUS_SOURSE [10] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_10[3]]  =  (STATUS_SOURSE [10] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_10[4]]  =  (STATUS_SOURSE [10] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_10[5]]  =  (STATUS_SOURSE [10] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_10[6]]  =  (STATUS_SOURSE [10] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_10[7]]  =  (STATUS_SOURSE [10] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_10[8]]  =  (STATUS_SOURSE [10] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_10[17]] =  (STATUS_SOURSE [10] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_10[20]] =  (STATUS_SOURSE [10] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_10[19]] =  (STATUS_SOURSE [10] = 'S01' || STATUS_SOURSE [10] = 'S02' || STATUS_SOURSE [10] = 'S03' || STATUS_SOURSE [10] = 'S04' || STATUS_SOURSE [10] = 'S05')
                                                    
(************************ Zone11  ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_11[1]]  =  (STATUS_SOURSE [11] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_11[2]]  =  (STATUS_SOURSE [11] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_11[3]]  =  (STATUS_SOURSE [11] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_11[4]]  =  (STATUS_SOURSE [11] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_11[5]]  =  (STATUS_SOURSE [11] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_11[6]]  =  (STATUS_SOURSE [11] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_11[7]]  =  (STATUS_SOURSE [11] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_11[8]]  =  (STATUS_SOURSE [11] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_11[17]] =  (STATUS_SOURSE [11] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_11[20]] =  (STATUS_SOURSE [11] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_11[19]] =  (STATUS_SOURSE [11] = 'S01' || STATUS_SOURSE [11] = 'S02' || STATUS_SOURSE [11] = 'S03' || STATUS_SOURSE [11] = 'S04' || STATUS_SOURSE [11] = 'S05')
                                                    
(************************ Zone12  ************************************)
[dvPanelAllZone, KEYPAD_MAKROS_12[1]]  =  (STATUS_SOURSE [12] = 'S01')
[dvPanelAllZone, KEYPAD_MAKROS_12[2]]  =  (STATUS_SOURSE [12] = 'S02')
[dvPanelAllZone, KEYPAD_MAKROS_12[3]]  =  (STATUS_SOURSE [12] = 'S03')
[dvPanelAllZone, KEYPAD_MAKROS_12[4]]  =  (STATUS_SOURSE [12] = 'S04')
[dvPanelAllZone, KEYPAD_MAKROS_12[5]]  =  (STATUS_SOURSE [12] = 'S05')
[dvPanelAllZone, KEYPAD_MAKROS_12[6]]  =  (STATUS_SOURSE [12] = 'S06')
[dvPanelAllZone, KEYPAD_MAKROS_12[7]]  =  (STATUS_SOURSE [12] = 'S07')
[dvPanelAllZone, KEYPAD_MAKROS_12[8]]  =  (STATUS_SOURSE [12] = 'S08')
[dvPanelAllZone, KEYPAD_MAKROS_12[17]] =  (STATUS_SOURSE [12] = 'S17')
[dvPanelAllZone, KEYPAD_MAKROS_12[20]] =  (STATUS_SOURSE [12] = 'OFF')
[dvPanelAllZone, KEYPAD_MAKROS_12[19]] =  (STATUS_SOURSE [12] = 'S01' || STATUS_SOURSE [12] = 'S02' || STATUS_SOURSE [12] = 'S03' || STATUS_SOURSE [12] = 'S04' || STATUS_SOURSE [12] = 'S05')
                                                    
[dvCinema, KEYPAD_MAKROS_CINEMA[3]] = (CINEMA_POWER = 'ON')
[dvCinema, KEYPAD_MAKROS_CINEMA[6]] = (CINEMA_SOURSE = 'SAT')
[dvCinema, KEYPAD_MAKROS_CINEMA[7]] = (CINEMA_SOURSE = 'DTV')
[dvCinema, KEYPAD_MAKROS_CINEMA[8]] = (CINEMA_SOURSE = 'BR')
[dvCinema, KEYPAD_MAKROS_CINEMA[9]] = (CINEMA_SOURSE = 'INT')
                               
}
                                                                                                                                                                                                                                                               
///////////////  охранка   
Wait 1
{
[dvAlarmMas, Macros_ALARM [1]] = (ALARM_SOUND = 1)


IF (Partitions_ExitTime_More10secs[1] || Partitions_ExitTime_Less10secs[1] || 
    Partitions_ExitTime_More10secs[2] || Partitions_ExitTime_Less10secs[2] || 
    Partitions_ExitTime_More10secs[3] || Partitions_ExitTime_Less10secs[3] || 
    Partitions_ExitTime_More10secs[4] || Partitions_ExitTime_Less10secs[4] || 
    Partitions_ExitTime_More10secs[5] || Partitions_ExitTime_Less10secs[5] || 
    Partitions_ExitTime_More10secs[6] || Partitions_ExitTime_Less10secs[6] || 
    Partitions_ExitTime_More10secs[7] || Partitions_ExitTime_Less10secs[7] || 
    Partitions_ExitTime_More10secs[8] || Partitions_ExitTime_Less10secs[8] || 
    Partitions_ExitTime_More10secs[9] || Partitions_ExitTime_Less10secs[9] || 
                                                                                       
    Partitions_ExitTime_More10secs[10] || Partitions_ExitTime_Less10secs[10] ||  
    Partitions_ExitTime_More10secs[11] || Partitions_ExitTime_Less10secs[11] || 
    Partitions_ExitTime_More10secs[12] || Partitions_ExitTime_Less10secs[12] || 
    Partitions_ExitTime_More10secs[13] || Partitions_ExitTime_Less10secs[13])
    { if (time_sxxx =! TIME_TO_SECOND(TIME)) {time_sxxx = TIME_TO_SECOND(TIME) SEND_COMMAND dvAlarmMas_Send_,"'ABEEP'" }}
                                                                                                                                                 



[dvAlarmMas, Zone_Save_Pass [1]] = (Partitions_Armed[1]) // постановка 1 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [2]] = (Partitions_Armed[2]) // постановка 2 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [3]] = (Partitions_Armed[3]) // постановка 3 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [4]] = (Partitions_Armed[4]) // постановка 4 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [5]] = (Partitions_Armed[5]) // постановка 5 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [6]] = (Partitions_Armed[6]) // постановка 6 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [7]] = (Partitions_Armed[7]) // постановка 7 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [8]] = (Partitions_Armed[8]) // постановка 8 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [9]] = (Partitions_Armed[9]) // постановка 9 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [10]] = (Partitions_Armed[10]) // постановка 10 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [11]] = (Partitions_Armed[11]) // постановка 11 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [12]] = (Partitions_Armed[12]) // постановка 12 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [13]] = (Partitions_Armed[13]) // постановка 13 группы на сигнализацию
                                                           
[dvAlarmMas, Zone_Save_Pass [15]] = (Partitions_Armed[1] && 
                    Partitions_Armed[2] && 
		    Partitions_Armed[3] && 
                    Partitions_Armed[4] && 
		    Partitions_Armed[5] && 
                    Partitions_Armed[6] && 
		    Partitions_Armed[7] && 
                    Partitions_Armed[8] && 
		    Partitions_Armed[9] && 
                    Partitions_Armed[10] && 
		    Partitions_Armed[11] && 
                    Partitions_Armed[12] && 
		    Partitions_Armed[13]) // постановка 13 груп на сигнализацию

[dvAlarmMas, Zone_Save_Pass [21]] =! (Partitions_Armed[1]) // постановка 1 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [22]] =! (Partitions_Armed[2]) // постановка 2 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [23]] =! (Partitions_Armed[3]) // постановка 3 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [24]] =! (Partitions_Armed[4]) // постановка 4 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [25]] =! (Partitions_Armed[5]) // постановка 5 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [26]] =! (Partitions_Armed[6]) // постановка 6 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [27]] =! (Partitions_Armed[7]) // постановка 7 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [28]] =! (Partitions_Armed[8]) // постановка 8 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [29]] =! (Partitions_Armed[9]) // постановка 9 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [30]] =! (Partitions_Armed[10]) // постановка 10 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [31]] =! (Partitions_Armed[11]) // постановка 11 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [32]] =! (Partitions_Armed[12]) // постановка 12 группы на сигнализацию
[dvAlarmMas, Zone_Save_Pass [33]] =! (Partitions_Armed[13]) // постановка 13 группы на сигнализацию
                                                           
[dvAlarmMas, Zone_Save_Pass [35]] =! (Partitions_Armed[1] && 
                    Partitions_Armed[2] && 
		    Partitions_Armed[3] && 
                    Partitions_Armed[4] && 
		    Partitions_Armed[5] && 
                    Partitions_Armed[6] && 
		    Partitions_Armed[7] && 
                    Partitions_Armed[8] && 
		    Partitions_Armed[9] && 
                    Partitions_Armed[10] && 
		    Partitions_Armed[11] && 
                    Partitions_Armed[12] && 
		    Partitions_Armed[13]) // постановка 13 груп на сигнализацию


[dvAlarmMas, Zone_Save_Alarm [1]] = (Partitions_Alarm[1])   // сработка 1 группы
[dvAlarmMas, Zone_Save_Alarm [2]] = (Partitions_Alarm[2])   // сработка 2 группы
[dvAlarmMas, Zone_Save_Alarm [3]] = (Partitions_Alarm[3])   // сработка 3 группы
[dvAlarmMas, Zone_Save_Alarm [4]] = (Partitions_Alarm[4])   // сработка 4 группы
[dvAlarmMas, Zone_Save_Alarm [5]] = (Partitions_Alarm[5])   // сработка 5 группы
[dvAlarmMas, Zone_Save_Alarm [6]] = (Partitions_Alarm[6])   // сработка 6 группы
[dvAlarmMas, Zone_Save_Alarm [7]] = (Partitions_Alarm[7])   // сработка 7 группы
[dvAlarmMas, Zone_Save_Alarm [8]] = (Partitions_Alarm[8])   // сработка 8 группы
[dvAlarmMas, Zone_Save_Alarm [9]] = (Partitions_Alarm[9])   // сработка 9 группы
[dvAlarmMas, Zone_Save_Alarm [10]] = (Partitions_Alarm[10]) // сработка 10 группы
[dvAlarmMas, Zone_Save_Alarm [11]] = (Partitions_Alarm[11]) // сработка 11 группы
[dvAlarmMas, Zone_Save_Alarm [12]] = (Partitions_Alarm[12]) // сработка 12 группы
[dvAlarmMas, Zone_Save_Alarm [13]] = (Partitions_Alarm[13]) // сработка 13 группы
[dvAlarmMas, Zone_Save_Alarm [14]] = (Partitions_Alarm[14]) // сработка пожарки
                                                                   
[dvAlarmMas, Zone_Save_Alarm [15]] = (Partitions_Alarm[1] || 
				      Partitions_Alarm[2] ||  
                                      Partitions_Alarm[3] ||  
                                      Partitions_Alarm[4] ||  
                                      Partitions_Alarm[5] ||  
                                      Partitions_Alarm[6] ||  
                                      Partitions_Alarm[7] ||  
                                      Partitions_Alarm[8] ||  
                                      Partitions_Alarm[9] ||  
                                      Partitions_Alarm[10] || 
                                      Partitions_Alarm[11] || 
                                      Partitions_Alarm[12] || 
                                      Partitions_Alarm[13]) // сработка в доме                                      
}       



WAIT 50 { IF ([dvAlarmMas, Zone_Save_Alarm [15]]) {SEND_COMMAND dvAlarmMas_Send_, "'@PPN-[Main]_Alarm'"  IF (ALARM_SOUND = 0) { SEND_COMMAND dvAlarmMas_Send_,"'@SOU-Alarm.mp3'"}}}



                                                   
Wait 1
{

[dvAlarmMas, Zone_channel[1]] = (Zones_Violation[1]) 
[dvAlarmMas, Zone_channel[2]] = (Zones_Violation[2]) 
[dvAlarmMas, Zone_channel[3]] = (Zones_Violation[3]) 
[dvAlarmMas, Zone_channel[4]] = (Zones_Violation[4]) 
[dvAlarmMas, Zone_channel[5]] = (Zones_Violation[5]) 
[dvAlarmMas, Zone_channel[6]] = (Zones_Violation[6]) 
[dvAlarmMas, Zone_channel[7]] = (Zones_Violation[7]) 
[dvAlarmMas, Zone_channel[8]] = (Zones_Violation[8]) 
[dvAlarmMas, Zone_channel[9]] = (Zones_Violation[9]) 
[dvAlarmMas, Zone_channel[10]] = (Zones_Violation[10]) 
[dvAlarmMas, Zone_channel[11]] = (Zones_Violation[11]) 
[dvAlarmMas, Zone_channel[12]] = (Zones_Violation[12]) 
[dvAlarmMas, Zone_channel[13]] = (Zones_Violation[13]) 
[dvAlarmMas, Zone_channel[14]] = (Zones_Violation[14]) 
[dvAlarmMas, Zone_channel[15]] = (Zones_Violation[15]) 
[dvAlarmMas, Zone_channel[16]] = (Zones_Violation[16]) 
[dvAlarmMas, Zone_channel[17]] = (Zones_Violation[17]) 
[dvAlarmMas, Zone_channel[18]] = (Zones_Violation[18]) 
[dvAlarmMas, Zone_channel[19]] = (Zones_Violation[19]) 
[dvAlarmMas, Zone_channel[20]] = (Zones_Violation[20]) 
[dvAlarmMas, Zone_channel[21]] = (Zones_Violation[21]) 
[dvAlarmMas, Zone_channel[22]] = (Zones_Violation[22]) 
[dvAlarmMas, Zone_channel[23]] = (Zones_Violation[23]) 
[dvAlarmMas, Zone_channel[24]] = (Zones_Violation[24]) 
[dvAlarmMas, Zone_channel[25]] = (Zones_Violation[25]) 
[dvAlarmMas, Zone_channel[26]] = (Zones_Violation[26]) 
[dvAlarmMas, Zone_channel[27]] = (Zones_Violation[27]) 
[dvAlarmMas, Zone_channel[28]] = (Zones_Violation[28]) 
[dvAlarmMas, Zone_channel[29]] = (Zones_Violation[29]) 
[dvAlarmMas, Zone_channel[30]] = (Zones_Violation[30]) 
[dvAlarmMas, Zone_channel[31]] = (Zones_Violation[31]) 
[dvAlarmMas, Zone_channel[32]] = (Zones_Violation[32]) 
[dvAlarmMas, Zone_channel[33]] = (Zones_Violation[33]) 
[dvAlarmMas, Zone_channel[34]] = (Zones_Violation[34]) 
[dvAlarmMas, Zone_channel[35]] = (Zones_Violation[35]) 
[dvAlarmMas, Zone_channel[36]] = (Zones_Violation[36]) 
[dvAlarmMas, Zone_channel[37]] = (Zones_Violation[37]) 
[dvAlarmMas, Zone_channel[38]] = (Zones_Violation[38]) 
[dvAlarmMas, Zone_channel[39]] = (Zones_Violation[39]) 
[dvAlarmMas, Zone_channel[40]] = (Zones_Violation[40]) 
[dvAlarmMas, Zone_channel[41]] = (Zones_Violation[41]) 
[dvAlarmMas, Zone_channel[42]] = (Zones_Violation[42]) 
[dvAlarmMas, Zone_channel[43]] = (Zones_Violation[43]) 
[dvAlarmMas, Zone_channel[44]] = (Zones_Violation[44]) 
[dvAlarmMas, Zone_channel[45]] = (Zones_Violation[45]) 
[dvAlarmMas, Zone_channel[46]] = (Zones_Violation[46]) 
[dvAlarmMas, Zone_channel[47]] = (Zones_Violation[47]) 
                                                   
}
  
Wait 1
{

[dvAlarmMas, Zone_channel_ALARM[1]] = (Zones_Alarm[1]) 
[dvAlarmMas, Zone_channel_ALARM[2]] = (Zones_Alarm[2]) 
[dvAlarmMas, Zone_channel_ALARM[3]] = (Zones_Alarm[3]) 
[dvAlarmMas, Zone_channel_ALARM[4]] = (Zones_Alarm[4]) 
[dvAlarmMas, Zone_channel_ALARM[5]] = (Zones_Alarm[5]) 
[dvAlarmMas, Zone_channel_ALARM[6]] = (Zones_Alarm[6]) 
[dvAlarmMas, Zone_channel_ALARM[7]] = (Zones_Alarm[7]) 
[dvAlarmMas, Zone_channel_ALARM[8]] = (Zones_Alarm[8]) 
[dvAlarmMas, Zone_channel_ALARM[9]] = (Zones_Alarm[9]) 
[dvAlarmMas, Zone_channel_ALARM[10]] = (Zones_Alarm[10]) 
[dvAlarmMas, Zone_channel_ALARM[11]] = (Zones_Alarm[11]) 
[dvAlarmMas, Zone_channel_ALARM[12]] = (Zones_Alarm[12]) 
[dvAlarmMas, Zone_channel_ALARM[13]] = (Zones_Alarm[13]) 
[dvAlarmMas, Zone_channel_ALARM[14]] = (Zones_Alarm[14]) 
[dvAlarmMas, Zone_channel_ALARM[15]] = (Zones_Alarm[15]) 
[dvAlarmMas, Zone_channel_ALARM[16]] = (Zones_Alarm[16]) 
[dvAlarmMas, Zone_channel_ALARM[17]] = (Zones_Alarm[17]) 
[dvAlarmMas, Zone_channel_ALARM[18]] = (Zones_Alarm[18]) 
[dvAlarmMas, Zone_channel_ALARM[19]] = (Zones_Alarm[19]) 
[dvAlarmMas, Zone_channel_ALARM[20]] = (Zones_Alarm[20]) 
[dvAlarmMas, Zone_channel_ALARM[21]] = (Zones_Alarm[21]) 
[dvAlarmMas, Zone_channel_ALARM[22]] = (Zones_Alarm[22]) 
[dvAlarmMas, Zone_channel_ALARM[23]] = (Zones_Alarm[23]) 
[dvAlarmMas, Zone_channel_ALARM[24]] = (Zones_Alarm[24]) 
[dvAlarmMas, Zone_channel_ALARM[25]] = (Zones_Alarm[25]) 
[dvAlarmMas, Zone_channel_ALARM[26]] = (Zones_Alarm[26]) 
[dvAlarmMas, Zone_channel_ALARM[27]] = (Zones_Alarm[27]) 
[dvAlarmMas, Zone_channel_ALARM[28]] = (Zones_Alarm[28]) 
[dvAlarmMas, Zone_channel_ALARM[29]] = (Zones_Alarm[29]) 
[dvAlarmMas, Zone_channel_ALARM[30]] = (Zones_Alarm[30]) 
[dvAlarmMas, Zone_channel_ALARM[31]] = (Zones_Alarm[31]) 
[dvAlarmMas, Zone_channel_ALARM[32]] = (Zones_Alarm[32]) 
[dvAlarmMas, Zone_channel_ALARM[33]] = (Zones_Alarm[33]) 
[dvAlarmMas, Zone_channel_ALARM[34]] = (Zones_Alarm[34]) 
[dvAlarmMas, Zone_channel_ALARM[35]] = (Zones_Alarm[35]) 
[dvAlarmMas, Zone_channel_ALARM[36]] = (Zones_Alarm[36]) 
[dvAlarmMas, Zone_channel_ALARM[37]] = (Zones_Alarm[37]) 
[dvAlarmMas, Zone_channel_ALARM[38]] = (Zones_Alarm[38]) 
[dvAlarmMas, Zone_channel_ALARM[39]] = (Zones_Alarm[39]) 
[dvAlarmMas, Zone_channel_ALARM[40]] = (Zones_Alarm[40]) 
[dvAlarmMas, Zone_channel_ALARM[41]] = (Zones_Alarm[41]) 
[dvAlarmMas, Zone_channel_ALARM[42]] = (Zones_Alarm[42]) 
[dvAlarmMas, Zone_channel_ALARM[43]] = (Zones_Alarm[43]) 
[dvAlarmMas, Zone_channel_ALARM[44]] = (Zones_Alarm[44]) 
[dvAlarmMas, Zone_channel_ALARM[45]] = (Zones_Alarm[45]) 
[dvAlarmMas, Zone_channel_ALARM[46]] = (Zones_Alarm[46]) 
[dvAlarmMas, Zone_channel_ALARM[47]] = (Zones_Alarm[47]) 
                                                   
}
   
   
