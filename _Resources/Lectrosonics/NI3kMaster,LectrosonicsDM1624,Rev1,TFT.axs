PROGRAM_NAME='NI2kMaster,LectrosonicsDM1624,Rev1,TFT'
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
// NI2000
// RS232
dvDM1624       =  5001:1:0

dvTP1aMainGen  = 10128:1:0
vdvTP1aMainGen = 33128:1:0

DEFINE_COMBINE 
(vdvTP1aMainGen,dvTP1aMainGen)

#INCLUDE 'AMX_QUEUE.AXI'

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT
INTEGER UP_INC   = 1
INTEGER DN_INC   = 1
LONG ltlQUERYINPUT  = 2002
LONG ltlQUERYOUTPUT = 2003
LONG ltlQUERYMATRIX = 2004

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE
STRUCTURE _uMATRIX
{
  INTEGER nMIXMODE 
  INTEGER nMIXMUTE 
  SINTEGER snCurLvl
  SINTEGER snPrevLvl
} 

STRUCTURE _uINPUT
{
  INTEGER nMUTE 
  INTEGER nPHANTOMPWR
  INTEGER nPHASE
  SINTEGER snCurGain
  SINTEGER snPrevGain
  SINTEGER snCurTrim
  SINTEGER snPrevTrim   
}

