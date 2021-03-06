;// FM8PE53 General Head Ver:1.01,build:0 credit:0 lastedit:20120316
;// Header Author:hu_cy; hu_cy@feeling-tech.com.tw
;// CHIP Version:N/A(General)
;---------------HEAD Credit History-------------------------------------------
;2012/03/16     Add .SET information
;2009/03/11     Compiler HEAD Release
;---------------Common define Segment-----------------------------------------
A               EQU     0x0
R               EQU     0x1
;---------------Control by IOST & OPTION Maps---------------------------------
PS0_B           EQU     0x0
PS1_B           EQU     0x1
PS2_B           EQU     0x2
PSA_B           EQU     0x3
T0SE_B          EQU     0x4
T0CS_B          EQU     0x5
INTEDG_B        EQU     0x6
;-------------------------------
.SET IOST
IOSTA           REG     0x05
IOSTB           REG     0x06
.ENDSET
;---------------Operation Registers Maps--------------------------------------
INDF            REG     0x00
TMR0            REG     0x01
PCL             REG     0x02
;-------------------------------
STATUS          REG     0x03
C_B             EQU     0x0
DC_B            EQU     0x1
Z_B             EQU     0x2
PD_B            EQU     0x3
TO_B            EQU     0x4
GP0_B           EQU     0x5
GP1_B           EQU     0x6
RST_B           EQU     0x7
;-------------------------------
FSR             REG     0x04
;-------------------------------
PORTA           REG     0x05
IOA0_B          EQU     0x0
IOA1_B          EQU     0x1
IOA2_B          EQU     0x2
IOA3_B          EQU     0x3
;-------------------------------
PORTB           REG     0x06
IOB0_B          EQU     0x0
IOB1_B          EQU     0x1
IOB2_B          EQU     0x2
IOB3_B          EQU     0x3
IOB4_B          EQU     0x4
IOB5_B          EQU     0x5
IOB6_B          EQU     0x6
IOB7_B          EQU     0x7
;-------------------------------
PCON            REG     0x08
LVDTE_B         EQU     0x5
EIS_B           EQU     0x6
WDTE_B          EQU     0x7
;-------------------------------
WUCON           REG     0x09
WUB0_B          EQU     0x0
WUB1_B          EQU     0x1
WUB2_B          EQU     0x2
WUB3_B          EQU     0x3
WUB4_B          EQU     0x4
WUB5_B          EQU     0x5
WUB6_B          EQU     0x6
WUB7_B          EQU     0x7
;-------------------------------
PCHBUF          REG     0x0A
;-------------------------------
PDCON           REG     0x0B
PDA0_B          EQU     0x0
PDA1_B          EQU     0x1
PDA2_B          EQU     0x2
PDA3_B          EQU     0x3
PDB0_B          EQU     0x4
PDB1_B          EQU     0x5
PDB2_B          EQU     0x6
;-------------------------------
ODCON           REG     0x0C
ODB0_B          EQU     0x0
ODB1_B          EQU     0x1
ODB2_B          EQU     0x2
ODB4_B          EQU     0x4
ODB5_B          EQU     0x5
ODB6_B          EQU     0x6
ODB7_B          EQU     0x7
;-------------------------------
PHCON           REG     0x0D
PHB0_B          EQU     0x0
PHB1_B          EQU     0x1
PHB2_B          EQU     0x2
PHB4_B          EQU     0x4
PHB5_B          EQU     0x5
PHB6_B          EQU     0x6
PHB7_B          EQU     0x7
;-------------------------------
INTEN           REG     0x0E
T0IE_B          EQU     0x0
PBIE_B          EQU     0x1
INTIE_B         EQU     0x2
GIE_B           EQU     0x7
;-------------------------------
INTFLAG         REG     0x0F
T0IF_B          EQU     0x0
PBIF_B          EQU     0x1
INTIF_B         EQU     0x2