        ;Autor: Mauricio Galvez Legua
        LIST	P=16f877A
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Configuración de puertos
        ORG     0x00        ; Se define el origen del programa
INICIO  BSF     STATUS,RP0
        BSF     TRISB,0
        CLRF    TRISD
        BCF     STATUS,RP0
        CLRF    PORTD
        ;Programa principal
BOTON   BTFSC   PORTB,0
        GOTO    BOTON
        ;Rutina de antirebote
ANTI    BTFSS   PORTB,0
        GOTO    ANTI
        INCF    PORTD,F
        GOTO    BOTON
        END