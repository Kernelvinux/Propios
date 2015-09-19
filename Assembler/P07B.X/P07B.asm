        ;Autor: Mauricio Galvez Legua
        LIST	P=16f877A
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Configurando puertos
        ORG     0x00        ;Se define el origen del programa
INICIO  BSF     STATUS,RP0  ;Activamos banco 1
        CLRF    TRISB
        COMF    TRISB       ;Configuramos PORTB como entrada
        CLRF    TRISC       ;Configuramos PORTC como salida
        BCF     STATUS,RP0  ;Regresamos la banco 0
        CLRF    PORTC       ;Iniciamos con 0 los display.
        ;Programa principal
BOTON0  BTFSS   PORTB,0     ;Pregunta por pulsador0
        GOTO    ANTI0
BOTON1  BTFSS   PORTB,1     ;Pregunta por pulsador1
        GOTO    ANTI1
        GOTO    BOTON0
        ;Rutinas de antirebote 0
ANTI0   BTFSS   PORTB,0     ;Pregunta si pulsador0 se ha "soltado"
        GOTO    ANTI0
        INCF    PORTC,F
        GOTO    BOTON1
        ;Rutinas de antirebote 1
ANTI1   BTFSS   PORTB,1     ;Pregunta si pulsador1 se ha "soltado"
        GOTO    ANTI1
        DECF    PORTC,F
        GOTO    BOTON0
        END