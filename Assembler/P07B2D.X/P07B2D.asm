        ;Autor: Piero Torpoco Llacza
        LIST	P=16f877A
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Configuración de puertos
        ORG     0x00        ; Se define el origen del programa
INICIO  BSF     STATUS,RP0
        BSF     TRISB,0
        CLRF    TRISD
	CLRF	TRISC
        BCF     OPTION_REG,NOT_RBPU
        BCF     STATUS,RP0
        CLRF    PORTD
	CLRF	PORTC
        ;Programa principal
	MOVLW	B'00000001'
	MOVWF	PORTC
BOTON0  BTFSS   PORTB,3     ;Pregunta por pulsador0
        GOTO    ANTI0
BOTON1  BTFSS   PORTB,2     ;Pregunta por pulsador1
        GOTO    ANTI1
        GOTO    BOTON0
        ;Rutinas de antirebote 0
ANTI0   BTFSS   PORTB,3     ;Pregunta si pulsador0 se ha "soltado"
        GOTO    ANTI0
	BCF	STATUS,C
	BTFSS	PORTD,7
        RLF     PORTD,F
	BTFSS	PORTD,7
	RLF	PORTC,F
	BTFSS	PORTD,7
	BTFSS	STATUS,C
	GOTO    BOTON1
	GOTO	CAMBIO1
        
        ;Rutinas de antirebote 1
ANTI1   BTFSS   PORTB,2     ;Pregunta si pulsador1 se ha "soltado"
        GOTO    ANTI1
	BCF	STATUS,C
        BTFSS	PORTC,0
        RRF     PORTC,F
	BTFSS	PORTC,0
	RRF	PORTD,F
	BTFSS	PORTC,0
	BTFSS	STATUS,C
        GOTO    BOTON0
	GOTO	CAMBIO2
	
CAMBIO1	MOVLW	B'00000001'
	MOVWF	PORTD
	GOTO	BOTON1
CAMBIO2	MOVLW	B'10000000'
	MOVWF	PORTC
	GOTO	BOTON0
	
        END