        ;Autor: Piero Torpoco Llacza
        LIST	P=16f877A
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        
	;Definicion de variables
PUERTOC1 EQU     0x20        ; Variable temporal para puerto C1
PUERTOC2 EQU     0x21        ; Variable temporal para puerto C2
PUERTOD1 EQU     0x22        ; Variable temporal para puerto D1
PUERTOD2 EQU     0x23        ; Variable temporal para puerto D2
	
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
	CLRF	PUERTOC1
	CLRF	PUERTOD1
	CLRF	PUERTOC2
	CLRF	PUERTOD2
	
	
        ;Programa principal
	MOVLW	B'00000001'
	MOVWF	PUERTOC1
	MOVLW	B'10000000'
	MOVWF	PUERTOD2
	
BOTON0  MOVF	PUERTOC1,W
	IORWF	PUERTOC2,W
	MOVWF	PORTC
	MOVF	PUERTOD1,W
	IORWF	PUERTOD2,W
	MOVWF	PORTD
	BTFSS   PORTB,3     ;Pregunta por pulsador3
        GOTO    ANTI0
	
BOTON1  MOVF	PUERTOC1,W
	IORWF	PUERTOC2,W
	MOVWF	PORTC
	MOVF	PUERTOD1,W
	IORWF	PUERTOD2,W
	MOVWF	PORTD
	BTFSS   PORTB,2     ;Pregunta por pulsador2
        GOTO    ANTI1
	
BOTON2  MOVF	PUERTOC1,W
	IORWF	PUERTOC2,W
	MOVWF	PORTC
	MOVF	PUERTOD1,W
	IORWF	PUERTOD2,W
	MOVWF	PORTD
	BTFSS   PORTB,1     ;Pregunta por pulsador1
        GOTO    ANTI2
	
BOTON3  MOVF	PUERTOC1,W
	IORWF	PUERTOC2,W
	MOVWF	PORTC
	MOVF	PUERTOD1,W
	IORWF	PUERTOD2,W
	MOVWF	PORTD
	BTFSS   PORTB,0     ;Pregunta por pulsador0
        GOTO    ANTI3
        GOTO    BOTON0
	
        ;Rutinas de antirebote 0
ANTI0   BTFSS   PORTB,3     ;Pregunta si pulsador0 se ha "soltado"
        GOTO    ANTI0
	BCF	STATUS,C
	BTFSS	PUERTOD1,7
        RLF     PUERTOD1,F
	BTFSS	PUERTOD1,7
	RLF	PUERTOC1,F
	BTFSS	PUERTOD1,7
	BTFSS	STATUS,C
	GOTO    BOTON1
	GOTO	CAMBIO1
        
        ;Rutinas de antirebote 1
ANTI1   BTFSS   PORTB,2     ;Pregunta si pulsador1 se ha "soltado"
        GOTO    ANTI1
	BCF	STATUS,C
        BTFSS	PUERTOC1,0
        RRF     PUERTOC1,F
	BTFSS	PUERTOC1,0
	RRF	PUERTOD1,F
	BTFSS	PUERTOC1,0
	BTFSS	STATUS,C
        GOTO    BOTON0
	GOTO	CAMBIO2
	
ANTI2   BTFSS   PORTB,1     ;Pregunta si pulsador0 se ha "soltado"
        GOTO    ANTI2
	BCF	STATUS,C
	BTFSS	PUERTOD2,7
        RLF     PUERTOD2,F
	BTFSS	PUERTOD2,7
	RLF	PUERTOC2,F
	BTFSS	PUERTOD2,7
	BTFSS	STATUS,C
	GOTO    BOTON3
	GOTO	CAMBIO3
	
ANTI3   BTFSS   PORTB,0     ;Pregunta si pulsador1 se ha "soltado"
        GOTO    ANTI3
	BCF	STATUS,C
        BTFSS	PUERTOC2,0
        RRF     PUERTOC2,F
	BTFSS	PUERTOC2,0
	RRF	PUERTOD2,F
	BTFSS	PUERTOC2,0
	BTFSS	STATUS,C
        GOTO    BOTON2
	GOTO	CAMBIO4
	
CAMBIO1	MOVLW	B'00000001'
	MOVWF	PUERTOD1
	GOTO	BOTON1
CAMBIO2	MOVLW	B'10000000'
	MOVWF	PUERTOC1
	GOTO	BOTON0	

CAMBIO3	MOVLW	B'00000001'
	MOVWF	PUERTOD2
	GOTO	BOTON3
CAMBIO4	MOVLW	B'10000000'
	MOVWF	PUERTOC2
	GOTO	BOTON2

	
        END