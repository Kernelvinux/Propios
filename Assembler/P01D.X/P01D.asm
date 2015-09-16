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
        ;Programa primera parte
REPETIR MOVLW   B'10000000' ; Encendemos el bit de mayor peso de PORTD
        MOVWF   PORTD
        MOVLW   B'00000001' ; Encendemos el bit de menor peso de PORTC
        MOVWF   PORTC
VOLVER1 CALL    DELAY
        BCF     STATUS,C    ; Ponemos C a 0
        RRF     PORTD,F     ; Desplazamiento derecha PORTD
        BCF     STATUS,C    ; Ponemos C a 0
        RLF     PORTC,F     ; Desplazamiento izquierda PORTC
        BTFSS   STATUS,C    ; Es C=1?
        GOTO    VOLVER1     ; Regresar
        ;Programa segunda parte
        ;CALL    DELAY
        MOVLW   B'00000001' ; Encendemos el bit de menor peso de PORTD
        MOVWF   PORTD
        MOVLW   B'10000000' ; Encendemos el bit de mayor peso de PORTC
        MOVWF   PORTC
VOLVER2 CALL    DELAY
        BCF     STATUS,C    ; Ponemos C a 0
        RLF     PORTD,F     ; Desplazamiento izquierda PORTD
        BCF     STATUS,C    ; Ponemos C a 0
        RRF     PORTC,F     ; Desplazamiento derecha PORTC
        BTFSS   PORTC,0     ; Es C=1?
        GOTO    VOLVER2     ; Regresar
        GOTO    REPETIR     ; Repetimos todo de nuevo
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