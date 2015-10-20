        ;Autor: Piero Torpoco Llacza
        LIST	P=16f877A
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        
	;Definición de variables
MARCA	EQU     0x23	    ; Variable para almacenar el numero marcado
CURSOR	EQU	0x24	    ; Variable para almacenar el cursor
TEMP	EQU	0x25	    ; Variable para almacenar el valor de W
	
	;Se define el inicio del programa
        ORG     0x000       ; Se define el origen del programa
	GOTO	INICIO
	;Se define el inicio de la rutina de interrupción
	ORG	0x004
	GOTO	INT
	
	;Configuración de puertos
INICIO  BSF     STATUS,RP0  ; Seleccion Banco 1
	CLRF	TRISB	    
	COMF	TRISB	    ; Puerto B como entrada
        CLRF    TRISD	    ; Puerto D como salida
	BCF	OPTION_REG,NOT_RBPU
	BSF	OPTION_REG,INTEDG
	BCF	INTCON,PEIE
	;Configuracion de la interrupcion PORTB
	CLRF	INTCON	    ; Se deshabilitan todas las interrupciones
	BSF	INTCON,RBIE ; Se habilita la interrupción de PORTB
	BSF	INTCON,GIE  ; Se habilita las interrupciones generales
        BCF     STATUS,RP0  ; Seleccion Banco 0
        
	;Programa principal
	MOVF	PORTB,W
	BCF	INTCON,RBIF
	CLRF    PORTD	    ; Puerto D se pone en 0
	CLRF	MARCA	    ; MARCA se pone en 0
	CLRF	CURSOR
	MOVLW	B'10000000'
	MOVWF	CURSOR	    
PRIN	MOVF	MARCA,W
	IORWF	CURSOR,W
	MOVWF	PORTD
	GOTO	PRIN
	
	;Inicio rutina de interrupción
INT	MOVWF	TEMP
	MOVF	PORTB,W
	BTFSS	PORTB,7
	CALL	SUMA
	BTFSS	PORTB,5
	CALL	DER
	BTFSS	PORTB,6
	CALL	IZQ
	MOVF	TEMP,W
	BCF	INTCON,RBIF
	RETFIE
	
DER	BTFSS	CURSOR,0
        RRF     CURSOR,F
	RETURN
	
IZQ	BTFSS	CURSOR,7
        RLF     CURSOR,F
	RETURN
	
SUMA	MOVF	CURSOR,W
	XORWF	MARCA,F
	RETURN
	
        END