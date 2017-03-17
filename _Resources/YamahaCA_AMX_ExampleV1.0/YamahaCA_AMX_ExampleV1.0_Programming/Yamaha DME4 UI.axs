MODULE_NAME='Yamaha DME4 UI'(DEV dvComms[], DEV dvPanel)
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

INTEGER nButtonInputPresence1		= 301
INTEGER nButtonInputPresence2		= 302
INTEGER nButtonInputPresence3		= 303
INTEGER nButtonInputPresence4		= 304
INTEGER nButtonInputPresence5		= 305
INTEGER nButtonInputPresence6		= 306
INTEGER nButtonInputPresence7		= 307
INTEGER nButtonInputPresence8		= 308

INTEGER nButtonInput1Up				= 311
INTEGER nButtonInput1Down			= 312
INTEGER nButtonInput2Up				= 313
INTEGER nButtonInput2Down			= 314
INTEGER nButtonInput3Up				= 315
INTEGER nButtonInput3Down			= 316
INTEGER nButtonInput4Up				= 317
INTEGER nButtonInput4Down			= 318
INTEGER nButtonInput5Up				= 319
INTEGER nButtonInput5Down			= 320
INTEGER nButtonInput6Up				= 321
INTEGER nButtonInput6Down			= 322
INTEGER nButtonInput7Up				= 323
INTEGER nButtonInput7Down			= 324
INTEGER nButtonInput8Up				= 325
INTEGER nButtonInput8Down			= 326

INTEGER nButtonOutputPresence1		= 331
INTEGER nButtonOutputPresence2		= 332
INTEGER nButtonOutputPresence3		= 333
INTEGER nButtonOutputPresence4		= 334
INTEGER nButtonOutputPresence5		= 335
INTEGER nButtonOutputPresence6		= 336
INTEGER nButtonOutputPresence7		= 337
INTEGER nButtonOutputPresence8		= 338

INTEGER nButtonOutput1Up			= 341
INTEGER nButtonOutput1Down			= 342
INTEGER nButtonOutput2Up			= 343
INTEGER nButtonOutput2Down			= 344
INTEGER nButtonOutput3Up			= 345
INTEGER nButtonOutput3Down			= 346
INTEGER nButtonOutput4Up			= 347
INTEGER nButtonOutput4Down			= 348
INTEGER nButtonOutput5Up			= 349
INTEGER nButtonOutput5Down			= 350
INTEGER nButtonOutput6Up			= 351
INTEGER nButtonOutput6Down			= 352
INTEGER nButtonOutput7Up			= 353
INTEGER nButtonOutput7Down			= 354
INTEGER nButtonOutput8Up			= 355
INTEGER nButtonOutput8Down			= 356

INTEGER nButtonGlobalMute			= 360

INTEGER nButtonGlobalPreset1		= 361
INTEGER nButtonGlobalPreset2		= 362
INTEGER nButtonGlobalPreset3		= 363
INTEGER nButtonGlobalPreset4		= 364
INTEGER nButtonGlobalPreset5		= 365
INTEGER nButtonGlobalPreset6		= 366
INTEGER nButtonGlobalPreset7		= 367
INTEGER nButtonGlobalPreset8		= 368

INTEGER nButtonWAVLoad1				= 371
INTEGER nButtonWAVLoad2				= 372
INTEGER nButtonWAVLoad3				= 373
INTEGER nButtonWAVLoad4				= 374
INTEGER nButtonWAVLoad5				= 375
INTEGER nButtonWAVLoad6				= 376
INTEGER nButtonWAVLoad7				= 377
INTEGER nButtonWAVLoad8				= 378
INTEGER nButtonWAVPlay				= 379
INTEGER nButtonWAVStop				= 380

INTEGER nButtonCrosspointOut1In1	= 381
INTEGER nButtonCrosspointOut1In2	= 382
INTEGER nButtonCrosspointOut1In3	= 383
INTEGER nButtonCrosspointOut1In4	= 384
INTEGER nButtonCrosspointOut1In5	= 385
INTEGER nButtonCrosspointOut1In6	= 386
INTEGER nButtonCrosspointOut1In7	= 387
INTEGER nButtonCrosspointOut1In8	= 388
INTEGER nButtonCrosspointOut1In9	= 389
INTEGER nButtonCrosspointOut1In10	= 390
INTEGER nButtonCrosspointOut2In1	= 391
INTEGER nButtonCrosspointOut2In2	= 392
INTEGER nButtonCrosspointOut2In3	= 393
INTEGER nButtonCrosspointOut2In4	= 394
INTEGER nButtonCrosspointOut2In5	= 395
INTEGER nButtonCrosspointOut2In6	= 396
INTEGER nButtonCrosspointOut2In7	= 397
INTEGER nButtonCrosspointOut2In8	= 398
INTEGER nButtonCrosspointOut2In9	= 399
INTEGER nButtonCrosspointOut2In10	= 400
INTEGER nButtonCrosspointUp			= 401
INTEGER nButtonCrosspointDown		= 402
INTEGER nButtonCrosspointMute		= 403

INTEGER nButtonSource0				= 410
INTEGER nButtonSource1				= 411
INTEGER nButtonSource2				= 412
INTEGER nButtonSource3				= 413
INTEGER nButtonSource4				= 414

//INTEGER nButtonSPXBypass			= 420

//INTEGER nButtonSPXIntensityUp		= 430
//INTEGER nButtonSPXIntensityDown		= 431
//INTEGER nButtonSPXDelayUp			= 432
//INTEGER nButtonSPXDelayDown			= 433

INTEGER nButtonVolumeMute			= 440
INTEGER nButtonVolumeUp				= 441
INTEGER nButtonVolumeDown			= 442

INTEGER nButtonMicAll				= 444
INTEGER nButtonMic1					= 445
INTEGER nButtonMic2					= 446
INTEGER nButtonMic3					= 447
INTEGER nButtonMic4					= 448

INTEGER nButtonRoomCombiner1		= 451
INTEGER nButtonRoomCombiner2		= 452
INTEGER nButtonRoomCombiner3		= 453
INTEGER nButtonRoomCombiner4		= 454
INTEGER nButtonRoomCombiner5		= 455
INTEGER nButtonRoomCombiner6		= 456

INTEGER nButtonRoomAll				= 457
INTEGER nButtonRoom1				= 458
INTEGER nButtonRoom2				= 459
INTEGER nButtonRoom3				= 460
INTEGER nButtonRoom4				= 461

