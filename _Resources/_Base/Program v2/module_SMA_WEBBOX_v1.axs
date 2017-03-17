MODULE_NAME='module_SMA_WEBBOX_v1'
(DEV DEVICE, DEV vdvModbus, DEV vdvDebug, DEV MVP[], CHAR DEVICE_IP[], INTEGER DEVICE_Port, INTEGER DEVICE_OnLine, INTEGER KEYPAD [], INTEGER BUTTON_ [],DEV IO, FLOAT SUMM_PARAM_[]) // 

#include 'Misc.axi'

DEFINE_DEVICE



DEFINE_VARIABLE

VOLATILE CHAR Daily_yield_ch_2 [30]
VOLATILE CHAR Total_yield_ch_2 [30]
VOLATILE CHAR Power_ch_2 [30]
VOLATILE CHAR Total_yield_ch_3 [30]
VOLATILE CHAR TOK_A [30]
VOLATILE CHAR TOK_B [30]
VOLATILE CHAR Battery_Charge [5]
        
VOLATILE INTEGER HI_REGISTR

VOLATILE FLOAT SUMM_PARAM_Z[10]


volatile INTEGER a = 0
volatile INTEGER OPROS_ON, COUNT_1, OPROS_ON_FIRST
volatile INTEGER SELECT_I
VOLATILE INTEGER REGISTER_STATUS [50] = 
    {
	30775, //01 AC active power across all phases (W) [Pac] 
	30519, //02 Day yield (Wh) [E-heute] 
	30515, //03 Total yield (Wh) [E-Total]
	30515, //04 Total yield (Wh) [E-Total]
	30769, //05 DC current input (A) [Ipv] 
	30803, //06 String current, string 6 (A) [B1.Ms.Amp] 
	30845, //07 Current battery charge status (%) [BatSoc] 
	           
	30531, //08 Total yield (kWh) [E-Total] 
	30775, //09 Power (W) [TotInvPwrAt]  				    
	30777, //10 Power L1 (W) [InvPwrAt]  			    
	30779, //11 Power L2 (W) [InvPwrAtSlv1]  			    
	30781, //12 Power L3 (W) [InvPwrAtSlv2]  	
	         
	30783, //13 Grid voltage phase L1 (V) [InvVtg]  			    
	30785, //14 Grid voltage phase L2 (V) [InvVtgSlv1]  			    
	30787, //15 Grid voltage phase L3 (V) [InvVtgSlv2] 	
	         
	30861, //16 Consumer power (W) [TotLodPwrAt] 			    
	30863, //17 Current generator power (W) [TotGnPwrAt] 	
	         
	30867, //18 Power grid feed-in (W) [GdFeedPwrAt] 			    
	30869, //19 PV power generated (W) [TotPvPwr] 			    
	30871, //20 Current self-consumption (W) [SlfCsmpPwrAt] 			    
	30887, //21 Power external mains connection phase A (W) [ExtPwrAt] 			    
	30889, //22 Power external mains connection phase B (W) [ExtPwrAtSlv1] 			    
	30891, //23 Power external mains connection phase C (W) [ExtPwrAtSlv2] 
	         
	30795, //24 Grid current (A) [TotInvCur] 
	30797, //25 Grid current phase L1 (A) [InvCur] 
	30799, //26 Grid current phase L2 (A) [InvCurSlv1] 
	30801, //27 Grid current phase L3 (A) [InvCurSlv2] 
	         
	30903, //28 Voltage external mains connection phase A (V) [ExtVtg] 
	30905, //29 Voltage external mains connection phase B (V) [ExtVtgSlv1]
	30907, //30 Voltage external mains connection phase C (V) [ExtVtgSlv2]
	30909, //31 Current external mains connection phase A (A) [ExtCur] 
	30911, //32 Current external mains connection phase B (A) [ExtCurSlv1]
	30913, //33 Current external mains connection phase C (A) [ExtCurSlv2]
	         
	30885, //34 Power external mains connection (W) [TotExtPwrAt] 
	30865, //35 Power grid reference (W) [GdCsmpPwrAt] 	
	30873, //36 Current rise in self-consumption (W) [SlfCsmpIncPwr] 	
	         
	30807, //37 Reactive power L1 (var) [GridMs.VAr.phsA] 
	30809, //38 Reactive power L2 (var) [GridMs.VAr.phsB] 
	30811, //39 Reactive power L3 (var) [GridMs.VAr.phsC] 
	           
	30773, //40 DC power input (W) [A.Ms.Watt] 
	30775, //41 AC active power across all phases (W) [Pac] адрес 4
	30843, //42 Battery current (A) [TotBatCur]                                
	30851, //43 Battery voltage (V) [BatVtg]                            
	30857  //44 Number of battery charge throughputs [BatCpyThrpCnt]   
}                
 


