        ;Modulador PSK - Autor Piero Torpoco Llacza
	list	p=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración
        
	
	;Definición de variables
CUENTA  EQU     0x23        ; Variable para almacenar temporalmente la CUENTA
TEMP	EQU	0x24
        ORG     0x00        ; Se define el origen del programa
        
	;Configuración de puertos
        BSF     STATUS,RP0  ; Selección banco 1
        CLRF	TRISB       
	COMF	TRISB	    ; Puerto B como entrada
        CLRF	TRISC       
	COMF	TRISC	    ; Puerto C como entrada
        CLRF    TRISD       ; Puerto D como salida
        BCF     STATUS,RP0  ; Seleccionando el banco 0
        
	;Programa principal
	CLRF	PORTD
INICIO  MOVF	PORTC,W
        MOVWF   CUENTA      

        ;Enviamos dato a primera matriz
	MOVF    CUENTA,W    ; Cargamos CUENTA a W
        CALL    TABLA1      ; Llamada a subrutina TABLA1
        MOVWF   TEMP 
	MOVF	TEMP,W
	ANDWF	PORTB,W
	MOVWF	PORTD
	GOTO	INICIO
        
        ;Tabla 1
TABLA1  ADDWF   PCL, F
        RETLW   0X01        
        RETLW   0x03        
        RETLW   0x07        
        RETLW   0x0F        
        RETLW   0x1F        
        RETLW   0x3F        
        RETLW   0x7F        
        RETLW   0xFF        
	


        END