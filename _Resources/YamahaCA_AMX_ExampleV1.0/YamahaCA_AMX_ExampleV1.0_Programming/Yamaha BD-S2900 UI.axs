MODULE_NAME='Yamaha BD-S2900 UI'(DEV dvReal, DEV dvPanel, CHAR cProductText[][])
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

// button numbering

INTEGER nButtonPlay					= 301
INTEGER nButtonStop					= 302
INTEGER nButtonPause				= 303
INTEGER nButtonNext					= 304
INTEGER nButtonPrevious				= 305
INTEGER nButtonForward				= 306
INTEGER nButtonReverse				= 307

INTEGER nButtonPowerToggle			= 309
INTEGER nButtonPowerOn				= 310
INTEGER nButtonPowerOff				= 311

INTEGER nButtonKeypad0				= 313
INTEGER nButtonKeypad1				= 314
INTEGER nButtonKeypad2				= 315
INTEGER nButtonKeypad3				= 316
INTEGER nButtonKeypad4				= 317
INTEGER nButtonKeypad5				= 318
INTEGER nButtonKeypad6				= 319
INTEGER nButtonKeypad7				= 320
INTEGER nButtonKeypad8				= 321
INTEGER nButtonKeypad9				= 322
INTEGER nButtonKeypadClear			= 323

INTEGER nButtonTopMenu				= 325
INTEGER nButtonPopupMenu			= 326
INTEGER nButtonSubMenu				= 327

INTEGER nButtonUp					= 329
INTEGER nButtonDown					= 330
INTEGER nButtonLeft					= 331
INTEGER nButtonRight				= 332
INTEGER nButtonOK					= 333
INTEGER nButtonReturn				= 334

INTEGER nButtonFunctions			= 336
INTEGER nButtonPIP					= 337

INTEGER nButtonRed					= 339
INTEGER nButtonGreen				= 340
INTEGER nButtonBlue					= 341
INTEGER nButtonYellow				= 342

INTEGER nButtonBDSD					= 344

INTEGER nButtonAudio				= 346
INTEGER nButtonSecondaryAudio		= 347
INTEGER nButtonSetup				= 348
INTEGER nButtonStatus				= 349
INTEGER nButtonOnScreen				= 350
INTEGER nButtonOpenClose			= 351

INTEGER nButtonProductGraphic		= 501

INTEGER nAddressMedia				= 285
INTEGER nAddressPlayer				= 286
INTEGER nAddressTrack				= 287
INTEGER nAddressTC					= 288

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR cLookup[256]
CHAR cGraphicOn					= false
CHAR cEnabled					= false
CHAR cWaitingStatusPlayer		= false
CHAR cWaitingStatusMedia		= false
CHAR cWaitingStatusTrack		= false
CHAR cWaitingStatusTC			= false
INTEGER nPlayerStatus			= $FF
INTEGER nMediaStatus			= $FF
INTEGER nTrackStatus			= 0
CHAR cTCStatus[8]				= '00:00:00'
CHAR cSearchDirection			= 1
CHAR cPowerIsOn					= false
CHAR cConnected					= false
CHAR cCommandWaiting[20]		= ''

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION PanelUpdatePlayer()
{
	SWITCH(nPlayerStatus)
	{
		CASE $00:																			// power on
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[16]"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,-'"
		}
		CASE $01:																			// standby
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[18]"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,-'"
		}
		CASE $02:																			// tray open
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[24]"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,-'"
		}
		CASE $03:																			// tray close
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[25]"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,-'"
		}
		CASE $04:																			// TOC read
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[26]"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,-'"
		}
		CASE $09:																			// no disc
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[27]"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,-'"
		}
		CASE $0B:																			// menu
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[23]"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,-'"
		}
		CASE $0D:																			// pause / resumeable stop
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[20]"
		}
		CASE $0E:																			// stop
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[19]"
		}
		CASE $10:																			// play
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[18]"
		}
		CASE $40:																			// searching forward
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[21]"
		}
		CASE $50:																			// searching backward
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[22]"
		}
		CASE $72:																			// setup
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,',cProductText[28]"
		}
		DEFAULT:																			// anybody's guess
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressPlayer),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,-'"
		}
	}
}

DEFINE_FUNCTION PanelUpdateMedia()
{
	SWITCH(nMediaStatus)
	{
		CASE 0:																				// reading
		{
			IF (nPlayerStatus == $02)
			{
				SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressMedia),',0,',cProductText[30]"
			}
			ELSE
			{
				SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressMedia),',0,',cProductText[29]"
			}
		}
		CASE 1:																				// no disc
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressMedia),',0,',cProductText[30]"
		}
		CASE 2:																				// CD
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressMedia),',0,',cProductText[31]"
		}
		CASE 3:																				// DVD
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressMedia),',0,',cProductText[32]"
		}
		CASE 4:																				// BD
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressMedia),',0,',cProductText[33]"
		}
		DEFAULT:																			// anybody's guess
		{
			SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressMedia),',0,-'"
		}
	}
}

