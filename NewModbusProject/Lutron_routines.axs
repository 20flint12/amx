PROGRAM_NAME='Lutron_routines'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE



#IF_NOT_DEFINED IPAD
    //#WARN 'RMS: This Device Needs to be Defined in your Main Program: dvPanel'
    IPAD    = 11001:1:1;
#END_IF




//IPAD    = 11001:1:1;

Lutron 	   = 5001:1:0;
vdv_LUTRON = 33001:1:1




(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

PERSISTENT CHAR Lutron_buffer[1000]


(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


COMBINE_CHANNELS (vdv_LUTRON, 200, ipad, 200)
COMBINE_CHANNELS (vdv_LUTRON, 201, ipad, 201)
COMBINE_CHANNELS (vdv_LUTRON, 202, ipad, 202)
COMBINE_CHANNELS (vdv_LUTRON, 203, ipad, 203)
COMBINE_CHANNELS (vdv_LUTRON, 204, ipad, 204)
COMBINE_CHANNELS (vdv_LUTRON, 205, ipad, 205)
COMBINE_CHANNELS (vdv_LUTRON, 206, ipad, 206)
COMBINE_CHANNELS (vdv_LUTRON, 207, ipad, 207)
COMBINE_CHANNELS (vdv_LUTRON, 208, ipad, 208)
COMBINE_CHANNELS (vdv_LUTRON, 209, ipad, 209)
COMBINE_CHANNELS (vdv_LUTRON, 210, ipad, 210)
COMBINE_CHANNELS (vdv_LUTRON, 211, ipad, 211)
COMBINE_CHANNELS (vdv_LUTRON, 212, ipad, 212)
COMBINE_CHANNELS (vdv_LUTRON, 213, ipad, 213)
COMBINE_CHANNELS (vdv_LUTRON, 214, ipad, 214)
COMBINE_CHANNELS (vdv_LUTRON, 215, ipad, 215)
COMBINE_CHANNELS (vdv_LUTRON, 216, ipad, 216)
COMBINE_CHANNELS (vdv_LUTRON, 217, ipad, 217)
COMBINE_CHANNELS (vdv_LUTRON, 218, ipad, 218)
COMBINE_CHANNELS (vdv_LUTRON, 219, ipad, 219)
COMBINE_CHANNELS (vdv_LUTRON, 220, ipad, 220)
COMBINE_CHANNELS (vdv_LUTRON, 221, ipad, 221)
COMBINE_CHANNELS (vdv_LUTRON, 222, ipad, 222)
COMBINE_CHANNELS (vdv_LUTRON, 223, ipad, 223)  
COMBINE_CHANNELS (vdv_LUTRON, 224, ipad, 224)  

CREATE_BUFFER Lutron, Lutron_buffer;


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT



BUTTON_EVENT [vdv_LUTRON, 200] //Калитка
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 17',$0D";
	SEND_STRING 0, "'KBP, [1:6:1], 17',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 201] //Дорожки
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 9',$0D";
	SEND_STRING 0, "'KBP, [1:6:1], 09',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 202] //Дальние
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:06:1], 10',$0D";
	SEND_STRING 0, "'KBP, [1:06:1], 10',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 203] //Вход спа
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 1',$0D";
	SEND_STRING 0, "'KBP, [1:6:1], 1',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 204] //Беседка 1
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 18',$0D";
	SEND_STRING 0, "'KBP, [1:6:1], 18',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 205] //Беседка 2
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 19',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 19',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 206] //Беседка 3
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 20',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 20',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 207] //Беседка 4
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 21',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 21',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 208] //Прожектор
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 2',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 2',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 209] //Ель 1
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 11',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 11',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 210] //Ель 2
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 12',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 12',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 211] //Ель 3
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 13',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 13',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 212] //Ворота
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 22',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 22',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 213] //Гараж 1
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 14',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 14',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 214] //Гараж 2
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 6',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 6',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 216] //Гараж 2 закрыть
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 7',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 7',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 217] //Гараж 1 закрыть
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 15',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 15',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 218] //Ворота закрыть
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 23',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 23',$0D"
    }
}

BUTTON_EVENT [vdv_LUTRON, 219] //Туман
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 4',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 04',$0D"
    }
}

