        ;Autor: Mauricio Galvez Legua
        LIST	P=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
                            ; selecciona el estado de los bits de configuración
        ;Definiendo variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
CUENTA  EQU     0x22        ; Variable CUENTA
        CONSTANT   direccion=0x30
        CONSTANT   tamaño=.8
        ;Inicio del programa
        ORG     0x00        ; Se define el inicio del código de programa
        ;Programamos los puertos
        BSF     STATUS,RP0  ; Selección banco 1
        BSF     TRISB,0     ; Configuramos RBO como entrada para el pulsador
        CLRF    TRISC       ; Configuracion del puerto C como salida
        CLRF    TRISD
        COMF    TRISD,F     ; Configuracmos el puerto D como entrada
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ; Programamos FSR con la dirección inicial donde se almacenará los datos
        MOVLW   direccion   ; Cargamos en W dirección inicial de los datos
        MOVWF   FSR         ; Cargamos en FSR el valor de W
        ; Inicia programa que graba datos en Memoria de Datos
        CLRF    CUENTA      ; Inicializamos CUENTA
        CLRF    PORTC       ; Inicializamos PORTC
BOTON   BTFSC   PORTB,0
        GOTO    BOTON
ANTI    BTFSS   PORTB,0
        GOTO    ANTI
        MOVF    PORTD,W
        MOVWF   INDF
        INCF    FSR
        INCF    CUENTA
        MOVLW   tamaño
        SUBWF   CUENTA,W
        BTFSS   STATUS,Z
        GOTO    BOTON
        ; Inicia programa que lee datos en Memoria de Datos
VOLVER3 CLRF    CUENTA      ; Inicializamos CUENTA
        MOVLW   direccion   ; Cargamos en W dirección inicial de los datos
        MOVWF   FSR         ; Cargamos en FSR el valor de W
VOLVER2 MOVF    INDF,W      ; Cargamos lo que hay en la direccion especificada por INDF a W
        MOVWF   PORTC
        CALL    DELAY
        INCF    FSR
        INCF    CUENTA
        MOVLW   tamaño
        SUBWF   CUENTA,W
        BTFSS   STATUS,Z
        GOTO    VOLVER2
        GOTO    VOLVER3
        ;Subrutina de Delay
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