MODULE_NAME='AVR_RS_CONTROL' (DEV DEVICE, DEV vdvPanel, DEV MVP[], INTEGER KEYPAD [])



DEFINE_DEVICE



DEFINE_VARIABLE


CHAR    MUTE [2]
volatile INTEGER a = 0
volatile INTEGER index
volatile CHAR    Buffer [10000]

volatile INTEGER CHANNEL_C__  //  Center
volatile INTEGER CHANNEL_SL_  //  Surround  Left
volatile INTEGER CHANNEL_SR_  //  Surround  Right
volatile INTEGER CHANNEL_SW_  //  Subwoofer




DEFINE_FUNCTION SEND_BASS_STATUS (integer bass_)
{
SELECT
    {
    ACTIVE (bass_ < 6):{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD[40]),',0,+', ITOA(6 - bass_), ' dB'" SEND_STRING 0, "'+', ITOA(6 - bass_), ' dB'"  }
    ACTIVE (bass_ = 6):{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD[40]),',0, 0 dB'" SEND_STRING 0, "'0 B'"  }
    ACTIVE (bass_ > 6):{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD[40]),',0,-', ITOA(bass_ - 6), ' dB'" SEND_STRING 0, "'-', ITOA(bass_ - 6), ' dB'"  }
    }
}



DEFINE_FUNCTION SEND_CHANNEL_STATUS (integer channel_,integer KEYPAD_)
{
SWITCH(channel_)
    {
    CASE 26:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,-12.0dB'" }
    CASE 27:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,-11.5dB'" }
    CASE 28:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,-11.0dB'" }
    CASE 29:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,-10.5dB'" }
    CASE 30:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,-10.0dB'" }
    CASE 31:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 9.5dB'" }
    CASE 32:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 9.0dB'" }
    CASE 33:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 8.5dB'" }
    CASE 34:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 8.0dB'" }
    CASE 35:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 7.5dB'" }
    CASE 36:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 7.0dB'" }
    CASE 37:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 6.5dB'" }
    CASE 38:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 6.0dB'" }
    CASE 39:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 5.5dB'" }
    CASE 40:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 5.0dB'" }
    CASE 41:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 4.5dB'" }
    CASE 42:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 4.0dB'" }
    CASE 43:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 3.5dB'" }
    CASE 44:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 3.0dB'" }
    CASE 45:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 2.5dB'" }
    CASE 46:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 2.0dB'" }
    CASE 47:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 1.5dB'" }
    CASE 48:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 1.0dB'" }
    CASE 49:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,- 0.5dB'" }
    CASE 50:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,  0.0dB'" }
    CASE 51:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 0.5dB'" }
    CASE 52:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 1.0dB'" }
    CASE 53:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 1.5dB'" }
    CASE 54:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 2.0dB'" }
    CASE 55:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 2.5dB'" }
    CASE 56:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 3.0dB'" }
    CASE 57:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 3.5dB'" }
    CASE 58:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 4.0dB'" }
    CASE 59:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 4.5dB'" }
    CASE 60:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 5.0dB'" }
    CASE 61:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 5.5dB'" }
    CASE 62:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 6.0dB'" }
    CASE 63:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 6.5dB'" }
    CASE 64:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 7.0dB'" }
    CASE 65:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 7.5dB'" }
    CASE 66:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 8.0dB'" }
    CASE 67:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 8.5dB'" }
    CASE 68:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 9.0dB'" }
    CASE 69:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+ 9.5dB'" }
    CASE 70:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+10.0dB'" }
    CASE 71:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+10.5dB'" }
    CASE 72:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+11.0dB'" }
    CASE 73:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+11.5dB'" }
    CASE 74:{SEND_COMMAND MVP, "'^TXT-',ITOA (KEYPAD_),',0,+12.0dB'" }

    }
}














DEFINE_START

Create_Buffer DEVICE, Buffer

for(index = 1; index<=LENGTH_ARRAY(MVP); index++)
	COMBINE_LEVELS (vdvPanel,KEYPAD[1], mvp[index],KEYPAD[1])

