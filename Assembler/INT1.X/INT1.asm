        ;Autor: Mauricio Galvez Legua
        LIST	P=16f877A
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Definiendo variables
TIEMPO1 EQU     0x20                ;Variable para temporizar DELAY
TIEMPO2 EQU     0x21                ;Variable para temporizar DELAY
        ; Se define el inicio del código de programa
        ORG     0x000
		GOTO	INICIO
        ; Se define el inicio de la rutina de interrupción
		ORG		0x004
		GOTO	INT
        ; Configuración de puertos
INICIO  BSF     STATUS,RP0          ;Selección banco 1
		CLRF	TRISC               ;Puerto C como salida
		CLRF	TRISD               ;Puerto D como salida
        BSF     TRISB,0             ;Bit 0 del puerto B como entrada
        ; Configurando la interrupción RBO/INT
        BSF 	OPTION_REG,INTEDG   ;Configurando flanco de subida
        BCF     INTCON,PEIE         ;Deshabilitamos PEIE
        BSF     INTCON,INTE         ;Habilitamos interrupción de RBO
        BSF     INTCON,GIE          ;Habilitamos las interrupciones generales
        BCF     STATUS,RP0          ;Seleccionando el banco 0
        ;Programa Principal
        BCF		INTCON,INTF         ;Poner a cero el flag de interrupción
        CLRF    PORTC               ;Poner a cero PORTC
		CLRF	PORTD               ;Poner a cero PORTD
PRIN    CALL	DELAY
        INCF	PORTD
		GOTO	PRIN
        ;Inicio de rutina de Interrupción
INT     INCF	PORTC
		BCF		INTCON,INTF         ;Poner a cero el flag de interrupción
		RETFIE
        ;Subrutina de DELAY
DELAY   MOVLW   0xFF                ;Configuramos el tiempo del retardo
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