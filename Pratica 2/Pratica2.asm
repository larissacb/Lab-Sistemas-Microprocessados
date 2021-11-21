#include <p18f4550.inc>
config CPUDIV = OSC1_PLL2 ;
config FOSC = HS ;
config WDT = OFF ;
config PBADEN = OFF ;
config LVP = OFF ;
config MCLRE = ON ;
config PWRT = ON ;
    
#define VaL 0x00;
#define VaH 0x01;
#define VbL 0x02;
#define VbH 0x03;

org 0x00
loop:
;Questão 1
;a
    MOVLW 0x8 ;Carregando 8 no acumulador
    MOVWF 0x00, 0 ;Movendo para o endereco 0x00 do banco de acesso
    MOVLW 0xA ;Carregando 10 no acumulador
    ADDWF 0x00, 0, 0 ;Somando o valor, carregando o valor em W, banco de acesso

;b
    MOVLW 0x8 ;Carregando 8 no acumulador
    MOVWF 0x00, 0 ;Movendo para o endereco 0x00 do banco de acesso
    MOVLW 0x78 ;Carregando 120 no acumulador
    ADDWF 0x00,0,0 ;Somando o valor, carregando o valor em W, banco de acesso

;c
    MOVLW 0x8 ;Carregando 8 no acumulador
    MOVWF 0x00,0 ;Movendo para o endereco 0x00 do banco de acesso
    MOVLW 0xFA ;Carregando 250 no acumulador
    ADDWF 0x00,0,0 ;Somando o valor, carregando o valor em W, banco de acesso

;Questão 2
;a
    MOVLW 0xFA ;Carregando 250 no acumulador
    MOVWF VbL, 0 ;Movendo para o endereco definido para VbL do banco de acesso
    MOVLW 0x07 ;Carregando 7 no acumulador
    MOVWF VaL, 0 ;Movendo para o endereco definido para VaL do banco de acesso
    ADDWF VbL, 1, 0 ;Somando o valor, carregando o valor em VbL, banco de acesso

;b
    MOVLW 0x7F ;Carregando 127 no acumulador
    MOVWF VbL, 0 ;Movendo para o endereco definido para VbL do banco de acesso
    MOVLW 0x03 ;Carregando 3 no acumulador
    MOVWF VaL, 0 ;Movendo para o endereco definido para VaL do banco de acesso
    ADDWF VbL, 1, 0 ;Somando o valor, carregando o valor em VbL, banco de acesso

;c
    MOVLW 0x0B ;Carregando 11 no acumulador
    MOVWF VbL, 0 ;Movendo para o endereco definido para VbL do banco de acesso
    MOVLW 0x03 ;Carregando 3 no acumulador
    MOVWF VaL, 0 ;Movendo para o endereco definido para VaL do banco de acesso
    SUBWF VbL, 1, 0 ;Subtraindo o valor, carregando o resultado em VbL, banco de acesso

;Questão 3
;a
;0d500 = 0x01F4
;0d300 = 0x012C
;Resultado 0d800 = 0x0320
    MOVLW 0xF4 ;Carregando a parcela menos significativa de 0x01F4 no W
    MOVWF VbL, 0 ;Movendo para o endereco definido para VbL do banco de acesso
    MOVLW 0x2C ;Carregando a parcela menos significativa de 0x012C no W
    MOVWF VaL, 0 ;Movendo para o endereco definido para VaL do banco de acesso
    ADDWF VbL,1,0 ;Somando, carregando o resultado em VbL, banco de acesso
    
    MOVLW 0x01 ;Carregando a parcela mais significativa de 0x01F4 no W
    MOVWF VbH, 0 ;Movendo para o endereco definido para VbH do banco de acesso
    MOVLW 0x01 ;Carregando a parcela mais significativa de 0x012C no W
    MOVWF VaH, 0 ;Movendo para o endereco definido para VaH do banco de acesso
    ADDWFC VbH,1,0 ;Somando considerando o CARRY, carregando o resultado em VbH, banco de acesso
    
    
