PROGRAM_NAME='Keypad_Port_2' // ���������


DEFINE_VARIABLE

VOLATILE INTEGER PANEL1_BUTTONS[] =   // ���� 0 ��
{                              
	1,  //        
	2,            
	3,  //        
	4,            
	5,  //        
	6,  //        
	7,  //        
	8,  //        
	9,  //        
	10, //        
	11,           
	12,           
	13,           
	14,           
	15,           
	16,           
	17,           
	18, // Lower  
	19  // Raise  
}                     
                      
VOLATILE INTEGER PANEL2_BUTTONS[] =   // ���������
{                              
	21,  //       
	22,           
	23,  //       
	24,           
	25,  //       
	26,  //       
	27,  //       
	28,  //       
	29,  //       
	30, //        
	31,           
	32,           
	33,           
	34,           
	35,           
	36,           
	37,           
	38, // Lower  
	39  // Raise  
}                     
                      
VOLATILE INTEGER PANEL3_BUTTONS[] =   //  ������� ������ 007 
{                              
	41,  //       
	42,           
	43,  //       
	44,           
	45,  //       
	46,  //       
	47,  //       
	48,  //       
	49,  //       
	50, //        
	51,           
	52,           
	53,           
	54,           
	55,           
	56,           
	57,           
	58, // Lower  
	59  // Raise  
}                     
                      
VOLATILE INTEGER PANEL4_BUTTONS[] =   // ��� ��� ������ 
{                              
	61,           
	62,           
	63,           
	64,           
	65,           
	66,  //       
	67,  //       
	68,  //       
	69,  //       
	70, //        
	71,           
	72,           
	73,           
	74,           
	75,           
	76,           
	77,           
	78, // Lower  
	79  // Raise  
}                     
                      
VOLATILE INTEGER PANEL5_BUTTONS[] =   // �������� 101
{                              
	81,           
	82,           
	83,           
	84,           
	85,           
	86,  //       
	87,  //       
	88,  //       
	89,  //       
	90, //        
	91,           
	92,           
	93,           
	94,           
	95,           
	96,           
	97,           
	98, // Lower  
	99  // Raise  
}                     
                      
VOLATILE INTEGER PANEL6_BUTTONS[] =   // �����
{                              
	101,          
	102,          
	103,          
	104,          
	105,          
	106,  //      
	107,  //      
	108,  //      
	109,  //      
	110, //       
	111,          
	112,          
	113,          
	114,          
	115,          
	116,          
	117,          
	118, // Lower 
	119  // Raise 
}                     
                      
VOLATILE INTEGER PANEL7_BUTTONS[] =   // ��������� � ��������
{                              
	121,  //        
	122,            
	123,  //        
	124,            
	125,  //        
	126,  //        
	127,  //        
	128,  //        
	129,  //        
	130, //        
	131,           
	132,           
	133,           
	134,           
	135,           
	136,           
	137,           
	138, // Lower  
	139  // Raise  
}                     
                      
VOLATILE INTEGER PANEL8_BUTTONS[] =   // ��������� � �����
{                              
	141,  //       
	142,           
	143,  //       
	144,           
	145,  //       
	146,  //       
	147,  //       
	148,  //       
	149,  //       
	150, //        
	151,           
	152,           
	153,           
	154,           
	155,           
	156,           
	157,           
	158, // Lower  
	159  // Raise  
}                     
                      
VOLATILE INTEGER PANEL9_BUTTONS[] =   //  ��������� �� ������
{                              
	161,  //       
	162,           
	163,  //       
	164,           
	165,  //       
	166,  //       
	167,  //       
	168,  //       
	169,  //       
	170, //        
	171,           
	172,           
	173,           
	174,           
	175,           
	176,           
	177,           
	178, // Lower  
	179  // Raise  
}                     
                      
VOLATILE INTEGER PANEL10_BUTTONS[] =   //  ��������� � ��������
{                              
	181,           
	182,           
	183,           
	184,           
	185,           
	186,  //       
	187,  //       
	188,  //       
	189,  //       
	190, //        
	191,           
	192,           
	193,           
	194,           
	195,           
	196,           
	197,           
	198, // Lower  
	199  // Raise  
}                     
                      
VOLATILE INTEGER PANEL11_BUTTONS[] =   // ������� ���.
{                              
	201,           
	202,           
	203,           
	204,           
	205,           
	206,  //       
	207,  //       
	208,  //       
	209,  //       
	210, //        
	211,           
	212,           
	213,           
	214,           
	215,           
	216,           
	217,           
	218, // Lower  
	219  // Raise  
}                     
                      
VOLATILE INTEGER PANEL12_BUTTONS[] =   // ������� ���. � ������� �����
{                              
	221,          
	222,          
	223,          
	224,          
	225,          
	226,  //      
	227,  //      
	228,  //      
	229,  //      
	230, //       
	231,          
	232,          
	233,          
	234,          
	235,          
	236,          
	237,          
	238, // Lower 
	239  // Raise 
}                     
                      
