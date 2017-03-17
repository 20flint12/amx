PROGRAM_NAME='Text'
(***********************************************************)
(* System Type : Netlinx                                   *)
(***********************************************************)


#if_not_defined _Text_Axi_
#define         _Text_Axi_


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


Integer wcUnicodeByCP1251[255] =
	{
		$0001, // $01 - #START OF HEADING
		$0002, // $02 - #START OF TEXT
		$0003, // $03 - #END OF TEXT
		$0004, // $04 - #END OF TRANSMISSION
		$0005, // $05 - #ENQUIRY
		$0006, // $06 - #ACKNOWLEDGE
		$0007, // $07 - #BELL
		$0008, // $08 - #BACKSPACE
		$0009, // $09 - #HORIZONTAL TABULATION
		$000A, // $0A - #LINE FEED
		$000B, // $0B - #VERTICAL TABULATION
		$000C, // $0C - #FORM FEED
		$000D, // $0D - #CARRIAGE RETURN
		$000E, // $0E - #SHIFT OUT
		$000F, // $0F - #SHIFT IN
		$0010, // $10 - #DATA LINK ESCAPE
		$0011, // $11 - #DEVICE CONTROL ONE
		$0012, // $12 - #DEVICE CONTROL TWO
		$0013, // $13 - #DEVICE CONTROL THREE
		$0014, // $14 - #DEVICE CONTROL FOUR
		$0015, // $15 - #NEGATIVE ACKNOWLEDGE
		$0016, // $16 - #SYNCHRONOUS IDLE
		$0017, // $17 - #END OF TRANSMISSION BLOCK
		$0018, // $18 - #CANCEL
		$0019, // $19 - #END OF MEDIUM
		$001A, // $1A - #SUBSTITUTE
		$001B, // $1B - #ESCAPE
		$001C, // $1C - #FILE SEPARATOR
		$001D, // $1D - #GROUP SEPARATOR
		$001E, // $1E - #RECORD SEPARATOR
		$001F, // $1F - #UNIT SEPARATOR
		$0020, // $20 - #SPACE
		$0021, // $21 - #EXCLAMATION MARK
		$0022, // $22 - #QUOTATION MARK
		$0023, // $23 - #NUMBER SIGN
		$0024, // $24 - #DOLLAR SIGN
		$0025, // $25 - #PERCENT SIGN
		$0026, // $26 - #AMPERSAND
		$0027, // $27 - #APOSTROPHE
		$0028, // $28 - #LEFT PARENTHESIS
		$0029, // $29 - #RIGHT PARENTHESIS
		$002A, // $2A - #ASTERISK
		$002B, // $2B - #PLUS SIGN
		$002C, // $2C - #COMMA
		$002D, // $2D - #HYPHEN-MINUS
		$002E, // $2E - #FULL STOP
		$002F, // $2F - #SOLIDUS
		$0030, // $30 - #DIGIT ZERO
		$0031, // $31 - #DIGIT ONE
		$0032, // $32 - #DIGIT TWO
		$0033, // $33 - #DIGIT THREE
		$0034, // $34 - #DIGIT FOUR
		$0035, // $35 - #DIGIT FIVE
		$0036, // $36 - #DIGIT SIX
		$0037, // $37 - #DIGIT SEVEN
		$0038, // $38 - #DIGIT EIGHT
		$0039, // $39 - #DIGIT NINE
		$003A, // $3A - #COLON
		$003B, // $3B - #SEMICOLON
		$003C, // $3C - #LESS-THAN SIGN
		$003D, // $3D - #EQUALS SIGN
		$003E, // $3E - #GREATER-THAN SIGN
		$003F, // $3F - #QUESTION MARK
		$0040, // $40 - #COMMERCIAL AT
		$0041, // $41 - #LATIN CAPITAL LETTER A
		$0042, // $42 - #LATIN CAPITAL LETTER B
		$0043, // $43 - #LATIN CAPITAL LETTER C
		$0044, // $44 - #LATIN CAPITAL LETTER D
		$0045, // $45 - #LATIN CAPITAL LETTER E
		$0046, // $46 - #LATIN CAPITAL LETTER F
		$0047, // $47 - #LATIN CAPITAL LETTER G
		$0048, // $48 - #LATIN CAPITAL LETTER H
		$0049, // $49 - #LATIN CAPITAL LETTER I
		$004A, // $4A - #LATIN CAPITAL LETTER J
		$004B, // $4B - #LATIN CAPITAL LETTER K
		$004C, // $4C - #LATIN CAPITAL LETTER L
		$004D, // $4D - #LATIN CAPITAL LETTER M
		$004E, // $4E - #LATIN CAPITAL LETTER N
		$004F, // $4F - #LATIN CAPITAL LETTER O
		$0050, // $50 - #LATIN CAPITAL LETTER P
		$0051, // $51 - #LATIN CAPITAL LETTER Q
		$0052, // $52 - #LATIN CAPITAL LETTER R
		$0053, // $53 - #LATIN CAPITAL LETTER S
		$0054, // $54 - #LATIN CAPITAL LETTER T
		$0055, // $55 - #LATIN CAPITAL LETTER U
		$0056, // $56 - #LATIN CAPITAL LETTER V
		$0057, // $57 - #LATIN CAPITAL LETTER W
		$0058, // $58 - #LATIN CAPITAL LETTER X
		$0059, // $59 - #LATIN CAPITAL LETTER Y
		$005A, // $5A - #LATIN CAPITAL LETTER Z
		$005B, // $5B - #LEFT SQUARE BRACKET
		$005C, // $5C - #REVERSE SOLIDUS
		$005D, // $5D - #RIGHT SQUARE BRACKET
		$005E, // $5E - #CIRCUMFLEX ACCENT
		$005F, // $5F - #LOW LINE
		$0060, // $60 - #GRAVE ACCENT
		$0061, // $61 - #LATIN SMALL LETTER A
		$0062, // $62 - #LATIN SMALL LETTER B
		$0063, // $63 - #LATIN SMALL LETTER C
		$0064, // $64 - #LATIN SMALL LETTER D
		$0065, // $65 - #LATIN SMALL LETTER E
		$0066, // $66 - #LATIN SMALL LETTER F
		$0067, // $67 - #LATIN SMALL LETTER G
		$0068, // $68 - #LATIN SMALL LETTER H
		$0069, // $69 - #LATIN SMALL LETTER I
		$006A, // $6A - #LATIN SMALL LETTER J
		$006B, // $6B - #LATIN SMALL LETTER K
		$006C, // $6C - #LATIN SMALL LETTER L
		$006D, // $6D - #LATIN SMALL LETTER M
		$006E, // $6E - #LATIN SMALL LETTER N
		$006F, // $6F - #LATIN SMALL LETTER O
		$0070, // $70 - #LATIN SMALL LETTER P
		$0071, // $71 - #LATIN SMALL LETTER Q
		$0072, // $72 - #LATIN SMALL LETTER R
		$0073, // $73 - #LATIN SMALL LETTER S
		$0074, // $74 - #LATIN SMALL LETTER T
		$0075, // $75 - #LATIN SMALL LETTER U
		$0076, // $76 - #LATIN SMALL LETTER V
		$0077, // $77 - #LATIN SMALL LETTER W
		$0078, // $78 - #LATIN SMALL LETTER X
		$0079, // $79 - #LATIN SMALL LETTER Y
		$007A, // $7A - #LATIN SMALL LETTER Z
		$007B, // $7B - #LEFT CURLY BRACKET
		$007C, // $7C - #VERTICAL LINE
		$007D, // $7D - #RIGHT CURLY BRACKET
		$007E, // $7E - #TILDE
		$007F, // $7F - #DELETE
		$0402, // $80 - #CYRILLIC CAPITAL LETTER DJE
		$0403, // $81 - #CYRILLIC CAPITAL LETTER GJE
		$201A, // $82 - #SINGLE LOW-9 QUOTATION MARK
		$0453, // $83 - #CYRILLIC SMALL LETTER GJE
		$201E, // $84 - #DOUBLE LOW-9 QUOTATION MARK
		$2026, // $85 - #HORIZONTAL ELLIPSIS
		$2020, // $86 - #DAGGER
		$2021, // $87 - #DOUBLE DAGGER
		$20AC, // $88 - #EURO SIGN
		$2030, // $89 - #PER MILLE SIGN
		$0409, // $8A - #CYRILLIC CAPITAL LETTER LJE
		$2039, // $8B - #SINGLE LEFT-POINTING ANGLE QUOTATION MARK
		$040A, // $8C - #CYRILLIC CAPITAL LETTER NJE
		$040C, // $8D - #CYRILLIC CAPITAL LETTER KJE
		$040B, // $8E - #CYRILLIC CAPITAL LETTER TSHE
		$040F, // $8F - #CYRILLIC CAPITAL LETTER DZHE
		$0452, // $90 - #CYRILLIC SMALL LETTER DJE
		$2018, // $91 - #LEFT SINGLE QUOTATION MARK
		$2019, // $92 - #RIGHT SINGLE QUOTATION MARK
		$201C, // $93 - #LEFT DOUBLE QUOTATION MARK
		$201D, // $94 - #RIGHT DOUBLE QUOTATION MARK
		$2022, // $95 - #BULLET
		$2013, // $96 - #EN DASH
		$2014, // $97 - #EM DASH
		$003F, // $98 - #UNDEFINED - Replaced by QUESTION MARK
		$2122, // $99 - #TRADE MARK SIGN
		$0459, // $9A - #CYRILLIC SMALL LETTER LJE
		$203A, // $9B - #SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
		$045A, // $9C - #CYRILLIC SMALL LETTER NJE
		$045C, // $9D - #CYRILLIC SMALL LETTER KJE
		$045B, // $9E - #CYRILLIC SMALL LETTER TSHE
		$045F, // $9F - #CYRILLIC SMALL LETTER DZHE
		$00A0, // $A0 - #NO-BREAK SPACE
		$040E, // $A1 - #CYRILLIC CAPITAL LETTER SHORT U
		$045E, // $A2 - #CYRILLIC SMALL LETTER SHORT U
		$0408, // $A3 - #CYRILLIC CAPITAL LETTER JE
		$00A4, // $A4 - #CURRENCY SIGN
		$0490, // $A5 - #CYRILLIC CAPITAL LETTER GHE WITH UPTURN
		$00A6, // $A6 - #BROKEN BAR
		$00A7, // $A7 - #SECTION SIGN
		$0401, // $A8 - #CYRILLIC CAPITAL LETTER IO
		$00A9, // $A9 - #COPYRIGHT SIGN
		$0404, // $AA - #CYRILLIC CAPITAL LETTER UKRAINIAN IE
		$00AB, // $AB - #LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
		$00AC, // $AC - #NOT SIGN
		$00AD, // $AD - #SOFT HYPHEN
		$00AE, // $AE - #REGISTERED SIGN
		$0407, // $AF - #CYRILLIC CAPITAL LETTER YI
		$00B0, // $B0 - #DEGREE SIGN
		$00B1, // $B1 - #PLUS-MINUS SIGN
		$0406, // $B2 - #CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
		$0456, // $B3 - #CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
		$0491, // $B4 - #CYRILLIC SMALL LETTER GHE WITH UPTURN
		$00B5, // $B5 - #MICRO SIGN
		$00B6, // $B6 - #PILCROW SIGN
		$00B7, // $B7 - #MIDDLE DOT
		$0451, // $B8 - #CYRILLIC SMALL LETTER IO
		$2116, // $B9 - #NUMERO SIGN
		$0454, // $BA - #CYRILLIC SMALL LETTER UKRAINIAN IE
		$00BB, // $BB - #RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
		$0458, // $BC - #CYRILLIC SMALL LETTER JE
		$0405, // $BD - #CYRILLIC CAPITAL LETTER DZE
		$0455, // $BE - #CYRILLIC SMALL LETTER DZE
		$0457, // $BF - #CYRILLIC SMALL LETTER YI
		$0410, // $C0 - #CYRILLIC CAPITAL LETTER A
		$0411, // $C1 - #CYRILLIC CAPITAL LETTER BE
		$0412, // $C2 - #CYRILLIC CAPITAL LETTER VE
		$0413, // $C3 - #CYRILLIC CAPITAL LETTER GHE
		$0414, // $C4 - #CYRILLIC CAPITAL LETTER DE
		$0415, // $C5 - #CYRILLIC CAPITAL LETTER IE
		$0416, // $C6 - #CYRILLIC CAPITAL LETTER ZHE
		$0417, // $C7 - #CYRILLIC CAPITAL LETTER ZE
		$0418, // $C8 - #CYRILLIC CAPITAL LETTER I
		$0419, // $C9 - #CYRILLIC CAPITAL LETTER SHORT I
		$041A, // $CA - #CYRILLIC CAPITAL LETTER KA
		$041B, // $CB - #CYRILLIC CAPITAL LETTER EL
		$041C, // $CC - #CYRILLIC CAPITAL LETTER EM
		$041D, // $CD - #CYRILLIC CAPITAL LETTER EN
		$041E, // $CE - #CYRILLIC CAPITAL LETTER O
		$041F, // $CF - #CYRILLIC CAPITAL LETTER PE
		$0420, // $D0 - #CYRILLIC CAPITAL LETTER ER
		$0421, // $D1 - #CYRILLIC CAPITAL LETTER ES
		$0422, // $D2 - #CYRILLIC CAPITAL LETTER TE
		$0423, // $D3 - #CYRILLIC CAPITAL LETTER U
		$0424, // $D4 - #CYRILLIC CAPITAL LETTER EF
		$0425, // $D5 - #CYRILLIC CAPITAL LETTER HA
		$0426, // $D6 - #CYRILLIC CAPITAL LETTER TSE
		$0427, // $D7 - #CYRILLIC CAPITAL LETTER CHE
		$0428, // $D8 - #CYRILLIC CAPITAL LETTER SHA
		$0429, // $D9 - #CYRILLIC CAPITAL LETTER SHCHA
		$042A, // $DA - #CYRILLIC CAPITAL LETTER HARD SIGN
		$042B, // $DB - #CYRILLIC CAPITAL LETTER YERU
		$042C, // $DC - #CYRILLIC CAPITAL LETTER SOFT SIGN
		$042D, // $DD - #CYRILLIC CAPITAL LETTER E
		$042E, // $DE - #CYRILLIC CAPITAL LETTER YU
		$042F, // $DF - #CYRILLIC CAPITAL LETTER YA
		$0430, // $E0 - #CYRILLIC SMALL LETTER A
		$0431, // $E1 - #CYRILLIC SMALL LETTER BE
		$0432, // $E2 - #CYRILLIC SMALL LETTER VE
		$0433, // $E3 - #CYRILLIC SMALL LETTER GHE
		$0434, // $E4 - #CYRILLIC SMALL LETTER DE
		$0435, // $E5 - #CYRILLIC SMALL LETTER IE
		$0436, // $E6 - #CYRILLIC SMALL LETTER ZHE
		$0437, // $E7 - #CYRILLIC SMALL LETTER ZE
		$0438, // $E8 - #CYRILLIC SMALL LETTER I
		$0439, // $E9 - #CYRILLIC SMALL LETTER SHORT I
		$043A, // $EA - #CYRILLIC SMALL LETTER KA
		$043B, // $EB - #CYRILLIC SMALL LETTER EL
		$043C, // $EC - #CYRILLIC SMALL LETTER EM
		$043D, // $ED - #CYRILLIC SMALL LETTER EN
		$043E, // $EE - #CYRILLIC SMALL LETTER O
		$043F, // $EF - #CYRILLIC SMALL LETTER PE
		$0440, // $F0 - #CYRILLIC SMALL LETTER ER
		$0441, // $F1 - #CYRILLIC SMALL LETTER ES
		$0442, // $F2 - #CYRILLIC SMALL LETTER TE
		$0443, // $F3 - #CYRILLIC SMALL LETTER U
		$0444, // $F4 - #CYRILLIC SMALL LETTER EF
		$0445, // $F5 - #CYRILLIC SMALL LETTER HA
		$0446, // $F6 - #CYRILLIC SMALL LETTER TSE
		$0447, // $F7 - #CYRILLIC SMALL LETTER CHE
		$0448, // $F8 - #CYRILLIC SMALL LETTER SHA
		$0449, // $F9 - #CYRILLIC SMALL LETTER SHCHA
		$044A, // $FA - #CYRILLIC SMALL LETTER HARD SIGN
		$044B, // $FB - #CYRILLIC SMALL LETTER YERU
		$044C, // $FC - #CYRILLIC SMALL LETTER SOFT SIGN
		$044D, // $FD - #CYRILLIC SMALL LETTER E
		$044E, // $FE - #CYRILLIC SMALL LETTER YU
		$044F  // $FF - #CYRILLIC SMALL LETTER YA
	}





