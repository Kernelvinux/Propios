        ; Primer Programa Modificado
        LIST	P=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
                            ; selecciona el estado de los bits de configuración
        
	;****************DEFINIENDO VARIABLES*****************
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
CUENTA  EQU     0x22        ; Variable CUENTA
        ;*****************************************************
	
        ORG     0x00        ; Se define el inicio del código de programa
        
	;Programamos los puertos
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF    TRISB       ; Configuracion del puerto C como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        
	; Programamos los registros de direccionamiento indirecto
        MOVLW   0x30        ; Cargamos en W dirección inicial de los datos
        MOVWF   FSR         ; Cargamos en FSR el valor de W
        
	; Inicia programa que graba datos en Memoria de Datos
        CLRF    CUENTA      ; Inicializamos CUENTA
VOLVER  MOVF    CUENTA,W
        MOVWF   INDF
        INCF    FSR
        INCF    CUENTA
        MOVLW   .8
        SUBWF   CUENTA,W
        BTFSS   STATUS,Z
        GOTO    VOLVER
        
	; Inicia programa que lee datos en Memoria de Datos
VOLVER3 CLRF    CUENTA      ; Inicializamos CUENTA
        MOVLW   0x30        ; Cargamos en W dirección inicial de los datos
        MOVWF   FSR         ; Cargamos en FSR el valor de W
VOLVER2 MOVF    INDF,W      ; Cargamos lo que hay en la direccion especificada por INDF a W
        MOVWF   PORTB
        CALL    DELAY
        INCF    FSR
        INCF    CUENTA
        MOVLW   .8
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