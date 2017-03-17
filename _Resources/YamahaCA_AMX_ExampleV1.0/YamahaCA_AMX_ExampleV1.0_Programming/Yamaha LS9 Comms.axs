MODULE_NAME = 'Yamaha LS9 Comms'(DEV dvComms, DEV dvReal)
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

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR cMidiChannel = 1
CHAR cConnected = false								// true: dvReal is online; false: dvReal is offline
CHAR cIncoming[10000] = ''							// buffer for incoming data
CHAR cEnabled = false

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION Send(CHAR cData[])																						// send a message to the mixer, if it's connected
{
	IF (cConnected)
	{
		SEND_STRING dvReal, cData
	}
}

DEFINE_FUNCTION SetInputFader(CHAR cMidiChan, INTEGER nInputChannel, INTEGER nValue)									// set a fader value
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$12,$01,$00,$33,$00,$00,(nInputChannel-1)/128,(nInputChannel-1)%128,$00,$00,$00,nValue/128,nValue%128,$F7")
	GetInputFader(cMidiChan, nInputChannel)
}

DEFINE_FUNCTION GetInputFader(CHAR cMidiChan, INTEGER nInputChannel)													// get a fader value
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$12,$01,$00,$33,$00,$00,(nInputChannel-1)/128,(nInputChannel-1)%128,$F7")
}

DEFINE_FUNCTION SetInputEnable(CHAR cMidiChan, INTEGER nInputChannel, CHAR cValue)										// set an enable on or off
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$12,$01,$00,$31,$00,$00,(nInputChannel-1)/128,(nInputChannel-1)%128,$00,$00,$00,$00,cValue,$F7")
	GetInputEnable(cMidiChan, nInputChannel)
}

DEFINE_FUNCTION GetInputEnable(CHAR cMidiChan, INTEGER nInputChannel)													// get an enable state
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$12,$01,$00,$31,$00,$00,(nInputChannel-1)/128,(nInputChannel-1)%128,$F7")
}

DEFINE_FUNCTION GetInputMeter(CHAR cMidiChan, INTEGER nStartChannel, INTEGER nChannelCount)								// get some meter values
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$12,$21,$00,$00,(nStartChannel-1)%128,nChannelCount/128,nChannelCount%128,$F7")		// start the meter polling
}

DEFINE_FUNCTION SetOutputFader(CHAR cMidiChan, INTEGER nOutputChannel, INTEGER nValue)									// set a fader value
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$12,$01,$00,$6D,$00,$00,(nOutputChannel-1)/128,(nOutputChannel-1)%128,$00,$00,$00,nValue/128,nValue%128,$F7")
	GetOutputFader(cMidiChan, nOutputChannel)
}

DEFINE_FUNCTION GetOutputFader(CHAR cMidiChan, INTEGER nOutputChannel)													// get a fader value
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$12,$01,$00,$6D,$00,$00,(nOutputChannel-1)/128,(nOutputChannel-1)%128,$F7")
}

DEFINE_FUNCTION SetOutputEnable(CHAR cMidiChan, INTEGER nOutputChannel, CHAR cValue)									// set an enable on or off
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$12,$01,$00,$6B,$00,$00,(nOutputChannel-1)/128,(nOutputChannel-1)%128,$00,$00,$00,$00,cValue,$F7")
	GetOutputEnable(cMidiChan, nOutputChannel)
}

DEFINE_FUNCTION GetOutputEnable(CHAR cMidiChan, INTEGER nOutputChannel)													// get an enable state
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$12,$01,$00,$6B,$00,$00,(nOutputChannel-1)/128,(nOutputChannel-1)%128,$F7")
}

DEFINE_FUNCTION GetOutputMeter(CHAR cMidiChan, INTEGER nStartChannel, INTEGER nChannelCount)							// get some meter values
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$12,$21,$03,$03,(nStartChannel-1)%128,nChannelCount/128,nChannelCount%128,$F7")
}

DEFINE_FUNCTION StopMeter(CHAR cMidiChan)																				// stop the stream of meter values
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$12,$21,$7F,$00,$00,$00,$00,$F7")													// stop the meter polling
}

DEFINE_FUNCTION SetScene(CHAR cMidiChan, INTEGER nScene)																// recall a scene
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$12,$00,'LibRcl__SCENE___',nScene/128,nScene%128,$04,$00,$F7")
}

DEFINE_FUNCTION GetScene(CHAR cMidiChan)																				// check the current scene
{
	// not implemented
}

DEFINE_FUNCTION SetTransport(CHAR cMidiChan, INTEGER cValue)															// control the recorder - MMC because parameter change doesn't work
{
	Send("$F0,$7F,cMidiChan-1,$06,cValue,$F7")
	//Send("$F0,$43,$0F+cMidiChan,$3E,$12,$01,$00,$1B,$00,$01,$00,$00,$00,$00,$00,$00,cValue-1,$F7")					// parameter change format - not implemented
}

