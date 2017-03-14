PROGRAM_NAME='07_Lighting'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/27/2010  AT: 13:55:21        *)
(***********************************************************)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*                                                         *)
(*  Rev  1.02     06/07/2010   DAH                         *)
(*  - Removed fan controls.                                *)
(*                                                         *)
(*  Rev  1.01     05/25/2010   CWR                         *)
(*  - Fixed keypad on/off buttons.                         *)
(*                                                         *)
(*  Rev  1.00     05/01/2010   CWR                         *)
(*  - Initial creation.                                    *)
(***********************************************************)


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(*-- Radia ------------------------------------------------*)
dvLTS01     = 96:1:0      // RE-DM6     1-Light 1
                          //            2-Light 2
                          //            3-Light 3
                          //            4-Light 4 (Sconce)
                          //            5-N/A
                          //            6-N/A

dvLTS02     = 97:1:0      // RE-DC w/   1-HVAC Fan 1
                          // RDM-6EM    2-HVAC Fan 2
                          //            3-HVAC Fan 3
                          //            4-N/A
                          //            5-N/A
                          //            6-N/A

vdvLTS01    = 41001:1:0
vdvLTS02    = 41002:1:0


(*-- Keypads ----------------------------------------------*)
dvKP01      = 128:1:0     // Novara SP-08-AX



(*-- RMS (See RMSMain.axi) --------------------------------*)
//dvRMSSocket              = 0:3:0
//vdvRMSEngine             = 33001:1:0
//vdvCLActions             = 33002:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(*-- Name and Ver of this include -------------------------*)
CHAR AXS_NAME[]           = '07_Lighting'
CHAR AXS_VER[]            = '1.02'


(*-- Radia ------------------------------------------------*)
OFF_THRESHOLD             = 25    // At this level value, dimmer is considered off


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(*-- Keypads ----------------------------------------------*)
STRUCTURE _uKP
{
  INTEGER nZone
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(*-- Radia ------------------------------------------------*)
VOLATILE INTEGER nLtLvl[2][6]


(*-- Keypads ----------------------------------------------*)
CONSTANT DEV dvKPs[] = { dvKP01 }
VOLATILE _uKP uKP[1]


CONSTANT INTEGER iBtnKP_ZoneSel[] = {
    5,  // 1
    6,  // 2
    7,  // 3
    8 } // All

CONSTANT INTEGER iBtnKP[] = {
    2,  // Up
    4,  // Down
    1,  // On
    3 } // Off


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
INCLUDE '07_Lighting_RMSMain.axi'
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
(*-- Keypad FB                                           --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION setKpFb (DEV dvKP, INTEGER nKPIdx)
{
(*-- Zone Select --*)
  [dvKP,iBtnKP_ZoneSel[1]] = (uKP[nKPIdx].nZone = 1)
  [dvKP,iBtnKP_ZoneSel[2]] = (uKP[nKPIdx].nZone = 2)
  [dvKP,iBtnKP_ZoneSel[3]] = (uKP[nKPIdx].nZone = 3)
  [dvKP,iBtnKP_ZoneSel[4]] = (uKP[nKPIdx].nZone = 0)

(*-- Zone Control --*)
  SWITCH(uKP[nKPIdx].nZone)
  {
    CASE 1 :
    {
      [dvKP,iBtnKP[1]] = [dvLTS01,129]    // Up
      [dvKP,iBtnKP[2]] = [dvLTS01,135]    // Down
      [dvKP,iBtnKP[3]] = (nLtLvl[1][1] >  OFF_THRESHOLD)  // On
      [dvKP,iBtnKP[4]] = (nLtLvl[1][1] <= OFF_THRESHOLD)  // Off
    }
    CASE 2 :
    {
      [dvKP,iBtnKP[1]] = [dvLTS01,130]    // Up
      [dvKP,iBtnKP[2]] = [dvLTS01,136]    // Down
      [dvKP,iBtnKP[3]] = (nLtLvl[1][2] >  OFF_THRESHOLD)  // On
      [dvKP,iBtnKP[4]] = (nLtLvl[1][2] <= OFF_THRESHOLD)  // Off
    }
    CASE 3 :
    {
      [dvKP,iBtnKP[1]] = [dvLTS01,131]    // Up
      [dvKP,iBtnKP[2]] = [dvLTS01,137]    // Down
      [dvKP,iBtnKP[3]] = (nLtLvl[1][3] >  OFF_THRESHOLD)  // On
      [dvKP,iBtnKP[4]] = (nLtLvl[1][3] <= OFF_THRESHOLD)  // Off
    }
    DEFAULT :
    {
      [dvKP,iBtnKP[1]] =([dvLTS01,129] && [dvLTS01,130] && [dvLTS01,131])    // Up
      [dvKP,iBtnKP[2]] =([dvLTS01,135] && [dvLTS01,136] && [dvLTS01,137])    // Down
      [dvKP,iBtnKP[3]] =((nLtLvl[1][1] >  OFF_THRESHOLD) &&  // On
                         (nLtLvl[1][2] >  OFF_THRESHOLD) &&
                         (nLtLvl[1][3] >  OFF_THRESHOLD))
      [dvKP,iBtnKP[4]] =((nLtLvl[1][1] <= OFF_THRESHOLD) &&  // On
                         (nLtLvl[1][2] <= OFF_THRESHOLD) &&
                         (nLtLvl[1][3] <= OFF_THRESHOLD))
    }
  }
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

//DEFINE_MODULE 'AMX_Radia_Comm_dr1_0_0' LTS01(vdvLTS01, dvLTS01)
//DEFINE_MODULE 'AMX_Radia_Comm_dr1_0_0' LTS02(vdvLTS02, dvLTS02)


(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- Initialization goes here ------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)


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
        SEND_COMMAND dvLTS01,"'P',ITOA(BUTTON.INPUT.CHANNEL),'L100T3'"
      }
      CASE 5 :
      {
        SEND_COMMAND dvLTS01,"'P1L0T3'"
        SEND_COMMAND dvLTS01,"'P2L0T3'"
        SEND_COMMAND dvLTS01,"'P3L0T3'"
        SEND_COMMAND dvLTS01,"'P4L100T0'"
      }
    }
  }
}