(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)


Define_Function _SendTextToPanel(Dev dvPanel, Integer Index, Char Text[], Char UnicodeText[])
{
	local_var volatile DEV_INFO_STRUCT disPanel;

	If (Index == 0)
		return;

	If (Device_ID(dvPanel) == 0)
		return;

	Device_Info(dvPanel, disPanel);

	If (disPanel.Source_Type == SOURCE_TYPE_AXLINK) // G3 family
	{
		If (Index < 256)
		{
			// Send_Command dvPanel, "'TEXT', itoa(Index), '-', Text";

			local_var volatile Char cIndex;
			cIndex = Type_Cast(Index);

			Send_Command dvPanel, "'!T', cIndex, Text";
		}
	}
	Else
	If (disPanel.Source_Type == $00) // Virtual
	{
		// Virtual
		// disPanel.Source_Type == $00
		// disPanel.Device_ID == 65534
		// disPanel.Device_ID_String == 'Virtual'

		If (Index < 256)
		{
			local_var volatile Char cIndex;
			cIndex = Type_Cast(Index);

			Send_Command dvPanel, "'!T', cIndex, Text";
		}
	}
	Else // G4 family
	{
		// Send_Command dvPanel, "'^UnicodeText-', itoa(Index), ',1.255,', Ascii2Uni(Text)";
		// Send_Command dvPanel, "'^UnicodeText-', itoa(Index), ',0,', Ascii2Uni(Text)";
		SendLongUnicodeTextToG4Panel(dvPanel, Index, UnicodeText);
	}
}



