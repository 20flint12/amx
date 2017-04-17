(*********************************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/26/2010  AT: 16:34:26        *)
(***********************************************************)
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

PROGRAM_NAME='RMSDigitalMedia'

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

// Panel Devices:
// dvTP
#IF_NOT_DEFINED dvTP
#WARN 'RMS: This Device Needs to be Defined in your Main Program: dvTP'
#END_IF

// Meeting Manager Devices:
// dvTP
#IF_NOT_DEFINED dvTP
#WARN 'RMS: This Device Needs to be Defined in your Main Program: dvTP'
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
INTEGER nAutoIS
///////////////////////////////////////////////////////
// Devices
///////////////////////////////////////////////////////
// RMS Welcome Devices
VOLATILE DEV dvRMSTPWelcome[] =
{
  dvTP
}

// RMS Welcome Base Devices
VOLATILE DEV dvRMSTPWelcome_Base[] =
{
  dvTP
}

// Main/Welcome Panel Subject String
VOLATILE CHAR    acRMS_MEETING_DEFAULT_SUBJECT[] =     'Ad Hoc Meeting'

// Main/Welcome Panel Message String
VOLATILE CHAR    acRMS_MEETING_DEFAULT_MESSAGE[] =     'Please do not disturb'

// i-ConnectLinx paramater storage
VOLATILE SLONG   asnNumberLevelArgValues[3]
VOLATILE CHAR    acStringEnumArgValues[3][50]


// i!-ConnectLinx Standard Actions
VOLATILE INTEGER nchCLdvTPButtons[] =
{
  1002,                             // Power Off
  1001,                             // Power On
  51,
  52
}

// i!-ConnectLinx Touch Panel Buttons
VOLATILE INTEGER nchCLdvTPPanelButtons[] =
{
  80,                               // Power Off
  81,                               // Power On
  51,                               // custom playlist1
  52                                // custom playlist2
}

(* Call Name: RMSDevMonRegisterCallback*)
DEFINE_FUNCTION RMSDevMonRegisterCallback()
{
  //Named NetLinx Devices
  RMSNetLinxDeviceOnline(dvTP,'Welcome Panel')
  RMSRegisterDevice(dvIS_SPX,'Inspired Signage','AMX','IS-SPX-1000')
}

(* Call Name: RMSDevMonSetParamCallback*)
(* Param:     DPS, Name, Value         *)
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
// Inspired Signage
DEFINE_MODULE 'RMSBasicDeviceMod' mdlBasicDev01(dvIS_SPX,
                                                dvIS_SPX,
                                                vdvRMSEngine)
// RMSEngineMod - The RMS engine. Requires i!-ConnectLinxEngineMod.
DEFINE_MODULE 'RMSEngineMod' mdlRMSEng(vdvRMSEngine,
                                       dvRMSSocket,
                                       vdvCLActions)


// RMSUIMod - The RMS User Interface.  Requires KeyboardMod.
// Channel And Variable Text Code Defined Inside The Module
DEFINE_MODULE 'RMSUIMod' mdlRMSUI(vdvRMSEngine,
                                  dvRMSTPWelcome,
				  dvRMSTPWelcome_Base,
                                  dvRMSTPWelcome,
				  dvRMSTPWelcome_Base,
				  acRMS_MEETING_DEFAULT_SUBJECT,
				  acRMS_MEETING_DEFAULT_MESSAGE)

// RMSWelcomeOnlyUIMod - The RMS Welcome Panel User Interface.
// Channel And Variable Text Code Defined Inside The Module
DEFINE_MODULE 'RMSWelcomeOnlyUIMod' mdlRMSUI(vdvRMSEngine,
                                             dvRMSTPWelcome,
                                             dvRMSTPWelcome_Base,
                                             acRMS_MEETING_DEFAULT_SUBJECT,
                                             acRMS_MEETING_DEFAULT_MESSAGE)