STRUCTURE _uOUTPUT
{
  INTEGER nMUTE
  INTEGER nSIGNALSRC
  SINTEGER snCurGain
  SINTEGER snPrevGain 
  SINTEGER snCurTrim
  SINTEGER snPrevTrim 
  INTEGER nSIGNALTYPE
}  
(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE 
PERSISTENT _uMATRIX uMATRIX[384]

PERSISTENT _uINPUT uINPUT[16]

PERSISTENT _uOUTPUT uOUTPUT[24]

LONG ltlQUERYMATRIXARRAY[] = {100,100,100,100}

LONG ltlQUERYINPUTARRAY[] = {100,100,100,100,100,100}

LONG ltlQUERYOUTPUTARRAY[] = {100,100,100,100,100,100,100}

INTEGER nPreset
INTEGER nPRESETHELD

DEV dvARRAYTPGen[] ={vdvTP1aMainGen}

CHAR dvDM1624_BUFF[255]

INTEGER nCUR_CTL_INPUT

INTEGER nCUR_CTL_OUTPUT

INTEGER nCUR_CTL_INPUT_MATRIX

INTEGER nCUR_CTL_OUTPUT_MATRIX

INTEGER nCUR_CTL_MATRIX

INTEGER nQUERYMATRIX
 
INTEGER nQUERYINPUT

INTEGER nQUERYOUTPUT

INTEGER nQUERY
 
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
// FUNCTION: fPROCESS_DM1624_RX
// PURPOSE: Process the received command  
// PARAMETERS:  
(***********************************************************)
DEFINE_FUNCTION fPROCESS_DM1624_RX()
{
  LOCAL_VAR CHAR sTRASH[5]  
  LOCAL_VAR INTEGER nLNGTH
  
  // Future polling
  WHILE(FIND_STRING(dvDM1624_BUFF,"'OK'",1))
  {
    sTRASH = REMOVE_STRING(dvDM1624_BUFF,"'OK '",1)
    nLNGTH = (FIND_STRING(dvDM1624_BUFF,"$0D",1) - 1)
    
    SWITCH(nQUERY)
    { 
      CASE 11:{uMATRIX[nCUR_CTL_INPUT_MATRIX * nCUR_CTL_OUTPUT_MATRIX].nMIXMODE = ATOI(LEFT_STRING(dvDM1624_BUFF,1)) + 1 TIMELINE_RESTART(ltlQUERYMATRIX)}
      CASE 12:{uMATRIX[nCUR_CTL_INPUT_MATRIX * nCUR_CTL_OUTPUT_MATRIX].nMIXMUTE = ATOI(LEFT_STRING(dvDM1624_BUFF,1)) TIMELINE_RESTART(ltlQUERYMATRIX)}
      CASE 13:{uMATRIX[nCUR_CTL_INPUT_MATRIX * nCUR_CTL_OUTPUT_MATRIX].snCurLvl = ATOI(LEFT_STRING(dvDM1624_BUFF,FIND_STRING(dvDM1624_BUFF,"$0D",1) - 1)) TIMELINE_RESTART(ltlQUERYMATRIX)}
      CASE 14:{} 
    } 
     
    SWITCH(nQUERY)
    {  
      CASE 21:{uINPUT[nCUR_CTL_INPUT].nMUTE       = ATOI(LEFT_STRING(dvDM1624_BUFF,1)) TIMELINE_RESTART(ltlQUERYINPUT)} 
      CASE 22:{uINPUT[nCUR_CTL_INPUT].nPHANTOMPWR = ATOI(LEFT_STRING(dvDM1624_BUFF,1)) TIMELINE_RESTART(ltlQUERYINPUT)}
      CASE 23:{uINPUT[nCUR_CTL_INPUT].nPHASE      = ATOI(LEFT_STRING(dvDM1624_BUFF,1)) TIMELINE_RESTART(ltlQUERYINPUT)}
      CASE 24:{uINPUT[nCUR_CTL_INPUT].snCurTrim   = ATOI(LEFT_STRING(dvDM1624_BUFF,FIND_STRING(dvDM1624_BUFF,"$0D",1) - 1)) TIMELINE_RESTART(ltlQUERYINPUT)}
      CASE 25:{uINPUT[nCUR_CTL_INPUT].snCurGain   = ATOI(LEFT_STRING(dvDM1624_BUFF,FIND_STRING(dvDM1624_BUFF,"$0D",1) - 1))  TIMELINE_RESTART(ltlQUERYINPUT)}
      CASE 26:{} 
    } 
     
    SWITCH(nQUERY)
    {  
      CASE 31:{uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALSRC   = ATOI(LEFT_STRING(dvDM1624_BUFF,1)) + 1 TIMELINE_RESTART(ltlQUERYOUTPUT)}//'outsrc'
      CASE 32:{uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALTYPE  = ATOI(LEFT_STRING(dvDM1624_BUFF,1)) TIMELINE_RESTART(ltlQUERYOUTPUT)}//'outmic'
      CASE 33:{uOUTPUT[nCUR_CTL_OUTPUT].nMUTE        = ATOI(LEFT_STRING(dvDM1624_BUFF,1)) TIMELINE_RESTART(ltlQUERYOUTPUT)}//'outmt'
      CASE 34:{uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim    = ATOI(LEFT_STRING(dvDM1624_BUFF,FIND_STRING(dvDM1624_BUFF,"$0D",1) - 1)) TIMELINE_RESTART(ltlQUERYOUTPUT)}//'rpoutgn'
      CASE 35:{uOUTPUT[nCUR_CTL_OUTPUT].snCurGain    = ATOI(LEFT_STRING(dvDM1624_BUFF,FIND_STRING(dvDM1624_BUFF,"$0D",1) - 1)) TIMELINE_RESTART(ltlQUERYOUTPUT)}//'outgn'
      CASE 36:{nPreset = ATOI(LEFT_STRING(dvDM1624_BUFF,FIND_STRING(dvDM1624_BUFF,"$0D",1) - 1)) TIMELINE_RESTART(ltlQUERYOUTPUT)}//'actpre'
      CASE 37:{}
    }
    CLEAR_BUFFER dvDM1624_BUFF
  }  
}

(***********************************************************)
// FUNCTION: fPROCESS_DM1624_RX
// PURPOSE: Process the received command  
// PARAMETERS:                      
(***********************************************************)
DEFINE_FUNCTION fLECNETSND(CHAR sCOMMAND[])
{ 
  CALL 'QUEUE ADD' (dvDM1624,"$18,sCOMMAND,$0D",100,0)
}  

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START 
CREATE_BUFFER dvDM1624,dvDM1624_BUFF  

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
// DATA EVENTS
DATA_EVENT[dvDM1624]
{
  ONLINE:
  {
    SEND_COMMAND DATA.DEVICE,"'XOFF'"
    SEND_COMMAND DATA.DEVICE,"'HSOFF'"
    SEND_COMMAND DATA.DEVICE,"'SET BAUD 57600,N,8,1 485 DISABLE'"
  }   
  STRING:
  {
    fPROCESS_DM1624_RX()
  }
} 
  
DATA_EVENT[dvTP1aMainGen]
{
  ONLINE:
  {
  }
}  
     
     
     
// BUTTON EVENTS
// Matrix 
// Auto Mix mode
BUTTON_EVENT[dvARRAYTPGen,1] // Auto  
BUTTON_EVENT[dvARRAYTPGen,2] // Direct
BUTTON_EVENT[dvARRAYTPGen,3] // Override
BUTTON_EVENT[dvARRAYTPGen,4] // Background
{
  PUSH:            
  { 
    IF(nCUR_CTL_MATRIX)
    {   
      SWITCH(BUTTON.INPUT.CHANNEL)
      {
        CASE 1:
        { 
          fLECNETSND("'xpmode(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                        ITOA(nCUR_CTL_OUTPUT_MATRIX),')=3'")
          uMATRIX[nCUR_CTL_MATRIX].nMIXMODE = 4
        } 
        CASE 2:
        { 
          fLECNETSND("'xpmode(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                        ITOA(nCUR_CTL_OUTPUT_MATRIX),')=0'") 
          uMATRIX[nCUR_CTL_MATRIX].nMIXMODE = 1
        }
        CASE 3:
        {
          fLECNETSND("'xpmode(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                        ITOA(nCUR_CTL_OUTPUT_MATRIX),')=1'") 
          uMATRIX[nCUR_CTL_MATRIX].nMIXMODE = 2
        }
        CASE 4:
        {
          fLECNETSND("'xpmode(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                        ITOA(nCUR_CTL_OUTPUT_MATRIX),')=2'")
          uMATRIX[nCUR_CTL_MATRIX].nMIXMODE = 3
        }
      }
    }    
  }
} 
    
// Crosspoint gain up -70 to +20
BUTTON_EVENT[dvARRAYTPGen,6]  
{
  PUSH:            
  {
    IF(nCUR_CTL_MATRIX)
    { 
      IF(uMATRIX[nCUR_CTL_MATRIX].nMIXMUTE)   (* If we are currently muted then unmute *)
      { 
        uMATRIX[nCUR_CTL_MATRIX].snCurLvl = uMATRIX[nCUR_CTL_MATRIX].snPrevLvl
        
        fLECNETSND("'xpmt(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                          ITOA(nCUR_CTL_OUTPUT_MATRIX),')=0'")
                          
        uMATRIX[nCUR_CTL_MATRIX].nMIXMUTE = 0
      }
      ELSE
      {
        IF((uMATRIX[nCUR_CTL_MATRIX].snCurLvl + UP_INC) >= 20)
        {
          uMATRIX[nCUR_CTL_MATRIX].snCurLvl = 20
        }
        ELSE
        {
          uMATRIX[nCUR_CTL_MATRIX].snCurLvl = (uMATRIX[nCUR_CTL_MATRIX].snCurLvl + UP_INC) 
        } 
      }  
      uMATRIX[nCUR_CTL_MATRIX].snPrevLvl = uMATRIX[nCUR_CTL_MATRIX].snCurLvl  
      
      fLECNETSND("'xpgn(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                          ITOA(nCUR_CTL_OUTPUT_MATRIX),')=',
                          ITOA(uMATRIX[nCUR_CTL_MATRIX].snCurLvl)")
    }                      
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_MATRIX)
    { 
      IF((uMATRIX[nCUR_CTL_MATRIX].snCurLvl + UP_INC) >= 20)
      {
        uMATRIX[nCUR_CTL_MATRIX].snCurLvl = 20
      }
      ELSE
      {
        uMATRIX[nCUR_CTL_MATRIX].snCurLvl = (uMATRIX[nCUR_CTL_MATRIX].snCurLvl + UP_INC) 
      } 
     
      uMATRIX[nCUR_CTL_MATRIX].snPrevLvl = uMATRIX[nCUR_CTL_MATRIX].snCurLvl  
      
      fLECNETSND("'xpgn(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                          ITOA(nCUR_CTL_OUTPUT_MATRIX),')=',
                          ITOA(uMATRIX[nCUR_CTL_MATRIX].snCurLvl)") 
    }                      
  }
}    

// Crosspoint gain Down -70 to +20
BUTTON_EVENT[dvARRAYTPGen,7]  
{
  PUSH:            
  {
    IF(nCUR_CTL_MATRIX)
    {    
      IF(uMATRIX[nCUR_CTL_MATRIX].nMIXMUTE)   (* If we are currently muted then unmute *)
      { 
        uMATRIX[nCUR_CTL_MATRIX].snCurLvl = uMATRIX[nCUR_CTL_MATRIX].snPrevLvl 
        
        fLECNETSND("'xpmt(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                          ITOA(nCUR_CTL_OUTPUT_MATRIX),')=0'")
                          
        uMATRIX[nCUR_CTL_MATRIX].nMIXMUTE = 0
      }
      ELSE
      {
        IF((uMATRIX[nCUR_CTL_MATRIX].snCurLvl - DN_INC) <= -70)
        {
          uMATRIX[nCUR_CTL_MATRIX].snCurLvl = -70
        }
        ELSE
        {
          uMATRIX[nCUR_CTL_MATRIX].snCurLvl = (uMATRIX[nCUR_CTL_MATRIX].snCurLvl - DN_INC) 
        } 
      }  
      uMATRIX[nCUR_CTL_MATRIX].snPrevLvl = uMATRIX[nCUR_CTL_MATRIX].snCurLvl  
      
      fLECNETSND("'xpgn(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                          ITOA(nCUR_CTL_OUTPUT_MATRIX),')=',
                          ITOA(uMATRIX[nCUR_CTL_MATRIX].snCurLvl)") 
    }                      
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_MATRIX)
    { 
      IF((uMATRIX[nCUR_CTL_MATRIX].snCurLvl - DN_INC) <= -70)
      {
        uMATRIX[nCUR_CTL_MATRIX].snCurLvl = -70
      }
      ELSE
      {
        uMATRIX[nCUR_CTL_MATRIX].snCurLvl = (uMATRIX[nCUR_CTL_MATRIX].snCurLvl - DN_INC) 
      } 
     
      uMATRIX[nCUR_CTL_MATRIX].snPrevLvl = uMATRIX[nCUR_CTL_MATRIX].snCurLvl  
      
      fLECNETSND("'xpgn(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                          ITOA(nCUR_CTL_OUTPUT_MATRIX),')=',
                          ITOA(uMATRIX[nCUR_CTL_MATRIX].snCurLvl)")      
    }                      
  }
} 

// Mute
BUTTON_EVENT[dvARRAYTPGen,5]  
{
  PUSH:            
  { 
    IF(nCUR_CTL_MATRIX)
    { 
      uMATRIX[nCUR_CTL_MATRIX].nMIXMUTE = !uMATRIX[nCUR_CTL_MATRIX].nMIXMUTE
      
      IF(uMATRIX[nCUR_CTL_MATRIX].nMIXMUTE)
      {
        fLECNETSND("'xpmt(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                        ITOA(nCUR_CTL_OUTPUT_MATRIX),')=1'")
                        
        uMATRIX[nCUR_CTL_MATRIX].snPrevLvl = uMATRIX[nCUR_CTL_MATRIX].snCurLvl
        uMATRIX[nCUR_CTL_MATRIX].snCurLvl = -70
        fLECNETSND("'xpgn(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                        ITOA(nCUR_CTL_OUTPUT_MATRIX),')=',
                        ITOA(uMATRIX[nCUR_CTL_MATRIX].snCurLvl)") 
                         
      }
      ELSE
      {
        fLECNETSND("'xpmt(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                        ITOA(nCUR_CTL_OUTPUT_MATRIX),')=0'")   
                        
        uMATRIX[nCUR_CTL_MATRIX].snCurLvl = uMATRIX[nCUR_CTL_MATRIX].snPrevLvl 
        
        fLECNETSND("'xpgn(',ITOA(nCUR_CTL_INPUT_MATRIX),',',
                        ITOA(nCUR_CTL_OUTPUT_MATRIX),')=',
                        ITOA(uMATRIX[nCUR_CTL_MATRIX].snCurLvl)")                
      }
    }  
  }
}
   
// Inputs 1-16
BUTTON_EVENT[dvARRAYTPGen,101]  
BUTTON_EVENT[dvARRAYTPGen,102]  
BUTTON_EVENT[dvARRAYTPGen,103]  
BUTTON_EVENT[dvARRAYTPGen,104]  
BUTTON_EVENT[dvARRAYTPGen,105]  
BUTTON_EVENT[dvARRAYTPGen,106]  
BUTTON_EVENT[dvARRAYTPGen,107]  
BUTTON_EVENT[dvARRAYTPGen,108]  
BUTTON_EVENT[dvARRAYTPGen,109]  
BUTTON_EVENT[dvARRAYTPGen,110]  
BUTTON_EVENT[dvARRAYTPGen,111]  
BUTTON_EVENT[dvARRAYTPGen,112]  
BUTTON_EVENT[dvARRAYTPGen,113]
BUTTON_EVENT[dvARRAYTPGen,114]  
BUTTON_EVENT[dvARRAYTPGen,115]  
BUTTON_EVENT[dvARRAYTPGen,116]  
{
  PUSH:            
  { 
    nCUR_CTL_INPUT_MATRIX = (BUTTON.INPUT.CHANNEL - 100) 
    nCUR_CTL_MATRIX = (nCUR_CTL_INPUT_MATRIX * nCUR_CTL_OUTPUT_MATRIX)
    
    IF(!TIMELINE_ACTIVE(ltlQUERYMATRIX))
    {
      TIMELINE_CREATE(ltlQUERYMATRIX,ltlQUERYMATRIXARRAY,4,TIMELINE_RELATIVE,TIMELINE_ONCE)
    }
  }
}        

// Outputs 1-24
BUTTON_EVENT[dvARRAYTPGen,121]  
BUTTON_EVENT[dvARRAYTPGen,122]  
BUTTON_EVENT[dvARRAYTPGen,123]  
BUTTON_EVENT[dvARRAYTPGen,124]  
BUTTON_EVENT[dvARRAYTPGen,125]  
BUTTON_EVENT[dvARRAYTPGen,126]  
BUTTON_EVENT[dvARRAYTPGen,127]  
BUTTON_EVENT[dvARRAYTPGen,128]  
BUTTON_EVENT[dvARRAYTPGen,129]  
BUTTON_EVENT[dvARRAYTPGen,130]  
BUTTON_EVENT[dvARRAYTPGen,131]  
BUTTON_EVENT[dvARRAYTPGen,132]  
BUTTON_EVENT[dvARRAYTPGen,133]
BUTTON_EVENT[dvARRAYTPGen,134]  
BUTTON_EVENT[dvARRAYTPGen,135]  
BUTTON_EVENT[dvARRAYTPGen,136]  
BUTTON_EVENT[dvARRAYTPGen,137]  
BUTTON_EVENT[dvARRAYTPGen,138]  
BUTTON_EVENT[dvARRAYTPGen,139]
BUTTON_EVENT[dvARRAYTPGen,140]  
BUTTON_EVENT[dvARRAYTPGen,141]  
BUTTON_EVENT[dvARRAYTPGen,142]  
BUTTON_EVENT[dvARRAYTPGen,143]  
BUTTON_EVENT[dvARRAYTPGen,144]  
{
  PUSH:            
  {  
    nCUR_CTL_OUTPUT_MATRIX = (BUTTON.INPUT.CHANNEL - 120)
    nCUR_CTL_MATRIX = (nCUR_CTL_INPUT_MATRIX * nCUR_CTL_OUTPUT_MATRIX)
      
    IF(!TIMELINE_ACTIVE(ltlQUERYMATRIX))
    {
      TIMELINE_CREATE(ltlQUERYMATRIX,ltlQUERYMATRIXARRAY,4,TIMELINE_RELATIVE,TIMELINE_ONCE)
    } 
  }
}  

TIMELINE_EVENT[ltlQUERYMATRIX]
{  
  nQUERYMATRIX = (TIMELINE.SEQUENCE)
  nQUERY = (TIMELINE.SEQUENCE + 10)  
  
  SWITCH(nQUERY)
  {
    CASE 11:{fLECNETSND("'xpmode(',ITOA(nCUR_CTL_INPUT_MATRIX),',',ITOA(nCUR_CTL_OUTPUT_MATRIX),')?'") TIMELINE_PAUSE(ltlQUERYMATRIX)}
    CASE 12:{fLECNETSND("'xpmt(',ITOA(nCUR_CTL_INPUT_MATRIX),',',ITOA(nCUR_CTL_OUTPUT_MATRIX),')?'") TIMELINE_PAUSE(ltlQUERYMATRIX)}
    CASE 13:{fLECNETSND("'xpgn(',ITOA(nCUR_CTL_INPUT_MATRIX),',',ITOA(nCUR_CTL_OUTPUT_MATRIX),')?'") TIMELINE_PAUSE(ltlQUERYMATRIX)}
    CASE 14:{nQUERY = 0}
  }
}
 
 
 
// Input parameter changes
// Phantom Power
BUTTON_EVENT[dvARRAYTPGen,8]  
{
  PUSH:            
  { 
    IF(nCUR_CTL_INPUT)
    { 
      uINPUT[nCUR_CTL_INPUT].nPHANTOMPWR = !uINPUT[nCUR_CTL_INPUT].nPHANTOMPWR
      
      IF(uINPUT[nCUR_CTL_INPUT].nPHANTOMPWR)
      {
        fLECNETSND("'inph(',ITOA(nCUR_CTL_INPUT),')=1'")  
      }
      ELSE
      {
        fLECNETSND("'inph(',ITOA(nCUR_CTL_INPUT),')=0'")
      }
    }   
  }
} 

// Phase invert
BUTTON_EVENT[dvARRAYTPGen,9]  
{
  PUSH:            
  { 
    IF(nCUR_CTL_INPUT)
    { 
      uINPUT[nCUR_CTL_INPUT].nPHASE = !uINPUT[nCUR_CTL_INPUT].nPHASE
      
      IF(uINPUT[nCUR_CTL_INPUT].nPHASE)
      {
        fLECNETSND("'iniv(',ITOA(nCUR_CTL_INPUT),')=1'")  
      }
      ELSE
      {
        fLECNETSND("'iniv(',ITOA(nCUR_CTL_INPUT),')=0'")
      }
    }   
  }

} 

// Mute
BUTTON_EVENT[dvARRAYTPGen,10]  
{
  PUSH:            
  { 
    IF(nCUR_CTL_INPUT)
    { 
      uINPUT[nCUR_CTL_INPUT].nMUTE = !uINPUT[nCUR_CTL_INPUT].nMUTE
      
      IF(uINPUT[nCUR_CTL_INPUT].nMUTE)
      {
        fLECNETSND("'inmt(',ITOA(nCUR_CTL_INPUT),')=1'")  
      }
      ELSE
      {
        fLECNETSND("'inmt(',ITOA(nCUR_CTL_INPUT),')=0'")
      }
    }    
  }
} 

// Input rear panel trim up -30 to 0
BUTTON_EVENT[dvARRAYTPGen,11]  
{
  PUSH:            
  {
    IF(nCUR_CTL_INPUT)
    {
      IF((uINPUT[nCUR_CTL_INPUT].snCurTrim + UP_INC) >= 0)
      {
        uINPUT[nCUR_CTL_INPUT].snCurTrim = 0
      }
      ELSE
      {
        uINPUT[nCUR_CTL_INPUT].snCurTrim = (uINPUT[nCUR_CTL_INPUT].snCurTrim + UP_INC) 
      } 
      uINPUT[nCUR_CTL_INPUT].snPrevTrim = uINPUT[nCUR_CTL_INPUT].snCurTrim  
      
      fLECNETSND("'rpingn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uINPUT[nCUR_CTL_INPUT].snCurTrim)")
    }  
  }
  HOLD[1,REPEAT]:
  {
    IF(nCUR_CTL_INPUT)
    { 
      IF((uINPUT[nCUR_CTL_INPUT].snCurTrim + UP_INC) >= 0)
      {
        uINPUT[nCUR_CTL_INPUT].snCurTrim = 0
      }
      ELSE
      {
        uINPUT[nCUR_CTL_INPUT].snCurTrim = (uINPUT[nCUR_CTL_INPUT].snCurTrim + UP_INC) 
      } 
     
      uINPUT[nCUR_CTL_INPUT].snPrevTrim = uINPUT[nCUR_CTL_INPUT].snCurTrim  
      
      fLECNETSND("'rpingn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uINPUT[nCUR_CTL_INPUT].snCurTrim)") 
    }  
  }
} 

// Input rear panel trim down -30 to 0
BUTTON_EVENT[dvARRAYTPGen,12]  
{
  PUSH:            
  {
    IF(nCUR_CTL_INPUT)
    {
      IF((uINPUT[nCUR_CTL_INPUT].snCurTrim - DN_INC) <= -30)
      {
        uINPUT[nCUR_CTL_INPUT].snCurTrim = -30
      }
      ELSE
      {
        uINPUT[nCUR_CTL_INPUT].snCurTrim = (uINPUT[nCUR_CTL_INPUT].snCurTrim - DN_INC) 
      } 
      uINPUT[nCUR_CTL_INPUT].snPrevTrim = uINPUT[nCUR_CTL_INPUT].snCurTrim  
      
      fLECNETSND("'rpingn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uINPUT[nCUR_CTL_INPUT].snCurTrim)")
    }  
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_INPUT)
    {
      IF((uINPUT[nCUR_CTL_INPUT].snCurTrim - DN_INC) <= -30)
      {
        uINPUT[nCUR_CTL_INPUT].snCurTrim = -30
      }
      ELSE
      {
        uINPUT[nCUR_CTL_INPUT].snCurTrim = (uINPUT[nCUR_CTL_INPUT].snCurTrim - DN_INC) 
      } 
     
      uINPUT[nCUR_CTL_INPUT].snPrevTrim = uINPUT[nCUR_CTL_INPUT].snCurTrim  
      
      fLECNETSND("'rpingn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uINPUT[nCUR_CTL_INPUT].snCurTrim)")  
    }  
  }
}
 
// Input gain up -10 to +60
BUTTON_EVENT[dvARRAYTPGen,23]  
{
  PUSH:            
  {
    IF(nCUR_CTL_INPUT)
    {
      IF((uINPUT[nCUR_CTL_INPUT].snCurGain + UP_INC) >= 60)
      {
        uINPUT[nCUR_CTL_INPUT].snCurGain = 60
      }
      ELSE
      {
        uINPUT[nCUR_CTL_INPUT].snCurGain = (uINPUT[nCUR_CTL_INPUT].snCurGain + UP_INC) 
      } 
      
      uINPUT[nCUR_CTL_INPUT].snPrevGain = uINPUT[nCUR_CTL_INPUT].snCurGain  
      
      fLECNETSND("'ingn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uINPUT[nCUR_CTL_INPUT].snCurGain)") 
    }  
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_INPUT)
    {
      IF((uINPUT[nCUR_CTL_INPUT].snCurGain + UP_INC) >= 60)
      {
        uINPUT[nCUR_CTL_INPUT].snCurGain = 60
      }
      ELSE
      {
        uINPUT[nCUR_CTL_INPUT].snCurGain = (uINPUT[nCUR_CTL_INPUT].snCurGain + UP_INC) 
      } 
     
      uINPUT[nCUR_CTL_INPUT].snPrevGain = uINPUT[nCUR_CTL_INPUT].snCurGain  
      
      fLECNETSND("'ingn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uINPUT[nCUR_CTL_INPUT].snCurGain)")
    }  
  }
} 

// Input gain Down -10 to +60
BUTTON_EVENT[dvARRAYTPGen,24]  
{
  PUSH:            
  { 
    IF(nCUR_CTL_INPUT)
    {
      IF((uINPUT[nCUR_CTL_INPUT].snCurGain - DN_INC) <= -10)
      {
        uINPUT[nCUR_CTL_INPUT].snCurGain = -10
      }
      ELSE
      {
        uINPUT[nCUR_CTL_INPUT].snCurGain = (uINPUT[nCUR_CTL_INPUT].snCurGain - DN_INC) 
      } 
      
      uINPUT[nCUR_CTL_INPUT].snPrevGain = uINPUT[nCUR_CTL_INPUT].snCurGain  
      
      fLECNETSND("'ingn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uINPUT[nCUR_CTL_INPUT].snCurGain)") 
    }  
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_INPUT)
    {
      IF((uINPUT[nCUR_CTL_INPUT].snCurGain - DN_INC) <= -10)
      {
        uINPUT[nCUR_CTL_INPUT].snCurGain = -10
      }
      ELSE
      {
        uINPUT[nCUR_CTL_INPUT].snCurGain = (uINPUT[nCUR_CTL_INPUT].snCurGain - DN_INC) 
      } 
     
      uINPUT[nCUR_CTL_INPUT].snPrevGain = uINPUT[nCUR_CTL_INPUT].snCurGain  
      
      fLECNETSND("'ingn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uINPUT[nCUR_CTL_INPUT].snCurGain)")
    }  
  }
}  

// Inputs 1-16
BUTTON_EVENT[dvARRAYTPGen,151]  
BUTTON_EVENT[dvARRAYTPGen,152]  
BUTTON_EVENT[dvARRAYTPGen,153]  
BUTTON_EVENT[dvARRAYTPGen,154]  
BUTTON_EVENT[dvARRAYTPGen,155]  
BUTTON_EVENT[dvARRAYTPGen,156]  
BUTTON_EVENT[dvARRAYTPGen,157]  
BUTTON_EVENT[dvARRAYTPGen,158]  
BUTTON_EVENT[dvARRAYTPGen,159]  
BUTTON_EVENT[dvARRAYTPGen,160]  
BUTTON_EVENT[dvARRAYTPGen,161]  
BUTTON_EVENT[dvARRAYTPGen,162]  
BUTTON_EVENT[dvARRAYTPGen,163]
BUTTON_EVENT[dvARRAYTPGen,164]  
BUTTON_EVENT[dvARRAYTPGen,165]  
BUTTON_EVENT[dvARRAYTPGen,166]  
{
  PUSH:            
  {  
    nCUR_CTL_INPUT = (BUTTON.INPUT.CHANNEL - 150)
    IF(!TIMELINE_ACTIVE(ltlQUERYINPUT))
    {
      TIMELINE_CREATE(ltlQUERYINPUT,ltlQUERYINPUTARRAY,6,TIMELINE_RELATIVE,TIMELINE_ONCE)
    } 
  }
}  

TIMELINE_EVENT[ltlQUERYINPUT]
{  
  nQUERYINPUT = (TIMELINE.SEQUENCE)
  nQUERY = (TIMELINE.SEQUENCE + 20)
   
  SWITCH(nQUERY)
  {
    CASE 21:{fLECNETSND("'inmt(',ITOA(nCUR_CTL_INPUT),')?'") TIMELINE_PAUSE(ltlQUERYINPUT)}
    CASE 22:{fLECNETSND("'inph(',ITOA(nCUR_CTL_INPUT),')?'") TIMELINE_PAUSE(ltlQUERYINPUT)}
    CASE 23:{fLECNETSND("'iniv(',ITOA(nCUR_CTL_INPUT),')?'") TIMELINE_PAUSE(ltlQUERYINPUT)}
    CASE 24:{fLECNETSND("'rpingn(',ITOA(nCUR_CTL_INPUT),')?'") TIMELINE_PAUSE(ltlQUERYINPUT)}
    CASE 25:{fLECNETSND("'ingn(',ITOA(nCUR_CTL_INPUT),')?'") TIMELINE_PAUSE(ltlQUERYINPUT)}
    CASE 26:{nQUERY = 0} 
  }
}



 
 
 
// Output parameter changes 
// Output signal source
BUTTON_EVENT[dvARRAYTPGen,13] // Matrix
BUTTON_EVENT[dvARRAYTPGen,14] // Pink noise
BUTTON_EVENT[dvARRAYTPGen,15] // Tone 1k
{
  PUSH:            
  {
    IF(nCUR_CTL_OUTPUT)
    { 
      uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALSRC = (BUTTON.INPUT.CHANNEL - 13 + 1)
      fLECNETSND("'outsrc(',ITOA(nCUR_CTL_OUTPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALSRC)")
    }     
  }
}

// MIC / LINE
BUTTON_EVENT[dvARRAYTPGen,16] // Mic
BUTTON_EVENT[dvARRAYTPGen,17] // Line
{
  PUSH:            
  {
    IF(nCUR_CTL_OUTPUT)
    { 
      SWITCH(BUTTON.INPUT.CHANNEL)
      {
        CASE 16:
        {
          fLECNETSND("'outmic(',ITOA(nCUR_CTL_OUTPUT),')=1'")
        }
        CASE 17:
        {
          fLECNETSND("'outmic(',ITOA(nCUR_CTL_OUTPUT),')=0'")
        }
      }
      uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALTYPE = (BUTTON.INPUT.CHANNEL - 15)
    }     
  }
}

// Presets
BUTTON_EVENT[dvARRAYTPGen,18] // Preset 1
BUTTON_EVENT[dvARRAYTPGen,19] // Preset 2
BUTTON_EVENT[dvARRAYTPGen,20] // Preset 3
BUTTON_EVENT[dvARRAYTPGen,21] // Preset 4
{
  PUSH:
  {
    nPRESETHELD = 0
  }
  RELEASE:            
  {  
    IF(!nPRESETHELD)
    {
      nPreset = (BUTTON.INPUT.CHANNEL - 17)
      
      fLECNETSND("'recall(',ITOA(nPreset),')'")
      
      WAIT 50 'PRESET'      
      {
        IF(!TIMELINE_ACTIVE(ltlQUERYOUTPUT))
        {
          TIMELINE_CREATE(ltlQUERYOUTPUT,ltlQUERYOUTPUTARRAY,7,TIMELINE_RELATIVE,TIMELINE_ONCE)
        }
      }  
    }  
  }
  HOLD[30]:
  {    
    nPRESETHELD = 1
    fLECNETSND("'store(',ITOA(BUTTON.INPUT.CHANNEL - 17),')'") 
    SEND_COMMAND BUTTON.INPUT.DEVICE,"'ADBEEP'"
  }
}
 
// Mute
BUTTON_EVENT[dvARRAYTPGen,29]  
{
  PUSH:            
  { 
    IF(nCUR_CTL_OUTPUT)
    { 
      uOUTPUT[nCUR_CTL_OUTPUT].nMUTE = !uOUTPUT[nCUR_CTL_OUTPUT].nMUTE
      
      IF(uOUTPUT[nCUR_CTL_OUTPUT].nMUTE)
      {
        fLECNETSND("'outmt(',ITOA(nCUR_CTL_OUTPUT),')=1'")  
      }
      ELSE
      {
        fLECNETSND("'outmt(',ITOA(nCUR_CTL_OUTPUT),')=0'")
      }
    }    
  }
} 

// Output rear panel trim up -30 to 0
BUTTON_EVENT[dvARRAYTPGen,27]  
{
  PUSH:            
  {
    IF(nCUR_CTL_OUTPUT)
    {
      IF((uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim + UP_INC) >= 0)
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim = 0
      }
      ELSE
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim = (uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim + UP_INC) 
      } 
      uOUTPUT[nCUR_CTL_OUTPUT].snPrevTrim = uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim  
      
      fLECNETSND("'rpoutgn(',ITOA(nCUR_CTL_OUTPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim)")
    }  
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_OUTPUT)
    {
      IF((uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim + UP_INC) >= 0)
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim = 0
      }
      ELSE
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim = (uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim + UP_INC) 
      } 
     
      uOUTPUT[nCUR_CTL_OUTPUT].snPrevTrim = uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim  
      
      fLECNETSND("'rpoutgn(',ITOA(nCUR_CTL_OUTPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim)")
    }  
  }                                 
} 

