MODULE_NAME='Yamaha 01V UI'(DEV dvComms, DEV dvPanel)
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

INTEGER nButtonInput1On				= 301
INTEGER nButtonInput2On				= 302
INTEGER nButtonInput3On				= 303
INTEGER nButtonInput4On				= 304
INTEGER nButtonInput5On				= 305
INTEGER nButtonInput6On				= 306
INTEGER nButtonInput7On				= 307
INTEGER nButtonInput8On				= 308
INTEGER nButtonInput9On				= 309
INTEGER nButtonInput10On			= 310
INTEGER nButtonInput11On			= 311
INTEGER nButtonInput12On			= 312
INTEGER nButtonInput13On			= 313
INTEGER nButtonInput14On			= 314
INTEGER nButtonInput15On			= 315
INTEGER nButtonInput16On			= 316
INTEGER nButtonInputStereo1On		= 333
INTEGER nButtonInputStereo2On		= 334

INTEGER nButtonInput1Up				= 341
INTEGER nButtonInput2Up				= 342
INTEGER nButtonInput3Up				= 343
INTEGER nButtonInput4Up				= 344
INTEGER nButtonInput5Up				= 345
INTEGER nButtonInput6Up				= 346
INTEGER nButtonInput7Up				= 347
INTEGER nButtonInput8Up				= 348
INTEGER nButtonInput9Up				= 349
INTEGER nButtonInput10Up			= 350
INTEGER nButtonInput11Up			= 351
INTEGER nButtonInput12Up			= 352
INTEGER nButtonInput13Up			= 353
INTEGER nButtonInput14Up			= 354
INTEGER nButtonInput15Up			= 355
INTEGER nButtonInput16Up			= 356
INTEGER nButtonInputStereo1Up		= 373
INTEGER nButtonInputStereo2Up		= 374

INTEGER nButtonInput1Down			= 391
INTEGER nButtonInput2Down			= 392
INTEGER nButtonInput3Down			= 393
INTEGER nButtonInput4Down			= 394
INTEGER nButtonInput5Down			= 395
INTEGER nButtonInput6Down			= 396
INTEGER nButtonInput7Down			= 397
INTEGER nButtonInput8Down			= 398
INTEGER nButtonInput9Down			= 399
INTEGER nButtonInput10Down			= 400
INTEGER nButtonInput11Down			= 401
INTEGER nButtonInput12Down			= 402
INTEGER nButtonInput13Down			= 403
INTEGER nButtonInput14Down			= 404
INTEGER nButtonInput15Down			= 405
INTEGER nButtonInput16Down			= 406
INTEGER nButtonInputStereo1Down		= 423
INTEGER nButtonInputStereo2Down		= 424

INTEGER nButtonOutputOn				= 431
INTEGER nButtonOutputUp				= 432
INTEGER nButtonOutputDown			= 433

INTEGER nButtonScene1Recall			= 451
INTEGER nButtonScene2Recall			= 452
INTEGER nButtonScene3Recall			= 453
INTEGER nButtonScene4Recall			= 454
INTEGER nButtonScene5Recall			= 455
INTEGER nButtonScene6Recall			= 456
INTEGER nButtonScene7Recall			= 457
INTEGER nButtonScene8Recall			= 458
INTEGER nButtonScene9Recall			= 459
INTEGER nButtonScene10Recall		= 460
INTEGER nButtonScene11Recall		= 461
INTEGER nButtonScene12Recall		= 462
INTEGER nButtonScene13Recall		= 463
INTEGER nButtonScene14Recall		= 464
INTEGER nButtonScene15Recall		= 465

INTEGER nButtonRecorderPlay			= 481
INTEGER nButtonRecorderStop			= 482
INTEGER nButtonRecorderPause		= 483

INTEGER nButtonRecorderRecord		= 488

