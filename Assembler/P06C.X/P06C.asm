        ;Autor Mauricio Galvez Legua
        list	p=16f877A       ;Indica el tipo de procesador
        INCLUDE	"p16f877a.inc"
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuraci�n
        ;Definici�n de Constantes
        CONSTANT    NUM=.8 ; N�mero de display
        ;Definici�n de variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
ROTAR   EQU     0x22        ; Variable de rotaci�n para multiplexado
CUENTA  EQU     0x23        ; Variable para almacenar la posici�n en la tabla
        ;Configuraci�n de puertos
        ORG     0x000       ; Se define el origen del programa
        BSF     STATUS,RP0  ; Selecci�n banco 1
        CLRF	TRISC       ; PORTC como salida
        CLRF    TRISD       ; PORTD como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        ;Programa Principal
INICIO  MOVLW   B'11111110' ; Inicializa la variable ROTAR
        MOVWF   ROTAR       ;
        CLRF    CUENTA      ; Inicia CUENTA con cero
        CLRF    PORTC       ; Poner PORTC en cero
        CALL    APAGAR
VOLVER  MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA       ; Llamada a subrutina TABLA
        MOVWF   PORTC       ; Envia dato de TABLA a PORTC
        MOVF    ROTAR,W     ;
        MOVWF   PORTD
        BSF     PCLATH,3    ; Seleccionamos la p�gina 1
        CALL    DELAY       ; Llamada a subrutina DELAY
        BCF     PCLATH,3    ; Seleccionamos la p�gina 0
        CALL    APAGAR
        BSF     STATUS,C    ; Ponemos CARRY a 1
        RLF     ROTAR,F
        INCF    CUENTA,F    ; Incrementa contador CUENTA
        ;Preguntamos si CUENTA = NUM
        MOVLW   NUM         ; Carga el n�mero de display en W
        SUBWF   CUENTA,W    ; W = Cuenta - W
        BTFSS   STATUS,Z    ; Salta si Z=1
        GOTO    VOLVER      ; Volver al inicio del programa
        GOTO    INICIO
        ;Tabla
TABLA   ADDWF   PCL, F
        RETLW   0x71        ; C�digo de F en 7 segmentos
        RETLW   0x06        ; C�digo de I en 7 segmentos
        RETLW   0x79        ; C�digo de E en 7 segmentos
        RETLW   0x79        ; C�digo de E en 7 segmentos
        RETLW   0x40        ; C�digo de - en 7 segmentos
        RETLW   0x79        ; C�digo de U en 7 segmentos
        RETLW   0x40        ; C�digo de n en 7 segmentos
        RETLW   0x40        ; C�digo de I en 7 segmentos
        ;Subrutina Apagar Todos los Display
APAGAR  MOVLW   0xFF        ; Cargamos el dato FF a W
        MOVWF   PORTD       ; Pone 1?s al puerto D
        RETURN
        ;Subrutina DELAY
        ORG     0x800       ; P�gina 1
DELAY   MOVLW   0x10        ; Configuramos el tiempo del retardo
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