INTEGER nButtonMessage1				= 463
INTEGER nButtonMessage2				= 464
INTEGER nButtonMessage3				= 465
INTEGER nButtonMessage4				= 466

INTEGER nButtonRoomCombination0		= 470
INTEGER nButtonRoomCombination1		= 471
INTEGER nButtonRoomCombination2		= 472
INTEGER nButtonRoomCombination3		= 473
INTEGER nButtonRoomCombination4		= 474

INTEGER nButtonGPIO1				= 481
INTEGER nButtonGPIO2				= 482
INTEGER nButtonGPIO3				= 483
INTEGER nButtonGPIO4				= 484
INTEGER nButtonGPIO5				= 485
INTEGER nButtonGPIO6				= 486
INTEGER nButtonGPIO7				= 487
INTEGER nButtonGPIO8				= 488

INTEGER nButtonProductGraphic		= 501

INTEGER nLevelInputFader1			= 1
INTEGER nLevelInputFader2			= 2
INTEGER nLevelInputFader3			= 3
INTEGER nLevelInputFader4			= 4
INTEGER nLevelInputFader5			= 5
INTEGER nLevelInputFader6			= 6
INTEGER nLevelInputFader7			= 7
INTEGER nLevelInputFader8			= 8

INTEGER nLevelInputBargraph1		= 11
INTEGER nLevelInputBargraph2		= 12
INTEGER nLevelInputBargraph3		= 13
INTEGER nLevelInputBargraph4		= 14
INTEGER nLevelInputBargraph5		= 15
INTEGER nLevelInputBargraph6		= 16
INTEGER nLevelInputBargraph7		= 17
INTEGER nLevelInputBargraph8		= 18

INTEGER nLevelOutputFader1			= 21
INTEGER nLevelOutputFader2			= 22
INTEGER nLevelOutputFader3			= 23
INTEGER nLevelOutputFader4			= 24
INTEGER nLevelOutputFader5			= 25
INTEGER nLevelOutputFader6			= 26
INTEGER nLevelOutputFader7			= 27
INTEGER nLevelOutputFader8			= 28

INTEGER nLevelOutputBargraph1		= 31
INTEGER nLevelOutputBargraph2		= 32
INTEGER nLevelOutputBargraph3		= 33
INTEGER nLevelOutputBargraph4		= 34
INTEGER nLevelOutputBargraph5		= 35
INTEGER nLevelOutputBargraph6		= 36
INTEGER nLevelOutputBargraph7		= 37
INTEGER nLevelOutputBargraph8		= 38

INTEGER nLevelMatrixFader			= 41
//INTEGER nLevelSPXIntensity			= 42
//INTEGER nLevelSPXDelay				= 43

INTEGER nLevelVolumeFader			= 46
INTEGER nLevelVolumeBargraphLeft	= 47
INTEGER nLevelVolumeBargraphRight	= 48

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nButtonInputPresence[]		= { nButtonInputPresence1, nButtonInputPresence2, nButtonInputPresence3, nButtonInputPresence4, nButtonInputPresence5, nButtonInputPresence6, nButtonInputPresence7, nButtonInputPresence8 }
VOLATILE INTEGER nButtonInputUp[]			= { nButtonInput1Up, nButtonInput2Up, nButtonInput3Up, nButtonInput4Up, nButtonInput5Up, nButtonInput6Up, nButtonInput7Up, nButtonInput8Up }
VOLATILE INTEGER nButtonInputDown[]			= { nButtonInput1Down, nButtonInput2Down, nButtonInput3Down, nButtonInput4Down, nButtonInput5Down, nButtonInput6Down, nButtonInput7Down, nButtonInput8Down }
VOLATILE INTEGER nButtonOutputPresence[]	= { nButtonOutputPresence1, nButtonOutputPresence2, nButtonOutputPresence3, nButtonOutputPresence4, nButtonOutputPresence5, nButtonOutputPresence6, nButtonOutputPresence7, nButtonOutputPresence8 }
VOLATILE INTEGER nButtonOutputUp[]			= { nButtonOutput1Up, nButtonOutput2Up, nButtonOutput3Up, nButtonOutput4Up, nButtonOutput5Up, nButtonOutput6Up, nButtonOutput7Up, nButtonOutput8Up }
VOLATILE INTEGER nButtonOutputDown[]		= { nButtonOutput1Down, nButtonOutput2Down, nButtonOutput3Down, nButtonOutput4Down, nButtonOutput5Down, nButtonOutput6Down, nButtonOutput7Down, nButtonOutput8Down }
VOLATILE INTEGER nButtonGlobalPreset[]		= { nButtonGlobalPreset1, nButtonGlobalPreset2, nButtonGlobalPreset3, nButtonGlobalPreset4, nButtonGlobalPreset5, nButtonGlobalPreset6, nButtonGlobalPreset7, nButtonGlobalPreset8 }
VOLATILE INTEGER nButtonWAVLoad[]			= { nButtonWAVLoad1, nButtonWAVLoad2, nButtonWAVLoad3, nButtonWAVLoad4, nButtonWAVLoad5, nButtonWAVLoad6, nButtonWAVLoad7, nButtonWAVLoad8 }
VOLATILE INTEGER nButtonCrosspoint[]		= { nButtonCrosspointOut1In1, nButtonCrosspointOut1In2, nButtonCrosspointOut1In3, nButtonCrosspointOut1In4, nButtonCrosspointOut1In5, 
												nButtonCrosspointOut1In6, nButtonCrosspointOut1In7, nButtonCrosspointOut1In8, nButtonCrosspointOut1In9, nButtonCrosspointOut1In10, 
												nButtonCrosspointOut2In1, nButtonCrosspointOut2In2, nButtonCrosspointOut2In3, nButtonCrosspointOut2In4, nButtonCrosspointOut2In5, 
												nButtonCrosspointOut2In6, nButtonCrosspointOut2In7, nButtonCrosspointOut2In8, nButtonCrosspointOut2In9, nButtonCrosspointOut2In10 }