// Output rear panel trim down -30 to 0
BUTTON_EVENT[dvARRAYTPGen,28]  
{
  PUSH:            
  {
    IF(nCUR_CTL_OUTPUT)
    {
      IF((uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim - DN_INC) <= -30)
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim = -30
      }
      ELSE
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim = (uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim - DN_INC) 
      } 
      uOUTPUT[nCUR_CTL_OUTPUT].snPrevTrim = uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim  
      
      fLECNETSND("'rpoutgn(',ITOA(nCUR_CTL_OUTPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim)")
    }  
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_OUTPUT)
    {
      IF((uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim - DN_INC) <= -30)
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim = -30
      }
      ELSE
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim = (uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim - DN_INC) 
      } 
     
      uOUTPUT[nCUR_CTL_OUTPUT].snPrevTrim = uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim  
      
      fLECNETSND("'rpoutgn(',ITOA(nCUR_CTL_OUTPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim)")
    }  
  }
}
 
// Output gain up -70 to +20
BUTTON_EVENT[dvARRAYTPGen,25]  
{
  PUSH:            
  { 
    IF(nCUR_CTL_OUTPUT)
    {
      IF((uOUTPUT[nCUR_CTL_OUTPUT].snCurGain + UP_INC) >= 20)
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurGain = 20
      }
      ELSE
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurGain = (uOUTPUT[nCUR_CTL_OUTPUT].snCurGain + UP_INC) 
      } 
      
      uOUTPUT[nCUR_CTL_OUTPUT].snPrevGain = uOUTPUT[nCUR_CTL_OUTPUT].snCurGain  
      
      fLECNETSND("'outgn(',ITOA(nCUR_CTL_INPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].snCurGain)") 
    }  
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_OUTPUT)
    {
      IF((uOUTPUT[nCUR_CTL_OUTPUT].snCurGain + UP_INC) >= 20)
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurGain = 20
      }
      ELSE
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurGain = (uOUTPUT[nCUR_CTL_OUTPUT].snCurGain + UP_INC) 
      } 
     
      uOUTPUT[nCUR_CTL_OUTPUT].snPrevGain = uOUTPUT[nCUR_CTL_OUTPUT].snCurGain  
      
      fLECNETSND("'outgn(',ITOA(nCUR_CTL_OUTPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].snCurGain)")  
    }  
  }
} 

