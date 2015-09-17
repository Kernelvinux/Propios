        ; Cuarto Programa Ensamblador
        ; Curso: Sistema Basados en Microprocesador
        list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
TIEMPO1 EQU     0X20
TIEMPO2 EQU     0X21
        ORG     0x00        ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF    TRISC       ; Configuracion del puerto C como salida
        CLRF    TRISD       ; Configuracion del puerto D como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;************INICIO PROGRAMA PRINCIPAL*********
        CLRF    PORTC       ; Poner puerto C en cero
        CLRF    PORTD       ; Poner puerto D en cero
                            ; Enviando dato a primer display
INICIO  MOVLW   0x3F        ; Mover literal 3F al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        BSF     PORTD,0     ; Habilitamos el primer display
        CALL    DELAY       ; Llamada a subrutina
        BCF     PORTD,0     ; Deshabilitamos primer display
                            ; Enviando dato a segundo display
        MOVLW   0x06        ; Mover literal 06 al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        BSF     PORTD,1     ; Habilitamos el segundo display
        CALL    DELAY       ; Llamada a subrutina
        BCF     PORTD,1     ; Deshabilitamos segundo display
        GOTO    INICIO      ; Volver al inicio del programa
        ;*****************DELAY************************
DELAY   MOVLW   0x40        ; Configuramos el tiempo del retardo
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