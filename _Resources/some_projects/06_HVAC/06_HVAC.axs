PROGRAM_NAME='06_HVAC'
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*                                                         *)
(*  Rev  1.02     06/07/2010   CWR                         *)
(*  - Added RMS support for stats 1/2/3 setpoints.         *)
(*                                                         *)
(*  Rev  1.01     05/17/2010   CWR                         *)
(*  - Added RMS hooks for hvac snapi commands.             *)
(*                                                         *)
(*  Rev  1.00     05/01/2010   CWR                         *)
(*  - Initial creation.                                    *)
(***********************************************************)

#INCLUDE 'snapi.axi'

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(*-- FieldServer ------------------------------------------*)
dvHVAC01    = 0:4:0       // FieldServer FSB-3510
vdvHVAC01   = 33003:1:0


(*-- Panels -----------------------------------------------*)
dvTP1a      = 10001:1:0   // NXD-500i
dvTPav      = 10001:1:140 // Destiny

(*-- RMS (See RMSMain.axi) --------------------------------*)
//dvRMSSocket              = 0:3:0
//vdvRMSEngine             = 33001:1:0
//vdvCLActions             = 33002:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(*-- Name and Ver of this include -------------------------*)
CHAR AXS_NAME[]           = '06_HVAC'
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
CONSTANT DEV dvPnls1a[] = { dvTP1a,dvTPav }


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
INCLUDE '06_HVAC_RMSMain.axi'
INCLUDE 'RMSGlobals.axi'


