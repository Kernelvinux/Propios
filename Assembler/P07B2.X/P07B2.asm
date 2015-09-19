        ;Autor: Piero Torpoco Llacza
        LIST	P=16f877A
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Configuración de puertos
        ORG     0x00        ; Se define el origen del programa
INICIO  BSF     STATUS,RP0
	CLRF	TRISB
	COMF	TRISB
        CLRF    TRISD
        BCF     STATUS,RP0
        CLRF    PORTD
        ;Programa principal
	MOVLW	B'00010000'
	MOVWF	PORTD
BOTON0  BTFSS   PORTB,0     ;Pregunta por pulsador0
        GOTO    ANTI0
BOTON1  BTFSS   PORTB,1     ;Pregunta por pulsador1
        GOTO    ANTI1
        GOTO    BOTON0
        ;Rutinas de antirebote 0
ANTI0   BTFSS   PORTB,0     ;Pregunta si pulsador0 se ha "soltado"
        GOTO    ANTI0
	BTFSS	PORTD,7
        RLF     PORTD,F
        GOTO    BOTON1
        ;Rutinas de antirebote 1
ANTI1   BTFSS   PORTB,1     ;Pregunta si pulsador1 se ha "soltado"
        GOTO    ANTI1
	BTFSS	PORTD,0
        RRF     PORTD,F
        GOTO    BOTON0
        END