// Output gain Down -70 to +20
BUTTON_EVENT[dvARRAYTPGen,26]  
{
  PUSH:            
  { 
    IF(nCUR_CTL_OUTPUT)
    {
      IF((uOUTPUT[nCUR_CTL_OUTPUT].snCurGain - DN_INC) <= -70)
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurGain = -70
      }
      ELSE
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurGain = (uOUTPUT[nCUR_CTL_OUTPUT].snCurGain - DN_INC) 
      } 
      
      uOUTPUT[nCUR_CTL_OUTPUT].snPrevGain = uOUTPUT[nCUR_CTL_OUTPUT].snCurGain  
      
      fLECNETSND("'outgn(',ITOA(nCUR_CTL_OUTPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].snCurGain)")
    }  
  }
  HOLD[1,REPEAT]:
  { 
    IF(nCUR_CTL_OUTPUT)
    {
      IF((uOUTPUT[nCUR_CTL_OUTPUT].snCurGain - DN_INC) <= -70)
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurGain = -70
      }
      ELSE
      {
        uOUTPUT[nCUR_CTL_OUTPUT].snCurGain = (uOUTPUT[nCUR_CTL_OUTPUT].snCurGain - DN_INC) 
      } 
     
      uOUTPUT[nCUR_CTL_OUTPUT].snPrevGain = uOUTPUT[nCUR_CTL_OUTPUT].snCurGain  
      
      fLECNETSND("'outgn(',ITOA(nCUR_CTL_OUTPUT),')=',ITOA(uOUTPUT[nCUR_CTL_OUTPUT].snCurGain)")
    }  
  }
}
 