(*---------------------------------------------------------*)
(*-- C/L Dimmer                                          --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[vdvCLActions,720]   // Dimmer Preset
BUTTON_EVENT[vdvCLActions,721]   // Dimmer 1 On
BUTTON_EVENT[vdvCLActions,722]   // Dimmer 2 On
BUTTON_EVENT[vdvCLActions,723]   // Dimmer 3 On
BUTTON_EVENT[vdvCLActions,724]   // Dimmer 4 On
BUTTON_EVENT[vdvCLActions,725]   // Dimmer 5 On
BUTTON_EVENT[vdvCLActions,726]   // Dimmer 6 On
BUTTON_EVENT[vdvCLActions,731]   // Dimmer 1 Off
BUTTON_EVENT[vdvCLActions,732]   // Dimmer 2 Off
BUTTON_EVENT[vdvCLActions,733]   // Dimmer 3 Off
BUTTON_EVENT[vdvCLActions,734]   // Dimmer 4 Off
BUTTON_EVENT[vdvCLActions,735]   // Dimmer 5 Off
BUTTON_EVENT[vdvCLActions,736]   // Dimmer 6 Off
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 720 :
      {
        STACK_VAR INTEGER nPset

        nPset = ATOI(acStringEnumArgValues[1])

        IF(nPset)
          SEND_COMMAND dvLTS01,"'RP',ITOA(nPset),'T3'"
      }
      CASE 721 :
      CASE 722 :
      CASE 723 :
      CASE 724 :
      CASE 725 :
      CASE 726 :
      {
        STACK_VAR INTEGER nChn
        nChn = BUTTON.INPUT.CHANNEL - 720
        SEND_COMMAND dvLTS01,"'P',ITOA(nChn),'L100T3'"
      }
      CASE 731 :
      CASE 732 :
      CASE 733 :
      CASE 734 :
      CASE 735 :
      CASE 736 :
      {
        STACK_VAR INTEGER nChn
        nChn = BUTTON.INPUT.CHANNEL - 730
        SEND_COMMAND dvLTS01,"'P',ITOA(nChn),'L0T0'"
      }
    }
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- GUI goes here -----------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Dimmers                                             --*)
(*---------------------------------------------------------*)
LEVEL_EVENT[dvLTS01,1]
LEVEL_EVENT[dvLTS01,2]
LEVEL_EVENT[dvLTS01,3]
LEVEL_EVENT[dvLTS01,4]
LEVEL_EVENT[dvLTS01,5]
LEVEL_EVENT[dvLTS01,6]
{
  nLtLvl[1][LEVEL.INPUT.LEVEL] = LEVEL.VALUE
}


