(*********************************************************************)
(*  AMX Corporation                                                  *)
(*  Copyright (c) 2004-2010 AMX Corporation. All rights reserved.    *)
(*********************************************************************)
(* Copyright Notice :                                                *)
(* Copyright, AMX, Inc., 2004-2010                                   *)
(*    Private, proprietary information, the sole property of AMX.    *)
(*    The contents, ideas, and concepts expressed herein are not to  *)
(*    be disclosed except within the confines of a confidential      *)
(*    relationship and only then on a need to know basis.            *)
(*********************************************************************)
MODULE_NAME='__DENT_SCOUT__' (DEV vdvMain, DEV dvDev)


(***********************************************************)
(* System Type : Netlinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*                                                         *)
(*  Rev  1.02     05/18/2010   CWR                         *)
(*  -Took a demo block module and removed the GUI code.    *)
(*  -Added commands back to caller for values.             *)
(*  -Module now polls 16 items for 6 circuits.             *)
(*                                                         *)
(***********************************************************)
(*  - Snapi components:                                    *)
(*       'CLEAR-<circuit>'                                 *)
(*       'CLEARALL'                                        *)
(*       'REFRESH'                                         *)
(*  - Snapi listeners:                                     *)
(*       'VOLTS-<circuit>,<phase>,<value>'                 *)
(*        'AMPS-<circuit>,<phase>,<value>'                 *)
(*       'WATTS-<circuit>,<phase>,<value>'                 *)
(*       'TOTAL WATTS-<circuit>,<value>'                   *)
(*       'TOTAL AMPS-<circuit>,<value>'                    *)
(*       'TOTAL KWH-<circuit>,<value>'                     *)
(***********************************************************)

#INCLUDE 'snapi.axi'

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

vdvMod = DYNAMIC_VIRTUAL_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR sVERSION[] = '1.1 (cwr)'

CONSTANT INTEGER POWER_STACK_TL = 1
CONSTANT INTEGER POWER_POLL_TL = 2

CONSTANT INTEGER VOLTS = 1
CONSTANT INTEGER AMPS = 2
CONSTANT INTEGER KILO_WATT = 3

FLOAT kW_SCALE[] = {0.00001, 0.001, 0.01, 0.1, 1, 10, 100}
FLOAT AMPS_SCALE[] = {0.01, 0.1, 0.1, 0.1, 1, 1, 1}
FLOAT VOLTS_SCALE[] = {0.1, 0.1, 0.1, 0.1, 1, 1, 1}

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _uCommandStack
{
  CHAR sCommand[10]
}

STRUCTURE _uPhase
{
  FLOAT fVoltage
  FLOAT fCurrent
  FLOAT fPower
}