// i!-ConnectLinxEngineMod
DEFINE_MODULE 'i!-ConnectLinxEngineMod' mdlCL(vdvCLActions)
(***********************************************************)
(*                  THE EVENTS GOES BELOW                  *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT[vdvRMSEngine]
{
  ONLINE:
  {
    // Configure RMS Server Address
    RMSSetServer(RMS_SERVER_IP)
    // Inspired Signage
    RMSSetDeviceInfo(dvIS_SPX,'Inspired Signage','AMX','IS-SPX-1000')
    RMSSetCommunicationTimeout(dvIS_SPX,300)
  }
}
DATA_EVENT [dvTP]
{
  ONLINE:
    RMSNetLinxDeviceOnline(dvTP,'Welcome Panel')
  OFFLINE:
    RMSNetLinxDeviceOffline(dvTP)
}
LEVEL_EVENT[vdvCLActions,0]
{
  //Store it if we have room
  IF (MAX_LENGTH_ARRAY(asnNumberLevelArgValues) >= LEVEL.INPUT.LEVEL)
    asnNumberLevelArgValues [LEVEL.INPUT.LEVEL] = LEVEL.Value
}
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
    //SEND_COMMAND DATA.DEVICE,'SET ROOM INFO-Digital Media,InfoComm 2010,Doug Hall'
    //SEND_COMMAND DATA.DEVICE,'ADD STD-1001-1002'
    //SEND_COMMAND DATA.DEVICE,'ADD ACTION-51,Select Playlist Emergency'
    //SEND_COMMAND DATA.DEVICE,'ADD FOLDER-Inspired Signage'
    //SEND_COMMAND DATA.DEVICE,'ADD FOLDER-Emergency Playlist,Inspired Signage'
    //SEND_COMMAND DATA.DEVICE,'ADD ACTION-52,Select Playlist AMX Demo'
  }
}
BUTTON_EVENT [vdvCLActions,nchCLdvTPButtons]
{
  PUSH:
  {
    DO_PUSH(dvTP,nchCLdvTPPanelButtons[GET_LAST(nchCLdvTPButtons)])
    send_string 0,"'btnEVT [vdvCLActions,',ITOA(PUSH_CHANNEL),']'"
  }
}
//custom src
BUTTON_EVENT[dvTP,nchCLdvTPPanelButtons]
{
  PUSH:
  {
    send_string 0,"'btnEVT [dvTP,',ITOA(PUSH_CHANNEL),']'"
    SWITCH(PUSH_CHANNEL)
    {
      CASE 80://pwr off
      {
        OFF[dvTP,81]
        ON[dvTP,PUSH_CHANNEL]
	OFF[dvTP,51]
	OFF[dvTP,52]
	nAutoIS = 1
      }
      CASE 81://pwr on
      {
        OFF[dvTP,80]
        ON[dvTP,PUSH_CHANNEL]
	nAutoIS = 1
      }
      CASE 51://rms schedule playlist
      {
        IP_CLIENT_OPEN(dvIS_SPX.PORT,'192.168.1.112',nIPPort,1)
	WAIT 2
	{
          OFF[dvTP,52]
          ON[dvTP,PUSH_CHANNEL]
          SEND_STRING dvIS_SPX,"'GET /update?RMSMENU=RMS HTTP/1.1',$0D,$0A,'Host: 192.168.1.112:1234',$0D,$0A,'Connection: keep-alive',$0D,$0A"
        }
	nAutoIS = 0
      }
      CASE 52://amxdemo playlist
      {
        IP_CLIENT_OPEN(dvIS_SPX.PORT,'192.168.1.112',nIPPort,1)
	WAIT 2
	{
          OFF[dvTP,51]
          ON[dvTP,PUSH_CHANNEL]
	  SEND_STRING dvIS_SPX,"'GET /update?RMSMENU=DEFAULT HTTP/1.1',$0D,$0A,'Host: 192.168.1.112:1234',$0D,$0A,'Connection: keep-alive',$0D,$0A"
	}
	nAutoIS = 0
      }
    }
  }
}
CHANNEL_EVENT [dvTP,nchCLdvTPPanelButtons]
{
  ON:
  {
    ON[vdvCLActions,nchCLdvTPButtons[GET_LAST(nchCLdvTPPanelButtons)]]
    send_string 0,"'chanEVT ON! [vdvCLActions,nchCLdvTPButtons[',ITOA(GET_LAST(nchCLdvTPPanelButtons)),']]'"
  }
  OFF:
  {
    OFF[vdvCLActions,nchCLdvTPButtons[GET_LAST(nchCLdvTPPanelButtons)]]
    send_string 0,"'chanEVT OFF! [vdvCLActions,nchCLdvTPButtons[',ITOA(GET_LAST(nchCLdvTPPanelButtons)),']]'"
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
WAIT 1500
{
  //IF(nAutoIS = 1)
  //{
    DO_PUSH(dvTP,nchCLdvTPButtons[3])
    //SEND_STRING dvIS_SPX,"'GET /update?RMSMENU=RMS HTTP/1.1',$0D,$0A,'Host: 192.168.1.112:1234',$0D,$0A,'Connection: keep-alive',$0D,$0A"
    WAIT 300
    {
      DO_PUSH(dvTP,nchCLdvTPButtons[4])
    }
  //}
}