;b
;0d100 = 0x0064
;0d90 = 0x005A
;Resultado 0d190 = 0x00BE
    MOVLW 0x64 ;Carregando a parcela menos significativa de 0x0064 no W
    MOVWF VbL, 0 ;Movendo para o endereco definido para VbL do banco de acesso
    MOVLW 0x5A ;Carregando a parcela menos significativa de 0x005A no W
    MOVWF VaL, 0 ;Movendo para o endereco definido para VaL do banco de acesso
    ADDWF VbL,1,0 ;Somando, carregando o resultado em VbL, banco de acesso
    
    MOVLW 0x00 ;Carregando a parcela mais significativa de 0x0064 no W
    MOVWF VbH, 0 ;Movendo para o endereco definido para VbH do banco de acesso
    MOVLW 0x00 ;Carregando a parcela mais significativa de 0x005A no W
    MOVWF VaH, 0 ;Movendo para o endereco definido para VaH do banco de acesso
    ADDWFC VbH,1,0 ;Somando considerando o CARRY, carregando o resultado em VbH, banco de acesso
    
;c
;0d500 = 0x01F4
;0d300 = 0x012C
;Resultado 0d200 = 0x00C8
    
    MOVLW 0xF4 ;Carregando a parcela menos significativa de 0x01F4 no W
    MOVWF VbL, 0 ;Movendo para o endereco definido para VbL do banco de acesso
    MOVLW 0x2C ;Carregando a parcela menos significativa de 0x012C no W
    MOVWF VaL, 0 ;Movendo para o endereco definido para VaL do banco de acesso
    SUBWF VbL,1,0 ;Subtraindo, carregando o resultado em VbL, banco de acesso
    
    MOVLW 0x01 ;Carregando a parcela mais significativa de 0x01F4 no W
    MOVWF VbH, 0 ;Movendo para o endereco definido para VbH do banco de acesso
    MOVLW 0x01 ;Carregando a parcela mais significativa de 0x012C no W
    MOVWF VaH, 0 ;Movendo para o endereco definido para VaH do banco de acesso
    SUBWFB VbH,1,0 ;Subtraindo considerando o BORROW, carregando o resultado em VbH, banco de acesso  
    
;Questão 4
;A = 0xAA
;B = 0x11
;Resultado = 0x1A
    MOVLW 0xAA ;Carregando 0xAA no acumulador
    MOVWF 0x10,0 ;Movendo para o endereço 0x10 do banco de acesso
    MOVLW 0x0F ;Mascara para os bits menos significativos
    ANDWF 0x10,0 ;Realiza a Op Logica AND e salva em W
    MOVWF 0x20,0 ;Movendo para o endereço 0x20 do banco de acesso
    
    MOVLW 0x11 ;Carregando 0x11 no acumulador
    MOVWF 0x11,0 ;Movendo para o endereço 0x11 do banco de acesso
    MOVLW 0xF0 ;Mascara para os bits menos significativos
    ANDWF 0x11,0 ;Realiza a Op Logica AND e salva em W
    
    IORWF 0x20,0 ;Realiza a Op Logica OR com o o que foi salvo em 0x20 e salva em W
    MOVWF 0x30,0 ;Movendo para o endereço 0x30 do banco de acesso
    
;Questão 5
;VB = 0d12 = 0x0C
;VA = 0d6 = 0x06
    MOVLW 0x0C ;Carregando 0x0C no acumulador
    MOVWF 0x40,0 ;Movendo para o endereço 0x40 do banco de acesso
    ;Divisao por 4 usando o deslocamento de bits
    RRNCF 0x40,1,0 ;Deslocamento de bits para a direita (dividir por 2) salvando no endereço 0x40 banco de acesso
    RRNCF 0x40,1,0 ;Deslocamento de bits para a direita (dividir por 2) salvando no endereço 0x40 banco de acesso
    
    MOVLW 0x06 ;Carregando 0x06 no acumulador 
    MOVWF 0x41,0 ;Movendo para o endereço 0x41 do banco de acesso
    ;Multiplicação por 2 usando o deslocamento de bits
    RLNCF 0x41,0,0 ;Deslocamento de bits para a esquerda (multiplicar por 2) salvando W, banco de acesso
    ;VC = VB/4 + 2*VA
    ADDWF 0x40,0,0 ;Somando o resultado salvo em W com o valor em 0x40, banco de acesso. Resultado da operação salvo em W
    MOVWF 0x42,0 ;Movendo o valor do resultado (VC) para o endereço 0x42 do banco de acesso
    end;
end
