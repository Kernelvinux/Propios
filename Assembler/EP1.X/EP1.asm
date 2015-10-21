        ;Autor Piero Torpoco Llacza
	list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración

	;Definicion de variables
FILTRO2	EQU     0x22        
FILTRO1 EQU     0x23        
CUENTA	EQU	0x24
TEMP	EQU	0x25
        ORG     0x00        ; Se define el origen del programa
	
        ;************CONFIGURACIÓN DE PUERTOS*********
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISC       ; Configuración del puerto C como salida
        CLRF    TRISD       ; Configuración del puerto D como salida
	CLRF	TRISB
	COMF	TRISB	    
        BCF     STATUS,RP0  ; Seleccionando el banco 0
	
        ;************INICIO PROGRAMA PRINCIPAL*********
        CLRF    PORTD       ; Poner puerto D en cero
	CLRF	PORTC
        CALL    APAGAR
INICIO	CLRF	CUENTA
	CLRF	FILTRO1
	CLRF	FILTRO2
	MOVLW	B'00001111'
	MOVWF	FILTRO1
	MOVF	PORTB,W	    ; Inicializa la variable ROTAR
        ANDWF   FILTRO1,W
        CALL    TABLA1       ; Llamada a subrutina TABLA
        MOVWF   PORTC       
	MOVLW	B'11110000'
	MOVWF	FILTRO2
	MOVF	PORTB,W
	ANDWF	FILTRO2,F
	CALL	ROTAR
	MOVF	FILTRO2,W
	CALL	TABLA1
	MOVWF	TEMP
	COMF	TEMP,W
	MOVWF	PORTD
        GOTO    INICIO
        
ROTAR	NOP
IN	RRF	FILTRO2,F
	INCF	CUENTA,F
	BTFSS	CUENTA,2
	GOTO	IN
	RETURN
	
	
	;*****************TABLA1************************
TABLA1   ADDWF   PCL, F
        RETLW   0x80        
        RETLW   0x40        
        RETLW   0x20        
        RETLW   0x10        
        RETLW   0x08        
        RETLW   0x04        
        RETLW   0x02        
        RETLW   0x01
	
	
        ;************APAGAR DISPLAY********************
APAGAR  MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Pone 1?s a todos los bits del puerto D
        RETURN
        
	
        END