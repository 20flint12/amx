MODULE_NAME='Runco_LS_4_5' (DEV DEVICE, DEV MVP[], INTEGER BUTTONS[])

DEFINE_EVENT

BUTTON_EVENT[MVP, BUTTONS[1]]{PUSH:Send_String DEVICE, "'ky pow.on', $0D"}  // ON
BUTTON_EVENT[MVP, BUTTONS[2]]{PUSH:Send_String DEVICE, "'ky pow.off', $0D"} // OFF

BUTTON_EVENT[MVP, BUTTONS[3]]{PUSH:Send_String DEVICE, "'op source.sel = 0', $0D"} // HDMI 1
BUTTON_EVENT[MVP, BUTTONS[4]]{PUSH:Send_String DEVICE, "'op source.sel = 1', $0D"} // HDMI 2
                                                                  
BUTTON_EVENT[MVP, BUTTONS[5]] {PUSH:Send_String DEVICE, "'op aspect = 0', $0D"} // 16:9
BUTTON_EVENT[MVP, BUTTONS[6]] {PUSH:Send_String DEVICE, "'op aspect = 1', $0D"} // Letterbox
BUTTON_EVENT[MVP, BUTTONS[7]] {PUSH:Send_String DEVICE, "'op aspect = 2', $0D"} // 4:3
BUTTON_EVENT[MVP, BUTTONS[8]] {PUSH:Send_String DEVICE, "'op aspect = 3', $0D"} // 4:3 Narrow
BUTTON_EVENT[MVP, BUTTONS[9]] {PUSH:Send_String DEVICE, "'op aspect = 4', $0D"} // Native      
BUTTON_EVENT[MVP, BUTTONS[10]]{PUSH:Send_String DEVICE, "'op memory = 0', $0D"} // User Memory 1
BUTTON_EVENT[MVP, BUTTONS[11]]{PUSH:Send_String DEVICE, "'op memory = 1', $0D"} // User Memory 2
BUTTON_EVENT[MVP, BUTTONS[12]]{PUSH:Send_String DEVICE, "'op memory = 2', $0D"} // ISF Day
BUTTON_EVENT[MVP, BUTTONS[13]]{PUSH:Send_String DEVICE, "'op memory = 3', $0D"} // ISF Night
                                                                                
DATA_EVENT [DEVICE]
{ONLINE:{WAIT 50 {SEND_COMMAND DEVICE,'SET BAUD 38400,N,8,1' WAIT 40 {Send_String DEVICE, "'op language = 11', $0D"}}}
} 

