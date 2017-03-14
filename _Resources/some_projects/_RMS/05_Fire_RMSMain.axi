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

PROGRAM_NAME='05_Fire_RMSMain'

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


// dvINP01
VOLATILE SLONG      slRMSFirePullsFirePull1  // Fire Pull 1

// dvINP01
VOLATILE SLONG      slRMSFirePullsFirePull2  // Fire Pull 2

// dvINP01
VOLATILE SLONG      slRMSFirePullsFirePull3  // Fire Pull 3

// dvINP01
VOLATILE SLONG      slRMSFirePullsFirePull4  // Fire Pull 4

// dvREL01
VOLATILE SLONG      slRMSFireFlashersFireFlasher1  // Fire Flasher 1

// dvREL01
VOLATILE SLONG      slRMSFireFlashersFireFlasher2  // Fire Flasher 2

// dvREL01
VOLATILE SLONG      slRMSFireFlashersFireFlasher3  // Fire Flasher 3

// dvREL01
VOLATILE SLONG      slRMSFireFlashersFireFlasher4  // Fire Flasher 4

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

  RMSRegisterDevice(dvINP01,'Fire Pulls','AMX','NI-700')
  RMSRegisterDeviceNumberParam(dvINP01,'Fire Pull 1',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSFirePullsFirePull1,0,0)
  RMSRegisterDeviceNumberParam(dvINP01,'Fire Pull 2',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSFirePullsFirePull2,0,0)
  RMSRegisterDeviceNumberParam(dvINP01,'Fire Pull 3',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSFirePullsFirePull3,0,0)
  RMSRegisterDeviceNumberParam(dvINP01,'Fire Pull 4',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSFirePullsFirePull4,0,0)

  RMSRegisterDevice(dvREL01,'Fire Flashers','AMX','AXB-REL8')
  RMSRegisterDeviceNumberParam(dvREL01,'Fire Flasher 1',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSFireFlashersFireFlasher1,0,0)
  RMSRegisterDeviceNumberParam(dvREL01,'Fire Flasher 2',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSFireFlashersFireFlasher2,0,0)
  RMSRegisterDeviceNumberParam(dvREL01,'Fire Flasher 3',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSFireFlashersFireFlasher3,0,0)
  RMSRegisterDeviceNumberParam(dvREL01,'Fire Flasher 4',
      0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
      FALSE,0,
      RMS_PARAM_SET,slRMSFireFlashersFireFlasher4,0,0)
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
(* Call Name: RMSSetFirePullsFirePull1                        *)
(* Function:  Set Fire Pull 1                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetFirePullsFirePull1(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSFirePullsFirePull1 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvINP01,'Fire Pull 1',RMS_PARAM_SET,slValue)
  slRMSFirePullsFirePull1 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetFirePullsFirePull2                        *)
(* Function:  Set Fire Pull 2                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetFirePullsFirePull2(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSFirePullsFirePull2 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvINP01,'Fire Pull 2',RMS_PARAM_SET,slValue)
  slRMSFirePullsFirePull2 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetFirePullsFirePull3                        *)
(* Function:  Set Fire Pull 3                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetFirePullsFirePull3(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSFirePullsFirePull3 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvINP01,'Fire Pull 3',RMS_PARAM_SET,slValue)
  slRMSFirePullsFirePull3 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetFirePullsFirePull4                        *)
(* Function:  Set Fire Pull 4                                 *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetFirePullsFirePull4(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSFirePullsFirePull4 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvINP01,'Fire Pull 4',RMS_PARAM_SET,slValue)
  slRMSFirePullsFirePull4 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetFireFlashersFireFlasher1                  *)
(* Function:  Set Fire Flasher 1                              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetFireFlashersFireFlasher1(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSFireFlashersFireFlasher1 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvREL01,'Fire Flasher 1',RMS_PARAM_SET,slValue)
  slRMSFireFlashersFireFlasher1 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetFireFlashersFireFlasher2                  *)
(* Function:  Set Fire Flasher 2                              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetFireFlashersFireFlasher2(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSFireFlashersFireFlasher2 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvREL01,'Fire Flasher 2',RMS_PARAM_SET,slValue)
  slRMSFireFlashersFireFlasher2 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetFireFlashersFireFlasher3                  *)
(* Function:  Set Fire Flasher 3                              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetFireFlashersFireFlasher3(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSFireFlashersFireFlasher3 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvREL01,'Fire Flasher 3',RMS_PARAM_SET,slValue)
  slRMSFireFlashersFireFlasher3 = slValue
  bInit = TRUE
}