INTEGER nButtonRecorderTrack1		= 491
INTEGER nButtonRecorderTrack2		= 492
INTEGER nButtonRecorderTrack3		= 493
INTEGER nButtonRecorderTrack4		= 494
INTEGER nButtonRecorderTrack5		= 495
INTEGER nButtonRecorderTrack6		= 496
INTEGER nButtonRecorderTrack7		= 497
INTEGER nButtonRecorderTrack8		= 498
INTEGER nButtonRecorderTrack9		= 499
INTEGER nButtonRecorderTrack10		= 500

INTEGER nButtonProductGraphic		= 501

INTEGER nLevelInput1Fader			= 1
INTEGER nLevelInput2Fader			= 2
INTEGER nLevelInput3Fader			= 3
INTEGER nLevelInput4Fader			= 4
INTEGER nLevelInput5Fader			= 5
INTEGER nLevelInput6Fader			= 6
INTEGER nLevelInput7Fader			= 7
INTEGER nLevelInput8Fader			= 8
INTEGER nLevelInput9Fader			= 9
INTEGER nLevelInput10Fader			= 10
INTEGER nLevelInput11Fader			= 11
INTEGER nLevelInput12Fader			= 12
INTEGER nLevelInput13Fader			= 13
INTEGER nLevelInput14Fader			= 14
INTEGER nLevelInput15Fader			= 15
INTEGER nLevelInput16Fader			= 16

INTEGER nLevelInputStereo1Fader		= 33
INTEGER nLevelInputStereo2Fader		= 34

INTEGER nLevelOutputFader			= 37

INTEGER nLevelInput1Bargraph		= 41
INTEGER nLevelInput2Bargraph		= 42
INTEGER nLevelInput3Bargraph		= 43
INTEGER nLevelInput4Bargraph		= 44
INTEGER nLevelInput5Bargraph		= 45
INTEGER nLevelInput6Bargraph		= 46
INTEGER nLevelInput7Bargraph		= 47
INTEGER nLevelInput8Bargraph		= 48
INTEGER nLevelInput9Bargraph		= 49
INTEGER nLevelInput10Bargraph		= 50
INTEGER nLevelInput11Bargraph		= 51
INTEGER nLevelInput12Bargraph		= 52
INTEGER nLevelInput13Bargraph		= 53
INTEGER nLevelInput14Bargraph		= 54
INTEGER nLevelInput15Bargraph		= 55
INTEGER nLevelInput16Bargraph		= 56

INTEGER nLevelInputStereo1LBargraph	= 63
INTEGER nLevelInputStereo1RBargraph	= 64
INTEGER nLevelInputStereo2LBargraph	= 65
INTEGER nLevelInputStereo2RBargraph	= 66
INTEGER nLevelOutputLBargraph		= 67
INTEGER nLevelOutputRBargraph		= 68

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

INTEGER nButtonInputOn[]		= { nButtonInput1On, nButtonInput2On, nButtonInput3On, nButtonInput4On, nButtonInput5On, nButtonInput6On, nButtonInput7On, nButtonInput8On,
									nButtonInput9On, nButtonInput10On, nButtonInput11On, nButtonInput12On, nButtonInput13On, nButtonInput14On, nButtonInput15On, nButtonInput16On }
INTEGER nButtonInputUp[]		= { nButtonInput1Up, nButtonInput2Up, nButtonInput3Up, nButtonInput4Up, nButtonInput5Up, nButtonInput6Up, nButtonInput7Up, nButtonInput8Up,
									nButtonInput9Up, nButtonInput10Up, nButtonInput11Up, nButtonInput12Up, nButtonInput13Up, nButtonInput14Up, nButtonInput15Up, nButtonInput16Up }
INTEGER nButtonInputDown[]		= { nButtonInput1Down, nButtonInput2Down, nButtonInput3Down, nButtonInput4Down, nButtonInput5Down, nButtonInput6Down, nButtonInput7Down, nButtonInput8Down,
									nButtonInput9Down, nButtonInput10Down, nButtonInput11Down, nButtonInput12Down, nButtonInput13Down, nButtonInput14Down, nButtonInput15Down, nButtonInput16Down }
