PROGRAM_NAME='Queue_and_Threshold_Sizes'
(*{{PS_SOURCE_INFO(PROGRAM STATS)                          *)
(***********************************************************)
(*  FILE CREATED ON: 09/12/2003 AT: 14:57:09               *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/01/2007 AT: 09:38:19         *)
(***********************************************************)
(*  ORPHAN_FILE_PLATFORM: 1                                *)
(***********************************************************)
(*  FILE REVISION: Rev 1                 cwl               *)
(*  REVISION DATE: 05/01/2007  AT: 11:28:08                *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*  1) Changed original Queue and Threshold settings to    *)
(*     look for non-duet and duet default firmware prior   *)
(*     to setting values.                                  *)
(*  2) Added functionality to reset values when a new      *)
(*     firmware is loaded.                                 *)
(*                                                         *)
(***********************************************************)
(*}}PS_SOURCE_INFO                                         *)
(***********************************************************)

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT 

INTEGER ciMAX_REBOOTS_FOR_INTERNALS = 2

INTEGER DEFAULT_SETTINGS  = 1
INTEGER ENHANCED_SETTINGS = 2

INTEGER NON_DUET_MASTER_FW_VERSION = 2  //Firmware 2.xx.xxx
INTEGER DUET_MASTER_FW_VERSION     = 3  //Firmware 3.xx.xxx

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER giNeedReboot;
PERSISTENT INTEGER gipRebootCount;

DEV_INFO_STRUCT sDevInfo

INTEGER QUEUE_AND_THRESHOLD_TYPE	//1=DEFAULT_SETTINGS or 2=ENHANCED_SETTINGS
//INTEGER FIRMWARE_VERION		//2=Non-Duet or 3=Duet 

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

DEFINE_FUNCTION INTEGER GET_MASTER_FIRMWARE_VERSION()
{  
  STACK_VAR CHAR    cVer[50]
  STACK_VAR CHAR    cTemp[50]
  STACK_VAR INTEGER nMajor

  // Check master version
  DEVICE_INFO(0:0:0,sDevInfo)
  
  cVer = sDevInfo.VERSION
  cTemp = REMOVE_STRING(cVer,'.',1)
  nMajor = ATOI(cTemp)

  RETURN nMajor;
}

DEFINE_FUNCTION REPORT_INTERNALS()
{
    STACK_VAR LONG lValue;        
    
    send_string 0,"' '"    
    send_string 0,"'------------------------------------------------'"

    (***********************************************************)
    (* If you receive an error that looks like                 *)
    (* ERROR: Symbol [INTERNAL_THRESHOLD_INDEX_INTERPRETER] not defined Line:52 Col:0  *)
    (* check the version of your NetLinx.axi                   *)  
    (***********************************************************)

    lValue = INTERNAL_THRESHOLD_GET(INTERNAL_THRESHOLD_INDEX_INTERPRETER);
    send_string 0,"'  INTERNAL_THRESHOLD_INDEX_INTERPRETER ',itoa(lValue)"    

    lValue = INTERNAL_THRESHOLD_GET(INTERNAL_THRESHOLD_INDEX_LONTALK);
    send_string 0,"'  INTERNAL_THRESHOLD_INDEX_LONTALK ',itoa(lValue)"    

    lValue = INTERNAL_THRESHOLD_GET(INTERNAL_THRESHOLD_INDEX_IP);
    send_string 0,"'  INTERNAL_THRESHOLD_INDEX_IP ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_INTERPRETER);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_INTERPRETER ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_NOTIFICATION_MGR);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_NOTIFICATION_MGR ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_CONNECTION_MGR);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_CONNECTION_MGR ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_ROUTE_MGR);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_ROUTE_MGR ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_DEVICE_MGR);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_DEVICE_MGR ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_DIAGNOSTIC_MGR);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_DIAGNOSTIC_MGR ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_TCP_TX);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_TCP_TX ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_IPCONNECTION_MGR);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_IPCONNECTION_MGR ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_MESSAGE_DISPATCHER);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_MESSAGE_DISPATCHER ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_AXLINK_TX);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_AXLINK_TX ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_PHASTLINK_TX);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_PHASTLINK_TX ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_ICSPLONTALK_TX);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_ICSPLONTALK_TX ',itoa(lValue)"

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_ICSP232_TX);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_ICSP232_TX ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_ICSPIP_TX);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_ICSPIP_TX ',itoa(lValue)"    

    lValue = INTERNAL_QUEUE_SIZE_GET(INTERNAL_QUEUE_SIZE_INDEX_NI_DEVICE);
    send_string 0,"'  INTERNAL_QUEUE_SIZE_INDEX_NI_DEVICE ',itoa(lValue)"    
    
    send_string 0,"'------------------------------------------------'"
    send_string 0,"' '"
}

