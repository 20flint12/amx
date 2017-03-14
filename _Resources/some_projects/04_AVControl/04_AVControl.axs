PROGRAM_NAME='04_AVControl'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/27/2010  AT: 12:59:38        *)
(***********************************************************)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*                                                         *)
(*  Rev  1.02     06/07/2010   DAH                         *)
(*  - Added PDU online event.                              *)
(*  - Added lighting.                                      *)
(*                                                         *)
(*  Rev  1.01     05/26/2010   CWR                         *)
(*  - Added RMS.                                           *)
(*                                                         *)
(*  Rev  1.00     05/01/2010   CWR                         *)
(*  - Initial creation.                                    *)
(***********************************************************)

INCLUDE 'snapi.axi'

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(*-- DVX-2100 ---------------------------------------------*)
dvDVD1      = 5001:5:0    // IR  DVD Player

dvDVX1      = 5002:1:0    // A/V Switcher


(*-- Power Module -----------------------------------------*)
dvShiner1   = 85:1:0      //   NXA-PDU-1508-8
dvShiner2   = 86:1:0
dvShiner3   = 87:1:0
dvShiner4   = 88:1:0
dvShiner5   = 89:1:0
dvShiner6   = 90:1:0
dvShiner7   = 91:1:0
dvShiner8   = 92:1:0

(*-- Lighting ---------------------------------------------*)
dvLTS02     = 97:1:170

(*-- Panels -----------------------------------------------*)
dvTP1a      = 10001:1:0   // Destiny


(*-- RMS (See RMSMain.axi) --------------------------------*)
//dvRMSSocket              = 0:3:0
//vdvRMSEngine             = 33001:1:0
//vdvCLActions             = 33002:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(*-- Name and Ver of this include -------------------------*)
CHAR AXS_NAME[]           = '04_LEED'
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

VOLATILE INTEGER nRmSrc


(*-- Source Selects ---------------------------------------*)
CONSTANT INTEGER iBTN_SrcSel[] = { 201, 202 }


(*-- DVD --------------------------------------------------*)
CONSTANT INTEGER iBTN_DVDXport[] = { 301,302,303,304,305,306,307,308 }
CONSTANT INTEGER oIR_DVDXport[]  = {   1,  2,  3,  4,  5,  6,  7,  8 }

CONSTANT INTEGER iBTN_DVDNav[]   = { 330,331,332,333,332,335,336 }
CONSTANT INTEGER oIR_DVDNav[]    = {  44, 45, 46, 47, 48, 49, 88 }


(*-- Power Module -----------------------------------------*)
CONSTANT DEV dvPNLs__SHINER__[] = { dvTP1a }

CONSTANT DEV dvDEVs__SHINER__[] = {dvShiner1,
                                   dvShiner2,
                                   dvShiner3,
                                   dvShiner4,
                                   dvShiner5,
                                   dvShiner6,
                                   dvShiner7,
                                   dvShiner8  }



(***********************************************************)
(*                INCLUDE DEFINITIONS GO BELOW             *)
(***********************************************************)

(*---------------------------------------------------------*)
(*-- Framework                                           --*)
(*---------------------------------------------------------*)


(*---------------------------------------------------------*)
(*-- Device Drivers                                      --*)
(*---------------------------------------------------------*)
INCLUDE '__SHINER__.axi'


(*---------------------------------------------------------*)
(*-- Applications                                        --*)
(*---------------------------------------------------------*)
INCLUDE '04_AVControl_RMSMain.axi'
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

