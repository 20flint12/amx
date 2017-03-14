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

PROGRAM_NAME='04_AVControl_RMSMain'

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


// dvShiner1
VOLATILE SLONG      slRMSPowerModule1PowerSense  // Power Sense

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1Relay  // Relay

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1Power  // Power

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1Current  // Current

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1PowerFactor  // Power Factor

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1Energy  // Energy

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2PowerSense  // Power Sense

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2Relay  // Relay

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2Power  // Power

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2Current  // Current

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2PowerFactor  // Power Factor

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2Energy  // Energy

// dvShiner3
VOLATILE SLONG      slRMSPowerModule3PowerSense  // Power Sense

// dvShiner3
VOLATILE SLONG      slRMSPowerModule3Relay  // Relay

// dvShiner3
VOLATILE SLONG      slRMSPowerModule3Power  // Power

// dvShiner3
VOLATILE SLONG      slRMSPowerModule3Current  // Current

// dvShiner3
VOLATILE SLONG      slRMSPowerModule3PowerFactor  // Power Factor

// dvShiner3
VOLATILE SLONG      slRMSPowerModule3Energy  // Energy

// dvShiner4
VOLATILE SLONG      slRMSPowerModule4PowerSense  // Power Sense

// dvShiner4
VOLATILE SLONG      slRMSPowerModule4Relay  // Relay

// dvShiner4
VOLATILE SLONG      slRMSPowerModule4Power  // Power

// dvShiner4
VOLATILE SLONG      slRMSPowerModule4Current  // Current

// dvShiner4
VOLATILE SLONG      slRMSPowerModule4PowerFactor  // Power Factor

// dvShiner4
VOLATILE SLONG      slRMSPowerModule4Energy  // Energy

// dvShiner5
VOLATILE SLONG      slRMSPowerModule5PowerSense  // Power Sense

// dvShiner5
VOLATILE SLONG      slRMSPowerModule5Relay  // Relay

// dvShiner5
VOLATILE SLONG      slRMSPowerModule5Power  // Power

// dvShiner5
VOLATILE SLONG      slRMSPowerModule5Current  // Current

// dvShiner5
VOLATILE SLONG      slRMSPowerModule5PowerFactor  // Power Factor

// dvShiner5
VOLATILE SLONG      slRMSPowerModule5Energy  // Energy

// dvShiner6
VOLATILE SLONG      slRMSPowerModule6PowerSense  // Power Sense

// dvShiner6
VOLATILE SLONG      slRMSPowerModule6Relay  // Relay

// dvShiner6
VOLATILE SLONG      slRMSPowerModule6Power  // Power

// dvShiner6
VOLATILE SLONG      slRMSPowerModule6Current  // Current

// dvShiner6
VOLATILE SLONG      slRMSPowerModule6PowerFactor  // Power Factor

// dvShiner6
VOLATILE SLONG      slRMSPowerModule6Energy  // Energy

// dvShiner7
VOLATILE SLONG      slRMSPowerModule7PowerSense  // Power Sense

// dvShiner7
VOLATILE SLONG      slRMSPowerModule7Relay  // Relay

// dvShiner7
VOLATILE SLONG      slRMSPowerModule7Power  // Power

// dvShiner7
VOLATILE SLONG      slRMSPowerModule7Current  // Current

// dvShiner7
VOLATILE SLONG      slRMSPowerModule7PowerFactor  // Power Factor

// dvShiner7
VOLATILE SLONG      slRMSPowerModule7Energy  // Energy

// dvShiner8
VOLATILE SLONG      slRMSPowerModule8PowerSense  // Power Sense

// dvShiner8
VOLATILE SLONG      slRMSPowerModule8Relay  // Relay

// dvShiner8
VOLATILE SLONG      slRMSPowerModule8Power  // Power

// dvShiner8
VOLATILE SLONG      slRMSPowerModule8Current  // Current

// dvShiner8
VOLATILE SLONG      slRMSPowerModule8PowerFactor  // Power Factor

// dvShiner8
VOLATILE SLONG      slRMSPowerModule8Energy  // Energy

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1InputVoltage  // Input Voltage

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2AxlinkVoltage  // Axlink Voltage

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1AxlinkPower  // Axlink Power

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1AxlinkCurrent  // Axlink Current

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2AxlinkPower  // Axlink Power

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2AxlinkCurrent  // Axlink Current

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1AxlinkOnOff  // Axlink OnOff

