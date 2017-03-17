MODULE_NAME='Sharp_Plasm_RS_v1' (DEV DEVICE, DEV vdvPanel, DEV MVP[], INTEGER BUTTONS[])
                                                                                                                                  
DEFINE_VARIABLE

volatile INTEGER index
volatile CHAR MUTE [2]
                                                                                                                                  
(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_START

for(index = 1; index<=LENGTH_ARRAY(MVP); index++)
	COMBINE_LEVELS (vdvPanel,BUTTONS[1], mvp[index],BUTTONS[1])

                                                                                                                                  
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
                                                                                                                                  
DATA_EVENT [DEVICE]  {ONLINE:{ WAIT 20 {Send_Command DEVICE, 'SET BAUD 9600,N,8,1 485 DISABLE'}}}                                          
                                                                                                                                  
BUTTON_EVENT[MVP, BUTTONS[1]] {PUSH:{SEND_STRING DEVICE, "'POWR1   ',$0D"}} // ON "$52,$43,$4B,$59,$34,$31,$20,$20"
BUTTON_EVENT[MVP, BUTTONS[2]] {PUSH:{SEND_STRING DEVICE, "'POWR0   ',$0D"}} // OFF RCKY41
                                                                                                                                  
BUTTON_EVENT[MVP, BUTTONS[3]] {PUSH:{SEND_STRING DEVICE, "'IAVD1   ',$0D" }} // EXT1
BUTTON_EVENT[MVP, BUTTONS[4]] {PUSH:{SEND_STRING DEVICE, "'IAVD2   ',$0D" }} // EXT2
BUTTON_EVENT[MVP, BUTTONS[5]] {PUSH:{SEND_STRING DEVICE, "'IAVD3   ',$0D" }} // EXT3
BUTTON_EVENT[MVP, BUTTONS[6]] {PUSH:{SEND_STRING DEVICE, "'IAVD4   ',$0D" }} // HDMI1
BUTTON_EVENT[MVP, BUTTONS[7]] {PUSH:{SEND_STRING DEVICE, "'IAVD5   ',$0D" }} // HDMI2
BUTTON_EVENT[MVP, BUTTONS[8]] {PUSH:{SEND_STRING DEVICE, "'IAVD6   ',$0D" }} // HDMI3
BUTTON_EVENT[MVP, BUTTONS[9]] {PUSH:{SEND_STRING DEVICE, "'IAVD7   ',$0D" }} // HDMI4
BUTTON_EVENT[MVP, BUTTONS[10]]{PUSH:{SEND_STRING DEVICE, "'IAVD8   ',$0D" }} // PC1
                                                                                                                                  
BUTTON_EVENT[MVP, BUTTONS[11]] {PUSH:{SEND_STRING DEVICE, "'WIDE0   ',$0D" }} // ÏÅÐÅÊËÞ×ÅÍÈÅ (AV)
BUTTON_EVENT[MVP, BUTTONS[12]] {PUSH:{SEND_STRING DEVICE, "'WIDE1   ',$0D" }} // ÍÎÐÌÀËÜÍÛÉ (AV)
BUTTON_EVENT[MVP, BUTTONS[13]] {PUSH:{SEND_STRING DEVICE, "'WIDE2   ',$0D" }} // ÌÀÑØÒÀÁ 14:9 (AV)
BUTTON_EVENT[MVP, BUTTONS[14]] {PUSH:{SEND_STRING DEVICE, "'WIDE3   ',$0D" }} // ÏÀÍÎÐÀÌÀ (AV)
BUTTON_EVENT[MVP, BUTTONS[15]] {PUSH:{SEND_STRING DEVICE, "'WIDE4   ',$0D" }} // ÏÎËÍÛÉ (AV / Âèäåî USB / Âèäåî äîìàøíåé ñåòè)
BUTTON_EVENT[MVP, BUTTONS[16]] {PUSH:{SEND_STRING DEVICE, "'WIDE5   ',$0D" }} // ÊÈÍÎÝÊÐÀÍ 16:9 (AV)
BUTTON_EVENT[MVP, BUTTONS[17]] {PUSH:{SEND_STRING DEVICE, "'WIDE6   ',$0D" }} // ÊÈÍÎÝÊÐÀÍ 14:9 (AV)
BUTTON_EVENT[MVP, BUTTONS[18]] {PUSH:{SEND_STRING DEVICE, "'WIDE7   ',$0D" }} // ÍÎÐÌÀËÜÍÛÉ (ÏÊ)
BUTTON_EVENT[MVP, BUTTONS[19]] {PUSH:{SEND_STRING DEVICE, "'WIDE8   ',$0D" }} // ÊÈÍÎÝÊÐÀÍ (ÏÊ)
BUTTON_EVENT[MVP, BUTTONS[20]] {PUSH:{SEND_STRING DEVICE, "'WIDE9   ',$0D" }} // ÏÎËÍÛÉ (ÏÊ)
BUTTON_EVENT[MVP, BUTTONS[21]] {PUSH:{SEND_STRING DEVICE, "'WIDE10  ',$0D" }} // ÏÎÒÎ×Å×ÍÎ (AV/ÏÊ)
BUTTON_EVENT[MVP, BUTTONS[22]] {PUSH:{SEND_STRING DEVICE, "'WIDE11  ',$0D" }} // ÓÌÅÍÜØÅÍÈÅ ÐÀÑÒÐÀ (AV)
BUTTON_EVENT[MVP, BUTTONS[23]] {PUSH:{SEND_STRING DEVICE, "'WIDE12  ',$0D" }} // ÀÂÒÎ (Âèäåî USB / Âèäåî äîìàøíåé ñåòè)
BUTTON_EVENT[MVP, BUTTONS[24]] {PUSH:{SEND_STRING DEVICE, "'WIDE13  ',$0D" }} // ÎÐÈÃÈÍÀË (Âèäåî AV/USB / Âèäåî äîìàøíåé ñåòè)
                                                                        
BUTTON_EVENT[MVP, BUTTONS[25]] {PUSH:{SEND_STRING DEVICE, "'AVMD0   ',$0D" }} // ÏÅÐÅÊËÞ×ÅÍÈÅ
BUTTON_EVENT[MVP, BUTTONS[26]] {PUSH:{SEND_STRING DEVICE, "'AVMD1   ',$0D" }} // ÑÒÀÍÄÀÐÒ
BUTTON_EVENT[MVP, BUTTONS[27]] {PUSH:{SEND_STRING DEVICE, "'AVMD2   ',$0D" }} // ÊÈÍÎÔÈËÜÌ
BUTTON_EVENT[MVP, BUTTONS[28]] {PUSH:{SEND_STRING DEVICE, "'AVMD3   ',$0D" }} // ÈÃÐÀ
BUTTON_EVENT[MVP, BUTTONS[29]] {PUSH:{SEND_STRING DEVICE, "'AVMD4   ',$0D" }} // ÏÎËÜÇÎÂÀÒÅËÜ
BUTTON_EVENT[MVP, BUTTONS[30]] {PUSH:{SEND_STRING DEVICE, "'AVMD5   ',$0D" }} // ÄÈÍÀÌÈ×ÅÑÊÈÉ (Ôèêñèðîâàííûé)
BUTTON_EVENT[MVP, BUTTONS[31]] {PUSH:{SEND_STRING DEVICE, "'AVMD6   ',$0D" }} // ÄÈÍÀÌÈ×ÅÑÊÈÉ
BUTTON_EVENT[MVP, BUTTONS[32]] {PUSH:{SEND_STRING DEVICE, "'AVMD7   ',$0D" }} // ÏÊ
BUTTON_EVENT[MVP, BUTTONS[33]] {PUSH:{SEND_STRING DEVICE, "'AVMD14  ',$0D" }} // ÑÒÀÍÄÀÐÒ (3D)
BUTTON_EVENT[MVP, BUTTONS[34]] {PUSH:{SEND_STRING DEVICE, "'AVMD15  ',$0D" }} // ÊÈÍÎÔÈËÜÌ (3D)
BUTTON_EVENT[MVP, BUTTONS[35]] {PUSH:{SEND_STRING DEVICE, "'AVMD16  ',$0D" }} // ÈÃÐÀ (3D)
BUTTON_EVENT[MVP, BUTTONS[36]] {PUSH:{SEND_STRING DEVICE, "'AVMD100 ',$0D" }} // ÀÂÒÎ                                                    
                                                                               
BUTTON_EVENT[MVP, BUTTONS[37]] {PUSH:{SEND_STRING DEVICE, "'TDCH0   ',$0D" }} // 3D ÂÛÊËÞ×ÅÍ
BUTTON_EVENT[MVP, BUTTONS[38]] {PUSH:{SEND_STRING DEVICE, "'TDCH1   ',$0D" }} // 2D s 3D
BUTTON_EVENT[MVP, BUTTONS[39]] {PUSH:{SEND_STRING DEVICE, "'TDCH2   ',$0D" }} // ÑËÅÂÀ È ÑÏÐÀÂÀ
BUTTON_EVENT[MVP, BUTTONS[40]] {PUSH:{SEND_STRING DEVICE, "'TDCH3   ',$0D" }} // ÑÂÅÐÕÓ È ÑÍÈÇÓ
BUTTON_EVENT[MVP, BUTTONS[41]] {PUSH:{SEND_STRING DEVICE, "'TDCH4   ',$0D" }} // 3D s 2D (ÑËÅÂÀ È ÑÏÐÀÂÀ)
BUTTON_EVENT[MVP, BUTTONS[42]] {PUSH:{SEND_STRING DEVICE, "'TDCH5   ',$0D" }} // 3D s 2D (ÑÂÅÐÕÓ È ÑÍÈÇÓ)
BUTTON_EVENT[MVP, BUTTONS[43]] {PUSH:{SEND_STRING DEVICE, "'TDCH6   ',$0D" }} // 3D ÀÂÒÎ
BUTTON_EVENT[MVP, BUTTONS[44]] {PUSH:{SEND_STRING DEVICE, "'TDCH7   ',$0D" }} // 3D s 2D                              
                                                                                                                                  
BUTTON_EVENT[MVP, BUTTONS [45]] {PUSH:{SEND_STRING DEVICE, "'RSPW0001',$0D" }} // RSPW 0001 

BUTTON_EVENT[MVP, BUTTONS[46]] {PUSH:{SEND_STRING DEVICE, "'IDTV    ',$0D" }} // digital TV 
BUTTON_EVENT[MVP, BUTTONS[47]] {PUSH:{SEND_STRING DEVICE, "'DTUP    ',$0D" }} // DTV CHANNEL UP 
BUTTON_EVENT[MVP, BUTTONS[48]] {PUSH:{SEND_STRING DEVICE, "'DTDW    ',$0D" }} // DTV CHANNEL DOWN
BUTTON_EVENT[MVP, BUTTONS[49]] {PUSH:{SEND_STRING DEVICE, "'ITVD    ',$0D" }} // analog TV 
BUTTON_EVENT[MVP, BUTTONS[50]] {PUSH:{SEND_STRING DEVICE, "'CHUP    ',$0D" }} // ATV CHANNEL UP 
BUTTON_EVENT[MVP, BUTTONS[51]] {PUSH:{SEND_STRING DEVICE, "'CHDW    ',$0D" }} // ATV CHANNEL DOWN                                                 
                        

BUTTON_EVENT [MVP, BUTTONS[52]] // Mute
{PUSH:{
IF (MUTE = 'ON') {MUTE = 'OF' SEND_STRING DEVICE, "'MUTE2   ',$0D"} // Mute OFF
else {MUTE = 'ON' SEND_STRING DEVICE, "'MUTE1   ',$0D"} // MUTE ON
}}


LEVEL_EVENT  [vdvPanel, BUTTONS[1]]
{
local_var integer volume

SEND_STRING DEVICE, "'VOLM',FORMAT('%02d',level.value),'  ',$0D"
IF (MUTE = 'ON') {MUTE = 'OF'}
} // level

 
                                                                                                                                  
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

wait 2
{
[MVP, BUTTONS[52]] = (MUTE = 'ON')
}



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
