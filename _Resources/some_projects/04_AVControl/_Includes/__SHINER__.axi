PROGRAM_NAME='__SHINER__'
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*                                                         *)
(*  Rev  1.00     05/01/2010   CWR                         *)
(*  - Initial creation.                                    *)
(***********************************************************)

INCLUDE 'snapi.axi'

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(*-- Name and Ver of this include -------------------------*)
CHAR AXS_NAME__SHINER__[]           = '__SHINER__'
CHAR AXS_VER__SHINER__[]            = '1.00'


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(*-- Power Module -----------------------------------------*)
STRUCTURE _uCircuit__SHINER__
{
  FLOAT   fPower
  FLOAT   fCurrent
  FLOAT   fPFactor
  FLOAT   fEnergy
  INTEGER nPhaseAngle
  INTEGER nTrigger
}

STRUCTURE _uAxlink__SHINER__
{
  FLOAT   fPower
  FLOAT   fCurrent
}

STRUCTURE _uState__SHINER__
{
  FLOAT   fTemp
  FLOAT   fInVoltage
  FLOAT   fAXVoltage
  _uCircuit__SHINER__ uCircuit[8]
  _uAxlink__SHINER__  uAxlink[2]
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(*-- Power Module -----------------------------------------*)
VOLATILE _uState__SHINER__ uState__SHINER__


(*-- Panels -----------------------------------------------*)
CONSTANT INTEGER iBTN_Relay__SHINER__[]   = {  1,  2,  3,  4,  5,  6,  7,  8}
CONSTANT INTEGER iBTN_Phase__SHINER__[]   = { 33, 34, 35, 36, 37, 38, 39, 40}
CONSTANT INTEGER iBTN_Trigger__SHINER__[] = { 41, 42, 43, 44, 45, 46, 47, 48}
CONSTANT INTEGER iBTN_PwrSense__SHINER__[]= {  9, 10, 11, 12, 13, 14, 15, 16}

CONSTANT INTEGER iVT_Current__SHINER__[]  = {  1,  2,  3,  4,  5,  6,  7,  8}
CONSTANT INTEGER iVT_PFactor__SHINER__[]  = {  9, 10, 11, 12, 13, 14, 15, 16}
CONSTANT INTEGER iVT_Energy__SHINER__[]   = { 17, 18, 19, 20, 21, 22, 23, 24}

CONSTANT INTEGER nVT_AxPower__SHINER__[]  = { 27, 28 }
CONSTANT INTEGER nVT_AxCurrent__SHINER__[]= { 29, 30 }

CONSTANT INTEGER nVT_Misc__SHINER__[]     = { 25, 26, 31 }


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

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- GUI helper functions ----------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Touch panel feedback.                               --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION setPnlFB__SHINER__ (DEV dvPNL, INTEGER nPnlIdx)
{
(*-- Relays --*)
  [dvPNL,iBTN_Relay__SHINER__[1]] = [dvDEVs__SHINER__[1],1]
  [dvPNL,iBTN_Relay__SHINER__[2]] = [dvDEVs__SHINER__[2],1]
  [dvPNL,iBTN_Relay__SHINER__[3]] = [dvDEVs__SHINER__[3],1]
  [dvPNL,iBTN_Relay__SHINER__[4]] = [dvDEVs__SHINER__[4],1]
  [dvPNL,iBTN_Relay__SHINER__[5]] = [dvDEVs__SHINER__[5],1]
  [dvPNL,iBTN_Relay__SHINER__[6]] = [dvDEVs__SHINER__[6],1]
  [dvPNL,iBTN_Relay__SHINER__[7]] = [dvDEVs__SHINER__[7],1]
  [dvPNL,iBTN_Relay__SHINER__[8]] = [dvDEVs__SHINER__[8],1]

(*-- Power Sense --*)
  [dvPNL,iBTN_PwrSense__SHINER__[1]] = [dvDEVs__SHINER__[1],255]
  [dvPNL,iBTN_PwrSense__SHINER__[2]] = [dvDEVs__SHINER__[2],255]
  [dvPNL,iBTN_PwrSense__SHINER__[3]] = [dvDEVs__SHINER__[3],255]
  [dvPNL,iBTN_PwrSense__SHINER__[4]] = [dvDEVs__SHINER__[4],255]
  [dvPNL,iBTN_PwrSense__SHINER__[5]] = [dvDEVs__SHINER__[5],255]
  [dvPNL,iBTN_PwrSense__SHINER__[6]] = [dvDEVs__SHINER__[6],255]
  [dvPNL,iBTN_PwrSense__SHINER__[7]] = [dvDEVs__SHINER__[7],255]
  [dvPNL,iBTN_PwrSense__SHINER__[8]] = [dvDEVs__SHINER__[8],255]

(*-- Temperature --*)
  [dvPNL,17] = [dvDEVs__SHINER__[1],2]         // Scale
  SEND_LEVEL dvPNL,9,uState__SHINER__.fTemp    // Temperature

(*-- Circuit Power --*)
  SEND_LEVEL dvPNL,1,uState__SHINER__.uCircuit[1].fPower
  SEND_LEVEL dvPNL,2,uState__SHINER__.uCircuit[2].fPower
  SEND_LEVEL dvPNL,3,uState__SHINER__.uCircuit[3].fPower
  SEND_LEVEL dvPNL,4,uState__SHINER__.uCircuit[4].fPower
  SEND_LEVEL dvPNL,5,uState__SHINER__.uCircuit[5].fPower
  SEND_LEVEL dvPNL,6,uState__SHINER__.uCircuit[6].fPower
  SEND_LEVEL dvPNL,7,uState__SHINER__.uCircuit[7].fPower
  SEND_LEVEL dvPNL,8,uState__SHINER__.uCircuit[8].fPower
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(*-- Print version ----------------------------------------*)
SEND_STRING 0,"'  Running ',AXS_NAME__SHINER__,' v',AXS_VER__SHINER__"


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- State from Shiner -------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Shiner levels.                                      --*)
(*---------------------------------------------------------*)
LEVEL_EVENT[dvDEVs__SHINER__,0]
{
  STACK_VAR INTEGER nIdx

  nIdx = GET_LAST(dvDEVs__SHINER__)

  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: //Power
    {
      uState__SHINER__.uCircuit[nIdx].fPower   = LEVEL.VALUE / 10.0
    }
    CASE 2: //Current
    {
      uState__SHINER__.uCircuit[nIdx].fCurrent = LEVEL.VALUE / 1000.000 //Amps
      SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(iVT_Current__SHINER__[nIdx]),',0,',FTOA(uState__SHINER__.uCircuit[nIdx].fCurrent)"
    }
    CASE 3: //Power Factor
    {
      uState__SHINER__.uCircuit[nIdx].fPFactor = LEVEL.VALUE / 100.00 //W/VA
      SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(iVT_PFactor__SHINER__[nIdx]),',0,',FTOA(uState__SHINER__.uCircuit[nIdx].fPFactor)"
    }
    CASE 4: //Energy
    {
      uState__SHINER__.uCircuit[nIdx].fEnergy  = LEVEL.VALUE * 100.0 // W-Hr
      SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(iVT_Energy__SHINER__ [nIdx]),',0,',FTOA(uState__SHINER__.uCircuit[nIdx].fEnergy )"
    }
    CASE 5:
    {
      SWITCH (nIdx)
      {
        CASE 1: //Input Voltage
        {
          uState__SHINER__.fInVoltage = LEVEL.VALUE / 10.0
          SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(nVT_Misc__SHINER__[1]),',0,',FTOA(uState__SHINER__.fInVoltage)"
        }
        CASE 2: //AX Voltage
        {
          uState__SHINER__.fAXVoltage = LEVEL.VALUE /10.0
          SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(nVT_Misc__SHINER__[2]),',0,',FTOA(uState__SHINER__.fAXVoltage)"
        }
      }
    }
    CASE 6: //AX Power
    {
      SWITCH (nIdx)
      {
        CASE 1: //Axlink1
        {
          uState__SHINER__.uAxlink[nIdx].fPower = LEVEL.VALUE/1.00
          SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(nVT_AxPower__SHINER__[nIdx]),',0,',FTOA(uState__SHINER__.uAxlink[nIdx].fPower)"
        }
        CASE 2: //Axlink2
        {
          uState__SHINER__.uAxlink[nIdx].fPower = LEVEL.VALUE/1.00
          SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(nVT_AxPower__SHINER__[nIdx]),',0,',FTOA(uState__SHINER__.uAxlink[nIdx].fPower)"
        }
      }
    }
    CASE 7: //AXCurrent
    {
      SWITCH (nIdx)
      {
        CASE 1: //Axlink1
        {
          uState__SHINER__.uAxlink[nIdx].fCurrent = LEVEL.VALUE/1.00
          SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(nVT_AxCurrent__SHINER__[nIdx]),',0,',FTOA(uState__SHINER__.uAxlink[nIdx].fCurrent)"
        }
        CASE 2: //Axlink2
        {
          uState__SHINER__.uAxlink[nIdx].fCurrent = LEVEL.VALUE/1.00
          SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(nVT_AxCurrent__SHINER__[nIdx]),',0,',FTOA(uState__SHINER__.uAxlink[nIdx].fCurrent)"
        }
      }
    }
    CASE 8: //Temp
    {
      uState__SHINER__.fTemp = LEVEL.VALUE / 10.0
    }
  }
}

