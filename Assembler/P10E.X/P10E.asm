        ;Autor Piero Torpoco Llacza
	list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuraci�n
        
	;Definici�n de constantes
	CONSTANT    NUM=.32
	
	;Definici�n de variables
TIEMPO1 EQU     0x20        ; Variable para temporizar el DELAY
TIEMPO2 EQU     0x21        ; Variable para temporizar el DELAY
ROTAR   EQU     0x22        ; Variable de rotaci�n para multiplexado
CUENTA  EQU     0x23        ; Variable para almacenar temporalmente la CUENTA
        ORG     0x00        ; Se define el origen del programa
        
	;Configuraci�n de puertos
        BSF     STATUS,RP0  ; Selecci�n banco 1
        CLRF	TRISB       ; Configuraci�n del puerto B como salida
        CLRF	TRISC       ; Configuraci�n del puerto C como salida
        CLRF    TRISD       ; Configuraci�n del puerto D como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        
	;Programa principal
        CLRF    PORTB
        COMF    PORTB       ; Poner puerto B en "uno"
        CLRF    PORTC
        COMF    PORTC       ; Poner puerto C en "uno"
        CALL    APAGAR
INICIO  MOVLW   B'00000000' ; Inicializa la variable ROTAR
        MOVWF   ROTAR       ;
        CLRF    CUENTA      ; Inicia CUENTA con cero
        ;Enviamos dato a primera matriz
VOLVER  MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA1      ; Llamada a subrutina TABLA1
        MOVWF   PORTB       ; Envia dato de TABLA1 a puerto B
        
	;Activamos columna
        MOVF    ROTAR,W     
        MOVWF   PORTD
        CALL    DELAY       ; Llamada a subrutina DELAY
        CALL    APAGAR
        INCF    CUENTA      ; Incrementa contador CUENTA
        BCF     STATUS,C    ; Ponemos CARRY a 0
        INCF    ROTAR
	MOVLW	NUM
	SUBWF	ROTAR,W
        BTFSS   STATUS,Z
        GOTO    VOLVER      ; Volver al inicio del programa
        GOTO    INICIO
        ;Tabla 1
TABLA1  ADDWF   PCL, F
        RETLW   0x00        ; C�digo del 0 en 7 segmentos
        RETLW   0x6F        ; C�digo del 0 en 7 segmentos
        RETLW   0x6F        ; C�digo del 0 en 7 segmentos
        RETLW   0x7F        ; C�digo del 0 en 7 segmentos
        RETLW   0xFF        ; C�digo del 0 en 7 segmentos
        RETLW   0x00        ; C�digo del 1 en 7 segmentos
        RETLW   0xFF        ; C�digo del 2 en 7 segmentos
        RETLW   0x00        ; C�digo del 3 en 7 segmentos
	RETLW   0x6E        ; C�digo del 4 en 7 segmentos
        RETLW   0x6E        ; C�digo del 5 en 7 segmentos
        RETLW   0x7E        ; C�digo del 6 en 7 segmentos
        RETLW   0xFF        ; C�digo del 7 en 7 segmentos
	
        RETLW   0x00        ; C�digo del 0 en 7 segmentos
        RETLW   0x6E        ; C�digo del 0 en 7 segmentos
        RETLW   0x6E        ; C�digo del 0 en 7 segmentos
        RETLW   0x7E        ; C�digo del 0 en 7 segmentos
	RETLW   0xFF        ; C�digo del 0 en 7 segmentos
	
        RETLW   0xEF        ; C�digo del 0 en 7 segmentos
        RETLW   0xEF        ; C�digo del 0 en 7 segmentos
        RETLW   0xEF        ; C�digo del 0 en 7 segmentos
        RETLW   0xFF        ; C�digo del 0 en 7 segmentos
        RETLW   0x00        ; C�digo del 1 en 7 segmentos
        RETLW   0xFE        ; C�digo del 2 en 7 segmentos
        RETLW   0xFE        ; C�digo del 3 en 7 segmentos
        RETLW   0x00        ; C�digo del 4 en 7 segmentos
        RETLW   0xFF        ; C�digo del 5 en 7 segmentos
        RETLW   0x00        ; C�digo del 6 en 7 segmentos
        RETLW   0xCF        ; C�digo del 7 en 7 segmentos
        RETLW   0xF3        ; C�digo del 0 en 7 segmentos
        RETLW   0x00        ; C�digo del 0 en 7 segmentos
        RETLW   0xFF        ; C�digo del 0 en 7 segmentos
        RETLW   0x00        ; C�digo del 0 en 7 segmentos
        ;Subrutina Apaga Matriz

APAGAR  MOVLW   0xFF        ; Cargamos el dato 00 a W
        MOVWF   PORTB       ; "Apagamos tods las columnas de PORTD"
        RETURN
        ;Subrutina de Delay
DELAY   MOVLW   0x03        ; Configuramos el tiempo del retardo
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
        ;Fin
        END