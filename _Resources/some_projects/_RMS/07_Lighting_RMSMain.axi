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

PROGRAM_NAME='07_Lighting_RMSMain'

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


// dvLTS01
VOLATILE SLONG      slRMSRadiaDimmerDimmerZone1  // Dimmer Zone 1

// dvLTS01
VOLATILE SLONG      slRMSRadiaDimmerDimmerZone2  // Dimmer Zone 2

// dvLTS01
VOLATILE SLONG      slRMSRadiaDimmerDimmerZone3  // Dimmer Zone 3

// dvLTS01
VOLATILE SLONG      slRMSRadiaDimmerDimmerZone4  // Dimmer Zone 4

// dvLTS01
VOLATILE SLONG      slRMSRadiaDimmerDimmerZone5  // Dimmer Zone 5

// dvLTS01
VOLATILE SLONG      slRMSRadiaDimmerDimmerZone6  // Dimmer Zone 6

// dvLTS02
VOLATILE SLONG      slRMSRadiaRelaysFanZone1  // Fan Zone 1

// dvLTS02
VOLATILE SLONG      slRMSRadiaRelaysFanZone2  // Fan Zone 2

// dvLTS02
VOLATILE SLONG      slRMSRadiaRelaysFanZone3  // Fan Zone 3

// dvLTS02
VOLATILE SLONG      slRMSRadiaRelaysFanZone4  // Fan Zone 4

// dvLTS02
VOLATILE SLONG      slRMSRadiaRelaysFanZone5  // Fan Zone 5

// dvLTS02
VOLATILE SLONG      slRMSRadiaRelaysFanZone6  // Fan Zone 6

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
  RMSNetLinxDeviceOnline(dvKP01,'Keypad 1')

  RMSRegisterDevice(dvLTS01,'Radia Dimmer','AMX','RE-DM6')
  RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 1',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone1,0,255)
  RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 2',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone2,0,255)
  RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 3',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone3,0,255)
  RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 4',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone4,0,255)
  RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 5',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone5,0,255)
  RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 6',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone6,0,255)

  RMSRegisterDevice(dvLTS02,'Radia Relays','AMX','RDM-6EM')
  RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 1',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaRelaysFanZone1,0,0)
  RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 2',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaRelaysFanZone2,0,0)
  RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 3',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaRelaysFanZone3,0,0)
  RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 4',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaRelaysFanZone4,0,0)
  RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 5',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaRelaysFanZone5,0,0)
  RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 6',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSRadiaRelaysFanZone6,0,0)
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


(**************************************************************)
(* Call Name: RMSSetRadiaDimmerDimmerZone1                    *)
(* Function:  Set Dimmer Zone 1                               *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaDimmerDimmerZone1(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaDimmerDimmerZone1 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS01,'Dimmer Zone 1',RMS_PARAM_SET,slValue)
  slRMSRadiaDimmerDimmerZone1 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaDimmerDimmerZone2                    *)
(* Function:  Set Dimmer Zone 2                               *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaDimmerDimmerZone2(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaDimmerDimmerZone2 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS01,'Dimmer Zone 2',RMS_PARAM_SET,slValue)
  slRMSRadiaDimmerDimmerZone2 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaDimmerDimmerZone3                    *)
(* Function:  Set Dimmer Zone 3                               *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaDimmerDimmerZone3(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaDimmerDimmerZone3 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS01,'Dimmer Zone 3',RMS_PARAM_SET,slValue)
  slRMSRadiaDimmerDimmerZone3 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaDimmerDimmerZone4                    *)
(* Function:  Set Dimmer Zone 4                               *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaDimmerDimmerZone4(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaDimmerDimmerZone4 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS01,'Dimmer Zone 4',RMS_PARAM_SET,slValue)
  slRMSRadiaDimmerDimmerZone4 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaDimmerDimmerZone5                    *)
(* Function:  Set Dimmer Zone 5                               *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaDimmerDimmerZone5(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaDimmerDimmerZone5 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS01,'Dimmer Zone 5',RMS_PARAM_SET,slValue)
  slRMSRadiaDimmerDimmerZone5 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaDimmerDimmerZone6                    *)
(* Function:  Set Dimmer Zone 6                               *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaDimmerDimmerZone6(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaDimmerDimmerZone6 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS01,'Dimmer Zone 6',RMS_PARAM_SET,slValue)
  slRMSRadiaDimmerDimmerZone6 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaRelaysFanZone1                       *)
(* Function:  Set Fan Zone 1                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaRelaysFanZone1(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaRelaysFanZone1 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS02,'Fan Zone 1',RMS_PARAM_SET,slValue)
  slRMSRadiaRelaysFanZone1 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaRelaysFanZone2                       *)
(* Function:  Set Fan Zone 2                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaRelaysFanZone2(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaRelaysFanZone2 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS02,'Fan Zone 2',RMS_PARAM_SET,slValue)
  slRMSRadiaRelaysFanZone2 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaRelaysFanZone3                       *)