VOLATILE INTEGER REGISTER_HI[50]

      

                                                
(* ************************************* ModBus ************************************* *)
// ModBus
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
    LOCAL_VAR INTEGER INDEX // 

	Select
	{
		// Обработка ответа от устройства с адресом $10 на запрос функции 4 с регистровым адресом $1400
		Active (Function == 4 && Device == 2 && Address == 30775) : {INDEX = 1 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 2 && Address == 30776) : {INDEX = 1 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000   SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'")}
		
		Active (Function == 4 && Device == 2 && Address == 30519) : {INDEX = 2 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 2 && Address == 30520) : {INDEX = 2 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kWh'")  }
		                                                             
		Active (Function == 4 && Device == 2 && Address == 30515) : {INDEX = 3 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 2 && Address == 30516) : {INDEX = 3 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kWh'")  }
		                                                       
		Active (Function == 4 && Device == 4 && Address == 30515) : {INDEX = 4 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 4 && Address == 30516) : {INDEX = 4 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kWh'")  }
		                                                             
		Active (Function == 4 && Device == 4 && Address == 30769) : {INDEX = 5 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 4 && Address == 30770) : {INDEX = 5 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'")  }
		                                                             
		Active (Function == 4 && Device == 4 && Address == 31803) : {INDEX = 6 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 4 && Address == 31804) : {INDEX = 6 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'")  }
		                                                            
		Active (Function == 4 && Device == 3 && Address == 30846) : {INDEX = 7 SUMM_PARAM_[INDEX] = Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' %'") }
	        
		Active (Function == 4 && Device == 3 && Address == 30531) : {INDEX = 8 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30532) : {INDEX = 8 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' kWh'")}
	                                                                                      
		Active (Function == 4 && Device == 3 && Address == 30775) : {INDEX = 9 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30776) : {INDEX = 9 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'")  }
		                                                                                                                                                                    
		Active (Function == 4 && Device == 3 && Address == 30777) : {INDEX = 10 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30778) : {INDEX = 10 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'")  }
		                                                                                                                                                                     
		Active (Function == 4 && Device == 3 && Address == 30779) : {INDEX = 11 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30780) : {INDEX = 11 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'")  }
		                                                                                                                                                                     
		Active (Function == 4 && Device == 3 && Address == 30781) : {INDEX = 12 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30782) : {INDEX = 12 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'")  }
		                                                                                                                                                                     
		Active (Function == 4 && Device == 3 && Address == 30783) : {INDEX = 13 REGISTER_HI[INDEX] = Value}                                                                            
		Active (Function == 4 && Device == 3 && Address == 30784) : {INDEX = 13 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/100 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.1f',SUMM_PARAM_[INDEX]), ' V'")  }
		                                                                                                                                                                     
		Active (Function == 4 && Device == 3 && Address == 30785) : {INDEX = 14 REGISTER_HI[INDEX] = Value}                                                                            
		Active (Function == 4 && Device == 3 && Address == 30786) : {INDEX = 14 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/100 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.1f',SUMM_PARAM_[INDEX]), ' V'")  }
		                                                                                                                                                                     
		Active (Function == 4 && Device == 3 && Address == 30787) : {INDEX = 15 REGISTER_HI[INDEX] = Value}                                                                            
		Active (Function == 4 && Device == 3 && Address == 30788) : {INDEX = 15 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/100 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.1f',SUMM_PARAM_[INDEX]), ' V'")  }
		                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30861) : {INDEX = 16 REGISTER_HI[INDEX] = Value}                                         
		Active (Function == 4 && Device == 3 && Address == 30862) : {INDEX = 16 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' kWh'")}
		                                                                                                                                    
		Active (Function == 4 && Device == 3 && Address == 30863) : {INDEX = 17 REGISTER_HI[INDEX] = Value}                                         
		Active (Function == 4 && Device == 3 && Address == 30864) : {INDEX = 17 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' kWh'")}
		                                                                                                                                    
		Active (Function == 4 && Device == 3 && Address == 30867) : {INDEX = 18 REGISTER_HI[INDEX] = Value}                                         
		Active (Function == 4 && Device == 3 && Address == 30868) : {INDEX = 18 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' kWh'")}
		                                                                                                                                    
		Active (Function == 4 && Device == 3 && Address == 30869) : {INDEX = 19 REGISTER_HI[INDEX] = Value}                                         
		Active (Function == 4 && Device == 3 && Address == 30870) : {INDEX = 19 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' kWh'")}
		                                                                                                                                    
		Active (Function == 4 && Device == 3 && Address == 30871) : {INDEX = 20 REGISTER_HI[INDEX] = Value}                                         
		Active (Function == 4 && Device == 3 && Address == 30872) : {INDEX = 20 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' kWh'")}
		                                                                                                                                    
		Active (Function == 4 && Device == 3 && Address == 30887) : {INDEX = 21 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30888) : {INDEX = 21 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'") }
		                                                                                                                                                               
		Active (Function == 4 && Device == 3 && Address == 30889) : {INDEX = 22 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30890) : {INDEX = 22 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'") }
		                                                                                                                                                               
		Active (Function == 4 && Device == 3 && Address == 30891) : {INDEX = 23 REGISTER_HI[INDEX] = Value}
	        Active (Function == 4 && Device == 3 && Address == 30892) : {INDEX = 23 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'") }
		                                                                                                                                                                    
                                                                                                                                                                                  
                                                                                                                                                                                  
		                                                                                                                                                                    
		Active (Function == 4 && Device == 3 && Address == 30795) : {INDEX = 24 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30796) : {INDEX = 24 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30797) : {INDEX = 25 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30798) : {INDEX = 25 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30799) : {INDEX = 26 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30800) : {INDEX = 26 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30801) : {INDEX = 27 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30802) : {INDEX = 27 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30903) : {INDEX = 28 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30904) : {INDEX = 28 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/100 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.1f',SUMM_PARAM_[INDEX]), ' V'") }
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30905) : {INDEX = 29 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30906) : {INDEX = 29 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/100 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.1f',SUMM_PARAM_[INDEX]), ' V'") }
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30907) : {INDEX = 30 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30908) : {INDEX = 30 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/100 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.1f',SUMM_PARAM_[INDEX]), ' V'") }
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30909) : {INDEX = 31 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30910) : {INDEX = 31 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30911) : {INDEX = 32 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30912) : {INDEX = 32 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
                                                                                                                                                                                  
		Active (Function == 4 && Device == 3 && Address == 30913) : {INDEX = 33 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30914) : {INDEX = 33 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
	                                                                                                                                                         
	
	
		Active (Function == 4 && Device == 3 && Address == 30885) : {INDEX = 34 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30886) : {INDEX = 34 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'") 
										SUMM_PARAM_Z[1] = SUMM_PARAM_[1] + SUMM_PARAM_[34] SEND_TXT (BUTTON_ [1], "FORMAT('%5.2f',SUMM_PARAM_Z[1]), ' kW'")
										}
	
		Active (Function == 4 && Device == 3 && Address == 30865) : {INDEX = 35 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30866) : {INDEX = 35 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'") }
	
		Active (Function == 4 && Device == 3 && Address == 30873) : {INDEX = 36 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30874) : {INDEX = 36 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'") }
	
	        Active (Function == 4 && Device == 3 && Address == 30807) : {INDEX = 37 REGISTER_HI[INDEX] = Value}                                         
		Active (Function == 4 && Device == 3 && Address == 30808) : {INDEX = 37 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' VA'")}

	        Active (Function == 4 && Device == 3 && Address == 30809) : {INDEX = 38 REGISTER_HI[INDEX] = Value}                                         
		Active (Function == 4 && Device == 3 && Address == 30810) : {INDEX = 38 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' VA'")}

	        Active (Function == 4 && Device == 3 && Address == 30811) : {INDEX = 39 REGISTER_HI[INDEX] = Value}                                         
		Active (Function == 4 && Device == 3 && Address == 30812) : {INDEX = 39 SUMM_PARAM_[INDEX] = REGISTER_HI[INDEX] * 65536 + Value  SEND_TXT (KEYPAD [INDEX], "itoa (SUMM_PARAM_[INDEX]), ' VA'")}

	
		Active (Function == 4 && Device == 3 && Address == 30773) : {INDEX = 40 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30774) : {INDEX = 40 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
	
		Active (Function == 4 && Device == 4 && Address == 30775) : {INDEX = 41 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 4 && Address == 30776) : {
		CANCEL_WAIT 'PAC_4' INDEX = 41 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 
		SUMM_PARAM_[45] = SUMM_PARAM_[1] - SUMM_PARAM_[41]
		SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' kW'") 
		IF (SUMM_PARAM_[45] < 0) {SEND_TXT (KEYPAD [45], "'0.00 kW'")} ELSE {SEND_TXT (KEYPAD [45], "FORMAT('%5.2f',SUMM_PARAM_[45]), ' kW'")}
		} 
	
		Active (Function == 4 && Device == 3 && Address == 30843) : {INDEX = 42 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30844) : {INDEX = 42 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/1000 SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.2f',SUMM_PARAM_[INDEX]), ' A'") }
	
		Active (Function == 4 && Device == 3 && Address == 30851) : {INDEX = 43 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30852) : {INDEX = 43 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value  SUMM_PARAM_[INDEX] = SUMM_PARAM_[INDEX]/100  SEND_TXT (KEYPAD [INDEX], "FORMAT('%5.1f',SUMM_PARAM_[INDEX]), ' V'") }
	
		Active (Function == 4 && Device == 3 && Address == 30857) : {INDEX = 44 REGISTER_HI[INDEX] = Value}
		Active (Function == 4 && Device == 3 && Address == 30858) : {INDEX = 44 SUMM_PARAM_[INDEX] =  REGISTER_HI[INDEX] * 65536 + Value   SEND_TXT (KEYPAD [INDEX], ITOA(SUMM_PARAM_[INDEX])) }
	                                                     
	}
}

DEFINE_FUNCTION SEND_STR_DEVICE (INTEGER NUM_K)
{
	SWITCH (NUM_K)
	    {
	    CASE 1:
	    CASE 2:
	    CASE 3: {Call 'ModBus - Call Function' (4, 2 , REGISTER_STATUS[ NUM_K], 2)}
	    CASE 4:
	    CASE 5:
	    CASE 6: {Call 'ModBus - Call Function' (4, 4 , REGISTER_STATUS[ NUM_K], 2)}
	    CASE 7:
	    CASE 8:
	    CASE 9:
	    CASE 10:
	    CASE 11:
	    CASE 12:
	    CASE 13:
	    CASE 14:
	    CASE 15:
	    CASE 16:
	    CASE 17:
	    CASE 18:
	    CASE 19:
	    CASE 20:
	    CASE 21:
	    CASE 22:
	    CASE 23:
	    CASE 24:
	    CASE 25:
	    CASE 26:
	    CASE 27:
	    CASE 28:
	    CASE 29:
	    CASE 30:
	    CASE 31:
	    CASE 32:
	    CASE 33:
	    CASE 34:
	    CASE 35:
	    CASE 36:
	    CASE 37:
	    CASE 38:
	    CASE 39:
	    CASE 40: {Call 'ModBus - Call Function' (4, 3 , REGISTER_STATUS[ NUM_K], 2)}
	    CASE 41: {Call 'ModBus - Call Function' (4, 4 , REGISTER_STATUS[ NUM_K], 2)}
	    CASE 42: {Call 'ModBus - Call Function' (4, 3 , REGISTER_STATUS[ NUM_K], 2)}
	    CASE 43: {Call 'ModBus - Call Function' (4, 3 , REGISTER_STATUS[ NUM_K], 2)}
	    CASE 44: {Call 'ModBus - Call Function' (4, 3 , REGISTER_STATUS[ NUM_K], 2)}
	    }    

}


DEFINE_FUNCTION SEND_TXT (INTEGER NUM_BUTTON, CHAR TXT [40])
{
SEND_COMMAND MVP, "'^TXT-',itoa (NUM_BUTTON),',0,', TXT"
}

//-- СONNECT WITH IP DEVICE --------------------------------------------------------------------------------------------------------------------------------------------------
DEFINE_FUNCTION ConnectToDEVICE()
{if(DEVICE_OnLine=1){IP_CLIENT_CLOSE(DEVICE.Port)DEVICE_OnLine=0} WAIT 200 {IP_CLIENT_OPEN(DEVICE.Port,DEVICE_IP,DEVICE_Port,1)}}
//----------------------------------------------------------------------------------------------------------------------------------------------------

DEFINE_MODULE 'module Modbus Master (TCP)' mdl_Modbus (DEVICE, vdvModbus);

DEFINE_START 


DEFINE_EVENT

BUTTON_EVENT [MVP, BUTTON_[1]] {PUSH:{IF( OPROS_ON = 1 ) OPROS_ON = 0 else {OPROS_ON = 1 SELECT_I = 1} }}

BUTTON_EVENT [MVP, BUTTON_[2]] {PUSH:{ OPROS_ON_FIRST = 1 SELECT_I = 1}}





BUTTON_EVENT [MVP, KEYPAD] 
{PUSH:{                
	LOCAL_VAR NUM_KEYPAD
	
	NUM_KEYPAD = GET_LAST (KEYPAD)
	
	SET_PULSE_TIME (5) PULSE [MVP, KEYPAD[NUM_KEYPAD]]
	SEND_STR_DEVICE (NUM_KEYPAD)
	}}


//-- СONNECT WITH IP DEVICE --------------------------------------------------------------------------------------------------------------------------------------------------
DATA_EVENT[DEVICE]
{ 
ONLINE:{  DEVICE_OnLine=1 }  
OFFLINE:{ DEVICE_OnLine=0 IP_CLIENT_CLOSE(DEVICE.Port) ConnectToDEVICE() }
ONERROR:{ if(DEVICE_OnLine=1){DEVICE_OnLine=0 IP_CLIENT_CLOSE(DEVICE.Port)}ConnectToDEVICE() }
}

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
				// TODO : Didn't receive answer On command/request
			}
			Active (RemoveCmdLeft(Data.Text, 'REQUEST_ERROR = ')):
			{
				// TODO : See error code in Data.Text
			}
			Active (RemoveCmdLeft(Data.Text, 'CRC_ERROR = ')):
			{
				// TODO : Wrong answer packet in Hex is in Data.Text
			}
		}
	}
	ONLINE:
	{
		// *************************************************************************************
		// Заменить на правильный код модуля, иначе система будет перезагружаться каждые 5 минут
		// *************************************************************************************
		Send_Command Data.Device, 'SERIAL = 7202';//  
		// Задание устройства, на которое будут дублироваться все сообщения, посылаемые модулем в окно Диагностики.
		// По умолчанию дублирование отключено
		// Для отключения дублирования послать адрес устройтва 0:1:0 : Send_Command Data.Device, 'VDVDEBUG = 0:1:0';
		Send_Command Data.Device, "'VDVDEBUG = ', itoa(vdvDebug.Number), ':', itoa(vdvDebug.Port), ':', itoa(vdvDebug.System)"; // Включить дублирование диагностических сообщений на адрес vdvDebug
		// Включение/выключение режима отображания расширенной отладочной информации.
		// Send_Command Data.Device, "'DEBUG = OFF'"; // Выключить режим отображания расширенной отладочной информации
		Send_Command Data.Device, "'DEBUG = ON'"; // Включить режим отображания расширенной отладочной информации
		// Задание строки, с которой будут начинаться все сообщения в окне Диагностики от данного модуля
		// Значение по умолчанию: Modbus
		// Например, 'Modbus[1]: Connecton ON'
		// Send_Command Data.Device, 'DEBUGSTRING = Modbus[1]'; // Поменять начало на "Modbus[1]"
		
		
		// *****************************************************************************************************************************************
		// Задание интервала ожидания ответа от устройства (в миллисекундах!!!)
		// *****************************************************************************************************************************************
		// Значение может быть от 100 и более. При значении менее 100мс оно автоматически заменяется на 100мс.
		// Значение по умолчанию: 1000мс
		// Send_Command Data.Device, "'ANSWER_TIMEOUT = 2000'";       // Ожидать ответ 2с, после чего считается, что пакет потерялся
		Send_Command Data.Device, "'ANSWER_TIMEOUT = 1000'";
	}
}



DEFINE_PROGRAM

if (a=0) {a=1 wait 15 'start'{ConnectToDEVICE()}}


IF (DEVICE_OnLine=1 ) 
{

WAIT 50
{
Call 'ModBus - Call Function' (4, 2 , 30775 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30775 , 2); // 
Call 'ModBus - Call Function' (4, 4 , 30775 , 2); WAIT 20 'PAC_4' {SUMM_PARAM_[41] = 0 SEND_TXT (KEYPAD [41], "FORMAT('%5.2f',SUMM_PARAM_[41]), ' kW'") SEND_TXT (KEYPAD [45], "'0.00 kW'")}
Call 'ModBus - Call Function' (4, 3 , 30885 , 2); // 

Call 'ModBus - Call Function' (4, 3 , 30887 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30889 , 2); // 
                                 
Call 'ModBus - Call Function' (4, 3 , 30843 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30903 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30905 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30907 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30851 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30857 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30903 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30905 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30907 , 2); // 
Call 'ModBus - Call Function' (4, 3 , 30845 , 2); // 
 }                                 
}

WAIT 3
{
[MVP, BUTTON_[1]] = (OPROS_ON = 1)

[MVP, BUTTON_[3]] = (SUMM_PARAM_[42] < 0) // Зеленая
[MVP, BUTTON_[4]] = (SUMM_PARAM_[42] >= 0) // Красная

[MVP, BUTTON_[5]] = (SUMM_PARAM_[41] > 0) // 




[MVP, BUTTON_[6]] = ((SUMM_PARAM_[28] < 100 && [IO, 5]) || (SUMM_PARAM_[29] < 100 && [IO, 5]) || (SUMM_PARAM_[30] < 100 && [IO, 5]))// Фаза А, B, C

[MVP, BUTTON_[7]] = (SUMM_PARAM_[41] = 0 && SUMM_PARAM_[42] > 0) // 

[MVP, BUTTON_[8]] = (SUMM_PARAM_[42] >= 0) // Красная



[MVP, BUTTON_[11]] = (SUMM_PARAM_[46] =  295) // 
[MVP, BUTTON_[12]] = (SUMM_PARAM_[46] =  381) // 
[MVP, BUTTON_[13]] = (SUMM_PARAM_[46] =  443) // 
[MVP, BUTTON_[14]] = (SUMM_PARAM_[46] =  565) // 
                                      
}


IF (DEVICE_OnLine=1 && OPROS_ON = 1)
{

IF (OPROS_ON_FIRST = 1) {OPROS_ON_FIRST = 0}
WAIT 5
	{
        IF (SELECT_I > LENGTH_ARRAY( REGISTER_STATUS) ) {SELECT_I = 1 } ELSE {SELECT_I = SELECT_I + 1 }
	SEND_STR_DEVICE (SELECT_I)
        }
}
	
IF (DEVICE_OnLine=1 && !OPROS_ON = 1 && OPROS_ON_FIRST = 1)
{
WAIT 5
	{
        IF (SELECT_I > LENGTH_ARRAY( REGISTER_STATUS) ) {OPROS_ON_FIRST = 0 SELECT_I = 1} ELSE {SELECT_I = SELECT_I + 1 }
	SEND_STR_DEVICE (SELECT_I)
        }
}

