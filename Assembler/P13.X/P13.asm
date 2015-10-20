        ;Autor: Mauricio Galvez Legua
        LIST	P=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
                            ; selecciona el estado de los bits de configuración
        ;Definiendo variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
CUENTA  EQU     0x22        ; Variable CUENTA
CURSOR  EQU     0x23        ; Variable que indica la siguiente
                            ; posición de memoria ibre
TEMPFSR EQU     0x24        ; Variable para almacenar temporalmente el FSR
TEMP    EQU     0x25        ; Variable para almacenar temporalmente a W
        CONSTANT   direccion=0x30   ; Direción inicial de memoria de datos
        CONSTANT   tamaño=.8        ; Número de display
        
	; Se define el inicio del código de programa
        ORG     0x00
		GOTO	INICIO
        ; Se define el inicio de la rutina de interrupción
		ORG		0X04
		GOTO	INT
        ;Programamos los puertos
INICIO  BSF     STATUS,RP0  ; Selección banco 1
        BSF     TRISB,0     ; Configuramos RBO como entrada para el pulsador
        CLRF    TRISC       ; Configuracion del puerto C como salida
        CLRF    TRISD       ; Configuración del puerto D
        COMF    TRISD,F     ; como entrada
        ; Configurando la interrupción RBO/INT
        MOVLW	B'01000000' ; Configurando flanco de subida
        MOVWF	OPTION_REG  ;
	MOVLW	B'10010000' ; Habilitamos GIE e INTE
        MOVWF	INTCON
        BCF     STATUS,RP0  ; Seleccionando el banco 0
	
        ; Programamos FSR con la dirección inicial donde se almacenará los datos
        MOVLW   direccion   ; Cargamos la dirección inicial de los datos en W
        MOVWF   FSR         ; Cargamos en FSR el valor de W
        MOVWF   CURSOR      ; Cargamos en CURSOR el valor de W
        CLRF    PORTC       ; Inicializamos PORTC
        ; Inicia programa que lee datos en Memoria de Datos
VOLVER3 CLRF    CUENTA      ; Inicializamos CUENTA
        MOVLW   direccion   ; Cargamos en W dirección inicial de los datos
        MOVWF   FSR         ; Cargamos en FSR el valor de W
VOLVER2 MOVF    INDF,W      ; Cargamos lo que hay en la direccion especificada por INDF a W
        MOVWF   PORTC       ; Cargamos W a PORTC
        CALL    DELAY
        INCF    FSR
        INCF    CUENTA
        MOVLW   tamaño      ; Detectamos si cuenta
        SUBWF   CUENTA,W    ; es igual
        BTFSS   STATUS,Z    ; a tamaño
        GOTO    VOLVER2
        GOTO    VOLVER3
        ;Subrutina de interrupcion
INT     MOVWF   TEMP        ; Guardamos temporalmente el valor de W
        MOVF    FSR,W       ; Guardamos temporalmente el valor de FSR
        MOVWF   TEMPFSR     ; en la variable TEMPFSR
        ; Cargamos el cursor en FSR
        MOVF    CURSOR,W    ; Cargamos en W el valor de cursor
        MOVWF   FSR         ; Cargamos en FSR el valor de W
        ; Leemos dato del PORTD y lo almacenamos en memoria de datos
        MOVF    PORTD,W     ; Cargamos el dato del PORTD en W
        MOVWF   INDF        ; Guardamos el dato en memoria.
        INCF    CURSOR
        MOVF    TEMPFSR,W   ; Recuperamos el valor de FSR
        MOVWF   FSR         ; almacenado en TEMPFSR
        MOVF    TEMP,W      ; Restauramos el valor de W
		BCF		INTCON,1
		RETFIE
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