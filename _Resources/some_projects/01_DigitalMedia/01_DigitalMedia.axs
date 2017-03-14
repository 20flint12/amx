PROGRAM_NAME='01_DigitalMedia'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/27/2010  AT: 12:55:07        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
dvTP       = 10111:1:0
dvIS_SPX   = 0:5:0
(*****************************s******************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT
INTEGER nIPPort=1234
INTEGER UI_BUTTONS[]={1,2,3}

(***********************************************************)
(*                 INCLUDE FILES GO BELOW                  *)
(***********************************************************)
#INCLUDE 'RMSDigitalMedia'
#INCLUDE 'RMSGlobals.axi'
(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE
(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

    WAIT 300
    {
      send_string 0,"'try to open IP socket!!!'"
      IP_CLIENT_OPEN(dvIS_SPX.PORT,'192.168.1.112',nIPPort,1)
    }
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT[dvIS_SPX]
{
  ONLINE:
  {

  }
  ONERROR:
  {
    SEND_STRING 0,"'error: dvIS_SPX=',ITOA(Data.Number)"
  }
  OFFLINE:
  {

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
    RMSGlobals(1)
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
        IP_CLIENT_OPEN(dvIS_SPX.PORT,'192.168.1.112',nIPPort,1)
	WAIT 2
	{
	  SEND_STRING dvIS_SPX,"'GET /update?RMSMENU=ALARM HTTP/1.1',$0D,$0A,'Host: 192.168.1.112:1234',$0D,$0A,'Connection: keep-alive',$0D,$0A"
	}  
        SEND_COMMAND dvTP,'@PPN-RMS_ALERT'
	nAutoIS = 0
      }
      CASE 5 :
      {
        DO_PUSH(dvTP,nchCLdvTPButtons[3])
        SEND_COMMAND dvTP,'@PPK-RMS_ALERT'
	nAutoIS = 0
      }
    }
  }
}
//nchCLdvTPButtons[1] // [1002] Power Off
//nchCLdvTPButtons[2] // [1001] Power On
//nchCLdvTPButtons[3] // [51]   Playlist 1 (Emergency)
//nchCLdvTPButtons[4] // [52]   Playlist 2 (AMX Demo)


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)