DEFINE_FUNCTION SetTrack(CHAR cMidiChan, INTEGER cValue)																// control the recorder - MMC because parameter change doesn't work
{
	Send("$F3,cValue-1")
}

DEFINE_FUNCTION GetTransport(CHAR cMidiChan)																			// get the recorder state
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$12,$01,$00,$1B,$00,$01,$00,$00,$F7")
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

cConnected=0														// assume we're not connected

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvReal]
{
	ONLINE:
	{
		cConnected = true
	}
	OFFLINE:
	{
		cConnected = false
	}
	ONERROR:
	{
	}
	COMMAND:
	{
	}
	STRING:
	{
		LOCAL_VAR CHAR cIncoming[2000]
		STACK_VAR CHAR cMessage[100]
		STACK_VAR INTEGER nValue1
		STACK_VAR INTEGER nValue2
		STACK_VAR INTEGER nCount
		STACK_VAR INTEGER nStart
		STACK_VAR INTEGER nLength
		IF (cEnabled)
		{
			IF ((LENGTH_STRING(cIncoming) + LENGTH_STRING(data.text)) > MAX_LENGTH_STRING(cIncoming))
			{
				cIncoming = ''
			}
			IF (LENGTH_STRING(data.text) <= MAX_LENGTH_STRING(cIncoming))
			{
				cIncoming = "cIncoming, data.text"
			}
			WHILE (FIND_STRING(cIncoming,"$F7",1))
			{
				cMessage = REMOVE_STRING(cIncoming,"$F7", 1);
				WHILE (FIND_STRING(cMessage,"$F0",1))
				{
					REMOVE_STRING(cMessage,"$F0",1)
				}
				IF (LENGTH_STRING(cMessage) > 9)
				{
					SELECT
					{
						ACTIVE(LEFT_STRING(cMessage,5) == "$43,$0F+cMidiChannel,$3E,$12,$21"):	// meters
						{
							SWITCH(cMessage[6])
							{
								CASE 0:		// input meters
								{
									nLength=LENGTH_STRING(cMessage) - 8
									nStart = cMessage[8]
									nCount = 1;
									WHILE (nLength > nCount)
									{
										nValue1 = nStart + nCount
										nValue2 = cMessage[8 + nCount]
										SEND_STRING dvComms,"'INPUTMETER-',ITOA(nValue1),',',ITOA(nValue2)"
										nCount++
									}
								}
								CASE 3:		// output meters
								{
									nLength=LENGTH_STRING(cMessage) - 8
									nStart = cMessage[8]
									nCount = 1;
									WHILE (nLength > nCount)
									{
										nValue1 = nStart + nCount
										nValue2 = cMessage[8 + nCount]
										SEND_STRING dvComms,"'OUTPUTMETER-',ITOA(nValue1),',',ITOA(nValue2)"
										nCount++
									}
								}
								DEFAULT:
								{
								}
							}
						}
						ACTIVE(LEFT_STRING(cMessage,6) == "$43,$0F+cMidiChannel,$3E,$12,$01,$00"):
						{
							IF ((LENGTH_STRING(cMessage) == 17))
							{
								SWITCH(cMessage[7])
								{
									CASE $1B:			// recorder transport
									{
										IF (cMessage[9] == 1)
										{
											nValue1 = (128 * cMessage[15]) + cMessage[16] + 1
											SWITCH(nValue1)
											{
												CASE 1:
												{
													SEND_STRING dvComms,'TRANSPORT-PLAY'
												}
												CASE 2:
												{
													SEND_STRING dvComms,'TRANSPORT-STOP'
												}
												DEFAULT:
												{
													SEND_STRING dvComms,"'TRANSPORT-TRACK',ITOA(nValue1-2)"
												}
											}
										}
									}
									CASE $31:			// input enable
									{
										nValue1 = (128 * cMessage[10]) + cMessage[11] + 1
										nValue2 = (cMessage[16] == 1)
										SEND_STRING dvComms,"'INPUTENABLE-',ITOA(nValue1),',',ITOA(nValue2)"
									}
									CASE $33:			// input fader
									{
										nValue1 = (128 * cMessage[10]) + cMessage[11] + 1
										nValue2 = (128 * cMessage[15]) + cMessage[16]
										SEND_STRING dvComms,"'INPUTFADER-',ITOA(nValue1),',',ITOA(nValue2)"
									}
									CASE $6B:			// output enable
									{
										nValue1 = (128 * cMessage[10]) + cMessage[11] + 1
										nValue2 = (cMessage[16] == 1)
										SEND_STRING dvComms,"'OUTPUTENABLE-',ITOA(nValue1),',',ITOA(nValue2)"
									}
									CASE $6D:			// output fader
									{
										nValue1 = (128 * cMessage[10]) + cMessage[11] + 1
										nValue2 = (128 * cMessage[15]) + cMessage[16]
										SEND_STRING dvComms,"'OUTPUTFADER-',ITOA(nValue1),',',ITOA(nValue2)"
									}
									DEFAULT:
									{
									}
								}
							}
						}
						ACTIVE(LENGTH_STRING(cMessage) == 26):
						{
							IF (LEFT_STRING(cMessage,21) == "$43,$0F+cMidiChannel,$3E,$12,$00,'LibRcl__SCENE___'")
							{
								SEND_STRING dvComms,"'SCENE-',ITOA((128*cMessage[22])+cMessage[23])"
							}
						}
						ACTIVE(true):
						{
						}
					}
				}
			}
		}
	}
}