(*---------------------------------------------------------*)
(*-- Fans                                                --*)
(*---------------------------------------------------------*)
LEVEL_EVENT[dvLTS02,1]
LEVEL_EVENT[dvLTS02,2]
LEVEL_EVENT[dvLTS02,3]
LEVEL_EVENT[dvLTS02,4]
LEVEL_EVENT[dvLTS02,5]
LEVEL_EVENT[dvLTS02,6]
{
  nLtLvl[2][LEVEL.INPUT.LEVEL] = LEVEL.VALUE
}


(*---------------------------------------------------------*)
(*-- Keypad (Zone Select)                                --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvKPs,iBtnKP_ZoneSel]
{
  PUSH :
  {
    STACK_VAR INTEGER nKP

    nKP = GET_LAST(dvKPs)

    uKP[nKP].nZone = GET_LAST(iBtnKP_ZoneSel)

    IF(uKP[nKP].nZone = MAX_LENGTH_ARRAY(iBtnKP_ZoneSel))
      uKP[nKP].nZone = 0
  }
}


(*---------------------------------------------------------*)
(*-- Keypad (Zone Control)                               --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvKPs,iBtnKP]
{
  PUSH :
  {
    STACK_VAR INTEGER nKP
    STACK_VAR INTEGER nZone

    nKP = GET_LAST(dvKPs)
    nZone = uKP[nKP].nZone

    IF((nZone = 0) || (nZone = 1))
    {
      SWITCH(GET_LAST(iBtnKP))
      {
        CASE 1 : TO[dvLTS01,129]      // Up
        CASE 2 : TO[dvLTS01,135]      // Down
        CASE 3 : SEND_COMMAND dvLTS01,"'P1L100T3'"    // On
        CASE 4 : SEND_COMMAND dvLTS01,"'P1L0T0'"      // Off
      }
    }

    IF((nZone = 0) || (nZone = 2))
    {
      SWITCH(GET_LAST(iBtnKP))
      {
        CASE 1 : TO[dvLTS01,130]      // Up
        CASE 2 : TO[dvLTS01,136]      // Down
        CASE 3 : SEND_COMMAND dvLTS01,"'P2L100T3'"    // On
        CASE 4 : SEND_COMMAND dvLTS01,"'P2L0T0'"      // Off
      }
    }

    IF((nZone = 0) || (nZone = 3))
    {
      SWITCH(GET_LAST(iBtnKP))
      {
        CASE 1 : TO[dvLTS01,131]      // Up
        CASE 2 : TO[dvLTS01,137]      // Down
        CASE 3 : SEND_COMMAND dvLTS01,"'P3L100T3'"    // On
        CASE 4 : SEND_COMMAND dvLTS01,"'P3L0T0'"      // Off
      }
    }
  }
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(*---------------------------------------------------------*)
(*-- Keypad FB                                           --*)
(*---------------------------------------------------------*)
setKpFb (dvKPs[1], 1)

[vdvRMSEngine,28]=[dvKPs,3]
[vdvRMSEngine,27]=[dvKPs,1]

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