DEFINE_FUNCTION PanelUpdateTrack()
{
	IF (nTrackStatus == 0)
	{
		SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,-'"
	}
	ELSE
	{
		SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTrack),',0,',cProductText[34],' ',ITOA(nTrackStatus)"
	}
}

DEFINE_FUNCTION PanelUpdateTC()
{
	SEND_COMMAND dvPanel,"'^TXT-',ITOA(nAddressTC),',0,',cTCStatus"
}

DEFINE_FUNCTION PanelUpdate()
{
	PanelUpdatePlayer()
	PanelUpdateMedia()
	PanelUpdateTrack()
	PanelUpdateTC()
}

DEFINE_FUNCTION PanelFeedback()
{
	//[dvPanel, nButtonPlay] = (nPlayerStatus == $10)
	//[dvPanel, nButtonStop] = (nPlayerStatus == $0E)
	//[dvPanel, nButtonPause] = (nPlayerStatus == $0D)
	//[dvPanel, nButtonForward] = (nPlayerStatus == $40)
	//[dvPanel, nButtonReverse] = (nPlayerStatus == $50)
	//[dvPanel, nButtonPowerToggle] = cPowerIsOn
	[dvPanel, nButtonPowerOn] = ((nPlayerStatus == $00) || (nPlayerStatus == $02) || (nPlayerStatus == $03) || (nPlayerStatus == $04) ||
								(nPlayerStatus == $09) || (nPlayerStatus == $0B) || (nPlayerStatus == $0D) || (nPlayerStatus == $0E) ||
								(nPlayerStatus == $10) || (nPlayerStatus == $40) || (nPlayerStatus == $50) || (nPlayerStatus == $72))
	[dvPanel, nButtonProductGraphic] = cGraphicOn
}

DEFINE_FUNCTION Send(CHAR cMessage[])
{
	IF (cConnected)
	{
		SEND_STRING dvReal, "$02,cMessage,$03"
	}
}

DEFINE_FUNCTION SendCommand(CHAR cMessage[])
{
	cCommandWaiting = cMessage
	IF (!cWaitingStatusPlayer && !cWaitingStatusMedia && !cWaitingStatusTrack && !cWaitingStatusTC)
	{
		Send(cCommandWaiting)
		cCommandWaiting=''
	}
}

DEFINE_FUNCTION GetPlayerStatus()
{
	Send('41000')
	cWaitingStatusPlayer	= true
	cWaitingStatusMedia		= false
	cWaitingStatusTrack		= false
	cWaitingStatusTC		= false
}

DEFINE_FUNCTION GetMediaStatus()
{
	Send('42000')
	cWaitingStatusPlayer	= false
	cWaitingStatusMedia		= true
	cWaitingStatusTrack		= false
	cWaitingStatusTC		= false
}

DEFINE_FUNCTION GetTrackStatus()
{
	Send('43000')
	cWaitingStatusPlayer	= false
	cWaitingStatusMedia		= false
	cWaitingStatusTrack		= true
	cWaitingStatusTC		= false
}

DEFINE_FUNCTION GetTCStatus()
{
	Send('44000')
	cWaitingStatusPlayer	= false
	cWaitingStatusMedia		= false
	cWaitingStatusTrack		= false
	cWaitingStatusTC		= true
}

DEFINE_FUNCTION Poll()
{
	IF (cEnabled)
	{
		GetPlayerStatus()
	}
}

DEFINE_FUNCTION LookupInit()
{
	STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < 257; nCount++)
	{
		cLookup[nCount] = $FF
	}
	cLookup[$30] = $00
	cLookup[$31] = $01
	cLookup[$32] = $02
	cLookup[$33] = $03
	cLookup[$34] = $04
	cLookup[$35] = $05
	cLookup[$36] = $06
	cLookup[$37] = $07
	cLookup[$38] = $08
	cLookup[$39] = $09
	cLookup[$41] = $0A
	cLookup[$42] = $0B
	cLookup[$43] = $0C
	cLookup[$44] = $0D
	cLookup[$45] = $0E
	cLookup[$46] = $0F
	SET_LENGTH_STRING(cLookup,256)
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

LookupInit()

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvPanel]
{
	ONLINE:
	{
		PanelUpdate()
	}
	OFFLINE:
	{
	}
	ONERROR:
	{
	}
	COMMAND:
	{
	}
	STRING:
	{
	}
}

BUTTON_EVENT[dvPanel, nButtonPlay]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C82')
	}
}

