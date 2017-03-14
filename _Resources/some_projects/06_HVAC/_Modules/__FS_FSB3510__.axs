MODULE_NAME='__FS_FSB3510__' (DEV vdvMain, DEV dvDEV, DEV dvPnls[10])
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*                                                         *)
(*  Rev  1.03     05/26/2010   CWR                         *)
(*  - Expanded iSelect[] to support 20 stats.              *)
(*                                                         *)
(*  Rev  1.02     05/18/2010   CWR                         *)
(*  - Unit shipped in for testing.                         *)
(*  - Added multiple stat control.                         *)
(*  - Added occupancy parsing, though it appears buggy.    *)
(*                                                         *)
(*  Rev  1.01     05/17/2010   CWR                         *)
(*  - Changes made based on rev2 of example code:          *)
(*    -- http header syntax fixed (still needs work).      *)
(*    -- Added mode status (off/auto/cool/heat).           *)
(*    -- Added fan  status (off/low/med/high).             *)
(*  - Removed level fb for setpoints.                      *)
(*    -- This will add way too much complexity when we     *)
(*       start supporting multiple stats.                  *)
(*                                                         *)
(*  Rev  1.00     05/07/2010   CWR                         *)
(*  - Initial creation.                                    *)
(*  - This code is "married" to a config file.  There are  *)
(*    3 stats programmed using the DA_AV_0x data array.    *)
(*  - Protocol supports these devices:                     *)
(*      FieldServer FS-B3510                               *)
(*                                                         *)
(***********************************************************)
(*  - Snapi components:                                    *)
(*       'MODE-<stat>,<OFF/AUTO/HEAT/COOL>'                *)
(*       'SP_ROOM-<stat>,<temp>'                           *)
(*       'SPO_HEAT-<stat>,<temp>'                          *)
(*       'SPO_COOL-<stat>,<temp>'                          *)
(*       'SPU_HEAT-<stat>,<temp>'                          *)
(*       'SPU_COOL-<stat>,<temp>'                          *)
(*       '?MODE-<stat>'                                    *)
(*       '?SP_ROOM-<stat>'                                 *)
(*       '?SPO_HEAT-<stat>'                                *)
(*       '?SPO_COOL-<stat>'                                *)
(*       '?SPU_HEAT-<stat>'                                *)
(*       '?SPU_COOL-<stat>'                                *)
(*       '?FAN-<stat>'                                     *)
(*       '?OCC-<stat>'                                     *)
(*  - Snapi listeners:                                     *)
(*       'MODE-<stat>,<OFF/AUTO/HEAT/COOL>'                *)
(*       'SP_ROOM-<stat>,<temp>'                           *)
(*       'SPO_HEAT-<stat>,<temp>'                          *)
(*       'SPO_COOL-<stat>,<temp>'                          *)
(*       'SPU_HEAT-<stat>,<temp>'                          *)
(*       'SPU_COOL-<stat>,<temp>'                          *)
(*       'FAN-<stat>,<OFF/LOW/MED/HI>'                     *)
(*       'OCC-<stat>,<0/1>'                                *)
(*  - User-defined properties:                             *)
(*       'IP_Address,<ip>'                                 *)
(*       'Port,<ip port>'     (for testing only)           *)
(***********************************************************)


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

vdvMod = DYNAMIC_VIRTUAL_DEVICE


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(*-- Name and Ver of this module --------------------------*)
CHAR __MDL_NAME__[]         = '__FS_FSB3510__'
CHAR __MDL_VER__[]          = '1.03'


(*-- Configuration ----------------------------------------*)
MAX_STAT                    = 3   // Not to exceed 20


(*-- Indexes ----------------------------------------------*)
IDX_ROOM                    = 1
IDX_HEAT_SPO                = 2
IDX_COOL_SPO                = 3
IDX_HEAT_SPU                = 4
IDX_COOL_SPU                = 5


(*-- Timelines --------------------------------------------*)
TL_POLL                     = 1


(*-- VT and Buttons ---------------------------------------*)
INTEGER iTextChan[]={
   33, // room temp
   32, // heat spo
   31, // cool spo
   40, // heat spu
   39  // cool spu
}

INTEGER iSelect[]={
  101, // Stat 01
  102, // Stat 02
  103, // Stat 03
  104, // Stat 04
  105, // Stat 05
  106, // Stat 06
  107, // Stat 07
  108, // Stat 08
  109, // Stat 09
  110, // Stat 10
  111, // Stat 11
  112, // Stat 12
  113, // Stat 13
  114, // Stat 14
  115, // Stat 15
  116, // Stat 16
  117, // Stat 17
  118, // Stat 18
  119, // Stat 19
  120  // Stat 20
}

INTEGER iButton[]={
    1, // Room Temp up
   11, //Room Temp dn
  143, //HEatSPO Temp up
  144, //HEatSPO Temp dn
  140, //CoolSPO Temp up
  141, //CoolSPO Temp dn
    4, //HeatSPU Temp up
   14, //HeatSPU Temp dn
    5, //CoolSPU Temp up
   15, //CoolSPU Temp dn
    6, //Room Temp Override up
   16  //Room Temp Override dn
}

INTEGER iSysMode[]={
   21, // OFF
   22, // Auto
   23, // Cool
   24  // Heat
}

CHAR cSysMode[][4] = {
  'OFF',
  'AUTO',
  'COOL',
  'HEAT'
}

INTEGER iFanMode[]={
  212, // OFF
  215, // Low
  214, // Med
  213, // High
   34  // FB Indicator
}

CHAR cFanMode[][4] = {
  'OFF',
  'LOW',
  'MED',
  'HIGH'
}


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(*-- Panel State ------------------------------------------*)
STRUCTURE _uPnlInfo
{
  INTEGER nStat
  FLOAT   fValue
  INTEGER nIdx
}


(*-- Device State -----------------------------------------*)
STRUCTURE _uStat
{
  FLOAT   fSP[5]
  INTEGER nMode
  INTEGER nFan
  INTEGER nOcc
}