// Outputs 1-24
BUTTON_EVENT[dvARRAYTPGen,171]  
BUTTON_EVENT[dvARRAYTPGen,172]  
BUTTON_EVENT[dvARRAYTPGen,173]  
BUTTON_EVENT[dvARRAYTPGen,174]  
BUTTON_EVENT[dvARRAYTPGen,175]  
BUTTON_EVENT[dvARRAYTPGen,176]  
BUTTON_EVENT[dvARRAYTPGen,177]  
BUTTON_EVENT[dvARRAYTPGen,178]  
BUTTON_EVENT[dvARRAYTPGen,179]  
BUTTON_EVENT[dvARRAYTPGen,180]  
BUTTON_EVENT[dvARRAYTPGen,181]  
BUTTON_EVENT[dvARRAYTPGen,182]  
BUTTON_EVENT[dvARRAYTPGen,183]
BUTTON_EVENT[dvARRAYTPGen,184]  
BUTTON_EVENT[dvARRAYTPGen,185]  
BUTTON_EVENT[dvARRAYTPGen,186]  
BUTTON_EVENT[dvARRAYTPGen,187]  
BUTTON_EVENT[dvARRAYTPGen,188]  
BUTTON_EVENT[dvARRAYTPGen,189]
BUTTON_EVENT[dvARRAYTPGen,190]  
BUTTON_EVENT[dvARRAYTPGen,191]  
BUTTON_EVENT[dvARRAYTPGen,192]  
BUTTON_EVENT[dvARRAYTPGen,193]  
BUTTON_EVENT[dvARRAYTPGen,194]  
{
  PUSH:            
  { 
    nCUR_CTL_OUTPUT = (BUTTON.INPUT.CHANNEL - 170)
    IF(!TIMELINE_ACTIVE(ltlQUERYOUTPUT))
    {
      TIMELINE_CREATE(ltlQUERYOUTPUT,ltlQUERYOUTPUTARRAY,7,TIMELINE_RELATIVE,TIMELINE_ONCE)
    }   
  }
}

