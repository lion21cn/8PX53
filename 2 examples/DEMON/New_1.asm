     INDF      EQU       00H        
     TMR0      EQU       01H                               
     PCL       EQU       02H            
     STATUS    EQU       03H    
;STATUS
     C         EQU       00H                                    
     Z         EQU       02H 
                                                                   
     FSR       EQU       04H                                                    
     PA        EQU       05H          
     PB        EQU       06H          
     PCON      EQU       08H 
     WUCON     EQU       09H                                               
     PCHBUF    EQU       0AH                                                                   
     PDCON     EQU       0BH                                                  
     ODCON     EQU       0CH                          
     PHCON     EQU       0DH                                           
     INTEN     EQU       0EH                                                      
     INTFLAG   EQU       0FH  
;=======================================
     ACCBUF    EQU       10H
     STABUF    EQU       11H      
     FLAG      EQU       12H           
;FLAG
     T_100US   EQU       00H      
     END       EQU       01H
     T_10MS    EQU       02H
                                 
     TCOUNT    EQU       13H      
     ENDCOUNT  EQU       14H
     COUNT     EQU       15H      ;21次一周期   
     COUNT1    EQU       16H      ;一周期循环100次
     TABBUF    EQU       17H 
;=======================================                     
     ORG       03FFH     
     GOTO      START
     ORG       08H     
     MOVAR     ACCBUF
     SWAPR     STATUS,0
     MOVAR     STABUF   
     
     MOVIA     112
     MOVAR     TMR0
     BSR       FLAG,T_100US
     BCR       INTFLAG,0 
     DECRSZ    TCOUNT,1
     GOTO      $+4  
     MOVIA     100  
     MOVAR     TCOUNT    
     BSR       FLAG,T_10MS     
                 
     SWAPR     STABUF,0
     MOVAR     STATUS
     SWAPR     ACCBUF,1
     SWAPR     ACCBUF,0      
     RETFIE         
;========================================
;=======================================
PA_TAB:   
     ADDAR     PCL,1 
;     RETIA     0FFH   
     RETIA     0FFH
     RETIA     0FFH   
     RETIA     0FFH
     RETIA     0FFH                          
     RETIA     0FFH 
     RETIA     0FFH  
     RETIA     0FFH  
     RETIA     0FFH           ;L1
     RETIA     0FFH           ;L2    
     RETIA     0FFH           ;L3    
     RETIA     0FFH           ;L4              
     RETIA     0BFH           ;L5
     RETIA     07FH           ;L6
     RETIA     0FEH           ;L7    
     RETIA     0FDH           ;L8    
     RETIA     0FFH           ;L9    
     RETIA     0FFH           ;L10
     RETIA     0FFH           ;L11
     RETIA     0FFH           ;L12    
     RETIA     0EFH           ;L13  
     RETIA     0F7H           ;L14
     RETIA     0FBH           ;L15
;     RETIA     0CFH           ;L16 
;     RETIA     0DDH           ;L17
;     RETIA     0DDH           ;L18
;     RETIA     0EDH           ;L19
;     RETIA     0EDH           ;L20            
     RETIA     0FFH 
     RETIA     0FFH
     RETIA     0FFH
     RETIA     0FFH
     RETIA     0FFH   
     RETIA     0FFH 
     RETIA     0FFH    
     RETIA     0FFH 
     RETIA     0FFH       
;=======================================
PB_TAB:
     ADDAR     PCL,1    
;     RETIA     0FFH
     RETIA     0FFH 
     RETIA     0FFH       
     RETIA     0FFH
     RETIA     0FFH
     RETIA     0FFH  
     RETIA     0FFH 
     RETIA     0FFH 
     RETIA     0EFH            ;L1
     RETIA     0DFH            ;L2    
     RETIA     0BFH            ;L3    
     RETIA     07FH            ;L4    
     RETIA     0FFH            ;L5
     RETIA     0FFH            ;L6
     RETIA     0FFH            ;L7    
     RETIA     0FFH            ;L8    
     RETIA     0FBH            ;L9    
     RETIA     0F7H            ;L10
     RETIA     0FDH            ;L11
     RETIA     0FEH            ;L12    
     RETIA     0FFH            ;L13   
     RETIA     0FFH            ;L14  
     RETIA     0FFH            ;L15
;     RETIA     10H            ;L16
;     RETIA     20H            ;L17
;     RETIA     02H            ;L18
;     RETIA     10H            ;L19
;     RETIA     02H            ;L20
     RETIA     0FFH
     RETIA     0FFH
     RETIA     0FFH
     RETIA     0FFH
     RETIA     0FFH  
     RETIA     0FFH
     RETIA     0FFH
     RETIA     0FFH 
     RETIA     0FFH    
       
;=======================================
START:  
     CALL      CLRR_RAM    
     MOVIA     00H
     OPTION
     MOVIA     0A0H
     MOVAR     PCON  
     MOVIA     00H
     MOVAR     WUCON  
     MOVIA     0FFH             
     MOVAR     PDCON  
     MOVIA     00H
     MOVAR     ODCON  
     MOVIA     0FFH                                                        
     MOVAR     PHCON
     MOVIA     80H  
     MOVAR     INTEN  
     CLRR      INTFLAG  
     MOVIA     37
     MOVAR     COUNT   
     MOVIA     101
     MOVAR     COUNT1
     MOVIA     12
     MOVAR     ENDCOUNT
     MOVIA     00H
     IOST      PA
     IOST      PB
     MOVIA     95
     MOVAR     TMR0  
     BSR       INTEN,0                
