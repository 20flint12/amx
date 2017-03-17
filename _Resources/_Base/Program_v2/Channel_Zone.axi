PROGRAM_NAME='Channel_Zone'


DEFINE_VARIABLE

// Harman AV
VOLATILE INTEGER KEYPAD_HARMAN_AV [] = 

{
	1, // On
	2, // Off
	3, // aux
	4  // digital
}        

// SAMSUNG TV
INTEGER KEYPAD_SAMSUNG []  = // 

{ 
101,   // Power On
102,   // HDMI 1
103,   // HDMI 2
104,   // HDMI 3
105,   // HDMI 4
106,   // Component
107,   // Plasma TV/DTV
108,   // Plasma 1
109,   // Plasma 2
110,   // Plasma 3
111,   // Plasma 4
112,   // Plasma 5
113,   // Plasma 6
114,   // Plasma 7
115,   // Plasma 8
116,   // Plasma 9
117,   // Plasma 0
118,   // CH List
119,   // Plasma HalfScreen
120,   // Plasma CH+
121,   // Plasma CH-
122,   // Plasma Mute
123,   // Plasma Vol+
124,   // Plasma Vol-
125,   // Plasma Return
126,   // Plasma HomeMenu
127,   // Plasma Exit
128,   // SMART
129,   // Plasma UP
130,   // Plasma DOWN
131,   // Plasma LEFT
132,   // Plasma RIGHT
133,   // Plasma Enter
134,   // Plasma Info
135,   // Plasma aspect
136,   // INPUT
137,   // Plasma Off
138,   // <<
139,   // >>
140,   // Stop
141,   // Play
142,   // Rec
143,   // Pause
144,   // 3D
145,   // Internet/TV
146,   // MediaP              
147,   // Vid1
148,   // Vid2
149,   // Vid3
150    //      
}        


// Спутник
INTEGER KEYPAD_OPENBOX []  = 

{
201,     // power
202,     // mute
203,     // 1
204,     // 2
205,     // 3
206,     // 4
207,     // 5
208,     // 6
209,     // 7
210,    // 8      
211,    // 9
212,    // 0
213,    // Back
214,    // Info
215,    // Menu
216,    // Exit
217,    // FAV
218,    // EPG
219,    // CH+
220,    // CH-
221,    // VOL+      
222,    // VOL-
223,    // Ok
224,    // Play List
225,    // Green
226,    // Yellow TXT
227,    // Blue
228,    // Red
229,    // ^
230,    // <      
231,    // >
232,    // v
233,    // VFormat
234,    // Sleep
235,    // TP/Rad
236,    // Resolution
237,    // Page UP
238,    // Page DOWN
239,    // Subtitle
240,    // Teletext
241,    // <<      
242,    // >>
243,    // Play
244,    // Pause
245,    // Stop
246,    // Rec
247,    // |<
248,    // >|
249     // Select
}	

INTEGER KEYPAD_OPENBOX_MACRO []  = 

{
271,     // List +
272,     // List -
273,     // 
274,     // 
275      // 
}



// DTV
INTEGER KEYPAD_STRONG_DTV []  = 

{
301,    // power
302,    // Mute
303,    // 1
304,    // 2
305,    // 3
306,    // 4
307,    // 5
308,    // 6
309,    // 7
310,    // 8 
311,    // 9
312,    // 0
313,    // tv/radio
314,    // AV
315,    // menu
316,    // Info
317,    // exit
318,    // epg
319,    // ^
320,    // v
321,    // <    
322,    // >
323,    // Ok
324,    // Red
325,    // Green
326,    // Yellow 
327,    // Blue
328,    // FAV
329,    // AUDIO
330,    // ZOOM 
331,    // VOL+
332,    // VOL-
333,    // CHAN+
334,    // CHAN-
335,    // PAUSE
336,    // PLAY
337,    // STOP
338,    // <<
339,    // >>
340,    // <|
341,    // |>  
342    // REC            
}	


// AppleTV
VOLATILE INTEGER KEYPAD_APPLETV [] = 

{
	401, // MENU               = 101
	402, // FORWARD            = 102
	403, // UP                 = 103
	404, // v                  = 104
	405, // REVERSE            = 105
	406, // FORWARD            = 106
	407  // OK                 = 107
}        