if (MUTE = '') {MUTE = 'OF'}

DEFINE_EVENT



DATA_EVENT[DEVICE]
{
ONLINE:{ Wait 40 { SEND_COMMAND DEVICE, "'SET BAUD 9600,N,8,1'" }}

STRING:{
		LOCAL_VAR volatile CHAR Reply[100]
		LOCAL_VAR volatile CHAR Cmd[100]

		while (FIND_STRING(Buffer,"$0D,$0A",1))
		{
		    Reply = REMOVE_STRING(Buffer,"$0D,$0A",1)
			IF (LENGTH_STRING (Reply) < 15)
			{
			    select
			    {
				active (FIND_STRING (Reply,'BA',1)): {
								REMOVE_STRING(Reply,'BA',1)
								SEND_BASS_STATUS (ATOI(LEFT_STRING (Reply, 2)))
							     }
				active (FIND_STRING (Reply,'C__',1)): {
								REMOVE_STRING(Reply,'C__',1)
								CHANNEL_C__ = ATOI(LEFT_STRING (Reply, 2))
								SEND_CHANNEL_STATUS (CHANNEL_C__, KEYPAD[43])
							     }
				active (FIND_STRING (Reply,'SL_',1)): {
								REMOVE_STRING(Reply,'SL_',1)
								CHANNEL_SL_ = ATOI(LEFT_STRING (Reply, 2))
								SEND_CHANNEL_STATUS (CHANNEL_SL_, KEYPAD[46])
							     }
				active (FIND_STRING (Reply,'SR_',1)): {
								REMOVE_STRING(Reply,'SR_',1)
								CHANNEL_SR_ = ATOI(LEFT_STRING (Reply, 2))
								SEND_CHANNEL_STATUS (CHANNEL_SR_, KEYPAD[49])
							     }
				active (FIND_STRING (Reply,'SW_',1)): {
								REMOVE_STRING(Reply,'SW_',1)
								CHANNEL_SW_ = ATOI(LEFT_STRING (Reply, 2))
								SEND_CHANNEL_STATUS (CHANNEL_SW_, KEYPAD[52])
							     }
			    }
                        }
                }
       }
}










//// POWER CONTROL //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [MVP, KEYPAD[1]] {PUSH:{SEND_STRING DEVICE, "'PO',$0D" WAIT 10 {SEND_STRING DEVICE, "'PO',$0D" WAIT 10 {SEND_STRING DEVICE, "'PO',$0D"}}}} // ON
BUTTON_EVENT [MVP, KEYPAD[2]] {PUSH:{SEND_STRING DEVICE, "'PF',$0D" WAIT 10 {SEND_STRING DEVICE, "'PF',$0D" WAIT 10 {SEND_STRING DEVICE, "'PF',$0D"}}}} // OFF
BUTTON_EVENT [MVP, KEYPAD[3]] {PUSH:{SEND_STRING DEVICE, "'?P',$0D" SEND_STRING 0, "'?P',$0D"}} // POWER STATUS

//// INPUT SELECT //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [MVP, KEYPAD[4]] {PUSH:{SEND_STRING DEVICE, "'25FN',$0D" }} // INPUT:BD
BUTTON_EVENT [MVP, KEYPAD[5]] {PUSH:{SEND_STRING DEVICE, "'15FN',$0D" }} // INPUT:DVR/BDR
BUTTON_EVENT [MVP, KEYPAD[6]] {PUSH:{SEND_STRING DEVICE, "'04FN',$0D" }} // INPUT:DVD
BUTTON_EVENT [MVP, KEYPAD[7]] {PUSH:{SEND_STRING DEVICE, "'06FN',$0D" }} // INPUT:SAT/cable
BUTTON_EVENT [MVP, KEYPAD[8]] {PUSH:{SEND_STRING DEVICE, "'10FN',$0D" }} // INPUT:VIDEO 1(VIDEO)
BUTTON_EVENT [MVP, KEYPAD[9]] {PUSH:{SEND_STRING DEVICE, "'14FN',$0D" }} // INPUT:VIDEO 2
BUTTON_EVENT [MVP, KEYPAD[10]]{PUSH:{SEND_STRING DEVICE, "'05FN',$0D" }} // INPUT:TV


