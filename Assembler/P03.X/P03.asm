        ; Primer Programa Ensamblador
        ; Curso: Sistema Basados en Microprocesador
        list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
TIEMPO1 EQU     0X20
TIEMPO2 EQU     0X21
        ORG     0x00        ; Directiva para definir el que origen del codigo esta en la posicion
        BSF     STATUS,RP0  ; Seleccion banco 1
        CLRF    TRISB       ; Configuracion del puerto B como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;************INICIO PROGRAMA PRINCIPAL*********
        CLRF    PORTB       ; Poner puerto C en cero
INICIO  MOVLW   0x3F        ; Mover literal 3F al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x06        ; Mover literal 06 al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x5B        ; Mover literal 5B al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x4F        ; Mover literal 4F al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x66        ; Mover literal 66 al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x6D        ; Mover literal 6D al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x7D        ; Mover literal 7D al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x07        ; Mover literal 07 al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x7F        ; Mover literal 7F al W
        MOVWF   PORTB
        CALL    DELAY
        MOVLW   0x67        ; Mover literal 67 al W
        MOVWF   PORTB
        CALL    DELAY
        GOTO    INICIO
        ;************FIN PROGRAMA PRINCIPAL************
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

