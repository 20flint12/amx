(*********************************************************************)
(*                                                                   *)
(*              AMX Resource Management Suite (3.3.33)               *)
(*                                                                   *)
(*********************************************************************)
/*
  * Legal Notice :
  *
  *    Copyright,  AMX LLC, 2008
  *
  *    Private, proprietary information, the sole property of AMX LLC.  The
  *    contents, ideas, and concepts expressed herein are not to be disclosed
  *    except within the confines of a confidential relationship and only
  *    then on a need to know basis.
  *
  *    Any entity in possession of this AMX Software shall not, and shall not
  *    permit any other person to, disclose, display, loan, publish, transfer
  *    (whether by sale, assignment, exchange, gift, operation of law or
  *    otherwise), license, sublicense, copy, or otherwise disseminate this
  *    AMX Software.
  *
  *    This AMX Software is owned by AMX and is protected by United States
  *    copyright laws, patent laws, international treaty provisions, and/or
  *    state of Texas trade secret laws.
  *
  *    Portions of this AMX Software may, from time to time, include
  *    pre-release code and such code may not be at the level of performance,
  *    compatibility and functionality of the final code. The pre-release code
  *    may not operate correctly and may be substantially modified prior to
  *    final release or certain features may not be generally released. AMX is
  *    not obligated to make or support any pre-release code. All pre-release
  *    code is provided /as is/ with no warranties.
  *
  *    This AMX Software is provided with restricted rights. Use, duplication,
  *    or disclosure by the Government is subject to restrictions as set forth
  *    in subparagraph (1)(ii) of The Rights in Technical Data and Computer
  *    Software clause at DFARS 252.227-7013 or subparagraphs (1) and (2) of
  *    the Commercial Computer Software Restricted Rights at 48 CFR 52.227-19,
  *    as applicable.
  *
*/

PROGRAM_NAME='03_CCTV_RMSMain'

(*{{PS_SOURCE_INFO(PROGRAM STATS)                          *)
(***********************************************************)
(*  ORPHAN_FILE_PLATFORM: 1                                *)
(***********************************************************)
(*}}PS_SOURCE_INFO                                         *)
(***********************************************************)

(***********************************************************)
(*           DEVICE NUMBER DEFINITIONS GO BELOW            *)
(***********************************************************)
DEFINE_DEVICE

// vdvRMSEngine
vdvRMSEngine             = 33001:1:0

// dvRMSSocket
dvRMSSocket              = 0:3:0

// vdvCLActions
vdvCLActions             = 33002:1:0

// These Devices Need to be Defined in your Main Program:
// Core Devices:
// vdvRMSEngine
#IF_NOT_DEFINED vdvRMSEngine
#WARN 'RMS: This Device Needs to be Defined in your Main Program: vdvRMSEngine'
#END_IF

// dvRMSSocket
#IF_NOT_DEFINED dvRMSSocket
#WARN 'RMS: This Device Needs to be Defined in your Main Program: dvRMSSocket'
#END_IF

// vdvCLActions
#IF_NOT_DEFINED vdvCLActions
#WARN 'RMS: This Device Needs to be Defined in your Main Program: vdvCLActions'
#END_IF

