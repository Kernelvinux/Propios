        ;Autor Piero Torpoco Llacza
	list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración

	;Definicion de variables
TEMP	EQU     0x22
MARCX	EQU	0x23
MARCY	EQU	0x24	
CURX	EQU	0x25
CURY	EQU	0x26
TEMPQ	EQU	0x27
TIEMPO1	EQU	0x28
TIEMPO2	EQU	0x29
        
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
	CLRF	TEMP
	CLRF	CURX
	CLRF	CURY
	CLRF	MARCX
	CLRF	MARCY
	CLRF    PORTD       ; Poner puerto D en cero
	CLRF	PORTC
        CALL    APAGAR
	
PRIN	MOVLW	B'10000000'
	MOVWF	PORTC
	MOVF	PORTC,W
	MOVWF	CURX
	MOVLW	B'11111110'
	MOVWF	PORTD
	MOVF	PORTD,W
	MOVWF	CURY
	
REP	BTFSC	TEMP,0
	CALL	ESCRIB
	BTFSC	TEMP,1
	CALL	PRIN
	BTFSC	TEMP,2
	CALL	IZQ
	BTFSC	TEMP,3
	CALL	SUBIR
	BTFSC	TEMP,4
	CALL	BAJAR
	BTFSC	TEMP,5
	CALL	CLEAR
	BTFSC	TEMP,6
	CALL	DER
	GOTO	REP
	
ESCRIB	MOVF	MARCX,W
	IORWF	CURX,W
	MOVWF	PORTC
	MOVF	MARCY,W
	IORWF	CURY,W
	MOVWF	PORTD
	RETURN
	
IZQ	BTFSS	PORTC,7
	RLF	PORTC,F
	CLRF	TEMP
	RETURN
	
SUBIR	BSF	STATUS,C
	BTFSC	PORTD,0
	RRF	PORTD,F
	CLRF	TEMP
	RETURN
	
BAJAR	BSF	STATUS,C
	BTFSC	PORTD,7
	RLF	PORTD,F
	CLRF	TEMP
	RETURN
	
CLEAR	NOP
	RETURN
	
DER	BTFSS	PORTC,0
	RRF	PORTC,F
	CLRF	TEMP
	RETURN

INT     MOVWF	TEMPQ
	SWAPF   PORTB,W
        ANDLW   B'00001111'
        CALL    TABLA1
        MOVWF   TEMP
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
        
        ;*****************DELAY************************
DELAY   MOVLW   0x08        ; Configuramos el tiempo del retardo
        MOVWF   TIEMPO1
DELAY1  MOVWF   TIEMPO2
DELAY2  NOP
        NOP
        NOP
        NOP
        DECFSZ  TIEMPO2,F
        GOTO    DELAY2
        DECFSZ  TIEMPO1,F
        GOTO    DELAY1
        RETURN
        ;**************FIN DELAY***********************
	
        END