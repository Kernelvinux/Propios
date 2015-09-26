        ;Autor: Piero Torpoco Llacza
        list	p=16f877A   ;Indica el tipo de procesador
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        
	;Definición de Constantes
        CONSTANT    NUM=.16 ; Valor de los números a contar
        
	;Definición de variables
TEMPO	EQU	0X22
        
	;Configuración de puertos
        ORG     0x000       ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISB       ; Puerto B como salida
        CLRF	TRISC       ; Puerto C como salida
        COMF	TRISC       ; Puerto C como entrada
        CLRF    TRISD       ; Puerto D como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        
	;Programa Principal
INICIO  CLRF    PORTB       ; Inicia PORTB con cero
        CLRF    PORTD       ; Poner puerto D en cero
	MOVLW	0XFF
	MOVWF	TEMPO
	
        ; Activamos memoria
VOLVER  BSF     PORTB,7
        ; Leemos dato
        MOVF    TEMPO,W
	BSF	STATUS,C    ; Se pone el Carry a 1
	SUBWF	PORTC,W	    ;
	BTFSS	STATUS,C
	CALL	MENOR
	BCF	PORTB,7
	INCF	PORTB,F
	MOVLW	NUM
	SUBWF	PORTB,W
	BTFSS	STATUS,Z
	GOTO	VOLVER
	MOVF	TEMPO,W
	MOVWF	PORTD
	GOTO	BUCLE
	
BUCLE	NOP
	GOTO	BUCLE
	
	
MENOR   MOVF	PORTC,W
	MOVWF	TEMPO
	RETURN
	
        END