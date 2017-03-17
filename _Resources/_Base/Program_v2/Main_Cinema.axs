PROGRAM_NAME='Main_Cinema'
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
#include 'Keypad_Port_2.axi'

DEFINE_DEVICE

(* PORT FOR Autonomic MCS_1 Server*)
dvMCS1_1  = 0:51:2
dvMCS1_2  = 0:52:2
dvMCS1_3  = 0:53:2
dvMCS1_4  = 0:54:2
dvMCS1_5  = 0:55:2

dvMCS1_11  = 0:61:2
dvMCS1_12  = 0:62:2
dvMCS1_13  = 0:63:2
dvMCS1_14  = 0:64:2
dvMCS1_15  = 0:65:2
dvMCS1_16  = 0:66:2
dvMCS1_17  = 0:67:2
dvMCS1_18  = 0:68:2
dvMCS1_19  = 0:69:2
dvMCS1_20  = 0:70:2
dvMCS1_21  = 0:71:2
dvMCS1_22  = 0:72:2
               

COM = 5001:1:2

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
              
	      
(* VIRTUAL MCE 1 Server *)

vdvMCS1_1  = 34101 : 1 : 2
vdvMCS1_2  = 34102 : 1 : 2
vdvMCS1_3  = 34103 : 1 : 2
vdvMCS1_4  = 34104 : 1 : 2
vdvMCS1_5  = 34105 : 1 : 2

vdvMCS1_11  = 34111 : 1 : 2
vdvMCS1_12  = 34112 : 1 : 2
vdvMCS1_13  = 34113 : 1 : 2
vdvMCS1_14  = 34114 : 1 : 2
vdvMCS1_15  = 34115 : 1 : 2
vdvMCS1_16  = 34116 : 1 : 2
vdvMCS1_17  = 34117 : 1 : 2
vdvMCS1_18  = 34118 : 1 : 2
vdvMCS1_19  = 34119 : 1 : 2
vdvMCS1_20  = 34120 : 1 : 2
vdvMCS1_21  = 34121 : 1 : 2
vdvMCS1_22  = 34122 : 1 : 2
                
			 
vdvONLINE_S1 = 34301:1:1  
			 
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
(***********************************************************)
DEFINE_VARIABLE

DEV MVP_MCE1 [] =  {MVP1_5, MVP2_5, MVP3_5, MVP4_5, MVP5_5, MVP11_5, MVP12_5, MVP13_5, MVP14_5, MVP15_5, MVP16_5, MVP17_5, MVP18_5, MVP19_5, MVP20_5, MVP21_5, MVP22_5} // For MCE Server

VOLATILE char cMCS1_SERVER_IP[] = '192.168.4.9'  //HOST MCE1 IP ADDRESS 192.168.1.5
VOLATILE integer iMCS_SERVER_PORT = 5004  //CONTROL PORT (SET IN AUTONOMIC CONFIG APP)
VOLATILE integer iMCS_ART_PORT    = 5005 //ARTWORK PORT (SET IN AUTONOMIC CONFIG APP)
VOLATILE integer Wait_Qetions = 5

DEV VDV_MCE1 [] = 
{
vdvMCS1_1, 
vdvMCS1_2, 
vdvMCS1_3, 
vdvMCS1_4, 
vdvMCS1_5,

vdvMCS1_11, 
vdvMCS1_12, 
vdvMCS1_13, 
vdvMCS1_14, 
vdvMCS1_15, 
vdvMCS1_16, 
vdvMCS1_17, 
vdvMCS1_18, 
vdvMCS1_19, 
vdvMCS1_20, 
vdvMCS1_21, 
vdvMCS1_22 
}       


// IP control MCS Server

