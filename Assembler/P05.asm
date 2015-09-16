        ; Quinto Programa Ensamblador
        ; Curso: Sistema Basados en Microprocesador
        list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"P16F877A.INC"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
        ;****************DEFINIENDO VARIABLES*****************
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
        ;*****************************************************
        ORG     0x00        ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF    TRISC       ; Configuracion del puerto C como salida
        CLRF    TRISD       ; Configuracion del puerto D como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;************INICIO PROGRAMA PRINCIPAL*********
        CLRF    PORTC       ; Poner puerto C en cero
        CLRF    PORTD       ; Poner puerto D en cero
                            ; Enviando dato a primer display
INICIO  MOVLW   0x71        ; Mover letra "F al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        BSF     PORTD,0     ; Habilitamos el primer display
        CALL    DELAY       ; Llamada a subrutina
        BCF     PORTD,0     ; Deshabilitamos primer display
                            ; Enviando dato a segundo display
        MOVLW   0x06        ; Mover letra "I" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        BSF     PORTD,1     ; Habilitamos el segundo display
        CALL    DELAY       ; Llamada a subrutina
        BCF     PORTD,1     ; Deshabilitamos segundo display
                            ; Enviando dato a tercer display
        MOVLW   0x79        ; Mover letra "E" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        BSF     PORTD,2     ; Habilitamos el tercer display
        CALL    DELAY       ; Llamada a subrutina
        BCF     PORTD,2     ; Deshabilitamos tercer display
                            ; Enviando dato a cuarto display
        MOVLW   0x79        ; Mover letra "E" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        BSF     PORTD,3     ; Habilitamos el cuarto display
        CALL    DELAY       ; Llamada a subrutina
        BCF     PORTD,3     ; Deshabilitamos cuarto display
        GOTO    INICIO      ; Volver al inicio del programa
        ;**********************DELAY**************************
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
        ;*********************FIN DELAY***********************
        END




