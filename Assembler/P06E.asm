        ;Autor: Mauricio Galvez Legua
        list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"P16F877A.INC"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
        CONSTANT NUM=.4     ; Valor de los números a contar
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
CUENTA  EQU     0x22        ; Variable para almacenar la CUENTA
        ;Configuración de puertos
        ORG     0x000       ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISB       ; Configuramos PORTB como salida
        CLRF    TRISC       ; Configuramos PORTC como salida
        CLRF    TRISD       ; Configuración del PORTD como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;Inicio del Programa Principal
INICIO  CLRF    CUENTA      ; Inicia CUENTA con cero
        CLRF    PORTB       ; Poner PORTC en cero
        CLRF    PORTC
        MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Desactivamos todos los display
VOLVER  MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA1      ; Llamada a subrutina TABLA1
        MOVWF   PORTB       ; Envia dato de TABLA1 a PORTB
        MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA2      ; Llamada a subrutina TABLA2
        MOVWF   PORTC       ; Envia dato de TABLA2 a PORTC
        MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA3      ; Llamada a subrutina TABLA3 (multiplexado)
        MOVWF   PORTD       ; Envia dato de TABLA3 a PORTD
        CALL    DELAY       ; Llamada a subrutina DELAY
        MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Desactivamos todos los display
        INCF    CUENTA,F    ; Incrementa contador CUENTA
        ;Preguntamos si Cuenta = 4
        MOVLW   NUM         ; Cargamos la constante a W
        SUBWF   CUENTA,W    ; W = Cuenta - W
        BTFSS   STATUS,Z    ; Salta si Z=1
        GOTO    VOLVER      ; Volver al inicio del programa
        GOTO    INICIO
        ;*****************Tabla1************************
TABLA1  ADDWF   PCL, F
        RETLW   0x76        ; Código del - en 7 segmentos
        RETLW   0x33        ; Código del - en 7 segmentos
        RETLW   0x3D        ; Código del F en 7 segmentos
        RETLW   0x38        ; Código del I en 7 segmentos
        ;*****************Tabla2************************
TABLA2  ADDWF   PCL, F
        RETLW   0x01        ; Código del E en 7 segmentos
        RETLW   0x22        ; Código del E en 7 segmentos
        RETLW   0x02        ; Código del - en 7 segmentos
        RETLW   0x00        ; Código del - en 7 segmentos
        ;*****************Tabla3************************
TABLA3  ADDWF   PCL, F
        RETLW   B'11111110' ; Código para habilitar 1 display
        RETLW   B'11111101' ; Código para habilitar 2 display
        RETLW   B'11111011' ; Código para habilitar 3 display
        RETLW   B'11110111' ; Código para habilitar 4 display
        ;Subrutina DELAY
DELAY   MOVLW   0x20        ; Configuramos el tiempo del retardo
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