(**************************************************************)
(* Call Name: RMSSetFireFlashersFireFlasher4                  *)
(* Function:  Set Fire Flasher 4                              *)
(* Param:     Value                                           *)
(* Return:    None                                            *)
(**************************************************************)
DEFINE_FUNCTION RMSSetFireFlashersFireFlasher4(SLONG slValue)
LOCAL_VAR
CHAR bInit
{
  IF (slRMSFireFlashersFireFlasher4 <> slValue || bInit = FALSE)
    RMSChangeNumberParam(dvREL01,'Fire Flasher 4',RMS_PARAM_SET,slValue)
  slRMSFireFlashersFireFlasher4 = slValue
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

    // Fire Pulls
    RMSSetDeviceInfo(dvINP01,'Fire Pulls','AMX','NI-700')

    // Fire Flashers
    RMSSetDeviceInfo(dvREL01,'Fire Flashers','AMX','AXB-REL8')
  }
}

(*******************************************)
(* DATA: Fire Pulls                        *)
(*******************************************)
DATA_EVENT [dvINP01]
{
  ONLINE:
  {
    RMSRegisterDevice(dvINP01,'Fire Pulls','AMX','NI-700')
    RMSRegisterDeviceNumberParam(dvINP01,'Fire Pull 1',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSFirePullsFirePull1,0,0)
    RMSRegisterDeviceNumberParam(dvINP01,'Fire Pull 2',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSFirePullsFirePull2,0,0)
    RMSRegisterDeviceNumberParam(dvINP01,'Fire Pull 3',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSFirePullsFirePull3,0,0)
    RMSRegisterDeviceNumberParam(dvINP01,'Fire Pull 4',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSFirePullsFirePull4,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvINP01)
}

(*******************************************)
(* DATA: Fire Flashers                     *)
(*******************************************)
DATA_EVENT [dvREL01]
{
  ONLINE:
  {
    RMSRegisterDevice(dvREL01,'Fire Flashers','AMX','AXB-REL8')
    RMSRegisterDeviceNumberParam(dvREL01,'Fire Flasher 1',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSFireFlashersFireFlasher1,0,0)
    RMSRegisterDeviceNumberParam(dvREL01,'Fire Flasher 2',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSFireFlashersFireFlasher2,0,0)
    RMSRegisterDeviceNumberParam(dvREL01,'Fire Flasher 3',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSFireFlashersFireFlasher3,0,0)
    RMSRegisterDeviceNumberParam(dvREL01,'Fire Flasher 4',
        0,RMS_COMP_NONE,RMS_STAT_NOT_ASSIGNED,
        FALSE,0,
        RMS_PARAM_SET,slRMSFireFlashersFireFlasher4,0,0)
  }
  OFFLINE:
    RMSNetLinxDeviceOffline(dvREL01)
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
(* CHANNEL: dvINP01                        *)
(*******************************************)
CHANNEL_EVENT [dvINP01,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetFirePullsFirePull1(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetFirePullsFirePull1(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvINP01                        *)
(*******************************************)
CHANNEL_EVENT [dvINP01,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 2:
        RMSSetFirePullsFirePull2(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 2:
        RMSSetFirePullsFirePull2(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvINP01                        *)
(*******************************************)
CHANNEL_EVENT [dvINP01,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 3:
        RMSSetFirePullsFirePull3(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 3:
        RMSSetFirePullsFirePull3(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvINP01                        *)
(*******************************************)
CHANNEL_EVENT [dvINP01,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 4:
        RMSSetFirePullsFirePull4(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 4:
        RMSSetFirePullsFirePull4(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvREL01                        *)
(*******************************************)
CHANNEL_EVENT [dvREL01,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetFireFlashersFireFlasher1(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 1:
        RMSSetFireFlashersFireFlasher1(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvREL01                        *)
(*******************************************)
CHANNEL_EVENT [dvREL01,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 2:
        RMSSetFireFlashersFireFlasher2(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 2:
        RMSSetFireFlashersFireFlasher2(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvREL01                        *)
(*******************************************)
CHANNEL_EVENT [dvREL01,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 3:
        RMSSetFireFlashersFireFlasher3(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 3:
        RMSSetFireFlashersFireFlasher3(0)
        break

    }
  }
}

(*******************************************)
(* CHANNEL: dvREL01                        *)
(*******************************************)
CHANNEL_EVENT [dvREL01,0]
{
  // Channel On
  ON:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 4:
        RMSSetFireFlashersFireFlasher4(1)
        break

    }
  }

  // Channel Off
  OFF:
  {
    SWITCH (CHANNEL.CHANNEL)
    {
      CASE 4:
        RMSSetFireFlashersFireFlasher4(0)
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
    SEND_COMMAND DATA.DEVICE,'SET ROOM INFO-05_Fire,Kiosk,AMX'

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