BUTTON_EVENT[dvPanel, nButtonStop]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C85')
	}
}

BUTTON_EVENT[dvPanel, nButtonPause]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C83')
	}
}

BUTTON_EVENT[dvPanel, nButtonNext]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CBA')
	}
}

BUTTON_EVENT[dvPanel, nButtonPrevious]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CB9')
	}
}

BUTTON_EVENT[dvPanel, nButtonForward]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C87')
	}
}

BUTTON_EVENT[dvPanel, nButtonReverse]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C86')
	}
}

BUTTON_EVENT[dvPanel, nButtonPowerToggle]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C80')
	}
}

BUTTON_EVENT[dvPanel, nButtonPowerOn]
{
	PUSH:
	{
		SendCommand('07CF6')
	}
}

BUTTON_EVENT[dvPanel, nButtonPowerOff]
{
	PUSH:
	{
		SendCommand('07CF7')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad0]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C93')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad1]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C94')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad2]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C95')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad3]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C96')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad4]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C97')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad5]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C98')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad6]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C99')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad7]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C9A')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad8]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C9B')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypad9]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C9C')
	}
}

BUTTON_EVENT[dvPanel, nButtonKeypadClear]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C9F')
	}
}

BUTTON_EVENT[dvPanel, nButtonTopMenu]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CB1')
	}
}

BUTTON_EVENT[dvPanel, nButtonPopupMenu]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CCF')
	}
}

BUTTON_EVENT[dvPanel, nButtonSubMenu]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CD0')
	}
}

BUTTON_EVENT[dvPanel, nButtonUp]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CB4')
	}
	HOLD[2,REPEAT]:
	{
		SendCommand('07CB4')
	}
}

BUTTON_EVENT[dvPanel, nButtonDown]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CB3')
	}
	HOLD[2,REPEAT]:
	{
		SendCommand('07CB3')
	}
}

BUTTON_EVENT[dvPanel, nButtonLeft]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CB5')
	}
	HOLD[2,REPEAT]:
	{
		SendCommand('07CB5')
	}
}

BUTTON_EVENT[dvPanel, nButtonRight]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CB6')
	}
	HOLD[2,REPEAT]:
	{
		SendCommand('07CB6')
	}
}

BUTTON_EVENT[dvPanel, nButtonOK]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CB8')
	}
}

BUTTON_EVENT[dvPanel, nButtonReturn]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CB7')
	}
}

BUTTON_EVENT[dvPanel, nButtonFunctions]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CE8')
	}
}

BUTTON_EVENT[dvPanel, nButtonPIP]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CED')
	}
}

BUTTON_EVENT[dvPanel, nButtonRed]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CE9')
	}
}

BUTTON_EVENT[dvPanel, nButtonGreen]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CEA')
	}
}

BUTTON_EVENT[dvPanel, nButtonBlue]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CEB')
	}
}

BUTTON_EVENT[dvPanel, nButtonYellow]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CEC')
	}
}

BUTTON_EVENT[dvPanel, nButtonBDSD]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CEF')
	}
}

BUTTON_EVENT[dvPanel, nButtonAudio]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CAD')
	}
}

BUTTON_EVENT[dvPanel, nButtonSecondaryAudio]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CAE')
	}
}

BUTTON_EVENT[dvPanel, nButtonSetup]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CAC')
	}
}

BUTTON_EVENT[dvPanel, nButtonStatus]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CA8')
	}
}

BUTTON_EVENT[dvPanel, nButtonOnScreen]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07CA6')
	}
}

BUTTON_EVENT[dvPanel, nButtonOpenClose]
{
	PUSH:
	{
		TO[button.input]
		SendCommand('07C81')
	}
}

BUTTON_EVENT[dvPanel,nButtonProductGraphic]
{
	PUSH:
	{
		CANCEL_WAIT 'graphic'
		cGraphicOn = !cGraphicOn
		IF (cGraphicOn)
		{
			WAIT 600 'graphic'
			{
				cGraphicOn = false
			}
		}
	}
}

