MODULE_NAME = 'Yamaha 01V Comms'(DEV dvComms, DEV dvReal)
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

CHAR cMidiChannel = 3
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
	Send("$F0,$43,$0F+cMidiChan,$3E,$7F,$01,$1C,$00,(nInputChannel-1)%128,$00,$00,nValue/128,nValue%128,$F7")
	GetInputFader(cMidiChan, nInputChannel)
}

DEFINE_FUNCTION GetInputFader(CHAR cMidiChan, INTEGER nInputChannel)													// get a fader value
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$7F,$01,$1C,$00,(nInputChannel-1)%128,$F7")
}

DEFINE_FUNCTION SetInputEnable(CHAR cMidiChan, INTEGER nInputChannel, CHAR cValue)										// set an enable on or off
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$7F,$01,$1A,$00,(nInputChannel-1)%128,$00,$00,$00,cValue,$F7")
	GetInputEnable(cMidiChan, nInputChannel)
}

DEFINE_FUNCTION GetInputEnable(CHAR cMidiChan, INTEGER nInputChannel)													// get an enable state
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$7F,$01,$1A,$00,(nInputChannel-1)%128,$F7")
}

DEFINE_FUNCTION GetInputMeter(CHAR cMidiChan, INTEGER nStartChannel, INTEGER nChannelCount)								// get some meter values
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$0D,$21,$00,$00,(nStartChannel-1)%128,nChannelCount/128,nChannelCount%128,$F7")		// start the meter polling
	StopMeter(cMidiChan)
}

DEFINE_FUNCTION SetOutputFader(CHAR cMidiChan, INTEGER nOutputChannel, INTEGER nValue)									// set a fader value
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$7F,$01,$4F,$00,(nOutputChannel-1)%128,$00,$00,nValue/128,nValue%128,$F7")
	GetOutputFader(cMidiChan, nOutputChannel)
}

DEFINE_FUNCTION GetOutputFader(CHAR cMidiChan, INTEGER nOutputChannel)													// get a fader value
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$7F,$01,$4F,$00,(nOutputChannel-1)%128,$F7")
}

DEFINE_FUNCTION SetOutputEnable(CHAR cMidiChan, INTEGER nOutputChannel, CHAR cValue)									// set an enable on or off
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$7F,$01,$4D,$00,(nOutputChannel-1)%128,$00,$00,$00,cValue,$F7")
	GetOutputEnable(cMidiChan, nOutputChannel)
}

DEFINE_FUNCTION GetOutputEnable(CHAR cMidiChan, INTEGER nOutputChannel)													// get an enable state
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$7F,$01,$4D,$00,(nOutputChannel-1)%128,$F7")
}

DEFINE_FUNCTION GetOutputMeter(CHAR cMidiChan, INTEGER nStartChannel, INTEGER nChannelCount)							// get some meter values
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$0D,$21,$04,$00,(nStartChannel-1)%128,nChannelCount/128,nChannelCount%128,$F7")		// start the meter polling
	StopMeter(cMidiChan)
}

DEFINE_FUNCTION StopMeter(CHAR cMidiChan)																				// stop the stream of meter values
{
	Send("$F0,$43,$2F+cMidiChan,$3E,$0D,$21,$7F,$00,$00,$00,$00,$F7")													// stop the meter polling
}

DEFINE_FUNCTION SetScene(CHAR cMidiChan, INTEGER nScene)																// recall a scene
{
	Send("$F0,$43,$0F+cMidiChan,$3E,$7F,$10,$00,$00,nScene%128,$02,$00,$F7")
}

DEFINE_FUNCTION GetScene(CHAR cMidiChan)																				// check the current scene
{
	// not implemented
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
		STACK_VAR CHAR cMessage[2000]
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
						ACTIVE(LEFT_STRING(cMessage,5) == "$43,$0F+cMidiChannel,$3E,$0D,$21"):	// meters
						{
							SWITCH(cMessage[6])
							{
								CASE 0:		// input meters
								{
									nLength = (LENGTH_STRING(cMessage) - 8)
									nStart = cMessage[8] + 1
									nCount = 1
									WHILE (nCount < nLength)
									{
										nValue1 = nStart + nCount / 2
										nValue2 = (128 * cMessage[8 + nCount]) + cMessage[9 + nCount]
										/*IF (nValue1 < 17)
										{
											SEND_LEVEL 10001:7:0, 40 + nValue1, nValue2/16
										}
										ELSE IF (nValue1 > 64)
										{
											SEND_LEVEL 10001:7:0, nValue1 - 2, nValue2/16
										}*/
										SEND_STRING dvComms,"'INPUTMETER-',ITOA(nValue1),',',ITOA(nValue2)"
										nCount = nCount + 2
									}
								}
								CASE 4:		// output meters
								{
									nLength = (LENGTH_STRING(cMessage) - 8)
									nStart = cMessage[8] + 1
									FOR (nCount = 1; nCount < nLength; nCount = nCount + 2)
									{
										nValue1 = nStart + nCount / 2
										nValue2 = (128 * cMessage[8 + nCount]) + cMessage[9 + nCount]
										/*IF (nValue1 < 3)
										{
											SEND_LEVEL 10001:7:0, 66 + nValue1, nValue2/16
										}*/
										SEND_STRING dvComms,"'OUTPUTMETER-',ITOA(nValue1),',',ITOA(nValue2)"
									}
								}
								DEFAULT:
								{
								}
							}
						}
						ACTIVE(LEFT_STRING(cMessage,5) == "$43,$0F+cMidiChannel,$3E,$7F,$01"):	// parameter
						{
							IF ((LENGTH_STRING(cMessage) == 13))
							{
								SWITCH(cMessage[6])
								{
									CASE $1A:			// input enable
									{
										nValue1 = cMessage[8] + 1
										nValue2 = (cMessage[12] == 1)
										SEND_STRING dvComms,"'INPUTENABLE-',ITOA(nValue1),',',ITOA(nValue2)"
									}
									CASE $1C:			// input fader
									{
										IF (cMessage[7] == 0)
										{
											nValue1 = cMessage[8] + 1
											nValue2 = (128 * cMessage[11]) + cMessage[12]
											SEND_STRING dvComms,"'INPUTFADER-',ITOA(nValue1),',',ITOA(nValue2)"
										}
									}
									CASE $4D:			// output enable
									{
										nValue1 = cMessage[8] + 1
										nValue2 = (cMessage[12] == 1)
										SEND_STRING dvComms,"'OUTPUTENABLE-',ITOA(nValue1),',',ITOA(nValue2)"
									}
									CASE $4F:			// output fader
									{
										IF (cMessage[7] == 0)
										{
											nValue1 = cMessage[8] + 1
											nValue2 = (128 * cMessage[11]) + cMessage[12]
											SEND_STRING dvComms,"'OUTPUTFADER-',ITOA(nValue1),',',ITOA(nValue2)"
										}
									}
									DEFAULT:
									{
									}
								}
							}
						}
						ACTIVE((LEFT_STRING(cMessage, 7) == "$43,$0F+cMidiChannel,$3E,$7F,$10,$00,$00") && (RIGHT_STRING(cMessage, 3) == "$02,$00,$F7")):
						{
							SEND_STRING dvComms,"'SCENE-',ITOA(cMessage[8])"
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
