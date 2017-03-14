PROGRAM_NAME='03_CCTV'
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*                                                         *)
(*  Rev  1.00     05/01/2010   CWR                         *)
(*  - Initial creation.                                    *)
(***********************************************************)


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(*-- NI-700 -----------------------------------------------*)
dvCCTV01    = 5001:3:0    // IR  Samsung SHR-3040


(*-- Panels -----------------------------------------------*)
dvTP1a      = 10001:1:0   // NXD-1500VG


(*-- RMS (See RMSMain.axi) --------------------------------*)
//dvRMSSocket              = 0:3:0
//vdvRMSEngine             = 33001:1:0
//vdvCLActions             = 33002:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(*-- Name and Ver of this include -------------------------*)
CHAR AXS_NAME[]           = '03_CCTV'
CHAR AXS_VER[]            = '1.00'


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
INCLUDE '03_CCTV_RMSMain.axi'
INCLUDE 'RMSGlobals.axi'


(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(*---------------------------------------------------------*)
(*-- RMS source useage                                   --*)
(*---------------------------------------------------------*)
(  [dvCCTV01,11],   // Camera 1
   [dvCCTV01,12],   // Camera 2
   [dvCCTV01,13],   // Camera 3
   [dvCCTV01,14],   // Camera 4
   [dvCCTV01,59],   // Sequence
   [dvCCTV01,49]  ) // Quad View


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
(*-- CCTV -------------------------------------------------*)
  [dvPNL,101] = [dvCCTV01,11]  // Camera 1
  [dvPNL,102] = [dvCCTV01,12]  // Camera 2
  [dvPNL,103] = [dvCCTV01,13]  // Camera 3
  [dvPNL,104] = [dvCCTV01,14]  // Camera 4
  [dvPNL,201] = [dvCCTV01,1]   // Play
  [dvPNL,203] = [dvCCTV01,3]   // Pause
  [dvPNL,204] = [dvCCTV01,4]   // Fwd
  [dvPNL,205] = [dvCCTV01,5]   // Rew
  [dvPNL,206] = [dvCCTV01,6]   // Search Fwd
  [dvPNL,208] = [dvCCTV01,8]   // Record
  [dvPNL,210] = [dvCCTV01,50]  // Escape
  [dvPNL,211] = [dvCCTV01,45]  // Up
  [dvPNL,212] = [dvCCTV01,46]  // Down
  [dvPNL,213] = [dvCCTV01,47]  // Left
  [dvPNL,214] = [dvCCTV01,48]  // Right
  [dvPNL,215] = [dvCCTV01,49]  // Select
  [dvPNL,216] = [dvCCTV01,55]  // Setup
  [dvPNL,217] = [dvCCTV01,57]  // ID
  [dvPNL,218] = [dvCCTV01,58]  // Backup
  [dvPNL,219] = [dvCCTV01,59]  // Sequence
  [dvPNL,220] = [dvCCTV01,10]  // 0
  [dvPNL,221] = [dvCCTV01,11]  // 1
  [dvPNL,222] = [dvCCTV01,12]  // 2
  [dvPNL,223] = [dvCCTV01,13]  // 3
  [dvPNL,224] = [dvCCTV01,14]  // 4
  [dvPNL,225] = [dvCCTV01,15]  // 5
  [dvPNL,226] = [dvCCTV01,16]  // 6
  [dvPNL,227] = [dvCCTV01,17]  // 7
  [dvPNL,228] = [dvCCTV01,18]  // 8
  [dvPNL,229] = [dvCCTV01,19]  // 9
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(*-- Print version ----------------------------------------*)
SEND_STRING 0,"'  Running ',AXS_NAME,' v',AXS_VER"


(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- Initialization goes here ------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- CCTV_Camera_Select.                                 --*)
(*---------------------------------------------------------*)
DATA_EVENT[dvPnls1a]
{
  ONLINE :
  {
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
    RMSGlobals (3)
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
        PULSE[dvCCTV01,11]  // Camera 1
        SEND_COMMAND dvPnls1a,"'PAGE-Nav Page 1'"
        SEND_COMMAND dvPnls1a,"'WAKE'"
      }
      CASE 5 :
      {
        PULSE[dvCCTV01,49]  // Quad View
        SEND_COMMAND dvPnls1a,"'PAGE-Trans_DVR'"
      }
    }
  }
}


(*---------------------------------------------------------*)
(*-- C/L: CCTV_Camera_Select.                            --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[vdvCLActions,311]  // Camera 1
BUTTON_EVENT[vdvCLActions,312]  // Camera 2
BUTTON_EVENT[vdvCLActions,313]  // Camera 3
BUTTON_EVENT[vdvCLActions,314]  // Camera 4
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 311 : PULSE[dvCCTV01,11]  // Camera 1
      CASE 312 : PULSE[dvCCTV01,12]  // Camera 2
      CASE 313 : PULSE[dvCCTV01,13]  // Camera 3
      CASE 314 : PULSE[dvCCTV01,14]  // Camera 4
    }

    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 311 : SEND_COMMAND dvPnls1a,"'PAGE-Nav Page 1'"
      CASE 312 : SEND_COMMAND dvPnls1a,"'PAGE-Nav Page 2'"
      CASE 313 : SEND_COMMAND dvPnls1a,"'PAGE-Nav Page 3'"
      CASE 314 : SEND_COMMAND dvPnls1a,"'PAGE-Nav Page 4'"
    }

    SEND_COMMAND dvPnls1a,"'WAKE'"
  }
}

