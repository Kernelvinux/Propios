        ; Programa Rotación a la derecha
        LIST	P=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
        ;****************DEFINIENDO VARIABLES*****************
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
        ;*****************************************************
        ORG     0x00        ; Directiva para definir el que origen del codigo esta en la posicion
        BSF     STATUS,RP0  ; Seleccion banco 1
        CLRF 	TRISD       ; Configuracion del puerto D como salida
        BCF     STATUS,RP0  ; Seleccion banco 0
        ;**************INICIO PROGRAMA PRINCIPAL**************
        CLRF    PORTD       ; Apagamos todos los leds
        BSF     STATUS,C    ; Poner el CARRY a 1
VOLVER  RRF     PORTD,F     ; Desplazamiento derecha
        CALL    DELAY       ; Llamada a subrutina de retardo
        GOTO    VOLVER      ; Saltar Volver
        ;***************FIN PROGRAMA PRINCIPAL****************
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
        ;*********************FIN DELAY***********************
        END