DEFINE_FUNCTION CHECK_QUEUE_SIZE(LONG QUEUE_INDEX,LONG SET_VALUE, char DESC[])
{
    STACK_VAR LONG lValue 
    
    lValue = INTERNAL_QUEUE_SIZE_GET(QUEUE_INDEX);
    
    //if(SET_VALUE > lValue)	(*cwl-if Queue is less set it too*)
    if(SET_VALUE <> lValue)
    {
        INTERNAL_QUEUE_SIZE_SET(QUEUE_INDEX,SET_VALUE);
        
        if (giNeedReboot == 0)
        {
           send_string 0,"' '"    
           send_string 0,"'------------------------------------------------------------------'"        
        }
        
        send_string 0,"'  Adjust ',DESC,' Queue Size from ',itoa(lValue),' to ',itoa(SET_VALUE)"
        
        giNeedReboot = 1
    }
}

DEFINE_FUNCTION CHECK_THRESHOLD_SIZE(LONG THRESHOLD_INDEX,LONG SET_VALUE, char DESC[])
{
    STACK_VAR LONG lValue 
    
    lValue = (THRESHOLD_INDEX);
    
    if(SET_VALUE > lValue)	(*cwl-lValue will always be 0, 1 or 2??*)
    //if(SET_VALUE <> lValue)
    {
        INTERNAL_THRESHOLD_SET(THRESHOLD_INDEX,SET_VALUE);
        
        if (giNeedReboot == 0)
        {
           send_string 0,"' '"    
           send_string 0,"'------------------------------------------------------------------'"        
        }
        
        send_string 0,"'  Adjust ',DESC,' Threshold from ',itoa(lValue),' to ',itoa(SET_VALUE)"
        
        giNeedReboot = 1
    }    
}

