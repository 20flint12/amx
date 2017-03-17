MODULE_NAME='NUVO_Tuner'(DEV NUVO, DEV MVP[], DEV vdvDEVCANNEL,integer KEYPAD_TUNER[][], char MasFMRadioKiev[][])




DEFINE_VARIABLE

VOLATILE CHAR NUVO_BUFFER [1000]
VOLATILE INTEGER NIStart = 0    
VOLATILE CHAR Buffer [1000]

VOLATILE CHAR FM_Station_A [8]
VOLATILE CHAR FM_Station_B [8]

VOLATILE INTEGER COUNT_Zone, COUNT_sourse
VOLATILE INTEGER I




DEFINE_CONSTANT

VOLATILE CHAR arrTuner [2][1] = {{'A'},{'B'}}


DEFINE_FUNCTION ShowSelectedsTATIONS(INTEGER NUM_TUNER ,char STATIONS[10])
{
    STACK_VAR INTEGER nIndex
    for(nIndex = 1; nIndex <= length_array (MasFMRadioKiev); nIndex++)
    {
		if(MasFMRadioKiev [nIndex] = STATIONS)
			ON[vdvDEVCANNEL, KEYPAD_tuner[NUM_TUNER][nIndex]]
		else
			OFF[vdvDEVCANNEL, KEYPAD_tuner[NUM_TUNER][nIndex]]
    }
}




DEFINE_FUNCTION ParseDT  (char ParsTXT [500])
{
                
                local_var volatile char ZZ  [10]
		local_var volatile char TXT [30]
                local_var volatile char TXT_channel [10]
		local_var volatile char TXT_END [2]
		
		If (find_string(ParsTXT,"'ON,FM'",1))
		{
		    
		  REMOVE_STRING(ParsTXT,"'#T',$27",1)
		  ZZ = LEFT_STRING(ParsTXT,1)
		  
		  send_string 0, "'ZZ_= ',ZZ"
		 
		 REMOVE_STRING(ParsTXT,'FM',1)
		 TXT = REMOVE_STRING(ParsTXT,"$0D",1)
		 TXT = LEFT_STRING(TXT,LENGTH_STRING(TXT)-1)
		 TXT_channel = "TXT"
		  
		switch(ZZ)
			{
				case 'A':
				{
				ShowSelectedsTATIONS(1 ,TXT)
				SEND_COMMAND MVP,"'^TXT-',itoa (KEYPAD_TUNER[1][1]),',0,',TXT,' FM'"

				}
				case 'B':
				{
				ShowSelectedsTATIONS(2 ,TXT)
				SEND_COMMAND MVP,"'^TXT-',itoa (KEYPAD_TUNER[2][1]),',0,',TXT,' FM'"
				}
			}
                }
}



DEFINE_FUNCTION ProcessAdressTuner (INTEGER TunerIndex)

{
   LOCAL_VAR VOLATILE integer sourse 
   
   
    sourse = GET_LAST (KEYPAD_tuner[TunerIndex])
    send_string 0, "itoa(sourse)"
       
       if (sourse < 31) 
                       { Send_String NUVO,"'*T',$27,arrTuner [TunerIndex],$27,'FM',MasFMRadioKiev[sourse],13"
		       }
}

DEFINE_FUNCTION ProcessAdressTuner31 (INTEGER TunerIndex)

{
   LOCAL_VAR VOLATILE integer sourse 
   
   
    sourse = GET_LAST (KEYPAD_tuner[TunerIndex])
    send_string 0, "itoa(sourse)"
       
                           SWITCH (sourse)
                                           {

					    CASE 31: //TUNE UP
                                                             {
							      Send_String NUVO,"'*T',$27,arrTuner [TunerIndex],$27,'SEEK+',13" 
							     }
					    CASE 32: //TUNE DOWN
                                                             {
							      Send_String NUVO,"'*T',$27,arrTuner [TunerIndex],$27,'SEEK-',13" 
							     }
					    CASE 33: //STATUS
                                                             {
							      Send_String NUVO,"'*T',$27,arrTuner [1],$27,'STATUS',13" 
							      wait 10
							      Send_String NUVO,"'*T',$27,arrTuner [2],$27,'STATUS',13" 
							     }
							     
					    }
		       }


DEFINE_START
CREATE_BUFFER NUVO, NUVO_BUFFER 


DEFINE_EVENT

BUTTON_EVENT [vdvDEVCANNEL,KEYPAD_tuner[1]] {PUSH:{ ProcessAdressTuner (1) send_string 0, 'ON'}} // TUNER 1
BUTTON_EVENT [MVP,KEYPAD_tuner[1]] {PUSH:{ ProcessAdressTuner31 (1) send_string 0, 'ON'}} // TUNER 1

BUTTON_EVENT [vdvDEVCANNEL,KEYPAD_tuner[2]] {PUSH:{ ProcessAdressTuner (2) send_string 0, 'ON'}} // TUNER 2
BUTTON_EVENT [MVP,KEYPAD_tuner[2]] {PUSH:{ ProcessAdressTuner31 (2) send_string 0, 'ON'}} // TUNER 2


DATA_EVENT[vdvDEVCANNEL]
{
    online:
	{
	    FOR (I=1 ; I <= LENGTH_ARRAY (MVP) ; I++)
		    {
		FOR (COUNT_sourse=1 ; COUNT_sourse<31 ; COUNT_sourse++)
		    {
		         combine_channels (vdvDEVCANNEL, KEYPAD_tuner[1][COUNT_sourse], MVP[I], KEYPAD_tuner[1][COUNT_sourse]) 
                         combine_channels (vdvDEVCANNEL, KEYPAD_tuner[2][COUNT_sourse], MVP[I], KEYPAD_tuner[2][COUNT_sourse]) 
                    }}
}}



DATA_EVENT[NUVO]

{
online:
       { wait 600 {Send_Command NUVO, 'SET BAUD 57600,N,8,1' 
         wait 10 {Send_String NUVO,"'*T',$27,arrTuner [1],$27,'STATUS',13" 
         wait 10 {Send_String NUVO,"'*T',$27,arrTuner [2],$27,'STATUS',13" 
		    }}}
       }
STRING:
         {
	        Buffer = Data.Text	
		if(find_string(Buffer,'#T',1) > 0)
		{
		   
		    ParseDT (Buffer)
                    Buffer = ''			      
		}
	        clear_buffer NUVO_BUFFER
         }
}



DEFINE_PROGRAM


