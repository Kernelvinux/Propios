        ;Autor: Mauricio Galvez Legua
        list	p=16f877A   ;Indica el tipo de procesador
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        
	;Definición de Constantes
        CONSTANT    NUM=.16 ; Valor de los números a contar
        
	;Definición de variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
        
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
        ; Activamos memoria
VOLVER  BSF     PORTB,7
        ; Leemos dato
        MOVF    PORTC,W     ; Cargamos DATO a registro W
        MOVWF   PORTD       ; Envia DATO a PORTD
        ; Desactivamos memoria
        BCF     PORTB,7
        CALL    DELAY       ; Llamada a subrutina DELAY
        INCF    PORTB,F     ; Incrementa PORTB
        ;Preguntamos si PORTB = num
        MOVLW   NUM         ; Carga el dato 16 decimal a W
        SUBWF   PORTB,W	    ; W = Cuenta - W
        BTFSS   STATUS,Z    ; Salta si Z=1
        GOTO    VOLVER
        GOTO    INICIO      ; Volver al inicio del programa
        
	;Subrutina de DELAY
DELAY   MOVLW   0xFFF        ; Configuramos el tiempo del retardo
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