//// HDMI SELECT //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [MVP, KEYPAD[11]] {PUSH:{SEND_STRING DEVICE, "'19FN',$0D" }} // HDMI 1
BUTTON_EVENT [MVP, KEYPAD[12]] {PUSH:{SEND_STRING DEVICE, "'20FN',$0D" }} // HDMI 2
BUTTON_EVENT [MVP, KEYPAD[13]] {PUSH:{SEND_STRING DEVICE, "'21FN',$0D" }} // HDMI 3
BUTTON_EVENT [MVP, KEYPAD[14]] {PUSH:{SEND_STRING DEVICE, "'22FN',$0D" }} // HDMI 4
BUTTON_EVENT [MVP, KEYPAD[15]] {PUSH:{SEND_STRING DEVICE, "'23FN',$0D" }} // HDMI 5
BUTTON_EVENT [MVP, KEYPAD[16]] {PUSH:{SEND_STRING DEVICE, "'24FN',$0D" }} // HDMI 6
BUTTON_EVENT [MVP, KEYPAD[17]] {PUSH:{SEND_STRING DEVICE, "'27FN',$0D" }} // HDMI 7

//// VOLUME  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [MVP, KEYPAD[18]] {PUSH:{SEND_STRING DEVICE, "'VU',$0D" } Hold [2,REPEAT]:{SEND_STRING DEVICE, "'VU',$0D"} }  // Volume UP
BUTTON_EVENT [MVP, KEYPAD[19]] {PUSH:{SEND_STRING DEVICE, "'VD',$0D" } Hold [2,REPEAT]:{SEND_STRING DEVICE, "'VD',$0D"} }  // Volume DOWN
BUTTON_EVENT [MVP, KEYPAD[20]] // Mute
{PUSH:{
IF (MUTE = 'ON') {MUTE = 'OF' SEND_STRING DEVICE, "'MF',$0D" SEND_STRING 0, "'MF',$0D"} // MUTE OFF
	    else {MUTE = 'ON' SEND_STRING DEVICE, "'MO',$0D" SEND_STRING 0, "'MO',$0D"} // MUTE ON
}}

LEVEL_EVENT  [vdvPanel, KEYPAD[1]] // level volume
{
local_var integer volume


volume = level.value
send_string 0, "'00',itoa (level.value)"

SELECT
{
    ACTIVE (volume<10) :{SEND_STRING DEVICE, "'00',itoa (level.value),'VL',$0D" }
    ACTIVE (10<=volume and volume<100) :{SEND_STRING DEVICE, "'0',itoa (level.value),'VL',$0D" }
    ACTIVE (100<=volume) :{SEND_STRING DEVICE, "itoa (level.value),'VL',$0D" }
}}


//// SELECT EFFECTS AUDIO  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [MVP, KEYPAD[21]] {PUSH:{SEND_STRING DEVICE, "'0010SR',$0D" }} // STEREO STANDARD
BUTTON_EVENT [MVP, KEYPAD[22]] {PUSH:{SEND_STRING DEVICE, "'0116SR',$0D" }} // TV SURROUND
BUTTON_EVENT [MVP, KEYPAD[23]] {PUSH:{SEND_STRING DEVICE, "'0109SR',$0D" }} // UNPLUGGED
BUTTON_EVENT [MVP, KEYPAD[24]] {PUSH:{SEND_STRING DEVICE, "'0112SR',$0D" }} // EXTENDED STEREO
BUTTON_EVENT [MVP, KEYPAD[25]] {PUSH:{SEND_STRING DEVICE, "'0050SR',$0D" }} // THX (cyclic)
BUTTON_EVENT [MVP, KEYPAD[26]] {PUSH:{SEND_STRING DEVICE, "'0056SR',$0D" }} // THX CINEMA (for multi ch)
BUTTON_EVENT [MVP, KEYPAD[27]] {PUSH:{SEND_STRING DEVICE, "'0057SR',$0D" }} // THX SURROUND EX (for multi ch)
BUTTON_EVENT [MVP, KEYPAD[28]] {PUSH:{SEND_STRING DEVICE, "'0065SR',$0D" }} // THX ULTRA2 CINEMA (for multi ch)
BUTTON_EVENT [MVP, KEYPAD[29]] {PUSH:{SEND_STRING DEVICE, "'0066SR',$0D" }} // THX ULTRA2 MUSIC (for multi ch)
BUTTON_EVENT [MVP, KEYPAD[30]] {PUSH:{SEND_STRING DEVICE, "'0006SR',$0D" }} // AUTO SURROUND
BUTTON_EVENT [MVP, KEYPAD[31]] {PUSH:{SEND_STRING DEVICE, "'0152SR',$0D" }} // OPTIMUM SURROUND

