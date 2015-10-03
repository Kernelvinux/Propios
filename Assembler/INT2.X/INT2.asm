        ; Curso de Microcontroladores
        LIST	P=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Definiendo las variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
        ;*****************************************************
        ;Se define el inicio del c�digo de programa
        ORG     0x00
		GOTO	INICIO
        ;Se define el inicio de la rutina de interrupci�n
		ORG		0X04
		GOTO	INT
        ;Configuraci�n de puertos
INICIO  BSF     STATUS,RP0  ; Selecci�n banco 1
		CLRF	TRISB       ;
        COMF    TRISB       ; Puerto B como entrada
		CLRF	TRISD       ; Puerto D como salida
        ;Configurando la interrupci�n RBO/INT
        MOVLW	B'01000000' ; Configurando flanco de subida
        MOVWF	OPTION_REG  ;
		MOVLW	B'10010000' ; Habilitamos GIE e INTE
        MOVWF	INTCON
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;Inicio de programa principal
        BCF		INTCON,1    ; Poner a cero el flag de interrupci�n
        CLRF    PORTD       ; Poner puerto D en cero
PRIN    NOP
		GOTO	PRIN
        ;Inicio de rutina de interrupci�n
INT     SWAPF   PORTB,W
        ANDLW   B'00001111'
        CALL    TABLA
        MOVWF   PORTD
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
        ;Tabla
TABLA   ADDWF   PCL, F
        RETLW   0x06        ; C�digo del 1 en 7 segmentos
        RETLW   0x66        ; C�digo del 4 en 7 segmentos
        RETLW   0x07        ; C�digo del 7 en 7 segmentos
        RETLW   0x71        ; C�digo del F en 7 segmentos
        RETLW   0x5B        ; C�digo del 2 en 7 segmentos
        RETLW   0x6D        ; C�digo del 5 en 7 segmentos
        RETLW   0x7F        ; C�digo del 8 en 7 segmentos
        RETLW   0x3F        ; C�digo del 0 en 7 segmentos
        RETLW   0x4F        ; C�digo del 3 en 7 segmentos
        RETLW   0x7D        ; C�digo del 6 en 7 segmentos
        RETLW   0x67        ; C�digo del 9 en 7 segmentos
        RETLW   0x79        ; C�digo del E en 7 segmentos
        RETLW   0x77        ; C�digo del A en 7 segmentos
        RETLW   0x7C        ; C�digo del B en 7 segmentos
        RETLW   0x39        ; C�digo del C en 7 segmentos
        RETLW   0x5E        ; C�digo del D en 7 segmentos
        END