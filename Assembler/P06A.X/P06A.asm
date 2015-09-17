        ;Autor: Mauricio Galvez Legua
        list	p=16f877A   ;Indica el tipo de procesador
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Definici�n de Constantes
        CONSTANT    NUM=.16 ; Valor de los n�meros a contar
        ;Definici�n de variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
CUENTA  EQU     0x22        ; Variable para almacenar la CUENTA
        ;Configuraci�n de puertos
        ORG     0x000       ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selecci�n banco 1
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
        BSF     PCLATH,3    ; Seleccionamos la p�gina 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la p�gina 0
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
        RETLW   0x3F        ; C�digo del 0 en 7 segmentos
        RETLW   0x06        ; C�digo del 1 en 7 segmentos
        RETLW   0x5B        ; C�digo del 2 en 7 segmentos
        RETLW   0x4F        ; C�digo del 3 en 7 segmentos
        RETLW   0x66        ; C�digo del 4 en 7 segmentos
        RETLW   0x6D        ; C�digo del 5 en 7 segmentos
        RETLW   0x7D        ; C�digo del 6 en 7 segmentos
        RETLW   0x07        ; C�digo del 7 en 7 segmentos
        RETLW   0x7F        ; C�digo del 8 en 7 segmentos
        RETLW   0x67        ; C�digo del 9 en 7 segmentos
        RETLW   0x77        ; C�digo del A en 7 segmentos
        RETLW   0x7C        ; C�digo del B en 7 segmentos
        RETLW   0x39        ; C�digo del C en 7 segmentos
        RETLW   0x5E        ; C�digo del D en 7 segmentos
        RETLW   0x79        ; C�digo del E en 7 segmentos
        RETLW   0x71        ; C�digo del F en 7 segmentos
        ;Subrutina de DELAY
        ORG     0x800       ; P�gina 1
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