(*---------------------------------------------------------*)
(*-- Touch panel feedback.                               --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION setPnlFB (DEV dvPNL, INTEGER nPnlIdx)
{
(*-- Power Module -----------------------------------------*)
  setPnlFB__SHINER__ (dvPNL, nPnlIdx)

(*-- DVD --------------------------------------------------*)
  [dvPNL,iBTN_DVDXport[1]] = [dvDVD1,oIR_DVDXport[1]]
  [dvPNL,iBTN_DVDXport[2]] = [dvDVD1,oIR_DVDXport[2]]
  [dvPNL,iBTN_DVDXport[3]] = [dvDVD1,oIR_DVDXport[3]]
  [dvPNL,iBTN_DVDXport[4]] = [dvDVD1,oIR_DVDXport[4]]
  [dvPNL,iBTN_DVDXport[5]] = [dvDVD1,oIR_DVDXport[5]]
  [dvPNL,iBTN_DVDXport[6]] = [dvDVD1,oIR_DVDXport[6]]
  [dvPNL,iBTN_DVDXport[7]] = [dvDVD1,oIR_DVDXport[7]]
  [dvPNL,iBTN_DVDXport[8]] = [dvDVD1,oIR_DVDXport[8]]

  [dvPNL,iBTN_DVDNav[1]]   = [dvDVD1,oIR_DVDNav[1]]
  [dvPNL,iBTN_DVDNav[2]]   = [dvDVD1,oIR_DVDNav[2]]
  [dvPNL,iBTN_DVDNav[3]]   = [dvDVD1,oIR_DVDNav[3]]
  [dvPNL,iBTN_DVDNav[4]]   = [dvDVD1,oIR_DVDNav[4]]
  [dvPNL,iBTN_DVDNav[5]]   = [dvDVD1,oIR_DVDNav[5]]
  [dvPNL,iBTN_DVDNav[6]]   = [dvDVD1,oIR_DVDNav[6]]
  [dvPNL,iBTN_DVDNav[7]]   = [dvDVD1,oIR_DVDNav[7]]
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(*-- Print version ----------------------------------------*)
SEND_STRING 0,"'  Running ',AXS_NAME,' v',AXS_VER"

(***********************************************************)
(*                MODULE  CODE GOES BELOW                  *)
(***********************************************************)


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- Initialization goes here ------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Initialize PDU                                      --*)
(*---------------------------------------------------------*)
DATA_EVENT[dvShiner1]
{
  ONLINE :
  {
             ON[dvShiner1,1]
    WAIT 1   ON[dvShiner2,1]
    WAIT 2   ON[dvShiner3,1]
    WAIT 3   ON[dvShiner4,1]
    WAIT 4   ON[dvShiner5,1]
    WAIT 5   ON[dvShiner6,1]
    WAIT 6   ON[dvShiner7,1]
    WAIT 7   ON[dvShiner8,1]
    WAIT 8   ON[dvShiner1,3]
    WAIT 9   ON[dvShiner2,3]
    WAIT 10  ON[dvShiner1,4]
    WAIT 11  ON[dvShiner2,4]
  }
}



(*---------------------------------------------------------*)
(*-- Initialize DVD.                                     --*)
(*---------------------------------------------------------*)
DATA_EVENT[dvDVD1]
{
  ONLINE :
  {
    SEND_COMMAND DATA.DEVICE,"'SET MODE IR'"
    SEND_COMMAND DATA.DEVICE,"'CARON'"
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- RMS hooks go here -------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Add i!-ConnectLinx actions.                         --*)
(*---------------------------------------------------------*)
//CHANNEL_EVENT[vdvRMSEngine,250] // RMS server online
DATA_EVENT[vdvCLActions]
{
  ONLINE :
  {
    RMSGlobals()
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
        SEND_COMMAND dvPnls1a,'@PPN-RMS_ALERT'
      }
      CASE 5 :
      {
        SEND_COMMAND dvPnls1a,'@PPK-RMS_ALERT'
      }
    }
  }
}


(*---------------------------------------------------------*)
(*-- i!-CL (Shiner Control)                              --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[vdvCLActions,461] // Relay 1
BUTTON_EVENT[vdvCLActions,462] // Relay 2
BUTTON_EVENT[vdvCLActions,463] // Relay 3
BUTTON_EVENT[vdvCLActions,464] // Relay 4
BUTTON_EVENT[vdvCLActions,465] // Relay 5
BUTTON_EVENT[vdvCLActions,466] // Relay 6
BUTTON_EVENT[vdvCLActions,467] // Relay 7
BUTTON_EVENT[vdvCLActions,468] // Relay 8
BUTTON_EVENT[vdvCLActions,469] // Axlink 1 on/off
BUTTON_EVENT[vdvCLActions,470] // Axlink 2 on/off
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 461 : [dvDEVs__SHINER__[1],1] = ![dvDEVs__SHINER__[1],1]
      CASE 462 : [dvDEVs__SHINER__[2],1] = ![dvDEVs__SHINER__[2],1]
      CASE 463 : [dvDEVs__SHINER__[3],1] = ![dvDEVs__SHINER__[3],1]
      CASE 464 : [dvDEVs__SHINER__[4],1] = ![dvDEVs__SHINER__[4],1]
      CASE 465 : [dvDEVs__SHINER__[5],1] = ![dvDEVs__SHINER__[5],1]
      CASE 466 : [dvDEVs__SHINER__[6],1] = ![dvDEVs__SHINER__[6],1]
      CASE 467 : [dvDEVs__SHINER__[7],1] = ![dvDEVs__SHINER__[7],1]
      CASE 468 : [dvDEVs__SHINER__[8],1] = ![dvDEVs__SHINER__[8],1]
      CASE 469 : [dvDEVs__SHINER__[1],3] = ![dvDEVs__SHINER__[1],3]
      CASE 470 : [dvDEVs__SHINER__[2],3] = ![dvDEVs__SHINER__[2],3]
    }
  }
}

