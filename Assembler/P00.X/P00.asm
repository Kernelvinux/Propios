        ; Primer Programa Ensamblador
        LIST	P=16f877A       ;Indica el tipo de procesador a programar
        INCLUDE	"p16f877a.inc"  ;Incluye en el programa el fichero de definiciones del uC seleccionado
        __CONFIG _CP_OFF& _DEBUG_OFF& _WRT_OFF& _CPD_OFF& _LVP_OFF& _BODEN_OFF& _PWRTE_ON& _WDT_OFF& _XT_OSC    ; selecciona el estado de los bits de configuración

        ORG     0x00        ; Directiva para definir el que origen del codigo esta en la posicion
        BSF     STATUS,RP0  ; Seleccion banco 1
        MOVLW	B'00000000' ; Mover literal 0 al registro W (1=IN 0=OUT)
        MOVWF	TRISD       ; Configuracion del puerto D como salida
        BCF     STATUS,RP0  ; Seleccion banco 0
        ;**************INICIO PROGRAMA PRINCIPAL*********
        CLRF    PORTD       ; Apagamos todos los leds
        MOVLW	B'10101010' ; Cargamos un literal al registro W
        MOVWF	PORTD       ; Enviamos el valor de W al puerto D
        ;**************FIN PROGRAMA PRINCIPAL************
        END