(*---------------------------------------------------------*)
(*-- Shiner data.                                        --*)
(*---------------------------------------------------------*)
DATA_EVENT[dvDEVs__SHINER__[1]]
{
  COMMAND:
  {
    STACK_VAR INTEGER nCircuit

    SELECT
    {
      ACTIVE(FIND_STRING(DATA.TEXT,'PHASEANGLE-',1)):
      {
        REMOVE_STRING(DATA.TEXT,'-',1)
        nCircuit = ATOI(REMOVE_STRING(DATA.TEXT,'=',1))
        uState__SHINER__.uCircuit[nCircuit].nPhaseAngle = ATOI(DATA.TEXT)
        SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(iBTN_Phase__SHINER__[nCircuit]),',0,',FTOA(uState__SHINER__.uCircuit[nCircuit].nPhaseAngle)"
      }
      ACTIVE(FIND_STRING(DATA.TEXT,'TRIGGER-',1)):
      {
        REMOVE_STRING(DATA.TEXT,'-',1)
        nCircuit = ATOI(REMOVE_STRING(DATA.TEXT,'=',1))
        uState__SHINER__.uCircuit[nCircuit].nTrigger = ATOI(DATA.TEXT)
        SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(iBTN_Trigger__SHINER__[nCircuit]),',0,',FTOA(uState__SHINER__.uCircuit[nCircuit].nTrigger)"
      }
      ACTIVE(FIND_STRING(DATA.TEXT,'V',1)):
      {
        REMOVE_STRING(DATA.TEXT,'V',1)
        SEND_COMMAND dvPNLs__SHINER__,"'^TXT-',ITOA(nVT_Misc__SHINER__[3]),',0,',DATA.TEXT"
      }
    }
  }
}

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- GUI goes here -----------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

BUTTON_EVENT[dvPNLs__SHINER__,iBTN_Relay__SHINER__]
{
  PUSH:
  {
    STACK_VAR INTEGER nIdx
    nIdx = GET_LAST(iBTN_Relay__SHINER__)
    [dvDEVs__SHINER__[nIdx],1] = ![dvDEVs__SHINER__[nIdx],1]
  }
}

BUTTON_EVENT[dvPNLs__SHINER__,iBTN_Phase__SHINER__]
{
  PUSH:
  {
    SEND_COMMAND dvDEVs__SHINER__[1],"'?PHASEANGLE-',ITOA(GET_LAST(iBTN_Phase__SHINER__))"
  }
}

BUTTON_EVENT[dvPNLs__SHINER__,iBTN_Trigger__SHINER__]
{
  PUSH:
  {
    SEND_COMMAND dvDEVs__SHINER__[1],"'?TRIGGER-',ITOA(GET_LAST(iBTN_Trigger__SHINER__))"
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