(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- GUI helper functions ----------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(*-- Print version ----------------------------------------*)
SEND_STRING 0,"'  Running ',AXS_NAME,' v',AXS_VER"


(***********************************************************)
(*                MODULE  CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_MODULE '__FS_FSB3510__' mdlHVAC01(vdvHVAC01, dvHVAC01, dvPnls1a)


(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
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
  }
}

(*---------------------------------------------------------*)
(*-- Initialize HVAC.                                    --*)
(*---------------------------------------------------------*)
DATA_EVENT[vdvHVAC01]
{
  ONLINE :
  {
    SEND_COMMAND DATA.DEVICE,"'PROPERTY-IP_Address,192.168.1.162'"
    SEND_COMMAND DATA.DEVICE,"'PROPERTY-Port,80'"
  }
  COMMAND :
  {
    STACK_VAR CHAR    cCmd[DUET_MAX_CMD_LEN]
    STACK_VAR CHAR    cHeader[DUET_MAX_HDR_LEN]
    STACK_VAR INTEGER nStat
    STACK_VAR CHAR    cValue[DUET_MAX_PARAM_LEN]
    STACK_VAR INTEGER nIdx
    STACK_VAR SLONG   slValue

    cCmd = DATA.TEXT
    cHeader = DuetParseCmdHeader(cCmd)
    nStat   = ATOI(DuetParseCmdParam(cCmd))
    cValue  = DuetParseCmdParam(cCmd)
    slValue = ATOI(cValue)

    SWITCH(nStat)
    {
      CASE 1 :
      {
        SWITCH(cHeader)
        {
          CASE 'MODE'     : RMSSetBacnetGatewayStat1Mode (cValue)
          CASE 'FAN'      : RMSSetBacnetGatewayStat1Fan  (cValue)
          CASE 'OCC'      : RMSSetBacnetGatewayStat1Occ  (slValue)
          CASE 'SP_ROOM'  : RMSSetBacnetGatewayStat1RoomSetpoint (slValue)
          CASE 'SPO_HEAT' : RMSSetBacnetGatewayStat1HeatSetpointOccupied (slValue)
          CASE 'SPO_COOL' : RMSSetBacnetGatewayStat1CoolSetpointOccupied (slValue)
          CASE 'SPU_HEAT' : RMSSetBacnetGatewayStat1HeatSetpointUnoccupied (slValue)
          CASE 'SPU_COOL' : RMSSetBacnetGatewayStat1CoolSetpointUnoccupied (slValue)
        }
      }
      CASE 2 :
      {
        SWITCH(cHeader)
        {
          CASE 'MODE'     : RMSSetBacnetGatewayStat2Mode (cValue)
          CASE 'FAN'      : RMSSetBacnetGatewayStat2Fan  (cValue)
          CASE 'OCC'      : RMSSetBacnetGatewayStat2Occ  (slValue)
          CASE 'SP_ROOM'  : RMSSetBacnetGatewayStat2RoomSetpoint (slValue)
          CASE 'SPO_HEAT' : RMSSetBacnetGatewayStat2HeatSetpointOccupied (slValue)
          CASE 'SPO_COOL' : RMSSetBacnetGatewayStat2CoolSetpointOccupied (slValue)
          CASE 'SPU_HEAT' : RMSSetBacnetGatewayStat2HeatSetpointUnoccupied (slValue)
          CASE 'SPU_COOL' : RMSSetBacnetGatewayStat2CoolSetpointUnoccupied (slValue)
        }
      }
      CASE 3 :
      {
        SWITCH(cHeader)
        {
          CASE 'MODE'     : RMSSetBacnetGatewayStat3Mode (cValue)
          CASE 'FAN'      : RMSSetBacnetGatewayStat3Fan  (cValue)
          CASE 'OCC'      : RMSSetBacnetGatewayStat3Occ  (slValue)
          CASE 'SP_ROOM'  : RMSSetBacnetGatewayStat3RoomSetpoint (slValue)
          CASE 'SPO_HEAT' : RMSSetBacnetGatewayStat3HeatSetpointOccupied (slValue)
          CASE 'SPO_COOL' : RMSSetBacnetGatewayStat3CoolSetpointOccupied (slValue)
          CASE 'SPU_HEAT' : RMSSetBacnetGatewayStat3HeatSetpointUnoccupied (slValue)
          CASE 'SPU_COOL' : RMSSetBacnetGatewayStat3CoolSetpointUnoccupied (slValue)
        }
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
    RMSGlobals (6)

    SEND_COMMAND vdvCLActions,'ADD FOLDER-HVAC'
    SEND_COMMAND vdvCLActions,'ADD FOLDER-HVAC'
    SEND_COMMAND vdvCLActions,'ADD ACTION-51,Stat1 Mode,Mode,HVAC'
    SEND_COMMAND vdvCLActions,'ADD EARG-Stat1 Mode,Mode,Off,Off,Auto,Heat,Cool'
    SEND_COMMAND vdvCLActions,'ADD ACTION-61,Stat1 Fan,Fan,HVAC'
    SEND_COMMAND vdvCLActions,'ADD EARG-Stat1 Fan,Fan,Off,Off,Low,Med,High'
    SEND_COMMAND vdvCLActions,'ADD ACTION-71,Stat1 Heat SPO,Heat setpoint (Occupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat1 Heat SPO,Heat setpoint (Occupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-72,Stat1 Cool SPO,Cool setpoint (Occupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat1 Cool SPO,Cool setpoint (Occupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-73,Stat1 Heat SPU,Heat setpoint (Unoccupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat1 Heat SPU,Heat setpoint (Unoccupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-74,Stat1 Cool SPU,Cool setpoint (Unoccupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat1 Cool SPU,Cool setpoint (Unoccupied),55,99,1,'

    SEND_COMMAND vdvCLActions,'ADD ACTION-52,Stat2 Mode,Mode,HVAC'
    SEND_COMMAND vdvCLActions,'ADD EARG-Stat2 Mode,Mode,Off,Off,Auto,Heat,Cool'
    SEND_COMMAND vdvCLActions,'ADD ACTION-62,Stat2 Fan,Fan,HVAC'
    SEND_COMMAND vdvCLActions,'ADD EARG-Stat2 Fan,Fan,Off,Off,Low,Med,High'
    SEND_COMMAND vdvCLActions,'ADD ACTION-81,Stat2 Heat SPO,Heat setpoint (Occupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat2 Heat SPO,Heat setpoint (Occupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-82,Stat2 Cool SPO,Cool setpoint (Occupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat2 Cool SPO,Cool setpoint (Occupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-83,Stat2 Heat SPU,Heat setpoint (Unoccupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat2 Heat SPU,Heat setpoint (Unoccupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-84,Stat2 Cool SPU,Cool setpoint (Unoccupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat2 Cool SPU,Cool setpoint (Unoccupied),55,99,1,'

    SEND_COMMAND vdvCLActions,'ADD ACTION-53,Stat3 Mode,Mode,HVAC'
    SEND_COMMAND vdvCLActions,'ADD EARG-Stat3 Mode,Mode,Off,Off,Auto,Heat,Cool'
    SEND_COMMAND vdvCLActions,'ADD ACTION-63,Stat3 Fan,Fan,HVAC'
    SEND_COMMAND vdvCLActions,'ADD EARG-Stat3 Fan,Fan,Off,Off,Low,Med,High'
    SEND_COMMAND vdvCLActions,'ADD ACTION-91,Stat3 Heat SPO,Heat setpoint (Occupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat3 Heat SPO,Heat setpoint (Occupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-92,Stat3 Cool SPO,Cool setpoint (Occupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat3 Cool SPO,Cool setpoint (Occupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-93,Stat3 Heat SPU,Heat setpoint (Unoccupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat3 Heat SPU,Heat setpoint (Unoccupied),55,99,1,'
    SEND_COMMAND vdvCLActions,'ADD ACTION-94,Stat3 Cool SPU,Cool setpoint (Unoccupied),HVAC'
    SEND_COMMAND vdvCLActions,'ADD NARG-Stat3 Cool SPU,Cool setpoint (Unoccupied),55,99,1,'
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
      CASE 1 :
      CASE 2 :
      CASE 3 :
      CASE 4 :
      {
        SEND_COMMAND vdvHVAC01,"'MODE-',ITOA(BUTTON.INPUT.CHANNEL),',OFF'"

        SEND_COMMAND dvPnls1a,'@PPN-RMS_ALERT'
      }
      CASE 5 :
      {
        SEND_COMMAND vdvHVAC01,"'MODE-1,AUTO'"
        SEND_COMMAND vdvHVAC01,"'MODE-2,AUTO'"
        SEND_COMMAND vdvHVAC01,"'MODE-3,AUTO'"

        SEND_COMMAND dvPnls1a,'@PPK-RMS_ALERT'
      }
    }
  }
}


(*---------------------------------------------------------*)
(*-- HVAC Control                                        --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[vdvCLActions,51]  // Stat 1 Mode
BUTTON_EVENT[vdvCLActions,52]  // Stat 2 Mode
BUTTON_EVENT[vdvCLActions,53]  // Stat 3 Mode
{
  PUSH :
  {
    STACK_VAR CHAR cValue[10]

    cValue = acStringEnumArgValues[1]

    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 51 : SEND_COMMAND vdvHVAC01,"'MODE-1,',cValue"
      CASE 52 : SEND_COMMAND vdvHVAC01,"'MODE-2,',cValue"
      CASE 53 : SEND_COMMAND vdvHVAC01,"'MODE-3,',cValue"
    }
  }
}

BUTTON_EVENT[vdvCLActions,61]  // Stat 1 Fan
BUTTON_EVENT[vdvCLActions,62]  // Stat 2 Fan
BUTTON_EVENT[vdvCLActions,63]  // Stat 3 Fan
{
  PUSH :
  {
    STACK_VAR CHAR cValue[10]

    cValue = acStringEnumArgValues[1]

    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 61 : SEND_COMMAND vdvHVAC01,"'FAN-1,' ,cValue"
      CASE 62 : SEND_COMMAND vdvHVAC01,"'FAN-2,' ,cValue"
      CASE 63 : SEND_COMMAND vdvHVAC01,"'FAN-3,' ,cValue"
    }
  }
}

BUTTON_EVENT[vdvCLActions,71] // Stat1 Heat Occupied
BUTTON_EVENT[vdvCLActions,72] // Stat1 Cool Occupied
BUTTON_EVENT[vdvCLActions,73] // Stat1 Heat Unoccupied
BUTTON_EVENT[vdvCLActions,74] // Stat1 Cool Unoccupied
{
  PUSH :
  {
    STACK_VAR INTEGER nValue

    nValue = ATOI(acStringEnumArgValues[1])

    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 71 : SEND_COMMAND vdvHVAC01,"'SPO_HEAT-1,',ITOA(nValue)"
      CASE 72 : SEND_COMMAND vdvHVAC01,"'SPO_COOL-1,',ITOA(nValue)"
      CASE 73 : SEND_COMMAND vdvHVAC01,"'SPU_HEAT-1,',ITOA(nValue)"
      CASE 74 : SEND_COMMAND vdvHVAC01,"'SPU_COOL-1,',ITOA(nValue)"
    }
  }
}