VOLATILE INTEGER nButtonSource[]			= { nButtonSource0, nButtonSource1, nButtonSource2, nButtonSource3, nButtonSource4 }
VOLATILE INTEGER nButtonMic[]				= { nButtonMicAll, nButtonMic1, nButtonMic2, nButtonMic3, nButtonMic4 }
VOLATILE INTEGER nButtonRoomCombiner[]		= { nButtonRoomCombiner1, nButtonRoomCombiner2, nButtonRoomCombiner3, nButtonRoomCombiner4, nButtonRoomCombiner5, nButtonRoomCombiner6 }
VOLATILE INTEGER nButtonRoom[]				= { nButtonRoomAll, nButtonRoom1, nButtonRoom2, nButtonRoom3, nButtonRoom4 }
VOLATILE INTEGER nButtonMessage[]			= { nButtonMessage1, nButtonMessage2, nButtonMessage3, nButtonMessage4 }
VOLATILE INTEGER nButtonRoomCombination[]	= { nButtonRoomCombination0, nButtonRoomCombination1, nButtonRoomCombination2, nButtonRoomCombination3, nButtonRoomCombination4 }
VOLATILE INTEGER nButtonGPIO[]				= { nButtonGPIO1, nButtonGPIO2, nButtonGPIO3, nButtonGPIO4, nButtonGPIO5, nButtonGPIO6, nButtonGPIO7, nButtonGPIO8 }
VOLATILE INTEGER nLevelInputFader[]			= { nLevelInputFader1, nLevelInputFader2, nLevelInputFader3, nLevelInputFader4, nLevelInputFader5, nLevelInputFader6, nLevelInputFader7, nLevelInputFader8 }
VOLATILE INTEGER nLevelInputBargraph[]		= { nLevelInputBargraph1, nLevelInputBargraph2, nLevelInputBargraph3, nLevelInputBargraph4, nLevelInputBargraph5, nLevelInputBargraph6, nLevelInputBargraph7, nLevelInputBargraph8 }
VOLATILE INTEGER nLevelOutputFader[]		= { nLevelOutputFader1, nLevelOutputFader2, nLevelOutputFader3, nLevelOutputFader4, nLevelOutputFader5, nLevelOutputFader6, nLevelOutputFader7, nLevelOutputFader8 }
VOLATILE INTEGER nLevelOutputBargraph[]		= { nLevelOutputBargraph1, nLevelOutputBargraph2, nLevelOutputBargraph3, nLevelOutputBargraph4, nLevelOutputBargraph5, nLevelOutputBargraph6, nLevelOutputBargraph7, nLevelOutputBargraph8 }
VOLATILE INTEGER nLevel[]					= { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 }

VOLATILE INTEGER nCurrentPage				= 1
VOLATILE INTEGER nCrosspointIn				= 1
VOLATILE INTEGER nCrosspointOut				= 1