/*DATA_EVENT [Lutron_buffer]
{
    STRING:
    {
	SELECT
	{
	    ACTIVE (FIND_STRING (Lutron_buffer,'[01:06:01], 100',1)):
	    {
		[IPAD,203] = 1;
		send_string 0, 'ON'
	    }
	    ACTIVE (FIND_STRING (Lutron_buffer,'[01:06:01], 000',1)):
	    {
		[IPAD,203] = 0;
		send_string 0, 'OFF'
	    }
	}
    }
}*/

BUTTON_EVENT [vdv_LUTRON, 220] //Въезд
{
    PUSH:
    {
	SEND_STRING Lutron, "'KBP, [1:6:1], 3',$0D";
	SEND_STRING 0, "'KBP, [01:06:01], 03',$0D"
    }
}

DATA_EVENT[Lutron]
{
    ONLINE:
    {
	SEND_COMMAND Lutron,'SET BAUD 9600,N,8,1'
	SEND_STRING  Lutron,"'KLMON',$0D" 
	WAIT 20 
	{
	    SEND_STRING  Lutron,"'RKLS,[01:06:01]',13"
	}
    }
}



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


Wait 5
{
IF (FIND_STRING (Lutron_buffer, "$0D",1)) 
    {
        REMOVE_STRING (Lutron_buffer,"$0D",1);
	REMOVE_STRING (Lutron_buffer,'KLS, [01:06:01], ',1);
	SEND_STRING 0, Lutron_buffer;
	//SEND_STRING 0, Lutron_device_buffer;
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 1, 1),'1'))
	{
	    [vdv_LUTRON,203] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 1, 1),'0'))   
	{
	    [vdv_LUTRON,203] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 2, 1),'1'))
	{
	    [vdv_LUTRON,208] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 2, 1),'0'))   
	{
	    [vdv_LUTRON,208] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 3, 1),'1'))
	{
	    [vdv_LUTRON,220] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 3, 1),'0'))   
	{
	    [vdv_LUTRON,220] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 4, 1),'1'))
	{
	    [vdv_LUTRON,219] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 4, 1),'0'))   
	{
	    [vdv_LUTRON,219] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 6, 1),'1'))
	{
	    [vdv_LUTRON,214] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 6, 1),'0'))   
	{
	    [vdv_LUTRON,214] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 9, 1),'1'))
	{
	    [vdv_LUTRON,201] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 9, 1),'0'))   
	{
	    [vdv_LUTRON,201] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 10, 1),'1'))
	{
	    [vdv_LUTRON,202] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 10, 1),'0'))   
	{
	    [vdv_LUTRON,202] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 11, 1),'1'))
	{
	    [vdv_LUTRON,209] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 11, 1),'0'))   
	{
	    [vdv_LUTRON,209] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 12, 1),'1'))
	{
	    [vdv_LUTRON,210] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 12, 1),'0'))   
	{
	    [vdv_LUTRON,210] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 13, 1),'1'))
	{
	    [vdv_LUTRON,211] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 13, 1),'0'))   
	{
	    [vdv_LUTRON,211] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 14, 1),'1'))
	{
	    [vdv_LUTRON,213] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 14, 1),'0'))   
	{
	    [vdv_LUTRON,213] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 17, 1),'1'))
	{
	    [vdv_LUTRON,200] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 17, 1),'0'))   
	{
	    [vdv_LUTRON,200] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 18, 1),'1'))
	{
	    [vdv_LUTRON,204] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 18, 1),'0'))   
	{
	    [vdv_LUTRON,204] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 19, 1),'1'))
	{
	    [vdv_LUTRON,205] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 19, 1),'0'))   
	{
	    [vdv_LUTRON,205] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 20, 1),'1'))
	{
	    [vdv_LUTRON,206] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 20, 1),'0'))   
	{
	    [vdv_LUTRON,206] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 21, 1),'1'))
	{
	    [vdv_LUTRON,207] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 21, 1),'0'))   
	{
	    [vdv_LUTRON,207] = 0;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 22, 1),'1'))
	{
	    [vdv_LUTRON,212] = 1;
	}
	IF (COMPARE_STRING (MID_STRING(Lutron_buffer, 22, 1),'0'))   
	{
	    [vdv_LUTRON,212] = 0;
	}
    }    
    CLEAR_BUFFER Lutron_buffer;
}





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

