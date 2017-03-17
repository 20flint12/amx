(***********************************************************
    Copyright (c) 2006 Autonomic Controls, Inc.
    
    Media Center Control Server
    Sample Application
    Comm Moudle

    FILE CREATED ON: August 12, 2006                       

(*  FILE_LAST_MODIFIED_ON: 08/25/2007  AT: 11:15:43        *)
(***********************************************************)
    REV HISTORY:                                           
    4/01/2007	Corrected IP connection issues.
				
	8/12/2006	Initial
    8/21/2006   Beta 1

************************************************************)

MODULE_NAME='Autonomic Controls MCS Comm'
(	dev vdvMCS,
	dev dvMCS,
	char cMCS_IP[],
	integer iMCS_PORT
)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

TRUE = 1
FALSE = 0
TCP = 1
RETRY_TIME = 100
DEBUG=2
PING=1

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

volatile integer bClientOnline;      // Flag: TRUE when client is connected          
volatile integer bClientKeepOpen=0   // Flag: keep the client open at all times 
volatile integer giHeartBeat=0   	//Server Heartbeat.
volatile integer giNewConnection=0   //initialization flag.
volatile integer giCurrentPort=0

volatile long TimeArray[1]={10000}	//Ping Server every 10 seconds.

volatile char gsCurrentIP[64]  
volatile char mceBuffer[16000] 

(***********************************************************)
(*                	  Functons			   *)
(***********************************************************)

define_function doCommand(char cmd[])
{
    integer t1;
	
	select 
	{
		active (find_string(cmd,'Disconnect',1)<>0):
		{
			Disconnect();
		}
		
		active (find_string(cmd,'Connect:',1)<>0):
		{
			gsCurrentIP = mid_string(cmd,9,length_string(cmd)-8)
			t1 = find_string(gsCurrentIP,':',1)
			if (t1>0) {
				giCurrentPort = atoi(mid_string(gsCurrentIP,t1+1,length_string(gsCurrentIP)-t1));
				gsCurrentIP = left_string(gsCurrentIP,t1-1);
			}
			
			if (debug>0) send_string 0,"'Connecting to Server: ',gsCurrentIP";
			if (debug>0) send_string 0,"'Connecting to Port:   ',itoa(giCurrentPort)";
			
			if (gsCurrentIP == '') {gsCurrentIP = cMCS_IP;}
			if (giCurrentPort == 0) {giCurrentPort = iMCS_PORT;}
			
			Connect(gsCurrentIP, giCurrentPort)
		}
		
		active (1):
		{
			if (debug>=1) send_string 0,"'OT: ',cmd"
			send_string dvMCS, "cmd,13,10";
		}
	}
}

define_function Connect(char newIP[], integer iPort)
{
	gsCurrentIP = newIP;
	if (bClientOnline = TRUE) Disconnect();
	if (debug>=2) send_string 0,"'Opening connection to ',gsCurrentIP"
	ip_client_open(dvMCS.port,gsCurrentIP,iPort,TCP)
}

define_function Disconnect() 
{
	if (bClientOnline)
	{
		ip_client_close (dvMCS.port);
		bClientOnline=0;
		off [vdvMCS,100];
	}
}
define_function retry()
{
	if (bClientKeepOpen)
	{	wait RETRY_TIME  
		{	ip_client_open(dvMCS.port,gsCurrentIP,giCurrentPort,TCP)
		}
	}
}
	
define_function send_feedback(char cmd[])
{
    send_string vdvMCS, "cmd"
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_START
	
    if (gsCurrentIP=='') {gsCurrentIP = cMCS_IP;}
	if (giCurrentPort == 0) {giCurrentPort = iMCS_PORT;}
	create_buffer dvMCS, mceBuffer;

(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

timeline_event[Ping]
{
	if (giHeartBeat==0)
	{
		doCommand("'Ping'");
		wait 10
		{
			if (giHeartBeat==0)
			{
				if (debug>=2) send_string 0,'No response from server';
				Disconnect();
				Retry();
			}
		}
	}
	else
	{
		giHeartBeat = 0;
	}
}

data_event[dvMCS] (*Media Center Events*)
{
	online:
	{  
		on[vdvMCS,100];
		bClientOnline = TRUE;
		giHeartBeat=1;
		wait 100
		{
			timeline_create (Ping, TimeArray, 1, TIMELINE_ABSOLUTE, TIMELINE_REPEAT)
		}
	}

   offline:
	{
	  off[vdvMCS,100];
	  bClientOnline = FALSE;
	  timeline_kill (Ping);
	  
      // Attempt to re-establish communications
      if (bClientKeepOpen)
         wait RETRY_TIME 
            ip_client_open(dvMCS.port,gsCurrentIP,giCurrentPort,TCP); 
   }
   
   // Data event runs when we get messages from the server.
	string:
	{
		char datum[16000]
		
		while (find_string(mceBuffer,"13,10",1))
		{   datum = remove_string (mceBuffer,"13,10",1)
			if (length_string (datum)<>0)
			{	
				giHeartBeat = 1;
				send_feedback (left_string(datum,length_string(datum)-2))
			}
		}
	}

   onerror:
   {
      send_string 0,"'Error: ',itoa(DATA.NUMBER)"
	  
	  switch(DATA.NUMBER)
      {
		// No need to re-open socket in response to following two errors.
		case 6:		//Connection Refused.
				{	send_feedback('CRF')
					off[vdvMCS,100];				
					Retry();
				}
		case 7: 	//Connection Timed Out.
				{	send_feedback('CTO') 
					off[vdvMCS,100];				
					Retry();
				}
		
		case 9: 	// Socket closed in response to IP_CLIENT_CLOSE
				{	off[vdvMCS,100];				
					break;
				}
		
		case 14:	// Client Open handle already in use.
				{	break;
				}
			
		case 17:	// Client handle already closed.
				{	off[vdvMCS,100];				
					break;
				}
		
		default:   // All other errors.  May want to re-try connection
			       off[vdvMCS,100];				
				   Retry();
			
      }
   }
} 

data_event [vdvMCS]
{
   command:
    {
		char cmd[1024]
		cmd=data.text
		doCommand(cmd)
		SEND_STRING 0, "'STRING: ', cmd"
	}
}

DEFINE_PROGRAM
{
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(***********************************************************)