DEFINE_FUNCTION CHECK_INTERNALS()
{        
    STACK_VAR LONG lValue
    STACK_VAR INTEGER DEVICE_IDENTITY
    STACK_VAR INTEGER FIRMWARE_VERION
    
    DEVICE_IDENTITY = DEVICE_ID(0:0:0)
    FIRMWARE_VERION = GET_MASTER_FIRMWARE_VERSION()	//2=Non-Duet or 3=Duet 

    giNeedReboot = 0
    
    IF((DEVICE_IDENTITY == 299) || (DEVICE_IDENTITY == 312))	//NI-x100 || NI-900
    {
	(****Currently there is no Enhanced Duet Settings published... so, Default****)
	
	(*-----------------------------CHECK AND SET THRESHOLDS-----------------------------*)
	// Check and reset Duet Interpreter Threshold to 1500
	CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_INTERPRETER,1500,"'Interpreter'");
	
	// Check and reset Duet Lontalk Threshold to 50
	CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_LONTALK,50,"'Lontalk'");
	
	// Check and reset Duet IP Threshold to 1500
	CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_IP,1500,"'IP'");
	
	(*-----------------------------CHECK AND SET QUEUE SIZES----------------------------*)
	// Check and reset Duet Interpreter Queue Size to 2000   
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_INTERPRETER,2000,"'Interpreter'")
	
	// Check and reset Duet Notification Queue Size to 2000  
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_NOTIFICATION_MGR,2000,"'Notification Manager'");
	
	// Check and reset Duet Connection Manager Queue Size to 2000  
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_CONNECTION_MGR,2000,"'Connection Manager'");    
	
	// Check and reset Duet Route Manager Queue Size to 400
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ROUTE_MGR,400,"'Route Manager'");    
	
	// Check and reset Duet Device Manager Queue Size to 1500
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_DEVICE_MGR,1500,"'Device Manager'");    
	
	// Check and reset Duet Diagnostic Manager Queue Size to 500
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_DIAGNOSTIC_MGR,500,"'Diagnostic Manager'");    
	
	// Check and reset Duet TCP Transmit Threads Queue Size to 600
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_TCP_TX,600,"'TCP Transmit Threads'");    
	
	// Check and reset Duet IP Connection Manager Queue Size to 800
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_IPCONNECTION_MGR,800,"'IP Connection Manager'");    
	
	// Check and reset Duet Message Dispatcher Queue Size to 1000
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_MESSAGE_DISPATCHER,1000,"'Message Dispatcher'");    
	
	// Check and reset Duet Axlink Transmit Queue Size to 800
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_AXLINK_TX,800,"'Axlink Transmit'");    
	
	// Check and reset Duet PhastLink Transmit Queue Size to 500
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_PHASTLINK_TX,500,"'PhastLink Transmit'");    
	
	// Check and reset Duet ICSNet Transmit Queue Size to 500
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSPLONTALK_TX,500,"'ICSNet Transmit'");    
	
	// Check and reset Duet ICSP 232 Transmit Queue Size to 500
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSP232_TX,500,"'ICSP 232 Transmit'");    
	
	// Check and reset Duet UDP Transmit Queue Size to 500
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSPIP_TX,500,"'UDP 232 Transmit'");    
	
	// Check and reset Duet NI Device Manager Queue Size to 500
	CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_NI_DEVICE,500,"'NI Device Manager'");
    }
    ELSE IF((DEVICE_IDENTITY != 299) && (DEVICE_IDENTITY != 312))	//Not NI-x100 or NI-900
    {
	IF(FIRMWARE_VERION == DUET_MASTER_FW_VERSION)	//Duet NI-x000 or NI-700 or ME-260/64
	{
	    (****Currently there is no Enhanced Duet Settings published... so, Default****)
	    
	    (*-----------------------------CHECK AND SET THRESHOLDS-----------------------------*)
	    // Check and reset Duet Interpreter Threshold to 1500
	    CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_INTERPRETER,1500,"'Interpreter'");
	    
	    // Check and reset Duet Lontalk Threshold to 50
	    CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_LONTALK,50,"'Lontalk'");
	    
	    // Check and reset Duet IP Threshold to 1500
	    CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_IP,1500,"'IP'");
	    
	    (*-----------------------------CHECK AND SET QUEUE SIZES----------------------------*)
	    // Check and reset Duet Interpreter Queue Size to 2000   
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_INTERPRETER,2000,"'Interpreter'")
	    
	    // Check and reset Duet Notification Queue Size to 2000  
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_NOTIFICATION_MGR,2000,"'Notification Manager'");
	    
	    // Check and reset Duet Connection Manager Queue Size to 2000  
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_CONNECTION_MGR,2000,"'Connection Manager'");    
	    
	    // Check and reset Duet Route Manager Queue Size to 400
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ROUTE_MGR,400,"'Route Manager'");    
	    
	    // Check and reset Duet Device Manager Queue Size to 1500
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_DEVICE_MGR,1500,"'Device Manager'");    
	    
	    // Check and reset Duet Diagnostic Manager Queue Size to 500
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_DIAGNOSTIC_MGR,500,"'Diagnostic Manager'");    
	    
	    // Check and reset Duet TCP Transmit Threads Queue Size to 600
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_TCP_TX,600,"'TCP Transmit Threads'");    
	    
	    // Check and reset Duet IP Connection Manager Queue Size to 800
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_IPCONNECTION_MGR,800,"'IP Connection Manager'");    
	    
	    // Check and reset Duet Message Dispatcher Queue Size to 1000
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_MESSAGE_DISPATCHER,1000,"'Message Dispatcher'");    
	    
	    // Check and reset Duet Axlink Transmit Queue Size to 800
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_AXLINK_TX,800,"'Axlink Transmit'");    
	    
	    // Check and reset Duet PhastLink Transmit Queue Size to 500
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_PHASTLINK_TX,500,"'PhastLink Transmit'");    
	    
	    // Check and reset Duet ICSNet Transmit Queue Size to 500
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSPLONTALK_TX,500,"'ICSNet Transmit'");    
	    
	    // Check and reset Duet ICSP 232 Transmit Queue Size to 500
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSP232_TX,500,"'ICSP 232 Transmit'");    
	    
	    // Check and reset Duet UDP Transmit Queue Size to 500
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSPIP_TX,500,"'UDP 232 Transmit'");    
	    
	    // Check and reset Duet NI Device Manager Queue Size to 500
	    CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_NI_DEVICE,500,"'NI Device Manager'");
	}
	ELSE IF(FIRMWARE_VERION == NON_DUET_MASTER_FW_VERSION)	//Non-Duet NI-x000 or NI-700 or ME-260/64
	{
	    IF(QUEUE_AND_THRESHOLD_TYPE == ENHANCED_SETTINGS)	//Non-Duet Enhanced
	    {
		(*------------------------CHECK AND SET THRESHOLDS------------------------*)
		// Check and reset Enhanced Non-Duet Interpreter Threshold to 2000
		CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_INTERPRETER,2000,"'Interpreter'");
		
		// Check and reset Enhanced Non-Duet Lontalk Threshold to 50
		CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_LONTALK,50,"'Lontalk'");
		
		// Check and reset Enhanced Non-Duet IP Threshold to 600
		CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_IP,600,"'IP'");
		
		(*------------------------CHECK AND SET QUEUE SIZES-----------------------*)
		// Check and reset Enhanced Non-Duet Interpreter Queue Size to 3000  
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_INTERPRETER,3000,"'Interpreter'")
		
		// Check and reset Enhanced Non-Duet Notification Queue Size to 3000 
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_NOTIFICATION_MGR,3000,"'Notification Manager'");
		
		// Check and reset Enhanced Non-Duet Connection Manager Queue Size to 3000  
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_CONNECTION_MGR,3000,"'Connection Manager'");    
		
		// Check and reset Enhanced Non-Duet Route Manager Queue Size to 200
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ROUTE_MGR,200,"'Route Manager'");    
		
		// Check and reset Enhanced Non-Duet Device Manager Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_DEVICE_MGR,500,"'Device Manager'");    
		
		// Check and reset Enhanced Non-Duet Diagnostic Manager Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_DIAGNOSTIC_MGR,500,"'Diagnostic Manager'");    
		
		// Check and reset Enhanced Non-Duet TCP Transmit Threads Queue Size to 600
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_TCP_TX,600,"'TCP Transmit Threads'");    
		
		// Check and reset Enhanced Non-Duet IP Connection Manager Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_IPCONNECTION_MGR,500,"'IP Connection Manager'");    
		
		// Check and reset Enhanced Non-Duet Message Dispatcher Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_MESSAGE_DISPATCHER,500,"'Message Dispatcher'");    
		
		// Check and reset Enhanced Non-Duet Axlink Transmit Queue Size to 3000
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_AXLINK_TX,3000,"'Axlink Transmit'");    
		
		// Check and reset Enhanced Non-Duet PhastLink Transmit Queue Size to 3000
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_PHASTLINK_TX,3000,"'PhastLink Transmit'");    
		
		// Check and reset Enhanced Non-Duet ICSNet Transmit Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSPLONTALK_TX,500,"'ICSNet Transmit'");    
		
		// Check and reset Enhanced Non-Duet ICSP 232 Transmit Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSP232_TX,500,"'ICSP 232 Transmit'");    
		
		// Check and reset Enhanced Non-Duet UDP Transmit Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSPIP_TX,500,"'UDP 232 Transmit'");    
		
		// Check and reset Enhanced Non-Duet NI Device Manager Queue Size to 0
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_NI_DEVICE,0,"'NI Device Manager'");
	    }
	    ELSE IF(QUEUE_AND_THRESHOLD_TYPE == DEFAULT_SETTINGS)	//Non-Duet Defaults
	    {
		(*------------------------CHECK AND SET THRESHOLDS------------------------*)
		// Check and reset Non-Duet Interpreter Threshold to 10
		CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_INTERPRETER,10,"'Interpreter'");
		
		// Check and reset Non-Duet Lontalk Threshold to 50
		CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_LONTALK,50,"'Lontalk'");
		
		// Check and reset Non-Duet IP Threshold to 200
		CHECK_THRESHOLD_SIZE(INTERNAL_THRESHOLD_INDEX_IP,200,"'IP'");
		
		(*------------------------CHECK AND SET QUEUE SIZES-----------------------*)
		// Check and reset Non-Duet Interpreter Queue Size to 600  
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_INTERPRETER,600,"'Interpreter'")
		
		// Check and reset Non-Duet Notification Queue Size to 200 
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_NOTIFICATION_MGR,200,"'Notification Manager'");
		
		// Check and reset Non-Duet Connection Manager Queue Size to 500  
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_CONNECTION_MGR,500,"'Connection Manager'");    
		
		// Check and reset Non-Duet Route Manager Queue Size to 200
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ROUTE_MGR,200,"'Route Manager'");    
		
		// Check and reset Non-Duet Device Manager Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_DEVICE_MGR,500,"'Device Manager'");    
		
		// Check and reset Non-Duet Diagnostic Manager Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_DIAGNOSTIC_MGR,500,"'Diagnostic Manager'");    
		
		// Check and reset Non-Duet TCP Transmit Threads Queue Size to 200
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_TCP_TX,200,"'TCP Transmit Threads'");    
		
		// Check and reset Non-Duet IP Connection Manager Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_IPCONNECTION_MGR,500,"'IP Connection Manager'");    
		
		// Check and reset Non-Duet Message Dispatcher Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_MESSAGE_DISPATCHER,500,"'Message Dispatcher'");    
		
		// Check and reset Non-Duet Axlink Transmit Queue Size to 200
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_AXLINK_TX,200,"'Axlink Transmit'");    
		
		// Check and reset Non-Duet PhastLink Transmit Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_PHASTLINK_TX,500,"'PhastLink Transmit'");    
		
		// Check and reset Non-Duet ICSNet Transmit Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSPLONTALK_TX,500,"'ICSNet Transmit'");    
		
		// Check and reset Non-Duet ICSP 232 Transmit Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSP232_TX,500,"'ICSP 232 Transmit'");    
	    
		// Check and reset Non-Duet UDP Transmit Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_ICSPIP_TX,500,"'UDP 232 Transmit'");    
		
		// Check and reset Non-Duet NI Device Manager Queue Size to 500
		CHECK_QUEUE_SIZE(INTERNAL_QUEUE_SIZE_INDEX_NI_DEVICE,500,"'NI Device Manager'");
	    }
	}
    }
    
    //----------------------------------------------------------------------------
    //       IF VALUES HAVE BEEN CHANGED REBOOT
    //----------------------------------------------------------------------------
    
    // Check if need to reboot.  Must reboot if we have changed internals
    if(giNeedReboot == 1)
    {                                      
       // Check to see if internals are not being updated, for whatever reason
       // This should only be true the first time.
       if(gipRebootCount < ciMAX_REBOOTS_FOR_INTERNALS)
       {     
           send_string 0,"' '"    
           send_string 0,"'  >>> Rebooting to set queue and theshold sizes <<<'"    
           send_string 0,"'------------------------------------------------------------------'"        
           send_string 0,"' '"    
	    
           gipRebootCount++
           REBOOT(0:0:0)      // reboot the master
       }
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

//#WARN 'Change to desired setting: DEFAULT_SETTINGS or ENHANCED_SETTINGS'
//Choose from: DEFAULT_SETTINGS or ENHANCED_SETTINGS
QUEUE_AND_THRESHOLD_TYPE = ENHANCED_SETTINGS

CHECK_INTERNALS()        // Check the setup of the Masters Internals

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

