MODULE_NAME='AVR_IP_Online' (DEV DEVICE, DEV vdvPanel, DEV MVP[], INTEGER KEYPAD [])



DEFINE_DEVICE



DEFINE_VARIABLE


CHAR    MUTE [2]
volatile INTEGER a = 0
volatile INTEGER index
volatile CHAR    Buffer [10000]
                                                     
                                                



DEFINE_START 

Create_Buffer DEVICE, Buffer 

for(index = 1; index<=LENGTH_ARRAY(MVP); index++)
	COMBINE_LEVELS (vdvPanel,KEYPAD[1], mvp[index],KEYPAD[1])

if (MUTE = '') {MUTE = 'OF'}

DEFINE_EVENT



DATA_EVENT[DEVICE]
{ 
ONLINE:{ Wait 40 { SEND_COMMAND DEVICE, "'SET BAUD 9600,N,8,1'" }}  
}


BUTTON_EVENT [MVP, KEYPAD[1]] {PUSH:{SEND_STRING DEVICE, "'PO',$0D" WAIT 10 {SEND_STRING DEVICE, "'PO',$0D" WAIT 10 {SEND_STRING DEVICE, "'PO',$0D"}}}} // ON
BUTTON_EVENT [MVP, KEYPAD[2]] {PUSH:{SEND_STRING DEVICE, "'PF',$0D" WAIT 10 {SEND_STRING DEVICE, "'PF',$0D" WAIT 10 {SEND_STRING DEVICE, "'PF',$0D"}}}} // OFF
BUTTON_EVENT [MVP, KEYPAD[3]] {PUSH:{SEND_STRING DEVICE, "'?P',$0D" SEND_STRING 0, "'?P',$0D"}} // POWER STATUS
                          
BUTTON_EVENT [MVP, KEYPAD[4]] {PUSH:{SEND_STRING DEVICE, "'25FN',$0D" }} // INPUT:BD
BUTTON_EVENT [MVP, KEYPAD[5]] {PUSH:{SEND_STRING DEVICE, "'15FN',$0D" }} // INPUT:DVR/BDR 
BUTTON_EVENT [MVP, KEYPAD[6]] {PUSH:{SEND_STRING DEVICE, "'04FN',$0D" }} // INPUT:DVD
BUTTON_EVENT [MVP, KEYPAD[7]] {PUSH:{SEND_STRING DEVICE, "'06FN',$0D" }} // INPUT:SAT/cable
BUTTON_EVENT [MVP, KEYPAD[8]] {PUSH:{SEND_STRING DEVICE, "'10FN',$0D" }} // INPUT:VIDEO 1(VIDEO)
BUTTON_EVENT [MVP, KEYPAD[9]] {PUSH:{SEND_STRING DEVICE, "'14FN',$0D" }} // INPUT:VIDEO 2           
BUTTON_EVENT [MVP, KEYPAD[10]]{PUSH:{SEND_STRING DEVICE, "'05FN',$0D" }} // INPUT:TV                  

BUTTON_EVENT [MVP, KEYPAD[11]] // Mute
{PUSH:{
IF (MUTE = 'ON') {MUTE = 'OF' SEND_STRING DEVICE, "'MF',$0D" SEND_STRING 0, "'MF',$0D"} // Mute OFF
else {MUTE = 'ON' SEND_STRING DEVICE, "'MO',$0D" SEND_STRING 0, "'MO',$0D"} // MUTE ON
}}

BUTTON_EVENT [MVP, KEYPAD[12]] {PUSH:{SEND_STRING DEVICE, "'0010SR',$0D" }} // STEREO STANDARD
BUTTON_EVENT [MVP, KEYPAD[13]] {PUSH:{SEND_STRING DEVICE, "'0001SR',$0D" }} // STEREO (cyclic)
BUTTON_EVENT [MVP, KEYPAD[14]] {PUSH:{SEND_STRING DEVICE, "'0057SR',$0D" }} // THX SURROUND EX (for multi ch)
BUTTON_EVENT [MVP, KEYPAD[15]] {PUSH:{SEND_STRING DEVICE, "'0008SR',$0D" }} // PURE DIRECT
BUTTON_EVENT [MVP, KEYPAD[16]] {PUSH:{SEND_STRING DEVICE, "'0006SR',$0D" }} // AUTO SURROUND                                        
 
		                                                                                           
BUTTON_EVENT [MVP, KEYPAD[17]] {PUSH:{SEND_STRING DEVICE, "'19FN',$0D" }} // HDMI 1
BUTTON_EVENT [MVP, KEYPAD[18]] {PUSH:{SEND_STRING DEVICE, "'20FN',$0D" }} // HDMI 2
BUTTON_EVENT [MVP, KEYPAD[19]] {PUSH:{SEND_STRING DEVICE, "'21FN',$0D" }} // HDMI 3
BUTTON_EVENT [MVP, KEYPAD[20]] {PUSH:{SEND_STRING DEVICE, "'22FN',$0D" }} // HDMI 4
BUTTON_EVENT [MVP, KEYPAD[21]] {PUSH:{SEND_STRING DEVICE, "'23FN',$0D" }} // HDMI 5
BUTTON_EVENT [MVP, KEYPAD[22]] {PUSH:{SEND_STRING DEVICE, "'24FN',$0D" }} // HDMI 6      
BUTTON_EVENT [MVP, KEYPAD[23]] {PUSH:{SEND_STRING DEVICE, "'27FN',$0D" }} // HDMI 7      
			                                                                           
BUTTON_EVENT [MVP, KEYPAD[24]] {PUSH:{SEND_STRING DEVICE, "'VU',$0D" } Hold [2,REPEAT]:{SEND_STRING DEVICE, "'VU',$0D"} }  // Volume UP
BUTTON_EVENT [MVP, KEYPAD[25]] {PUSH:{SEND_STRING DEVICE, "'VD',$0D" } Hold [2,REPEAT]:{SEND_STRING DEVICE, "'VD',$0D"} }  // Volume DOWN
                                                                                                             
LEVEL_EVENT  [vdvPanel, KEYPAD[1]]
{
local_var integer volume


volume = level.value
send_string 0, "'00',itoa (level.value)"

SELECT
{
    ACTIVE (volume<10) :{SEND_STRING DEVICE, "'00',itoa (level.value),'VL',$0D" }
    ACTIVE (10<=volume and volume<100) :{SEND_STRING DEVICE, "'0',itoa (level.value),'VL',$0D" }
    ACTIVE (100<=volume) :{SEND_STRING DEVICE, "itoa (level.value),'VL',$0D" }
}
} // level


DEFINE_PROGRAM


wait 2
{
[MVP, KEYPAD[7]] = (MUTE = 'ON')
}

                           
