        ;Autor: Mauricio Galvez Legua
        LIST	P=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
        ;Definiendo variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
        ;Configurando puertos
        ORG     0x00        ; Dirección inicial del programa
        BSF     STATUS,RP0  ; Seleccion banco 1
        CLRF 	TRISC       ; Configuracion de PORTC como salida
        CLRF 	TRISD       ; Configuracion de PORTD como salida
        BCF     STATUS,RP0  ; Seleccion banco 0
        ;Programa con PORTD
REPITE  CLRF    PORTC       ; Inicializamos con CERO el PORTC
        MOVLW   B'10000000' ; Encendemos el bit de mayor peso de PORTD
        MOVWF   PORTD
VOLVER1 CALL    DELAY       ; Llamada a subrutina de retardo
        BCF     STATUS,C    ; Poner el CARRY a 0
        RRF     PORTD,F     ; Desplazamiento derecha
        BTFSS   STATUS,C    ; Es C=1?
        GOTO    VOLVER1     ; Regresar
        ;Programa con PORTC
        CLRF    PORTD       ; Inicializamos con CERO el PORTD
        MOVLW   B'10000000' ; Encendemos el bit de mayor peso de PORTC
        MOVWF   PORTC
VOLVER2 CALL    DELAY       ; Llamada a subrutina de retardo
        BCF     STATUS,C    ; Poner el CARRY a 0
        RRF     PORTC,F     ; Desplazamiento derecha
        BTFSS   STATUS,C    ; Es C=1?
        GOTO    VOLVER2     ; Saltar Volver
        GOTO    REPITE      ; Repetimos todo de nuevo
        ;Subrutina de DELAY
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

