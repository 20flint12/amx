MODULE_NAME = 'Yamaha DME Comms'(DEV dvComms, DEV dvReal)
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

CHAR cVersion[] = '1.0.0'

INTEGER nQueueMaxItems = 100						// how many items can be stored in the queue
INTEGER nQueueMaxItemLength = 50					// max length of each item in the queue
INTEGER nTimeoutSendAck = 2							// time before giving up waiting for an ack

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _Parameter
{
	DEV dvDevice									// device for virtual comms
	CHAR cType[10]									// type of control for this parameter
	CHAR cID										// number on DME remote control list
	CHAR cPoll										// true = poll this parameter, false = don't poll this parameter
	SINTEGER sMinimum								// minimum value of this (para)meter
	SINTEGER sMaximum								// maximum value of this (para)meter
	SINTEGER sValue									// current value of this parameter
	CHAR cValue										// 0-255 scaled value of this parameter
	SINTEGER sMeter[32]								// current values of this meter
	CHAR cMeter[32]									// 0-255 scaled values of this meter
	SINTEGER sHoldMeter[32]							// current values of this hold meter
	CHAR cHoldMeter[32]								// 0-255 scaled values of this hold meter
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR cWaitingFinalReply							// true: OK has been received, now awaiting the proper reply before continuing
VOLATILE INTEGER nQStart									// where the start of the queue is withing cQueue
VOLATILE INTEGER nQLength									// how many items are currently queued in cQueue
VOLATILE CHAR cPollEnabled = false							// whether to keep polling or not
VOLATILE CHAR cIPAddress[40] = ''							// IP address to communicate with DME
VOLATILE INTEGER nIPPort = 0								// IP port to communicate with DME
VOLATILE CHAR cQReady = true								// true: dvReal can be sent to; false: dvReal should not be send to
VOLATILE CHAR cConnect = false								// true: IP connection wanted; false: no IP connection wanted
VOLATILE CHAR cOldConnect = false							// true: IP connection wanted; false: no IP connection wanted
VOLATILE CHAR cConnected = false							// true: dvReal is online; false: dvReal is offline
VOLATILE DEV vdvParameter[150]								// virtual device for each AMX-controlled parameter
VOLATILE _Parameter Parameter[150]							// DME remote control parameter numbers in use
VOLATILE INTEGER nLookup[256]								// reverse lookup: translation from DME remote control parameter to AMX parameter list
VOLATILE INTEGER nCurrentPreset = 0							// last-known DME preset
VOLATILE CHAR cCurrentPresetName[100] = ''					// last-known DME preset's name
VOLATILE INTEGER nDebugLevel = 0								// level of reporting from this module
VOLATILE CHAR cPassbackOn = false							// true: incoming strings from DME are copied to dvComms; false: they aren't
VOLATILE CHAR cGlobalMuteOn = false							// true: everything's muted; false - something's live
VOLATILE INTEGER nM = 0										// handy global integer
VOLATILE INTEGER nN = 0										// handy global integer
VOLATILE INTEGER nLevel[] = { 1, 2, 3, 4, 5, 6, 7, 8}		// levels to be watched for changes
VOLATILE INTEGER nChannel[] = { 24, 25, 26, 199 }			// channels to be watched for changes
VOLATILE INTEGER nPorts[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
							11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
							21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
							31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
							41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
							51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
							61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
							71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
							81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
							91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
							101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
							111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
							121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
							131, 132, 133, 134, 135, 136, 137, 138, 139, 140,
							141, 142, 143, 144, 145, 146, 147, 148, 149, 150,
							151}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION Try()												// try to connect or disconnect, as required
{
	CANCEL_WAIT 'trying'											// stop waiting for a valid IP address/port combination
	IF (cConnect && !cConnected)									// if we're not connect but want to
	{
		WAIT_UNTIL(LENGTH_STRING(cIPAddress) && nIPPort) 'trying'	// wait until the IP addres and port are valid
		{
			IP_CLIENT_OPEN(dvReal.port,cIPAddress,nIPPort,1)		// initiate the connection
		}
	}
	ELSE IF (!cConnect && cConnected)								// if we're connected but don't want to be
	{
		IP_CLIENT_CLOSE(dvReal.port)								// attempt to terminate the connection
	}
}

DEFINE_FUNCTION Error()												// handle a connection error
{
	WAIT 20+RANDOM_NUMBER(40)										// wait a slightly variable period (friendlier for huge systems)
	{
		Try()														// attempt to connect or disconnect as required
	}
}

DEFINE_FUNCTION Queue(CHAR cQString[nQueueMaxItemLength])			// this encompasses the queue itself, adding items, sending items and timing out
{
	LOCAL_VAR CHAR cQueue[nQueueMaxItems][nQueueMaxItemLength]		// the queue itself - a circular queue
	STACK_VAR INTEGER nQTemp										// a handy calculation thing
    IF (LENGTH_STRING(cQString))									// if there's something to be processed,
    {
        IF (FIND_STRING(cQString, 'INIT', 1))						// if it's the initialisation command,
        {
            nQStart = 1												// reset the start of the queue,
            nQLength = 0											// reset the number of queued items to none
            cQReady = true											// we're ready to send immediately
        }
        ELSE														// if it's a string to be send to dvReal,
        {
			IF (nQLength < nQueueMaxItems)							// if there's room in the queue,
			{
				nQTemp = nQStart + nQLength							// find where the start of the queue is within Queue
				WHILE (nQTemp > nQueueMaxItems)						// if it would be past the endstop of cQueue,
				{
					nQTemp = nQTemp - nQueueMaxItems				// go back by the length of cQueue; done this way as failsafe, should only loop once
				}
				cQueue[nQTemp] = "cQString, $0A"					// insert the new string into the queue
				nQLength = nQLength + 1								// mark the queue as one item longer
			}
			ELSE
			{
				SEND_STRING 0,"'DME (device ',ITOA(dvReal.number),':',ITOA(dvReal.port),':',ITOA(dvReal.system),') outgoing queue is full - message not added to queue'"
			}
        }
    }
    IF (nQLength > 0)
	{
		IF (cQReady && cConnected)										// now check to see if we can send - this happens even if there was nothing to add to the queue
		{
			SEND_STRING dvReal, cQueue[nQStart]						// send the first item from the queue
			nQStart = nQStart + 1										// step onto the second item in the queue
			WHILE (nQStart > nQueueMaxItems)							// if this takes us past the limits of cQueue,
			{
				nQStart = nQStart - nQueueMaxItems						// go back by the length of cQueue; done this way as failsafe, should only loop once
			}
			nQLength = nQLength - 1										// mark the queue as one item shorter
			cQReady = false												// now waiting for an ack, so not ready
			WAIT (nTimeoutSendAck) 'TimeoutAck'							// if no ack is received within set time,
			{
				cQReady = true											// be ready to send again
			}
		}
	}
/*	ELSE
	{
		IF (cConnected && cPollEnabled)
		{
			PollSelected()
		}
	}*/
}

DEFINE_FUNCTION SetSliderValue(CHAR cID, CHAR cValue)					// set a curve table value from a slider (0 - 255) value
{
	SetCurve(cID, (1023 * cValue) / 255)
}

DEFINE_FUNCTION SetCurve(CHAR cID, INTEGER nValue)						// set a curve table value (0 - 1023)
{
	IF ((nValue >=0) && (nValue < 1024))
	{
		Queue("'SVL 0 ',ITOA(cID),' ',ITOA(nValue)")
	}
}

DEFINE_FUNCTION SetdB(CHAR cID, SINTEGER sValue)						// set a direct (dB) value (anything goes)
{
	Queue("'SPR 0 ',ITOA(cID),' ',ITOA(sValue)")
}

DEFINE_FUNCTION PolldB(CHAR cID)										// get a direct (dB) value
{
	Queue("'GPR 0 ',ITOA(cID)")
}

DEFINE_FUNCTION PollCurve(CHAR cID)										// get a curve table value
{
	Queue("'GVL 0 ',ITOA(cID)")
}

DEFINE_FUNCTION PollMeter(CHAR cID)										// get a meter value
{
	Queue("'GMT 0 ',ITOA(cID),' 0'")
}

DEFINE_FUNCTION SetPreset(INTEGER nPreset)								// set a preset (scene)
{
	Queue("'RSC 0 ',ITOA(nPreset)")
}

DEFINE_FUNCTION PollPreset()											// get the current preset (scene)
{
	Queue('GCS 0')
}

DEFINE_FUNCTION PollPresetName(INTEGER nPreset)							// get a preset (scene) name
{
	Queue("'GSN 0 ', ITOA(nPreset)")
}

DEFINE_FUNCTION SetGPIO(INTEGER nChannel, CHAR cState)
{
	IF (cState)
	{
		Queue("'SGO 0 ',ITOA(nChannel),' ON'")
	}
	ELSE
	{
		Queue("'SGO 0 ',ITOA(nChannel),' OFF'")
	}
}

DEFINE_FUNCTION SetGlobalMute(CHAR cState)								// set the global mute
{
	IF (cState == false)
	{
		Queue('SMUT 0 OFF')
	}
	ELSE
	{
		Queue('SMUT 0 ON')
	}
}

DEFINE_FUNCTION PlayWavFile(INTEGER nFile)								// play a wav file
{
	IF (nFile > 0)
	{
		Queue("'PWF 0 ', ITOA(nFile)")
	}
	ELSE
	{
		Queue('PWF 0 0')
	}
}

DEFINE_FUNCTION PollIndex(INTEGER nIndex)								// get the value for a given index
{
	IF ((nIndex > 1) && (nIndex < LENGTH_ARRAY(Parameter)))
	{
		IF (Parameter[nIndex].cID > 0)
		{
			SWITCH(Parameter[nIndex].cType)
			{
				CASE 'VOLUME':
				{
					PollCurve(Parameter[nIndex].cID)
					BREAK
				}
				CASE 'LEVEL':
				{
					PolldB(Parameter[nIndex].cID)
					BREAK
				}
				CASE 'SLIDER':
				{
					PollCurve(Parameter[nIndex].cID)
					BREAK
				}
				CASE 'STATE':
				{
					PolldB(Parameter[nIndex].cID)
					BREAK
				}
				CASE 'METER':
				{
					PollMeter(Parameter[nIndex].cID)
					BREAK
				}
				DEFAULT:
				{
				}
			}
		}
	}
}

DEFINE_FUNCTION PollSelected()											// poll all parameters which are marked for polling
{
	STACK_VAR INTEGER nCount
	IF ((nQLength == 0) && cConnected && cPollEnabled)
	{
		FOR (nCount = 1; nCount < LENGTH_ARRAY(Parameter); nCount++)
		{
			IF (Parameter[nCount].cPoll)
			{
				PollIndex(nCount)
			}
		}
	}
}

DEFINE_FUNCTION PollAll()												// poll all parameterd in our list
{
	STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < LENGTH_ARRAY(Parameter); nCount++)
	{
		IF (Parameter[nCount].cID)
		{
			PollIndex(nCount)
		}
	}
}

