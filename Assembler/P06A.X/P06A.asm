        ;Autor: Mauricio Galvez Legua
        list	p=16f877A   ;Indica el tipo de procesador
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Definición de Constantes
        CONSTANT    NUM=.16 ; Valor de los números a contar
        ;Definición de variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
CUENTA  EQU     0x22        ; Variable para almacenar la CUENTA
        ;Configuración de puertos
        ORG     0x000       ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISC       ; Puerto C como salida
        CLRF    TRISD       ; Puerto D como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;Programa Principal
INICIO  CLRF    CUENTA      ; Inicia CUENTA con cero
        CLRF    PORTC       ; Poner puerto C en cero
        MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Pone a un el puerto D
        ; Enviando dato a primer display
VOLVER  MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA       ; Llamada a subrutina TABLA
        MOVWF   PORTC       ; Envia dato de TABLA a puerto C
        BCF     PORTD,0     ; Pone a cero el bit0 del puerto D
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        BSF     PORTD,0     ; Pone a uno el bit0 del puerto D
        INCF    CUENTA,F    ; Incrementa contador CUENTA
        ;Preguntamos si CUENTA = num
        MOVLW   NUM         ; Carga el dato 10 decimal a W
        SUBWF   CUENTA,W    ; W = Cuenta - W
        BTFSS   STATUS,Z    ; Salta si Z=1
        GOTO    VOLVER
        GOTO    INICIO      ; Volver al inicio del programa
        ;Tabla
TABLA   ADDWF   PCL, F
        RETLW   0x3F        ; Código del 0 en 7 segmentos
        RETLW   0x06        ; Código del 1 en 7 segmentos
        RETLW   0x5B        ; Código del 2 en 7 segmentos
        RETLW   0x4F        ; Código del 3 en 7 segmentos
        RETLW   0x66        ; Código del 4 en 7 segmentos
        RETLW   0x6D        ; Código del 5 en 7 segmentos
        RETLW   0x7D        ; Código del 6 en 7 segmentos
        RETLW   0x07        ; Código del 7 en 7 segmentos
        RETLW   0x7F        ; Código del 8 en 7 segmentos
        RETLW   0x67        ; Código del 9 en 7 segmentos
        RETLW   0x77        ; Código del A en 7 segmentos
        RETLW   0x7C        ; Código del B en 7 segmentos
        RETLW   0x39        ; Código del C en 7 segmentos
        RETLW   0x5E        ; Código del D en 7 segmentos
        RETLW   0x79        ; Código del E en 7 segmentos
        RETLW   0x71        ; Código del F en 7 segmentos
        ;Subrutina de DELAY
        ORG     0x800       ; Página 1
DELAY   MOVLW   0xFF        ; Configuramos el tiempo del retardo
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

