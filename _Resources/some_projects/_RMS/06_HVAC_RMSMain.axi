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

PROGRAM_NAME='06_HVAC_RMSMain'

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


// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat1RoomSetpoint  // Stat1 Room Setpoint

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat1HeatSetpointOccupied  // Stat1 Heat Setpoint Occupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat1CoolSetpointOccupied  // Stat1 Cool Setpoint Occupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat1HeatSetpointUnoccupied  // Stat1 Heat Setpoint Unoccupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat1CoolSetpointUnoccupied  // Stat1 Cool Setpoint Unoccupied

// vdvHVAC01
CHAR                acRMSBacnetGatewayStat1Mode[RMS_MAX_PARAM_LEN]  // Stat1 Mode

// vdvHVAC01
CHAR                acRMSBacnetGatewayStat1Fan[RMS_MAX_PARAM_LEN]  // Stat1 Fan

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat1Occ  // Stat1 Occ

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat2RoomSetpoint  // Stat2 Room Setpoint

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat2HeatSetpointOccupied  // Stat2 Heat Setpoint Occupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat2CoolSetpointOccupied  // Stat2 Cool Setpoint Occupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat2HeatSetpointUnoccupied  // Stat2 Heat Setpoint Unoccupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat2CoolSetpointUnoccupied  // Stat2 Cool Setpoint Unoccupied

// vdvHVAC01
CHAR                acRMSBacnetGatewayStat2Mode[RMS_MAX_PARAM_LEN]  // Stat2 Mode

// vdvHVAC01
CHAR                acRMSBacnetGatewayStat2Fan[RMS_MAX_PARAM_LEN]  // Stat2 Fan

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat2Occ  // Stat2 Occ

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat3RoomSetpoint  // Stat3 Room Setpoint

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat3HeatSetpointOccupied  // Stat3 Heat Setpoint Occupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat3CoolSetpointOccupied  // Stat3 Cool Setpoint Occupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat3HeatSetpointUnoccupied  // Stat3 Heat Setpoint Unoccupied

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat3CoolSetpointUnoccupied  // Stat3 Cool Setpoint Unoccupied

// vdvHVAC01
CHAR                acRMSBacnetGatewayStat3Mode[RMS_MAX_PARAM_LEN]  // Stat3 Mode

// vdvHVAC01
CHAR                acRMSBacnetGatewayStat3Fan[RMS_MAX_PARAM_LEN]  // Stat3 Fan

