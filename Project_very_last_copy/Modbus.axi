PROGRAM_NAME='Modbus'
DEFINE_DEVICE
dvModbus  = 5001:2:0; // Физический адресс Модбас
vdvModbus = 33001:1:0; // Виртуальное устройство Модбас
vdvDebug  = 32999:1:0; // Устройство для дебага
DEFINE_CONSTANT
//Константы для модбаса без конвертации в нормальные значения
VOLATILE FLOAT VAR_1
VOLATILE FLOAT VAR_2
VOLATILE FLOAT VAR_3
VOLATILE FLOAT VAR_4
VOLATILE FLOAT VAR_5
VOLATILE FLOAT VAR_6
VOLATILE FLOAT VAR_7
VOLATILE FLOAT VAR_8
VOLATILE FLOAT VAR_9
VOLATILE FLOAT VAR_10


//Константы для модбаса с конвертацыей
VOLATILE FLOAT VAR_1_ex
VOLATILE FLOAT VAR_2_ex
VOLATILE FLOAT VAR_3_ex
VOLATILE FLOAT VAR_4_ex
VOLATILE FLOAT VAR_5_ex
VOLATILE FLOAT VAR_6_ex
VOLATILE FLOAT VAR_7_ex
VOLATILE FLOAT VAR_8_ex
VOLATILE FLOAT VAR_9_ex

Define_Call 'ModBus - RS485 2-wire cable'     (Char bValue) { If (bValue) Send_Command vdvModbus, 'RS485_2WIRE = ON'; Else Send_Command vdvModbus, 'RS485_2WIRE = OFF'; }

Define_Call 'ModBus - Call Function'          (Char Function, Char Device, Integer Address, Integer QuantityOrValue) { If (Function == 5 && QuantityOrValue == 1) QuantityOrValue = $FF00;   Send_Command vdvModbus, "'ADDCOMMAND = ',         Format('%02X', Device), Format('%02X', Function), Format('%04X', Address), Format('%04X', QuantityOrValue)"; }
Define_Call 'ModBus - Call Function Priority' (Char Function, Char Device, Integer Address, Integer QuantityOrValue) { If (Function == 5 && QuantityOrValue == 1) QuantityOrValue = $FF00;   Send_Command vdvModbus, "'ADDPRIORITYCOMMAND = ', Format('%02X', Device), Format('%02X', Function), Format('%04X', Address), Format('%04X', QuantityOrValue)"; }
Define_Call 'Modbus - Write Multiple Coils' (Char DeviceAddress, Integer StartRegisterAddress, Integer QuantityOfCoils, Char Coils[])
{
	If (QuantityOfCoils && QuantityOfCoils <= $07B0)
	{
		local_var volatile Char    Bits[8];
		local_var volatile Char    bByteCount;
		local_var volatile Char    bData;
		local_var volatile Char    sData[512];
		local_var volatile Integer i;
		
    	Bits = "$01, $02, $04, $08, $10, $20, $40, $80";
		bByteCount = Type_Cast((QuantityOfCoils - 1) / 8 + 1);
		sData = "Format('%02X', DeviceAddress), Format('%02X', $0F), Format('%04X', StartRegisterAddress), Format('%04X', QuantityOfCoils), Format('%02X', bByteCount)";
		bData = $00; For (i = 1; i <= QuantityOfCoils; i++) { bData = bData | (Bits[(i - 1) % 8 + 1] * Coils[i]); If (i % 8 == 0) { sData = "sData, Format('%02X', bData)"; bData = $00; } }
		If (i % 8 != 1) { sData = "sData, Format('%02X', bData)"; }
		
		Send_Command vdvModbus, "'ADDCOMMAND = ', sData";
	}
}

Define_Call 'Modbus - Write Multiple Coils - Single coil' (Char DeviceAddress, Integer RegisterAddress, Char Coil)
{
	Send_Command vdvModbus, "'ADDCOMMAND = ', Format('%02X', DeviceAddress), Format('%02X', $0F), Format('%04X', RegisterAddress), Format('%04X', 1 /* QuantityOfCoils */), Format('%02X', 1 /* bByteCount */), Format('%02X', (Coil > 0))";
}



