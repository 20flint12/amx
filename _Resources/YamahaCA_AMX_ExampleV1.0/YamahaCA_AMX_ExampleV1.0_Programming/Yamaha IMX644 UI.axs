MODULE_NAME='Yamaha IMX644 UI'(DEV dvReal, DEV dvPanel)
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

INTEGER nButtonInputMono1Up			= 301
INTEGER nButtonInputMono1Down		= 302
INTEGER nButtonInputMono2Up			= 303
INTEGER nButtonInputMono2Down		= 304
INTEGER nButtonInputMono3Up			= 305
INTEGER nButtonInputMono3Down		= 306
INTEGER nButtonInputMono4Up			= 307
INTEGER nButtonInputMono4Down		= 308
INTEGER nButtonInputMono5Up			= 309
INTEGER nButtonInputMono5Down		= 310
INTEGER nButtonInputMono6Up			= 311
INTEGER nButtonInputMono6Down		= 312

INTEGER nButtonInputStereo1Up		= 313
INTEGER nButtonInputStereo1Down		= 314
INTEGER nButtonInputStereo2Up		= 315
INTEGER nButtonInputStereo2Down		= 316
INTEGER nButtonInputStereo3Up		= 317
INTEGER nButtonInputStereo3Down		= 318
INTEGER nButtonInputStereo4Up		= 319
INTEGER nButtonInputStereo4Down		= 320

INTEGER nButtonOutput1Up			= 321
INTEGER nButtonOutput1Down			= 322
INTEGER nButtonOutput2Up			= 323
INTEGER nButtonOutput2Down			= 324
INTEGER nButtonOutput3Up			= 325
INTEGER nButtonOutput3Down			= 326
INTEGER nButtonOutput4Up			= 327
INTEGER nButtonOutput4Down			= 328

INTEGER nButtonMemory01				= 351
INTEGER nButtonMemory02				= 352
INTEGER nButtonMemory03				= 353
INTEGER nButtonMemory04				= 354
INTEGER nButtonMemory05				= 355
INTEGER nButtonMemory06				= 356
INTEGER nButtonMemory07				= 357
INTEGER nButtonMemory08				= 358
INTEGER nButtonMemory09				= 359
INTEGER nButtonMemory10				= 360
INTEGER nButtonMemory11				= 361
INTEGER nButtonMemory12				= 362
INTEGER nButtonMemory13				= 363
INTEGER nButtonMemory14				= 364
INTEGER nButtonMemory15				= 365
INTEGER nButtonMemory16				= 366

INTEGER nButtonProductGraphic		= 501

INTEGER nLevelInputMono1			= 1
INTEGER nLevelInputMono2			= 2
INTEGER nLevelInputMono3			= 3
INTEGER nLevelInputMono4			= 4
INTEGER nLevelInputMono5			= 5
INTEGER nLevelInputMono6			= 6

INTEGER nLevelInputStereo1			= 7
INTEGER nLevelInputStereo2			= 8
INTEGER nLevelInputStereo3			= 9
INTEGER nLevelInputStereo4			= 10

INTEGER nLevelOutput1				= 11
INTEGER nLevelOutput2				= 12
INTEGER nLevelOutput3				= 13
INTEGER nLevelOutput4				= 14

INTEGER nIMXQueueMaxItems			= 100			// how many items can be stored in the queue
INTEGER nIMXQueueMaxItemLength		= 20			// max length of each item in the queue
INTEGER nTimeoutSendAck				= 20			// time before giving up waiting for an ack
INTEGER nLevelStep					= 8				// step change in level for each jab of a button

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR cGraphicOn		= false
VOLATILE CHAR cEnabled			= false
VOLATILE CHAR cConnected		= false
VOLATILE CHAR cWaitingScene		= false

VOLATILE INTEGER nIMXQStart		= 1								// where the start of the queue is withing cQueue
VOLATILE INTEGER nIMXQLength	= 0								// how many items are currently queued in cQueue
VOLATILE CHAR cIMXQReady		= false

VOLATILE INTEGER nButtonChannelUp[] = { nButtonInputMono1Up, nButtonInputMono2Up, nButtonInputMono3Up, nButtonInputMono4Up, nButtonInputMono5Up, nButtonInputMono6Up,
										nButtonInputStereo1Up, nButtonInputStereo2Up, nButtonInputStereo3Up, nButtonInputStereo4Up, 
										nButtonOutput1Up, nButtonOutput2Up, nButtonOutput3Up, nButtonOutput4Up }

VOLATILE INTEGER nButtonChannelDown[] = { nButtonInputMono1Down, nButtonInputMono2Down, nButtonInputMono3Down, nButtonInputMono4Down, nButtonInputMono5Down, nButtonInputMono6Down,
										nButtonInputStereo1Down, nButtonInputStereo2Down, nButtonInputStereo3Down, nButtonInputStereo4Down, 
										nButtonOutput1Down, nButtonOutput2Down, nButtonOutput3Down, nButtonOutput4Down }