(* Function:  Set Fan Zone 3                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaRelaysFanZone3(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaRelaysFanZone3 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS02,'Fan Zone 3',RMS_PARAM_SET,slValue)
  slRMSRadiaRelaysFanZone3 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaRelaysFanZone4                       *)
(* Function:  Set Fan Zone 4                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaRelaysFanZone4(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaRelaysFanZone4 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS02,'Fan Zone 4',RMS_PARAM_SET,slValue)
  slRMSRadiaRelaysFanZone4 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaRelaysFanZone5                       *)
(* Function:  Set Fan Zone 5                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaRelaysFanZone5(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaRelaysFanZone5 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS02,'Fan Zone 5',RMS_PARAM_SET,slValue)
  slRMSRadiaRelaysFanZone5 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetRadiaRelaysFanZone6                       *)
(* Function:  Set Fan Zone 6                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetRadiaRelaysFanZone6(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSRadiaRelaysFanZone6 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvLTS02,'Fan Zone 6',RMS_PARAM_SET,slValue)
  slRMSRadiaRelaysFanZone6 = slValue
  bInit = TRUE
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

    // Radia Dimmer
    RMSSetDeviceInfo(dvLTS01,'Radia Dimmer','AMX','RE-DM6')

    // Radia Relays
    RMSSetDeviceInfo(dvLTS02,'Radia Relays','AMX','RDM-6EM')
  }
}

(*******************************************)
(* DATA: Keypad 1                          *)
(*******************************************)
DATA_EVENT [dvKP01]
{
  ONLINE:
    RMSNetLinxDeviceOnline(dvKP01,'Keypad 1')
  OFFLINE:
    RMSNetLinxDeviceOffline(dvKP01)
}

(*******************************************)
(* DATA: Radia Dimmer                      *)
(*******************************************)
DATA_EVENT [dvLTS01]
{
  ONLINE:
  {
    RMSRegisterDevice(dvLTS01,'Radia Dimmer','AMX','RE-DM6')
    RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 1',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone1,0,255)
    RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 2',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone2,0,255)
    RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 3',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone3,0,255)
    RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 4',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone4,0,255)
    RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 5',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone5,0,255)
    RMSRegisterDeviceNumberParam(dvLTS01,'Dimmer Zone 6',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaDimmerDimmerZone6,0,255)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvLTS01)
}

(*******************************************)
(* DATA: Radia Relays                      *)
(*******************************************)
DATA_EVENT [dvLTS02]
{
  ONLINE:
  {
    RMSRegisterDevice(dvLTS02,'Radia Relays','AMX','RDM-6EM')
    RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 1',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaRelaysFanZone1,0,0)
    RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 2',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaRelaysFanZone2,0,0)
    RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 3',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaRelaysFanZone3,0,0)
    RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 4',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaRelaysFanZone4,0,0)
    RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 5',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaRelaysFanZone5,0,0)
    RMSRegisterDeviceNumberParam(dvLTS02,'Fan Zone 6',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSRadiaRelaysFanZone6,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvLTS02)
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
(* LEVEL: dvLTS01                          *)
(*******************************************)
LEVEL_EVENT [dvLTS01,0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 1:
      RMSSetRadiaDimmerDimmerZone1(LEVEL.VALUE)
      break

  }
}

(*******************************************)
(* LEVEL: dvLTS01                          *)
(*******************************************)
LEVEL_EVENT [dvLTS01,0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 2:
      RMSSetRadiaDimmerDimmerZone2(LEVEL.VALUE)
      break

  }
}

(*******************************************)
(* LEVEL: dvLTS01                          *)
(*******************************************)
LEVEL_EVENT [dvLTS01,0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 3:
      RMSSetRadiaDimmerDimmerZone3(LEVEL.VALUE)
      break

  }
}

(*******************************************)
(* LEVEL: dvLTS01                          *)
(*******************************************)
LEVEL_EVENT [dvLTS01,0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 4:
      RMSSetRadiaDimmerDimmerZone4(LEVEL.VALUE)
      break

  }
}

(*******************************************)
(* LEVEL: dvLTS01                          *)
(*******************************************)
LEVEL_EVENT [dvLTS01,0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 5:
      RMSSetRadiaDimmerDimmerZone5(LEVEL.VALUE)
      break

  }
}

(*******************************************)
(* LEVEL: dvLTS01                          *)
(*******************************************)
LEVEL_EVENT [dvLTS01,0]
{
  SWITCH (LEVEL.INPUT.LEVEL)
  {
    CASE 6:
      RMSSetRadiaDimmerDimmerZone6(LEVEL.VALUE)
      break

  }
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
    SEND_COMMAND DATA.DEVICE,'SET ROOM INFO-07_Lighting,Kiosk,AMX'

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
