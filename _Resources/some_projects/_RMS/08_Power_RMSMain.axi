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

PROGRAM_NAME='08_Power_RMSMain'

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


// dvSCOUT1
VOLATILE SLONG      slRMSScoutHVACVoltage  // HVAC Voltage

// dvSCOUT1
VOLATILE SLONG      slRMSScoutHVACCurrent  // HVAC Current

// dvSCOUT1
VOLATILE SLONG      slRMSScoutHVACPower  // HVAC Power

// dvSCOUT1
VOLATILE SLONG      slRMSScoutLightingVoltage  // Lighting Voltage

// dvSCOUT1
VOLATILE SLONG      slRMSScoutLightingCurrent  // Lighting Current

// dvSCOUT1
VOLATILE SLONG      slRMSScoutLightingPower  // Lighting Power

// dvSCOUT1
VOLATILE SLONG      slRMSScoutAVVoltage  // AV Voltage

// dvSCOUT1
VOLATILE SLONG      slRMSScoutAVCurrent  // AV Current

// dvSCOUT1
VOLATILE SLONG      slRMSScoutAVPower  // AV Power

// dvSCOUT1
VOLATILE SLONG      slRMSScoutDigitalMediaVoltage  // Digital Media Voltage

// dvSCOUT1
VOLATILE SLONG      slRMSScoutDigitalMediaCurrent  // Digital Media Current

// dvSCOUT1
VOLATILE SLONG      slRMSScoutDigitalMediaPower  // Digital Media Power

// dvSCOUT1
VOLATILE SLONG      slRMSScoutCCTVVoltage  // CCTV Voltage

// dvSCOUT1
VOLATILE SLONG      slRMSScoutCCTVCurrent  // CCTV Current

// dvSCOUT1
VOLATILE SLONG      slRMSScoutCCTVPower  // CCTV Power

// dvSCOUT1
VOLATILE SLONG      slRMSScoutBuildingAccessVoltage  // Building Access Voltage

// dvSCOUT1
VOLATILE SLONG      slRMSScoutBuildingAccessCurrent  // Building Access Current