BUTTON_EVENT[vdvCLActions,81] // Stat2 Heat Occupied
BUTTON_EVENT[vdvCLActions,82] // Stat2 Cool Occupied
BUTTON_EVENT[vdvCLActions,83] // Stat2 Heat Unoccupied
BUTTON_EVENT[vdvCLActions,84] // Stat2 Cool Unoccupied
{
  PUSH :
  {
    STACK_VAR INTEGER nValue

    nValue = ATOI(acStringEnumArgValues[1])

    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 81 : SEND_COMMAND vdvHVAC01,"'SPO_HEAT-2,',ITOA(nValue)"
      CASE 82 : SEND_COMMAND vdvHVAC01,"'SPO_COOL-2,',ITOA(nValue)"
      CASE 83 : SEND_COMMAND vdvHVAC01,"'SPU_HEAT-2,',ITOA(nValue)"
      CASE 84 : SEND_COMMAND vdvHVAC01,"'SPU_COOL-2,',ITOA(nValue)"
    }
  }
}

BUTTON_EVENT[vdvCLActions,91] // Stat3 Heat Occupied
BUTTON_EVENT[vdvCLActions,92] // Stat3 Cool Occupied
BUTTON_EVENT[vdvCLActions,93] // Stat3 Heat Unoccupied
BUTTON_EVENT[vdvCLActions,94] // Stat3 Cool Unoccupied
{
  PUSH :
  {
    STACK_VAR INTEGER nValue

    nValue = ATOI(acStringEnumArgValues[1])

    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 91 : SEND_COMMAND vdvHVAC01,"'SPO_HEAT-3,',ITOA(nValue)"
      CASE 92 : SEND_COMMAND vdvHVAC01,"'SPO_COOL-3,',ITOA(nValue)"
      CASE 93 : SEND_COMMAND vdvHVAC01,"'SPU_HEAT-3,',ITOA(nValue)"
      CASE 94 : SEND_COMMAND vdvHVAC01,"'SPU_COOL-3,',ITOA(nValue)"
    }
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- GUI goes here -----------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