DEFINE_FUNCTION InitialiseParameters()
{
	STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < 151; nCount++)										// initialise our parameter table
	{
		vdvParameter[nCount] = dvComms.number:nCount:dvComms.system
		Parameter[nCount].dvDevice = vdvParameter[nCount]
		Parameter[nCount].cType=''
		Parameter[nCount].cID = 0
		Parameter[nCount].cPoll = false
		Parameter[nCount].sMinimum = 0
		Parameter[nCount].sMaximum = 1
		Parameter[nCount].sValue = 0
		Parameter[nCount].cValue = 0
		FOR (nM = 1; nM < 33; nM++)
		{
			Parameter[nCount].sMeter[nM] = 0
			Parameter[nCount].cMeter[nM] = 0
			Parameter[nCount].sHoldMeter[nM] = 0
			Parameter[nCount].cHoldMeter[nM] = 0
		}
	}
	SET_LENGTH_ARRAY(Parameter, 150)
	SET_LENGTH_ARRAY(vdvParameter, 150)
	FOR (nCount = 1; nCount < 257; nCount++)										// initialise the reverse lookup table
	{
		nLookup[nCount] = 0
	}
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

cConnect = false													// we don't want to connect until told to
cConnected = false													// assume we're not connected
Try()																// start the connection maintenance
InitialiseParameters()												// reset all parameter slots to nothing, blank, empty
Queue('INIT')														// initialise the queue

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvComms]
{
	ONLINE:															// when the main device appears online, enable lots more ports for the parameter devices
	{
		SET_VIRTUAL_PORT_COUNT (data.device, 151)
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

DATA_EVENT[dvComms.number:2:dvComms.system]							// for all the parameter devices
DATA_EVENT[dvComms.number:3:dvComms.system]
DATA_EVENT[dvComms.number:4:dvComms.system]
DATA_EVENT[dvComms.number:5:dvComms.system]
DATA_EVENT[dvComms.number:6:dvComms.system]
DATA_EVENT[dvComms.number:7:dvComms.system]
DATA_EVENT[dvComms.number:8:dvComms.system]
DATA_EVENT[dvComms.number:9:dvComms.system]
DATA_EVENT[dvComms.number:10:dvComms.system]
DATA_EVENT[dvComms.number:11:dvComms.system]
DATA_EVENT[dvComms.number:12:dvComms.system]
DATA_EVENT[dvComms.number:13:dvComms.system]
DATA_EVENT[dvComms.number:14:dvComms.system]
DATA_EVENT[dvComms.number:15:dvComms.system]
DATA_EVENT[dvComms.number:16:dvComms.system]
DATA_EVENT[dvComms.number:17:dvComms.system]
DATA_EVENT[dvComms.number:18:dvComms.system]
DATA_EVENT[dvComms.number:19:dvComms.system]
DATA_EVENT[dvComms.number:20:dvComms.system]
DATA_EVENT[dvComms.number:21:dvComms.system]
DATA_EVENT[dvComms.number:22:dvComms.system]
DATA_EVENT[dvComms.number:23:dvComms.system]
DATA_EVENT[dvComms.number:24:dvComms.system]
DATA_EVENT[dvComms.number:25:dvComms.system]
DATA_EVENT[dvComms.number:26:dvComms.system]
DATA_EVENT[dvComms.number:27:dvComms.system]
DATA_EVENT[dvComms.number:28:dvComms.system]
DATA_EVENT[dvComms.number:29:dvComms.system]
DATA_EVENT[dvComms.number:30:dvComms.system]
DATA_EVENT[dvComms.number:31:dvComms.system]
DATA_EVENT[dvComms.number:32:dvComms.system]
DATA_EVENT[dvComms.number:33:dvComms.system]
DATA_EVENT[dvComms.number:34:dvComms.system]
DATA_EVENT[dvComms.number:35:dvComms.system]
DATA_EVENT[dvComms.number:36:dvComms.system]
DATA_EVENT[dvComms.number:37:dvComms.system]
DATA_EVENT[dvComms.number:38:dvComms.system]
DATA_EVENT[dvComms.number:39:dvComms.system]
DATA_EVENT[dvComms.number:40:dvComms.system]
DATA_EVENT[dvComms.number:41:dvComms.system]
DATA_EVENT[dvComms.number:42:dvComms.system]
DATA_EVENT[dvComms.number:43:dvComms.system]
DATA_EVENT[dvComms.number:44:dvComms.system]
DATA_EVENT[dvComms.number:45:dvComms.system]
DATA_EVENT[dvComms.number:46:dvComms.system]
DATA_EVENT[dvComms.number:47:dvComms.system]
DATA_EVENT[dvComms.number:48:dvComms.system]
DATA_EVENT[dvComms.number:49:dvComms.system]
DATA_EVENT[dvComms.number:50:dvComms.system]
DATA_EVENT[dvComms.number:51:dvComms.system]
DATA_EVENT[dvComms.number:52:dvComms.system]
DATA_EVENT[dvComms.number:53:dvComms.system]
DATA_EVENT[dvComms.number:54:dvComms.system]
DATA_EVENT[dvComms.number:55:dvComms.system]
DATA_EVENT[dvComms.number:56:dvComms.system]
DATA_EVENT[dvComms.number:57:dvComms.system]
DATA_EVENT[dvComms.number:58:dvComms.system]
DATA_EVENT[dvComms.number:59:dvComms.system]
DATA_EVENT[dvComms.number:60:dvComms.system]
DATA_EVENT[dvComms.number:61:dvComms.system]
DATA_EVENT[dvComms.number:62:dvComms.system]
DATA_EVENT[dvComms.number:63:dvComms.system]
DATA_EVENT[dvComms.number:64:dvComms.system]
DATA_EVENT[dvComms.number:65:dvComms.system]
DATA_EVENT[dvComms.number:66:dvComms.system]
DATA_EVENT[dvComms.number:67:dvComms.system]
DATA_EVENT[dvComms.number:68:dvComms.system]
DATA_EVENT[dvComms.number:69:dvComms.system]
DATA_EVENT[dvComms.number:70:dvComms.system]
DATA_EVENT[dvComms.number:71:dvComms.system]
DATA_EVENT[dvComms.number:72:dvComms.system]
DATA_EVENT[dvComms.number:73:dvComms.system]
DATA_EVENT[dvComms.number:74:dvComms.system]
DATA_EVENT[dvComms.number:75:dvComms.system]
DATA_EVENT[dvComms.number:76:dvComms.system]
DATA_EVENT[dvComms.number:77:dvComms.system]
DATA_EVENT[dvComms.number:78:dvComms.system]
DATA_EVENT[dvComms.number:79:dvComms.system]
DATA_EVENT[dvComms.number:80:dvComms.system]
DATA_EVENT[dvComms.number:81:dvComms.system]
DATA_EVENT[dvComms.number:82:dvComms.system]
DATA_EVENT[dvComms.number:83:dvComms.system]
DATA_EVENT[dvComms.number:84:dvComms.system]
DATA_EVENT[dvComms.number:85:dvComms.system]
DATA_EVENT[dvComms.number:86:dvComms.system]
DATA_EVENT[dvComms.number:87:dvComms.system]
DATA_EVENT[dvComms.number:88:dvComms.system]
DATA_EVENT[dvComms.number:89:dvComms.system]
DATA_EVENT[dvComms.number:90:dvComms.system]
DATA_EVENT[dvComms.number:91:dvComms.system]
DATA_EVENT[dvComms.number:92:dvComms.system]
DATA_EVENT[dvComms.number:93:dvComms.system]
DATA_EVENT[dvComms.number:94:dvComms.system]
DATA_EVENT[dvComms.number:95:dvComms.system]
DATA_EVENT[dvComms.number:96:dvComms.system]
DATA_EVENT[dvComms.number:97:dvComms.system]
DATA_EVENT[dvComms.number:98:dvComms.system]
DATA_EVENT[dvComms.number:99:dvComms.system]
DATA_EVENT[dvComms.number:100:dvComms.system]
DATA_EVENT[dvComms.number:101:dvComms.system]
DATA_EVENT[dvComms.number:102:dvComms.system]
DATA_EVENT[dvComms.number:103:dvComms.system]
DATA_EVENT[dvComms.number:104:dvComms.system]
DATA_EVENT[dvComms.number:105:dvComms.system]
DATA_EVENT[dvComms.number:106:dvComms.system]
DATA_EVENT[dvComms.number:107:dvComms.system]
DATA_EVENT[dvComms.number:108:dvComms.system]
DATA_EVENT[dvComms.number:109:dvComms.system]
DATA_EVENT[dvComms.number:110:dvComms.system]
DATA_EVENT[dvComms.number:111:dvComms.system]
DATA_EVENT[dvComms.number:112:dvComms.system]
DATA_EVENT[dvComms.number:113:dvComms.system]
DATA_EVENT[dvComms.number:114:dvComms.system]
DATA_EVENT[dvComms.number:115:dvComms.system]
DATA_EVENT[dvComms.number:116:dvComms.system]
DATA_EVENT[dvComms.number:117:dvComms.system]
DATA_EVENT[dvComms.number:118:dvComms.system]
DATA_EVENT[dvComms.number:119:dvComms.system]
DATA_EVENT[dvComms.number:120:dvComms.system]
DATA_EVENT[dvComms.number:121:dvComms.system]
DATA_EVENT[dvComms.number:122:dvComms.system]
DATA_EVENT[dvComms.number:123:dvComms.system]
DATA_EVENT[dvComms.number:124:dvComms.system]
DATA_EVENT[dvComms.number:125:dvComms.system]
DATA_EVENT[dvComms.number:126:dvComms.system]
DATA_EVENT[dvComms.number:127:dvComms.system]
DATA_EVENT[dvComms.number:128:dvComms.system]
DATA_EVENT[dvComms.number:129:dvComms.system]
DATA_EVENT[dvComms.number:130:dvComms.system]
DATA_EVENT[dvComms.number:131:dvComms.system]
DATA_EVENT[dvComms.number:132:dvComms.system]
DATA_EVENT[dvComms.number:133:dvComms.system]
DATA_EVENT[dvComms.number:134:dvComms.system]
DATA_EVENT[dvComms.number:135:dvComms.system]
DATA_EVENT[dvComms.number:136:dvComms.system]
DATA_EVENT[dvComms.number:137:dvComms.system]
DATA_EVENT[dvComms.number:138:dvComms.system]
DATA_EVENT[dvComms.number:139:dvComms.system]
DATA_EVENT[dvComms.number:140:dvComms.system]
DATA_EVENT[dvComms.number:141:dvComms.system]
DATA_EVENT[dvComms.number:142:dvComms.system]
DATA_EVENT[dvComms.number:143:dvComms.system]
DATA_EVENT[dvComms.number:144:dvComms.system]
DATA_EVENT[dvComms.number:145:dvComms.system]
DATA_EVENT[dvComms.number:146:dvComms.system]
DATA_EVENT[dvComms.number:147:dvComms.system]
DATA_EVENT[dvComms.number:148:dvComms.system]
DATA_EVENT[dvComms.number:149:dvComms.system]
DATA_EVENT[dvComms.number:150:dvComms.system]
DATA_EVENT[dvComms.number:151:dvComms.system]
{
	ONLINE:															// when a parameter device appears online
	{
		SET_VIRTUAL_LEVEL_COUNT (data.device, 32)					// set it to have 32 levels (for metering - only needs one otherwise)
		SET_VIRTUAL_CHANNEL_COUNT (data.device, 255)				// set it to have 255 channels (this is the default anyway)
	}
}

CHANNEL_EVENT[dvComms.number:2:dvComms.system, 0]					// for all the channels on all the parameter devices
CHANNEL_EVENT[dvComms.number:3:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:4:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:5:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:6:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:7:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:8:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:9:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:10:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:11:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:12:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:13:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:14:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:15:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:16:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:17:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:18:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:19:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:20:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:21:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:22:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:23:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:24:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:25:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:26:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:27:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:28:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:29:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:30:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:31:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:32:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:33:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:34:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:35:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:36:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:37:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:38:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:39:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:40:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:41:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:42:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:43:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:44:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:45:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:46:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:47:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:48:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:49:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:50:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:51:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:52:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:53:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:54:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:55:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:56:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:57:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:58:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:59:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:60:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:61:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:62:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:63:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:64:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:65:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:66:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:67:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:68:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:69:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:70:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:71:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:72:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:73:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:74:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:75:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:76:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:77:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:78:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:79:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:80:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:81:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:82:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:83:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:84:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:85:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:86:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:87:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:88:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:89:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:90:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:91:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:92:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:93:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:94:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:95:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:96:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:97:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:98:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:99:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:100:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:101:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:102:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:103:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:104:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:105:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:106:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:107:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:108:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:109:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:110:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:111:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:112:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:113:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:114:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:115:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:116:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:117:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:118:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:119:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:120:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:121:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:122:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:123:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:124:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:125:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:126:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:127:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:128:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:129:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:130:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:131:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:132:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:133:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:134:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:135:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:136:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:137:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:138:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:139:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:140:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:141:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:142:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:143:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:144:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:145:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:146:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:147:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:148:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:149:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:150:dvComms.system, 0]
CHANNEL_EVENT[dvComms.number:151:dvComms.system, 0]
{
	ON:																// when a channel goes on (remeber this could be from the UI or from this module)
	{
		STACK_VAR INTEGER nIndex
		STACK_VAR CHAR cID
		STACK_VAR nChan
		nIndex = channel.device.port								// get the parameter slot which has changed
		cID = Parameter[nIndex].cID									// get the DME parameter ID for this slot
		nChan = channel.channel										// get the channel which has just gone on
		IF (cID > 0)												// if this is a valid DME parameter
		{
			SWITCH(nChan)											// do different things depending on which channel has just gone on
			{
				CASE 24:											// level up by one step
				{
					SWITCH(Parameter[nIndex].cType)					// treat the step up differently for each parameter type
					{
						CASE 'VOLUME':								// for a VOLUME type (range 0-1024, curve table control method, AMX control range 0-1024)
						{
							IF (Parameter[nIndex].sValue < 992)		// if the current level will take a full step up
							{
								SetCurve(cID, TYPE_CAST(Parameter[nIndex].sValue) + 32)	// bump it up by the step size
							}
							ELSE									// if the current level is too close to the max for a full step up
							{
								SetCurve(cID, 1023)					// bump it up to the max
							}
							BREAK
						}
						CASE 'LEVEL':								// for a LEVEL type (range default -13801 to 1 or manually settable, dB/direct control method, AMX control range the same)
						{
							STACK_VAR SINTEGER nStep
							nStep = (Parameter[nIndex].sMaximum - Parameter[nIndex].sMinimum) / 32	// calculate an appropriate step size
							IF (nStep == 0)							// if the step is so small it rounds down to nothing
							{
								nStep = 1							// make it the minimum possible step size
							}
							IF (Parameter[nIndex].sValue <= (Parameter[nIndex].sMaximum - nStep))	// if the current level will take a full step up
							{
								SetdB(cID, Parameter[nIndex].sValue + nStep)	// bump it up by the step size
							}
							ELSE									// if the current level is too close to the max for a full step up
							{
								SetdB(cID, Parameter[nIndex].sMaximum)	// bump it up to the max
							}
							BREAK
						}
						CASE 'SLIDER':								// for a SLIDER type (range 0-1024, curve table control method, AMX control range 0-255)
						{
							IF (Parameter[nIndex].sValue < 992)		// if the current level can take a full step up without maxing out
							{
								SetCurve(cID, TYPE_CAST(Parameter[nIndex].sValue) + 32)	// bump it up by a full step
							}
							ELSE									// if the current level would exceed the maximum level by taking a full step up
							{
								SetCurve(cID, 1023)					// bump it up to the max
							}
							BREAK
						}
						CASE 'STATE':								// for a STATE type (range 0-1, dB/direct control method, AMX control range 0-1)
						{
							SetdB(cID, 1)							// switch it on
							BREAK
						}
						CASE 'METER':								// METER type is for feedback only, so no control here
						{
						}
						DEFAULT:									// we're not interested in any other type
						{
							BREAK
						}
					}
					BREAK
				}
				CASE 25:											// level down
				{
					SWITCH(Parameter[nIndex].cType)					// do slightly different things depending on the type of control involved
					{
						CASE 'VOLUME':								// for the VOLUME type (range 0-1024, curve table control method, AMX control range 0-1024)
						{
							IF (Parameter[nIndex].sValue > 31)		// if the current level is high enough that we can take a full step down
							{
								SetCurve(cID, TYPE_CAST(Parameter[nIndex].sValue) - 32)	// take a full step down
							}
							ELSE									// if the current level is already pretty close to the minimum
							{
								SetCurve(cID, 0)					// go to the minimum
							}
							BREAK
						}
						CASE 'LEVEL':								// for a LEVEL type (range default -13801 to 1 or manually settable, dB/direct control method, AMX control range the same)
						{
							STACK_VAR SINTEGER nStep
							nStep = (Parameter[nIndex].sMaximum - Parameter[nIndex].sMinimum) / 32	// calculate a suitable step size for this parameter
							IF (nStep == 0)							// if the step is so small it rounds down to nothing
							{
								nStep = 1							// make it the minimum possible step size
							}
							IF (Parameter[nIndex].sValue >= (Parameter[nIndex].sMinimum + nStep))	// if the current level can take a full step down without eceeding its limits
							{
								SetdB(cID, Parameter[nIndex].sValue - nStep)	// take a full step down
							}
							ELSE									// if the current level can't take a full step down without breaking something
							{
								SetdB(cID, Parameter[nIndex].sMinimum)	// set it to the minimum
							}
							BREAK
						}
						CASE 'SLIDER':								// for a SLIDER type (range 0-1024, curve table control method, AMX control range 0-255)
						{
							IF (Parameter[nIndex].sValue > 31)		// if it'll take a full step down without breaking
							{
								SetCurve(cID, TYPE_CAST(Parameter[nIndex].sValue) - 32)	// take a full step down
							}
							ELSE									// if it'll break something by taking a full step down
							{
								SetCurve(cID, 0)					// just step down to the minimum level
							}
							BREAK
						}
						CASE 'STATE':								// for a STATE type (range 0-1, dB/direct control method, AMX control range 0-1)
						{
							SetdB(cID, 0)							// just switch it off
							BREAK
						}
						CASE 'METER':								// METER type is for feedback only, so no control here
						{
						}
						DEFAULT:									// we're not interested in any other type
						{
							BREAK
						}
					}
					BREAK
				}
				CASE 26:											// pulse to toggle
				{
					IF (Parameter[nIndex].sValue == Parameter[nIndex].sMinimum)	// if the current level of this parameter is at its minimum (i.e. as off as it can be)
					{
						SWITCH(Parameter[nIndex].cType)				// depending on the parameter type, do some useful stuff
						{
							CASE 'VOLUME':							// for a VOLUME type
							{
								SetCurve(cID, 1023)					// set the volume to max (ouch)
								BREAK
							}
							CASE 'LEVEL':							// for a LEVEL type
							{
								SetdB(cID, Parameter[nIndex].sMaximum)	// max it out
								BREAK
							}
							CASE 'SLIDER':							// for a SLIDER type
							{
								SetCurve(cID, 1023)					// set the volume to max (ouch again)
								BREAK
							}
							CASE 'STATE':							// for a STATE type - the only variety we really expect people to be doing this for
							{
								SetdB(cID, 1)						// switch it on
								BREAK
							}
							CASE 'METER':							// METER types are feedback only: do nothing
							{
							}
							DEFAULT:								// if there are any other types, we don't care about them
							{
								BREAK
							}
						}
					}
					ELSE											// if the parameter is currently non-zero / non-minimum / non-off / on
					{
						SWITCH(Parameter[nIndex].cType)				// do stuff relevant to this parameter's type
						{
							CASE 'VOLUME':							
							{
								SetCurve(cID, 0)
								BREAK
							}
							CASE 'LEVEL':
							{
								SetdB(cID, Parameter[nIndex].sMinimum)
								BREAK
							}
							CASE 'SLIDER':
							{
								SetCurve(cID, 0)
								BREAK
							}
							CASE 'STATE':
							{
								SetdB(cID, 0)
								BREAK
							}
							CASE 'METER':
							{
							}
							DEFAULT:
							{
								BREAK
							}
						}
					}
					BREAK
				}
				CASE 27:						// state on
				{
					SWITCH(Parameter[nIndex].cType)
					{
						CASE 'VOLUME':
						{
							IF (Parameter[nIndex].sValue != 1023)
							{
								SetCurve(cID, 1023)
							}
							BREAK
						}
						CASE 'LEVEL':
						{
							IF (Parameter[nIndex].sValue != Parameter[nIndex].sMaximum)
							{
								SetdB(cID, Parameter[nIndex].sMaximum)
							}
							BREAK
						}
						CASE 'SLIDER':
						{
							IF (Parameter[nIndex].sValue != 1023)
							{
								SetCurve(cID, 1023)
							}
							BREAK
						}
						CASE 'STATE':
						{
							IF (Parameter[nIndex].sValue != 1)
							{
								SetdB(cID, 1)
							}
							BREAK
						}
						CASE 'METER':
						{
						}
						DEFAULT:
						{
							BREAK
						}
					}
					BREAK
				}
				CASE 28:					// state off
				{
					SWITCH(Parameter[nIndex].cType)
					{
						CASE 'VOLUME':
						{
							IF (Parameter[nIndex].sValue != 0)
							{
								SetCurve(cID, 0)
							}
							BREAK
						}
						CASE 'LEVEL':
						{
							IF (Parameter[nIndex].sValue != Parameter[nIndex].sMinimum)
							{
								SetdB(cID, Parameter[nIndex].sMinimum)
							}
							BREAK
						}
						CASE 'SLIDER':
						{
							IF (Parameter[nIndex].sValue != 0)
							{
								SetCurve(cID, 0)
							}
							BREAK
						}
						CASE 'STATE':
						{
							IF (Parameter[nIndex].sValue != 0)
							{
								SetdB(cID, 0)
							}
							BREAK
						}
						CASE 'METER':
						{
						}
						DEFAULT:
						{
							BREAK
						}
					}
					BREAK
				}
				CASE 199:						// state on/off
				{
					SWITCH(Parameter[nIndex].cType)
					{
						CASE 'VOLUME':
						{
							IF (Parameter[nIndex].sValue != 1023)
							{
								SetCurve(cID, 1023)
							}
							BREAK
						}
						CASE 'LEVEL':
						{
							IF (Parameter[nIndex].sValue != Parameter[nIndex].sMaximum)
							{
								SetdB(cID, Parameter[nIndex].sMaximum)
							}
							BREAK
						}
						CASE 'SLIDER':
						{
							IF (Parameter[nIndex].sValue != 1023)
							{
								SetCurve(cID, 1023)
							}
							BREAK
						}
						CASE 'STATE':
						{
							IF (Parameter[nIndex].sValue != 1)
							{
								SetdB(cID, 1)
							}
							BREAK
						}
						CASE 'METER':
						{
						}
						DEFAULT:
						{
							BREAK
						}
					}
					BREAK
				}
				DEFAULT:
				{
					BREAK
				}
			}
		}
	}
	OFF:
	{
		STACK_VAR CHAR nIndex
		STACK_VAR CHAR cID
		nIndex = TYPE_CAST(channel.device.port)
		cID = Parameter[nIndex].cID
		IF (cID > 0)
		{
			SWITCH(channel.channel)
			{
				CASE 199:
				{
					SWITCH(Parameter[nIndex].cType)
					{
						CASE 'VOLUME':
						{
							IF (Parameter[nIndex].sValue != 0)
							{
								SetCurve(cID, 0)
							}
							BREAK
						}
						CASE 'LEVEL':
						{
							IF (Parameter[nIndex].sValue != Parameter[nIndex].sMinimum)
							{
								SetdB(cID, Parameter[nIndex].sMinimum)
							}
							BREAK
						}
						CASE 'SLIDER':
						{
							IF (Parameter[nIndex].sValue != 0)
							{
								SetCurve(cID, 0)
							}
							BREAK
						}
						CASE 'STATE':
						{
							IF (Parameter[nIndex].sValue != 0)
							{
								SetdB(cID, 0)
							}
							BREAK
						}
						CASE 'METER':
						{
						}
						DEFAULT:
						{
							BREAK
						}
					}
					BREAK
				}
				DEFAULT:
				{
					BREAK
				}
			}
		}
	}
}

LEVEL_EVENT[dvComms.number:2:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:3:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:4:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:5:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:6:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:7:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:8:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:9:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:10:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:11:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:12:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:13:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:14:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:15:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:16:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:17:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:18:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:19:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:20:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:21:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:22:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:23:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:24:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:25:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:26:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:27:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:28:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:29:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:30:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:31:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:32:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:33:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:34:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:35:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:36:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:37:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:38:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:39:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:40:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:41:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:42:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:43:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:44:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:45:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:46:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:47:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:48:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:49:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:50:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:51:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:52:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:53:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:54:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:55:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:56:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:57:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:58:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:59:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:60:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:61:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:62:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:63:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:64:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:65:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:66:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:67:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:68:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:69:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:70:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:71:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:72:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:73:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:74:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:75:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:76:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:77:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:78:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:79:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:80:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:81:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:82:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:83:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:84:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:85:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:86:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:87:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:88:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:89:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:90:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:91:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:92:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:93:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:94:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:95:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:96:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:97:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:98:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:99:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:100:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:101:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:102:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:103:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:104:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:105:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:106:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:107:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:108:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:109:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:110:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:111:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:112:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:113:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:114:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:115:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:116:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:117:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:118:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:119:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:120:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:121:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:122:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:123:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:124:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:125:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:126:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:127:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:128:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:129:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:130:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:131:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:132:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:133:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:134:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:135:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:136:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:137:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:138:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:139:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:140:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:141:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:142:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:143:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:144:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:145:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:146:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:147:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:148:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:149:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:150:dvComms.system, 1]
LEVEL_EVENT[dvComms.number:151:dvComms.system, 1]
{
	STACK_VAR INTEGER nIndex
	STACK_VAR CHAR cID
	STACK_VAR SINTEGER nVal
	nIndex = level.input.device.port
	cID = Parameter[nIndex].cID
	nVal = level.value
	IF (cID > 0)
	{
		SWITCH(Parameter[nIndex].cType)
		{
			CASE 'VOLUME':
			{
				IF (Parameter[nIndex].sValue != nVal)
				{
					SetCurve(cID, TYPE_CAST(nVal))
				}
				BREAK
			}
			CASE 'LEVEL':
			{
				IF (Parameter[nIndex].sValue != nVal)
				{
					SetdB(cID, nVal)
				}
				BREAK
			}
			CASE 'SLIDER':
			{
				IF (Parameter[nIndex].cValue != nVal)
				{
					SetCurve(cID, (1023 * TYPE_CAST(nVal)) / 255)
				}
				BREAK
			}
			CASE 'STATE':
			{
				STACK_VAR CHAR cState
				IF (Parameter[nIndex].sValue != (nVal != 0))
				{
					IF (nVal != 0)
					{
						cState = true
					}
					ELSE
					{
						cState = false
					}
					SetdB(cID, cState)
				}
				BREAK
			}
			CASE 'METER':
			{
			}
			DEFAULT:
			{
				BREAK
			}
		}
	}
}

DATA_EVENT[dvReal]
{
	ONLINE:
	{
		SEND_COMMAND dvReal,'SET BAUD 38400,N,8,1 485 DISABLE'
		cConnected = true
		Queue('INIT')
		PollPreset()
		PollAll()
	}
	OFFLINE:
	{
		cConnected = false
		Queue('INIT')
		Error()
	}
	ONERROR:
	{
		SWITCH (data.number)										// choose what to do based on the error type
		{
			CASE 9: 												// Socket closed in response to IP_CLIENT_CLOSE: well that's fine...
			{														// ... so do nothing
			}
			CASE 17: 												// String was sent to a closed socket: well that's naughty but doesn't affect the connection...
			{														// ... so we'll ignore it
			}
			DEFAULT: 												// All other errors. Something unexpected and unwanted has occurred...
			{
				Error()												// ... so handle it appropriately
			}
		}
	}
	COMMAND:
	{
	}
	STRING:
	{
		LOCAL_VAR CHAR cIncoming[1000]
		STACK_VAR CHAR cMessage[1000]
		STACK_VAR CHAR cID
		STACK_VAR INTEGER nIndex
		IF (cPassbackOn)
		{
			SEND_STRING dvComms, data.text
		}
		IF ((LENGTH_STRING(cIncoming) + LENGTH_STRING(data.text)) > MAX_LENGTH_STRING(cIncoming))
		{
			cIncoming = ''
		}
		IF (LENGTH_STRING(data.text) <= MAX_LENGTH_STRING(cIncoming))
		{
			cIncoming = "cIncoming, data.text"
		}
		WHILE (FIND_STRING(cIncoming,"$0A",1))
		{
			IF (cWaitingFinalReply)
			{
				cWaitingFinalReply = false
				CANCEL_WAIT 'TimeoutAck'								// wait no longer for an ack/nak/reply from the real equipment
				cQReady = true											// then say we're ready
			}
			cMessage = REMOVE_STRING(cIncoming,"$0A", 1);
			cMessage = LEFT_STRING(cMessage, LENGTH_STRING(cMessage) - 1)
			IF (FIND_STRING(cMessage,'OK',1) && !cQReady)				// if this is a useful reply & we're tagged as unable to send yet,
			{
				cWaitingFinalReply = true
			}
			ELSE IF (FIND_STRING(cMessage,'ERR',1) && !cQReady)
			{
				cWaitingFinalReply = false
				CANCEL_WAIT 'TimeoutAck'								// wait no longer for an ack/nak/reply from the real equipment
				cQReady = true											// then say we're ready
			}
			SELECT
			{
				ACTIVE(LEFT_STRING(cMessage, 3) == 'PRM'):
				{
					STACK_VAR SINTEGER sOldValue
					cMessage = RIGHT_STRING(cMessage, LENGTH_STRING(cMessage) - 6)
					cID = ATOI(REMOVE_STRING(cMessage, ' ', 1))
					IF ((cID > 0) && (cID < 256))
					{
						nIndex = nLookup[cID]
						IF (nIndex > 0)
						{
							IF ((Parameter[nIndex].cType == 'LEVEL') || (Parameter[nIndex].cType == 'STATE'))
							{
								sOldValue = Parameter[nIndex].sValue
								Parameter[nIndex].sValue = ATOI(cMessage)
								Parameter[nIndex].cValue = TYPE_CAST((255 * (Parameter[nIndex].sValue - Parameter[nIndex].sMinimum)) / (Parameter[nIndex].sMaximum - Parameter[nIndex].sMinimum))
								IF (sOldValue != Parameter[nIndex].sValue)
								{
									SWITCH (Parameter[nIndex].cType)
									{
										CASE 'LEVEL':
										{
											SEND_LEVEL Parameter[nIndex].dvDevice, 1, Parameter[nIndex].sValue
											BREAK
										}
										CASE 'STATE':
										{
											[Parameter[nIndex].dvDevice, 199] = (Parameter[nIndex].sValue != 0)
											BREAK
										}
										DEFAULT:
										{
											BREAK
										}
									}
								}
							}
							ELSE IF ((Parameter[nIndex].cType == 'VOLUME') || (Parameter[nIndex].cType == 'SLIDER'))
							{
								PollCurve(cID)		// if we're only using curve table for this parameter, get the value that way instead
							}
						}
					}
				}
				ACTIVE(LEFT_STRING(cMessage, 3) == 'VOL'):
				{
					STACK_VAR SINTEGER sOldValue
					cMessage = RIGHT_STRING(cMessage, LENGTH_STRING(cMessage) - 6)
					cID = ATOI(REMOVE_STRING(cMessage, ' ', 1))
					IF ((cID > 0) && (cID < 256))
					{
						nIndex = nLookup[cID]
						IF (nIndex > 0)
						{
							IF ((Parameter[nIndex].cType == 'VOLUME') || (Parameter[nIndex].cType == 'SLIDER'))
							{
								sOldValue = Parameter[nIndex].sValue
								Parameter[nIndex].sValue = ATOI(cMessage)
								Parameter[nIndex].cValue = TYPE_CAST((255 * (Parameter[nIndex].sValue - Parameter[nIndex].sMinimum)) / (Parameter[nIndex].sMaximum - Parameter[nIndex].sMinimum))
								IF (sOldValue != Parameter[nIndex].sValue)
								{
									SWITCH (Parameter[nIndex].cType)
									{
										CASE 'VOLUME':
										{
											SEND_LEVEL Parameter[nIndex].dvDevice, 1, Parameter[nIndex].sValue
											BREAK
										}
										CASE 'SLIDER':
										{
											SEND_LEVEL Parameter[nIndex].dvDevice, 1, Parameter[nIndex].cValue
											BREAK
										}
										DEFAULT:
										{
											BREAK
										}
									}
								}
							}
						}
					}
				}
				ACTIVE(LEFT_STRING(cMessage, 3) == 'SCN'):
				{
					STACK_VAR INTEGER nOldPreset
					cMessage = RIGHT_STRING(cMessage, LENGTH_STRING(cMessage) - 6)
					nOldPreset = nCurrentPreset
					nCurrentPreset = ATOI(cMessage)
					IF (nOldPreset != nCurrentPreset)
					{
						SEND_COMMAND dvComms, "'AUDIOPROCPRESET-', ITOA(nCurrentPreset)"
						PollPresetName(nCurrentPreset)
					}
				}
				ACTIVE(LEFT_STRING(cMessage, 3) == 'CSN'):
				{
					STACK_VAR INTEGER nOldPreset
					cMessage = RIGHT_STRING(cMessage, LENGTH_STRING(cMessage) - 6)
					nOldPreset = nCurrentPreset
					nCurrentPreset = ATOI(cMessage)
					IF (nOldPreset != nCurrentPreset)
					{
						SEND_COMMAND dvComms, "'AUDIOPROCPRESET-', ITOA(nCurrentPreset)"
						PollPresetName(nCurrentPreset)
					}
				}
				ACTIVE(LEFT_STRING(cMessage, 3) == 'SNM'):
				{
					STACK_VAR CHAR cOldPresetName[100]
					cMessage = RIGHT_STRING(cMessage, LENGTH_STRING(cMessage) - 6)
					cOldPresetName = cCurrentPresetName
					cCurrentPresetName = cMessage
					IF (cOldPresetName != cCurrentPresetName)
					{
						SEND_COMMAND dvComms, "'AUDIOPROCPRESETNAME-', cCurrentPresetName"
					}
				}
				ACTIVE(LEFT_STRING(cMessage, 4) == 'MUTE'):
				{
					STACK_VAR CHAR cOldGlobalMuteOn
					cMessage = RIGHT_STRING(cMessage, LENGTH_STRING(cMessage) - 7)
					cOldGlobalMuteOn = cGlobalMuteOn
					IF (FIND_STRING(cMessage, 'ON', 1))
					{
						cGlobalMuteOn = true
					}
					ELSE
					{
						cGlobalMuteOn = false
					}
					IF (cGlobalMuteOn != cOldGlobalMuteOn)
					{
						SEND_COMMAND dvComms, "'MUTE-', ITOA(cGlobalMuteOn)"
					}
				}
				ACTIVE(LEFT_STRING(cMessage, 3) == 'MTR'):
				{
					STACK_VAR SINTEGER sOldMeter[32]
					STACK_VAR CHAR cMeter[500]
					STACK_VAR CHAR cHoldMeter[500]
					STACK_VAR SINTEGER sMeter
					STACK_VAR INTEGER nCount
					cMessage = RIGHT_STRING(cMessage, LENGTH_STRING(cMessage) - 6)
					cID = ATOI(REMOVE_STRING(cMessage, ' ', 1))
					REMOVE_STRING(cMessage,' ',1)
					IF ((cID > 0) && (cID < 256))
					{
						nIndex = nLookup[cID]
						IF (nIndex > 0)
						{
							IF (LEFT_STRING(cMessage, 4) == 'CUR ')
							{
								REMOVE_STRING(cMessage, 'CUR ',1)
								cMeter = REMOVE_STRING(cMessage, 'HOLD ',1)
								cMeter = LEFT_STRING(cMeter, LENGTH_STRING(cMeter) - 5)
								cMeter = "cMeter, ' '"
								cHoldMeter = "cMessage, ' '"
								sOldMeter = Parameter[nIndex].sMeter
								nCount = 1
								WHILE (FIND_STRING(cMeter, ' ', 1))
								{
									Parameter[nIndex].sMeter[nCount] = ATOI(REMOVE_STRING(cMeter, ' ', 1))
									Parameter[nIndex].cMeter[nCount] = TYPE_CAST((255 * (Parameter[nIndex].sMeter[nCount] - Parameter[nIndex].sMinimum)) / (Parameter[nIndex].sMaximum - Parameter[nIndex].sMinimum))
									Parameter[nIndex].cMeter[nCount] = (Parameter[nIndex].cMeter[nCount] * Parameter[nIndex].cMeter[nCount]) / 255		// make it non-linear - cheap & cheerful method
									IF (Parameter[nIndex].sMeter[nCount] != sOldMeter[nCount])
									{
										SEND_LEVEL Parameter[nIndex].dvDevice, nCount, Parameter[nIndex].cMeter[nCount]
									}
									nCount++
								}
								sOldMeter = Parameter[nIndex].sHoldMeter
								nCount = 1
								WHILE (FIND_STRING(cHoldMeter, ' ', 1))
								{
									Parameter[nIndex].sHoldMeter[nCount] = ATOI(REMOVE_STRING(cHoldMeter, ' ', 1))
									Parameter[nIndex].cHoldMeter[nCount] = TYPE_CAST((255 * (Parameter[nIndex].sHoldMeter[nCount] - Parameter[nIndex].sMinimum)) / (Parameter[nIndex].sMaximum - Parameter[nIndex].sMinimum))
									nCount++
								}
							}
						}
					}
				}
				ACTIVE(true):
				{
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
		STACK_VAR INTEGER nIndex
		STACK_VAR CHAR cID
		STACK_VAR CHAR cType[10]
		STACK_VAR INTEGER nPreset
		STACK_VAR INTEGER nValue
		STACK_VAR CHAR cValue
		STACK_VAR INTEGER nLength
		STACK_VAR INTEGER nCount
		STACK_VAR CHAR cMessage[100]
		STACK_VAR SINTEGER sLower
		STACK_VAR SINTEGER sHigher
		cMessage = data.text
		SELECT
		{
			ACTIVE(LEFT_STRING(cMessage, 5) == 'POLL-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				IF (ATOI(cMessage) == 0)
				{
					cPollEnabled = false
				}
				ELSE
				{
					cPollEnabled = true
				}
			}
			ACTIVE(LEFT_STRING(cMessage, 13) == 'AUDIOPROCADD-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				nIndex = ATOI(REMOVE_STRING(cMessage,',',1))
				cID = ATOI(REMOVE_STRING(cMessage,':',1))
				IF (FIND_STRING(cMessage,',',1))
				{
					cType = REMOVE_STRING(cMessage,',',1)
					cType = LEFT_STRING(cType,LENGTH_STRING(cType)-1)
					sLower = ATOI(REMOVE_STRING(cMessage,',',1))
					sHigher = ATOI(cMessage)
				}
				ELSE
				{
					cType=cMessage
					sLower = 0
					sHigher = 0
				}
				IF ((nIndex > 1) && (nIndex < 151) && (cID > 0) && (cID < 257))
				{
					Parameter[nIndex].cType = cType
					SWITCH(cType)
					{
						CASE 'VOLUME':
						{
							Parameter[nIndex].cID = cID
							Parameter[nIndex].cPoll = false
							Parameter[nIndex].sMaximum = 1023
							Parameter[nIndex].sMinimum = 0
							Parameter[nIndex].sValue = 0
							Parameter[nIndex].cValue = 0
							FOR (nCount = 1; nCount < 33; nCount++)
							{
								Parameter[nIndex].sMeter[nCount] = 0
								Parameter[nIndex].cMeter[nCount] = 0
							}
							nLookup[cID] = nIndex
							PollCurve(cID)
							BREAK
						}
						CASE 'LEVEL':
						{
							Parameter[nIndex].cID = cID
							Parameter[nIndex].cPoll = false
							IF (sLower != sHigher)
							{
								Parameter[nIndex].sMaximum = sHigher
								Parameter[nIndex].sMinimum = sLower
							}
							ELSE
							{
								Parameter[nIndex].sMaximum = 0
								Parameter[nIndex].sMinimum = -13801
							}
							Parameter[nIndex].sValue = -13801
							Parameter[nIndex].cValue = 0
							FOR (nCount = 1; nCount < 33; nCount++)
							{
								Parameter[nIndex].sMeter[nCount] = 0
								Parameter[nIndex].cMeter[nCount] = 0
							}
							nLookup[cID] = nIndex
							PolldB(cID)
							BREAK
						}
						CASE 'SLIDER':
						{
							Parameter[nIndex].cID = cID
							Parameter[nIndex].cPoll = false
							Parameter[nIndex].sMaximum = 1023
							Parameter[nIndex].sMinimum = 0
							Parameter[nIndex].sValue = 0
							Parameter[nIndex].cValue = 0
							FOR (nCount = 1; nCount < 33; nCount++)
							{
								Parameter[nIndex].sMeter[nCount] = 0
								Parameter[nIndex].cMeter[nCount] = 0
							}
							nLookup[cID] = nIndex
							PollCurve(cID)
							BREAK
						}
						CASE 'STATE':
						{
							Parameter[nIndex].cID = cID
							Parameter[nIndex].cPoll = false
							Parameter[nIndex].sMaximum = 1
							Parameter[nIndex].sMinimum = 0
							Parameter[nIndex].sValue = 0
							Parameter[nIndex].cValue = 0
							FOR (nCount = 1; nCount < 33; nCount++)
							{
								Parameter[nIndex].sMeter[nCount] = 0
								Parameter[nIndex].cMeter[nCount] = 0
							}
							nLookup[cID] = nIndex
							PolldB(cID)
							BREAK
						}
						CASE 'METER':
						{
							Parameter[nIndex].cID = cID
							Parameter[nIndex].cPoll = true
							Parameter[nIndex].sMaximum = 0
							Parameter[nIndex].sMinimum = -13801
							Parameter[nIndex].sValue = 0
							Parameter[nIndex].cValue = 0
							FOR (nCount = 1; nCount < 33; nCount++)
							{
								Parameter[nIndex].sMeter[nCount] = 0
								Parameter[nIndex].cMeter[nCount] = 0
							}
							nLookup[cID] = nIndex
							PollMeter(cID)
							BREAK
						}
						DEFAULT:
						{
							BREAK
						}
					}
				}
			}
			ACTIVE(LEFT_STRING(cMessage, 15) == '?AUDIOPROCADDR-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				nIndex = ATOI(cMessage)
				SEND_COMMAND dvComms,"'AUDIOPROCADDR-',ITOA(nIndex),',',ITOA(Parameter[nIndex].cID),':',Parameter[nIndex].cType"
			}
			ACTIVE(LEFT_STRING(cMessage, 14) == '?AUDIOPROCIDX-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				cID = ATOI(cMessage)
				nIndex = nLookup[cID]
				SEND_COMMAND dvComms, "'AUDIOPROCADDR-',ITOA(nIndex),',',ITOA(Parameter[nIndex].cID),':',Parameter[nIndex].cType"
			}
			ACTIVE(LEFT_STRING(cMessage, 16) == 'AUDIOPROCPRESET-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue = ATOI(cMessage)
				IF ((nValue > 0) && (nValue != nCurrentPreset))
				{
					SetPreset(nValue)
				}
			}
			ACTIVE(cMessage == 'AUDIOPROCPRESET?'):
			{
				SEND_COMMAND dvComms, "'AUDIOPROCPRESET-',ITOA(nCurrentPreset)"
			}
			ACTIVE(LEFT_STRING(cMessage, 24) == 'AUDIOPROCREMOVEADDR-ALL'):
			{
				InitialiseParameters()
			}
			ACTIVE(LEFT_STRING(cMessage, 20) == 'AUDIOPROCREMOVEADDR-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				cID = ATOI(REMOVE_STRING(cMessage, ':', 1))
				cType = cMessage
				nIndex = nLookup[cID]
				IF (nIndex > 1)
				{
					Parameter[nIndex].cType=''
					Parameter[nIndex].cID = 0
					Parameter[nIndex].cPoll = false
					Parameter[nIndex].sMinimum = 0
					Parameter[nIndex].sMaximum = 1
					Parameter[nIndex].sValue = 0
					Parameter[nIndex].cValue = 0
					FOR (nCount = 1; nCount < 33; nCount++)
					{
						Parameter[nIndex].sMeter[nCount] = 0
						Parameter[nIndex].cMeter[nCount] = 0
					}
				}
				nLookup[cID] = 0
			}
			ACTIVE(LEFT_STRING(cMessage, 22) == 'AUDIOPROCREMOVEIDX-ALL'):
			{
				InitialiseParameters()
			}
			ACTIVE(LEFT_STRING(cMessage, 19) == 'AUDIOPROCREMOVEIDX-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				nIndex = ATOI(cMessage)
				IF (nIndex > 1)
				{
					cID = Parameter[nIndex].cID
					Parameter[nIndex].cType=''
					Parameter[nIndex].cID = 0
					Parameter[nIndex].cPoll = false
					Parameter[nIndex].sMinimum = 0
					Parameter[nIndex].sMaximum = 1
					Parameter[nIndex].sValue = 0
					Parameter[nIndex].cValue = 0
					FOR (nCount = 1; nCount < 33; nCount++)
					{
						Parameter[nIndex].sMeter[nCount] = 0
						Parameter[nIndex].cMeter[nCount] = 0
					}
				}
				IF (cID > 0)
				{
					nLookup[cID] = 0
				}
			}
			ACTIVE(LEFT_STRING(cMessage, 6) == 'DEBUG-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				nDebugLevel = ATOI(cMessage)
			}
			ACTIVE(cMessage == '?DEBUG'):
			{
				SEND_COMMAND dvComms, "'DEBUG-',ITOA(nDebugLevel)"
			}
			ACTIVE(LEFT_STRING(cMessage, 9) == 'PASSBACK-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				cPassbackOn = (ATOI(cMessage) != 0)
			}
			ACTIVE(LEFT_STRING(cMessage, 9) == 'PASSTHRU-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				IF (RIGHT_STRING(cMessage,1) == "$0A")
				cMessage = LEFT_STRING(cMessage, LENGTH_STRING(cMessage) - 1)
				Queue(cMessage)
			}
			ACTIVE(LEFT_STRING(cMessage, 9) == 'PROPERTY-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				SELECT
				{
					ACTIVE(UPPER_STRING(LEFT_STRING(cMessage, 11)) == 'IP_ADDRESS,'):
					{
						cConnect = false
						REMOVE_STRING(cMessage,',',1)
						cIPAddress = cMessage
					}
					ACTIVE(UPPER_STRING(LEFT_STRING(cMessage, 5)) == 'PORT,'):
					{
						cConnect = false
						REMOVE_STRING(cMessage,',',1)
						nIPPort = ATOI(cMessage)
					}
					ACTIVE(true):
					{
					}
				}
			}
			ACTIVE(LEFT_STRING(cMessage, 10) == '?PROPERTY-'):
			{
				REMOVE_STRING(cMessage, '?PROPERTY', 1)
				SELECT
				{
					ACTIVE(UPPER_STRING(LEFT_STRING(cMessage, 11)) == 'IP_ADDRESS,'):
					{
						SEND_COMMAND dvComms,"'PROPERTY-IP_Address,', cIPAddress"
					}
					ACTIVE(UPPER_STRING(LEFT_STRING(cMessage, 11)) == 'PORT,'):
					{
						SEND_COMMAND dvComms,"'PROPERTY-Port,', ITOA(nIPPort)"
					}
					ACTIVE(true):
					{
					}
				}
			}
			ACTIVE(LEFT_STRING(cMessage, 14) == 'PLAY_WAV_FILE-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue = ATOI(cMessage)
				PlayWavFile(nValue)
			}
			ACTIVE(LEFT_STRING(cMessage, 5) == 'MUTE-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue = ATOI(cMessage)
				SetGlobalMute(nValue != 0)
			}
			ACTIVE(LEFT_STRING(cMessage, 5) == 'GPIO-'):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue = ATOI(cMessage)
				REMOVE_STRING(cMessage,',',1)
				SetGPIO(nValue,(ATOI(cMessage) != 0))
			}
			ACTIVE(cMessage == 'REINIT'):
			{
				CANCEL_WAIT 'IPStart'
				Queue('INIT')
				cConnect = false
				WAIT 10 'IPStart'
				{
					cConnect = true
				}
			}
			ACTIVE(cMessage == '?VERSION'):
			{
				SEND_COMMAND dvComms,"'VERSION-', cVersion"
			}
			ACTIVE(cMessage == 'ENABLE'):
			{
				CANCEL_WAIT 'IPStart'
				Queue('INIT')
				cPollEnabled = true
				cConnect = true
			}
			ACTIVE(cMessage == 'DISABLE'):
			{
				CANCEL_WAIT 'IPStart'
				Queue('INIT')
				cPollEnabled = false
				cConnect = false
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

Queue('')														// check if anything needs to be sent from the queue
IF (cConnect != cOldConnect)									// if the main program has changed what we need to do with the connection
{
	Try()														// check if we need to do anything about the connection
	cOldConnect = cConnect
}

WAIT 2
{
	PollSelected()
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