(*---------------------------------------------------------*)
(*-- Shiner levels.                                      --*)
(*---------------------------------------------------------*)
LEVEL_EVENT[dvDEVs__SHINER__[1],0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: RMSSetPowerModule1Power         (TYPE_CAST(uState__SHINER__.uCircuit[1].fPower  ))
    CASE 2: RMSSetPowerModule1Current       (TYPE_CAST(uState__SHINER__.uCircuit[1].fCurrent))
    CASE 3: RMSSetPowerModule1PowerFactor   (TYPE_CAST(uState__SHINER__.uCircuit[1].fPFactor))
    CASE 4: RMSSetPowerModule1Energy        (TYPE_CAST(uState__SHINER__.uCircuit[1].fEnergy ))
    CASE 5: RMSSetPowerModule1InputVoltage  (TYPE_CAST(uState__SHINER__.fInVoltage          ))
    CASE 6: RMSSetPowerModule1AxlinkPower   (TYPE_CAST(uState__SHINER__.uAxlink[1].fPower   ))
    CASE 7: RMSSetPowerModule1AxlinkCurrent (TYPE_CAST(uState__SHINER__.uAxlink[1].fCurrent ))
    CASE 8: RMSSetPowerModule1Temperature   (TYPE_CAST(uState__SHINER__.fTemp               ))
  }
}

LEVEL_EVENT[dvDEVs__SHINER__[2],0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: RMSSetPowerModule2Power         (TYPE_CAST(uState__SHINER__.uCircuit[2].fPower  ))
    CASE 2: RMSSetPowerModule2Current       (TYPE_CAST(uState__SHINER__.uCircuit[2].fCurrent))
    CASE 3: RMSSetPowerModule2PowerFactor   (TYPE_CAST(uState__SHINER__.uCircuit[2].fPFactor))
    CASE 4: RMSSetPowerModule2Energy        (TYPE_CAST(uState__SHINER__.uCircuit[2].fEnergy ))
    CASE 5: RMSSetPowerModule2AxlinkVoltage (TYPE_CAST(uState__SHINER__.fAxVoltage          ))
    CASE 6: RMSSetPowerModule2AxlinkPower   (TYPE_CAST(uState__SHINER__.uAxlink[2].fPower   ))
    CASE 7: RMSSetPowerModule2AxlinkCurrent (TYPE_CAST(uState__SHINER__.uAxlink[2].fCurrent ))
  }
}

LEVEL_EVENT[dvDEVs__SHINER__[3],0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: RMSSetPowerModule3Power       (TYPE_CAST(uState__SHINER__.uCircuit[3].fPower  ))
    CASE 2: RMSSetPowerModule3Current     (TYPE_CAST(uState__SHINER__.uCircuit[3].fCurrent))
    CASE 3: RMSSetPowerModule3PowerFactor (TYPE_CAST(uState__SHINER__.uCircuit[3].fPFactor))
    CASE 4: RMSSetPowerModule3Energy      (TYPE_CAST(uState__SHINER__.uCircuit[3].fEnergy ))
  }
}

LEVEL_EVENT[dvDEVs__SHINER__[4],0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: RMSSetPowerModule4Power       (TYPE_CAST(uState__SHINER__.uCircuit[4].fPower  ))
    CASE 2: RMSSetPowerModule4Current     (TYPE_CAST(uState__SHINER__.uCircuit[4].fCurrent))
    CASE 3: RMSSetPowerModule4PowerFactor (TYPE_CAST(uState__SHINER__.uCircuit[4].fPFactor))
    CASE 4: RMSSetPowerModule4Energy      (TYPE_CAST(uState__SHINER__.uCircuit[4].fEnergy ))
  }
}

LEVEL_EVENT[dvDEVs__SHINER__[5],0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: RMSSetPowerModule5Power       (TYPE_CAST(uState__SHINER__.uCircuit[5].fPower  ))
    CASE 2: RMSSetPowerModule5Current     (TYPE_CAST(uState__SHINER__.uCircuit[5].fCurrent))
    CASE 3: RMSSetPowerModule5PowerFactor (TYPE_CAST(uState__SHINER__.uCircuit[5].fPFactor))
    CASE 4: RMSSetPowerModule5Energy      (TYPE_CAST(uState__SHINER__.uCircuit[5].fEnergy ))
  }
}