(***********************************************************)
(*              CONSTANT DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_CONSTANT

// RMS Server IP
CHAR RMS_SERVER_IP[100]   = '192.168.1.101'

// Max String/Enum Param Length
RMS_MAX_PARAM_LEN         = 100

(***********************************************************)
(*                 INCLUDE FILES GO BELOW                  *)
(***********************************************************)
#INCLUDE 'RMSCommon.axi'

(***********************************************************)
(*              VARIABLE DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_VARIABLE

///////////////////////////////////////////////////////
// Devices
///////////////////////////////////////////////////////
// i-ConnectLinx paramater storage
VOLATILE SLONG   asnNumberLevelArgValues[3]
VOLATILE CHAR    acStringEnumArgValues[3][50]

(***********************************************************)
(*             SUBROUTINE DEFINITIONS GO BELOW             *)
(***********************************************************)

(***************************************)
(* Call Name: RMSDevMonRegisterCallback*)
(* Function:  time to register devices *)
(* Param:     None                     *)
(* Return:    None                     *)
(* Note:      Caller must define this  *)
(***************************************)
DEFINE_FUNCTION RMSDevMonRegisterCallback()
{
  //Named NetLinx Devices
  RMSNetLinxDeviceOnline(dvTP1a,'NXD-1500VG')

  RMSRegisterDevice(dvCCTV01,'CCTV Controller','Samsung','SHR-3040')
}

(***************************************)
(* Call Name: RMSDevMonSetParamCallback*)
(* Function:  Reset parameters         *)
(* Param:     DPS, Name, Value         *)
(* Return:    None                     *)
(* Note:      Caller must define this  *)
(***************************************)
DEFINE_FUNCTION RMSDevMonSetParamCallback(DEV dvDPS, CHAR cName[], CHAR cValue[])
{
}

(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                 MODULE CODE GOES BELOW                  *)
(***********************************************************)

// RMSSrcUsageMod - Tracks equipment usage
DEFINE_MODULE 'RMSSrcUsageMod' mdlSrcUsage(vdvRMSEngine,
                                           vdvCLActions)

// RMSEngineMod - The RMS engine. Requires i!-ConnectLinxEngineMod.
DEFINE_MODULE 'RMSEngineMod' mdlRMSEng(vdvRMSEngine,
                                       dvRMSSocket,
                                       vdvCLActions)

// i!-ConnectLinxEngineMod
DEFINE_MODULE 'i!-ConnectLinxEngineMod' mdlCL(vdvCLActions)

(***********************************************************)
(*                  THE EVENTS GOES BELOW                  *)
(***********************************************************)
DEFINE_EVENT

(*******************************************)
(* DATA: RMS Engine                        *)
(*******************************************)
DATA_EVENT[vdvRMSEngine]
{
  ONLINE:
  {
    // Configure RMS Server Address
    RMSSetServer(RMS_SERVER_IP)

    // CCTV Controller
    RMSSetDeviceInfo(dvCCTV01,'CCTV Controller','Samsung','SHR-3040')
  }
}

(*******************************************)
(* DATA: NXD-1500VG                        *)
(*******************************************)
DATA_EVENT [dvTP1a]
{
  ONLINE:
    RMSNetLinxDeviceOnline(dvTP1a,'NXD-1500VG')
  OFFLINE:
    RMSNetLinxDeviceOffline(dvTP1a)
}

(*******************************************)
(* DATA: CCTV Controller                   *)
(*******************************************)
DATA_EVENT [dvCCTV01]
{
  ONLINE:
  {
    RMSRegisterDevice(dvCCTV01,'CCTV Controller','Samsung','SHR-3040')
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvCCTV01)
}

(*******************************************)
(* LEVEL: i!-ConnectLinx Engine            *)
(*******************************************)
LEVEL_EVENT[vdvCLActions,0]
{
  //Store it if we have room
  IF (MAX_LENGTH_ARRAY(asnNumberLevelArgValues) >= LEVEL.INPUT.LEVEL)
    asnNumberLevelArgValues [LEVEL.INPUT.LEVEL] = LEVEL.Value
}

(*******************************************)
(* DATA: i!-ConnectLinx Engine             *)
(*******************************************)
DATA_EVENT[vdvCLActions]
{
  STRING:
  {
    STACK_VAR
    CHAR    cTemp[1000]
    CHAR    cTrash[10]
    INTEGER nId

    // Look for arguments
    IF (LEFT_STRING(DATA.TEXT,3) = 'ARG')
    {
      // Get arg ID
      cTemp = DATA.Text
      cTrash = REMOVE_STRING(cTemp,'ARG',1)
      nId = ATOI(cTemp)
      cTrash = REMOVE_STRING(cTemp,'-',1)

      // Store it if we have room
      IF (MAX_LENGTH_ARRAY(acStringEnumArgValues) >= nId)
        acStringEnumArgValues [nId] = cTemp
    }
  }

  ONLINE:
  {
    // Set Room Info
    SEND_COMMAND DATA.DEVICE,'SET ROOM INFO-03_CCTV,Kiosk,AMX'

  }
}

(***********************************************************)
(*              THE ACTUAL PROGRAM GOES BELOW              *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*         DO NOT PUT ANY CODE BELOW THIS COMMENT          *)
(***********************************************************)
