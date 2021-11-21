#include <p18f4550.inc>
config CPUDIV = OSC1_PLL2 ;
config FOSC = HS ;
config WDT = OFF ;
config PBADEN = OFF ;
config LVP = OFF ;
config MCLRE = ON ;
config PWRT = ON ;

org 0x00
loop:

	MOVLW 0x5A ;item a
	MOVWF 0x00, 0 ;item b
	MOVFF 0x000, 0x3AA; item c - movendo do endereco 0x000 para o endereco 0x3AA
	;item d
	MOVLB 0x5 ;selecionando banco 5
	MOVWF 0xAA, 1 ;movendo o valor do acumulador para o endereco 0xAA do banco 5
end
