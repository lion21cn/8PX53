/*
E53 DEMO CODE
*/
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
     TIMER     EQU       07H

;======================================= 
     ORG       03FFH
     GOTO      START
     ORG       08H     
     CLRR      INTFLAG
     RETFIE  
;=======================================          
START:  
     CALL      CLRR_RAM
     MOVIA     02H       ;8分频
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
     MOVIA     00H
     MOVAR     PA
     IOST      PA
     MOVIA     00H
     MOVAR     PB
     MOVIA     00H
     IOST      PB
     CLRR      INTFLAG 
     MOVIA     00H
     MOVAR     INTEN
     MOVIA     25
     MOVAR     TIMER
     CLRR      TMR0
MAIN:

     MOVIA     0FFH
     XORAR     PB,1
     MOVIA     0FFH
     XORAR     PA,1
     
MAIN_WAIT:    
     CLRWDT
     MOVR      TMR0,0              
     XORAR     TIMER,0         
     BTRSS     STATUS,Z       
     GOTO      $-3
     MOVIA     25        ;25*8*0.25=50US
     ADDAR     TIMER,1
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
;=======================================