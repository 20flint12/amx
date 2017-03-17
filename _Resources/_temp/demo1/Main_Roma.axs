PROGRAM_NAME='Main_Roma'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)

DEFINE_DEVICE

LUTRON	=	5001:1:1 // Lutron HW

NIBE	=	5001:2:1 // �������� �����

IPAD1 = 11001:1:1

// Lutron
vdvHW_KEYPAD1  = 34001:1:1    // 


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV ALL_MVP [1] = {IPAD1}

VOLATILE CHAR Buffer_Nibe [1000]

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER  NIBE, Buffer_Nibe







(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT [ALL_MVP]
    {
	ONLINE:{SEND_COMMAND Nibe, '0x2B' }
    }








(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