Define_Call 'Modbus - Write Multiple Registers' (Char DeviceAddress, Integer StartRegisterAddress, Integer QuantityOfRegisters, Integer Values[])
{
	If (QuantityOfRegisters && QuantityOfRegisters <= $7B)
	{
		local_var volatile Char    sData[512];
		local_var volatile Integer i;
		
		sData = "Format('%02X', DeviceAddress), Format('%02X', $10), Format('%04X', StartRegisterAddress), Format('%04X', QuantityOfRegisters), Format('%02X', QuantityOfRegisters * 2)";
	
		For (i = 1; i <= QuantityOfRegisters; i++)
			sData = "sData, Format('%04X', Values[i])";
		
		Send_Command vdvModbus, "'ADDCOMMAND = ', sData";
	}
}

Define_Call 'Modbus - Write Multiple Registers - Single register' (Char DeviceAddress, Integer RegisterAddress, Integer Value)
{
	Send_Command vdvModbus, "'ADDCOMMAND = ', Format('%02X', DeviceAddress), Format('%02X', $10), Format('%04X', RegisterAddress), Format('%04X', 1 /* QuantityOfRegisters */), Format('%02X', 2 /* QuantityOfRegisters * 2 */), Format('%04X', Value)";
}





Define_Call 'ModBus - Process Answer' (Char Function, Char Device, Integer Address, Integer Value)
{
	// TODO : Process answers there

	Select
	{
		// Обработка ответа от устройства с адресом $10 на запрос функции 4 с регистровым адресом $1400
		Active (Function == 3 && Address == 40004) : { VAR_1 = Value}
		Active (Function == 3 && Address == 40008) : { VAR_2 = Value }
		Active (Function == 3 && Address == 40012) : { VAR_3 = Value }
		Active (Function == 3 && Address == 40013) : { VAR_4 = Value }
		Active (Function == 3 && Address == 40014) : { VAR_5 = Value }
		Active (Function == 3 && Address == 44035) : { VAR_6 = Value }
		Active (Function == 3 && Address == 40016) : { VAR_7 = Value }
		Active (Function == 3 && Address == 40033) : { VAR_8 = Value }
		Active (Function == 3 && Address == 43005) : { VAR_9 = Value }
		Active (Function == 3 && Address == 45001) : { VAR_10 = Value }
	}                                                                        
}
DEFINE_EVENT
/*Инициализация модуля модбас*/
DATA_EVENT [vdvModbus]
{
	COMMAND:
	{
		/* If you need to analize sent packet
		local_var volatile Char    SentPacket[256], SentPacketHex[512];
		local_var volatile Integer iPos;

		iPos = Find_String(Data.Text, '; ON_COMMAND = ', 1);
		If (iPos)
		{
			SentPacketHex = Right_String(Data.Text, Length_String(Data.Text) - iPos + 1 - Length_String('; ON_COMMAND = '));
			SentPacket    = GetDataFromHex(SentPacketHex);

			Data.Text     = Left_String(Data.Text, iPos - 1);
		}
		Else
		{
			Clear_Buffer SentPacketHex;
			Clear_Buffer SentPacket;
		}
		*/
		local_var volatile Integer iPos;

		iPos = Find_String(Data.Text, '; ON_COMMAND = ', 1);
		If (iPos)
			Set_Length_String(Data.Text, iPos - 1);


		Select
		{
			Active (RemoveCmdLeft(Data.Text, 'VALUE = ')):
			{
				// REGISTER VALUE RECEIVED FROM DEVICE
				
				// Received data from Device
				// VALUE = 04 01 000A 000F
				// Where:
				//   04   - Function
				//   01   - Device address
				//   000A - Register address
				//   000F - Register value
				
				Call 'ModBus - Process Answer' (hextoi(Mid_String(Data.Text, 1, 2)), hextoi(Mid_String(Data.Text, 4, 2)), hextoi(Mid_String(Data.Text, 7, 4)), hextoi(Mid_String(Data.Text, 12, 4)));
			}


			Active (RemoveCmdLeft(Data.Text, 'ANSWER = ')):
			{
				// FULL RESPONSE THAT RECEIVED ON THE REQUEST
				
				/*
				local_var volatile Char Answer[256], AnswerHex[512];

				AnswerHex = Data.Text;
				Answer    = GetDataFromHex(AnswerHex);

				// TODO : Process answer from AnswerHex or Answer. Example: AnswerHex = '1004020001'
				// TODO : or wait For same 'VALUE = ' messages
				*/
			}


			Active (RemoveCmdLeft(Data.Text, 'WRONG_ANSWER = ')):
			{
				// FULL RESPONSE THAT RECEIVED FROM OTHER DEVICE OR FROM OTHER FUNCTION
				
				/*
				local_var volatile Char Answer[256], AnswerHex[512];

				AnswerHex = Data.Text;
				Answer    = GetDataFromHex(AnswerHex);

				// TODO : Process answer from AnswerHex or Answer. Example: AnswerHex = '1004020001'
				// TODO : or wait For same 'VALUE = ' messages
				*/
			}


			Active (RemoveCmdFull(Data.Text, 'ANSWER_TIMEOUT')):
			{
			    wait 1 SEND_COMMAND IPAD,"'^TXT-10,0,ERROR CONNECT MODBUS'"
			}
			
		}
	}
}