VOLATILE INTEGER PANEL13_BUTTONS[] =   // ������� ���. � ������� ������
{                              
	241,  //        
	242,            
	243,  //        
	244,            
	245,  //        
	246,  //        
	247,  //        
	248,  //        
	249,  //        
	250, //        
	251,           
	252,           
	253,           
	254,           
	255,           
	256,           
	257,           
	258, // Lower  
	259  // Raise  
}                     
                      
VOLATILE INTEGER PANEL14_BUTTONS[] =   // ������� ���. ����
{                              
	261,  //       
	262,           
	263,  //       
	264,           
	265,  //       
	266,  //       
	267,  //       
	268,  //       
	269,  //       
	270, //        
	271,           
	272,           
	273,           
	274,           
	275,           
	276,           
	277,           
	278, // Lower  
	279  // Raise  
}                     
                      
VOLATILE INTEGER PANEL15_BUTTONS[] =   //  ������� � ������
{                              
	281,  //       
	282,           
	283,  //       
	284,           
	285,  //       
	286,  //       
	287,  //       
	288,  //       
	289,  //       
	290, //        
	291,           
	292,           
	293,           
	294,           
	295,           
	296,           
	297,           
	298, // Lower  
	299  // Raise  
}                     
                      
VOLATILE INTEGER PANEL16_BUTTONS[] =   //  �����
{                              
	301,           
	302,           
	303,           
	304,           
	305,           
	306,  //       
	307,  //       
	308,  //       
	309,  //       
	310, //        
	311,           
	312,           
	313,           
	314,           
	315,           
	316,           
	317,           
	318, // Lower  
	319  // Raise  
}                     
                      
VOLATILE INTEGER PANEL17_BUTTONS[] =   // ������� � ���������
{                              
	321,           
	322,           
	323,           
	324,           
	325,           
	326,  //       
	327,  //       
	328,  //       
	329,  //       
	330, //        
	331,           
	332,           
	333,           
	334,           
	335,           
	336,           
	337,           
	338, // Lower  
	339  // Raise  
}                     
                      
VOLATILE INTEGER PANEL18_BUTTONS[] =   // ������� � �����
{                              
	341,          
	342,          
	343,          
	344,          
	345,          
	346,  //      
	347,  //      
	348,  //      
	349,  //      
	350, //       
	351,          
	352,          
	353,          
	354,          
	355,          
	356,          
	357,          
	358, // Lower 
	359  // Raise 
}                     
                      
VOLATILE INTEGER PANEL19_BUTTONS[] =   // ������� �� �����
{                              
	361,  //        
	362,            
	363,  //        
	364,            
	365,  //        
	366,  //        
	367,  //        
	368,  //        
	369,  //        
	370, //        
	371,           
	372,           
	373,           
	374,           
	375,           
	376,           
	377,           
	378, // Lower  
	379  // Raise  
}                     
                      
VOLATILE INTEGER PANEL20_BUTTONS[] =   // ������� � �������
{                              
	381,  //       
	382,           
	383,  //       
	384,           
	385,  //       
	386,  //       
	387,  //       
	388,  //       
	389,  //       
	390, //        
	391,           
	392,           
	393,           
	394,           
	395,           
	396,           
	397,           
	398, // Lower  
	399  // Raise  
}                     
                      
VOLATILE INTEGER PANEL21_BUTTONS[] =   //  ���� ������ � ��������
{                              
	401,  //       
	402,           
	403,  //       
	404,           
	405,  //       
	406,  //       
	407,  //       
	408,  //       
	409,  //       
	410, //        
	411,           
	412,           
	413,           
	414,           
	415,           
	416,           
	417,           
	418, // Lower  
	419  // Raise  
}                     
                      
VOLATILE INTEGER PANEL22_BUTTONS[] =   //  ������� ���� � �����
{                              
	421,           
	422,           
	423,           
	424,           
	425,           
	426,  //       
	427,  //       
	428,  //       
	429,  //       
	430, //        
	431,           
	432,           
	433,           
	434,           
	435,           
	436,           
	437,           
	438, // Lower  
	439  // Raise  
}                     
                      
VOLATILE INTEGER PANEL23_BUTTONS[] =   // ������� ���� � ������� �����
{                              
	441,           
	442,           
	443,           
	444,           
	445,           
	446,  //       
	447,  //       
	448,  //       
	449,  //       
	450, //        
	451,           
	452,           
	453,           
	454,           
	455,           
	456,           
	457,           
	458, // Lower  
	459  // Raise  
}                     
                      
VOLATILE INTEGER PANEL24_BUTTONS[] =   // ������� ���� � ������� ������
{                              
	461,          
	462,          
	463,          
	464,          
	465,          
	466,  //      
	467,  //      
	468,  //      
	469,  //      
	470, //       
	471,          
	472,          
	473,          
	474,          
	475,          
	476,          
	477,          
	478, // Lower 
	479  // Raise 
}                     
                      