(*---------------------------------------------------------*)
(*-- C/L: CCTV_View.                                     --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[vdvCLActions,321]  // Sequence
BUTTON_EVENT[vdvCLActions,322]  // Quad View
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 321 : PULSE[dvCCTV01,59]  // Sequence
      CASE 322 : PULSE[dvCCTV01,49]  // Quad View
    }

    SEND_COMMAND dvPnls1a,"'PAGE-Trans_DVR'"
    SEND_COMMAND dvPnls1a,"'WAKE'"
  }
}

(*---------------------------------------------------------*)
(*-- C/L: Monitor_Power.                                 --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[vdvCLActions,331]  // Monitor On
BUTTON_EVENT[vdvCLActions,332]  // Monitor Off
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 331 : SEND_COMMAND dvPnls1a,'WAKE'
      CASE 332 : SEND_COMMAND dvPnls1a,'SLEEP'
    }
  }
}


(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- GUI goes here -----------------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- CCTV_Camera_Select.                                 --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls1a,101]  // Camera 1
BUTTON_EVENT[dvPnls1a,102]  // Camera 2
BUTTON_EVENT[dvPnls1a,103]  // Camera 3
BUTTON_EVENT[dvPnls1a,104]  // Camera 4
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 101 : TO[dvCCTV01,11]  // Camera 1
      CASE 102 : TO[dvCCTV01,12]  // Camera 2
      CASE 103 : TO[dvCCTV01,13]  // Camera 3
      CASE 104 : TO[dvCCTV01,14]  // Camera 4
    }
  }
}

(*---------------------------------------------------------*)
(*-- CCTV recorder.                                      --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls1a,201]  // Play
BUTTON_EVENT[dvPnls1a,203]  // Pause
BUTTON_EVENT[dvPnls1a,204]  // Fwd
BUTTON_EVENT[dvPnls1a,205]  // Rew
BUTTON_EVENT[dvPnls1a,206]  // Search Fwd
BUTTON_EVENT[dvPnls1a,208]  // Record
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 201 : TO[dvCCTV01,1]  // Play
      CASE 203 : TO[dvCCTV01,3]  // Pause
      CASE 204 : TO[dvCCTV01,4]  // Fwd
      CASE 205 : TO[dvCCTV01,5]  // Rew
      CASE 206 : TO[dvCCTV01,6]  // Search Fwd
      CASE 208 : TO[dvCCTV01,8]  // Record
    }
  }
}

(*---------------------------------------------------------*)
(*-- CCTV recorder.                                      --*)
(*---------------------------------------------------------*)
BUTTON_EVENT[dvPnls1a,210]  // Escape
BUTTON_EVENT[dvPnls1a,211]  // Up
BUTTON_EVENT[dvPnls1a,212]  // Down
BUTTON_EVENT[dvPnls1a,213]  // Left
BUTTON_EVENT[dvPnls1a,214]  // Right
BUTTON_EVENT[dvPnls1a,215]  // Select
BUTTON_EVENT[dvPnls1a,216]  // Setup
BUTTON_EVENT[dvPnls1a,217]  // ID
BUTTON_EVENT[dvPnls1a,218]  // Backup
BUTTON_EVENT[dvPnls1a,219]  // Sequence
BUTTON_EVENT[dvPnls1a,220]  // 0
BUTTON_EVENT[dvPnls1a,221]  // 1
BUTTON_EVENT[dvPnls1a,222]  // 2
BUTTON_EVENT[dvPnls1a,223]  // 3
BUTTON_EVENT[dvPnls1a,224]  // 4
BUTTON_EVENT[dvPnls1a,225]  // 5
BUTTON_EVENT[dvPnls1a,226]  // 6
BUTTON_EVENT[dvPnls1a,227]  // 7
BUTTON_EVENT[dvPnls1a,228]  // 8
BUTTON_EVENT[dvPnls1a,229]  // 9
{
  PUSH :
  {
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
      CASE 210 : TO[dvCCTV01,50]  // Escape
      CASE 211 : TO[dvCCTV01,45]  // Up
      CASE 212 : TO[dvCCTV01,46]  // Down
      CASE 213 : TO[dvCCTV01,47]  // Left
      CASE 214 : TO[dvCCTV01,48]  // Right
      CASE 215 : TO[dvCCTV01,49]  // Select
      CASE 216 : TO[dvCCTV01,55]  // Setup
      CASE 217 : TO[dvCCTV01,57]  // ID
      CASE 218 : TO[dvCCTV01,58]  // Backup
      CASE 219 : TO[dvCCTV01,59]  // Sequence
      CASE 220 : TO[dvCCTV01,10]  // 0
      CASE 221 : TO[dvCCTV01,11]  // 1
      CASE 222 : TO[dvCCTV01,12]  // 2
      CASE 223 : TO[dvCCTV01,13]  // 3
      CASE 224 : TO[dvCCTV01,14]  // 4
      CASE 225 : TO[dvCCTV01,15]  // 5
      CASE 226 : TO[dvCCTV01,16]  // 6
      CASE 227 : TO[dvCCTV01,17]  // 7
      CASE 228 : TO[dvCCTV01,18]  // 8
      CASE 229 : TO[dvCCTV01,19]  // 9
    }
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
(*-- RMS source useage                                   --*)
(*---------------------------------------------------------*)
[vdvClActions,11] = [dvCCTV01,11]  // Camera 1
[vdvClActions,12] = [dvCCTV01,12]  // Camera 2
[vdvClActions,13] = [dvCCTV01,13]  // Camera 3
[vdvClActions,14] = [dvCCTV01,14]  // Camera 4
[vdvClActions,21] = [dvCCTV01,59]  // Sequence
[vdvClActions,22] = [dvCCTV01,49]  // Quad View


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