DEFINE_PROGRAM
wait 10
{
VAR_1_ex = VAR_1/10;
VAR_2_ex = VAR_2/10;
VAR_3_ex = VAR_3/10;
VAR_4_ex = VAR_4/10;
VAR_5_ex = VAR_5/10;
VAR_6_ex = VAR_6/10;
VAR_7_ex = VAR_7/10;
VAR_8_ex = VAR_8/10;
VAR_9_ex = VAR_9/10;
}

Wait 100 'Modbus Requests'
{
	// Read values
	// Прочитать функцией 4 у устройства с адресом $10 регистровые значения начиная с адреса $1400 в количесте 20 штук подряд
	// Т.е. прийдют ответы от регистров $1400, $1401, ..., $1412 (итого 20 значений, которые надо будет обработать в функции 'ModBus - Process Answer'
	wait 10 Call 'ModBus - Call Function'  (3, 1, 40004, 1); //Outdoortemperature
	wait 20 Call 'ModBus - Call Function'  (3, 1, 40008, 1); //Flowtemperature
	wait 30 Call 'ModBus - Call Function'  (3, 1, 40012, 1); //Returntemperature
	wait 40 Call 'ModBus - Call Function'  (3, 1, 40013, 1); //Hotwater,top
	wait 50 Call 'ModBus - Call Function'  (3, 1, 40014, 1); //Hotwatermiddle
	wait 60 Call 'ModBus - Call Function'  (3, 1, 40015, 1); //Brinein
	wait 70 Call 'ModBus - Call Function'  (3, 1, 40016, 1); //Brineout
	wait 80 Call 'ModBus - Call Function'  (3, 1, 40033, 1); //Roomtemperature
	wait 90 Call 'ModBus - Call Function'  (3, 1, 43005, 1); //Degreeminutes
	wait 100 Call 'ModBus - Call Function' (3, 1, 45001, 1); //Code of error
}
if (var_1_ex<3000)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-1,0,',FORMAT('%5.1f', VAR_1_ex),' °'"
} 
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-1,0,UNUSED!'"
}
if (var_2_ex<3000)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-2,0,',FTOA(VAR_2_ex),' °'"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-2,0,UNUSED!'"
}
if (var_3_ex<3000)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-3,0,',FTOA(VAR_3_ex),' °'"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-3,0,UNUSED!'"
}
if (var_4_ex<3000)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-4,0,',FTOA(VAR_4_ex),' °'"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-4,0,UNUSED!'"
}
if (var_5_ex<3000)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-5,0,',FTOA(VAR_5_ex),' °'"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-5,0,UNUSED!'"
}
if (var_6_ex<3000)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-6,0,',FTOA(VAR_6_ex),' °'"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-6,0,UNUSED!'"
}
if (var_7_ex<3000)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-7,0,',FTOA(VAR_7_ex),' °'"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-7,0,UNUSED!'"
}
if (var_8_ex<3000)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-8,0,',FTOA(VAR_8_ex),' °'"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-8,0,UNUSED!'"
}

wait 100 SEND_COMMAND IPAD,"'^TXT-9,0,',FTOA(var_9_ex)"
if (var_10=0)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-11,0,',FTOA(var_10)"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-11,0, Error Code: ',FTOA(var_10)"
}
if (var_10>0)
{
wait 100 SEND_COMMAND IPAD,"'^TXT-10,0,The boiler has reported an error please check your equip. Code:',FTOA(var_10)"
}
else
{
wait 100 SEND_COMMAND IPAD,"'^TXT-10,0, '"
}