BUTTON_EVENT [MVP, KEYPAD[32]] {PUSH:{SEND_STRING DEVICE, "'SR',$0D" }} // BLANK
BUTTON_EVENT [MVP, KEYPAD[33]] {PUSH:{SEND_STRING DEVICE, "'SR',$0D" }} // BLANK
BUTTON_EVENT [MVP, KEYPAD[34]] {PUSH:{SEND_STRING DEVICE, "'SR',$0D" }} // BLANK
BUTTON_EVENT [MVP, KEYPAD[35]] {PUSH:{SEND_STRING DEVICE, "'SR',$0D" }} // BLANK

//// SELECT TONE  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [MVP, KEYPAD[36]] {PUSH:{SEND_STRING DEVICE, "'0TO',$0D" }} // TONE BYPASS
BUTTON_EVENT [MVP, KEYPAD[37]] {PUSH:{SEND_STRING DEVICE, "'1TO',$0D" }} // TONE ON

//// SELECT BASS  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [MVP, KEYPAD[38]] {PUSH:{SEND_STRING DEVICE, "'BI',$0D" }} // BASS INCREMENT
BUTTON_EVENT [MVP, KEYPAD[39]] {PUSH:{SEND_STRING DEVICE, "'BD',$0D" }} // BASS DECREMENT
BUTTON_EVENT [MVP, KEYPAD[40]] {PUSH:{SEND_STRING DEVICE, "'?BA',$0D" }} // BASS ???



//// SELECT CHANNEL VOLUME  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BUTTON_EVENT [MVP, KEYPAD[43]] {PUSH:{SEND_STRING DEVICE, "'?C__CLV',$0D" }} // Center
BUTTON_EVENT [MVP, KEYPAD[46]] {PUSH:{SEND_STRING DEVICE, "'?SL_CLV',$0D" }} // Surround  Left
BUTTON_EVENT [MVP, KEYPAD[49]] {PUSH:{SEND_STRING DEVICE, "'?SR_CLV',$0D" }} // Surround  Right
BUTTON_EVENT [MVP, KEYPAD[52]] {PUSH:{SEND_STRING DEVICE, "'?SW_CLV',$0D" }} // Subwoofer

BUTTON_EVENT [MVP, KEYPAD[53]] //
{PUSH:{
	SEND_STRING DEVICE, "'?BA',$0D"
	WAIT 3 {SEND_STRING DEVICE, "'?C__CLV',$0D"
	WAIT 3 {SEND_STRING DEVICE, "'?SL_CLV',$0D"
	WAIT 3 {SEND_STRING DEVICE, "'?SR_CLV',$0D"
	WAIT 3 {SEND_STRING DEVICE, "'?SW_CLV',$0D" }}}}
}} // Subwoofer

