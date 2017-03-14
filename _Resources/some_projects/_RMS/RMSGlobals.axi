(*---------------------------------------------------------*)
(*-- Add i!-ConnectLinx actions.                         --*)
(*---------------------------------------------------------*)
DEFINE_FUNCTION RMSGlobals (INTEGER nIdx)
{
  SEND_COMMAND vdvCLActions,'ADD FOLDER-Alert'
  SEND_COMMAND vdvCLActions,'ADD ACTION-1,Alert 1,Alert 1,Alert'
  SEND_COMMAND vdvCLActions,'ADD ACTION-2,Alert 2,Alert 2,Alert'
  SEND_COMMAND vdvCLActions,'ADD ACTION-3,Alert 3,Alert 3,Alert'
  SEND_COMMAND vdvCLActions,'ADD ACTION-4,Alert 4,Alert 4,Alert'
  SEND_COMMAND vdvCLActions,'ADD ACTION-5,Normal Operation,Normal Operation,Alert'
}