VOLATILE CHAR cInputPresence[8]				= { 0, 0, 0, 0, 0, 0, 0, 0 }
VOLATILE CHAR cInputMeter[8]				= { 0, 0, 0, 0, 0, 0, 0, 0 }
VOLATILE CHAR cInputFader[8]				= { 0, 0, 0, 0, 0, 0, 0, 0 }
VOLATILE CHAR cOutputPresence[8]			= { 0, 0, 0, 0, 0, 0, 0, 0 }
VOLATILE CHAR cOutputMeter[8]				= { 0, 0, 0, 0, 0, 0, 0, 0 }
VOLATILE CHAR cOutputFader[8]				= { 0, 0, 0, 0, 0, 0, 0, 0 }
VOLATILE CHAR cGlobalMuteOn					= false
VOLATILE INTEGER nGlobalPresetLoaded		= 0
VOLATILE INTEGER nWAVLoaded					= 0
VOLATILE CHAR cWAVPlaying					= false
VOLATILE CHAR cMatrixFader[20]				= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
VOLATILE CHAR cMatrixEnabled[20]			= { false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }
VOLATILE CHAR cExtraMatrixEnabled[6]		= { false, false, false, false, false, false }
VOLATILE INTEGER nRoomSource				= 0
//VOLATILE CHAR cSPXBypassOn				= false
//VOLATILE CHAR cSPXIntensity				= 0
//VOLATILE CHAR cSPXDelay					= 0
VOLATILE CHAR cVolumeMuted[2]				= { false, false }
VOLATILE CHAR cVolumeFader[2]				= { 0, 0 }
VOLATILE CHAR cVolumeMeter[2]				= { 0, 0 }
VOLATILE CHAR cRoomCombinerOn[6]			= { false, false, false, false, false, false }
VOLATILE CHAR cMicOn[4]						= { false, false, false, false }
VOLATILE CHAR cGraphicOn					= false
VOLATILE CHAR cMicAllEnabled				= true
VOLATILE CHAR cRoomAllEnabled				= true
VOLATILE CHAR cGPIOOn[]						= { 0, 0, 0, 0, 0, 0, 0, 0 }

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION SetPage(INTEGER nPage)
{
	STACK_VAR INTEGER nCount
	SEND_COMMAND dvComms[1],'REINIT'
	SEND_COMMAND dvComms[1],'AUDIOPROCREMOVEIDX-ALL'
	SWITCH(nPage)
	{
		CASE 1:
		{
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-45,44:LEVEL,0,99'		// wav file number (0 - 99)
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-46,45:STATE'				// wav play / stop

			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-48,47:SLIDER'			// matrix mixer in 1 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-49,48:SLIDER'			// matrix mixer in 2 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-50,49:SLIDER'			// matrix mixer in 3 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-51,50:SLIDER'			// matrix mixer in 4 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-52,51:SLIDER'			// matrix mixer in 5 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-53,52:SLIDER'			// matrix mixer in 6 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-54,53:SLIDER'			// matrix mixer in 7 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-55,54:SLIDER'			// matrix mixer in 8 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-56,55:SLIDER'			// matrix mixer in 9 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-57,56:SLIDER'			// matrix mixer in 10 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-58,57:SLIDER'			// matrix mixer in 1 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-59,58:SLIDER'			// matrix mixer in 2 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-60,59:SLIDER'			// matrix mixer in 3 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-61,60:SLIDER'			// matrix mixer in 4 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-62,61:SLIDER'			// matrix mixer in 5 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-63,62:SLIDER'			// matrix mixer in 6 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-64,63:SLIDER'			// matrix mixer in 7 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-65,64:SLIDER'			// matrix mixer in 8 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-66,65:SLIDER'			// matrix mixer in 9 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-67,66:SLIDER'			// matrix mixer in 10 out 2
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-68,67:STATE'				// matrix mixer in 1 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-69,68:STATE'				// matrix mixer in 2 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-70,69:STATE'				// matrix mixer in 3 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-71,70:STATE'				// matrix mixer in 4 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-72,71:STATE'				// matrix mixer in 5 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-73,72:STATE'				// matrix mixer in 6 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-74,73:STATE'				// matrix mixer in 7 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-75,74:STATE'				// matrix mixer in 8 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-76,75:STATE'				// matrix mixer in 9 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-77,76:STATE'				// matrix mixer in 10 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-78,77:STATE'				// matrix mixer in 1 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-79,78:STATE'				// matrix mixer in 2 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-80,79:STATE'				// matrix mixer in 3 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-81,80:STATE'				// matrix mixer in 4 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-82,81:STATE'				// matrix mixer in 5 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-83,82:STATE'				// matrix mixer in 6 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-84,83:STATE'				// matrix mixer in 7 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-85,84:STATE'				// matrix mixer in 8 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-86,85:STATE'				// matrix mixer in 9 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-87,86:STATE'				// matrix mixer in 10 out 2 enable
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-92,91:LEVEL,0,4'			// source selector (0 - 4)
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-117,116:STATE'			// room combiner combination 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-118,117:STATE'			// room combiner combination 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-119,118:STATE'			// room combiner combination 3
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-120,119:STATE'			// room combiner combination 4
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-121,120:STATE'			// room combiner combination 5
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-122,121:STATE'			// room combiner combination 6
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-123,122:METER'			// stereo volume meters
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-124,123:SLIDER'			// stereo volume fader left
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-126,125:STATE'			// stereo volume enable left
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-132,131:STATE'			// mic mixer in 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-133,132:STATE'			// mic mixer in 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-134,133:STATE'			// mic mixer in 3 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-135,134:STATE'			// mic mixer in 4 enable
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-137,136:STATE'			// matrix mixer in 9 out 3 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-138,137:STATE'			// matrix mixer in 10 out 4 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-139,138:STATE'			// matrix mixer in 9 out 5 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-140,139:STATE'			// matrix mixer in 10 out 6 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-141,140:STATE'			// matrix mixer in 9 out 7 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-142,141:STATE'			// matrix mixer in 10 out 8 enable
			
			BREAK
		}
		CASE 2:
		{
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-45,44:LEVEL,0,99'		// wav file number (0 - 99)
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-46,45:STATE'				// wav play / stop
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-48,47:SLIDER'			// matrix mixer in 1 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-49,48:SLIDER'			// matrix mixer in 2 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-50,49:SLIDER'			// matrix mixer in 3 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-51,50:SLIDER'			// matrix mixer in 4 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-52,51:SLIDER'			// matrix mixer in 5 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-53,52:SLIDER'			// matrix mixer in 6 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-54,53:SLIDER'			// matrix mixer in 7 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-55,54:SLIDER'			// matrix mixer in 8 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-56,55:SLIDER'			// matrix mixer in 9 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-57,56:SLIDER'			// matrix mixer in 10 out 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-58,57:SLIDER'			// matrix mixer in 1 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-59,58:SLIDER'			// matrix mixer in 2 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-60,59:SLIDER'			// matrix mixer in 3 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-61,60:SLIDER'			// matrix mixer in 4 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-62,61:SLIDER'			// matrix mixer in 5 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-63,62:SLIDER'			// matrix mixer in 6 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-64,63:SLIDER'			// matrix mixer in 7 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-65,64:SLIDER'			// matrix mixer in 8 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-66,65:SLIDER'			// matrix mixer in 9 out 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-67,66:SLIDER'			// matrix mixer in 10 out 2
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-68,67:STATE'				// matrix mixer in 1 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-69,68:STATE'				// matrix mixer in 2 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-70,69:STATE'				// matrix mixer in 3 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-71,70:STATE'				// matrix mixer in 4 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-72,71:STATE'				// matrix mixer in 5 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-73,72:STATE'				// matrix mixer in 6 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-74,73:STATE'				// matrix mixer in 7 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-75,74:STATE'				// matrix mixer in 8 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-76,75:STATE'				// matrix mixer in 9 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-77,76:STATE'				// matrix mixer in 10 out 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-78,77:STATE'				// matrix mixer in 1 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-79,78:STATE'				// matrix mixer in 2 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-80,79:STATE'				// matrix mixer in 3 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-81,80:STATE'				// matrix mixer in 4 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-82,81:STATE'				// matrix mixer in 5 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-83,82:STATE'				// matrix mixer in 6 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-84,83:STATE'				// matrix mixer in 7 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-85,84:STATE'				// matrix mixer in 8 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-86,85:STATE'				// matrix mixer in 9 out 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-87,86:STATE'				// matrix mixer in 10 out 2 enable
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-92,91:LEVEL,0,4'			// source selector (0 - 4)
			
//			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-97,96:STATE'				// SPX bypass
//			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-98,97:LEVEL,0,100'		// SPX intensity
//			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-99,98:LEVEL,0,83'		// SPX delay
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-117,116:STATE'			// room combiner combination 1
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-118,117:STATE'			// room combiner combination 2
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-119,118:STATE'			// room combiner combination 3
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-120,119:STATE'			// room combiner combination 4
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-121,120:STATE'			// room combiner combination 5
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-122,121:STATE'			// room combiner combination 6
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-123,122:METER'			// stereo volume meters
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-124,123:SLIDER'			// stereo volume fader left
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-126,125:STATE'			// stereo volume enable left
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-132,131:STATE'			// mic mixer in 1 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-133,132:STATE'			// mic mixer in 2 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-134,133:STATE'			// mic mixer in 3 enable
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-135,134:STATE'			// mic mixer in 4 enable
			
			BREAK
		}
		CASE 3:
		{
/*			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-2,1:METER'				// input detects
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-3,2:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-4,3:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-5,4:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-6,5:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-7,6:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-8,7:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-9,8:METER'*/
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-10,9:METER'				// input meters
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-11,10:SLIDER'			// input levels
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-12,11:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-13,12:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-14,13:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-15,14:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-16,15:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-17,16:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-18,17:SLIDER'
			
/*			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-19,18:METER'				// output detects
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-20,19:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-21,20:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-22,21:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-23,22:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-24,23:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-25,24:METER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-26,25:METER'*/
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-27,26:METER'				// ouptput meters
			
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-28,27:SLIDER'			// output levels
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-29,28:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-30,29:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-31,30:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-32,31:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-33,32:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-34,33:SLIDER'
			SEND_COMMAND dvComms[1], 'AUDIOPROCADD-35,34:SLIDER'
			
			BREAK
		}
		CASE 4:
		{
			BREAK
		}
		CASE 5:
		{
			BREAK
		}
		DEFAULT:
		{
			BREAK
		}
	}
	nCurrentPage = nPage
}