// dvShiner2
VOLATILE SLONG      slRMSPowerModule2AxlinkOnOff  // Axlink OnOff

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1Temperature  // Temperature

// dvShiner1
VOLATILE SLONG      slRMSPowerModule1ScaleCorF  // Scale C or F

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
  RMSNetLinxDeviceOnline(dvTP1a,'Destiny')

  RMSRegisterDevice(dvDVD1,'DVD','Unknown','Unknown')

  RMSRegisterDevice(dvDVX1,'AV Switcher','AMX','DVX-2100')

  RMSRegisterDevice(dvShiner1,'Power Module 1','AMX','NXA-PDU-1508-8')
  RMSRegisterDeviceNumberParam(dvShiner1,'Power Sense',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1PowerSense,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Relay',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1Relay,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1Power,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1Current,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Power Factor',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1PowerFactor,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Energy',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1Energy,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Input Voltage',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1InputVoltage,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Axlink Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1AxlinkPower,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Axlink Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1AxlinkCurrent,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Axlink OnOff',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1AxlinkOnOff,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Temperature',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1Temperature,0,0)
  RMSRegisterDeviceNumberParam(dvShiner1,'Scale C or F',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule1ScaleCorF,0,0)

  RMSRegisterDevice(dvShiner2,'Power Module 2','AMX','NXA-PDU-1508-8')
  RMSRegisterDeviceNumberParam(dvShiner2,'Power Sense',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2PowerSense,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Relay',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2Relay,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2Power,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2Current,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Power Factor',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2PowerFactor,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Energy',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2Energy,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Axlink Voltage',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2AxlinkVoltage,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Axlink Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2AxlinkPower,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Axlink Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2AxlinkCurrent,0,0)
  RMSRegisterDeviceNumberParam(dvShiner2,'Axlink OnOff',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule2AxlinkOnOff,0,0)

  RMSRegisterDevice(dvShiner3,'Power Module 3','AMX','NXA-PDU-1508-8')
  RMSRegisterDeviceNumberParam(dvShiner3,'Power Sense',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule3PowerSense,0,0)
  RMSRegisterDeviceNumberParam(dvShiner3,'Relay',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule3Relay,0,0)
  RMSRegisterDeviceNumberParam(dvShiner3,'Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule3Power,0,0)
  RMSRegisterDeviceNumberParam(dvShiner3,'Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule3Current,0,0)
  RMSRegisterDeviceNumberParam(dvShiner3,'Power Factor',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule3PowerFactor,0,0)
  RMSRegisterDeviceNumberParam(dvShiner3,'Energy',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule3Energy,0,0)

  RMSRegisterDevice(dvShiner4,'Power Module 4','AMX','NXA-PDU-1508-8')
  RMSRegisterDeviceNumberParam(dvShiner4,'Power Sense',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule4PowerSense,0,0)
  RMSRegisterDeviceNumberParam(dvShiner4,'Relay',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule4Relay,0,0)
  RMSRegisterDeviceNumberParam(dvShiner4,'Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule4Power,0,0)
  RMSRegisterDeviceNumberParam(dvShiner4,'Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule4Current,0,0)
  RMSRegisterDeviceNumberParam(dvShiner4,'Power Factor',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule4PowerFactor,0,0)
  RMSRegisterDeviceNumberParam(dvShiner4,'Energy',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule4Energy,0,0)

  RMSRegisterDevice(dvShiner5,'Power Module 5','AMX','NXA-PDU-1508-8')
  RMSRegisterDeviceNumberParam(dvShiner5,'Power Sense',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule5PowerSense,0,0)
  RMSRegisterDeviceNumberParam(dvShiner5,'Relay',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule5Relay,0,0)
  RMSRegisterDeviceNumberParam(dvShiner5,'Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule5Power,0,0)
  RMSRegisterDeviceNumberParam(dvShiner5,'Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule5Current,0,0)
  RMSRegisterDeviceNumberParam(dvShiner5,'Power Factor',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule5PowerFactor,0,0)
  RMSRegisterDeviceNumberParam(dvShiner5,'Energy',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule5Energy,0,0)

  RMSRegisterDevice(dvShiner6,'Power Module 6','AMX','NXA-PDU-1508-8')
  RMSRegisterDeviceNumberParam(dvShiner6,'Power Sense',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule6PowerSense,0,0)
  RMSRegisterDeviceNumberParam(dvShiner6,'Relay',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule6Relay,0,0)
  RMSRegisterDeviceNumberParam(dvShiner6,'Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule6Power,0,0)
  RMSRegisterDeviceNumberParam(dvShiner6,'Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule6Current,0,0)
  RMSRegisterDeviceNumberParam(dvShiner6,'Power Factor',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule6PowerFactor,0,0)
  RMSRegisterDeviceNumberParam(dvShiner6,'Energy',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule6Energy,0,0)

  RMSRegisterDevice(dvShiner7,'Power Module 7','AMX','NXA-PDU-1508-8')
  RMSRegisterDeviceNumberParam(dvShiner7,'Power Sense',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule7PowerSense,0,0)
  RMSRegisterDeviceNumberParam(dvShiner7,'Relay',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule7Relay,0,0)
  RMSRegisterDeviceNumberParam(dvShiner7,'Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule7Power,0,0)
  RMSRegisterDeviceNumberParam(dvShiner7,'Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule7Current,0,0)
  RMSRegisterDeviceNumberParam(dvShiner7,'Power Factor',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule7PowerFactor,0,0)
  RMSRegisterDeviceNumberParam(dvShiner7,'Energy',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule7Energy,0,0)

  RMSRegisterDevice(dvShiner8,'Power Module 8','AMX','NXA-PDU-1508-8')
  RMSRegisterDeviceNumberParam(dvShiner8,'Power Sense',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule8PowerSense,0,0)
  RMSRegisterDeviceNumberParam(dvShiner8,'Relay',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule8Relay,0,0)
  RMSRegisterDeviceNumberParam(dvShiner8,'Power',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule8Power,0,0)
  RMSRegisterDeviceNumberParam(dvShiner8,'Current',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule8Current,0,0)
  RMSRegisterDeviceNumberParam(dvShiner8,'Power Factor',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule8PowerFactor,0,0)
  RMSRegisterDeviceNumberParam(dvShiner8,'Energy',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSPowerModule8Energy,0,0)
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
(* Call Name: RMSSetPowerModule1PowerSense                    *)
(* Function:  Set Power Sense                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1PowerSense(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1PowerSense <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Power Sense',RMS_PARAM_SET,slValue)
  slRMSPowerModule1PowerSense = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1Relay                         *)
(* Function:  Set Relay                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1Relay(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1Relay <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Relay',RMS_PARAM_SET,slValue)
  slRMSPowerModule1Relay = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1Power                         *)
(* Function:  Set Power                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1Power(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1Power <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule1Power = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1Current                       *)
(* Function:  Set Current                                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1Current(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1Current <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule1Current = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1PowerFactor                   *)
(* Function:  Set Power Factor                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1PowerFactor(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1PowerFactor <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Power Factor',RMS_PARAM_SET,slValue)
  slRMSPowerModule1PowerFactor = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1Energy                        *)
(* Function:  Set Energy                                      *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1Energy(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1Energy <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Energy',RMS_PARAM_SET,slValue)
  slRMSPowerModule1Energy = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2PowerSense                    *)
(* Function:  Set Power Sense                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2PowerSense(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2PowerSense <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Power Sense',RMS_PARAM_SET,slValue)
  slRMSPowerModule2PowerSense = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2Relay                         *)
(* Function:  Set Relay                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2Relay(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2Relay <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Relay',RMS_PARAM_SET,slValue)
  slRMSPowerModule2Relay = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2Power                         *)
(* Function:  Set Power                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2Power(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2Power <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule2Power = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2Current                       *)
(* Function:  Set Current                                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2Current(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2Current <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule2Current = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2PowerFactor                   *)
(* Function:  Set Power Factor                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2PowerFactor(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2PowerFactor <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Power Factor',RMS_PARAM_SET,slValue)
  slRMSPowerModule2PowerFactor = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2Energy                        *)
(* Function:  Set Energy                                      *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2Energy(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2Energy <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Energy',RMS_PARAM_SET,slValue)
  slRMSPowerModule2Energy = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule3PowerSense                    *)
(* Function:  Set Power Sense                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule3PowerSense(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule3PowerSense <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner3,'Power Sense',RMS_PARAM_SET,slValue)
  slRMSPowerModule3PowerSense = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule3Relay                         *)
(* Function:  Set Relay                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule3Relay(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule3Relay <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner3,'Relay',RMS_PARAM_SET,slValue)
  slRMSPowerModule3Relay = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule3Power                         *)
(* Function:  Set Power                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule3Power(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule3Power <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner3,'Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule3Power = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule3Current                       *)
(* Function:  Set Current                                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule3Current(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule3Current <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner3,'Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule3Current = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule3PowerFactor                   *)
(* Function:  Set Power Factor                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule3PowerFactor(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule3PowerFactor <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner3,'Power Factor',RMS_PARAM_SET,slValue)
  slRMSPowerModule3PowerFactor = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule3Energy                        *)
(* Function:  Set Energy                                      *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule3Energy(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule3Energy <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner3,'Energy',RMS_PARAM_SET,slValue)
  slRMSPowerModule3Energy = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule4PowerSense                    *)
(* Function:  Set Power Sense                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule4PowerSense(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule4PowerSense <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner4,'Power Sense',RMS_PARAM_SET,slValue)
  slRMSPowerModule4PowerSense = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule4Relay                         *)
(* Function:  Set Relay                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule4Relay(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule4Relay <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner4,'Relay',RMS_PARAM_SET,slValue)
  slRMSPowerModule4Relay = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule4Power                         *)
(* Function:  Set Power                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule4Power(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule4Power <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner4,'Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule4Power = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule4Current                       *)
(* Function:  Set Current                                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule4Current(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule4Current <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner4,'Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule4Current = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule4PowerFactor                   *)
(* Function:  Set Power Factor                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule4PowerFactor(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule4PowerFactor <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner4,'Power Factor',RMS_PARAM_SET,slValue)
  slRMSPowerModule4PowerFactor = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule4Energy                        *)
(* Function:  Set Energy                                      *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule4Energy(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule4Energy <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner4,'Energy',RMS_PARAM_SET,slValue)
  slRMSPowerModule4Energy = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule5PowerSense                    *)
(* Function:  Set Power Sense                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule5PowerSense(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule5PowerSense <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner5,'Power Sense',RMS_PARAM_SET,slValue)
  slRMSPowerModule5PowerSense = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule5Relay                         *)
(* Function:  Set Relay                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule5Relay(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule5Relay <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner5,'Relay',RMS_PARAM_SET,slValue)
  slRMSPowerModule5Relay = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule5Power                         *)
(* Function:  Set Power                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule5Power(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule5Power <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner5,'Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule5Power = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule5Current                       *)
(* Function:  Set Current                                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule5Current(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule5Current <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner5,'Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule5Current = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule5PowerFactor                   *)
(* Function:  Set Power Factor                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule5PowerFactor(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule5PowerFactor <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner5,'Power Factor',RMS_PARAM_SET,slValue)
  slRMSPowerModule5PowerFactor = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule5Energy                        *)
(* Function:  Set Energy                                      *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule5Energy(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule5Energy <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner5,'Energy',RMS_PARAM_SET,slValue)
  slRMSPowerModule5Energy = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule6PowerSense                    *)
(* Function:  Set Power Sense                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule6PowerSense(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule6PowerSense <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner6,'Power Sense',RMS_PARAM_SET,slValue)
  slRMSPowerModule6PowerSense = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule6Relay                         *)
(* Function:  Set Relay                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule6Relay(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule6Relay <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner6,'Relay',RMS_PARAM_SET,slValue)
  slRMSPowerModule6Relay = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule6Power                         *)
(* Function:  Set Power                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule6Power(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule6Power <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner6,'Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule6Power = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule6Current                       *)
(* Function:  Set Current                                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule6Current(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule6Current <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner6,'Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule6Current = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule6PowerFactor                   *)
(* Function:  Set Power Factor                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule6PowerFactor(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule6PowerFactor <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner6,'Power Factor',RMS_PARAM_SET,slValue)
  slRMSPowerModule6PowerFactor = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule6Energy                        *)
(* Function:  Set Energy                                      *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule6Energy(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule6Energy <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner6,'Energy',RMS_PARAM_SET,slValue)
  slRMSPowerModule6Energy = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule7PowerSense                    *)
(* Function:  Set Power Sense                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule7PowerSense(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule7PowerSense <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner7,'Power Sense',RMS_PARAM_SET,slValue)
  slRMSPowerModule7PowerSense = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule7Relay                         *)
(* Function:  Set Relay                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule7Relay(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule7Relay <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner7,'Relay',RMS_PARAM_SET,slValue)
  slRMSPowerModule7Relay = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule7Power                         *)
(* Function:  Set Power                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule7Power(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule7Power <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner7,'Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule7Power = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule7Current                       *)
(* Function:  Set Current                                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule7Current(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule7Current <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner7,'Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule7Current = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule7PowerFactor                   *)
(* Function:  Set Power Factor                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule7PowerFactor(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule7PowerFactor <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner7,'Power Factor',RMS_PARAM_SET,slValue)
  slRMSPowerModule7PowerFactor = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule7Energy                        *)
(* Function:  Set Energy                                      *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule7Energy(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule7Energy <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner7,'Energy',RMS_PARAM_SET,slValue)
  slRMSPowerModule7Energy = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule8PowerSense                    *)
(* Function:  Set Power Sense                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule8PowerSense(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule8PowerSense <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner8,'Power Sense',RMS_PARAM_SET,slValue)
  slRMSPowerModule8PowerSense = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule8Relay                         *)
(* Function:  Set Relay                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule8Relay(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule8Relay <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner8,'Relay',RMS_PARAM_SET,slValue)
  slRMSPowerModule8Relay = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule8Power                         *)
(* Function:  Set Power                                       *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule8Power(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule8Power <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner8,'Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule8Power = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule8Current                       *)
(* Function:  Set Current                                     *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule8Current(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule8Current <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner8,'Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule8Current = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule8PowerFactor                   *)
(* Function:  Set Power Factor                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule8PowerFactor(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule8PowerFactor <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner8,'Power Factor',RMS_PARAM_SET,slValue)
  slRMSPowerModule8PowerFactor = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule8Energy                        *)
(* Function:  Set Energy                                      *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule8Energy(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule8Energy <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner8,'Energy',RMS_PARAM_SET,slValue)
  slRMSPowerModule8Energy = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1InputVoltage                  *)
(* Function:  Set Input Voltage                               *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1InputVoltage(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1InputVoltage <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Input Voltage',RMS_PARAM_SET,slValue)
  slRMSPowerModule1InputVoltage = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2AxlinkVoltage                 *)
(* Function:  Set Axlink Voltage                              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2AxlinkVoltage(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2AxlinkVoltage <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Axlink Voltage',RMS_PARAM_SET,slValue)
  slRMSPowerModule2AxlinkVoltage = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1AxlinkPower                   *)
(* Function:  Set Axlink Power                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1AxlinkPower(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1AxlinkPower <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Axlink Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule1AxlinkPower = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1AxlinkCurrent                 *)
(* Function:  Set Axlink Current                              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1AxlinkCurrent(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1AxlinkCurrent <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Axlink Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule1AxlinkCurrent = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2AxlinkPower                   *)
(* Function:  Set Axlink Power                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2AxlinkPower(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2AxlinkPower <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Axlink Power',RMS_PARAM_SET,slValue)
  slRMSPowerModule2AxlinkPower = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2AxlinkCurrent                 *)
(* Function:  Set Axlink Current                              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2AxlinkCurrent(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2AxlinkCurrent <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Axlink Current',RMS_PARAM_SET,slValue)
  slRMSPowerModule2AxlinkCurrent = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1AxlinkOnOff                   *)
(* Function:  Set Axlink OnOff                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1AxlinkOnOff(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1AxlinkOnOff <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Axlink OnOff',RMS_PARAM_SET,slValue)
  slRMSPowerModule1AxlinkOnOff = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule2AxlinkOnOff                   *)
(* Function:  Set Axlink OnOff                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule2AxlinkOnOff(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule2AxlinkOnOff <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner2,'Axlink OnOff',RMS_PARAM_SET,slValue)
  slRMSPowerModule2AxlinkOnOff = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1Temperature                   *)
(* Function:  Set Temperature                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1Temperature(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1Temperature <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Temperature',RMS_PARAM_SET,slValue)
  slRMSPowerModule1Temperature = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetPowerModule1ScaleCorF                     *)
(* Function:  Set Scale C or F                                *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetPowerModule1ScaleCorF(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSPowerModule1ScaleCorF <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvShiner1,'Scale C or F',RMS_PARAM_SET,slValue)
  slRMSPowerModule1ScaleCorF = slValue
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

    // DVD
    RMSSetDeviceInfo(dvDVD1,'DVD','Unknown','Unknown')

    // AV Switcher
    RMSSetDeviceInfo(dvDVX1,'AV Switcher','AMX','DVX-2100')

    // Power Module 1
    RMSSetDeviceInfo(dvShiner1,'Power Module 1','AMX','NXA-PDU-1508-8')

    // Power Module 2
    RMSSetDeviceInfo(dvShiner2,'Power Module 2','AMX','NXA-PDU-1508-8')

    // Power Module 3
    RMSSetDeviceInfo(dvShiner3,'Power Module 3','AMX','NXA-PDU-1508-8')

    // Power Module 4
    RMSSetDeviceInfo(dvShiner4,'Power Module 4','AMX','NXA-PDU-1508-8')

    // Power Module 5
    RMSSetDeviceInfo(dvShiner5,'Power Module 5','AMX','NXA-PDU-1508-8')

    // Power Module 6
    RMSSetDeviceInfo(dvShiner6,'Power Module 6','AMX','NXA-PDU-1508-8')

    // Power Module 7
    RMSSetDeviceInfo(dvShiner7,'Power Module 7','AMX','NXA-PDU-1508-8')

    // Power Module 8
    RMSSetDeviceInfo(dvShiner8,'Power Module 8','AMX','NXA-PDU-1508-8')
  }
}

(*******************************************)
(* DATA: Destiny                           *)
(*******************************************)
DATA_EVENT [dvTP1a]
{
  ONLINE:
    RMSNetLinxDeviceOnline(dvTP1a,'Destiny')
  OFFLINE:
    RMSNetLinxDeviceOffline(dvTP1a)
}

(*******************************************)
(* DATA: DVD                               *)
(*******************************************)
DATA_EVENT [dvDVD1]
{
  ONLINE:
  {
    RMSRegisterDevice(dvDVD1,'DVD','Unknown','Unknown')
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvDVD1)
}

(*******************************************)
(* DATA: AV Switcher                       *)
(*******************************************)
DATA_EVENT [dvDVX1]
{
  ONLINE:
  {
    RMSRegisterDevice(dvDVX1,'AV Switcher','AMX','DVX-2100')
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvDVX1)
}

(*******************************************)
(* DATA: Power Module 1                    *)
(*******************************************)
DATA_EVENT [dvShiner1]
{
  ONLINE:
  {
    RMSRegisterDevice(dvShiner1,'Power Module 1','AMX','NXA-PDU-1508-8')
    RMSRegisterDeviceNumberParam(dvShiner1,'Power Sense',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1PowerSense,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Relay',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1Relay,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1Power,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1Current,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Power Factor',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1PowerFactor,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Energy',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1Energy,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Input Voltage',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1InputVoltage,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Axlink Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1AxlinkPower,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Axlink Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1AxlinkCurrent,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Axlink OnOff',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1AxlinkOnOff,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Temperature',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1Temperature,0,0)
    RMSRegisterDeviceNumberParam(dvShiner1,'Scale C or F',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule1ScaleCorF,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvShiner1)
}

(*******************************************)
(* DATA: Power Module 2                    *)
(*******************************************)
DATA_EVENT [dvShiner2]
{
  ONLINE:
  {
    RMSRegisterDevice(dvShiner2,'Power Module 2','AMX','NXA-PDU-1508-8')
    RMSRegisterDeviceNumberParam(dvShiner2,'Power Sense',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2PowerSense,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Relay',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2Relay,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2Power,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2Current,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Power Factor',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2PowerFactor,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Energy',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2Energy,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Axlink Voltage',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2AxlinkVoltage,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Axlink Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2AxlinkPower,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Axlink Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2AxlinkCurrent,0,0)
    RMSRegisterDeviceNumberParam(dvShiner2,'Axlink OnOff',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule2AxlinkOnOff,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvShiner2)
}

(*******************************************)
(* DATA: Power Module 3                    *)
(*******************************************)
DATA_EVENT [dvShiner3]
{
  ONLINE:
  {
    RMSRegisterDevice(dvShiner3,'Power Module 3','AMX','NXA-PDU-1508-8')
    RMSRegisterDeviceNumberParam(dvShiner3,'Power Sense',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule3PowerSense,0,0)
    RMSRegisterDeviceNumberParam(dvShiner3,'Relay',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule3Relay,0,0)
    RMSRegisterDeviceNumberParam(dvShiner3,'Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule3Power,0,0)
    RMSRegisterDeviceNumberParam(dvShiner3,'Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule3Current,0,0)
    RMSRegisterDeviceNumberParam(dvShiner3,'Power Factor',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule3PowerFactor,0,0)
    RMSRegisterDeviceNumberParam(dvShiner3,'Energy',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule3Energy,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvShiner3)
}

(*******************************************)
(* DATA: Power Module 4                    *)
(*******************************************)
DATA_EVENT [dvShiner4]
{
  ONLINE:
  {
    RMSRegisterDevice(dvShiner4,'Power Module 4','AMX','NXA-PDU-1508-8')
    RMSRegisterDeviceNumberParam(dvShiner4,'Power Sense',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule4PowerSense,0,0)
    RMSRegisterDeviceNumberParam(dvShiner4,'Relay',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule4Relay,0,0)
    RMSRegisterDeviceNumberParam(dvShiner4,'Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule4Power,0,0)
    RMSRegisterDeviceNumberParam(dvShiner4,'Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule4Current,0,0)
    RMSRegisterDeviceNumberParam(dvShiner4,'Power Factor',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule4PowerFactor,0,0)
    RMSRegisterDeviceNumberParam(dvShiner4,'Energy',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule4Energy,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvShiner4)
}

(*******************************************)
(* DATA: Power Module 5                    *)
(*******************************************)
DATA_EVENT [dvShiner5]
{
  ONLINE:
  {
    RMSRegisterDevice(dvShiner5,'Power Module 5','AMX','NXA-PDU-1508-8')
    RMSRegisterDeviceNumberParam(dvShiner5,'Power Sense',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule5PowerSense,0,0)
    RMSRegisterDeviceNumberParam(dvShiner5,'Relay',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule5Relay,0,0)
    RMSRegisterDeviceNumberParam(dvShiner5,'Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule5Power,0,0)
    RMSRegisterDeviceNumberParam(dvShiner5,'Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule5Current,0,0)
    RMSRegisterDeviceNumberParam(dvShiner5,'Power Factor',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule5PowerFactor,0,0)
    RMSRegisterDeviceNumberParam(dvShiner5,'Energy',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule5Energy,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvShiner5)
}

(*******************************************)
(* DATA: Power Module 6                    *)
(*******************************************)
DATA_EVENT [dvShiner6]
{
  ONLINE:
  {
    RMSRegisterDevice(dvShiner6,'Power Module 6','AMX','NXA-PDU-1508-8')
    RMSRegisterDeviceNumberParam(dvShiner6,'Power Sense',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule6PowerSense,0,0)
    RMSRegisterDeviceNumberParam(dvShiner6,'Relay',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule6Relay,0,0)
    RMSRegisterDeviceNumberParam(dvShiner6,'Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule6Power,0,0)
    RMSRegisterDeviceNumberParam(dvShiner6,'Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule6Current,0,0)
    RMSRegisterDeviceNumberParam(dvShiner6,'Power Factor',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule6PowerFactor,0,0)
    RMSRegisterDeviceNumberParam(dvShiner6,'Energy',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule6Energy,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvShiner6)
}

(*******************************************)
(* DATA: Power Module 7                    *)
(*******************************************)
DATA_EVENT [dvShiner7]
{
  ONLINE:
  {
    RMSRegisterDevice(dvShiner7,'Power Module 7','AMX','NXA-PDU-1508-8')
    RMSRegisterDeviceNumberParam(dvShiner7,'Power Sense',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule7PowerSense,0,0)
    RMSRegisterDeviceNumberParam(dvShiner7,'Relay',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule7Relay,0,0)
    RMSRegisterDeviceNumberParam(dvShiner7,'Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule7Power,0,0)
    RMSRegisterDeviceNumberParam(dvShiner7,'Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule7Current,0,0)
    RMSRegisterDeviceNumberParam(dvShiner7,'Power Factor',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule7PowerFactor,0,0)
    RMSRegisterDeviceNumberParam(dvShiner7,'Energy',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule7Energy,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvShiner7)
}

(*******************************************)
(* DATA: Power Module 8                    *)
(*******************************************)
DATA_EVENT [dvShiner8]
{
  ONLINE:
  {
    RMSRegisterDevice(dvShiner8,'Power Module 8','AMX','NXA-PDU-1508-8')
    RMSRegisterDeviceNumberParam(dvShiner8,'Power Sense',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule8PowerSense,0,0)
    RMSRegisterDeviceNumberParam(dvShiner8,'Relay',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule8Relay,0,0)
    RMSRegisterDeviceNumberParam(dvShiner8,'Power',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule8Power,0,0)
    RMSRegisterDeviceNumberParam(dvShiner8,'Current',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule8Current,0,0)
    RMSRegisterDeviceNumberParam(dvShiner8,'Power Factor',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule8PowerFactor,0,0)
    RMSRegisterDeviceNumberParam(dvShiner8,'Energy',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSPowerModule8Energy,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvShiner8)
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
(* CHANNEL: dvShiner1                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner1,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule1PowerSense(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule1PowerSense(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner1                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner1,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule1Relay(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule1Relay(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner1                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner1,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 3:
        RMSSetPowerModule1AxlinkOnOff(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 3:
        RMSSetPowerModule1AxlinkOnOff(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner1                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner1,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 2:
        RMSSetPowerModule1ScaleCorF(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 2:
        RMSSetPowerModule1ScaleCorF(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner2                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner2,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule2PowerSense(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule2PowerSense(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner2                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner2,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule2Relay(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule2Relay(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner2                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner2,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 3:
        RMSSetPowerModule2AxlinkOnOff(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 3:
        RMSSetPowerModule2AxlinkOnOff(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner3                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner3,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule3PowerSense(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule3PowerSense(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner3                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner3,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule3Relay(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule3Relay(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner4                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner4,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule4PowerSense(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule4PowerSense(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner4                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner4,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule4Relay(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule4Relay(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner5                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner5,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule5PowerSense(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule5PowerSense(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner5                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner5,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule5Relay(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule5Relay(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner6                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner6,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule6PowerSense(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule6PowerSense(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner6                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner6,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule6Relay(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule6Relay(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner7                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner7,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule7PowerSense(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule7PowerSense(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner7                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner7,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule7Relay(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule7Relay(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner8                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner8,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule8PowerSense(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 255:
        RMSSetPowerModule8PowerSense(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvShiner8                      *)
(*******************************************)
CHANNEL_EVENT [dvShiner8,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule8Relay(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetPowerModule8Relay(0)
        break

    }
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
    SEND_COMMAND DATA.DEVICE,'SET ROOM INFO-04_AVControl,Kiosk,AMX'

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
