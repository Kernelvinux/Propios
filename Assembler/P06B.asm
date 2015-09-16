        ;Autor: Mauricio Galvez Legua
        list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"P16F877A.INC"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuraci�n
        CONSTANT NUM=.8     ; Valor de los n�meros a contar
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
CUENTA  EQU     0x22        ; Variable para almacenar la CUENTA
        ;Configuraci�n de puertos
        ORG     0x000       ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selecci�n banco 1
        CLRF	TRISC       ; Configuraci�n del PORTC como salida
        CLRF    TRISD       ; Configuraci�n del PORTD como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;Inicio del Programa Principal
INICIO  CLRF    CUENTA      ; Inicia CUENTA con cero
        CLRF    PORTC       ; Poner PORTC en cero
        MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Desactivamos todos los display
        
VOLVER  MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA1      ; Llamada a subrutina TABLA1
        MOVWF   PORTC       ; Envia dato de TABLA1 a PORTC
        MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA2      ; Llamada a subrutina TABLA2
        MOVWF   PORTD       ; Envia dato de TABLA2 a PORTD
        BSF     PCLATH,3    ; Seleccionamos la p�gina 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la p�gina 0
        CLRF    PORTC       ; Apagamos los display
        INCF    CUENTA,F    ; Incrementa contador CUENTA
        ;Preguntamos si Cuenta = 8
        MOVLW   NUM         ; Cargamos la constante a W
        SUBWF   CUENTA,W    ; W = Cuenta - W
        BTFSS   STATUS,Z    ; Salta si Z=1
        GOTO    VOLVER      ; Volver al inicio del programa
        GOTO    INICIO
        ;*****************Tabla1************************
TABLA1  ADDWF   PCL, F
        RETLW   0x71        ; C�digo del F en 7 segmentos
        RETLW   0x06        ; C�digo del I en 7 segmentos
        RETLW   0x79        ; C�digo del E en 7 segmentos
        RETLW   0x79        ; C�digo del E en 7 segmentos
        RETLW   0x40        ; C�digo del - en 7 segmentos
        RETLW   0x3E        ; C�digo del U en 7 segmentos
        RETLW   0x54        ; C�digo del N en 7 segmentos
        RETLW   0x06        ; C�digo del I en 7 segmentos
        ;*****************Tabla2************************
TABLA2  ADDWF   PCL, F
        RETLW   B'11111110' ; C�digo para habilitar 1 display
        RETLW   B'11111101' ; C�digo para habilitar 2 display
        RETLW   B'11111011' ; C�digo para habilitar 3 display
        RETLW   B'11110111' ; C�digo para habilitar 4 display
        RETLW   B'11101111' ; C�digo para habilitar 5 display
        RETLW   B'11011111' ; C�digo para habilitar 6 display
        RETLW   B'10111111' ; C�digo para habilitar 7 display
        RETLW   B'01111111' ; C�digo para habilitar 8 display
        ;Subrutina DELAY
        ORG     0x800       ; P�gina 1
DELAY   MOVLW   0x10        ; Configuramos el tiempo del retardo
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