TIMELINE_EVENT[ltlQUERYOUTPUT]
{  
  nQUERYOUTPUT = (TIMELINE.SEQUENCE)
  nQUERY = (TIMELINE.SEQUENCE + 30)
  
  SWITCH(nQUERY)
  {
    CASE 31:{fLECNETSND("'outsrc(',ITOA(nCUR_CTL_OUTPUT),')?'")TIMELINE_PAUSE(ltlQUERYOUTPUT)}
    CASE 32:{fLECNETSND("'outmic(',ITOA(nCUR_CTL_OUTPUT),')?'")TIMELINE_PAUSE(ltlQUERYOUTPUT)}
    CASE 33:{fLECNETSND("'outmt(',ITOA(nCUR_CTL_OUTPUT),')?'")TIMELINE_PAUSE(ltlQUERYOUTPUT)}
    CASE 34:{fLECNETSND("'rpoutgn(',ITOA(nCUR_CTL_OUTPUT),')?'")TIMELINE_PAUSE(ltlQUERYOUTPUT)}
    CASE 35:{fLECNETSND("'outgn(',ITOA(nCUR_CTL_OUTPUT),')?'")TIMELINE_PAUSE(ltlQUERYOUTPUT)}
    CASE 36:{fLECNETSND("'actpre?'")TIMELINE_PAUSE(ltlQUERYOUTPUT)} 
    CASE 37:{nQUERY = 0}
  }
}
 
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM 
// Feedback
[dvARRAYTPGen,101] = nCUR_CTL_INPUT_MATRIX = 1 
[dvARRAYTPGen,102] = nCUR_CTL_INPUT_MATRIX = 2  
[dvARRAYTPGen,103] = nCUR_CTL_INPUT_MATRIX = 3  
[dvARRAYTPGen,104] = nCUR_CTL_INPUT_MATRIX = 4  
[dvARRAYTPGen,105] = nCUR_CTL_INPUT_MATRIX = 5  
[dvARRAYTPGen,106] = nCUR_CTL_INPUT_MATRIX = 6  
[dvARRAYTPGen,107] = nCUR_CTL_INPUT_MATRIX = 7  
[dvARRAYTPGen,108] = nCUR_CTL_INPUT_MATRIX = 8  
[dvARRAYTPGen,109] = nCUR_CTL_INPUT_MATRIX = 9  
[dvARRAYTPGen,110] = nCUR_CTL_INPUT_MATRIX = 10  
[dvARRAYTPGen,111] = nCUR_CTL_INPUT_MATRIX = 11  
[dvARRAYTPGen,112] = nCUR_CTL_INPUT_MATRIX = 12  
[dvARRAYTPGen,113] = nCUR_CTL_INPUT_MATRIX = 13
[dvARRAYTPGen,114] = nCUR_CTL_INPUT_MATRIX = 14  
[dvARRAYTPGen,115] = nCUR_CTL_INPUT_MATRIX = 15  
[dvARRAYTPGen,116] = nCUR_CTL_INPUT_MATRIX = 16  

