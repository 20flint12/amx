PROGRAM_NAME='08_Power'
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*                                                         *)
(*  Rev  1.01     05/25/2010   CWR                         *)
(*  - Added aggregate total for total kWh.                 *)
(*                                                         *)
(*  Rev  1.00     05/01/2010   CWR                         *)
(*  - Initial creation.                                    *)
(***********************************************************)

INCLUDE 'snapi.axi'

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(*-- NI-700 -----------------------------------------------*)
dvSCOUT1    = 5001:1:0    // 485 Dent Industries PowerScout 18
vdvSCOUT1   = 33003:1:0


(*-- Panels -----------------------------------------------*)
dvTP1a      = 10001:1:0   // NXD-500i


(*-- RMS (See RMSMain.axi) --------------------------------*)
//dvRMSSocket              = 0:3:0
//vdvRMSEngine             = 33001:1:0
//vdvCLActions             = 33002:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(*-- Name and Ver of this include -------------------------*)
CHAR AXS_NAME[]           = '08_Power'
CHAR AXS_VER[]            = '1.01'


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(*-- My Panels --------------------------------------------*)
CONSTANT DEV dvPnls1a[] = { dvTP1a }


(***********************************************************)
(*                INCLUDE DEFINITIONS GO BELOW             *)
(***********************************************************)

(*---------------------------------------------------------*)
(*-- Framework                                           --*)
(*---------------------------------------------------------*)


(*---------------------------------------------------------*)
(*-- Device Drivers                                      --*)
(*---------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Applications                                        --*)
(*---------------------------------------------------------*)
INCLUDE '08_Power_RMSMain.axi'
INCLUDE 'RMSGlobals.axi'


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


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(*-- Print version ----------------------------------------*)
SEND_STRING 0,"'  Running ',AXS_NAME,' v',AXS_VER"


(***********************************************************)
(*                MODULE  CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_MODULE '__DENT_SCOUT__' comm(vdvSCOUT1, dvSCOUT1)


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- Initialization goes here ------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Initialize panels.                                  --*)
(*---------------------------------------------------------*)
DATA_EVENT[dvPnls1a]
{
  ONLINE :
  {
    SEND_COMMAND vdvSCOUT1,'REFRESH'
  }
}


(*---------------------------------------------------------*)
(*-- Initialize PowerScout.                              --*)
(*---------------------------------------------------------*)
DATA_EVENT[dvSCOUT1]
{
  ONLINE :
  {
// NOTE: This is done in the module..
//   SEND_COMMAND DATA.DEVICE,'SET BAUD 9600,N,8,1 485 ENABLE'
//   SEND_COMMAND DATA.DEVICE,'RXON'
  }
}