// dvSCOUT1
VOLATILE SLONG      slRMSScoutBuildingAccessPower  // Building Access Power

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
  RMSNetLinxDeviceOnline(dvTP1a,'NXD-1000Vi')

  RMSRegisterDevice(dvSCOUT1,'Scout','Dent Industries','PowerScout 18')
  RMSRegisterDeviceNumberParam(dvSCOUT1,'HVAC Voltage',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutHVACVoltage,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'HVAC Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutHVACCurrent,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'HVAC Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutHVACPower,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Lighting Voltage',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutLightingVoltage,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Lighting Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutLightingCurrent,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Lighting Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutLightingPower,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'AV Voltage',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutAVVoltage,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'AV Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutAVCurrent,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'AV Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutAVPower,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Digital Media Voltage',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutDigitalMediaVoltage,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Digital Media Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutDigitalMediaCurrent,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Digital Media Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutDigitalMediaPower,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'CCTV Voltage',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutCCTVVoltage,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'CCTV Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutCCTVCurrent,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'CCTV Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutCCTVPower,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Building Access Voltage',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutBuildingAccessVoltage,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Building Access Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutBuildingAccessCurrent,0,0)
  RMSRegisterDeviceNumberParam(dvSCOUT1,'Building Access Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSScoutBuildingAccessPower,0,0)
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
(* Call Name: RMSSetScoutHVACVoltage                          *)
(* Function:  Set HVAC Voltage                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutHVACVoltage(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutHVACVoltage <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'HVAC Voltage',RMS_PARAM_SET,slValue)
  slRMSScoutHVACVoltage = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutHVACCurrent                          *)
(* Function:  Set HVAC Current                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutHVACCurrent(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutHVACCurrent <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'HVAC Current',RMS_PARAM_SET,slValue)
  slRMSScoutHVACCurrent = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutHVACPower                            *)
(* Function:  Set HVAC Power                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutHVACPower(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutHVACPower <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'HVAC Power',RMS_PARAM_SET,slValue)
  slRMSScoutHVACPower = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutLightingVoltage                      *)
(* Function:  Set Lighting Voltage                            *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutLightingVoltage(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutLightingVoltage <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Lighting Voltage',RMS_PARAM_SET,slValue)
  slRMSScoutLightingVoltage = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutLightingCurrent                      *)
(* Function:  Set Lighting Current                            *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutLightingCurrent(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutLightingCurrent <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Lighting Current',RMS_PARAM_SET,slValue)
  slRMSScoutLightingCurrent = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutLightingPower                        *)
(* Function:  Set Lighting Power                              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutLightingPower(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutLightingPower <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Lighting Power',RMS_PARAM_SET,slValue)
  slRMSScoutLightingPower = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutAVVoltage                            *)
(* Function:  Set AV Voltage                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutAVVoltage(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutAVVoltage <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'AV Voltage',RMS_PARAM_SET,slValue)
  slRMSScoutAVVoltage = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutAVCurrent                            *)
(* Function:  Set AV Current                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutAVCurrent(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutAVCurrent <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'AV Current',RMS_PARAM_SET,slValue)
  slRMSScoutAVCurrent = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutAVPower                              *)
(* Function:  Set AV Power                                    *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutAVPower(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutAVPower <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'AV Power',RMS_PARAM_SET,slValue)
  slRMSScoutAVPower = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutDigitalMediaVoltage                  *)
(* Function:  Set Digital Media Voltage                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutDigitalMediaVoltage(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutDigitalMediaVoltage <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Digital Media Voltage',RMS_PARAM_SET,slValue)
  slRMSScoutDigitalMediaVoltage = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutDigitalMediaCurrent                  *)
(* Function:  Set Digital Media Current                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutDigitalMediaCurrent(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutDigitalMediaCurrent <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Digital Media Current',RMS_PARAM_SET,slValue)
  slRMSScoutDigitalMediaCurrent = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutDigitalMediaPower                    *)
(* Function:  Set Digital Media Power                         *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutDigitalMediaPower(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutDigitalMediaPower <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Digital Media Power',RMS_PARAM_SET,slValue)
  slRMSScoutDigitalMediaPower = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutCCTVVoltage                          *)
(* Function:  Set CCTV Voltage                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutCCTVVoltage(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutCCTVVoltage <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'CCTV Voltage',RMS_PARAM_SET,slValue)
  slRMSScoutCCTVVoltage = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutCCTVCurrent                          *)
(* Function:  Set CCTV Current                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutCCTVCurrent(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutCCTVCurrent <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'CCTV Current',RMS_PARAM_SET,slValue)
  slRMSScoutCCTVCurrent = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutCCTVPower                            *)
(* Function:  Set CCTV Power                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutCCTVPower(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutCCTVPower <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'CCTV Power',RMS_PARAM_SET,slValue)
  slRMSScoutCCTVPower = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutBuildingAccessVoltage                *)
(* Function:  Set Building Access Voltage                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutBuildingAccessVoltage(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutBuildingAccessVoltage <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Building Access Voltage',RMS_PARAM_SET,slValue)
  slRMSScoutBuildingAccessVoltage = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutBuildingAccessCurrent                *)
(* Function:  Set Building Access Current                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutBuildingAccessCurrent(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutBuildingAccessCurrent <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Building Access Current',RMS_PARAM_SET,slValue)
  slRMSScoutBuildingAccessCurrent = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetScoutBuildingAccessPower                  *)
(* Function:  Set Building Access Power                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetScoutBuildingAccessPower(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSScoutBuildingAccessPower <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvSCOUT1,'Building Access Power',RMS_PARAM_SET,slValue)
  slRMSScoutBuildingAccessPower = slValue
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

    // Scout
    RMSSetDeviceInfo(dvSCOUT1,'Scout','Dent Industries','PowerScout 18')
    RMSSetCommunicationTimeout(dvSCOUT1,300)
  }
}

(*******************************************)
(* DATA: NXD-1000Vi                        *)
(*******************************************)
DATA_EVENT [dvTP1a]
{
  ONLINE:
    RMSNetLinxDeviceOnline(dvTP1a,'NXD-1000Vi')
  OFFLINE:
    RMSNetLinxDeviceOffline(dvTP1a)
}

(*******************************************)
(* DATA: Scout                             *)
(*******************************************)
DATA_EVENT [dvSCOUT1]
{
  ONLINE:
  {
    RMSRegisterDevice(dvSCOUT1,'Scout','Dent Industries','PowerScout 18')
    RMSRegisterDeviceNumberParam(dvSCOUT1,'HVAC Voltage',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutHVACVoltage,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'HVAC Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutHVACCurrent,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'HVAC Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutHVACPower,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Lighting Voltage',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutLightingVoltage,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Lighting Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutLightingCurrent,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Lighting Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutLightingPower,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'AV Voltage',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutAVVoltage,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'AV Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutAVCurrent,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'AV Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutAVPower,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Digital Media Voltage',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutDigitalMediaVoltage,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Digital Media Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutDigitalMediaCurrent,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Digital Media Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutDigitalMediaPower,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'CCTV Voltage',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutCCTVVoltage,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'CCTV Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutCCTVCurrent,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'CCTV Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutCCTVPower,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Building Access Voltage',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutBuildingAccessVoltage,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Building Access Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutBuildingAccessCurrent,0,0)
    RMSRegisterDeviceNumberParam(dvSCOUT1,'Building Access Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSScoutBuildingAccessPower,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvSCOUT1)
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
    SEND_COMMAND DATA.DEVICE,'SET ROOM INFO-08_Power,Kiosk,AMX'

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