Define_Function SendTextToPanel(Dev dvPanel, Integer Index, Char Text[])
{
	_SendTextToPanel(dvPanel, Index, Text, Ascii2Uni(Text));
}

Define_Function SendTextToPanels(Dev dvPanels[], Integer Index, Char Text[])
{
	local_var volatile Integer i;
	local_var volatile Char    UnicodeText[10240];

	UnicodeText = Ascii2Uni(Text);

	For (i = 1; i <= Length_Array(dvPanels); i++)
		_SendTextToPanel(dvPanels[i], Index, Text, UnicodeText);
}

Define_Function SendTextToDevChan(DevChan dtAddress, Char Text[])
{
	_SendTextToPanel(dtAddress.Device, dtAddress.Channel, Text, Ascii2Uni(Text));
}

Define_Function SendTextToDevChans(DevChan dtAddresses[], Char Text[])
{
	local_var volatile Integer i;
	local_var volatile Char    UnicodeText[10240];

	UnicodeText = Ascii2Uni(Text);

	For (i = 1; i <= Length_Array(dtAddresses); i++)
		_SendTextToPanel(dtAddresses[i].Device, dtAddresses[i].Channel, Text, UnicodeText);
}



Define_Function SendLongTextToG4Panel(Dev dvPanel, Integer Address, Char Text[])
{
	local_var volatile Integer iStart, iLen, iCnt;

	iStart = 1;
	iLen   = 160;

	If (Length_String(Text) <= iLen)
	{
		Send_Command dvPanel, "'^TXT-', itoa(Address), ',0,', Text";
	}
	Else
	{
		Send_Command dvPanel, "'^TXT-', itoa(Address), ',0,', Mid_String(Text, iStart, iLen)";
		iStart = iStart + iLen;

		While (Length_String(Text) >= iStart)
		{
			iCnt = Min_Value(Length_String(Text) - iStart + 1, iLen);

			Send_Command dvPanel, "'^BAT-', itoa(Address), ',0,', Mid_String(Text, iStart, iCnt)";

			iStart = iStart + iLen;
		}
	}
}

