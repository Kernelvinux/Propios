        ;Autor Piero Torpoco Llacza
	list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración

	;Definicion de variables
TEMPQ	EQU	0x27
        
	ORG     0x00        ; Se define el origen del programa
	GOTO	INICIO
	
	ORG	0x04
	GOTO	INT
	
        ;************CONFIGURACIÓN DE PUERTOS*********
INICIO  BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISC       ; Configuración del puerto C como salida
        CLRF    TRISD       ; Configuración del puerto D como salida
	CLRF	TRISB
	COMF	TRISB
	;Configurando la interrupción RBO/INT
        MOVLW	B'01000000' ; Configurando flanco de subida
        MOVWF	OPTION_REG  ;
	MOVLW	B'10010000' ; Habilitamos GIE e INTE
        MOVWF	INTCON
        BCF     STATUS,RP0  ; Seleccionando el banco 0
	
        ;************INICIO PROGRAMA PRINCIPAL*********
        BCF	INTCON,1
	CLRF    PORTD       ; Poner puerto D en cero
	CLRF	PORTC
        CALL    APAGAR
	
	MOVLW	B'00000001'
	MOVWF	PORTC
	MOVLW	B'11111110'
	MOVWF	PORTD
	
PRIN	NOP
	GOTO	PRIN
	
REP	BTFSS	PORTD,0
	CALL	IZQ
	BTFSS	PORTD,7
	CALL	DER
	BTFSC	PORTC,7
	CALL	BAJAR
	BTFSC	PORTC,0
	CALL	SUBIR
	RETURN
	
IZQ	BTFSC	PORTC,7
	CALL	BAJAR
	BCF	STATUS,C
	RLF	PORTC,F
	RETURN
	
SUBIR	BSF	STATUS,C
	BTFSC	PORTD,0
	RRF	PORTD,F
	RETURN
	
BAJAR	BSF	STATUS,C
	BTFSC	PORTD,7
	RLF	PORTD,F
	RETURN
	
	
DER	BTFSC	PORTC,0
	CALL	SUBIR
	BCF	STATUS,C
	RRF	PORTC,F
	RETURN

INT     MOVWF	TEMPQ
        CALL	REP
	MOVF	TEMPQ,W
	BCF	INTCON,1
	RETFIE
	
	;*****************TABLA1************************
TABLA1   ADDWF   PCL, F
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
        RETLW   0x01
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x02
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
        RETLW   0x04        
        RETLW   0x08        
        RETLW   0x10        
        RETLW   0x20        
        RETLW   0x40
	
        ;************APAGAR DISPLAY********************
APAGAR  MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Pone 1?s a todos los bits del puerto D
        RETURN
        
	
        END