[dvARRAYTPGen,121] = nCUR_CTL_OUTPUT_MATRIX = 1
[dvARRAYTPGen,122] = nCUR_CTL_OUTPUT_MATRIX = 2 
[dvARRAYTPGen,123] = nCUR_CTL_OUTPUT_MATRIX = 3 
[dvARRAYTPGen,124] = nCUR_CTL_OUTPUT_MATRIX = 4 
[dvARRAYTPGen,125] = nCUR_CTL_OUTPUT_MATRIX = 5 
[dvARRAYTPGen,126] = nCUR_CTL_OUTPUT_MATRIX = 6 
[dvARRAYTPGen,127] = nCUR_CTL_OUTPUT_MATRIX = 7 
[dvARRAYTPGen,128] = nCUR_CTL_OUTPUT_MATRIX = 8 
[dvARRAYTPGen,129] = nCUR_CTL_OUTPUT_MATRIX = 9 
[dvARRAYTPGen,130] = nCUR_CTL_OUTPUT_MATRIX = 10 
[dvARRAYTPGen,131] = nCUR_CTL_OUTPUT_MATRIX = 11 
[dvARRAYTPGen,132] = nCUR_CTL_OUTPUT_MATRIX = 12 
[dvARRAYTPGen,133] = nCUR_CTL_OUTPUT_MATRIX = 13
[dvARRAYTPGen,134] = nCUR_CTL_OUTPUT_MATRIX = 14
[dvARRAYTPGen,135] = nCUR_CTL_OUTPUT_MATRIX = 15 
[dvARRAYTPGen,136] = nCUR_CTL_OUTPUT_MATRIX = 16 
[dvARRAYTPGen,137] = nCUR_CTL_OUTPUT_MATRIX = 17 
[dvARRAYTPGen,138] = nCUR_CTL_OUTPUT_MATRIX = 18 
[dvARRAYTPGen,139] = nCUR_CTL_OUTPUT_MATRIX = 19
[dvARRAYTPGen,140] = nCUR_CTL_OUTPUT_MATRIX = 20
[dvARRAYTPGen,141] = nCUR_CTL_OUTPUT_MATRIX = 21 
[dvARRAYTPGen,142] = nCUR_CTL_OUTPUT_MATRIX = 22 
[dvARRAYTPGen,143] = nCUR_CTL_OUTPUT_MATRIX = 23 
[dvARRAYTPGen,144] = nCUR_CTL_OUTPUT_MATRIX = 24 
        