(*---------------------------------------------------------*)
(*-- Module replies.                                     --*)
(*---------------------------------------------------------*)
DATA_EVENT[vdvSCOUT1]
{
  COMMAND :
  {
    STACK_VAR CHAR    cCmd[DUET_MAX_CMD_LEN]
    STACK_VAR CHAR    cHeader[DUET_MAX_HDR_LEN]
    STACK_VAR CHAR    cValue1[DUET_MAX_PARAM_LEN]
    STACK_VAR CHAR    cValue2[DUET_MAX_PARAM_LEN]

    cCmd    = DATA.TEXT
    cHeader = DuetParseCmdHeader(cCmd)
    cValue1 = DuetParseCmdParam(cCmd)
    cValue2 = DuetParseCmdParam(cCmd)

    SWITCH(cHeader)
    {
    (*-----------------------*)
    (*-- Voltage           --*)
    (*-----------------------*)
      CASE 'VOLTS'    :
      {
        STACK_VAR INTEGER nCircuit
        STACK_VAR INTEGER nPhase
        STACK_VAR CHAR    cValue3[DUET_MAX_PARAM_LEN]
        STACK_VAR SLONG   slValue

        nCircuit = ATOI(cValue1)
        nPhase   = ATOI(cValue2)
        cValue3  = DuetParseCmdParam(cCmd)
        slValue  = ATOL(cValue3)

        SELECT
        {
          ACTIVE((nCircuit=1) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT1-',cValue3"
          ACTIVE((nCircuit=2) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT2-',cValue3"
          ACTIVE((nCircuit=3) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT3-',cValue3"
          ACTIVE((nCircuit=4) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT4-',cValue3"
          ACTIVE((nCircuit=5) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT5-',cValue3"
          ACTIVE((nCircuit=6) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT6-',cValue3"
        }

        SELECT
        {
          ACTIVE((nCircuit=1) && (nPhase=1)) : RMSSetScoutHVACVoltage           (slValue)
          ACTIVE((nCircuit=2) && (nPhase=1)) : RMSSetScoutLightingVoltage       (slValue)
          ACTIVE((nCircuit=3) && (nPhase=1)) : RMSSetScoutAVVoltage             (slValue)
          ACTIVE((nCircuit=4) && (nPhase=1)) : RMSSetScoutDigitalMediaVoltage   (slValue)
          ACTIVE((nCircuit=5) && (nPhase=1)) : RMSSetScoutCCTVVoltage           (slValue)
          ACTIVE((nCircuit=6) && (nPhase=1)) : RMSSetScoutBuildingAccessVoltage (slValue)
        }
      }
    (*-----------------------*)
    (*-- Current           --*)
    (*-----------------------*)
      CASE 'AMPS'     :
      {
        STACK_VAR INTEGER nCircuit
        STACK_VAR INTEGER nPhase
        STACK_VAR CHAR    cValue3[DUET_MAX_PARAM_LEN]
        STACK_VAR SLONG   slValue

        nCircuit = ATOI(cValue1)
        nPhase   = ATOI(cValue2)
        cValue3  = DuetParseCmdParam(cCmd)
        slValue  = ATOL(cValue3)

        SELECT
        {
          ACTIVE((nCircuit=1) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT11-',cValue3"
          ACTIVE((nCircuit=2) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT12-',cValue3"
          ACTIVE((nCircuit=3) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT13-',cValue3"
          ACTIVE((nCircuit=4) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT14-',cValue3"
          ACTIVE((nCircuit=5) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT15-',cValue3"
          ACTIVE((nCircuit=6) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT16-',cValue3"
        }

        SELECT
        {
          ACTIVE((nCircuit=1) && (nPhase=1)) : RMSSetScoutHVACCurrent           (slValue)
          ACTIVE((nCircuit=2) && (nPhase=1)) : RMSSetScoutLightingCurrent       (slValue)
          ACTIVE((nCircuit=3) && (nPhase=1)) : RMSSetScoutAVCurrent             (slValue)
          ACTIVE((nCircuit=4) && (nPhase=1)) : RMSSetScoutDigitalMediaCurrent   (slValue)
          ACTIVE((nCircuit=5) && (nPhase=1)) : RMSSetScoutCCTVCurrent           (slValue)
          ACTIVE((nCircuit=6) && (nPhase=1)) : RMSSetScoutBuildingAccessCurrent (slValue)
        }
      }
    (*-----------------------*)
    (*-- Power             --*)
    (*-----------------------*)
      CASE 'WATTS'    :
      {
        STACK_VAR INTEGER nCircuit
        STACK_VAR INTEGER nPhase
        STACK_VAR CHAR    cValue3[DUET_MAX_PARAM_LEN]
        STACK_VAR SLONG   slValue

        nCircuit = ATOI(cValue1)
        nPhase   = ATOI(cValue2)
        cValue3  = DuetParseCmdParam(cCmd)
        slValue  = ATOL(cValue3)

        SELECT
        {
          ACTIVE((nCircuit=1) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT21-',cValue3"
          ACTIVE((nCircuit=2) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT22-',cValue3"
          ACTIVE((nCircuit=3) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT23-',cValue3"
          ACTIVE((nCircuit=4) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT24-',cValue3"
          ACTIVE((nCircuit=5) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT25-',cValue3"
          ACTIVE((nCircuit=6) && (nPhase=1)) : SEND_COMMAND dvPnls1a,"'TEXT26-',cValue3"
        }

        SELECT
        {
          ACTIVE((nCircuit=1) && (nPhase=1)) : RMSSetScoutHVACPower           (slValue)
          ACTIVE((nCircuit=2) && (nPhase=1)) : RMSSetScoutLightingPower       (slValue)
          ACTIVE((nCircuit=3) && (nPhase=1)) : RMSSetScoutAVPower             (slValue)
          ACTIVE((nCircuit=4) && (nPhase=1)) : RMSSetScoutDigitalMediaPower   (slValue)
          ACTIVE((nCircuit=5) && (nPhase=1)) : RMSSetScoutCCTVPower           (slValue)
          ACTIVE((nCircuit=6) && (nPhase=1)) : RMSSetScoutBuildingAccessPower (slValue)
        }
      }
    (*-----------------------*)
    (*-- Total Current     --*)
    (*-----------------------*)
      CASE 'TOTAL AMPS'  :
      {
        STACK_VAR INTEGER nCircuit

        nCircuit = ATOI(cValue1)

        SELECT
        {
          ACTIVE(nCircuit=1) : SEND_COMMAND dvPnls1a,"'TEXT31-',cValue2"
          ACTIVE(nCircuit=2) : SEND_COMMAND dvPnls1a,"'TEXT32-',cValue2"
          ACTIVE(nCircuit=3) : SEND_COMMAND dvPnls1a,"'TEXT33-',cValue2"
          ACTIVE(nCircuit=4) : SEND_COMMAND dvPnls1a,"'TEXT34-',cValue2"
          ACTIVE(nCircuit=5) : SEND_COMMAND dvPnls1a,"'TEXT35-',cValue2"
          ACTIVE(nCircuit=6) : SEND_COMMAND dvPnls1a,"'TEXT36-',cValue2"
        }
      }
    (*-----------------------*)
    (*-- Total Power       --*)
    (*-----------------------*)
      CASE 'TOTAL WATTS' :
      {
        STACK_VAR INTEGER nCircuit

        nCircuit = ATOI(cValue1)

        SELECT
        {
          ACTIVE(nCircuit=1) : SEND_COMMAND dvPnls1a,"'TEXT41-',cValue2"
          ACTIVE(nCircuit=2) : SEND_COMMAND dvPnls1a,"'TEXT42-',cValue2"
          ACTIVE(nCircuit=3) : SEND_COMMAND dvPnls1a,"'TEXT43-',cValue2"
          ACTIVE(nCircuit=4) : SEND_COMMAND dvPnls1a,"'TEXT44-',cValue2"
          ACTIVE(nCircuit=5) : SEND_COMMAND dvPnls1a,"'TEXT45-',cValue2"
          ACTIVE(nCircuit=6) : SEND_COMMAND dvPnls1a,"'TEXT46-',cValue2"
        }
      }
    (*-----------------------*)
    (*-- Total kWH         --*)
    (*-----------------------*)
      CASE 'TOTAL KWH'   :
      {
        LOCAL_VAR FLOAT   fTotals[7]
        STACK_VAR INTEGER nCircuit

        nCircuit = ATOI(cValue1)
        fTotals[nCircuit] = ATOF(cValue2)
        fTotals[7] = fTotals[1] + fTotals[2] + fTotals[3] + fTotals[4] + fTotals[5] + fTotals[6]

        SELECT
        {
          ACTIVE(nCircuit=1) : SEND_COMMAND dvPnls1a,"'TEXT51-',cValue2"
          ACTIVE(nCircuit=2) : SEND_COMMAND dvPnls1a,"'TEXT52-',cValue2"
          ACTIVE(nCircuit=3) : SEND_COMMAND dvPnls1a,"'TEXT53-',cValue2"
          ACTIVE(nCircuit=4) : SEND_COMMAND dvPnls1a,"'TEXT54-',cValue2"
          ACTIVE(nCircuit=5) : SEND_COMMAND dvPnls1a,"'TEXT55-',cValue2"
          ACTIVE(nCircuit=6) : SEND_COMMAND dvPnls1a,"'TEXT56-',cValue2"
        }
        SEND_COMMAND dvPnls1a,"'TEXT50-',FTOA(fTotals[7])"
      }
    }
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- RMS hooks go here -------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Add i!-ConnectLinx actions.                         --*)
(*---------------------------------------------------------*)
CHANNEL_EVENT[vdvRMSEngine,250] // RMS server online
{
  ON :
  {
    RMSGlobals (8)
  }
}

BUTTON_EVENT[vdvCLActions,1] // Action 1
BUTTON_EVENT[vdvCLActions,2] // Action 2
BUTTON_EVENT[vdvCLActions,3] // Action 3
BUTTON_EVENT[vdvCLActions,4] // Action 4
BUTTON_EVENT[vdvCLActions,5] // Action 5
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 1 : {}
      CASE 2 : {}
      CASE 3 : {}
      CASE 4 : {}
      CASE 5 : {}
    }
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- GUI goes here -----------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Reset accumulated totals.                           --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls1a,100]
{
  PUSH :
  {
    IF(![BUTTON.INPUT])
    {
      SEND_COMMAND vdvSCOUT1,'CLEARALL'

      SET_PULSE_TIME(20)
      PULSE[dvPnls1a,100]
      SET_PULSE_TIME(5)
    }
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