// LG TV
INTEGER KEYPAD_LG []  = // 

{ 
501,   // ON
502,   // OFF
503,   // HDMI 1
504,   // HDMI 2
505,   // TV
506,   // Power
507,   // TV/RAD
508,   // INPUT
509,   // RATIO
510,   // SUBTITLE
511,   // 1
512,   // 2
513,   // 3
514,   // 4
515,   // 5
516,   // 6
517,   // 7
518,   // 8
519,   // 9
520,   // 0
521,   // LIST
522,   // Q.VIEW
523,   // FAV
524,   // GUIDE
525,   // PAGE +
526,   // PAGE -
527,   // VOL +
528,   // VOL -
529,   // MUTE
530,   // INFO
531,   // SETTINGS
532,   // MY APPS
533,   // SMART
534,   // BACK
535,   // EXIT
536,   // ^
537,   // V
538,   // <
539,   // >
540,   // ok
541,   // RED
542,   // GREEN
543,   // YELLOW
544,   // BLUE
545,   // TEXT
546,   // T.OPT
547,   // Q.MENU
548,   // STOP
549,   // PLAY
550,   // PAUSE
551,   // <<
552,   // >>
553,   // REC
554,   // SLEEP
555,   // AD
556    // App                               
}        


// BENK TV
INTEGER KEYPAD_BENK []  = // 

{ 
601,   // PowerOff
602,   // bang radio
603,   // bang cd
604,   // bang tv
605,   // bang light
606,   // bang dtv
607,   // bang dvd
608,   // bang v.mem
609,   // bang a.mem
610,   // bang 0
611,   // bang 1
612,   // bang 2
613,   // bang 3
614,   // bang 4
615,   // bang 5
616,   // bang 6
617,   // bang 7
618,   // bang 8
619,   // bang 9
620,   // bang gr
621,   // bang yl
622,   // bang rd
623,   // bang bl
624,   // bang up
625,   // bang down
626,   // bang left
627,   // bang right
628,   // bang list
629,   // bang stop
630,   // bang exit
631,   // bang vol +
632,   // bang vol -
633,   // bang go
634    // bang menu    
}        


// SONY TV
INTEGER KEYPAD_SONY []  = // 

{ 
701,   // Power
702,   // Select_Input
703,   // 1
704,   // 2
705,   // 3
706,   // 4
707,   // 5
708,   // 6
709,   // 7
710,   // 8
711,   // 9
712,   // 0
713,   // 3d
714,   // Vol+
715,   // Vol-
716,   // Prog+
717,   // Prog-
718,   // mute
719,   // Pover_on
720,   // Power_off
721,   // TV
722,   // Zoom
723,   // Theatre
724,   // Analog Digital
725,   // Analog
726,   // Scene
727,   // audio
728,   // HDMI1
729,   // HDMI2
730,   // HDMI3
731,   // HDMI4
732,   // guide
733,   // sen
734,   // exit
735,   // Green
736,   // Yellow
737,   // Red
738,   // Blue
739,   // info
740,   // Widgets
741,   // sync menu
742,   // Store Mode
743,   // Return
744,   // Options
745,   // Home
746,   // Up            
747,   // Down
748,   // Left
749,   // Right
750,   // Ok
751,   // Sony Play
752,   // Sony Pause
753,   // Sony Stop
754,   // Sony |<<
755,   // Sony >>|            
756,   // Sony <<
757    // Sony >>               
}        

// PANASONIC TV
INTEGER KEYPAD_PANASONIC []  = // 

{ 
801,   // On
802,   // Off
803,   // Component 1
804,   // Component 2
805,   // HDMI 1
806,   // HDMI 2
807,   // HDMI 3
808,   // Video 1
809,   // Video 2
810,   // Video 3
811,   // VGA
812,   // TV
813,   // Aspect
814,   // SC/HC
815,   // VIERA/CAST
816,   // Info
817,   // Menu
818,   // Exit
819,   // ^
820,   // v
821,   // <
822,   // >
823,   // Ok
824,   // Return
825,   // Option
826,   // Guide
827,   // VIERA tools
828,   // VIERA link
829,   // Return Ch
830,   // 0
831,   // 1
832,   // 2
833,   // 3
834,   // 4
835,   // 5
836,   // 6
837,   // 7
838,   // 8
839,   // 9
840,   // Mute
841,   // Vol +
842,   // Vol -
843,   // Ch +
844,   // Ch -
845,   // Red
846,   // Green
847,   // Yellow
848,   // Blue
849,   // TEXT
850,   // STTL
851,   // INDEX
852,   // HOLD
853,   // Programme ^
854    // Programme v     
}        


