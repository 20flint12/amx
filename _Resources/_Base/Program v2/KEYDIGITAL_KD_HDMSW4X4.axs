MODULE_NAME='KEYDIGITAL_KD_HDMSW4X4' (DEV DEVICE, DEV MVP[], INTEGER BUTTONS[][])
(*МОДУЛЬ ПОДДЕРЖИВАЕТ МОДЕЛЬ KEY DIGITAL КD-HDMSW4X4*)

DEFINE_VARIABLE



(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)

DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[DEVICE]
{
ONLINE:{WAIT 20 {SEND_COMMAND DEVICE,'SET BAUD 57600,N,8,1 485 DISABLE'}}
}

// Зона 1
// УПРАВЛЕНИЕ ВИДЕО ВХОДАМИ
BUTTON_EVENT[MVP, BUTTONS[1][1]]{PUSH: SEND_STRING DEVICE, "'SPO01SI01',$0D,$0A"} // вход 1
BUTTON_EVENT[MVP, BUTTONS[1][2]]{PUSH: SEND_STRING DEVICE, "'SPO01SI02',$0D,$0A"} // вход 2
BUTTON_EVENT[MVP, BUTTONS[1][3]]{PUSH: SEND_STRING DEVICE, "'SPO01SI03',$0D,$0A"} // вход 3
BUTTON_EVENT[MVP, BUTTONS[1][4]]{PUSH: SEND_STRING DEVICE, "'SPO01SI04',$0D,$0A"} // вход 4
                       
// Зона 2
// УПРАВЛЕНИЕ ВИДЕО ВХОДАМИ
BUTTON_EVENT[MVP, BUTTONS[2][1]]{PUSH: SEND_STRING DEVICE, "'SPO02SI01',$0D,$0A"} // вход 1
BUTTON_EVENT[MVP, BUTTONS[2][2]]{PUSH: SEND_STRING DEVICE, "'SPO02SI02',$0D,$0A"} // вход 2
BUTTON_EVENT[MVP, BUTTONS[2][3]]{PUSH: SEND_STRING DEVICE, "'SPO02SI03',$0D,$0A"} // вход 3
BUTTON_EVENT[MVP, BUTTONS[2][4]]{PUSH: SEND_STRING DEVICE, "'SPO02SI04',$0D,$0A"} // вход 4
                                                        
// Зона 3
// УПРАВЛЕНИЕ ВИДЕО ВХОДАМИ
BUTTON_EVENT[MVP, BUTTONS[3][1]] {PUSH: SEND_STRING DEVICE, "'SPO03SI01',$0D,$0A"} // вход 1
BUTTON_EVENT[MVP, BUTTONS[3][2]]{PUSH: SEND_STRING DEVICE, "'SPO03SI02',$0D,$0A"} // вход 2
BUTTON_EVENT[MVP, BUTTONS[3][3]]{PUSH: SEND_STRING DEVICE, "'SPO03SI03',$0D,$0A"} // вход 3
BUTTON_EVENT[MVP, BUTTONS[3][4]]{PUSH: SEND_STRING DEVICE, "'SPO03SI04',$0D,$0A"} // вход 4
                                                        
// Зона 4
// УПРАВЛЕНИЕ ВИДЕО ВХОДАМИ
BUTTON_EVENT[MVP, BUTTONS[4][1]]{PUSH: SEND_STRING DEVICE, "'SPO04SI01',$0D,$0A"} // вход 1
BUTTON_EVENT[MVP, BUTTONS[4][2]]{PUSH: SEND_STRING DEVICE, "'SPO04SI02',$0D,$0A"} // вход 2
BUTTON_EVENT[MVP, BUTTONS[4][3]]{PUSH: SEND_STRING DEVICE, "'SPO04SI03',$0D,$0A"} // вход 3
BUTTON_EVENT[MVP, BUTTONS[4][4]]{PUSH: SEND_STRING DEVICE, "'SPO04SI04',$0D,$0A"} // вход 4
                       
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
