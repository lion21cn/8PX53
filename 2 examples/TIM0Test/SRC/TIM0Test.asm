/*
---------------------------------------
PRJ Name : GPIO.asm
Brif     : A LED is conctroled by a key.
          IOA1 connect to key
          IOB2 connect to LED
CPU      : AT8PE53
ICE REV  : ICE 2.12

history
---------------------------------------
Date      Author    modify
2012-1217  ZGX      first release       
---------------------------------------
*/

;MACRO
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
;Globle varible       
     PB_BUFF   EQU       10H

;======================================== 

START:  
     CALL      CLRR_RAM  ;�������ͨ�üĴ���
     MOVIA     02H       ;8��Ƶ
     OPTION
     MOVIA     0A0H      ;����LVDT ����WDT
     MOVAR     PCON  
     MOVIA     00H       ;��ֹIOB���жϺͻ��ѹ���
     MOVAR     WUCON  
     MOVIA     0FDH      ;��ֹIOA0 3 IOB0-2 ����IOA1����           
     MOVAR     PDCON 
     MOVIA     0FFH      ;����IBO0-7��©
     MOVAR     ODCON  
     MOVIA     0FFH      ;
     MOVAR     PHCON
     MOVIA     0FFH
     MOVAR     PA        ;PA ��ʼ��Ϊ0
     IOST      PA        ;Input mode
     MOVIA     0FFH      ;PB ��ʼ��Ϊff
     MOVAR     PB
     MOVIA     00H
     IOST      PB        ;PB ��Ϊ���ģʽ
     CLRR      INTFLAG 
     MOVIA     00H       ;�����жϳ�ʼ��Ϊ��
     MOVAR     INTEN
     MOVIA     250
     MOVAR     TIMER
     CLRR      TMR0
    
MAIN:
     CLRWDT 
     BTRSC     PA,1      ;PA1KEY ��Ϊ1 ִ��$+1����LED
                         ;����Ϊ0������$+1��  
     BCR       PB,2    
     BTRSS     PA,1      ;����ʱ��LED
     BSR       PB,2      
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