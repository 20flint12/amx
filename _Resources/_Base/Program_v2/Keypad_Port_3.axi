PROGRAM_NAME='Keypad_Port_3' // �����������������

DEFINE_VARIABLE


(***********************************************************)
//              ����� �������������                        
//                                 
// 
(***********************************************************)



VOLATILE INTEGER BLOCK101_BUTTONS[] =  // 
{            
	101,  // ��������
	102,  // ���������
	103,  // �����
	104,  // dry
	105,  // �����
	106,  // ����������
	107,  // �������� 
	108,  // �������
	109,  // �������
	110,  // ����
	111,  // ����������� ����
	112,  // ����������� �����
	113,  // 
	114,  // 
	115,  // 
	116,  // 
	117,  // ������� ������
	118,  // ������� ��������
	119,  // ������������� �����������
	120  // ������� �����������
} 
      
VOLATILE INTEGER BLOCK102_BUTTONS[] =  // 
{            
	201,  // ��������
	202,  // ���������
	203,  // �����
	204,  // dry
	205,  // �����
	206,  // ����������
	207,  // �������� 
	208,  // �������
	209,  // �������
	210,  // ����
	211,  // ����������� ����
	212,  // ����������� �����
	213,  // 
	214,  // 
	215,  // 
	216,  // 
	217,  // ������� ������
	218,  // ������� ��������
	219,  // ������������� �����������
	220  // ������� �����������
}       

VOLATILE INTEGER BLOCK103_BUTTONS[] =  // 
{            
	301,  // ��������
	302,  // ���������
	303,  // �����
	304,  // dry
	305,  // �����
	306,  // ����������
	307,  // �������� 
	308,  // �������
	309,  // �������
	310,  // ����
	311,  // ����������� ����
	312,  // ����������� �����
	313,  // 
	314,  // 
	315,  // 
	316,  // 
	317,  // ������� ������
	318,  // ������� ��������
	319,  // ������������� �����������
	320  // ������� �����������
}       

VOLATILE INTEGER BLOCK104_BUTTONS[] =  // 
{            
	401,  // ��������
	402,  // ���������
	403,  // �����
	404,  // dry
	405,  // �����
	406,  // ����������
	407,  // �������� 
	408,  // �������
	409,  // �������
	410,  // ����
	411,  // ����������� ����
	412,  // ����������� �����
	413,  // 
	414,  // 
	415,  // 
	416,  // 
	417,  // ������� ������
	418,  // ������� ��������
	419,  // ������������� �����������
	420  // ������� �����������
}       

VOLATILE INTEGER BLOCK105_BUTTONS[] =  // 
{            
	501,  // ��������
	502,  // ���������
	503,  // �����
	504,  // dry
	505,  // �����
	506,  // ����������
	507,  // �������� 
	508,  // �������
	509,  // �������
	510,  // ����
	511,  // ����������� ����
	512,  // ����������� �����
	513,  // 
	514,  // 
	515,  // 
	516,  // 
	517,  // ������� ������
	518,  // ������� ��������
	519,  // ������������� �����������
	520  // ������� �����������
}       

VOLATILE INTEGER BLOCK106_BUTTONS[] =  // 
{            
	601,  // ��������
	602,  // ���������
	603,  // �����
	604,  // dry
	605,  // �����
	606,  // ����������
	607,  // �������� 
	608,  // �������
	609,  // �������
	610,  // ����
	611,  // ����������� ����
	612,  // ����������� �����
	613,  // 
	614,  // 
	615,  // 
	616,  // 
	617,  // ������� ������
	618,  // ������� ��������
	619,  // ������������� �����������
	620  // ������� �����������
}       

VOLATILE INTEGER BLOCK107_BUTTONS[] =  // 
{            
	701,  // ��������
	702,  // ���������
	703,  // �����
	704,  // dry
	705,  // �����
	706,  // ����������
	707,  // �������� 
	708,  // �������
	709,  // �������
	710,  // ����
	711,  // ����������� ����
	712,  // ����������� �����
	713,  // 
	714,  // 
	715,  // 
	716,  // 
	717,  // ������� ������
	718,  // ������� ��������
	719,  // ������������� �����������
	720   // ������� �����������
}       

VOLATILE INTEGER BLOCK_BUTTONS[] =  // 
{            
	1001,  // �����
	1002,  // �����
	1003,  // ��������  ��� ����
	1004,  // ��������� ��� ����
	1005   // ������ ���� ����
}         

integer RAZNICA_DEV_FR_BL = 34200


(*
000 ON  22C 23,00C High Cool OK$0D$0A
001 ON  22C 24,00C High Cool OK$0D$0A
002 ON  22C 23,00C High Cool OK$0D$0A
003 ON  22C 24,00C High Cool OK$0D$0A
004 ON  22C 25,00C High Cool OK$0D$0A
005 ON  22C 23,00C High Cool OK$0D$0A
006 OFF 23C 13,00C Top  Dry  OK$0D$0A
*)