// vdvHVAC01
VOLATILE SLONG      slRMSBacnetGatewayStat3Occ  // Stat3 Occ

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
  RMSNetLinxDeviceOnline(dvTP1a,'Touch Panel')

  RMSRegisterDevice(vdvHVAC01,'Bacnet Gateway','FieldServer','FSB-3510')
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Room Setpoint',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat1RoomSetpoint,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Heat Setpoint Occupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat1HeatSetpointOccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Cool Setpoint Occupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat1CoolSetpointOccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Heat Setpoint Unoccupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat1HeatSetpointUnoccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Cool Setpoint Unoccupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat1CoolSetpointUnoccupied,55,99)
  RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat1 Mode',
      '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,'',
      RMS_PARAM_SET,acRMSBacnetGatewayStat1Mode,
      'OFF|AUTO|COOL|HEAT')
  RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat1 Fan',
      '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,'',
      RMS_PARAM_SET,acRMSBacnetGatewayStat1Fan,
      'OFF|LOW|MED|HIGH')
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Occ',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat1Occ,0,1)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Room Setpoint',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat2RoomSetpoint,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Heat Setpoint Occupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat2HeatSetpointOccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Cool Setpoint Occupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat2CoolSetpointOccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Heat Setpoint Unoccupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat2HeatSetpointUnoccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Cool Setpoint Unoccupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat2CoolSetpointUnoccupied,55,99)
  RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat2 Mode',
      '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,'',
      RMS_PARAM_SET,acRMSBacnetGatewayStat2Mode,
      'OFF|AUTO|COOL|HEAT')
  RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat2 Fan',
      '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,'',
      RMS_PARAM_SET,acRMSBacnetGatewayStat2Fan,
      'OFF|LOW|MED|HIGH')
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Occ',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat2Occ,0,1)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Room Setpoint',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat3RoomSetpoint,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Heat Setpoint Occupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat3HeatSetpointOccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Cool Setpoint Occupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat3CoolSetpointOccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Heat Setpoint Unoccupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat3HeatSetpointUnoccupied,55,99)
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Cool Setpoint Unoccupied',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat3CoolSetpointUnoccupied,55,99)
  RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat3 Mode',
      '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,'',
      RMS_PARAM_SET,acRMSBacnetGatewayStat3Mode,
      'OFF|AUTO|COOL|HEAT')
  RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat3 Fan',
      '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,'',
      RMS_PARAM_SET,acRMSBacnetGatewayStat3Fan,
      'OFF|LOW|MED|HIGH')
  RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Occ',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSBacnetGatewayStat3Occ,0,1)
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
(* Call Name: RMSSetBacnetGatewayStat1RoomSetpoint            *)
(* Function:  Set Stat1 Room Setpoint                         *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat1RoomSetpoint(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat1RoomSetpoint <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat1 Room Setpoint',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat1RoomSetpoint = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat1HeatSetpointOccupied    *)
(* Function:  Set Stat1 Heat Setpoint Occupied                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat1HeatSetpointOccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat1HeatSetpointOccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat1 Heat Setpoint Occupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat1HeatSetpointOccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat1CoolSetpointOccupied    *)
(* Function:  Set Stat1 Cool Setpoint Occupied                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat1CoolSetpointOccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat1CoolSetpointOccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat1 Cool Setpoint Occupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat1CoolSetpointOccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat1HeatSetpointUnoccupied  *)
(* Function:  Set Stat1 Heat Setpoint Unoccupied              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat1HeatSetpointUnoccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat1HeatSetpointUnoccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat1 Heat Setpoint Unoccupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat1HeatSetpointUnoccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat1CoolSetpointUnoccupied  *)
(* Function:  Set Stat1 Cool Setpoint Unoccupied              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat1CoolSetpointUnoccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat1CoolSetpointUnoccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat1 Cool Setpoint Unoccupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat1CoolSetpointUnoccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat1Mode                    *)
(* Function:  Set Stat1 Mode                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat1Mode(CHAR cValue[])
LOCAL_VAR
CHAR bInit
{
  IF (acRMSBacnetGatewayStat1Mode <> cValue || bInit = FALSE)
    RMSChangeEnumParam(vdvHVAC01,'Stat1 Mode',cValue)
  acRMSBacnetGatewayStat1Mode = cValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat1Fan                     *)
(* Function:  Set Stat1 Fan                                   *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat1Fan(CHAR cValue[])
LOCAL_VAR
CHAR bInit
{
  IF (acRMSBacnetGatewayStat1Fan <> cValue || bInit = FALSE)
    RMSChangeEnumParam(vdvHVAC01,'Stat1 Fan',cValue)
  acRMSBacnetGatewayStat1Fan = cValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat1Occ                     *)
(* Function:  Set Stat1 Occ                                   *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat1Occ(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat1Occ <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat1 Occ',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat1Occ = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat2RoomSetpoint            *)
(* Function:  Set Stat2 Room Setpoint                         *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat2RoomSetpoint(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat2RoomSetpoint <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat2 Room Setpoint',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat2RoomSetpoint = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat2HeatSetpointOccupied    *)
(* Function:  Set Stat2 Heat Setpoint Occupied                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat2HeatSetpointOccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat2HeatSetpointOccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat2 Heat Setpoint Occupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat2HeatSetpointOccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat2CoolSetpointOccupied    *)
(* Function:  Set Stat2 Cool Setpoint Occupied                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat2CoolSetpointOccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat2CoolSetpointOccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat2 Cool Setpoint Occupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat2CoolSetpointOccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat2HeatSetpointUnoccupied  *)
(* Function:  Set Stat2 Heat Setpoint Unoccupied              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat2HeatSetpointUnoccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat2HeatSetpointUnoccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat2 Heat Setpoint Unoccupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat2HeatSetpointUnoccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat2CoolSetpointUnoccupied  *)
(* Function:  Set Stat2 Cool Setpoint Unoccupied              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat2CoolSetpointUnoccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat2CoolSetpointUnoccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat2 Cool Setpoint Unoccupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat2CoolSetpointUnoccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat2Mode                    *)
(* Function:  Set Stat2 Mode                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat2Mode(CHAR cValue[])
LOCAL_VAR
CHAR bInit
{
  IF (acRMSBacnetGatewayStat2Mode <> cValue || bInit = FALSE)
    RMSChangeEnumParam(vdvHVAC01,'Stat2 Mode',cValue)
  acRMSBacnetGatewayStat2Mode = cValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat2Fan                     *)
(* Function:  Set Stat2 Fan                                   *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat2Fan(CHAR cValue[])
LOCAL_VAR
CHAR bInit
{
  IF (acRMSBacnetGatewayStat2Fan <> cValue || bInit = FALSE)
    RMSChangeEnumParam(vdvHVAC01,'Stat2 Fan',cValue)
  acRMSBacnetGatewayStat2Fan = cValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat2Occ                     *)
(* Function:  Set Stat2 Occ                                   *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat2Occ(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat2Occ <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat2 Occ',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat2Occ = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat3RoomSetpoint            *)
(* Function:  Set Stat3 Room Setpoint                         *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat3RoomSetpoint(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat3RoomSetpoint <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat3 Room Setpoint',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat3RoomSetpoint = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat3HeatSetpointOccupied    *)
(* Function:  Set Stat3 Heat Setpoint Occupied                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat3HeatSetpointOccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat3HeatSetpointOccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat3 Heat Setpoint Occupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat3HeatSetpointOccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat3CoolSetpointOccupied    *)
(* Function:  Set Stat3 Cool Setpoint Occupied                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat3CoolSetpointOccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat3CoolSetpointOccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat3 Cool Setpoint Occupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat3CoolSetpointOccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat3HeatSetpointUnoccupied  *)
(* Function:  Set Stat3 Heat Setpoint Unoccupied              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat3HeatSetpointUnoccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat3HeatSetpointUnoccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat3 Heat Setpoint Unoccupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat3HeatSetpointUnoccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat3CoolSetpointUnoccupied  *)
(* Function:  Set Stat3 Cool Setpoint Unoccupied              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat3CoolSetpointUnoccupied(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat3CoolSetpointUnoccupied <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat3 Cool Setpoint Unoccupied',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat3CoolSetpointUnoccupied = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat3Mode                    *)
(* Function:  Set Stat3 Mode                                  *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat3Mode(CHAR cValue[])
LOCAL_VAR
CHAR bInit
{
  IF (acRMSBacnetGatewayStat3Mode <> cValue || bInit = FALSE)
    RMSChangeEnumParam(vdvHVAC01,'Stat3 Mode',cValue)
  acRMSBacnetGatewayStat3Mode = cValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat3Fan                     *)
(* Function:  Set Stat3 Fan                                   *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat3Fan(CHAR cValue[])
LOCAL_VAR
CHAR bInit
{
  IF (acRMSBacnetGatewayStat3Fan <> cValue || bInit = FALSE)
    RMSChangeEnumParam(vdvHVAC01,'Stat3 Fan',cValue)
  acRMSBacnetGatewayStat3Fan = cValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetBacnetGatewayStat3Occ                     *)
(* Function:  Set Stat3 Occ                                   *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetBacnetGatewayStat3Occ(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSBacnetGatewayStat3Occ <> slValue || bInit = FALSE)
    RMSChangeNumberParam(vdvHVAC01,'Stat3 Occ',RMS_PARAM_SET,slValue)
  slRMSBacnetGatewayStat3Occ = slValue
  bInit = TRUE
}


(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                 MODULE CODE GOES BELOW                  *)
(***********************************************************)

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

    // Bacnet Gateway
    RMSSetDeviceInfo(vdvHVAC01,'Bacnet Gateway','FieldServer','FSB-3510')
    RMSSetCommunicationTimeout(vdvHVAC01,300)
  }
}

(*******************************************)
(* DATA: Touch Panel                       *)
(*******************************************)
DATA_EVENT [dvTP1a]
{
  ONLINE:
    RMSNetLinxDeviceOnline(dvTP1a,'Touch Panel')
  OFFLINE:
    RMSNetLinxDeviceOffline(dvTP1a)
}

(*******************************************)
(* DATA: Bacnet Gateway                    *)
(*******************************************)
DATA_EVENT [vdvHVAC01]
{
  ONLINE:
  {
    RMSRegisterDevice(vdvHVAC01,'Bacnet Gateway','FieldServer','FSB-3510')
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Room Setpoint',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat1RoomSetpoint,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Heat Setpoint Occupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat1HeatSetpointOccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Cool Setpoint Occupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat1CoolSetpointOccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Heat Setpoint Unoccupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat1HeatSetpointUnoccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Cool Setpoint Unoccupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat1CoolSetpointUnoccupied,55,99)
    RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat1 Mode',
        '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,'',
        RMS_PARAM_SET,acRMSBacnetGatewayStat1Mode,
        'OFF|AUTO|COOL|HEAT')
    RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat1 Fan',
        '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,'',
        RMS_PARAM_SET,acRMSBacnetGatewayStat1Fan,
        'OFF|LOW|MED|HIGH')
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat1 Occ',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat1Occ,0,1)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Room Setpoint',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat2RoomSetpoint,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Heat Setpoint Occupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat2HeatSetpointOccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Cool Setpoint Occupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat2CoolSetpointOccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Heat Setpoint Unoccupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat2HeatSetpointUnoccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Cool Setpoint Unoccupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat2CoolSetpointUnoccupied,55,99)
    RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat2 Mode',
        '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,'',
        RMS_PARAM_SET,acRMSBacnetGatewayStat2Mode,
        'OFF|AUTO|COOL|HEAT')
    RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat2 Fan',
        '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,'',
        RMS_PARAM_SET,acRMSBacnetGatewayStat2Fan,
        'OFF|LOW|MED|HIGH')
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat2 Occ',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat2Occ,0,1)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Room Setpoint',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat3RoomSetpoint,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Heat Setpoint Occupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat3HeatSetpointOccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Cool Setpoint Occupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat3CoolSetpointOccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Heat Setpoint Unoccupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat3HeatSetpointUnoccupied,55,99)
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Cool Setpoint Unoccupied',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat3CoolSetpointUnoccupied,55,99)
    RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat3 Mode',
        '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,'',
        RMS_PARAM_SET,acRMSBacnetGatewayStat3Mode,
        'OFF|AUTO|COOL|HEAT')
    RMSRegisterDeviceEnumParam(vdvHVAC01,'Stat3 Fan',
        '',RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,'',
        RMS_PARAM_SET,acRMSBacnetGatewayStat3Fan,
        'OFF|LOW|MED|HIGH')
    RMSRegisterDeviceNumberParam(vdvHVAC01,'Stat3 Occ',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSBacnetGatewayStat3Occ,0,1)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(vdvHVAC01)
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
    SEND_COMMAND DATA.DEVICE,'SET ROOM INFO-06_HVAC,Kiosk,AMX'

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
