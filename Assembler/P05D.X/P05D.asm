	; Autor Piero Torpoco Llacza
        ; Curso: Sistema Basados en Microprocesador
        list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración

TIEMPO1 EQU     0X20
TIEMPO2 EQU     0X21
CONT	EQU	0X22
 
        ORG     0x00        ; Directiva para definir el que origen del codigo esta en la posicion
        BSF     STATUS,RP0  ; Seleccion banco 1
        CLRF    TRISB	      ; Configuracion del puerto B como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;************INICIO PROGRAMA PRINCIPAL*********
        CLRF    PORTB       ; Poner puerto B en cero


	MOVLW	B'00000000'
	MOVWF	CONT
	
INICIO	MOVF	CONT,W
	MOVWF	PORTB
	CALL	DELAY
	BTFSC	CONT,3
	GOTO	SALTO
	INCF	CONT
	GOTO	INICIO
	
SALTO	BTFSS	CONT,0
	GOTO	SALTO1
	BTFSC	CONT,7
	CALL	SALTO2
	MOVLW	0X07
	ADDWF	CONT,F
	GOTO	INICIO
	
SALTO1	INCF	CONT
	GOTO	INICIO
	
SALTO2	BTFSC	CONT,4
	GOTO	NOV
	RETURN
	
NOV	MOVLW	B'10011001'
	MOVWF	PORTB
	GOTO	NOV
	
DELAY   MOVLW   0x90        ; Configuramos el tiempo del retardo
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
	
	END