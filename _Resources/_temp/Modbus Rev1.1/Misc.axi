(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* Version : 2.0                                           *)
(***********************************************************)


#if_not_defined _Misc_Axi_
#define         _Misc_Axi_


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


sInteger siEmptyTemperatureValue = '9990'



(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)



Define_Function Char[256] GetDataFromHex(Char HexPacket[]) { local_var volatile Char Result[256]; local_var volatile Integer i; Set_Length_String(Result, Min_Value(Length_String(HexPacket) / 2, 256)); For (i = 1; i <= Length_String(Result); i++) Result[i] = hextoi(Mid_String(HexPacket, i*2-1, 2)); return Result; }
Define_Function Char[512] GetHexFromData(Char Packet[])    { local_var volatile Char Result[512]; local_var volatile Integer i, Len; Clear_Buffer Result; Len = Min_Value(Length_String(Packet), 256); For (i = 1; i <= Len; i++) Result = "Result, Format('%02X', Packet[i])"; return Result; }
Define_Function Char[1024] GetHexFromDataD(Char Packet[], Char S[]) { local_var volatile Char Result[1024]; local_var volatile Integer i; Clear_Buffer Result; For (i = 1; i <= Length_String(Packet); i++) Result = "Result, Format('%02X', Packet[i]), S"; Set_Length_String(Result, Length_String(Result) - Length_String(S)); return Result; }


Define_Function Char[16] TemperatureToStr(sInteger Temperature)
{
	If (Temperature <> siEmptyTemperatureValue)
		return "Mid_String(' +-', 1 + (Temperature > 0)*1 + (Temperature < 0)*2, 1), Format('%d', Abs_Value(Temperature / 10)), '.', Format('%d', Abs_Value(Temperature % 10))";
	Else
		return "'??.?'";
}


Define_Function Char[16] TemperatureToStrWithSign(sInteger Temperature)
{
	If (Temperature <> siEmptyTemperatureValue)
		return "Mid_String(' +-', 1 + (Temperature > 0)*1 + (Temperature < 0)*2, 1), Format('%d', Abs_Value(Temperature / 10)), '.', Format('%d', Abs_Value(Temperature % 10)), '°C'";
	Else
		return "'??.?°C'";
}


Define_Function Char[16] MinutesToText(Integer Minutes)
{
	If (Minutes == 0)
		return "'0 мин'";
	Else
	If (Minutes < 60)
		return "Format('%d мин', Minutes)";
	Else
	If ((Minutes % 60) == 0)
		return "Format('%d ч', (Minutes / 60))";
	Else
		return "Format('%d ч ', (Minutes / 60)), Format('%d мин', (Minutes % 60))";
}


// Returns timeout value in 1/10 of second

Define_Function Long Timeout(Long Days, Long Hours, Long Minutes, Long Seconds)
{
	return ((((Days * 24) + Hours) * 60 + Minutes) * 60 + Seconds) * 10; // Generate runtime error
}



Define_Function Char[32] GetDeviceAsText(Dev Device)
{
	return "itoa(Device.Number), ':', itoa(Device.Port), ':', itoa(Device.System)";
}



// Returns true if Cmd was removed from Msg

Define_Function Integer RemoveCmd(Char Msg[], Char Cmd[])
{
	If (Msg == Cmd)
	{
		Clear_Buffer Msg;

		return 1;
	}
	Else
	{
		// If (Right_String(Cmd, 3) == ' = ' ||
		If (Right_String(Cmd, 1) == ' ' ||
			Right_String(Cmd, 1) == '=' ||
			Right_String(Cmd, 1) == '-' ||
			Right_String(Cmd, 1) == ':')
		{
			If (Find_String(Msg, Cmd, 1) == 1)
			{
	    		Get_Buffer_String(Msg, Length_Array(Cmd));

	    		return 1;
	    	}
	    }
	}

	return 0;
}



// Returns true if Cmd was removed from left part of Msg

Define_Function Integer RemoveCmdLeft(Char Msg[], Char Cmd[])
{
	If (Find_String(Msg, Cmd, 1) == 1)
	{
		Get_Buffer_String(Msg, Length_Array(Cmd));

		return 1;
	}

	return 0;
}



// Returns true if Cmd was full Msg and was removed from Msg

Define_Function Integer RemoveCmdFull(Char Msg[], Char Cmd[])
{
	If (Msg == Cmd)
	{
		Clear_Buffer Msg;

		return 1;
	}

	return 0;
}



// Get(Type)ArrayIndex functions

Define_Function Integer GetCharArrayIndex(Char cElement, Char cArray[])
{
    local_var volatile Integer i;

    For (i = 1; i <= Length_Array(cArray); i++)
        If (cElement == cArray[i])
            return i;

    return 0;
}


Define_Function Integer GetIntegerArrayIndex(Integer iElement, Integer iArray[])
{
    local_var volatile Integer i;

    For (i = 1; i <= Length_Array(iArray); i++)
        If (iElement == iArray[i])
            return i;

    return 0;
}


Define_Function Integer GetLongArrayIndex(Long lElement, Long lArray[])
{
    local_var volatile Integer i;

    For (i = 1; i <= Length_Array(lArray); i++)
        If (lElement == lArray[i])
            return i;

    return 0;
}


Define_Function Integer GetDevIndex(Dev dvElement, Dev dvArray[])
{
    local_var volatile Integer i;

    For (i = 1; i <= Length_Array(dvArray); i++)
        If (dvElement.Number == dvArray[i].Number && dvElement.Port == dvArray[i].Port && (dvElement.System == dvArray[i].System || (dvElement.System == Get_System_Number() && dvArray[i].System == 0)))
            return i;

    return 0;
}


Define_Function Integer GetDevChanIndex(DevChan dcElement, DevChan dcArray[])
{
    local_var volatile Integer i;

    For (i = 1; i <= Length_Array(dcArray); i++)
        If (dcElement.Device.Number == dcArray[i].Device.Number && dcElement.Device.Port == dcArray[i].Device.Port && (dcElement.Device.System == dcArray[i].Device.System || (dcElement.Device.System == Get_System_Number() && dcArray[i].Device.System == 0)) &&
            dcElement.Channel       == dcArray[i].Channel)
            return i;

    return 0;
}


Define_Function Integer GetDevLevIndex(DevLev dlElement, DevLev dlArray[])
{
    local_var volatile Integer i;

    For (i = 1; i <= Length_Array(dlArray); i++)
        If (dlElement.Device.Number == dlArray[i].Device.Number && dlElement.Device.Port == dlArray[i].Device.Port && (dlElement.Device.System == dlArray[i].Device.System || (dlElement.Device.System == Get_System_Number() && dlArray[i].Device.System == 0)) &&
            dlElement.Level         == dlArray[i].Level)
            return i;

    return 0;
}



#end_if // _Misc_Axi_