DEFINE_FUNCTION PanelFeedback()
{
	STACK_VAR INTEGER nCount
	FOR (nCount = 1; nCount < 9; nCount++)
	{
		[dvPanel, nButtonInputPresence[nCount]] = cInputPresence[nCount]
		SEND_LEVEL dvPanel, nLevelInputBargraph[nCount], cInputMeter[nCount]
		SEND_LEVEL dvPanel, nLevelInputFader[nCount], cInputFader[nCount]
		[dvPanel, nButtonOutputPresence[nCount]] = cOutputPresence[nCount]
		SEND_LEVEL dvPanel, nLevelOutputBargraph[nCount], cOutputMeter[nCount]
		SEND_LEVEL dvPanel, nLevelOutputFader[nCount], cOutputFader[nCount]
		[dvPanel, nButtonWAVLoad[nCount]] = (nWAVLoaded == nCount)
		[dvPanel, nButtonGlobalPreset[nCount]] = (nGlobalPresetLoaded == nCount)
		[dvPanel, nButtonGPIO[nCount]] = cGPIOOn[nCount]
	}
	[dvPanel, nButtonGlobalMute] = cGlobalMuteOn
	FOR (nCount = 1; nCount < 21; nCount++)
	{
		[dvPanel, nButtonCrosspoint[nCount]] = (nCount == (nCrosspointIn + 10 * (nCrosspointOut - 1)))
	}
	SEND_LEVEL dvPanel, nLevelMatrixFader, cMatrixFader[nCrosspointIn + (10 * (nCrosspointOut - 1))]
	[dvPanel, nButtonCrosspointMute] = !cMatrixEnabled[nCrosspointIn + (10 * (nCrosspointOut - 1))]
	[dvPanel, nButtonSource0] = (nRoomSource == 0)
	[dvPanel, nButtonSource1] = (nRoomSource == 1)
	[dvPanel, nButtonSource2] = (nRoomSource == 2)
	[dvPanel, nButtonSource3] = (nRoomSource == 3)
	[dvPanel, nButtonSource4] = (nRoomSource == 4)
//	[dvPanel, nButtonSPXBypass] = cSPXBypassOn
//	SEND_LEVEL dvPanel, nLevelSPXIntensity, cSPXIntensity
//	SEND_LEVEL dvPanel, nLevelSPXDelay, cSPXDelay
	SEND_LEVEL dvPanel, nLevelVolumeBargraphLeft, cVolumeMeter[1]
	SEND_LEVEL dvPanel, nLevelVolumeBargraphRight, cVolumeMeter[2]
	SEND_LEVEL dvPanel, nLevelVolumeFader, cVolumeFader[1]
	[dvPanel, nButtonVolumeMute] = cVolumeMuted[1]
	[dvPanel, nButtonWAVPlay] = cWAVPlaying
	[dvPanel, nButtonRoomCombiner1] = cRoomCombinerOn[1]
	[dvPanel, nButtonRoomCombiner2] = cRoomCombinerOn[2]
	[dvPanel, nButtonRoomCombiner3] = cRoomCombinerOn[3]
	[dvPanel, nButtonRoomCombiner4] = cRoomCombinerOn[4]
	[dvPanel, nButtonRoomCombiner5] = cRoomCombinerOn[5]
	[dvPanel, nButtonRoomCombiner6] = cRoomCombinerOn[6]
	[dvPanel, nButtonRoomCombination0] = ( !cRoomCombinerOn[1] && !cRoomCombinerOn[2] && !cRoomCombinerOn[3] && !cRoomCombinerOn[4] && !cRoomCombinerOn[5] && !cRoomCombinerOn[6] )
	[dvPanel, nButtonRoomCombination1] = ( cRoomCombinerOn[1] && !cRoomCombinerOn[2] && !cRoomCombinerOn[3] && !cRoomCombinerOn[4] && !cRoomCombinerOn[5] && !cRoomCombinerOn[6] )
	[dvPanel, nButtonRoomCombination2] = ( cRoomCombinerOn[1] && !cRoomCombinerOn[2] && !cRoomCombinerOn[3] && !cRoomCombinerOn[4] && !cRoomCombinerOn[5] && cRoomCombinerOn[6] )
	[dvPanel, nButtonRoomCombination3] = ( cRoomCombinerOn[1] && cRoomCombinerOn[2] && !cRoomCombinerOn[3] && !cRoomCombinerOn[4] && !cRoomCombinerOn[5] && !cRoomCombinerOn[6] )
	[dvPanel, nButtonRoomCombination4] = ( cRoomCombinerOn[1] && cRoomCombinerOn[2] && cRoomCombinerOn[3] && !cRoomCombinerOn[4] && !cRoomCombinerOn[5] && !cRoomCombinerOn[6] )
	[dvPanel, nButtonMicAll] = ( cMicOn[1] && cMicOn[2] && cMicOn[3] && cMicOn[4] )
	[dvPanel, nButtonMic1] = cMicOn[1]
	[dvPanel, nButtonMic2] = cMicOn[2]
	[dvPanel, nButtonMic3] = cMicOn[3]
	[dvPanel, nButtonMic4] = cMicOn[4]
	[dvPanel, nButtonMessage1] = (( nWAVLoaded == 1 ) && cWAVPlaying)
	[dvPanel, nButtonMessage2] = (( nWAVLoaded == 2 ) && cWAVPlaying)
	[dvPanel, nButtonMessage3] = (( nWAVLoaded == 3 ) && cWAVPlaying)
	[dvPanel, nButtonMessage4] = (( nWAVLoaded == 4 ) && cWAVPlaying)
	[dvPanel, nButtonRoomAll] = ( cMatrixEnabled[9] && cMatrixEnabled[20] && cExtraMatrixEnabled[1] && cExtraMatrixEnabled[2] && cExtraMatrixEnabled[3] && cExtraMatrixEnabled[4] && cExtraMatrixEnabled[5] && cExtraMatrixEnabled[6] )
	[dvPanel, nButtonRoom1] = ( cMatrixEnabled[9] && cMatrixEnabled[20] )
	[dvPanel, nButtonRoom2] = ( cExtraMatrixEnabled[1] && cExtraMatrixEnabled[2] )
	[dvPanel, nButtonRoom3] = ( cExtraMatrixEnabled[3] && cExtraMatrixEnabled[4] )
	[dvPanel, nButtonRoom4] = ( cExtraMatrixEnabled[5] && cExtraMatrixEnabled[6] )
	[dvPanel, nButtonProductGraphic] = cGraphicOn
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SET_PULSE_TIME(1)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvComms]
{
	ONLINE:
	{
		IF (GET_LAST(dvComms) == 1)
		{
			SetPage(nCurrentPage)
		}
	}
	OFFLINE:
	{
		IF (GET_LAST(dvComms) == 1)
		{
			SetPage(0)
		}
	}
	ONERROR:
	{
	}
	COMMAND:
	{
		STACK_VAR CHAR cMessage[100]
		cMessage = data.text
		SWITCH(GET_LAST(dvComms))
		{
			CASE 1:
			{
				SELECT
				{
					ACTIVE(LEFT_STRING(cMessage, 5) == 'PAGE-'):
					{
						cGraphicOn = false
						REMOVE_STRING(cMessage, '-', 1)
						SetPage(ATOI(cMessage))
					}
					ACTIVE(LEFT_STRING(cMessage, 6) == 'ENABLE'):
					{
						cGraphicOn = false
						SetPage(1)
					}
					ACTIVE(LEFT_STRING(cMessage, 5) == 'MUTE-'):
					{
						REMOVE_STRING(cMessage, '-', 1)
						cGlobalMuteOn = (ATOI(cMessage) > 0)
					}
					ACTIVE(LEFT_STRING(cMessage, 16) == 'AUDIOPROCPRESET-'):
					{
						REMOVE_STRING(cMessage, '-', 1)
						nGlobalPresetLoaded = ATOI(cMessage)
					}
					ACTIVE(cMessage == 'DISABLE'):
					{
						cGraphicOn = false
						SetPage(0)
					}
					ACTIVE(true):
					{
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

BUTTON_EVENT[dvPanel, nButtonInputUp]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		TO[button.input]
		nChannel = GET_LAST(nButtonInputUp)
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[nChannel + 10], 24]
	}
	HOLD[2,REPEAT]:
	{
		STACK_VAR INTEGER nChannel
		nChannel = GET_LAST(nButtonInputUp)
		PULSE[dvComms[nChannel + 10], 24]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonInputDown]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		TO[button.input]
		nChannel = GET_LAST(nButtonInputDown)
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[nChannel + 10], 25]
	}
	HOLD[2,REPEAT]:
	{
		STACK_VAR INTEGER nChannel
		nChannel = GET_LAST(nButtonInputDown)
		PULSE[dvComms[nChannel + 10], 25]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonOutputUp]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		TO[button.input]
		nChannel = GET_LAST(nButtonOutputUp)
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[nChannel + 27], 24]
	}
	HOLD[2,REPEAT]:
	{
		STACK_VAR INTEGER nChannel
		nChannel = GET_LAST(nButtonOutputUp)
		PULSE[dvComms[nChannel + 27], 24]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonOutputDown]
{
	PUSH:
	{
		STACK_VAR INTEGER nChannel
		TO[button.input]
		nChannel = GET_LAST(nButtonOutputDown)
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[nChannel + 27], 25]
	}
	HOLD[2,REPEAT]:
	{
		STACK_VAR INTEGER nChannel
		nChannel = GET_LAST(nButtonOutputDown)
		PULSE[dvComms[nChannel + 27], 25]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonGlobalMute]
{
	PUSH:
	{
		IF (cGlobalMuteOn)
		{
			SEND_COMMAND dvComms[1], 'MUTE-0'
		}
		ELSE
		{
			SEND_COMMAND dvComms[1], 'MUTE-1'
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonGlobalPreset]
{
	PUSH:
	{
		SEND_COMMAND dvComms[1],"'AUDIOPROCPRESET-',ITOA(GET_LAST(nButtonGlobalPreset))"
	}
}

BUTTON_EVENT[dvPanel, nButtonWAVLoad]
{
	PUSH:
	{
		SEND_LEVEL dvComms[45], 1, GET_LAST(nButtonWAVLoad)-1
	}
}

BUTTON_EVENT[dvPanel, nButtonWAVPlay]
{
	PUSH:
	{
		PULSE[dvComms[46], 27]
	}
}

BUTTON_EVENT[dvPanel, nButtonWAVStop]
{
	PUSH:
	{
		PULSE[dvComms[47], 28]
	}
}

BUTTON_EVENT[dvPanel, nButtonCrosspoint]
{
	PUSH:
	{
		STACK_VAR INTEGER nIndex
		nIndex = GET_LAST(nButtonCrosspoint)
		nCrosspointIn = nIndex % 10
		nCrosspointOut = (nIndex / 10) + 1
	}
}

BUTTON_EVENT[dvPanel, nButtonCrosspointUp]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[47 + nCrosspointIn + (10 * (nCrosspointOut - 1))], 24]
	}
	HOLD[2,REPEAT]:
	{
		PULSE[dvComms[47 + nCrosspointIn + (10 * (nCrosspointOut - 1))], 24]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonCrosspointDown]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[47 + nCrosspointIn + (10 * (nCrosspointOut - 1))], 25]
	}
	HOLD[2,REPEAT]:
	{
		PULSE[dvComms[47 + nCrosspointIn + (10 * (nCrosspointOut - 1))], 25]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonCrosspointMute]
{
	PUSH:
	{
		PULSE[dvComms[67 + nCrosspointIn + (10 * (nCrosspointOut - 1))], 26]
	}
}

