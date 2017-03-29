PROGRAM_NAME='SubRoutines'
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

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

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

DEFINE_FUNCTION ButtonImage(DEV dvDevice, INTEGER nButton, CHAR cImage[])
{
    SEND_COMMAND dvDevice, "'^BMP-',ITOA(nButton),',0,',cImage"
}

DEFINE_FUNCTION ButtonDynamicImage(DEV dvDevice, INTEGER nButton, CHAR cImage[])
{
    SEND_COMMAND dvDevice, "'^BBR-',ITOA(nButton),',0,',cImage"
}

DEFINE_FUNCTION ButtonText(DEV dvDevice, INTEGER nButton, CHAR cText[])
{
    SEND_COMMAND dvDevice, "'^TXT-',ITOA(nButton),',0,',cText"
}

DEFINE_FUNCTION TemperatureText(DEV dvDevice, INTEGER iAddrCode, INTEGER Temperature)
{
    LOCAL_VAR CHAR cText[20]
    //cText = "ITOA(Temperature),'°C', '++++'" 
    cText = "ITOA(Temperature/10), '.', ITOA(Temperature%10),'°C'"          
    SEND_COMMAND dvDevice, "'^TXT-',ITOA(iAddrCode),',0,',cText"
}







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
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