STRUCTURE _uState
{
  FLOAT fTotalkWH
  FLOAT fTotalPower
  FLOAT fTotalCurrent
  _uPhase uPhase[3]
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

// DEBUG Variable
VOLATILE INTEGER nDebug = 1;

VOLATILE _uCommandStack uCommandStack[50]

VOLATILE _uState uState
VOLATILE _uState uStatePrev

VOLATILE INTEGER nStackCounter = 1
VOLATILE INTEGER nStackPointer = 1
VOLATILE INTEGER nPollCounter = 1

VOLATILE INTEGER PowerScoutAddress = $01

VOLATILE INTEGER CircuitAddressOffset = 255

VOLATILE INTEGER fScaleFactor = 0

VOLATILE LONG lPowerStackTriggers[] = {0,200}
VOLATILE LONG lPowerPollTriggers[] = {300,300,300,500,500,500,500,500,500,500,500,500,500,500,500,300}

VOLATILE CHAR cCrcHigh
VOLATILE CHAR cCrcLow

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING
(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)


(*---------------------------------------------------------*)
(*-- Device queue.                                       --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION fnNextCommand (INTEGER nCommand,INTEGER nADDRESS)
{
  IF (nDebug > 2)
  {
    send_string 0, "'In fnNextCommand(', ITOA(nCommand),',',ITOA(nADDRESS),')'"
  }
  SWITCH (nCommand)
  {
    CASE 1: fnCommandStack ("nADDRESS,$03,$0F,$E4,$00,$02")   //Firmware
    CASE 2: fnCommandStack ("nADDRESS,$03,$10,$68,$00,$05")   //Model
    CASE 3: fnCommandStack ("nADDRESS,$03,$11,$F9,$00,$01")   //Scalar
    CASE 4: fnCommandStack ("nADDRESS,$03,$0F,$DA,$00,$01")   //L1 Voltage
    CASE 5: fnCommandStack ("nADDRESS,$03,$0F,$D7,$00,$01")   //L1 Amps
    CASE 6: fnCommandStack ("nADDRESS,$03,$0F,$BC,$00,$01")   //L1 Power
    CASE 7: fnCommandStack ("nADDRESS,$03,$0F,$DB,$00,$01")   //L2 Voltage
    CASE 8: fnCommandStack ("nADDRESS,$03,$0F,$D8,$00,$01")   //L2 Amps
    CASE 9: fnCommandStack ("nADDRESS,$03,$0F,$BD,$00,$01")   //L2 Power
    CASE 10: fnCommandStack ("nADDRESS,$03,$0F,$DC,$00,$01")  //L3 Voltage
    CASE 11: fnCommandStack ("nADDRESS,$03,$0F,$D9,$00,$01")  //L3 Amps
    CASE 12: fnCommandStack ("nADDRESS,$03,$0F,$BE,$00,$01")  //L3 Power
    CASE 13: fnCommandStack ("nADDRESS,$03,$0F,$A2,$00,$01")  //System Net Power
    CASE 14: fnCommandStack ("nADDRESS,$03,$0F,$AF,$00,$01")  //System Amps
    CASE 15: fnCommandStack ("nADDRESS,$03,$0F,$A0,$00,$02")  //System Accumilated Power
    CASE 16: fnCommandStack ("nADDRESS,$03,$10,$6D,$00,$05")  //Serial
  }
}

(*---------------------------------------------------------*)
(*-- Device crc checksum.                                --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION fnCalcCheckSum(CHAR cBuffer[] )
{
  STACK_VAR INTEGER nCRCReg              // CRC checksum working register
  STACK_VAR INTEGER nPOLYNOMIAL          // polynomial constant A001
  STACK_VAR INTEGER i, j                 // loop counters
  STACK_VAR INTEGER nByte                // byte in msg to process
  STACK_VAR INTEGER nLSB                 // temp var to hold value of LSB (Least Significant Bit)

  nPOLYNOMIAL = $A001
  nCRCReg = $FFFF

  for (i=1; i <= LENGTH_STRING(cBuffer); i++) // for each byte in the command string...
  {
    nByte = cBuffer[i]
    nCRCReg = nCRCReg ^ nByte            // XOR first 8-bit byte of str with register

    for (j=1; j <= 8; j++)               // will shift a total of 8 times
    {
      nLSB = (nCRCReg & $01)             // save LSB
      nCRCReg = TYPE_CAST (nCRCReg >> 1) // shift 1 bit to the right

      if (nLSB)                          // check if LSB WAS 0 or 1
      {
        nCRCReg = nCRCReg ^ nPOLYNOMIAL  // if 1, XOR with constant A001, otherwise just continue
      }
    }                                    // END OF - loop thru 8 bits
  }                                      // END OF - loop for each byte in the string

  cCrcHigh = TYPE_CAST ((nCRCReg & $FF00) >> 8)
  cCrcLow =  TYPE_CAST (nCRCReg & $00FF)

  IF (nDebug > 3)
  {
    send_string 0, "'calculated checksum is  ', cCrcLow, cCrcHigh"
  }
}

(*---------------------------------------------------------*)
(*-- Device polling.                                     --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION fnTimelineStart (INTEGER nTimeline)
{
  SWITCH (nTimeline)
  {
    CASE POWER_STACK_TL:
    {
      IF (!TIMELINE_ACTIVE(POWER_STACK_TL))
      {
        TIMELINE_CREATE (POWER_STACK_TL,lPowerStackTriggers,LENGTH_ARRAY(lPowerStackTriggers),TIMELINE_RELATIVE,TIMELINE_REPEAT)
      }
    }
    CASE POWER_POLL_TL:
    {
      IF (!TIMELINE_ACTIVE(POWER_POLL_TL))
      {
        TIMELINE_CREATE (POWER_POLL_TL,lPowerPollTriggers,LENGTH_ARRAY(lPowerPollTriggers),TIMELINE_RELATIVE,TIMELINE_REPEAT)
      }
    }
  }
}

(*---------------------------------------------------------*)
(*-- Device polling.                                     --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION fnTimelineStop (INTEGER nTimeline)
{
  SWITCH (nTimeline)
  {
    CASE POWER_STACK_TL:
    {
      IF (TIMELINE_ACTIVE(POWER_STACK_TL))
      {
        TIMELINE_KILL (POWER_STACK_TL)
      }
    }
    CASE POWER_POLL_TL:
    {
      IF (TIMELINE_ACTIVE(POWER_POLL_TL))
      {
        TIMELINE_KILL (POWER_POLL_TL)
      }
    }
  }
}

(*---------------------------------------------------------*)
(*-- Device queue.                                       --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION fnCommandStack (CHAR sCommand[10])
{
  IF (nDebug > 2)
  {
    SEND_STRING 0, "'In fnCommandStack(',sCommand,')'"
  }
  fnCalcChecksum(sCommand)
  uCommandStack[nStackCounter].sCommand = "sCommand,cCrcLow,cCrcHigh"
  IF (nStackCounter < 50) nStackCounter ++
  ELSE nStackCounter = 1
  fnTimelineStart (POWER_STACK_TL)
}

(*---------------------------------------------------------*)
(*-- Value scaling.                                      --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION FLOAT fnScaleValue (INTEGER data_value, INTEGER scaleType)
{
  IF (nDebug > 2)
  {
    send_string 0, "'In fnScaleValue(',itoa(data_value),')'"
  }
  IF(scaleType==VOLTS)
  {
    SWITCH(fScaleFactor+1)
    {
      CASE 1: RETURN data_value*0.1
      CASE 2: RETURN data_value*0.1
      CASE 3: RETURN(data_value*0.1)
      CASE 4: RETURN(data_value*0.1)
      CASE 5: RETURN(data_value*1)
      CASE 6: RETURN(data_value*1)
      CASE 7: RETURN(data_value*1)
    }
  }
  ELSE IF(scaleType==AMPS)
  {
    SWITCH(fScaleFactor+1)
    {
      CASE 1: RETURN(data_value*0.01)
      CASE 2: RETURN(data_value*0.1)
      CASE 3: RETURN(data_value*0.1)
      CASE 4: RETURN(data_value*0.1)
      CASE 5: RETURN(data_value*1)
      CASE 6: RETURN(data_value*1)
      CASE 7: RETURN(data_value*1)
    }
  }
  ELSE IF(scaleType==KILO_WATT)
  {
    SWITCH(fScaleFactor+1)
    {
      CASE 1: RETURN(data_value*0.00001)
      CASE 2: RETURN(data_value*0.001)
      CASE 3: RETURN(data_value*0.01)
      CASE 4: RETURN(data_value*0.1)
      CASE 5: RETURN(data_value*1)
      CASE 6: RETURN(data_value*10)
      CASE 7: RETURN(data_value*100)
    }
  }
  ELSE RETURN 0
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(*-- Virtual Device Translation ---------------------------*)
TRANSLATE_DEVICE (vdvMain, vdvMod)


WAIT 50 fnTimelineStart (POWER_POLL_TL)

(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

(*---------------------------------------------------------*)
(*-- Real device.                                        --*)
(*---------------------------------------------------------*)
DATA_EVENT [dvDev]
{
  ONLINE:
  {
    SEND_COMMAND dvDev,'SET BAUD 9600,N,8,1 485 ENABLE'
    SEND_COMMAND dvDev,'RXON'
  }
  STRING:
  {
    STACK_VAR INTEGER ScoutID
    STACK_VAR INTEGER nByte1
    STACK_VAR INTEGER nByte2
    STACK_VAR INTEGER nConverted

    IF (nDebug > 1)
    {
        send_string 0, "'Data received: ', DATA.TEXT"
    }
    SELECT
    {
      ACTIVE ((LENGTH_ARRAY(DATA.TEXT) == 7) && (FIND_STRING(DATA.TEXT,"$03,$02",2))):    //Circuit Data
      {
        IF (nDebug > 3)
        {
          send_string 0, "'Data Event, 7 len response to read reg.'"
        }
        ScoutID = GET_BUFFER_CHAR(DATA.TEXT) * 256
        GET_BUFFER_STRING(DATA.TEXT,2)
        nByte1 = ATOI(FORMAT('%d',LEFT_STRING(DATA.TEXT,1)))
        nByte1 = nByte1 * 256
        nByte2 = ATOI(FORMAT('%d',MID_STRING(DATA.TEXT,2,1)))
        nConverted = nByte1 + nByte2
        IF (nDebug == 2)
        {
          SEND_STRING 0, "'Data Event, Switching:', ITOA(nPollCounter),' value:',ITOA(nConverted)"
        }

        SWITCH (nPollCounter)
        {
          CASE  4 : uState.uPhase[1].fVoltage = nConverted * VOLTS_SCALE[fScaleFactor+1]
          CASE  5 : uState.uPhase[1].fCurrent = fnScaleValue(nConverted, AMPS)
          CASE  6 : uState.uPhase[1].fPower   = nConverted * kW_SCALE[fScaleFactor+1]

          CASE  7 : uState.uPhase[2].fVoltage = nConverted * VOLTS_SCALE[fScaleFactor+1]
          CASE  8 : uState.uPhase[2].fCurrent = fnScaleValue(nConverted, AMPS)
          CASE  9 : uState.uPhase[2].fPower   = nConverted * kW_SCALE[fScaleFactor+1]

          CASE 10 : uState.uPhase[3].fVoltage = nConverted * VOLTS_SCALE[fScaleFactor+1]
          CASE 11 : uState.uPhase[3].fCurrent = fnScaleValue(nConverted, AMPS)
          CASE 12 : uState.uPhase[3].fPower   = nConverted * kW_SCALE[fScaleFactor+1]

          CASE 13 : uState.fTotalPower        = nConverted * kW_SCALE[fScaleFactor+1]
          CASE 14 : uState.fTotalCurrent    = nConverted * AMPS_SCALE[fScaleFactor+1]
        }

        IF(uStatePrev.uPhase[1].fVoltage <> uState.uPhase[1].fVoltage) SEND_COMMAND vdvMod,"'VOLTS-',ITOA(CircuitAddressOffset + 1),',1,',FTOA(uState.uPhase[1].fVoltage)"
        IF(uStatePrev.uPhase[1].fVoltage <> uState.uPhase[1].fCurrent) SEND_COMMAND vdvMod," 'AMPS-',ITOA(CircuitAddressOffset + 1),',1,',FTOA(uState.uPhase[1].fCurrent)"
        IF(uStatePrev.uPhase[1].fVoltage <> uState.uPhase[1].fPower  ) SEND_COMMAND vdvMod,"'WATTS-',ITOA(CircuitAddressOffset + 1),',1,',FTOA(uState.uPhase[1].fPower  )"

        IF(uStatePrev.uPhase[2].fVoltage <> uState.uPhase[2].fVoltage) SEND_COMMAND vdvMod,"'VOLTS-',ITOA(CircuitAddressOffset + 1),',2,',FTOA(uState.uPhase[2].fVoltage)"
        IF(uStatePrev.uPhase[2].fVoltage <> uState.uPhase[2].fCurrent) SEND_COMMAND vdvMod," 'AMPS-',ITOA(CircuitAddressOffset + 1),',2,',FTOA(uState.uPhase[2].fCurrent)"
        IF(uStatePrev.uPhase[2].fVoltage <> uState.uPhase[2].fPower  ) SEND_COMMAND vdvMod,"'WATTS-',ITOA(CircuitAddressOffset + 1),',2,',FTOA(uState.uPhase[2].fPower  )"

        IF(uStatePrev.uPhase[3].fVoltage <> uState.uPhase[3].fVoltage) SEND_COMMAND vdvMod,"'VOLTS-',ITOA(CircuitAddressOffset + 1),',3,',FTOA(uState.uPhase[3].fVoltage)"
        IF(uStatePrev.uPhase[3].fVoltage <> uState.uPhase[3].fCurrent) SEND_COMMAND vdvMod," 'AMPS-',ITOA(CircuitAddressOffset + 1),',3,',FTOA(uState.uPhase[3].fCurrent)"
        IF(uStatePrev.uPhase[3].fVoltage <> uState.uPhase[3].fPower  ) SEND_COMMAND vdvMod,"'WATTS-',ITOA(CircuitAddressOffset + 1),',3,',FTOA(uState.uPhase[3].fPower  )"

        IF(uStatePrev.fTotalPower        <> uState.fTotalPower       ) SEND_COMMAND vdvMod,"'TOTAL WATTS-',ITOA(CircuitAddressOffset + 1),',',FTOA(uState.fTotalPower   )"
        IF(uStatePrev.fTotalCurrent      <> uState.fTotalCurrent     ) SEND_COMMAND vdvMod,"'TOTAL AMPS-' ,ITOA(CircuitAddressOffset + 1),',',FTOA(uState.fTotalCurrent )"

        uStatePrev = uState
      }
      ACTIVE ((LENGTH_ARRAY(DATA.TEXT) == 9) && !(FIND_STRING(DATA.TEXT,'ADDRESS-',1))):    //FIRMWARE
      {
        IF (nDebug == 2)
        {
          send_string 0, "'Data Event, 9 len response to read reg.'"
        }
        GET_BUFFER_STRING(DATA.TEXT,3)
        if(nPollCounter==1)
        {
          nByte1 = ATOI(FORMAT('%d',MID_STRING(DATA.TEXT,2,1)))   //MSB
          nByte2 = ATOI(FORMAT('%d',MID_STRING(DATA.TEXT,4,1)))   //
          IF (nDebug == 2)
          {
            send_string 0, "'RAW FIRMWARE,   MSB(',ITOA(nByte1),',',ITOA(nByte2),')'"
          }
        }
        if(nPollCounter==15)
        {
          STACK_VAR LONG lConverted

          nByte1 = ATOI(FORMAT('%d',LEFT_STRING(DATA.TEXT,1)))    //LSW
          nByte2 = ATOI(FORMAT('%d',MID_STRING(DATA.TEXT,2,1)))   //LSW
          IF (nDebug > 3)
          {
            send_string 0, "'RAW kWh,   LSW(',ITOA(nByte1),',',ITOA(nByte2),')'"
          }
          lConverted = nByte1 + nByte2
          GET_BUFFER_STRING(DATA.TEXT,2)
          nByte1 = ATOI(FORMAT('%d',LEFT_STRING(DATA.TEXT,1)))    //MSW
          nByte2 = ATOI(FORMAT('%d',MID_STRING(DATA.TEXT,2,1)))   //MSW
          IF (nDebug > 3)
          {
            SEND_STRING 0, "'RAW kWh,   MSW(',ITOA(nByte1),',',ITOA(nByte2),')'"
          }
          lConverted = lConverted + (nByte1+nByte2*65536)

          uState.fTotalkWH   = lConverted * kW_SCALE[fScaleFactor+1]
          IF(uStatePrev.fTotalkWH   <> uState.fTotalkWH  ) SEND_COMMAND vdvMod," 'TOTAL KWH-',ITOA(CircuitAddressOffset + 1),',',FTOA(uState.fTotalkWH)"
          uStatePrev.fTotalkWH = uState.fTotalkWH
        }
      }
      ACTIVE ((LENGTH_ARRAY(DATA.TEXT) == 5) ):   //SCALAR, SERIAL
      {
        IF (nDebug > 3)
        {
          send_string 0, "'Data Event, 5 len response to read reg.'"
        }
        GET_BUFFER_STRING(DATA.TEXT,2)
        nByte1 = ATOI(FORMAT('%d',LEFT_STRING(DATA.TEXT,1)))
        if(nPollCounter==3)
        {
          fScaleFactor = nByte1
          IF (nDebug > 3)
          {
            send_string 0, "'FScaleFactor adjusted to ',itoa(nByte1)"
          }
        }
       }
       ACTIVE ((LENGTH_ARRAY(DATA.TEXT) == 15) ):   //MODEL, SERIAL
       {
        IF (nDebug > 3)
        {
          send_string 0, "'Data Event, 15 len response to read reg.'"
        }
      }
    }
  }
}

(*---------------------------------------------------------*)
(* SNAPI Interface commands.                               *)
(*---------------------------------------------------------*)
DATA_EVENT[vdvMod]
{
  COMMAND :
  {
    STACK_VAR CHAR    cCmd[DUET_MAX_CMD_LEN]
    STACK_VAR CHAR    cHeader[DUET_MAX_HDR_LEN]
    STACK_VAR CHAR    cValue[DUET_MAX_PARAM_LEN]

    cCmd    = DATA.TEXT
    cHeader = DuetParseCmdHeader(cCmd)
    cValue= DuetParseCmdParam(cCmd)

    SWITCH(cHeader)
    {
    (*-----------------------*)
    (*-- Debug             --*)
    (*-----------------------*)
      CASE 'DEBUG'    :
      {
        nDebug = ATOI(cValue)
        if(nDebug < 1) nDebug=1;
        else if (nDebug > 4) nDebug=4;
        send_string 0, "'Debug is now ',itoa(nDebug)"
      }
      CASE '?DEBUG'   :
      {
        send_string 0, "'Debug is now ',itoa(nDebug)"
      }
    (*-----------------------*)
    (*-- Address           --*)
    (*-----------------------*)
      CASE 'ADDRESS'  :
      {
        STACK_VAR INTEGER nByte1

        nByte1 = ATOI(cValue)
        IF(nByte1 > 0 && nByte1 < 248)      //Valid Range for Device Address
        {
          PowerScoutAddress = nByte1
          send_string 0,"'ADDRESS-',itoa(PowerScoutAddress)"
        }
        ELSE
        {
          send_string 0,"'ERROR:  Device Address is out of range (1-247) ',itoa(nByte1)"
        }
      }
      CASE '?ADDRESS' :
      {
        send_string 0,"'ADDRESS-',itoa(PowerScoutAddress)"
      }
    (*-----------------------*)
    (*-- Clear             --*)
    (*-----------------------*)
      CASE 'CLEAR' :
      {
        STACK_VAR INTEGER nAddr

        nAddr = ATOI(cValue)

        IF(nAddr <= 5)
    	    fnCommandStack ("(PowerScoutAddress+nAddr),$06,$00,$00,$00,$00")
      }
      CASE 'CLEARALL' :
      {
    	  fnCommandStack ("(PowerScoutAddress+0),$06,$00,$00,$00,$00")
    	  fnCommandStack ("(PowerScoutAddress+1),$06,$00,$00,$00,$00")
    	  fnCommandStack ("(PowerScoutAddress+2),$06,$00,$00,$00,$00")
    	  fnCommandStack ("(PowerScoutAddress+3),$06,$00,$00,$00,$00")
    	  fnCommandStack ("(PowerScoutAddress+4),$06,$00,$00,$00,$00")
    	  fnCommandStack ("(PowerScoutAddress+5),$06,$00,$00,$00,$00")
      }
    (*-----------------------*)
    (*-- Passthru          --*)
    (*-----------------------*)
      CASE 'PASSTHRU' :
      {
        STACK_VAR INTEGER nByte1
        STACK_VAR INTEGER i
        STACK_VAR CHAR sTemp[10]

        IF (nDebug > 2)
        {
          send_string 0, "'Passthru received.'"
        }

        FOR(i=1; i<7; i++)
        {
            nByte1=HEXTOI(GET_BUFFER_STRING(cValue,2))
            sTemp[i]=TYPE_CAST(nByte1)
            IF (nDebug > 3)
            {
              send_string 0, "'sTemp[',ITOA(i),'] = "',sTemp[i],'"'"
            }
        }
        fnCommandStack("sTemp[1],sTemp[2],sTemp[3],sTemp[4],sTemp[5],sTemp[6]");
      }
    }
  }
}

(*---------------------------------------------------------*)
(*-- Device queue.                                       --*)
(*---------------------------------------------------------*)
TIMELINE_EVENT [POWER_STACK_TL]
{
  SWITCH (TIMELINE.SEQUENCE)
  {
    CASE 1:
    {
      IF (nDebug > 2)
      {
        send_string 0, "'SENDING:', uCommandStack[nStackPointer].sCommand"
      }
      SEND_STRING dvDev,uCommandStack[nStackPointer].sCommand
      uCommandStack[nStackPointer].sCommand = ''
      IF (nStackPointer < 50) nStackPointer ++
      ELSE nStackPointer = 1
      IF (nStackPointer = nStackCounter)
      {
        nStackCounter = 1
        nStackPointer = 1
        fnTimelineStop (POWER_STACK_TL)
      }
    }
  }
}

(*---------------------------------------------------------*)
(*-- Device polling.                                     --*)
(*---------------------------------------------------------*)
TIMELINE_EVENT [POWER_POLL_TL]
{
  nPollCounter = TIMELINE.SEQUENCE

  IF(TIMELINE.SEQUENCE = 1)
  {
    CircuitAddressOffset++
    IF(CircuitAddressOffset > 5)
      CircuitAddressOffset = 0
  }

  IF (nDebug == 2)
  {
    send_string 0, "'Polling:', ITOA(nPollCounter), ' adding ',ITOA(CircuitAddressOffset)"
  }

  fnNextCommand(nPollCounter,PowerScoutAddress+CircuitAddressOffset)
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
