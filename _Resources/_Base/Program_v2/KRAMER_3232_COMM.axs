MODULE_NAME='KRAMER_3232_COMM' (DEV DAS, DEV vdvDAS[], DEV vdvString)

DEFINE_CONSTANT

DEFINE_VARIABLE
volatile CHAR DAS_Buffer[1024] = ""
volatile CHAR vdvBufferString [1024] = ""
volatile char String_To_DAS [100]
volatile integer i, ii
volatile integer Max_Zone 



DEFINE_FUNCTION GetZoneStatus(INTEGER Zone)
{
	Send_String vdvString, "'**O',itoa(Zone),'!!',$0D"
}

DEFINE_FUNCTION ZoneSelectSource(INTEGER Zone, INTEGER Source)
{
	Send_String vdvString, "'**Y',itoa(Zone),',',ITOA(Source),'!!',$0D"
	Send_String vdvString, "'**O',itoa(Zone),'!!',$0D"

}

DEFINE_FUNCTION ZoneSetVolume(INTEGER Zone, INTEGER Value)
{
	Send_String vdvString, "'**GVAR1,AUDOUT_GAINS,',itoa(Zone),',',ITOA(Value),'~!!',$0D"
}



DEFINE_START
CREATE_BUFFER DAS, DAS_Buffer
CREATE_BUFFER vdvString, vdvBufferString


Max_Zone = LENGTH_ARRAY (vdvDAS)

DEFINE_EVENT

DATA_EVENT[DAS]
{
	ONLINE:
	{
	WAIT 50 { Send_Command DAS, 'SET BAUD 9600,N,8,1' }
	WAIT 100 { Send_String vdvString, "'**S!!',$0D" }
	}
	STRING:
	{
		LOCAL_VAR volatile CHAR Reply[100]
		LOCAL_VAR volatile CHAR Cmd[100]
		LOCAL_VAR volatile INTEGER Zone
		LOCAL_VAR volatile CHAR Sourse[2]
		
		while (FIND_STRING(DAS_Buffer,"'Y'",1))
		{
		    REMOVE_STRING(DAS_Buffer,"'Y'",1)
		    Reply = REMOVE_STRING(DAS_Buffer,"','",1)
		    Zone = ATOI ( LEFT_STRING(Reply, LENGTH_STRING(Reply) - 1) )
		    Sourse = LEFT_STRING(DAS_Buffer,2)
		    
		    IF ( Zone <= LENGTH_ARRAY (vdvDAS)  )   {Send_String vdvDAS[Zone],"'SOURCE:',Sourse"}
		    
                }
		CLEAR_BUFFER DAS_Buffer
	}
}


DATA_EVENT[vdvDAS]
{
	ONLINE:
	{
	}
	COMMAND:
	{        
		CHAR Cmd[30]
		INTEGER  DASZone
		DASZone = GET_LAST(vdvDAS)
		
		Cmd = REMOVE_STRING(Data.Text,':',1)
		if(LENGTH_STRING(Cmd)>0)
		{
			INTEGER Param
			Param = ATOI("Data.Text")
			
			SELECT
			{
				ACTIVE(FIND_STRING(Cmd,'SOURCE',1)):
				{
					ZoneSelectSource(DASZone, Param)
				}
				ACTIVE(FIND_STRING(Cmd,'STATUS',1)):
				{
					GetZoneStatus(DASZone)
				}
			}
		}
	}
}
LEVEL_EVENT[vdvDAS,1]
{
	ZoneSetVolume(GET_LAST(vdvDAS), Level.Value)
}



DEFINE_PROGRAM

WAIT 2
{IF (vdvBufferString <> '')
{IF (ii = 0) {
String_To_DAS = REMOVE_STRING(vdvBufferString, "$0D",1)
SEND_STRING DAS, String_To_DAS
IF (FIND_STRING (vdvBufferString, "$0D",1)=0) {vdvBufferString = ''}
}}}


 

