include <P16F628A.INC>

	__CONFIG	3F10

		org 	0x00
		goto 	Inicio

		org 	0x04

		bcf		INTCON, GIE 	; inhabilito las interrupciones globales
		bcf 	INTCON, INTF 	; bajo el flag de la interrupción

		btfsc	PORTB,1			;el led 1 esta apagado?
		goto	CASE_NO			;si no esta apagado voy al caso no

		btfss	PORTB,1			;el led 1 esta encendido?
		goto	CASE_SI			;si esta apagado voy al caso si
		
FINAL
		retfie 		   			; Return especial para las rutinas de interrupción

CASE_SI:
		btfss	PORTB,2			;el led 2 esta encendido?	
		bsf		PORTB,1			;si no, prendo el led 1
		bcf		PORTB,2			;apago el led 2	
		goto	FINAL

CASE_NO:
		btfsc	PORTB,2			;el led 2 esta apagado?	
		bcf		PORTB,1			;si no, apago el led 1
		bsf		PORTB,2			;enciendo el led 2	
		goto	FINAL

Inicio	bsf 	INTCON,GIE 		; habilito las interrupciones globales
		bsf 	INTCON,INTE		; habilito la interrupción por RB0
		bsf 	STATUS,RP0  	; me muevo al Banco 1
		bcf		OPTION_REG,NOT_RBPU
		movlw 	b'00000001' 	; configuro el TRISB: RB0 entrada y el resto salida
		movwf 	TRISB
		bcf		STATUS, RP0 	; regreso al Banco 0
		
		clrf	PORTB			; pongo a cero los registros del puerto b
		goto 	$           	; esto indica que se hace un loop en la misma posición 



	END