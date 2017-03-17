MODULE_NAME='Runco_LS_100' (DEV DEVICE, DEV MVP[], INTEGER BUTTONS[])

DEFINE_EVENT

BUTTON_EVENT[MVP, BUTTONS[1]]{PUSH:Send_String DEVICE, "'(PWR=1)', $0D"} // ON
BUTTON_EVENT[MVP, BUTTONS[2]]{PUSH:Send_String DEVICE, "'(PWR=0)', $0D"} // OFF
                                                   
BUTTON_EVENT[MVP, BUTTONS[3]]{PUSH:Send_String DEVICE, "'(INS=7)', $0D"} // HDMI 1
BUTTON_EVENT[MVP, BUTTONS[4]]{PUSH:Send_String DEVICE, "'(INS=8)', $0D"} // HDMI 2
                                                                  
BUTTON_EVENT[MVP, BUTTONS[5]] {PUSH:Send_String DEVICE, "'(ASP=0)', $0D"} // 4:3
BUTTON_EVENT[MVP, BUTTONS[6]] {PUSH:Send_String DEVICE, "'(ASP=1)', $0D"} // 16:9
BUTTON_EVENT[MVP, BUTTONS[7]] {PUSH:Send_String DEVICE, "'(ASP=2)', $0D"} // Letterbox
BUTTON_EVENT[MVP, BUTTONS[8]] {PUSH:Send_String DEVICE, "'(ASP=3)', $0D"} // VirtualWide
BUTTON_EVENT[MVP, BUTTONS[9]] {PUSH:Send_String DEVICE, "'(ASP=4)', $0D"} // Cinema
BUTTON_EVENT[MVP, BUTTONS[10]]{PUSH:Send_String DEVICE, "'(ASP=5)', $0D"} // Virtual Cinema
BUTTON_EVENT[MVP, BUTTONS[11]]{PUSH:Send_String DEVICE, "'(ASP=6)', $0D"} // Native             
BUTTON_EVENT[MVP, BUTTONS[12]]{PUSH:Send_String DEVICE, "'(MMP=0)', $0D"} // ISF Night    
BUTTON_EVENT[MVP, BUTTONS[13]]{PUSH:Send_String DEVICE, "'(MMP=1)', $0D"} // ISF Day    
BUTTON_EVENT[MVP, BUTTONS[14]]{PUSH:Send_String DEVICE, "'(MMP=2)', $0D"} // Custom 1    
BUTTON_EVENT[MVP, BUTTONS[15]]{PUSH:Send_String DEVICE, "'(MMP=3)', $0D"} // Custom 2                  
                                                                                
DATA_EVENT [DEVICE]
{ONLINE:{WAIT 50 {SEND_COMMAND DEVICE,'SET BAUD 19200,N,8,1' WAIT 40 {Send_String DEVICE, "'(LAN=9)', $0D"}}}
} 