// PIONEER TV
INTEGER KEYPAD_PIONEER_TV []  = // 

{ 
901,   // Plasma Power
902,   // Plasma Input 1
903,   // Plasma Input 2
904,   // Plasma Input 3
905,   // Plasma Input 4
906,   // Plasma Input 5
907,   // Plasma TV/DTV
908,   // Plasma 1
909,   // Plasma 2
910,   // Plasma 3
911,   // Plasma 4
912,   // Plasma 5
913,   // Plasma 6
914,   // Plasma 7
915,   // Plasma 8
916,   // Plasma 9
917,   // Plasma 0
918,   // Plasma PC
919,   // Plasma HalfScreen
920,   // Plasma CH+
921,   // Plasma CH-
922,   // Plasma Mute
923,   // Plasma Vol+
924,   // Plasma Vol-
925,   // Plasma Return
926,   // Plasma HomeMenu
927,   // Plasma Exit
928,   // Plasma EPG
929,   // Plasma UP
930,   // Plasma DOWN
931,   // Plasma LEFT
932,   // Plasma RIGHT
933,   // Plasma Enter
934,   // Plasma Info
935,   // Plasma aspect
936,   // Plasma On
937    // Plasma Off            
}        

// DVD_NAD S570
INTEGER KEYPAD_DVD_NAD []  = // 

{ 
1001,   // ON
1002,   // OFF
1003,   // OpenClose
1004,   // AUDIO
1005,   // SUBTITLE
1006,   // ANGLE
1007,   // REPEAT
1008,   // RPT A-B
1009,   // RANDOM
1010,   // MENU
1011,   // RETURN
1012,   // DIMMER
1013,   // ZOOM
1014,   // DIPLAY
1015,   // TITLE
1016,   // ^
1017,   // v
1018,   // <
1019,   // >
1020,   // Enter
1021,   // 1
1022,   // 2
1023,   // 3
1024,   // 4
1025,   // 5
1026,   // 6
1027,   // 7
1028,   // 8
1029,   // 9
1030,   // 0
1031,   // Play
1032,   // <<
1033,   // >>
1034,   // |<<
1035,   // >>|
1036,   // Pause
1037,   // Stop
1038,   // SETUP
1039,   // PROGRAM
1040,   // CLEAR
1041,   // MARKER
1042    // SEARCH     
}        

// NAD S170I
INTEGER KEYPAD_AVR_NAD []  = // 

{ 
1101,   // On
1102,   // Off
1103,   // VOL+
1104,   // VOL-
1105,   // MUTE
1106,   // SPEAKER A
1107,   // SPEAKER B
1108,   // DVD
1109,   // SAT
1110,   // VIDEO 4
1111,   // VIDEO 5
1112,   // THX
1113,   // TONE
1114,   // L.NITE
1115,   // SURR +
1116,   // SURR -
1117,   // CENTER +
1118,   // CENTER -
1119,   // SUR +
1120,   // SUR -        
1121    // TUNER        
}        

// DVD_PIONEER
INTEGER KEYPAD_DVD_PIONEER []  = // 

{ 
1201,   // Power
1202,   // DVD/USB
1203,   // OpenClose
1204,   // AUDIO
1205,   // SUBTITLE
1206,   // ANGLE
1207,   // CLEAR
1208,   // MENU
1209,   // TOP MENU
1210,   // HOME MENU
1211,   // RETURN
1212,   // DISPLAY
1213,   // ZOOM
1214,   // PLAY MODE
1215,   // REC/USB
1216,   // ^
1217,   // v
1218,   // <
1219,   // >
1220,   // Enter
1221,   // 1
1222,   // 2
1223,   // 3
1224,   // 4
1225,   // 5
1226,   // 6
1227,   // 7
1228,   // 8
1229,   // 9
1230,   // 0
1231,   // Play
1232,   // <<
1233,   // >>
1234,   // |<<
1235,   // >>|
1236,   // Pause
1237,   // Stop      
1238,   // 
1239,   // 
1240    // 
}  
      