[dvARRAYTPGen,151] = nCUR_CTL_INPUT = 1 
[dvARRAYTPGen,152] = nCUR_CTL_INPUT = 2  
[dvARRAYTPGen,153] = nCUR_CTL_INPUT = 3  
[dvARRAYTPGen,154] = nCUR_CTL_INPUT = 4  
[dvARRAYTPGen,155] = nCUR_CTL_INPUT = 5  
[dvARRAYTPGen,156] = nCUR_CTL_INPUT = 6  
[dvARRAYTPGen,157] = nCUR_CTL_INPUT = 7  
[dvARRAYTPGen,158] = nCUR_CTL_INPUT = 8  
[dvARRAYTPGen,159] = nCUR_CTL_INPUT = 9  
[dvARRAYTPGen,160] = nCUR_CTL_INPUT = 10  
[dvARRAYTPGen,161] = nCUR_CTL_INPUT = 11  
[dvARRAYTPGen,162] = nCUR_CTL_INPUT = 12  
[dvARRAYTPGen,163] = nCUR_CTL_INPUT = 13
[dvARRAYTPGen,164] = nCUR_CTL_INPUT = 14  
[dvARRAYTPGen,165] = nCUR_CTL_INPUT = 15  
[dvARRAYTPGen,166] = nCUR_CTL_INPUT = 16  

[dvARRAYTPGen,171] = nCUR_CTL_OUTPUT = 1
[dvARRAYTPGen,172] = nCUR_CTL_OUTPUT = 2 
[dvARRAYTPGen,173] = nCUR_CTL_OUTPUT = 3 
[dvARRAYTPGen,174] = nCUR_CTL_OUTPUT = 4 
[dvARRAYTPGen,175] = nCUR_CTL_OUTPUT = 5 
[dvARRAYTPGen,176] = nCUR_CTL_OUTPUT = 6 
[dvARRAYTPGen,177] = nCUR_CTL_OUTPUT = 7 
[dvARRAYTPGen,178] = nCUR_CTL_OUTPUT = 8 
[dvARRAYTPGen,179] = nCUR_CTL_OUTPUT = 9 
[dvARRAYTPGen,180] = nCUR_CTL_OUTPUT = 10 
[dvARRAYTPGen,181] = nCUR_CTL_OUTPUT = 11 
[dvARRAYTPGen,182] = nCUR_CTL_OUTPUT = 12 
[dvARRAYTPGen,183] = nCUR_CTL_OUTPUT = 13
[dvARRAYTPGen,184] = nCUR_CTL_OUTPUT = 14
[dvARRAYTPGen,185] = nCUR_CTL_OUTPUT = 15 
[dvARRAYTPGen,186] = nCUR_CTL_OUTPUT = 16 
[dvARRAYTPGen,187] = nCUR_CTL_OUTPUT = 17 
[dvARRAYTPGen,188] = nCUR_CTL_OUTPUT = 18 
[dvARRAYTPGen,189] = nCUR_CTL_OUTPUT = 19
[dvARRAYTPGen,190] = nCUR_CTL_OUTPUT = 20
[dvARRAYTPGen,191] = nCUR_CTL_OUTPUT = 21 
[dvARRAYTPGen,192] = nCUR_CTL_OUTPUT = 22 
[dvARRAYTPGen,193] = nCUR_CTL_OUTPUT = 23 
[dvARRAYTPGen,194] = nCUR_CTL_OUTPUT = 24 

IF(nCUR_CTL_MATRIX)
{
  [dvARRAYTPGen,1] = uMATRIX[nCUR_CTL_MATRIX].nMIXMODE = 4 // MATRIX MODE AUTO
  [dvARRAYTPGen,2] = uMATRIX[nCUR_CTL_MATRIX].nMIXMODE = 1 // MATRIX MODE DIRECT
  [dvARRAYTPGen,3] = uMATRIX[nCUR_CTL_MATRIX].nMIXMODE = 2 // MATRIX MODE OVERRIDE
  [dvARRAYTPGen,4] = uMATRIX[nCUR_CTL_MATRIX].nMIXMODE = 3 // MATRIX MODE BACKGROUND
  [dvARRAYTPGen,5] = uMATRIX[nCUR_CTL_MATRIX].nMIXMUTE     // MATRIX MUTE
  SEND_LEVEL dvARRAYTPGen,1,uMATRIX[nCUR_CTL_MATRIX].snCurLvl  
}

IF(nCUR_CTL_INPUT)
{
  [dvARRAYTPGen,10] = uINPUT[nCUR_CTL_INPUT].nMUTE 
  [dvARRAYTPGen,8]  = uINPUT[nCUR_CTL_INPUT].nPHANTOMPWR
  [dvARRAYTPGen,9]  = uINPUT[nCUR_CTL_INPUT].nPHASE 
  SEND_LEVEL dvARRAYTPGen,3,uINPUT[nCUR_CTL_INPUT].snCurGain
  SEND_LEVEL dvARRAYTPGen,2,uINPUT[nCUR_CTL_INPUT].snCurTrim
}

IF(nCUR_CTL_OUTPUT)
{
  [dvARRAYTPGen,29] = uOUTPUT[nCUR_CTL_OUTPUT].nMUTE
  [dvARRAYTPGen,13] = uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALSRC  = 1  // MATRIX
  [dvARRAYTPGen,14] = uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALSRC  = 2  // PINK NOISE
  [dvARRAYTPGen,15] = uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALSRC  = 3  // TONE 
  [dvARRAYTPGen,16] = uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALTYPE = 1  // MIC
  [dvARRAYTPGen,17] = uOUTPUT[nCUR_CTL_OUTPUT].nSIGNALTYPE = 2  // LINE

  SEND_LEVEL dvARRAYTPGen,4,uOUTPUT[nCUR_CTL_OUTPUT].snCurGain
  SEND_LEVEL dvARRAYTPGen,5,uOUTPUT[nCUR_CTL_OUTPUT].snCurTrim
}    

[dvARRAYTPGen,18] = nPreset = 1 
[dvARRAYTPGen,19] = nPreset = 2
[dvARRAYTPGen,20] = nPreset = 3
[dvARRAYTPGen,21] = nPreset = 4

WAIT 5 'FAIL SAFE'
{
  TIMELINE_RESTART(ltlQUERYINPUT)  
  TIMELINE_RESTART(ltlQUERYOUTPUT)
  TIMELINE_RESTART(ltlQUERYMATRIX)
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