BUTTON_EVENT[dvPanel, nButtonSource]
{
	PUSH:
	{
		STACK_VAR INTEGER nSource
		nSource = GET_LAST(nButtonSource)-1
		SEND_LEVEL dvComms[92], 1, nSource
	}
}
/*
BUTTON_EVENT[dvPanel, nButtonSPXBypass]
{
	PUSH:
	{
		PULSE[dvComms[97], 26]
	}
}

BUTTON_EVENT[dvPanel, nButtonSPXIntensityUp]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[98], 24]
	}
	HOLD[2,REPEAT]:
	{
		PULSE[dvComms[98], 24]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonSPXIntensityDown]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[98], 25]
	}
	HOLD[2,REPEAT]:
	{
		PULSE[dvComms[98], 25]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonSPXDelayUp]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[99], 24]
	}
	HOLD[2,REPEAT]:
	{
		PULSE[dvComms[99], 24]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonSPXDelayDown]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[99], 25]
	}
	HOLD[2,REPEAT]:
	{
		PULSE[dvComms[99], 25]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}
*/
BUTTON_EVENT[dvPanel, nButtonVolumeMute]
{
	PUSH:
	{
		PULSE[dvComms[126], 26]
	}
}

BUTTON_EVENT[dvPanel, nButtonVolumeUp]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[124], 24]
	}
	HOLD[2,REPEAT]:
	{
		PULSE[dvComms[124], 24]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonVolumeDown]
{
	PUSH:
	{
		TO[button.input]
		SEND_COMMAND dvComms[1],'POLL-0'
		PULSE[dvComms[124], 25]
	}
	HOLD[2,REPEAT]:
	{
		PULSE[dvComms[124], 25]
	}
	RELEASE:
	{
		SEND_COMMAND dvComms[1],'POLL-1'
	}
}