// AVR_PIONEER
INTEGER KEYPAD_AVR_PIONEER []  = // 

{ 
1301,   // POWER
1302,   // INPUT 1
1303,   // INPUT 2
1304,   // INPUT 3
1305,   // INPUT 4
1306,   // VOL +
1307,   // VOL -
1308,   // MUTE
1309,   // MENU
1310,   // ^
1311,   // v
1312,   // <
1313,   // >
1314,   // ENTER
1315,   // RETURN         
1316,   // ON Plasm         
1317    // Off Plasm         
}

// CD_PANASONIC
INTEGER KEYPAD_CD_PANASONIC []  = // 

{ 
1401,   // Power
1402,   // sleep AUTO_OFF
1403,   // CLOCK\TIMER
1404,   // PLAY/REC
1405,   // TITLE IN
1406,   // DISPLAY
1407,   // DIMMER
1408,   // DISC
1409,   // PROGRAM
1410,   // PLAY MODE
1411,   // REPEAT
1412,   // DEL
1413,   // ALBUM<
1414,   // ALBUM>
1415,   // AUX
1416,   // ^
1417,   // v
1418,   // <
1419,   // >
1420,   // Enter
1421,   // 1
1422,   // 2
1423,   // 3
1424,   // 4
1425,   // 5
1426,   // 6
1427,   // 7
1428,   // 8
1429,   // 9
1430,   // 0
1431,   // PlayLIST
1432,   // TAPE<>
1433,   // PLAY/PAUSE CD
1434,   // |<<
1435,   // >>|
1436,   // TUNER/BAUD
1437,   // Stop
1438,   // RETURN
1439,   // +10
1440,   // REMASTER
1441,   // INTRO
1442,   // MARKER
1443,   // TITLE SEARCH
1444,   // S. SOUND EQ
1445,   // SOUND
1446,   // SURROUND
1447    // MUTING                 
}  

// TV JVC
INTEGER KEYPAD_TV_JVC []  = // 

{ 
1501,   // Power
1502,   // TV/VIDEO
1503,   // 1
1504,   // 2
1505,   // 3
1506,   // 4
1507,   // 5
1508,   // 6
1509,   // 7
1510,   // 8
1511,   // 9
1512,   // 0
1513,   // text
1514,   // Vol+
1515,   // Vol-
1516,   // Prog+
1517,   // Prog-
1518,   // mute
1519,   // return
1520,   // menu
1521,   // DISPLAY
1522,   // BACK
1523,   // RED
1524,   // GREEN
1525,   // YELLOW
1526,   // BLUE
1527,   // ^
1528,   // v
1529,   // <
1530,   // >
1531,   // OK
1532,   // Power ON
1533,   // Power OFF
1534,   // Video 1
1535,   // Video 2
1536    // Video 3        
}  

// RADIO FM
INTEGER KEYPAD_FM_NAD []  = // 

{ 
1501,   // MONO
1502,   // BLEND
1503,   // ANTENNA
1504,   // IF
1505,   // DISPLAY
1506,   // PRESET
1507,   // <TUNE
1508    // TUNE>    
}


