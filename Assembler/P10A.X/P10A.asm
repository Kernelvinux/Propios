        list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
ROTAR   EQU     0x22        ; Variable de rotación para multiplexado
CUENTA  EQU     0x23        ; Variable para almacenar temporalmente la CUENTA
        ORG     0x00        ; Se define el origen del programa
        ;************CONFIGURACIÓN DE PUERTOS*********
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISB       ; Configuración del puerto C como salida
        CLRF    TRISD       ; Configuración del puerto D como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;************INICIO PROGRAMA PRINCIPAL*********
        CLRF    PORTB       ; Poner puerto B en cero
        CALL    APAGAR
INICIO  MOVLW   B'11111110' ; Inicializa la variable ROTAR
        MOVWF   ROTAR       ;
        CLRF    CUENTA      ; Inicia CUENTA con cero
VOLVER  MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA       ; Llamada a subrutina TABLA
        MOVWF   PORTB       ; Envia dato de TABLA a puerto B
        MOVF    ROTAR,W     ;
        MOVWF   PORTD
        CALL    DELAY       ; Llamada a subrutina DELAY
        CALL    APAGAR
        INCF    CUENTA      ; Incrementa contador CUENTA
        BSF     STATUS,C    ; Ponemos CARRY a 1
        RLF     ROTAR,F
        BTFSC   STATUS,C
        GOTO    VOLVER      ; Volver al inicio del programa
        GOTO    INICIO
        ;*****************TABLA************************
TABLA   ADDWF   PCL, F
        RETLW   0x3C        ; Código del 0 en 7 segmentos
        RETLW   0x42        ; Código del 1 en 7 segmentos
        RETLW   0x42        ; Código del 2 en 7 segmentos
        RETLW   0x42        ; Código del 3 en 7 segmentos
        RETLW   0x7E        ; Código del 4 en 7 segmentos
        RETLW   0x42        ; Código del 5 en 7 segmentos
        RETLW   0x42        ; Código del 6 en 7 segmentos
        RETLW   0x42        ; Código del 7 en 7 segmentos
        ;************APAGAR DISPLAY********************
APAGAR  MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Pone 1?s a todos los bits del puerto D
        RETURN
        ;*****************DELAY************************
DELAY   MOVLW   0x08        ; Configuramos el tiempo del retardo
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
        ;**************FIN DELAY***********************
        END