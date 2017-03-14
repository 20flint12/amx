PROGRAM_NAME='02_Security'
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

(*-- Door Access ------------------------------------------*)
dvDOOR01    = 0:4:0       // Brivo ACS-5000
vdvDOOR01   = 33003:1:0


(*-- Panels -----------------------------------------------*)
dvTP1a      = 10001:1:0   // NXD-1200VG


(*-- RMS (See RMSMain.axi) --------------------------------*)
//dvRMSSocket              = 0:3:0
//vdvRMSEngine             = 33001:1:0
//vdvCLActions             = 33002:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(*-- Name and Ver of this include -------------------------*)
CHAR AXS_NAME[]           = '02_Security'
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
INCLUDE '02_BuildingAccess_RMSMain.axi'
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


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(*-- Print version ----------------------------------------*)
SEND_STRING 0,"'  Running ',AXS_NAME,' v',AXS_VER"


(***********************************************************)
(*                MODULE  CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_MODULE 'Brivo_ACS5000_Comm_dr1_0_0' comm1(vdvDOOR01, dvDOOR01)


(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

(*------------------------------------------------------------------------------------------------------------------*)
(*---------------------------------- Initialization goes here ------------------------------------------------------*)
(*------------------------------------------------------------------------------------------------------------------*)

(*---------------------------------------------------------*)
(*-- Initialize door access.                             --*)
(*---------------------------------------------------------*)
DATA_EVENT[vdvDOOR01]
{
	ONLINE:
	{
		SEND_COMMAND vdvDOOR01, "'PROPERTY-IP_Address,192.168.1.122'"
		SEND_COMMAND vdvDOOR01, "'PROPERTY-User_Name,admin'"
		SEND_COMMAND vdvDOOR01, "'PROPERTY-Password,brivo1'"
		SEND_COMMAND vdvDOOR01, "'REINIT'"
	}
  COMMAND :
  {
    STACK_VAR CHAR    cCmd[DUET_MAX_CMD_LEN]
    STACK_VAR CHAR    cHeader[DUET_MAX_HDR_LEN]
    STACK_VAR CHAR    cValue [DUET_MAX_PARAM_LEN]

    cCmd    = DATA.TEXT
    cHeader = DuetParseCmdHeader(cCmd)
    cValue  = DuetParseCmdParam(cCmd)

    SWITCH(cHeader)
    {
      CASE 'EVENT'    :
      {
        IF(FIND_STRING(UPPER_STRING(cValue),'FORCED OPEN',1))
        {
          RMSSetSecurityForcedOpen (1)

          CANCEL_WAIT 'FORCED_OPEN'
          WAIT 50 'FORCED_OPEN'
            RMSSetSecurityForcedOpen (0)
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
    RMSGlobals (2)
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


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(*---------------------------------------------------------*)
(*-- Fire flashers are tied to fire pulls.               --*)
(*---------------------------------------------------------*)
[dvPnls1a,1] = [vdvDOOR01,1]
[dvPnls1a,2] = [vdvDOOR01,2]
[dvPnls1a,3] = [vdvDOOR01,3]
[dvPnls1a,4] = [vdvDOOR01,4]


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