BUTTON_EVENT [MVP, KEYPAD[54]] {PUSH:{SEND_STRING DEVICE, "'1MC',$0D" }} // Presets
BUTTON_EVENT [MVP, KEYPAD[55]] {PUSH:{SEND_STRING DEVICE, "'2MC',$0D" }} // Presets
BUTTON_EVENT [MVP, KEYPAD[56]] {PUSH:{SEND_STRING DEVICE, "'3MC',$0D" }} // Presets
BUTTON_EVENT [MVP, KEYPAD[57]] {PUSH:{SEND_STRING DEVICE, "'4MC',$0D" }} // Presets
BUTTON_EVENT [MVP, KEYPAD[58]] {PUSH:{SEND_STRING DEVICE, "'5MC',$0D" }} // Presets
BUTTON_EVENT [MVP, KEYPAD[59]] {PUSH:{SEND_STRING DEVICE, "'6MC',$0D" }} // Presets



BUTTON_EVENT [MVP, KEYPAD[41]] // Center UP
{PUSH:{
	IF (CHANNEL_C__ >= 74)  {CHANNEL_C__ = 74} else
	    { {CHANNEL_C__ = CHANNEL_C__ + 1} }
	      SEND_STRING DEVICE, "'C__', ITOA(CHANNEL_C__) ,'CLV',$0D"
}}

BUTTON_EVENT [MVP, KEYPAD[42]] // Center DOWN
{PUSH:{
	IF (CHANNEL_C__ <= 26)  {CHANNEL_C__ = 26} else
	    { {CHANNEL_C__ = CHANNEL_C__ - 1} }
	      SEND_STRING DEVICE, "'C__', ITOA(CHANNEL_C__) ,'CLV',$0D"
}}


BUTTON_EVENT [MVP, KEYPAD[44]] // Surround  Left  UP
{PUSH:{
	IF (CHANNEL_SL_ >= 74)  {CHANNEL_SL_ = 74} else
	    { {CHANNEL_SL_ = CHANNEL_SL_ + 1} }
	      SEND_STRING DEVICE, "'SL_', ITOA(CHANNEL_SL_) ,'CLV',$0D"
}}

BUTTON_EVENT [MVP, KEYPAD[45]] // Surround  Left  DOWN
{PUSH:{
	IF (CHANNEL_SL_ <= 26)  {CHANNEL_SL_ = 26} else
	    { {CHANNEL_SL_ = CHANNEL_SL_ - 1} }
	      SEND_STRING DEVICE, "'SL_', ITOA(CHANNEL_SL_) ,'CLV',$0D"
}}


BUTTON_EVENT [MVP, KEYPAD[47]] // Surround  Right UP
{PUSH:{
	IF (CHANNEL_SR_ >= 74)  {CHANNEL_SR_ = 74} else
	    { {CHANNEL_SR_ = CHANNEL_SR_ + 1} }
	      SEND_STRING DEVICE, "'SR_', ITOA(CHANNEL_SR_) ,'CLV',$0D"
}}

BUTTON_EVENT [MVP, KEYPAD[48]] // Surround  Right DOWN
{PUSH:{
	IF (CHANNEL_SR_ <= 26)  {CHANNEL_SR_ = 26} else
	    { {CHANNEL_SR_ = CHANNEL_SR_ - 1} }
	      SEND_STRING DEVICE, "'SR_', ITOA(CHANNEL_SR_) ,'CLV',$0D"
}}


BUTTON_EVENT [MVP, KEYPAD[50]] // Subwoofer UP
{PUSH:{
	IF (CHANNEL_SW_ >= 74)  {CHANNEL_SW_ = 74} else
	    { {CHANNEL_SW_ = CHANNEL_SW_ + 1} }
	      SEND_STRING DEVICE, "'SW_', ITOA(CHANNEL_SW_) ,'CLV',$0D"
}}

BUTTON_EVENT [MVP, KEYPAD[51]] // Subwoofer DOWN
{PUSH:{
	IF (CHANNEL_SW_ <= 26)  {CHANNEL_SW_ = 26} else
	    { {CHANNEL_SW_ = CHANNEL_SW_ - 1} }
	      SEND_STRING DEVICE, "'SW_', ITOA(CHANNEL_SW_) ,'CLV',$0D"
}}






DEFINE_PROGRAM


wait 2
{
[MVP, KEYPAD[7]] = (MUTE = 'ON')
}