LEVEL_EVENT[dvDEVs__SHINER__[6],0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: RMSSetPowerModule6Power       (TYPE_CAST(uState__SHINER__.uCircuit[6].fPower  ))
    CASE 2: RMSSetPowerModule6Current     (TYPE_CAST(uState__SHINER__.uCircuit[6].fCurrent))
    CASE 3: RMSSetPowerModule6PowerFactor (TYPE_CAST(uState__SHINER__.uCircuit[6].fPFactor))
    CASE 4: RMSSetPowerModule6Energy      (TYPE_CAST(uState__SHINER__.uCircuit[6].fEnergy ))
  }
}

LEVEL_EVENT[dvDEVs__SHINER__[7],0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: RMSSetPowerModule7Power       (TYPE_CAST(uState__SHINER__.uCircuit[7].fPower  ))
    CASE 2: RMSSetPowerModule7Current     (TYPE_CAST(uState__SHINER__.uCircuit[7].fCurrent))
    CASE 3: RMSSetPowerModule7PowerFactor (TYPE_CAST(uState__SHINER__.uCircuit[7].fPFactor))
    CASE 4: RMSSetPowerModule7Energy      (TYPE_CAST(uState__SHINER__.uCircuit[7].fEnergy ))
  }
}

LEVEL_EVENT[dvDEVs__SHINER__[8],0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1: RMSSetPowerModule8Power       (TYPE_CAST(uState__SHINER__.uCircuit[8].fPower  ))
    CASE 2: RMSSetPowerModule8Current     (TYPE_CAST(uState__SHINER__.uCircuit[8].fCurrent))
    CASE 3: RMSSetPowerModule8PowerFactor (TYPE_CAST(uState__SHINER__.uCircuit[8].fPFactor))
    CASE 4: RMSSetPowerModule8Energy      (TYPE_CAST(uState__SHINER__.uCircuit[8].fEnergy ))
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- GUI goes here -----------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Source select.                                      --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls1a,iBTN_SrcSel]
{
  PUSH :
  {
    nRmSrc = GET_LAST(iBTN_SrcSel)

    SWITCH(GET_LAST(iBTN_SrcSel))
    {
      CASE 1 : // PC
      {
        SEND_COMMAND dvDVX1,"'CI1O1'"
  ON[vdvRMSEngine,27]
      }
      CASE 2 : // DVD
      {
        SEND_COMMAND dvDVX1,"'CI2O1'"
  ON[vdvRMSEngine,27]
      }
    }
  }
}

BUTTON_EVENT[vdvCLActions,411] // Src PC
BUTTON_EVENT[vdvCLActions,412] // Src DVD
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 411 : // PC
      {
        nRmSrc = 1
        SEND_COMMAND dvDVX1,"'CI1O1'"
  ON[vdvRMSEngine,27]
      }
      CASE 412 : // DVD
      {
        nRmSrc = 2
        SEND_COMMAND dvDVX1,"'CI2O1'"
  ON[vdvRMSEngine,27]
      }
    }
  }
}

(*---------------------------------------------------------*)
(*-- DVD control.                                        --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls1a,iBTN_DVDXport]
{
  PUSH :
  {
    STACK_VAR INTEGER oIR_Xport
    oIR_Xport = oIR_DVDXport[GET_LAST(iBTN_DVDXport)]
    TO[dvDVD1,oIR_Xport]
  }
}

BUTTON_EVENT[dvPnls1a,iBTN_DVDNav]
{
  PUSH :
  {
    STACK_VAR INTEGER oIR_Nav
    oIR_Nav   = oIR_DVDNav  [GET_LAST(iBTN_DVDNav  )]
    TO[dvDVD1,oIR_Nav  ]
  }
}


(*---------------------------------------------------------*)
(*-- lighting control.                                   --*)
(*---------------------------------------------------------*)
BUTTON_EVENT [dvTP1a,9]
{

    PUSH:
    {
  SEND_COMMAND dvLTS02,"'P1L100T0'"
  ON[BUTTON.INPUT.CHANNEL]
  OFF[dvTP1a,10]
    }
}
BUTTON_EVENT [dvTP1a,10]
{

    PUSH:
    {
  SEND_COMMAND dvLTS02,"'P1L0T0'"
  ON[BUTTON.INPUT.CHANNEL]
  OFF[dvTP1a,9]
    }
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(*---------------------------------------------------------*)
(*-- Touch panel feedback.                               --*)
(*---------------------------------------------------------*)
setPnlFB (dvPnls1a[1], 1)


(*---------------------------------------------------------*)
(*-- i!-ConnectLinx                                      --*)
(*---------------------------------------------------------*)
[vdvCLActions,411] = (nRmSrc = 1) // Src PC
[vdvCLActions,412] = (nRmSrc = 2) // Src DVD


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