// iPad 1
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM1  (vdvMCS1_1,  dvMCS1_1, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_1   (vdvMCS1_1,    MVP1_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// iPad 2  
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM2  (vdvMCS1_2,  dvMCS1_2, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_2   (vdvMCS1_2,    MVP2_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// iPad 3                                                             
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM3  (vdvMCS1_3,  dvMCS1_3, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_3   (vdvMCS1_3,    MVP3_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// iPad 4                                                             
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM4  (vdvMCS1_4,  dvMCS1_4, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_4   (vdvMCS1_4,    MVP4_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// iPad 5                                                             
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM5  (vdvMCS1_5,  dvMCS1_5, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_5   (vdvMCS1_5,    MVP5_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 

// Panel 1
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM11  (vdvMCS1_11,  dvMCS1_11, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_11   (vdvMCS1_11,    MVP11_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// Panel 2
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM12  (vdvMCS1_12,  dvMCS1_12, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_12   (vdvMCS1_12,    MVP12_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// Panel 3
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM13  (vdvMCS1_13,  dvMCS1_13, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_13   (vdvMCS1_13,    MVP13_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// Panel 4
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM14  (vdvMCS1_14,  dvMCS1_14, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_14   (vdvMCS1_14,    MVP14_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// Panel 5
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM15  (vdvMCS1_15,  dvMCS1_15, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_15   (vdvMCS1_15,    MVP15_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// Panel 6
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM16  (vdvMCS1_16,  dvMCS1_16, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_16   (vdvMCS1_16,    MVP16_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// Panel 7
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM17  (vdvMCS1_17,  dvMCS1_17, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_17   (vdvMCS1_17,    MVP17_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 
// Panel 8
DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM18  (vdvMCS1_18,  dvMCS1_18, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_18   (vdvMCS1_18,    MVP18_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 

DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM19  (vdvMCS1_19,  dvMCS1_19, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_19   (vdvMCS1_19,    MVP19_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 

DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM20  (vdvMCS1_20,  dvMCS1_20, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_20   (vdvMCS1_20,    MVP20_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 

DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM21  (vdvMCS1_21,  dvMCS1_21, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_21   (vdvMCS1_21,    MVP21_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 

DEFINE_MODULE 'Autonomic Controls MCS Comm' MCECOMM22  (vdvMCS1_22,  dvMCS1_22, cMCS1_SERVER_IP, iMCS_SERVER_PORT)
DEFINE_MODULE 'Autonomic Controls MCS UI'   MCEUI_22   (vdvMCS1_22,    MVP22_5, cMCS1_SERVER_IP, iMCS_ART_PORT) 


DEFINE_FUNCTION OFFLINE_MCE (integer num_PANEL)
 {
     IF ([VDV_MCE1[num_PANEL],1]) {off[VDV_MCE1[num_PANEL],1]}
 } 
 

DEFINE_FUNCTION ONLINE_MCE (integer num_SOURSE, integer num_PANEL)
 {
     DO_PUSH (MVP_MCE1[num_PANEL],2010+num_SOURSE)
 } 





DEFINE_START

//enable programatic page flips.
on[vdvMCS1_1,2] 
on[vdvMCS1_2,2] 
on[vdvMCS1_3,2] 
on[vdvMCS1_4,2] 
on[vdvMCS1_5,2] 
on[vdvMCS1_11,2] 
on[vdvMCS1_12,2] 
on[vdvMCS1_13,2] 
on[vdvMCS1_14,2] 
on[vdvMCS1_15,2] 
on[vdvMCS1_16,2] 
on[vdvMCS1_17,2] 
on[vdvMCS1_18,2] 
on[vdvMCS1_19,2] 
on[vdvMCS1_20,2] 
on[vdvMCS1_21,2] 
on[vdvMCS1_22,2] 
           

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[com]
{
	ONLINE:
	{
	WAIT 50 { Send_Command com, 'SET BAUD 19200,N,8,1' }
}}
  
(************************ ”œ–¿¬À≈Õ»≈ Audio Media Serverom ************************************)

// MCE1
BUTTON_EVENT [MVP_MCE1, 2001] // —onnect with MCE1
{PUSH:{
LOCAL_VAR INTEGER PANEL_NUM

PANEL_NUM = GET_LAST (MVP_MCE1)
on[VDV_MCE1[PANEL_NUM],1]
}}

BUTTON_EVENT [MVP_MCE1, 2002] // Disconnect with MCE1
{PUSH:{
LOCAL_VAR INTEGER PANEL_NUM

PANEL_NUM = GET_LAST (MVP_MCE1)

OFFLINE_MCE (PANEL_NUM)
//off[VDV_MCE1[PANEL_NUM],1]
}}



BUTTON_EVENT [MVP_MCE1, 2011]
{PUSH:{
LOCAL_VAR INTEGER PANEL_NUM

PANEL_NUM = GET_LAST (MVP_MCE1)
IF (![VDV_MCE1[PANEL_NUM],1])
{
on[VDV_MCE1[PANEL_NUM],1] Wait Wait_Qetions {
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetInstance Music_Server_A'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SubscribeEvents'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'GetMCEStatus'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetPicklistCount 8'"
}} else {
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetInstance Music_Server_A'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SubscribeEvents'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'GetMCEStatus'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetPicklistCount 8'"
}
}}

BUTTON_EVENT [MVP_MCE1, 2012]
{PUSH:{
LOCAL_VAR INTEGER PANEL_NUM

PANEL_NUM = GET_LAST (MVP_MCE1)
IF (![VDV_MCE1[PANEL_NUM],1])
{
on[VDV_MCE1[PANEL_NUM],1] Wait Wait_Qetions {
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetInstance Music_Server_B'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SubscribeEvents'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'GetMCEStatus'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetPicklistCount 8'"
}} else {
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetInstance Music_Server_B'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SubscribeEvents'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'GetMCEStatus'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetPicklistCount 8'"
}
}}

BUTTON_EVENT [MVP_MCE1, 2013]
{PUSH:{
LOCAL_VAR INTEGER PANEL_NUM

PANEL_NUM = GET_LAST (MVP_MCE1)
IF (![VDV_MCE1[PANEL_NUM],1])
{
on[VDV_MCE1[PANEL_NUM],1] Wait Wait_Qetions {
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetInstance Music_Server_C'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SubscribeEvents'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'GetMCEStatus'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetPicklistCount 8'"
}} else {
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetInstance Music_Server_C'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SubscribeEvents'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'GetMCEStatus'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetPicklistCount 8'"
}
}}


BUTTON_EVENT [MVP_MCE1, 2014]
{PUSH:{
LOCAL_VAR INTEGER PANEL_NUM

PANEL_NUM = GET_LAST (MVP_MCE1)
IF (![VDV_MCE1[PANEL_NUM],1])
{
on[VDV_MCE1[PANEL_NUM],1] Wait Wait_Qetions {
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetInstance Music_Server_D'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SubscribeEvents'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'GetMCEStatus'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetPicklistCount 8'"
}} else {
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetInstance Music_Server_D'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SubscribeEvents'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'GetMCEStatus'"
SEND_COMMAND VDV_MCE1[PANEL_NUM], "'SetPicklistCount 8'"
}
}}




(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