Define_Function SendLongUnicodeTextToG4Panel(Dev dvPanel, Integer Address, Char UnicodeText[])
{
	local_var volatile Integer iStart, iLen, iCnt;

	iStart = 1;
	iLen   = 160;

	If (Length_String(UnicodeText) <= iLen)
	{
		Send_Command dvPanel, "'^UNI-', itoa(Address), ',0,', UnicodeText";
	}
	Else
	{
		Send_Command dvPanel, "'^UNI-', itoa(Address), ',0,', Mid_String(UnicodeText, iStart, iLen)";
		iStart = iStart + iLen;

		While (Length_String(UnicodeText) >= iStart)
		{
			iCnt = Min_Value(Length_String(UnicodeText) - iStart + 1, iLen);

			Send_Command dvPanel, "'^BAU-', itoa(Address), ',0,', Mid_String(UnicodeText, iStart, iCnt)";

			iStart = iStart + iLen;
		}
	}
}



Define_Function Char[2048] Uni2Ascii (Char UnicodeText[])
{
	local_var volatile Integer i, j, UnicodeIndex;
	local_var volatile Char    Result[2048], IsFound;

	For (i = 1; i <= Length_String(UnicodeText) / 4; i++)
	{
		UnicodeIndex = hextoi(Mid_String(UnicodeText, (i - 1) * 4 + 1, 4));

		If (UnicodeIndex < $80)
		{
			Result[i] = Type_Cast(UnicodeIndex);
		}
		Else
		{
			Off[IsFound];
			For (j = $80; j <= $FF; j++)
				If (wcUnicodeByCP1251[j] == UnicodeIndex)
				{
					Result[i] = Type_Cast(j);

					On[IsFound];
					break;
				}

			If (!IsFound)
				Result[i] = '?';
		}
	}

	Set_Length_Array(Result, Length_String(UnicodeText) / 4);

	return Result;
}