DATA_EVENT[dvComms]
{
	ONLINE:
	{
	}
	OFFLINE:
	{
	}
	ONERROR:
	{
	}
	COMMAND:
	{
		STACK_VAR CHAR cMessage[100]
		STACK_VAR INTEGER nValue1
		STACK_VAR INTEGER nValue2
		cMessage = data.text
		SELECT
		{
			ACTIVE(FIND_STRING(cMessage,'SETINPUTFADER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025) && (nValue2 >= 0) && (nValue2 < 1024))
				{
					SetInputFader(cMidiChannel,nValue1,nValue2)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'GETINPUTFADER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025))
				{
					GetInputFader(cMidiChannel,nValue1)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'SETINPUTENABLE-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025) && (nValue2 >= 0) && (nValue2 < 2))
				{
					SetInputEnable(cMidiChannel,nValue1,TYPE_CAST(nValue2))
				}
			}
			ACTIVE(FIND_STRING(cMessage,'GETINPUTENABLE-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025))
				{
					GetInputEnable(cMidiChannel,nValue1)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'GETINPUTMETER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025) && (nValue2 >0) && (nValue2 < 1025))
				{
					GetInputMeter(cMidiChannel,nValue1,nValue2)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'SETOUTPUTFADER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025) && (nValue2 >= 0) && (nValue2 < 1024))
				{
					SetOutputFader(cMidiChannel,nValue1,nValue2)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'GETOUTPUTFADER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025))
				{
					GetOutputFader(cMidiChannel,nValue1)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'SETOUTPUTENABLE-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025) && (nValue2 >= 0) && (nValue2 < 2))
				{
					SetOutputEnable(cMidiChannel,nValue1,TYPE_CAST(nValue2))
				}
			}
			ACTIVE(FIND_STRING(cMessage,'GETOUTPUTENABLE-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025))
				{
					GetOutputEnable(cMidiChannel,nValue1)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'GETOUTPUTMETER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025) && (nValue2 >0) && (nValue2 < 1025))
				{
					GetOutputMeter(cMidiChannel,nValue1,nValue2)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'STOPMETER',1)):
			{
				StopMeter(cMIDIchannel)
			}
			ACTIVE(FIND_STRING(cMessage,'SETSCENE-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				IF ((nValue1 >= 0) && (nValue1 < 301))
				{
					SetScene(cMidiChannel,nValue1)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'GETSCENE',1)):
			{
				GetScene(cMidiChannel)
			}
			ACTIVE(FIND_STRING(cMessage,'PLAY',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025))
				{
					SetTrack(cMidiChannel,nValue1)
				}
				SetTransport(cMidiChannel,2)
			}
			ACTIVE(FIND_STRING(cMessage,'STOP',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				SetTransport(cMidiChannel,1)
			}
			ACTIVE(FIND_STRING(cMessage,'PAUSE',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				SetTransport(cMidiChannel,9)
			}
			ACTIVE(FIND_STRING(cMessage,'RECORD',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				SetTransport(cMidiChannel,6)
			}
			ACTIVE(FIND_STRING(cMessage,'GETTRANSPORT',1)):
			{
				GetTransport(cMidiChannel)
			}
			ACTIVE(FIND_STRING(cMessage,'SETTRACK-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				IF ((nValue1 > 0) && (nValue1 < 1025))
				{
					SetTrack(cMidiChannel,nValue1)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'SETMIDICHANNEL-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				IF ((nValue1 > 0) &&(nValue1 < 17))
				{
					cMidiChannel=TYPE_CAST(nValue1)
				}
			}
			ACTIVE(FIND_STRING(cMessage,'INIT',1)):
			{
				cIncoming=''
			}
			ACTIVE(FIND_STRING(cMessage,'ENABLE',1)):
			{
				cIncoming=''
				cEnabled=true
			}
			ACTIVE(FIND_STRING(cMessage,'DISABLE',1)):
			{
				cEnabled=false
				cIncoming=''
			}
			ACTIVE(true):
			{
			}
		}
	}
	STRING:
	{
	}
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
