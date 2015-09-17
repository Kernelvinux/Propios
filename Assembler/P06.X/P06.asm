        ; Autor: Mauricio Galvez Legua
        list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
        ;****************DEFINIENDO VARIABLES*****************
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
        ;*****************************************************
        ORG     0x00        ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISC       ; Configuración del puerto C como salida
        CLRF    TRISD       ; Configuración del puerto D como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;************INICIO PROGRAMA PRINCIPAL*********
        CLRF    PORTC       ; Poner puerto C en cero
        ; Enviando dato a primer display
INICIO  CLRF    PORTD       ; Poner puerto D en cero
        MOVLW   0x40        ; Mover el carcater "-" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CLRF    PORTC       ; Deshabilitar display
        ; Enviando dato a segundo display
        MOVLW   0x40        ; Mover el carcater "-" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        INCF    PORTD,F     ; Enviar dato de W a puerto D
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CLRF    PORTC       ; Deshabilitar display
        ; Enviando dato a tercer display
        MOVLW   0x71        ; Mover letra "F al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        INCF    PORTD,F     ; Enviar dato de W a puerto D
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CLRF    PORTC       ; Deshabilitar display
        ; Enviando dato a cuarto display
        MOVLW   0x06        ; Mover letra "I" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        INCF    PORTD,F     ; Habilitamos segundo display
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CLRF    PORTC       ; Deshabilitar display
        ; Enviando dato a quinto display
        MOVLW   0x79        ; Mover letra "E" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        INCF    PORTD,F     ; Habilitamos tercer display
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CLRF    PORTC       ; Deshabilitar display
        ; Enviando dato a sexto display
        MOVLW   0x79        ; Mover letra "E" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        INCF    PORTD,F     ; Enviar dato de W a puerto D
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CLRF    PORTC       ; Deshabilitar display
        ; Enviando dato a septimo display
        MOVLW   0x40        ; Mover el carcater "-" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        INCF    PORTD,F     ; Enviar dato de W a puerto D
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CLRF    PORTC       ; Deshabilitar display
        ; Enviando dato a octavo display
        MOVLW   0x40        ; Mover el carcater "-" al W
        MOVWF   PORTC       ; Enviar dato de W a puerto C
        INCF    PORTD,F     ; Enviar dato de W a puerto D
        BSF     PCLATH,3    ; Seleccionamos la página 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la página 0
        CLRF    PORTC       ; Deshabilitar display
        GOTO    INICIO      ; Volver al inicio del programa
        ;**********************DELAY**************************
        ORG     0x800       ; Página 1
DELAY   MOVLW   0x15        ; Configuramos el tiempo del retardo
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