VOLATILE INTEGER PANEL25_BUTTONS[] =   // ������� ���� � ������� ���� 
{                              
	481,          
	482,          
	483,          
	484,          
	485,          
	486,  //      
	487,  //      
	488,  //      
	489,  //      
	490, //       
	491,          
	492,          
	493,          
	494,          
	495,          
	496,          
	497,          
	498, // Lower 
	499  // Raise 
}                     
                      
VOLATILE INTEGER PANEL26_BUTTONS[] =   // ������ ��� � �������
{                              
	501,          
	502,          
	503,          
	504,          
	505,          
	506,  //      
	507,  //      
	508,  //      
	509,  //      
	510, //       
	511,          
	512,          
	513,          
	514,          
	515,          
	516,          
	517,          
	518, // Lower 
	519  // Raise 
}                     
                      
VOLATILE INTEGER PANEL27_BUTTONS[] =   // ������ ��� � ����
{                              
	521,          
	522,          
	523,          
	524,          
	525,          
	526,  //      
	527,  //      
	528,  //      
	529,  //      
	530, //       
	531,          
	532,          
	533,          
	534,          
	535,          
	536,          
	537,          
	538, // Lower 
	539  // Raise 
}                     
                      
VOLATILE INTEGER PANEL28_BUTTONS[] =   // ������ ��� �� ������
{                              
	541,          
	542,          
	543,          
	544,          
	545,          
	546,  //      
	547,  //      
	548,  //      
	549,  //      
	550, //       
	551,          
	552,          
	553,          
	554,          
	555,          
	556,          
	557,          
	558, // Lower 
	559  // Raise 
}                     


VOLATILE INTEGER PANEL29_BUTTONS[] =   // ���� ������
{                              
	561,  //  ���� 001         
	562,  //  ��������� 002        
	563,  //  ������� 007        
	564,  //  ��� ��� ������� 014        
	565,  //  �������� 101        
	566,  //  ����� 102    
	567,  //  ��������� 104    
	568,  //  ������� 109    
	569,  //  ������� 113    
	570,  //  ����� 114     
	571,  //  ������� 107        
	572,  //  ���� ������ 202        
	573,  //  ������� 209        
	574,  //  �������� 212        
	575,  //  ������ ��� 213        
	576,  //  ������ 215        
	577,  //  ���� ��� ����           
	578   //  �����  
}                 
       
VOLATILE INTEGER PANEL30_BUTTONS[] =   // ������ ��� �� ������
{                              
	601,  //  ����� ���� �������         
	602,  //  ����� ���� ����        
	603,  //  ����� ���� �������        
	604,  //  ����� �������� ����        
	605,  //  ����� �������� ����        
	606,  //  ����� �������� ����    
	607,  //  ���� �������� ����    
	608,  //  ���� �������� ����    
	609,  //  ���� �������� ����    
	610,  //  ����� ��������� ����     
	611,  //  ����� ��������� ����        
	612,  //  ����� ��������� ����        
	613,  //  ���� ��������� ����        
	614,  //  ���� ��������� ����        
	615,  //  ���� ��������� ����        
	616,  //  ����� �������� ����        
	617,  //  ����� �������� ����        
	618,  //  ����� �������� ����        
	619,  //  ���� �������� ����        
	620,  //  ���� �������� ����        
	621,  //  ���� �������� ����        
	622,  //  �� ������ ��� ����        
	623,  //  �� ������ ��� ����        
	624,  //  �� ������ ��� ����        
	625   //  ������  up\stop\down            
}                     
      
      
VOLATILE INTEGER HW_KEYPADS_COUNT = 30

VOLATILE INTEGER NUM_LED_PANEL[2] = {18,25}

VOLATILE CHAR HW_KEYPADS[30][3] =
{
	'22', // ���� 0 ��
	'23', // ���������
	'24', // ������� ������ 007 
	'26', // ��� ��� ������
	'27', // �������� 101
	'28', // �����
	'29', // ��������� � ��������
	'32', // ��������� � �����
	'30', // ��������� �� ������
	'31', // ��������� � ��������
	'37', // ������� ���.
	'38', // ������� ���. � ������� �����
	'39', // ������� ���. � ������� ������
	'40', // ������� ���. ����
	'41', // ������� � ������
	'42', // �����
	'33', // ������� � ���������
	'34', // ������� � �����
	'35', // ������� �� �����
	'36', // ������� � �������
	'43', // ���� ������ � ��������
	'44', // ������� ���� � �����
	'45', // ������� ���� � ������� �����
	'46', // ������� ���� � ������� ������
	'47', // ������� ���� � ������� ���� 
	'48', // ������ ��� � �������
	'49', // ������ ��� � ����
	'50', // ������ ��� �� ������                     
	'153', // ����. ������                     
	'154'  // ����. ������                     
}