INTEGER nButtonSceneRecall[]	= { nButtonScene1Recall, nButtonScene2Recall, nButtonScene3Recall, nButtonScene4Recall, nButtonScene5Recall, 
									nButtonScene6Recall, nButtonScene7Recall, nButtonScene8Recall, nButtonScene9Recall, nButtonScene10Recall,
									nButtonScene11Recall, nButtonScene12Recall, nButtonScene13Recall, nButtonScene14Recall, nButtonScene15Recall }
INTEGER nButtonRecorderTrack[]	= { nButtonRecorderTrack1, nButtonRecorderTrack2, nButtonRecorderTrack3, nButtonRecorderTrack4, nButtonRecorderTrack5, 
									nButtonRecorderTrack6, nButtonRecorderTrack7, nButtonRecorderTrack8, nButtonRecorderTrack9, nButtonRecorderTrack10 }
INTEGER nLevelInputFader[]		= { nLevelInput1Fader, nLevelInput2Fader, nLevelInput3Fader, nLevelInput4Fader, nLevelInput5Fader, nLevelInput6Fader, nLevelInput7Fader, nLevelInput8Fader, 
									nLevelInput9Fader, nLevelInput10Fader, nLevelInput11Fader, nLevelInput12Fader, nLevelInput13Fader, nLevelInput14Fader, nLevelInput15Fader, nLevelInput16Fader }
INTEGER nLevelInputBargraph[]	= { nLevelInput1bargraph, nLevelInput2bargraph, nLevelInput3bargraph, nLevelInput4bargraph, nLevelInput5bargraph, nLevelInput6bargraph, nLevelInput7bargraph, nLevelInput8bargraph, 
									nLevelInput9bargraph, nLevelInput10bargraph, nLevelInput11bargraph, nLevelInput12bargraph, nLevelInput13bargraph, nLevelInput14bargraph, nLevelInput15bargraph, nLevelInput16bargraph }


CHAR cInputOn[]					= { false, false, false, false, false, false, false, false,
									false, false, false, false, false, false, false, false }
CHAR cInputStereoOn[]			= { false, false }
CHAR cOutputOn					= false
INTEGER nInputFader[]			= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
INTEGER nInputStereoFader[]		= { 0, 0 }
INTEGER nOutputFader			= 0
INTEGER nGlobalSceneLoaded		= 0
CHAR cGraphicOn					= false
CHAR cEnabled					= false
CHAR cPollOn					= true
INTEGER nFaderRepeatTime		= 2
INTEGER nFaderStep				= 48
INTEGER nFaderMaxStep			// derived at startup
INTEGER nFaderMinStep			// derived at startup

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION PanelFeedback()
{
	STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < 16; nCount++)
	{
		[dvPanel, nButtonSceneRecall[nCount]] = (nGlobalSceneLoaded == nCount)
	}
	[dvPanel, nButtonProductGraphic] = cGraphicOn
}

