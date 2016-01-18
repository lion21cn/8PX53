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
;======================================== 
     TIMER     EQU       07H

;======================================== 
     ORG       03FFH
     GOTO      START
     ORG       08H     
     CLRR      INTFLAG
     RETFIE  
;========================================          
START:  
     CALL      CLRR_RAM
     MOVIA     02H       ;8·ÖÆµ
     OPTION
     MOVIA     0A0H
     MOVAR     PCON  
     MOVIA     00H
     MOVAR     WUCON  
     MOVIA     0FFH             
     MOVAR     PDCON  
     MOVIA     0FFH
     MOVAR     ODCON  
     MOVIA     0FFH
     MOVAR     PHCON
     MOVIA     00H
     MOVAR     PA ;PA Iinit is 0
     IOST      PA ;Output mode
     MOVIA     0FFH
     MOVAR     PB 
     MOVIA     00H
     IOST      PB  ;Output mode
     CLRR      INTFLAG 
     MOVIA     00H
     MOVAR     INTEN
     MOVIA     250
     MOVAR     TIMER
     CLRR      TMR0
    
MAIN:
     CLRWDT
     COMR PB,1
     CALL DELAY_500MS
     GOTO      MAIN                  
;==========CLRR_RAM=====================                                                                
CLRR_RAM:
     MOVIA     2FH
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
;======================================== 
DELAY_500MS:
     CLRWDT
     MOVIA     200;
     MOVAR     16H
     MOVIA     200;
     MOVAR     15H
LOOP_1:
     CALL LOOP_0
     DECRSZ    16H,1     
     GOTO LOOP_1
     CLRR 16H
     RETURN
LOOP_0:
     CLRWDT
     NOP
     NOP
     NOP
     NOP
     NOP
     DECRSZ    15H,1
     GOTO LOOP_0
     CLRR 15H
     RETURN
;========================================                                                     