VOLATILE INTEGER nButtonMemory[] = { nButtonMemory01, nButtonMemory02, nButtonMemory03, nButtonMemory04, nButtonMemory05, 
									nButtonMemory06, nButtonMemory07, nButtonMemory08, nButtonMemory09, nButtonMemory10, 
									nButtonMemory11, nButtonMemory12, nButtonMemory13, nButtonMemory14, nButtonMemory15, 
									nButtonMemory16 }

VOLATILE INTEGER nLevelChannel[] = { nLevelInputMono1, nLevelInputMono2, nLevelInputMono3, nLevelInputMono4, nLevelInputMono5, nLevelInputMono6, 
									nLevelInputStereo1, nLevelInputStereo2, nLevelInputStereo3, nLevelInputStereo4, 
									nLevelOutput1, nLevelOutput2, nLevelOutput3, nLevelOutput4 }

VOLATILE INTEGER nChannelLevel[14]
VOLATILE INTEGER nLastMemory

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION PanelFeedback()
{
	STACK_VAR INTEGER nCount
	//FOR (nCount = 1; nCount < 15; nCount++)		// done directly from feedback
	//{
	//	SEND_LEVEL dvPanel, nLevelChannel[nCount], 2 * nChannelLevel[nCount]
	//}
	FOR (nCount = 1; nCount < 17; nCount++)
	{
		[dvPanel, nButtonMemory[nCount]] = (nLastMemory == nCount)
	}
}

DEFINE_FUNCTION IMXQueue(CHAR cIMXQString[nIMXQueueMaxItemLength])			// this is the queue itself, adding items, sending items and timing out
{
	LOCAL_VAR CHAR cIMXQueue[nIMXQueueMaxItems][nIMXQueueMaxItemLength]		// the queue itself - a circular queue
	STACK_VAR INTEGER nIMXQTemp												// a handy calculation thing
    IF (LENGTH_STRING(cIMXQString))											// if there's something to be processed,
    {
        IF (FIND_STRING(cIMXQString, 'INIT', 1))							// if it's the initialisation command,
        {
            nIMXQStart = 1													// reset the start of the queue,
            nIMXQLength = 0													// reset the number of queued items to none
			CANCEL_WAIT 'TimeoutAck'
            cIMXQReady = true												// we're ready to send immediately
        }
        ELSE																// if it's a string to be send to dvReal,
        {
			IF (nIMXQLength < nIMXQueueMaxItems)							// if there's room in the queue,
			{
				nIMXQTemp = nIMXQStart + nIMXQLength						// find where the start of the queue is within Queue
				WHILE (nIMXQTemp > nIMXQueueMaxItems)						// if it would be past the endstop of cQueue,
				{
					nIMXQTemp = nIMXQTemp - nIMXQueueMaxItems				// go back by the length of cQueue; done this way as failsafe, should only loop once
				}
				cIMXQueue[nIMXQTemp] = "cIMXQString, $0A"					// insert the new string into the queue
				nIMXQLength = nIMXQLength + 1								// mark the queue as one item longer
			}
			ELSE
			{
				SEND_STRING 0,"'IMX (device ',ITOA(dvReal.number),':',ITOA(dvReal.port),':',ITOA(dvReal.system),') outgoing queue is full - message not added to queue'"
			}
        }
    }
    IF (nIMXQLength > 0)
	{
		IF (cIMXQReady && cConnected)										// now check to see if we can send - this happens even if there was nothing to add to the queue
		{
			SEND_STRING dvReal, cIMXQueue[nIMXQStart]						// send the first item from the queue
			nIMXQStart = nIMXQStart + 1										// step onto the second item in the queue
			WHILE (nIMXQStart > nIMXQueueMaxItems)							// if this takes us past the limits of cQueue,
			{
				nIMXQStart = nIMXQStart - nIMXQueueMaxItems					// go back by the length of cQueue; done this way as failsafe, should only loop once
			}
			nIMXQLength = nIMXQLength - 1									// mark the queue as one item shorter
			cIMXQReady = false												// now waiting for an ack, so not ready
			WAIT (nTimeoutSendAck) 'TimeoutAck'								// if no ack is received within set time,
			{
				cIMXQReady = true											// be ready to send again
			}
		}
	}
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvPanel]
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
	}
	STRING:
	{
	}
}