DEFINE_FUNCTION GetAllValues()
{
	CANCEL_WAIT 'getting full poll'
	SetPoll(false)
	SEND_COMMAND dvComms,'GETINPUTFADER-1'
	SEND_COMMAND dvComms,'GETINPUTFADER-2'
	SEND_COMMAND dvComms,'GETINPUTFADER-3'
	SEND_COMMAND dvComms,'GETINPUTFADER-4'
	SEND_COMMAND dvComms,'GETINPUTFADER-5'
	SEND_COMMAND dvComms,'GETINPUTFADER-6'
	SEND_COMMAND dvComms,'GETINPUTFADER-7'
	SEND_COMMAND dvComms,'GETINPUTFADER-8'
	SEND_COMMAND dvComms,'GETINPUTFADER-9'
	SEND_COMMAND dvComms,'GETINPUTFADER-10'
	SEND_COMMAND dvComms,'GETINPUTFADER-11'
	SEND_COMMAND dvComms,'GETINPUTFADER-12'
	SEND_COMMAND dvComms,'GETINPUTFADER-13'
	SEND_COMMAND dvComms,'GETINPUTFADER-14'
	SEND_COMMAND dvComms,'GETINPUTFADER-15'
	SEND_COMMAND dvComms,'GETINPUTFADER-16'
	SEND_COMMAND dvComms,'GETINPUTFADER-33'
	SEND_COMMAND dvComms,'GETINPUTFADER-35'
	SEND_COMMAND dvComms,'GETINPUTENABLE-1'
	SEND_COMMAND dvComms,'GETINPUTENABLE-2'
	SEND_COMMAND dvComms,'GETINPUTENABLE-3'
	SEND_COMMAND dvComms,'GETINPUTENABLE-4'
	SEND_COMMAND dvComms,'GETINPUTENABLE-5'
	SEND_COMMAND dvComms,'GETINPUTENABLE-6'
	SEND_COMMAND dvComms,'GETINPUTENABLE-7'
	SEND_COMMAND dvComms,'GETINPUTENABLE-8'
	SEND_COMMAND dvComms,'GETINPUTENABLE-9'
	SEND_COMMAND dvComms,'GETINPUTENABLE-10'
	SEND_COMMAND dvComms,'GETINPUTENABLE-11'
	SEND_COMMAND dvComms,'GETINPUTENABLE-12'
	SEND_COMMAND dvComms,'GETINPUTENABLE-13'
	SEND_COMMAND dvComms,'GETINPUTENABLE-14'
	SEND_COMMAND dvComms,'GETINPUTENABLE-15'
	SEND_COMMAND dvComms,'GETINPUTENABLE-16'
	SEND_COMMAND dvComms,'GETINPUTENABLE-33'
	SEND_COMMAND dvComms,'GETINPUTENABLE-35'
	SEND_COMMAND dvComms,'GETOUTPUTFADER-1'
	SEND_COMMAND dvComms,'GETOUTPUTENABLE-1'
	WAIT 10 'getting full poll'
	{
		SetPoll(true)
	}
}

DEFINE_FUNCTION PollInputMeters()
{
	IF (cPollOn && cEnabled)
	{
		SEND_COMMAND dvComms,'GETINPUTMETER-1,16'
	}
}

DEFINE_FUNCTION PollInputStereoMeters()
{
	IF (cPollOn && cEnabled)
	{
		SEND_COMMAND dvComms,'GETINPUTMETER-33,4'
	}
}

DEFINE_FUNCTION PollOutputMeters()
{
	IF (cPollOn && cEnabled)
	{
		SEND_COMMAND dvComms,'GETOUTPUTMETER-1,2'
	}
}

DEFINE_FUNCTION Poll()
{
	PollInputMeters()
	PollInputStereoMeters()
	PollOutputMeters()
}

