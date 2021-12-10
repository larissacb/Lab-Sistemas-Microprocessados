#include <p18f4550.inc>

    config CPUDIV = OSC1_PLL2 ;
    config FOSC = HS ;
    config WDT = OFF ;
    config PBADEN = OFF;
    config LVP = OFF ;
    config MCLRE = ON ;
    config PWRT = ON ;
    #define aux 0x05
    #define VA 0x00; Variavel A
    #define VB 0x01; Variavel B
    #define VC 0x02; Variavel C
    #define VR 0x03 ; Resto da divisao

    org 0x00
;Questao 1
; a
LFSR FSR0, 0x300;
MOVLW 0x00;
loop:
    MOVWF POSTINC0, 0; passando o valor do acumulador para o endereço apontado incrementando o contador do ponteiro
    INCF WREG, 0, 0; incrementando o acumulador
    BNC loop;
    BCF STATUS, 0, 0; zerar o bit do carry (bit 0) do STATUS para zerar o contador
; b
LFSR FSR0, 0x300;
LFSR FSR1, 0x400;
loop2:
    MOVFF POSTINC0, POSTINC1; passa o valor apontado pelo ponteiro 0 para o ponteiro 1 e incrementa os dois ponteiros
    INCF WREG, 0, 0; incrementando o acumulador
    BNC loop2;
main:
     BRA main; evitar com que o programa rode infinitamente
end
Questao 2
ResetVector:
    org 0x00
    BRA start
    
start:
    LFSR FSR0, 0x00; Substitui o MOVLW e MOVWF (aponta para o endereço de memoria 00)
    MOVLW 0x04
    MOVWF aux
    MOVLW 0x00
loop:
    MOVWF POSTINC0, 0; Move e incrementa no endereço de memoria 0x00
    ADDLW 1; Soma 1 no acumulador
    DECFSZ aux
    BRA loop
    BRA start
    end

;Questao 3
start:
    MOVLW 0x09; Movendo 9 para o acumulador
    MOVWF VA, 0; Movendo para o endereço de memoria VA, banco de acesso
    MOVLW 0x04; Movendo 4 para acumulador
    MOVWF VB, 0; Movendo para o endereço de memoria VB, banco de acesso
    
    CLRF VC, 0; Limpa o endereço de memoria VC
    CLRF VR, 0; Limpa o endereço de memoria VR
    MOVFF VA, 0x04; Move o valor de VA para uma memoria auxiliar
    
loop:
    INCF VC, 1, 0; Incrementa VC a cada loop, ao final sera o resultado
    SUBWF 0x04, 1, 0; Subtrai na memoria auxiliar o divisor de do dividendo e salva em WREG
    CPFSLT 0x04, 0; Compara o valor na memoria auxiliar com WREG
    BNZ loop ;Enquanto resultado nao for zero, retorna para 'loop'
    MOVFF 0x04, VR; O valor restante na memoria auxiliar é passado para VR
    
    bra start
    end
   