VOLATILE INTEGER KEYPAD_TUNER [][]= 
{
{           // TUNER 1
	
	2001,  // TUNE (обратка текста станции на первом тюнере)
	2002,  // TUNE 
	2003,  // TUNE 
	2004,  // TUNE 
	2005,  // TUNE 
	2006,  // TUNE 
	2007,  // TUNE 
	2008,  // TUNE 
	2009,  // TUNE 
	2010,  // TUNE 
	2011,  // TUNE 
	2012,  // TUNE 
	2013,  // TUNE 
	2014,  // TUNE 
	2015,  // TUNE 
	2016,  // TUNE 
	2017,  // TUNE 
	2018,  // TUNE 
	2019,  // TUNE 
	2020,  // TUNE 
	2021,  // TUNE 
	2022,  // TUNE 
	2023,  // TUNE 
	2024,  // TUNE 
	2025,  // TUNE 
	2026,  // TUNE 
	2027,  // TUNE 
	2028,  // TUNE 
	2029,  // TUNE 
	2030,  // TUNE 
	2031,  // Preset UP
	2032,  // Preset DOWN
	2033   // Status
        
},
{           // TUNER 2
	
	2101,  // TUNE 1  Ретро FM(обратка текста станции на первом тюнере)
	2102,  // TUNE 2  Европа +
	2103,  // TUNE 3  Бизнес Рад
	2104,  // TUNE 4  Радио Конт
	2105,  // TUNE 5  L’Radio
	2106,  // TUNE 6  Jam FM
	2107,  // TUNE 7  Радио Эра 
	2108,  // TUNE 8  Хит FM
	2109,  // TUNE 9  DJ FM
	2110,  // TUNE 10 Радио Киев
	2111,  // TUNE 11 Русское Ра
	2112,  // TUNE 12 Nostalgie
	2113,  // TUNE 13 Radio One
	2114,  // TUNE 14 Gala FM
	2115,  // TUNE 15 Народное Р
	2116,  // TUNE 16 Радио Мело
	2117,  // TUNE 17 Music Radi
	2118,  // TUNE 18 Радио Шанс
	2119,  // TUNE 19 Просто Рад
	2120,  // TUNE 20 Люкс FM
	2121,  // TUNE 21 Радио Рокс
	2122,  // TUNE 22 Радио Шарм
	2123,  // TUNE 23 NRG
	2124,  // TUNE 24 Радио Пром
	2125,  // TUNE 25 Перец FM
	2126,  // TUNE 26 Душевное Р
	2127,  // TUNE 27 Kiss FM
	2128,  // TUNE 28 Европа FM
	2129,  // TUNE 29 Авто Радио
	2130,  // TUNE 30 Наше Радио
	2131,  // TUNE UP
	2132,  // Preset DOWN
	2133   // Status
        
}
}
Char MasFMRadioKiev [30] [8] = 
{
'92.4',  //1  Ретро FM               92,4 	Ретро FM 		
'92.8',  //2  Европа +               92,8 	Europa Plus Украина 	
'93.8',  //3  Бизнес Радио           93,8 	Бизнес Радио 	
'94.2',  //4  Радио Континент        94,2 	Радио Ренессанс 	
'95.2',  //5  L’Radio                95,2 	Радио Мелодия 	
'95.6',  //6  Jam FM                 95,6 	Джем FM 	
'96.0',  //7  Радио Эра FM           96,0 	Радио Эра 	
'96.4',  //8  Хит FM                 96,4 	Хит FM 	
'96.8',  //9  DJ FM                  96,8 	DJ FM 	
'98.0',  //10 Радио Киев             98,0 	Радио Киев 	
'98.5',  //11 Русское Радио          98,5 	Русское Радио — Украина 
'99.0',  //12 Nostalgie              99,0 	Радио Nostalgie 	
'99.4',  //13 Radio One              99,4 	Lounge FM 	
'100.0', //14 Gala FM                100,0 	GALA радио 	
'100.5', //15 Народное Радио         100,5 	Народное радио 	
'101.1', //16 Радио Мелодия          101,1 	Суперрадио 	
'101.5', //17 Music Radio            101,5 	Релакс радио 	
'101.9', //18 Радио Шансон           101,9 	Радио Шансон 	
'102.5', //19 Просто Радио           102,5 	Просто радио 	
'103.1', //20 Люкс FM                103,1 	Люкс FM 	
'103.6', //21 Радио Рокс             103,6 	Радио Рокс-Украи
'104.0', //22 Радио Шарманка         104,0 	Радио Шарманка 	
'104.6', //23 NRG                    104,6 	Радио 24 	
'105.0', //24 Радио Промінь          105,0 	Радио Проминь 	
'105.5', //25 Перец FM               105,5 	Перец FM 	
'106.0', //26 Душевное Радио         106,0 	Голос Столицы 	
'106.5', //27 Kiss FM                106,5 	Kiss FM 	
'107.0', //28 Европа FM              107,0 	Европа Плюс Киев 	
'107.4', //29 Авто Радио             107,4 	Авторадио — Украина 	
'107.9'  //30 Наше Радио             107,9 	Наше Радио 	                   
}                                