Define_Function Char[10240] Ascii2Uni (Char Ascii[])
{
	local_var volatile Integer i;
	local_var volatile Char Result[10240];

	Result = "";

	For (i = 1; i <= Length_String(Ascii); i++)
		If (Ascii[i])
		    Result = "Result, Format('%04X', wcUnicodeByCP1251[Ascii[i]])";
	    Else
	    	Result = "Result, '0000'";

	return Result;
}



Define_Function Char[2048] UniB2Ascii (Char UnicodeText[])
{
	local_var volatile Integer i, j, UnicodeIndex;
	local_var volatile Char    Result[2048], IsFound;

	For (i = 1; i <= Length_String(UnicodeText) / 2; i++)
	{
		UnicodeIndex = UnicodeText[(i - 1) * 2 + 1] + 256 * UnicodeText[(i - 1) * 2 + 2];

		If (UnicodeIndex < $80)
		{
			Result[i] = Type_Cast(UnicodeIndex);
		}
		Else
		{
			Off[IsFound];
			For (j = $80; j <= $FF; j++)
				If (wcUnicodeByCP1251[j] == UnicodeIndex)
				{
					Result[i] = Type_Cast(j);

					On[IsFound];
					break;
				}

			If (!IsFound)
				Result[i] = '?';
		}
	}

	Set_Length_Array(Result, Length_String(UnicodeText) / 2);

	return Result;
}



Define_Function Char[2048] Ascii2UniB (Char Ascii[])
{
	local_var volatile Integer i;
	local_var volatile Char Result[2048], IsFound;

	Result = "";

	For (i = 1; i <= Length_String(Ascii); i++)
		If (Ascii[i])
	    	Result = "Result, wcUnicodeByCP1251[Ascii[i]] mod 256, wcUnicodeByCP1251[Ascii[i]] / 256";
	    Else
	    	Result = "Result, 0, 0";

	return Result;
}



#end_if // _Text_Axi_