DATA_EVENT[dvReal]
{
	ONLINE:
	{
		SEND_COMMAND dvReal,'SET BAUD 38400,N,8,1 485 DISABLE'
		SEND_COMMAND dvReal,'HSOFF'
		cConnected = true
		CANCEL_WAIT 'TimeoutAck'
		cIMXQReady = true
	}
	OFFLINE:
	{
		cConnected = false
	}
	STRING:
	{
		LOCAL_VAR CHAR cIncoming[1000]
		STACK_VAR CHAR cMessage[1000]
		STACK_VAR INTEGER nChannel
		cIncoming = "cIncoming, data.text"
		WHILE (FIND_STRING(cIncoming, "$0A", 1))
		{
			cMessage = REMOVE_STRING(cIncoming, "$0A", 1)
			SELECT
			{
				ACTIVE(FIND_STRING(cMessage, 'VOL 0 ', 1)):
				{
					REMOVE_STRING(cMessage, 'VOL 0 ', 1)
					nChannel = ATOI(REMOVE_STRING(cMessage,' ',1)) + 1
					nChannelLevel[nChannel] = 127 - ATOI(cMessage)
					SEND_LEVEL dvPanel, nLevelChannel[nChannel], 2 * nChannelLevel[nChannel]
					IF (cWaitingScene)
					{
						IF (nChannel == 13)
						{
							CANCEL_WAIT 'TimeoutScene'
							CANCEL_WAIT 'TimeoutAck'
							cWaitingScene = false
							cIMXQReady = true
						}
					}
					ELSE
					{
						CANCEL_WAIT 'TimeoutAck'
						cIMXQReady = true
					}
				}
				ACTIVE(FIND_STRING(cMessage, 'SCN 0 ', 1)):
				{
					CANCEL_WAIT 'TimeoutAck'
					CANCEL_WAIT 'TimeoutScene'
					REMOVE_STRING(cMessage, 'SCN 0 ', 1)
					nLastMemory = ATOI(cMessage)
					cWaitingScene = true
					WAIT 30 'TimeoutScene'
					{
						cWaitingScene = false
					}
				}
				ACTIVE(1):
				{
				}
			}
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonChannelUp]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		STACK_VAR INTEGER nLevel
		TO[button.input]
		nChannel = GET_LAST(nButtonChannelUp)
		nLevel = nChannelLevel[nChannel] + nLevelStep
		IF (nLevel > 127)
		{
			nLevel = 127
		}
		IMXQueue("'SVL 0 ',ITOA(nChannel - 1),' ',ITOA(127 - nLevel)")
		nChannelLevel[nChannel] = nLevel
		SEND_LEVEL dvPanel, nLevelChannel[nChannel], 2 * nChannelLevel[nChannel]
	}
	HOLD[3, REPEAT]:
	{
		STACK_VAR INTEGER nChannel
		STACK_VAR INTEGER nLevel
		nChannel = GET_LAST(nButtonChannelUp)
		nLevel = nChannelLevel[nChannel] + nLevelStep
		IF (nLevel > 127)
		{
			nLevel = 127
		}
		IMXQueue("'SVL 0 ',ITOA(nChannel - 1),' ',ITOA(127 - nLevel)")
		nChannelLevel[nChannel] = nLevel
		SEND_LEVEL dvPanel, nLevelChannel[nChannel], 2 * nChannelLevel[nChannel]
	}
	RELEASE:
	{
	}
}

BUTTON_EVENT[dvPanel, nButtonChannelDown]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		STACK_VAR INTEGER nLevel
		TO[button.input]
		nChannel = GET_LAST(nButtonChannelDown)
		IF (nChannelLevel[nChannel] >= nLevelStep)
		{
			nLevel = nChannelLevel[nChannel] - nLevelStep
		}
		ELSE
		{
			nLevel = 0
		}
		IMXQueue("'SVL 0 ',ITOA(nChannel - 1),' ',ITOA(127 - nLevel)")
		nChannelLevel[nChannel] = nLevel
		SEND_LEVEL dvPanel, nLevelChannel[nChannel], 2 * nChannelLevel[nChannel]
	}
	HOLD[3, REPEAT]:
	{
		STACK_VAR INTEGER nChannel
		STACK_VAR INTEGER nLevel
		nChannel = GET_LAST(nButtonChannelDown)
		IF (nChannelLevel[nChannel] >= nLevelStep)
		{
			nLevel = nChannelLevel[nChannel] - nLevelStep
		}
		ELSE
		{
			nLevel = 0
		}
		IMXQueue("'SVL 0 ',ITOA(nChannel - 1),' ',ITOA(127 - nLevel)")
		nChannelLevel[nChannel] = nLevel
		SEND_LEVEL dvPanel, nLevelChannel[nChannel], 2 * nChannelLevel[nChannel]
	}
	RELEASE:
	{
	}
}

BUTTON_EVENT[dvPanel, nButtonMemory]
{
	PUSH:
	{
		STACK_VAR INTEGER nMemory
		nMemory = GET_LAST(nButtonMemory)
		IMXQueue("'RSC 0 ',ITOA(nMemory)")
		nLastMemory = nMemory
	}
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

WAIT 1
{
	IMXQueue('')
	PanelFeedback()
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