MAIN:  
     BTRSC     FLAG,END
     GOTO      $+3     
     CALL      SET_IO  
     GOTO      MAIN_WAIT      
     MOVIA     0FFH
     MOVAR     PB
     MOVAR     PA
     CLRWDT
     BTRSS     FLAG,T_10MS
     GOTO      $-2          
     BCR       FLAG,T_10MS
     DECRSZ    ENDCOUNT,1
     GOTO      $-5
     MOVIA     12
     MOVAR     ENDCOUNT
     BCR       FLAG,END           
MAIN_WAIT:     
     BTRSS     FLAG,T_100US
     GOTO      $-1                            
     BCR       FLAG,T_100US  
     CLRWDT
     GOTO      MAIN     
;=======================================     
SET_IO:
     DECRSZ    COUNT,1
     GOTO      $+4
     MOVIA     37
     MOVAR     COUNT
     RETURN  
     
     DECRSZ    COUNT1,1
     GOTO      SET_IO_LOOP36
     MOVIA     101
     MOVAR     COUNT1          
     INCR      TABBUF,1
     MOVIA     22    
     SUBAR     TABBUF,0
     BTRSS     STATUS,Z                    
     GOTO      $+3      
     CLRR      TABBUF
     BSR       FLAG,END  
SET_IO_LOOP36:     
     MOVIA     36   
     SUBAR     COUNT,0     
     BTRSS     STATUS,Z
     GOTO      SET_IO_LOOP28
     MOVIA     7     
     ADDAR     TABBUF,0                          
     CALL      PB_TAB
     MOVAR     PB 
     MOVIA     7
     ADDAR     TABBUF,0
     CALL      PA_TAB
     MOVAR     PA 
     RETURN      
SET_IO_LOOP28:     
     MOVIA     28   
     SUBAR     COUNT,0     
     BTRSS     STATUS,Z
     GOTO      SET_IO_LOOP21
     MOVIA     6    
     ADDAR     TABBUF,0                          
     CALL      PB_TAB
     MOVAR     PB 
     MOVIA     6 
     ADDAR     TABBUF,0
     CALL      PA_TAB
     MOVAR     PA
     RETURN      
SET_IO_LOOP21:     
     MOVIA     21  
     SUBAR     COUNT,0     
     BTRSS     STATUS,Z
     GOTO      SET_IO_LOOP15
     MOVIA     5     
     ADDAR     TABBUF,0                          
     CALL      PB_TAB
     MOVAR     PB 
     MOVIA     5
     ADDAR     TABBUF,0
     CALL      PA_TAB
     MOVAR     PA
     RETURN      
SET_IO_LOOP15:     
     MOVIA     15 
     SUBAR     COUNT,0     
     BTRSS     STATUS,Z
     GOTO      SET_IO_LOOP10
     MOVIA     4     
     ADDAR     TABBUF,0                          
     CALL      PB_TAB
     MOVAR     PB 
     MOVIA     4
     ADDAR     TABBUF,0
     CALL      PA_TAB
     MOVAR     PA
     RETURN 
SET_IO_LOOP10:                    
     MOVIA     10             
     SUBAR     COUNT,0
     BTRSS     STATUS,Z
     GOTO      SET_IO_LOOP6
     MOVIA     3     
     ADDAR     TABBUF,0
     CALL      PB_TAB
     MOVAR     PB 
     MOVIA     3
     ADDAR     TABBUF,0
     CALL      PA_TAB
     MOVAR     PA
     RETURN     
SET_IO_LOOP6:                         
     MOVIA     6
     SUBAR     COUNT,0
     BTRSS     STATUS,Z
     GOTO      SET_IO_LOOP3
     MOVIA     2     
     ADDAR     TABBUF,0
     CALL      PB_TAB
     MOVAR     PB 
     MOVIA     2
     ADDAR     TABBUF,0
     CALL      PA_TAB
     MOVAR     PA
     RETURN
SET_IO_LOOP3:
     MOVIA     3
     SUBAR     COUNT,0
     BTRSS     STATUS,Z
     GOTO      SET_IO_LOOP1
     MOVIA     1     
     ADDAR     TABBUF,0
     CALL      PB_TAB
     MOVAR     PB 
     MOVIA     1
     ADDAR     TABBUF,0
     CALL      PA_TAB
     MOVAR     PA
     RETURN    
SET_IO_LOOP1:
     MOVIA     1
     SUBAR     COUNT,0
     BTRSS     STATUS,Z
     RETURN
     MOVIA     0     
     ADDAR     TABBUF,0
     CALL      PB_TAB
     MOVAR     PB 
     MOVIA     0
     ADDAR     TABBUF,0
     CALL      PA_TAB
     MOVAR     PA
     RETURN      
;=======================================
CLRR_RAM:
     MOVIA     30H
     MOVAR     10H                         
     MOVIA     11H         
     MOVAR     FSR     
CLRR_RAM_LOOP:                                            
     CLRR      INDF                                                         
     INCR      FSR,1
     DECRSZ    10H,1
     GOTO      CLRR_RAM_LOOP                 
     CLRR      10H                       
     RETURN  