DEFINE_FUNCTION SetPoll(CHAR cState)
{
	IF (cState)
	{
		cPollOn = true
		PollInputMeters()
	}
	ELSE
	{
		cPollOn = false
		SEND_COMMAND dvComms,'STOPMETERS'
	}
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

nFaderMaxStep = 1024 - nFaderStep
nFaderMinStep = nFaderStep - 1

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

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
		SELECT
		{
			ACTIVE(LEFT_STRING(data.text,6) == 'ENABLE'):
			{
				cGraphicOn = false
				cEnabled = true
				SetPoll(true)
			}
			ACTIVE(FIND_STRING(data.text,'DISABLE',1)):
			{
				cGraphicOn = false
				cEnabled = false
				SetPoll(false)
			}
			ACTIVE(FIND_STRING(data.text,'PAGE-',1)):
			{
				cGraphicOn = false
				GetAllValues()
			}
		}
	}
	STRING:
	{
		STACK_VAR CHAR cMessage[200]
		STACK_VAR INTEGER nValue1
		STACK_VAR INTEGER nValue2
		cMessage=data.text
		SELECT
		{
			ACTIVE(FIND_STRING(cMessage,'TRANSPORT-',1)):
			{
			}
			ACTIVE(FIND_STRING(cMessage,'INPUTENABLE-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				SWITCH(nValue1)
				{
					CASE 33:
					CASE 34:
					{
						cInputStereoOn[1]=(nValue2 != 0)
						[dvPanel,nButtonInputStereo1On]=cInputStereoOn[1]
					}
					CASE 35:
					CASE 36:
					{
						cInputStereoOn[2]=(nValue2 != 0)
						[dvPanel,nButtonInputStereo2On]=cInputStereoOn[2]
					}
					DEFAULT:
					{
						IF ((nValue1 > 0) && (nValue1 < 17))
						{
							cInputOn[nValue1] = (nValue2 != 0)
							[dvPanel,nButtonInputOn[nValue1]]=cInputOn[nValue1]
						}
					}
				}
			}
			ACTIVE(FIND_STRING(cMessage,'INPUTFADER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				SWITCH(nValue1)
				{
					CASE 33:
					CASE 34:
					{
						nInputStereoFader[1]=nValue2
						SEND_LEVEL dvPanel, nLevelInputStereo1Fader, nValue2/4
					}
					CASE 35:
					CASE 36:
					{
						nInputStereoFader[2]=nValue2
						SEND_LEVEL dvPanel, nLevelInputStereo2Fader, nValue2/4
					}
					DEFAULT:
					{
						IF ((nValue1 > 0) && (nValue1 < 17))
						{
							nInputFader[nValue1] = nValue2
							SEND_LEVEL dvPanel, nLevelInputFader[nValue1], nValue2/4
						}
					}
				}
			}
			ACTIVE(FIND_STRING(cMessage,'INPUTMETER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				SWITCH(nValue1)
				{
					CASE 33:
					{
						SEND_LEVEL dvPanel, nLevelInputStereo1LBargraph, nValue2 / 16
					}
					CASE 34:
					{
						SEND_LEVEL dvPanel, nLevelInputStereo1RBargraph, nValue2 / 16
					}
					CASE 35:
					{
						SEND_LEVEL dvPanel, nLevelInputStereo2LBargraph, nValue2 / 16
					}
					CASE 36:
					{
						SEND_LEVEL dvPanel, nLevelInputStereo2RBargraph, nValue2 / 16
						PollOutputMeters()
					}
					CASE 16:
					{
						SEND_LEVEL dvPanel, nLevelInputBargraph[nValue1], nValue2 / 16
						PollInputStereoMeters()
					}
					DEFAULT:
					{
						IF ((nValue1 > 0) && (nValue1 < 17))
						{
							SEND_LEVEL dvPanel, nLevelInputBargraph[nValue1], nValue2 / 16
						}
					}
				}
			}
			ACTIVE(FIND_STRING(cMessage,'OUTPUTENABLE-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				SWITCH(nValue1)
				{
					CASE 1:
					CASE 2:
					{
						cOutputOn=(nValue2 != 0)
						[dvPanel,nButtonOutputOn]=cOutputOn
					}
					DEFAULT:
					{
					}
				}
			}
			ACTIVE(FIND_STRING(cMessage,'OUTPUTFADER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				SWITCH(nValue1)
				{
					CASE 1:
					CASE 2:
					{
						nOutputFader=nValue2
						SEND_LEVEL dvPanel, nLevelOutputFader, nValue2/4
					}
					DEFAULT:
					{
					}
				}
			}
			ACTIVE(FIND_STRING(cMessage,'OUTPUTMETER-',1)):
			{
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(REMOVE_STRING(cMessage,',',1))
				nValue2=ATOI(cMessage)
				SWITCH(nValue1)
				{
					CASE 1:
					{
						SEND_LEVEL dvPanel, nLevelOutputLBargraph, nValue2 / 16
					}
					CASE 2:
					{
						SEND_LEVEL dvPanel, nLevelOutputRBargraph, nValue2 / 16
					}
					DEFAULT:
					{
					}
				}
			}
			ACTIVE(FIND_STRING(cMessage,'SCENE-',1)):
			{
				SetPoll(false)
				REMOVE_STRING(cMessage,'-',1)
				nValue1=ATOI(cMessage)
				nGlobalSceneLoaded=nValue1
				WAIT 3
				{
					GetAllValues()
				}
			}
			ACTIVE(true):
			{
			}
		}
	}
}

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

BUTTON_EVENT[dvPanel, nButtonInputOn]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		nChannel = GET_LAST(nButtonInputOn)
		SEND_COMMAND dvComms,"'SETINPUTENABLE-',ITOA(nChannel),',',ITOA(!cInputOn[nChannel])"
	}
}

BUTTON_EVENT[dvPanel, nButtonInputUp]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		SetPoll(false)
		TO[button.input]
		nChannel = GET_LAST(nButtonInputUp)
		IF (nInputFader[nChannel] < nFaderMaxStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-',ITOA(nChannel),',',ITOA(nInputFader[nChannel] + nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-',ITOA(nChannel),',1023'"
		}
	}
	HOLD[nFaderRepeatTime, REPEAT]:
	{
		STACK_VAR INTEGER nChannel
		nChannel = GET_LAST(nButtonInputUp)
		IF (nInputFader[nChannel] < nFaderMaxStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-',ITOA(nChannel),',',ITOA(nInputFader[nChannel] + nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-',ITOA(nChannel),',1023'"
		}
	}
	RELEASE:
	{
		SetPoll(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonInputDown]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		SetPoll(false)
		TO[button.input]
		nChannel = GET_LAST(nButtonInputDown)
		IF (nInputFader[nChannel] > nFaderMinStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-',ITOA(nChannel),',',ITOA(nInputFader[nChannel] - nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-',ITOA(nChannel),',0'"
		}
	}
	HOLD[nFaderRepeatTime, REPEAT]:
	{
		STACK_VAR INTEGER nChannel
		nChannel = GET_LAST(nButtonInputDown)
		IF (nInputFader[nChannel] > nFaderMinStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-',ITOA(nChannel),',',ITOA(nInputFader[nChannel] - nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-',ITOA(nChannel),',0'"
		}
	}
	RELEASE:
	{
		SetPoll(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonInputStereo1On]
{
	PUSH:
	{
		SEND_COMMAND dvComms,"'SETINPUTENABLE-33,',ITOA(!cInputStereoOn[1])"
	}
}

BUTTON_EVENT[dvPanel, nButtonInputStereo2On]
{
	PUSH:
	{
		SEND_COMMAND dvComms,"'SETINPUTENABLE-35,',ITOA(!cInputStereoOn[2])"
	}
}

BUTTON_EVENT[dvPanel, nButtonInputStereo1Up]
{
	PUSH:
	{
		SetPoll(false)
		TO[button.input]
		IF (nInputStereoFader[1] < nFaderMaxStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-33,',ITOA(nInputStereoFader[1] + nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-33,1023'"
		}
	}
	HOLD[nFaderRepeatTime, REPEAT]:
	{
		IF (nInputStereoFader[1] < nFaderMaxStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-33,',ITOA(nInputStereoFader[1] + nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-33,1023'"
		}
	}
	RELEASE:
	{
		SetPoll(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonInputStereo2Up]
{
	PUSH:
	{
		SetPoll(false)
		TO[button.input]
		IF (nInputStereoFader[2] < nFaderMaxStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-35,',ITOA(nInputStereoFader[2] + nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-35,1023'"
		}
	}
	HOLD[nFaderRepeatTime, REPEAT]:
	{
		IF (nInputStereoFader[2] < nFaderMaxStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-35,',ITOA(nInputStereoFader[2] + nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-35,1023'"
		}
	}
	RELEASE:
	{
		SetPoll(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonInputStereo1Down]
{
	PUSH:
	{
		SetPoll(false)
		TO[button.input]
		IF (nInputStereoFader[1] > nFaderMinStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-33,',ITOA(nInputStereoFader[1] - nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-33,0'"
		}
	}
	HOLD[nFaderRepeatTime, REPEAT]:
	{
		IF (nInputStereoFader[1] > nFaderMinStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-33,',ITOA(nInputStereoFader[1] - nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-33,0'"
		}
	}
	RELEASE:
	{
		SetPoll(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonInputStereo2Down]
{
	PUSH:
	{
		SetPoll(false)
		TO[button.input]
		IF (nInputStereoFader[2] > nFaderMinStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-35,',ITOA(nInputStereoFader[2] - nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-35,0'"
		}
	}
	HOLD[nFaderRepeatTime, REPEAT]:
	{
		IF (nInputStereoFader[2] > nFaderMinStep)
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-35,',ITOA(nInputStereoFader[2] - nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETINPUTFADER-35,0'"
		}
	}
	RELEASE:
	{
		SetPoll(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonOutputOn]
{
	PUSH:
	{
		SEND_COMMAND dvComms,"'SETOUTPUTENABLE-1,',ITOA(!cOutputOn)"
	}
}

BUTTON_EVENT[dvPanel, nButtonOutputUp]
{
	PUSH:
	{
		SetPoll(false)
		TO[button.input]
		IF (nOutputFader < nFaderMaxStep)
		{
			SEND_COMMAND dvComms,"'SETOUTPUTFADER-1,',ITOA(nOutputFader + nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETOUTPUTFADER-1,1023'"
		}
	}
	HOLD[nFaderRepeatTime, REPEAT]:
	{
		IF (nOutputFader < nFaderMaxStep)
		{
			SEND_COMMAND dvComms,"'SETOUTPUTFADER-1,',ITOA(nOutputFader + nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETOUTPUTFADER-1,1023'"
		}
	}
	RELEASE:
	{
		SetPoll(true)
	}
}

BUTTON_EVENT[dvPanel, nButtonOutputDown]
{
	PUSH:
	{
		SetPoll(false)
		TO[button.input]
		IF (nOutputFader > nFaderMinStep)
		{
			SEND_COMMAND dvComms,"'SETOUTPUTFADER-1,',ITOA(nOutputFader - nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETOUTPUTFADER-1,0'"
		}
	}
	HOLD[nFaderRepeatTime, REPEAT]:
	{
		IF (nOutputFader > nFaderMinStep)
		{
			SEND_COMMAND dvComms,"'SETOUTPUTFADER-1,',ITOA(nOutputFader - nFaderStep)"
		}
		ELSE
		{
			SEND_COMMAND dvComms,"'SETOUTPUTFADER-1,0'"
		}
	}
	RELEASE:
	{
		SetPoll(true)
	}
}

BUTTON_EVENT[dvPanel,nButtonSceneRecall]
{
	PUSH:
	{
		STACK_VAR INTEGER nScene
		SetPoll(false)
		nScene=GET_LAST(nButtonSceneRecall)
		SetPoll(false)
		SEND_COMMAND dvComms,"'SETSCENE-',ITOA(nScene)"
		nGlobalSceneLoaded=nScene
		WAIT 3
		{
			GetAllValues()
		}
	}
}

BUTTON_EVENT[dvPanel,nButtonRecorderPlay]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms,'SETTRANSPORT-PLAY'
	}
}

BUTTON_EVENT[dvPanel,nButtonRecorderStop]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms,'SETTRANSPORT-STOP'
	}
}

BUTTON_EVENT[dvPanel,nButtonRecorderPause]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms,'SETTRANSPORT-PAUSE'
	}
}

BUTTON_EVENT[dvPanel,nButtonRecorderRecord]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms,'SETTRANSPORT-RECORD'
	}
}

BUTTON_EVENT[dvPanel,nButtonRecorderTrack]
{
	PUSH:
	{
		STACK_VAR INTEGER nTrack
		TO[button.input]
		nTrack=GET_LAST(nButtonRecorderTrack)
		SEND_COMMAND dvComms,"'SETTRACK-',ITOA(nTrack)"
	}
}

BUTTON_EVENT[dvPanel,nButtonProductGraphic]
{
	PUSH:
	{
		cGraphicOn = !cGraphicOn
	}
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

WAIT 2
{
	PanelFeedback()
	PollInputMeters()
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