BUTTON_EVENT[dvPanel, nButtonMic]
{
	PUSH:
	{
		SWITCH(GET_LAST(nButtonMic) - 1)
		{
			CASE 0:
			{
				IF (cMicAllEnabled)
				{
					cMicAllEnabled = false
					IF ([dvComms[132], 199])
					{
						PULSE[dvComms[132], 28]
						PULSE[dvComms[133], 28]
						PULSE[dvComms[134], 28]
						PULSE[dvComms[135], 28]
					}
					ELSE
					{
						PULSE[dvComms[132], 27]
						PULSE[dvComms[133], 27]
						PULSE[dvComms[134], 27]
						PULSE[dvComms[135], 27]
					}
					WAIT 10
					{
						cMicAllEnabled = true
					}
				}
				BREAK
			}
			CASE 1:
			{
				PULSE[dvComms[132], 26]
				BREAK
			}
			CASE 2:
			{
				PULSE[dvComms[133], 26]
				BREAK
			}
			CASE 3:
			{
				PULSE[dvComms[134], 26]
				BREAK
			}
			CASE 4:
			{
				PULSE[dvComms[135], 26]
				BREAK
			}
			DEFAULT:
			{
				BREAK
			}
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonRoomCombiner]
{
	PUSH:
	{
		STACK_VAR INTEGER nIndex
		nIndex = GET_LAST(nButtonRoomCombiner)
		PULSE[dvComms[116 + nIndex], 26]
	}
}

BUTTON_EVENT[dvPanel, nButtonRoom]
{
	PUSH:
	{
		SWITCH (GET_LAST(nButtonRoom) - 1)
		{
			CASE 0:
			{
				IF (cRoomAllEnabled)
				{
					cRoomAllEnabled = false
					IF ([dvComms[76], 199])
					{
						PULSE[dvComms[76], 28]
						PULSE[dvComms[87], 28]
						PULSE[dvComms[137], 28]
						PULSE[dvComms[138], 28]
						PULSE[dvComms[139], 28]
						PULSE[dvComms[140], 28]
						PULSE[dvComms[141], 28]
						PULSE[dvComms[142], 28]
					}
					ELSE
					{
						PULSE[dvComms[76], 27]
						PULSE[dvComms[87], 27]
						PULSE[dvComms[137], 27]
						PULSE[dvComms[138], 27]
						PULSE[dvComms[139], 27]
						PULSE[dvComms[140], 27]
						PULSE[dvComms[141], 27]
						PULSE[dvComms[142], 27]
					}
					WAIT 10
					{
						cRoomAllEnabled = true
					}
				}
			}
			CASE 1:
			{
				IF ([dvComms[76], 199])
				{
					PULSE[dvComms[76], 28]
					PULSE[dvComms[87], 28]
				}
				ELSE
				{
					PULSE[dvComms[76], 27]
					PULSE[dvComms[87], 27]
				}
			}
			CASE 2:
			{
				IF ([dvComms[137], 199])
				{
					PULSE[dvComms[137], 28]
					PULSE[dvComms[138], 28]
				}
				ELSE
				{
					PULSE[dvComms[137], 27]
					PULSE[dvComms[138], 27]
				}
			}
			CASE 3:
			{
				IF ([dvComms[139], 199])
				{
					PULSE[dvComms[139], 28]
					PULSE[dvComms[140], 28]
				}
				ELSE
				{
					PULSE[dvComms[139], 27]
					PULSE[dvComms[140], 27]
				}
			}
			CASE 4:
			{
				IF ([dvComms[141], 199])
				{
					PULSE[dvComms[141], 28]
					PULSE[dvComms[142], 28]
				}
				ELSE
				{
					PULSE[dvComms[141], 27]
					PULSE[dvComms[142], 27]
				}
			}
			DEFAULT:
			{
				BREAK
			}
		}
	}
}

BUTTON_EVENT[dvPanel, nButtonMessage]
{
	PUSH:
	{
		SEND_COMMAND dvComms[1], "'PLAY_WAV_FILE-', ITOA(GET_LAST(nButtonMessage))"
	}
}

BUTTON_EVENT[dvPanel, nButtonRoomCombination]
{
	PUSH:
	{
		SWITCH(GET_LAST(nButtonRoomCombination) - 1)
		{
			CASE 0:
			{
				PULSE[dvComms[117], 28]
				PULSE[dvComms[118], 28]
				PULSE[dvComms[119], 28]
				PULSE[dvComms[120], 28]
				PULSE[dvComms[121], 28]
				PULSE[dvComms[122], 28]
				BREAK
			}
			CASE 1:
			{
				PULSE[dvComms[117], 27]
				PULSE[dvComms[118], 28]
				PULSE[dvComms[119], 28]
				PULSE[dvComms[120], 28]
				PULSE[dvComms[121], 28]
				PULSE[dvComms[122], 28]
				BREAK
			}
			CASE 2:
			{
				PULSE[dvComms[117], 27]
				PULSE[dvComms[118], 28]
				PULSE[dvComms[119], 28]
				PULSE[dvComms[120], 28]
				PULSE[dvComms[121], 28]
				PULSE[dvComms[122], 27]
				BREAK
			}
			CASE 3:
			{
				PULSE[dvComms[117], 27]
				PULSE[dvComms[118], 27]
				PULSE[dvComms[119], 28]
				PULSE[dvComms[120], 28]
				PULSE[dvComms[121], 28]
				PULSE[dvComms[122], 28]
				BREAK
			}
			CASE 4:
			{
				PULSE[dvComms[117], 27]
				PULSE[dvComms[118], 27]
				PULSE[dvComms[119], 27]
				PULSE[dvComms[120], 28]
				PULSE[dvComms[121], 28]
				PULSE[dvComms[122], 28]
				BREAK
			}
			DEFAULT:
			{
				BREAK
			}
		}
	}
}

BUTTON_EVENT[dvPanel,nButtonGPIO]
{
	PUSH:
	{
		STACK_VAR INTEGER nChan
		nChan = GET_LAST(nButtonGPIO)
		cGPIOOn[nChan] = !cGPIOOn[nChan]
		IF (cGPIOOn[nChan])
		{
			SEND_COMMAND dvComms[1],"'GPIO-',ITOA(nChan),',1'"
		}
		ELSE
		{
			SEND_COMMAND dvComms[1],"'GPIO-',ITOA(nChan),',0'"
		}
	}
	RELEASE:
	{
		//STACK_VAR INTEGER nChan
		//nChan = GET_LAST(nButtonGPIO)
		//SEND_COMMAND dvComms[1],"'GPIO-',ITOA(nChan),',0'"
	}
}

BUTTON_EVENT[dvPanel,nButtonProductGraphic]
{
	PUSH:
	{
		cGraphicOn = !cGraphicOn
	}
}

LEVEL_EVENT[dvComms, 0]
{
	STACK_VAR INTEGER nDev
	STACK_VAR INTEGER nLev
	STACK_VAR INTEGER nVal
	nDev = GET_LAST(dvComms)
	nLev = level.input.level
	nVal = level.value
	SWITCH(nDev)
	{
		CASE 2:
		CASE 3:
		CASE 4:
		CASE 5:
		CASE 6:
		CASE 7:
		CASE 8:
		CASE 9:
		{
			BREAK
			//cInputPresence[nLev] = (level.value > 1)
		}
		CASE 10:
		{
			cInputMeter[nLev]= level.value
			cInputPresence[nLev] = (level.value > 128)
			BREAK
		}
		CASE 11:
		CASE 12:
		CASE 13:
		CASE 14:
		CASE 15:
		CASE 16:
		CASE 17:
		CASE 18:
		{
			cInputFader[nDev - 10]= level.value
			BREAK
		}
		CASE 19:
		CASE 20:
		CASE 21:
		CASE 22:
		CASE 23:
		CASE 24:
		CASE 25:
		CASE 26:
		{
			//cOutputPresence[nDev - 18] = (level.value > 0)
			BREAK
		}
		CASE 27:
		{
			cOutputMeter[nLev]= level.value
			cOutputPresence[nLev] = (level.value > 128)
			BREAK
		}
		CASE 28:
		CASE 29:
		CASE 30:
		CASE 31:
		CASE 32:
		CASE 33:
		CASE 34:
		CASE 35:
		{
			cOutputFader[nDev - 27]= level.value
			BREAK
		}
		CASE 45:
		{
			nWAVLoaded = level.value + 1
			BREAK
		}
		CASE 48:
		CASE 49:
		CASE 50:
		CASE 51:
		CASE 52:
		CASE 53:
		CASE 54:
		CASE 55:
		CASE 56:
		CASE 57:
		CASE 58:
		CASE 59:
		CASE 60:
		CASE 61:
		CASE 62:
		CASE 63:
		CASE 64:
		CASE 65:
		CASE 66:
		CASE 67:
		{
			cMatrixFader[nDev - 47] = level.value
			BREAK
		}
		CASE 92:
		{
			nRoomSource = level.value
			BREAK
		}
/*		CASE 98:
		{
			cSPXIntensity = (255 * level.value) / 100
			BREAK
		}
		CASE 99:
		{
			cSPXDelay = (255 * level.value) / 83
			BREAK
		}*/
		CASE 123:
		{
			cVolumeMeter[nLev] = level.value
			BREAK
		}
		CASE 124:
		{
			cVolumeFader[1] = level.value
			BREAK
		}
		CASE 125:
		{
			cVolumeFader[2] = level.value
			BREAK
		}
		DEFAULT:
		{
			BREAK
		}
	}
}

CHANNEL_EVENT[dvComms, 199]
{
	ON:
	{
		STACK_VAR INTEGER nDev
		nDev = GET_LAST(dvComms)
		SWITCH(nDev)
		{
			CASE 46:
			{
				cWAVPlaying = true
				BREAK
			}
			CASE 68:
			CASE 69:
			CASE 70:
			CASE 71:
			CASE 72:
			CASE 73:
			CASE 74:
			CASE 75:
			CASE 76:
			CASE 77:
			CASE 78:
			CASE 79:
			CASE 80:
			CASE 81:
			CASE 82:
			CASE 83:
			CASE 84:
			CASE 85:
			CASE 86:
			CASE 87:
			{
				cMatrixEnabled[nDev - 67] = true
				BREAK
			}
/*			CASE 97:
			{
				cSPXBypassOn = true
				BREAK
			}*/
			CASE 117:
			CASE 118:
			CASE 119:
			CASE 120:
			CASE 121:
			CASE 122:
			{
				cRoomCombinerOn[nDev - 116] = true
				BREAK
			}
			CASE 126:
			CASE 127:
			{
				cVolumeMuted[nDev - 125] = false
				BREAK
			}
			CASE 132:
			CASE 133:
			CASE 134:
			CASE 135:
			{
				cMicOn[nDev - 131] = true
				BREAK
			}
			CASE 137:
			CASE 138:
			CASE 139:
			CASE 140:
			CASE 141:
			CASE 142:
			{
				cExtraMatrixEnabled[nDev - 136] = true
				BREAK
			}
			DEFAULT:
			{
				BREAK
			}
		}
	}
	OFF:
	{
		STACK_VAR INTEGER nDev
		nDev = GET_LAST(dvComms)
		SWITCH(nDev)
		{
			CASE 46:
			{
				cWAVPlaying = false
				BREAK
			}
			CASE 68:
			CASE 69:
			CASE 70:
			CASE 71:
			CASE 72:
			CASE 73:
			CASE 74:
			CASE 75:
			CASE 76:
			CASE 77:
			CASE 78:
			CASE 79:
			CASE 80:
			CASE 81:
			CASE 82:
			CASE 83:
			CASE 84:
			CASE 85:
			CASE 86:
			CASE 87:
			{
				cMatrixEnabled[nDev - 67] = false
				BREAK
			}
/*			CASE 97:
			{
				cSPXBypassOn = false
				BREAK
			}*/
			CASE 117:
			CASE 118:
			CASE 119:
			CASE 120:
			CASE 121:
			CASE 122:
			{
				cRoomCombinerOn[nDev - 116] = false
				BREAK
			}
			CASE 126:
			CASE 127:
			{
				cVolumeMuted[nDev - 125] = true
				BREAK
			}
			CASE 132:
			CASE 133:
			CASE 134:
			CASE 135:
			{
				cMicOn[nDev - 131] = false
				BREAK
			}
			CASE 137:
			CASE 138:
			CASE 139:
			CASE 140:
			CASE 141:
			CASE 142:
			{
				cExtraMatrixEnabled[nDev - 136] = false
				BREAK
			}
			DEFAULT:
			{
				BREAK
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

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