STRUCTURE _uState
{
  CHAR    bConnecting
  CHAR    bOnline

  CHAR    bComm
  CHAR    bCommCnt

  _uStat  uStat[MAX_STAT]
  _uStat  uStatPrev[MAX_STAT]

  INTEGER nPollStat
  CHAR    cPostQueue[2000]

  CHAR    cDebugTx[5]
  CHAR    cDebugRx[5]
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(*-- Panel  State -----------------------------------------*)
VOLATILE _uPnlInfo uPnlInfo[10]


(*-- Device State -----------------------------------------*)
VOLATILE _uState uState

VOLATILE CHAR    strBuff[20000]


(*-- Properties -------------------------------------------*)
PERSISTENT CHAR    strIP[30]
PERSISTENT INTEGER nIP_PORT = 80


(***********************************************************)
(*             DEPENDENCY DEFINITIONS GO BELOW             *)
(***********************************************************)
INCLUDE 'SNAPI.axi'


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
(*---------------------------------------- Communication stuff -----------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Open IP connection.                                 --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION ipOpen ()
{
  IF(LENGTH_STRING(strIP) && (!uState.bConnecting) && (!uState.bOnline))
  {
    uState.bConnecting = 1
    IP_CLIENT_OPEN(dvDEV.PORT, strIP, nIP_PORT, IP_TCP)
  }
}

(*---------------------------------------------------------*)
(*-- Start and repeat polling.                           --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION pollStart (INTEGER nStat, LONG lDelay)
{
  IF(!TIMELINE_ACTIVE(TL_POLL))
  {
    STACK_VAR LONG lTlTimes[1]

    lTlTimes[1] = lDelay
    TIMELINE_CREATE(TL_POLL, lTlTimes, 1, TIMELINE_RELATIVE, TIMELINE_ONCE)

    uState.nPollStat = nStat
  }
}

(*---------------------------------------------------------*)
(*-- Stop polling.                                       --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION pollCancel()
{
  IF(TIMELINE_ACTIVE(TL_POLL))
    TIMELINE_KILL(TL_POLL)
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------------- Device stuff ------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Add a post item to the queue.                       --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION devQueAdd (INTEGER nStat, CHAR cPost[])
{
  IF(LENGTH_STRING(uState.cPostQueue)+(LENGTH_STRING(cPost)+2) <= MAX_LENGTH_STRING(uState.cPostQueue))
  {
    uState.cPostQueue = "uState.cPostQueue,cPost,$FE,$FF"

    ipOpen ()

    pollCancel ()
    pollStart (nStat, 1000)
  }
}

(*---------------------------------------------------------*)
(*-- Control stat mode.                                  --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION devSetMode (INTEGER nStat, INTEGER nMode)
STACK_VAR
  CHAR cTemp[20]
{
  cTemp = "'DA_AV_S_',RIGHT_STRING("'00',ITOA(nStat)",2)"

	SWITCH (nMode)
	{
	  CASE  1 : cTemp="cTemp,'.8=1.0'" // Off
	  CASE  2 : cTemp="cTemp,'.8=2.0'" // Auto
	  CASE  3 : cTemp="cTemp,'.8=3.0'" // Cool
	  CASE  4 : cTemp="cTemp,'.8=4.0'" // Heat
	  DEFAULT : RETURN
	}

  uState.uStat[nStat].nMode = nMode

  devQueAdd (nStat, cTemp)
}

(*---------------------------------------------------------*)
(*-- Control fan  mode.                                  --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION devSetFan  (INTEGER nStat, INTEGER nFan)
STACK_VAR
  CHAR cTemp[20]
{
  cTemp = "'DA_AV_S_',RIGHT_STRING("'00',ITOA(nStat)",2)"

	SWITCH (nFan)
	{
	  CASE  1 : cTemp="cTemp,'.9=1.0'" // Off
	  CASE  2 : cTemp="cTemp,'.9=2.0'" // Low
	  CASE  3 : cTemp="cTemp,'.9=3.0'" // Med
	  CASE  4 : cTemp="cTemp,'.9=4.0'" // High
	  DEFAULT : RETURN
	}

  uState.uStat[nStat].nFan  = nFan

  devQueAdd (nStat, cTemp)
}

(*---------------------------------------------------------*)
(*-- Control setpoints of selected stat.                 --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION devSetSP (INTEGER nStat, INTEGER nIdx, FLOAT fValue)
STACK_VAR
  CHAR cTemp[20]
{
  cTemp = "'DA_AV_S_',RIGHT_STRING("'00',ITOA(nStat)",2)"

  SWITCH (nIdx)
  {
    CASE  IDX_ROOM     : IF(fValue < 55) fValue = 55
    CASE  IDX_HEAT_SPO : IF(fValue < 55) fValue = 55
    CASE  IDX_COOL_SPO : IF(fValue < 55) fValue = 55
    CASE  IDX_HEAT_SPU : IF(fValue < 55) fValue = 55
    CASE  IDX_COOL_SPU : IF(fValue < 55) fValue = 55
  }

  SWITCH (nIdx)
  {
    CASE  IDX_ROOM     : IF(fValue > 99) fValue = 99
    CASE  IDX_HEAT_SPO : IF(fValue > 99) fValue = 99
    CASE  IDX_COOL_SPO : IF(fValue > 99) fValue = 99
    CASE  IDX_HEAT_SPU : IF(fValue > 99) fValue = 99
    CASE  IDX_COOL_SPU : IF(fValue > 99) fValue = 99
  }

  SWITCH (nIdx)
  {
    CASE  IDX_ROOM     : cTemp = "cTemp,'.0=',FTOA(fValue)"
    CASE  IDX_HEAT_SPO : cTemp = "cTemp,'.1=',FTOA(fValue)"
    CASE  IDX_COOL_SPO : cTemp = "cTemp,'.2=',FTOA(fValue)"
    CASE  IDX_HEAT_SPU : cTemp = "cTemp,'.3=',FTOA(fValue)"
    CASE  IDX_COOL_SPU : cTemp = "cTemp,'.4=',FTOA(fValue)"
  }

  devQueAdd (nStat, cTemp)
}

(*---------------------------------------------------------*)
(*-- Ramp a value up or down and validate range.         --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION devRampSP (FLOAT fSP, FLOAT fStep, FLOAT fMIN, FLOAT fMAX)
{
(*-- Default to min --*)
  IF(fSP = 0)
    fSP = fMIN

(*-- Step --*)
  fSP = fSP + fStep

(*-- Validate range --*)
  IF(fStep > 0) // Up
    fSP = MIN_VALUE (fSP, fMAX)
  ELSE          // Down
    fSP = MAX_VALUE (fSP, fMIN)
}

(*---------------------------------------------------------*)
(*-- Get device status.                                  --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION httpGet (INTEGER nStat)
STACK_VAR
  CHAR strHdr[1024]
{
  IF(uState.bOnline)
  {
    strHdr  = "'GET /data_arrays.xml?da=DA_AV_',RIGHT_STRING("'00',ITOA(nStat)",2),' HTTP/1.1',13,10,
               'Host: ',strIP,13,10,13,10"

    SEND_STRING dvDev,"urlEncode(strHdr)"

    IF(uState.cDebugTx = 'ASCII')
    {
      devEcho ('HDR', 'DEBUG_TX (Get-Header)')
      devEcho (uState.cDebugTx, strHdr)
    }
  }
}

(*---------------------------------------------------------*)
(*-- Post device control.                                --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION httpPost()
STACK_VAR
  CHAR strHdr[1024]
  CHAR strData[1024]
{
  IF(uState.bOnline)
  {
    strData = REMOVE_STRING(uState.cPostQueue,"$FE,$FF",1)
    IF(LENGTH_STRING(strData))
      SET_LENGTH_STRING(strData,LENGTH_STRING(strData)-2)
    ELSE
      RETURN;

    strHdr  = "'POST /post.cgi?data_arrays HTTP/1.1',13,10,
               'Content-Length: ',ITOA(LENGTH_STRING(strData)),13,10,
               'Host: ',strIP,13,10,13,10"

    SEND_STRING dvDev,"urlEncode(strHdr),urlEncode(strData)"

    IF(uState.cDebugTx = 'ASCII')
    {
      devEcho ('HDR', 'DEBUG_TX (Post-Header)')
      devEcho (uState.cDebugTx, strHdr)

      devEcho ('HDR', 'DEBUG_TX (Post-Data)')
      devEcho (uState.cDebugTx, strData)
    }
  }
}

(*---------------------------------------------------------*)
(*-- URL encode this for the wire (future).              --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION CHAR[1024] urlEncode(CHAR strData[])
{
  RETURN(strData)
}

(*---------------------------------------------------------*)
(* Return a device as a string.                            *)
(*---------------------------------------------------------*)
DEFINE_FUNCTION CHAR[20] devToString (DEV dvDEV)
{
  RETURN("'[',ITOA(dvDEV.NUMBER),':',ITOA(dvDEV.PORT),':',ITOA(dvDEV.SYSTEM),']'")
}

(*---------------------------------------------------------*)
(* Echo to terminal.                                       *)
(*---------------------------------------------------------*)
(* Sample:                                                 *)
(*   --MDL_NAME [0:3:0] (cData)--                          *)
(*     A multi-line message, with HEX or ASCII.            *)
(*---------------------------------------------------------*)
DEFINE_FUNCTION devEcho (CHAR strEnum[5], CHAR cData[])
{
  SWITCH(strEnum)
  {
    CASE 'HDR'   :
    {
      SEND_STRING 0,"'--',__MDL_NAME__,' ',devToString(dvDEV),' (',cData,')--'"
    }
    CASE 'MSG'   :
    {
      SEND_STRING 0,"'  ',cData"
    }
    CASE 'ASCII' :
    {
      STACK_VAR INTEGER nLoop

    (*-- Echo in chunks of 131 bytes (that's what works) --*)
      FOR(nLoop=1; nLoop<=LENGTH_STRING(cData); nLoop=nLoop+131)
      {
        IF(LENGTH_STRING(cData) > (nLoop-1+131))
          SEND_STRING 0,"MID_STRING(cData,nLoop,131)"
        ELSE
          SEND_STRING 0,"MID_STRING(cData,nLoop,LENGTH_STRING(cData)-nLoop+1)"
      }
    }
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------------- Panel  stuff Misc -------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Set panel feedback.                                 --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION pnlSetFb (DEV dvPNL, INTEGER nStat)
{
(*-- Stat select --*)
  [dvPNL,iSelect[1 ]] = (nStat = 1 )
  [dvPNL,iSelect[2 ]] = (nStat = 2 )
  [dvPNL,iSelect[3 ]] = (nStat = 3 )
  [dvPNL,iSelect[4 ]] = (nStat = 4 )
  [dvPNL,iSelect[5 ]] = (nStat = 5 )
  [dvPNL,iSelect[6 ]] = (nStat = 6 )
  [dvPNL,iSelect[7 ]] = (nStat = 7 )
  [dvPNL,iSelect[8 ]] = (nStat = 8 )
  [dvPNL,iSelect[9 ]] = (nStat = 9 )
  [dvPNL,iSelect[10]] = (nStat = 10)
  [dvPNL,iSelect[11]] = (nStat = 11)
  [dvPNL,iSelect[12]] = (nStat = 12)
  [dvPNL,iSelect[13]] = (nStat = 13)
  [dvPNL,iSelect[14]] = (nStat = 14)
  [dvPNL,iSelect[15]] = (nStat = 15)
  [dvPNL,iSelect[16]] = (nStat = 16)
  [dvPNL,iSelect[17]] = (nStat = 17)
  [dvPNL,iSelect[18]] = (nStat = 18)
  [dvPNL,iSelect[19]] = (nStat = 19)
  [dvPNL,iSelect[20]] = (nStat = 20)

(*-- Stat mode --*)
  [dvPNL,iSysMode[1]] = (uState.uStat[nStat].nMode = 1) // Off
  [dvPNL,iSysMode[2]] = (uState.uStat[nStat].nMode = 2) // Auto
  [dvPNL,iSysMode[3]] = (uState.uStat[nStat].nMode = 3) // Cool
  [dvPNL,iSysMode[4]] = (uState.uStat[nStat].nMode = 4) // Heat

(*-- Fan mode --*)
  [dvPNL,iFanMode[1]] = (uState.uStat[nStat].nFan  = 1) // Off
  [dvPNL,iFanMode[2]] = (uState.uStat[nStat].nFan  = 2) // Low
  [dvPNL,iFanMode[3]] = (uState.uStat[nStat].nFan  = 3) // Medium
  [dvPNL,iFanMode[4]] = (uState.uStat[nStat].nFan  = 4) // High
  [dvPNL,iFanMode[5]] = (uState.uStat[nStat].nFan  > 1) // FB Indicator
}

(*---------------------------------------------------------*)
(*-- Set panel var text.                                 --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION pnlSetVt (DEV dvPNL, INTEGER nVT, FLOAT fSP)
STACK_VAR
  cTemp[20]
{
  IF(fSP = 0)   cTemp = '--'

  IF(FIND_STRING(FTOA(fSP),'.',1))  cTemp = "FTOA(fSP)"
  ELSE                              cTemp = "FTOA(fSP),'.0'"

  SEND_COMMAND dvPNL ,"'TEXT',ITOA(nVT),'-',cTemp"
}

(*---------------------------------------------------------*)
(*-- Assign panel to thermostat.                         --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION pnlSelectStat (DEV dvPNL, INTEGER nPnlIdx, INTEGER nStat)
{
  uPnlInfo[nPnlIdx].nStat = nStat

  pnlSetVt (dvPNL, iTextChan[IDX_ROOM    ], uState.uStat[nStat].fSP[IDX_ROOM    ])
  pnlSetVt (dvPNL, iTextChan[IDX_HEAT_SPO], uState.uStat[nStat].fSP[IDX_HEAT_SPO])
  pnlSetVt (dvPNL, iTextChan[IDX_COOL_SPO], uState.uStat[nStat].fSP[IDX_COOL_SPO])
  pnlSetVt (dvPNL, iTextChan[IDX_HEAT_SPU], uState.uStat[nStat].fSP[IDX_HEAT_SPU])
  pnlSetVt (dvPNL, iTextChan[IDX_COOL_SPU], uState.uStat[nStat].fSP[IDX_COOL_SPU])

  pnlSetFb (dvPNL, nStat)
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(*-- Virtual Device Translation ---------------------------*)
TRANSLATE_DEVICE (vdvMain, vdvMod)


(*-- From device ------------------------------------------*)
CREATE_BUFFER dvDEV, strBuff


(*-- Query for initial status -----------------------------*)
WAIT 50 'STARTUP QUERY'
{
  ipOpen ()
  pollStart (1, 15000)
}

(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------------- Initialization goes here ------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(* Initialization (panels)                                 *)
(*---------------------------------------------------------*)
DATA_EVENT[dvPnls]
{
  ONLINE :
  {
    STACK_VAR INTEGER nPnlIdx

    nPnlIdx = GET_LAST(dvPnls)

    IF(uPnlInfo[nPnlIdx].nStat = 0)
      uPnlInfo[nPnlIdx].nStat = 1

    pnlSelectStat (DATA.DEVICE, nPnlIdx, uPnlInfo[nPnlIdx].nStat)
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

    cCmd    = DATA.TEXT
    cHeader = DuetParseCmdHeader(cCmd)

    SWITCH(cHeader)
    {
    (*-----------------------*)
    (*-- Mode              --*)
    (*-----------------------*)
      CASE 'MODE'     :
      {
        STACK_VAR INTEGER nStat
        STACK_VAR CHAR    cValue[DUET_MAX_PARAM_LEN]

        nStat = ATOI(DuetParseCmdParam(cCmd))
        cValue= DuetParseCmdParam(cCmd)

        IF(nStat && (nStat <= MAX_STAT))
        {
          SWITCH(cValue)
          {
            CASE 'OFF'  : devSetMode (nStat, 1)
            CASE 'AUTO' : devSetMode (nStat, 2)
            CASE 'COOL' : devSetMode (nStat, 3)
            CASE 'HEAT' : devSetMode (nStat, 4)
          }
        }
      }
      CASE '?MODE'     :
      {
        STACK_VAR INTEGER nStat

        nStat = ATOI(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
        {
          IF(uState.uStat[nStat].nMode)
            SEND_COMMAND vdvMod,"'MODE-',ITOA(nStat),',',cSysMode[uState.uStat[nStat].nMode]"
          ELSE
            SEND_COMMAND vdvMod,"'MODE-',ITOA(nStat),','"
        }
      }
    (*-----------------------*)
    (*-- Fan               --*)
    (*-----------------------*)
      CASE 'FAN'      :
      {
        STACK_VAR INTEGER nStat
        STACK_VAR CHAR    cValue[DUET_MAX_PARAM_LEN]

        nStat = ATOI(DuetParseCmdParam(cCmd))
        cValue= DuetParseCmdParam(cCmd)

        IF(nStat && (nStat <= MAX_STAT))
        {
          SWITCH(cValue)
          {
            CASE 'OFF'  : devSetFan (nStat, 1)
            CASE 'LOW'  : devSetFan (nStat, 2)
            CASE 'MED'  : devSetFan (nStat, 3)
            CASE 'HIGH' : devSetFan (nStat, 4)
          }
        }
      }
      CASE '?FAN'      :
      {
        STACK_VAR INTEGER nStat
        nStat = ATOI(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
        {
          IF(uState.uStat[nStat].nFan)
            SEND_COMMAND vdvMod,"'FAN-',ITOA(nStat),',',cSysMode[uState.uStat[nStat].nFan ]"
          ELSE
            SEND_COMMAND vdvMod,"'FAN-',ITOA(nStat),','"
        }
      }
    (*-----------------------*)
    (*-- Occupancy Sensor  --*)
    (*-----------------------*)
      CASE '?OCC'      :
      {
        STACK_VAR INTEGER nStat
        nStat = ATOI(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          SEND_COMMAND vdvMod,"'OCC-',ITOA(nStat),',',ITOA(uState.uStat[nStat].nOcc)"
      }
    (*-----------------------*)
    (*-- Room              --*)
    (*-----------------------*)
      CASE 'SP_ROOM'  :
      {
        STACK_VAR INTEGER nStat
        STACK_VAR FLOAT   fValue
        nStat = ATOI(DuetParseCmdParam(cCmd))
        fValue= ATOF(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          devSetSP (nStat, IDX_ROOM, fValue)
      }
      CASE '?SP_ROOM'  :
      {
        STACK_VAR INTEGER nStat
        nStat = ATOI(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          SEND_COMMAND vdvMod,"'SP_ROOM-',ITOA(nStat),',',FTOA(uState.uStat[nStat].fSP[IDX_ROOM    ])"
      }
    (*-----------------------*)
    (*-- Heat (occupied)   --*)
    (*-----------------------*)
      CASE 'SPO_HEAT' :
      {
        STACK_VAR INTEGER nStat
        STACK_VAR FLOAT   fValue
        nStat = ATOI(DuetParseCmdParam(cCmd))
        fValue= ATOF(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          devSetSP (nStat, IDX_HEAT_SPO, fValue)
      }
      CASE '?SPO_HEAT' :
      {
        STACK_VAR INTEGER nStat
        nStat = ATOI(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          SEND_COMMAND vdvMod,"'SPO_HEAT-',ITOA(nStat),',',FTOA(uState.uStat[nStat].fSP[IDX_HEAT_SPO])"
      }
    (*-----------------------*)
    (*-- Cool (occupied)   --*)
    (*-----------------------*)
      CASE 'SPO_COOL' :
      {
        STACK_VAR INTEGER nStat
        STACK_VAR FLOAT   fValue
        nStat = ATOI(DuetParseCmdParam(cCmd))
        fValue= ATOF(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          devSetSP (nStat, IDX_COOL_SPO, fValue)
      }
      CASE '?SPO_COOL' :
      {
        STACK_VAR INTEGER nStat
        nStat = ATOI(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          SEND_COMMAND vdvMod,"'SPO_COOL-',ITOA(nStat),',',FTOA(uState.uStat[nStat].fSP[IDX_COOL_SPO])"
      }
    (*-----------------------*)
    (*-- Heat (unoccupied) --*)
    (*-----------------------*)
      CASE 'SPU_HEAT' :
      {
        STACK_VAR INTEGER nStat
        STACK_VAR FLOAT   fValue
        nStat = ATOI(DuetParseCmdParam(cCmd))
        fValue= ATOF(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          devSetSP (nStat, IDX_HEAT_SPU, fValue)
      }
      CASE '?SPU_HEAT' :
      {
        STACK_VAR INTEGER nStat
        nStat = ATOI(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          SEND_COMMAND vdvMod,"'SPU_HEAT-',ITOA(nStat),',',FTOA(uState.uStat[nStat].fSP[IDX_HEAT_SPU])"
      }
    (*-----------------------*)
    (*-- Cool (unoccupied) --*)
    (*-----------------------*)
      CASE 'SPU_COOL' :
      {
        STACK_VAR INTEGER nStat
        STACK_VAR FLOAT   fValue
        nStat = ATOI(DuetParseCmdParam(cCmd))
        fValue= ATOF(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          devSetSP (nStat, IDX_COOL_SPU, fValue)
      }
      CASE '?SPU_COOL' :
      {
        STACK_VAR INTEGER nStat
        nStat = ATOI(DuetParseCmdParam(cCmd))

        IF(nStat && (nStat <= MAX_STAT))
          SEND_COMMAND vdvMod,"'SPU_COOL-',ITOA(nStat),',',FTOA(uState.uStat[nStat].fSP[IDX_COOL_SPU])"
      }
    (*-----------------*)
    (*-- Debug Tx/Rx --*)
    (*-----------------*)
      CASE 'DEBUG_TX' :
      {
        STACK_VAR CHAR cValue[DUET_MAX_PARAM_LEN]
        cValue = DuetParseCmdParam(cCmd)

        SWITCH(cValue)
        {
          CASE 'ASCII' : uState.cDebugTx = cValue
          CASE 'OFF'   : uState.cDebugTx = ""
        }

        devEcho ('HDR', "'DEBUG_TX'")
        devEcho ('MSG', "'DEBUG_TX=',uState.cDebugTx")
      }
      CASE '?DEBUG_TX' :
      {
        devEcho ('HDR', "'DEBUG_TX'")
        devEcho ('MSG', "'DEBUG_TX=',uState.cDebugTx")
      }
      CASE 'DEBUG_RX' :
      {
        STACK_VAR CHAR cValue[DUET_MAX_PARAM_LEN]
        cValue = DuetParseCmdParam(cCmd)

        SWITCH(cValue)
        {
          CASE 'ASCII' : uState.cDebugRx = cValue
          CASE 'OFF'   : uState.cDebugRx = ""
        }

        devEcho ('HDR', "'DEBUG_RX'")
        devEcho ('MSG', "'DEBUG_RX=',uState.cDebugRx")
      }
      CASE '?DEBUG_RX' :
      {
        devEcho ('HDR', "'DEBUG_RX'")
        devEcho ('MSG', "'DEBUG_RX=',uState.cDebugRx")
      }
    (*-----------------*)
    (*-- Properties  --*)
    (*-----------------*)
      CASE 'PROPERTY' :
      {
        STACK_VAR CHAR cKey[DUET_MAX_PARAM_LEN]
        STACK_VAR CHAR cValue[DUET_MAX_PARAM_LEN]

        cKey   = DuetParseCmdParam(cCmd)
        cValue = DuetParseCmdParam(cCmd)

        SWITCH (cKey)
        {
          CASE 'Port'            : nIP_PORT = ATOI(cValue)
          CASE 'IP_Address'      : strIP = cValue
        }
      }
      CASE '?PROPERTY' :
      {
        STACK_VAR CHAR cKey[DUET_MAX_PARAM_LEN]
        STACK_VAR CHAR cValue[DUET_MAX_PARAM_LEN]

        cKey   = DuetParseCmdParam(cCmd)

        SWITCH (cKey)
        {
          CASE 'Port'            : cValue = ITOA(nIP_PORT)
          CASE 'IP_Address'      : cValue = strIP
        }

        SEND_COMMAND vdvMod,"DuetPackCmdSimple(cKey,cValue)"

        devEcho ('HDR', "'PROPERTY'")
        devEcho ('MSG', "cKey,'=',cValue")
      }
      DEFAULT :
      {
      }
    }
  }
}


(*---------------------------------------------------------*)
(*-- Initialization (Device)                             --*)
(*---------------------------------------------------------*)
DATA_EVENT[dvDEV]
{
  ONLINE :
  {
    strBuff = ""
    uState.bConnecting = 0
    uState.bOnline     = 1

    uState.bComm       = 1
    uState.bCommCnt    = 0

    IF(LENGTH_STRING(uState.cPostQueue))
    {
      httpPost ()
    }
    ELSE
    {
      httpGet (uState.nPollStat)

      uState.nPollStat++
      IF(uState.nPollStat > MAX_STAT)
        uState.nPollStat = 1
    }
  }
  OFFLINE :
  {
    uState.bConnecting = 0
    uState.bOnline     = 0

    IF(LENGTH_STRING(uState.cPostQueue))
      ipOpen ()
    ELSE
      pollStart (uState.nPollStat, 15000)
  }
  ONERROR :
  {
    IF((DATA.NUMBER <> 13) && (DATA.NUMBER <> 14))
    {
      uState.bConnecting = 0
      uState.bOnline     = 0

      IF(LENGTH_STRING(uState.cPostQueue))
        ipOpen ()
      ELSE
        pollStart (uState.nPollStat, 15000)
    }
  }
  STRING :
  {
    IF(FIND_STRING(strBuff,"13,10,13,10",1))
    {
      STACK_VAR CHAR strHdrTemp[1024]
      STACK_VAR CHAR strHdr[1024]
      STACK_VAR CHAR strField[200]

      strHdr = REMOVE_STRING(strBuff,"13,10,13,10",1)
      strHdrTemp = strHdr

      WHILE(FIND_STRING(strHdrTemp,"13,10",1))
      {
        strField = REMOVE_STRING(strHdrTemp,"13,10",1)

        SELECT
        {
//        ACTIVE(FIND_STRING(strField,"'Date:'"          ,1)) : {}
//        ACTIVE(FIND_STRING(strField,"'Server:'"       ",1)) : {}
//        ACTIVE(FIND_STRING(strField,"'Connection:'"   ",1)) : {}
//        ACTIVE(FIND_STRING(strField,"'Cache-Control:'" ,1)) : {}
//        ACTIVE(FIND_STRING(strField,"'Content-Type:'"  ,1)) : {}
//        ACTIVE(FIND_STRING(strField,"'Content-Length:'",1)) : {} // NOTE: This never came in.
          ACTIVE(1) : {}
        }
      }

      IF(!FIND_STRING(strBuff,"'</DATA_ARRAYS>'",1))  // .....Data is fragmented.....
      {                                               //      Rebuild buffer and
        strBuff = "strHdr,strBuff"                    //      wait for next chunk.
      }
      ELSE                                            // Got a complete XML file.
      {
        STACK_VAR INTEGER nStat
        STACK_VAR INTEGER nIdx
        STACK_VAR CHAR    strData[1024]
        STACK_VAR CHAR    cValue[10]

        IF(uState.cDebugRx = 'ASCII')
        {
          devEcho ('HDR', 'DEBUG_RX (Header)')
          devEcho (uState.cDebugRx, strHdr)

          devEcho ('HDR', 'DEBUG_RX (Data)')
          devEcho (uState.cDebugRx, strBuff)
        }

//<DATA_ARRAYS FST_XML_VERSION="1.00" MAX_INDEX="27" BRIDGE_TITLE="cc09403000 v1.00a">
//  <DATA_ARRAY NAME="DA_AV_01" FORMAT="Float" LENGTH="20" INDEX="1">
//    <DATA OFFSET="0" DATA_AGE="31.806s" STATUS="0">74.500 71.000 73.000 55.000 79.200 0.000 76.000 5.000 3.000 4.000 3.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000</DATA>
//  </DATA_ARRAY>
//</DATA_ARRAYS>
        REMOVE_STRING(strBuff,"'<DATA_ARRAY NAME="'",1)
        nStat = ATOI(strBuff)

        REMOVE_STRING(strBuff,"'<DATA '",1)
        REMOVE_STRING(strBuff,"'>'",1)
        strData = REMOVE_STRING(strBuff,'</DATA>',1)
        strData = LEFT_STRING(strData,FIND_STRING(strData,'</DATA>',1)-1)
        strData = "strData,' '"

        nIdx = 0
        WHILE(FIND_STRING(strData,' ',1))
        {
          nIdx++
          cValue = REMOVE_STRING(strData,' ',1)

          SWITCH(nIdx)
          {
            CASE 1  : uState.uStat[nStat].fSP[IDX_ROOM    ] = ATOF(cValue)   // Room Temp
            CASE 2  : uState.uStat[nStat].fSP[IDX_HEAT_SPO] = ATOF(cValue)   // Occ Heat SP
            CASE 3  : uState.uStat[nStat].fSP[IDX_COOL_SPO] = ATOF(cValue)   // Occ Cool SP
            CASE 4  : uState.uStat[nStat].fSP[IDX_HEAT_SPU] = ATOF(cValue)   // UnOcc Heat SP
            CASE 5  : uState.uStat[nStat].fSP[IDX_COOL_SPU] = ATOF(cValue)   // UnOcc Cool SP
            CASE 6  : {} // Pl Heating Demand
            CASE 7  : {} // Pl Cooling Demand
            CASE 8  : {} // Fan Mode Seq
            CASE 9  : uState.uStat[nStat].nMode = ATOI(cValue)   // System Mode
            CASE 10 : uState.uStat[nStat].nFan  = ATOI(cValue)   // Fan Status
            CASE 11 : uState.uStat[nStat].nOcc  = ATOI(cValue)   // Occupancy
          }

          IF(uState.cDebugRx = 'ASCII')
          {
            IF(nIdx = 1)
              SEND_STRING 0,"'nStat        = ',ITOA(nStat)"

            SWITCH(nIdx)
            {
              CASE 1  : SEND_STRING 0,"'IDX_ROOM     = ',cValue"   // Room Temp
              CASE 2  : SEND_STRING 0,"'IDX_HEAT_SPO = ',cValue"   // Occ Heat SP
              CASE 3  : SEND_STRING 0,"'IDX_COOL_SPO = ',cValue"   // Occ Cool SP
              CASE 4  : SEND_STRING 0,"'IDX_HEAT_SPU = ',cValue"   // UnOcc Heat SP
              CASE 5  : SEND_STRING 0,"'IDX_COOL_SPU = ',cValue"   // UnOcc Cool SP
              CASE 6  : {} // Pl Heating Demand
              CASE 7  : {} // Pl Cooling Demand
              CASE 8  : {} // Fan Mode Seq
              CASE 9  : SEND_STRING 0,"'nMode        = ',cValue"   // System Mode
              CASE 10 : SEND_STRING 0,"'nFan         = ',cValue"   // Fan Status
              CASE 11 : SEND_STRING 0,"'nOcc         = ',cValue"   // Occupancy
            }
          }
        }

        FOR(nIdx=1; nIdx<=MAX_LENGTH_ARRAY(dvPnls); nIdx++)
        {
          IF(uPnlInfo[nIdx].nStat = nStat)
          {
            pnlSetFb (dvPnls[nIdx], nStat)

            pnlSetVt (dvPnls[nIdx], iTextChan[IDX_ROOM    ], uState.uStat[nStat].fSP[IDX_ROOM    ])
            pnlSetVt (dvPnls[nIdx], iTextChan[IDX_HEAT_SPO], uState.uStat[nStat].fSP[IDX_HEAT_SPO])
            pnlSetVt (dvPnls[nIdx], iTextChan[IDX_COOL_SPO], uState.uStat[nStat].fSP[IDX_COOL_SPO])
            pnlSetVt (dvPnls[nIdx], iTextChan[IDX_HEAT_SPU], uState.uStat[nStat].fSP[IDX_HEAT_SPU])
            pnlSetVt (dvPnls[nIdx], iTextChan[IDX_COOL_SPU], uState.uStat[nStat].fSP[IDX_COOL_SPU])
          }
        }

        IF(uState.uStatPrev[nStat].nMode             <> uState.uStat[nStat].nMode            ) SEND_COMMAND vdvMod,"'MODE-' ,cSysMode[uState.uStat[nStat].nMode]"
        IF(uState.uStatPrev[nStat].nFan              <> uState.uStat[nStat].nFan             ) SEND_COMMAND vdvMod,"'FAN-'  ,cFanMode[uState.uStat[nStat].nFan]"
        IF(uState.uStatPrev[nStat].fSP[IDX_ROOM    ] <> uState.uStat[nStat].fSP[IDX_ROOM    ]) SEND_COMMAND vdvMod,"'SP_ROOM-' ,FTOA(uState.uStat[nStat].fSP[IDX_ROOM    ])"
        IF(uState.uStatPrev[nStat].fSP[IDX_HEAT_SPO] <> uState.uStat[nStat].fSP[IDX_HEAT_SPO]) SEND_COMMAND vdvMod,"'SPO_HEAT-',FTOA(uState.uStat[nStat].fSP[IDX_HEAT_SPO])"
        IF(uState.uStatPrev[nStat].fSP[IDX_COOL_SPO] <> uState.uStat[nStat].fSP[IDX_COOL_SPO]) SEND_COMMAND vdvMod,"'SPO_COOL-',FTOA(uState.uStat[nStat].fSP[IDX_COOL_SPO])"
        IF(uState.uStatPrev[nStat].fSP[IDX_HEAT_SPU] <> uState.uStat[nStat].fSP[IDX_HEAT_SPU]) SEND_COMMAND vdvMod,"'SPU_HEAT-',FTOA(uState.uStat[nStat].fSP[IDX_HEAT_SPU])"
        IF(uState.uStatPrev[nStat].fSP[IDX_COOL_SPU] <> uState.uStat[nStat].fSP[IDX_COOL_SPU]) SEND_COMMAND vdvMod,"'SPU_COOL-',FTOA(uState.uStat[nStat].fSP[IDX_COOL_SPU])"

        uState.uStatPrev[nStat].nMode             = uState.uStat[nStat].nMode
        uState.uStatPrev[nStat].nFan              = uState.uStat[nStat].nFan
        uState.uStatPrev[nStat].fSP[IDX_ROOM    ] = uState.uStat[nStat].fSP[IDX_ROOM    ]
        uState.uStatPrev[nStat].fSP[IDX_HEAT_SPO] = uState.uStat[nStat].fSP[IDX_HEAT_SPO]
        uState.uStatPrev[nStat].fSP[IDX_COOL_SPO] = uState.uStat[nStat].fSP[IDX_COOL_SPO]
        uState.uStatPrev[nStat].fSP[IDX_HEAT_SPU] = uState.uStat[nStat].fSP[IDX_HEAT_SPU]
        uState.uStatPrev[nStat].fSP[IDX_COOL_SPU] = uState.uStat[nStat].fSP[IDX_COOL_SPU]
      }
    }
  }
}


(*---------------------------------------------------------*)
(*-- Poll for status.                                    --*)
(*---------------------------------------------------------*)
TIMELINE_EVENT[TL_POLL]
{
  ipOpen ()

(*-- RMS comm --*)
  uState.bCommCnt++

  IF(uState.bCommCnt > 3)
  {
    uState.bComm       = 0
    uState.bCommCnt    = 0
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------------- Button  events go here --------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Assign stat to panel.                               --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls,iSelect]
{
  PUSH:
  {
    STACK_VAR INTEGER nPnlIdx
    STACK_VAR INTEGER nStat

    nPnlIdx = GET_LAST(dvPnls)
    nStat   = GET_LAST(iSelect)

    pnlSelectStat (BUTTON.INPUT.DEVICE, nPnlIdx, nStat)
  }
}

(*---------------------------------------------------------*)
(*-- Control stat mode.                                  --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls,iSysMode]
{
  PUSH:
  {
    STACK_VAR INTEGER nPnlIdx
    STACK_VAR INTEGER nStat
    STACK_VAR INTEGER nMode

    nPnlIdx = GET_LAST(dvPnls)
    nStat   = uPnlInfo[nPnlIdx].nStat
    nMode   = GET_LAST(iSysMode)

    IF(nStat)
      devSetMode (nStat, nMode)

    pnlSetFb (BUTTON.INPUT.DEVICE, nStat)
  }
}

(*---------------------------------------------------------*)
(*-- Control fan  mode.                                  --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls,iFanMode]
{
  PUSH:
  {
    IF(GET_LAST(iFanMode) <> MAX_LENGTH_ARRAY(iFanMode))
    {
      STACK_VAR INTEGER nPnlIdx
      STACK_VAR INTEGER nStat
      STACK_VAR INTEGER nFan

      nPnlIdx = GET_LAST(dvPnls)
      nStat   = uPnlInfo[nPnlIdx].nStat
      nFan    = GET_LAST(iFanMode)

      IF(nStat)
        devSetFan  (nStat, nFan )

      pnlSetFb (BUTTON.INPUT.DEVICE, nStat)
    }
  }
}

(*---------------------------------------------------------*)
(*-- Control setpoints of selected stat.                 --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls,iButton]
{
  PUSH:
  {
    STACK_VAR INTEGER nPnlIdx
    STACK_VAR INTEGER nStat

    nPnlIdx = GET_LAST(dvPnls)
    nStat   = uPnlInfo[nPnlIdx].nStat

    IF(nStat)
    {
      pollCancel ()

      SWITCH (GET_LAST(iButton))
      {
        CASE 1 : uPnlInfo[nPnlIdx].nIdx = IDX_ROOM
        CASE 2 : uPnlInfo[nPnlIdx].nIdx = IDX_ROOM
        CASE 3 : uPnlInfo[nPnlIdx].nIdx = IDX_HEAT_SPO
        CASE 4 : uPnlInfo[nPnlIdx].nIdx = IDX_HEAT_SPO
        CASE 5 : uPnlInfo[nPnlIdx].nIdx = IDX_COOL_SPO
        CASE 6 : uPnlInfo[nPnlIdx].nIdx = IDX_COOL_SPO
        CASE 7 : uPnlInfo[nPnlIdx].nIdx = IDX_HEAT_SPU
        CASE 8 : uPnlInfo[nPnlIdx].nIdx = IDX_HEAT_SPU
        CASE 9 : uPnlInfo[nPnlIdx].nIdx = IDX_COOL_SPU
        CASE 10: uPnlInfo[nPnlIdx].nIdx = IDX_COOL_SPU
        CASE 11: {}
        CASE 12: {}
      }

      SWITCH (GET_LAST(iButton))
      {
        CASE 1 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_ROOM    ]
        CASE 2 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_ROOM    ]
        CASE 3 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_HEAT_SPO]
        CASE 4 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_HEAT_SPO]
        CASE 5 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_COOL_SPO]
        CASE 6 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_COOL_SPO]
        CASE 7 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_HEAT_SPU]
        CASE 8 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_HEAT_SPU]
        CASE 9 : uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_COOL_SPU]
        CASE 10: uPnlInfo[nPnlIdx].fValue = uState.uStat[nStat].fSP[IDX_COOL_SPU]
        CASE 11: {}
        CASE 12: {}
      }

      SWITCH (GET_LAST(iButton))
      {
        CASE 1 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 2 : devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 3 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 4 : devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 5 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 6 : devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 7 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 8 : devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 9 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 10: devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 11: {}
        CASE 12: {}
      }

      pnlSetVT (BUTTON.INPUT.DEVICE, iTextChan[uPnlInfo[nPnlIdx].nIdx], uPnlInfo[nPnlIdx].fValue)
    }
  }
  HOLD[3,REPEAT]:
  {
    STACK_VAR INTEGER nPnlIdx
    STACK_VAR INTEGER nStat

    nPnlIdx = GET_LAST(dvPnls)
    nStat   = uPnlInfo[nPnlIdx].nStat

    IF(nStat)
    {
      SWITCH (GET_LAST(iButton))
      {
        CASE 1 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 2 : devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 3 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 4 : devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 5 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 6 : devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 7 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 8 : devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 9 : devRampSP (uPnlInfo[nPnlIdx].fValue, 1, 55, 99)
        CASE 10: devRampSP (uPnlInfo[nPnlIdx].fValue,-1, 55, 99)
        CASE 11: {}
        CASE 12: {}
      }

      pnlSetVT (BUTTON.INPUT.DEVICE, iTextChan[uPnlInfo[nPnlIdx].nIdx], uPnlInfo[nPnlIdx].fValue)
    }
  }
  RELEASE:
  {
    STACK_VAR INTEGER nPnlIdx
    STACK_VAR INTEGER nStat

    nPnlIdx = GET_LAST(dvPnls)
    nStat   = uPnlInfo[nPnlIdx].nStat

    IF(nStat)
    {
      devSetSP (nStat, uPnlInfo[nPnlIdx].nIdx, uPnlInfo[nPnlIdx].fValue)

    (*-- Fake it for now --*)
      uState.uStat[nStat].fSP[uPnlInfo[nPnlIdx].nIdx]     = uPnlInfo[nPnlIdx].fValue
      uState.uStatpREV[nStat].fSP[uPnlInfo[nPnlIdx].nIdx] = 0
    }
  }
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(*---------------------------------------------------------*)
(* SNAPI Interface Component Listeners.                    *)
(*---------------------------------------------------------*)
[vdvMod,DEVICE_COMMUNICATING] = (uState.bComm > 0)


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

