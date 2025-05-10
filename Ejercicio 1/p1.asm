include <P16F628A.INC>

	__CONFIG	3F10


	CONT_A	EQU		0x20
	CONT_B	EQU		0x21
	CONT_C	EQU		0X22
	org 0


INICIO
	bsf		STATUS, RP0		;bank 1
	bcf		TRISB, 0
	bcf		TRISB, 1
	bcf		TRISB, 2
	bcf		TRISB, 3	
	bcf		STATUS, RP0		;bank 2
	



LoopPrincipal:				; Crear subrutina LoopEncendido
	bsf		PORTB, 0
	bsf		PORTB, 1
	bsf		PORTB, 2
	bsf		PORTB, 3
	CALL	DEMORA_1S

	bcf		PORTB, 0
	bcf		PORTB, 1
	bcf		PORTB, 2
	bcf		PORTB, 3
	CALL	DEMORA_1S

	GOTO	LoopPrincipal

DEMORA_1MS						;Demora de 1 milisegundo | Necesitamos 1000us = 1ms. 1000us / 4 (ciclos) = 250us
	MOVLW	.250				;Ponemos 250
	MOVWF	CONT_A				;y lo pone en CONT_A
LOOP1
	NOP
	DECFSZ	CONT_A, F			;Decrementa CONT_A hasta 0
	GOTO	LOOP1				;Mientras CONT_A no sea 0, se repite
	RETURN						;Cuando es 0, sale

;------------------------------

DEMORA_250MS						;Demora de 20 milisegundos
	MOVLW	.250					;Como vamos a usar el de 1ms vamos a hacer 20 * 1ms = 20ms
	MOVWF	CONT_B				;y lo pone en CONT_B
LOOP2		
	CALL	DEMORA_1MS			;Llama a la funcion DEMORA_1MS (acá es cuando se multiplica)
	DECFSZ	CONT_B, F			;Decrementa CONT_B hasta 0
	GOTO	LOOP2				;Mientras CONT_B no sea 0, se repite
	RETURN						;Cuando es 0, sale

;---------------------------------

DEMORA_1S						;Demora de 20 milisegundos
	MOVLW	.04  				;Como vamos a usar el de 1ms vamos a hacer 20 * 1ms = 20ms
	MOVWF	CONT_C				;y lo pone en CONT_B
LOOP3	
	CALL	DEMORA_250MS			;Llama a la funcion DEMORA_1MS (acá es cuando se multiplica)
	DECFSZ	CONT_C, F			;Decrementa CONT_B hasta 0
	GOTO	LOOP3				;Mientras CONT_B no sea 0, se repite
	RETURN

	END