DATA_EVENT[dvReal]
{
	ONLINE:
	{
		SEND_COMMAND dvReal,'SET BAUD 9600,N,8,1 485 DISABLE'
		SEND_COMMAND dvReal,'HSOFF'
		cConnected = true
		cEnabled = true
	}
	OFFLINE:
	{
		cConnected = false
	}
	STRING:
	{
		LOCAL_VAR CHAR cIncoming[1000]
		STACK_VAR CHAR cMessage[1000]
		STACK_VAR CHAR cByteSource
		STACK_VAR CHAR cByteGuard
		STACK_VAR CHAR cByteType
		STACK_VAR CHAR cByteCMD0
		STACK_VAR CHAR cByteCMD1
		STACK_VAR CHAR cByteCMD2
		STACK_VAR CHAR cTemp[3][2]
		cIncoming = "cIncoming, data.text"
		WHILE(FIND_STRING(cIncoming, "$03", 8))
		{
			cMessage = LEFT_STRING(cIncoming, FIND_STRING(cIncoming, "$03", 8))
			cIncoming=RIGHT_STRING(cIncoming, LENGTH_STRING(cIncoming) - LENGTH_STRING(cMessage))
			WHILE((FIND_STRING(cMessage, "$02", 1) < (LENGTH_STRING(cMessage) - 6)) && (FIND_STRING(cMessage, "$02", 1) != 0))
			{
				REMOVE_STRING(cMessage, "$02", 1)
			}
			IF (LENGTH_STRING(cMessage) == 7)
			{
				cByteSource	= cMessage[1]
				cByteGuard	= cMessage[2]
				cByteType	= cMessage[3]
				cByteCMD0	= cMessage[4]
				cByteCMD1	= cMessage[5]
				cByteCMD2	= cMessage[6]
				IF (cByteguard == $30)
				{
					SELECT
					{
						ACTIVE((cByteSource == $30) && (cByteType == $30)):		// system status, apparently not supported
						{
						}
						ACTIVE((cByteSource == $40) && (cByteType == $34)):		// player/media/track/TC status reply
						{
							SELECT
							{
								ACTIVE(cWaitingStatusPlayer && (cByteCMD0 == $30)):
								{
									cWaitingStatusPlayer = false
									nPlayerStatus = (16 * cLookup[cByteCMD1]) + cLookup[cByteCMD2]
									PanelUpdatePlayer()
									IF (cCommandWaiting != '')
									{
										Send(cCommandWaiting)
										cCommandWaiting=''
									}
									ELSE
									{
										GetMediaStatus()
									}
								}
								ACTIVE(cWaitingStatusMedia):
								{
									cWaitingStatusMedia = false
									nMediaStatus = cLookup[cByteCMD2]
									PanelUpdateMedia()
									IF (cCommandWaiting != '')
									{
										Send(cCommandWaiting)
										cCommandWaiting=''
									}
									ELSE
									{
										IF (nMediaStatus == 2)	// if there's a CD loaded
										{
											GetTrackStatus()
										}
										ELSE
										{
											nTrackStatus = 0
											PanelUpdateTrack()
											IF ((nPlayerStatus == $0D) || (nPlayerStatus == $0E) || (nPlayerStatus == $10) || (nPlayerStatus == $40) || (nPlayerStatus == $50))
											{
												GetTCStatus()
											}
											ELSE
											{
												cTCStatus = '-'
												PanelUpdateTC()
											}
										}
									}
								}
								ACTIVE(cWaitingStatusTrack):
								{
									cWaitingStatusTrack = false
									nTrackStatus = cByteCMD2;
									PanelUpdateTrack()
									IF (cCommandWaiting != '')
									{
										Send(cCommandWaiting)
										cCommandWaiting=''
									}
									ELSE
									{
										IF ((nPlayerStatus == $0D) || (nPlayerStatus == $0E) || (nPlayerStatus == $10) || (nPlayerStatus == $40) || (nPlayerStatus == $50))
										{
											GetTCStatus();
										}
										ELSE
										{
											cTCStatus = '-'
											PanelUpdateTC()
										}
									}
								}
								ACTIVE(cWaitingStatusTC):
								{
									cWaitingStatusTC = false
									cTemp[1]="ITOA(cByteCMD0)"
									WHILE (LENGTH_STRING(cTemp[1]) < 2)
									{
										cTemp[1] = "'0',cTemp[1]"
									}
									cTemp[2]="ITOA(cByteCMD1)"
									WHILE (LENGTH_STRING(cTemp[2]) < 2)
									{
										cTemp[2] = "'0',cTemp[2]"
									}
									cTemp[3]="ITOA(cByteCMD2)"
									WHILE (LENGTH_STRING(cTemp[3]) < 2)
									{
										cTemp[3] = "'0',cTemp[3]"
									}
									cTCStatus = "cTemp[1],':',cTemp[2],':',cTemp[3]"
									PanelUpdateTC()
									IF (cCommandWaiting != '')
									{
										Send(cCommandWaiting)
										cCommandWaiting=''
									}
								}
								ACTIVE(1):
								{
								}
							}
						}
						ACTIVE(cByteType == $30):					// remote control
						{
							SEND_STRING 0, "'Yamaha BD-S2900: remote control [',ITOHEX(cByteCMD0),' ',ITOHEX(cByteCMD1),'] received'"
						}
						ACTIVE(1):
						{
						}
					}
				}
			}
		}
	}
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

WAIT 1
{
	PanelFeedback()
}

WAIT 5
{
	Poll()
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
