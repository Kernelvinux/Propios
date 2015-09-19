        ;Autor Piero Torpoco Llacza
        list	p=16f877A       ;Indica el tipo de procesador
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
        
	;Definición de Constantes
        CONSTANT    NUM=.8 ; Número de display
	CONSTANT    NUM2=.16
        
	;Definición de variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
CUENTA3 EQU     0x22        ; Variable de rotación para multiplexado
CUENTA1 EQU     0x23        ; Variable para almacenar la posición en la tabla
CUENTA2	EQU	0x24	    
  
        
	;Configuración de puertos
        ORG     0x000       ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISC       ; PORTC como salida
        CLRF    TRISD       ; PORTD como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        
	;Programa Principal
INICIO2	CLRF	CUENTA3
INICIO	CLRF	CUENTA1
	MOVF	CUENTA3,W
	CALL	TABLA3
	MOVWF	CUENTA1
	MOVLW	B'00000000'
	MOVWF	CUENTA2
        CLRF    PORTC       ; Poner PORTC en cero
        CALL    APAGAR
VOLVER  MOVF    CUENTA1,W    ; Cargamos CUENTA a W
        CALL    TABLA       ; Llamada a subrutina TABLA
        MOVWF   PORTC       ; Envia dato de TABLA a PORTC
	MOVF	CUENTA2,W
	CALL	TABLA2
	MOVWF	PORTD
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CALL    APAGAR
        INCF    CUENTA1,F   ; Incrementa contador CUENTA1
	INCF	CUENTA2,F   ; Incrementa contador CUENTA2
        
	;Preguntamos si CUENTA = NUM
        MOVLW   NUM         ; Carga el número de display en W
        SUBWF   CUENTA2,W   ; W = Cuenta - W
        BTFSS   STATUS,Z    ; Salta si Z=1
        GOTO    VOLVER      ; Volver al inicio del programa
	;CALL	DELAYB
	INCF	CUENTA3,F
	MOVLW	NUM2
	SUBWF	CUENTA3,W
	BTFSS	STATUS,Z
	GOTO    INICIO
	GOTO	INICIO2
        
	;Tabla
TABLA   ADDWF   PCL, F
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x40	    ; Código de - en 7 segmentos
	RETLW	0x40	    ; Código de - en 7 segmentos
        RETLW   0x71        ; Código de F en 7 segmentos
        RETLW   0x06        ; Código de I en 7 segmentos
        RETLW   0x79        ; Código de E en 7 segmentos
        RETLW   0x79        ; Código de E en 7 segmentos
        RETLW   0x40        ; Código de - en 7 segmentos
        RETLW   0x40        ; Código de - en 7 segmentos
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00
	RETLW	0x00

TABLA2  ADDWF   PCL, F
        RETLW   B'11111110' ; Código para habilitar 1 display
        RETLW   B'11111101' ; Código para habilitar 2 display
        RETLW   B'11111011' ; Código para habilitar 3 display
        RETLW   B'11110111' ; Código para habilitar 4 display
	RETLW   B'11101111' ; Código para habilitar 5 display
        RETLW   B'11011111' ; Código para habilitar 6 display
        RETLW   B'10111111' ; Código para habilitar 7 display
        RETLW   B'01111111' ; Código para habilitar 8 display
	
TABLA3  ADDWF   PCL, F
        RETLW   B'00000000' 
        RETLW   B'00000001' 
        RETLW   B'00000010' 
        RETLW   B'00000011' 
        RETLW   B'00000100' 
        RETLW   B'00000101' 
        RETLW   B'00000110' 
        RETLW   B'00000111' 
        RETLW   B'00001000' 
        RETLW   B'00001001' 
        RETLW   B'00001010' 
        RETLW   B'00001011' 
	RETLW   B'00001100' 
        RETLW   B'00001101' 
        RETLW   B'00001110' 
        RETLW   B'00001111' 
        RETLW   B'00010000' 
	
        ;Subrutina Apagar Todos los Display
APAGAR  MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Pone 1?s al puerto D
        RETURN
	
        ;Subrutina DELAY
        ORG     0x800       ; Página 1
DELAY   MOVLW   0x50        ; Configuramos el tiempo del retardo
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
	
        ;Subrutina DELAYB
	ORG	0x700
DELAYB  MOVLW   0x90        ; Configuramos el tiempo del retardo
        MOVWF   TIEMPO1
DELAY1B MOVWF   TIEMPO2
DELAY2B NOP
        NOP
        NOP
        NOP
        DECFSZ  TIEMPO2,F
        GOTO    DELAY2B
        DECFSZ  TIEMPO1,F
        GOTO    DELAY1B
        RETURN
        END
