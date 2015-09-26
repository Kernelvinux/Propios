        ;Autor: Mauricio Galvez Legua
        LIST	P=16f877A
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC
        ;Configuracion de variables
COL     EQU     0x20        ; Variable que indica que tecla se esta analizando
        ;Configurando puertos
        ORG     0x00        ; Se define el origen del programa
        BSF     STATUS,RP0  ; Activamos banco 1
        CLRF    TRISB       ; Configuramos puerto B como salida para Display
        CLRF    TRISC       ; Puerto C como salida para filas teclado
        CLRF    TRISD
        COMF    TRISD       ; Puerto D como entrada para las columnas teclado
        BCF     STATUS,RP0  ; Regresamos la banco 0
        ;Programa principal
        CLRF    PORTB       ; Apagamos el display
        CLRF    PORTC       ;
        COMF    PORTC       ; Ponemos a "1" el puerto C
INICIO1 CLRF    COL         ; Iniciamos COL = 0
        BCF     STATUS,C    ; Ponemos el Carry en CERO
INICIO2 RLF     PORTC       ; Rotamos a la izquierda Puerto C
COL1    BTFSS   PORTD,4     ; Leemos primera columna
        CALL    ANTI
        INCF    COL
COL2    BTFSS   PORTD,5     ; Leemos segunda columna
        CALL    ANTI
        INCF    COL
COL3    BTFSS   PORTD,6     ; Leemos tercera columna
        CALL    ANTI
        INCF    COL
COL4    BTFSS   PORTD,7     ; Leemos cuarta columna
        CALL    ANTI
        INCF    COL
        ;Preguntamos si COL = 16
        MOVF    COL,W       ; Cargamos en W el número de teclas
        SUBLW   .16         ; W = 16 - W
        BTFSC   STATUS,Z    ; Preguntamos si COL = 16 (10000)
        GOTO    INICIO1     ; Inicia todo de nuevo
        BSF     STATUS,C    ; Ponemos el Carry en UNO
        GOTO    INICIO2
        ;Subrutina de Antirrebote y Displayado
ANTI    NOP
ANTI1   BTFSS   PORTD,4
        GOTO    ANTI1
ANTI2   BTFSS   PORTD,5
        GOTO    ANTI2
ANTI3   BTFSS   PORTD,6
        GOTO    ANTI3
ANTI4   BTFSS   PORTD,7
        GOTO    ANTI4
        MOVF    COL,W
        CALL    TABLA
        MOVWF   PORTB
        RETURN
        ;Tabla
TABLA   ADDWF   PCL, F
        RETLW   0x3F        ; Código del 0 en 7 segmentos
        RETLW   0x06        ; Código del 1 en 7 segmentos
        RETLW   0x5B        ; Código del 2 en 7 segmentos
        RETLW   0x4F        ; Código del 3 en 7 segmentos
        RETLW   0x66        ; Código del 4 en 7 segmentos
        RETLW   0x6D        ; Código del 5 en 7 segmentos
        RETLW   0x7D        ; Código del 6 en 7 segmentos
        RETLW   0x07        ; Código del 7 en 7 segmentos
        RETLW   0x7F        ; Código del 8 en 7 segmentos
        RETLW   0x67        ; Código del 9 en 7 segmentos
        RETLW   0x77        ; Código del A en 7 segmentos
        RETLW   0x7C        ; Código del B en 7 segmentos
        RETLW   0x39        ; Código del C en 7 segmentos
        RETLW   0x5E        ; Código del D en 7 segmentos
        RETLW   0x79        ; Código del E en 7 segmentos
        RETLW   0x71        ; Código del F en 7 segmentos
        END