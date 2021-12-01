#include <p18f4550.inc>

    config CPUDIV = OSC1_PLL2;
    config FOSC = HS;
    config WDT = OFF;
    config PBADEN = OFF;
    config LVP = OFF;
    config MCLRE = ON;
    config PWRT = ON;
    #define dL 0x00;
    #define dH 0x01;
    org 0x00;
    ;CONFIGURACOES
    BCF INTCON2,7,0; Habilitando resitor pullup
    MOVLW 0x0F;
    MOVWF ADCON1,0;Desabilitando conversor AD
    MOVLW 0xFF;
    MOVWF TRISB, 0; Configurando portas do port b como entrada
    MOVLW 0x00;
    MOVWF TRISD, 0; Configurando como saida
    MOVWF TRISC, 0; Configurando como saida
;Q1
loop:
    MOVFF PORTB, LATD;
    bra loop;
;Q2
loop:
    BTFSC PORTB, 6, 0;
    BCF LATD, 0, 0;
    BTFSS PORTB, 6, 0;
    BSF LATD, 0, 0;
    bra loop;
;Q3
loop:
    BTFSC PORTB,6,0 ;Testa o pino da chave. Se estiver setado, realiza proximo comando - Buzzer liga
    BSF LATC, 2, 0;Seta pino do buzzer
    MOVLW 0x04
    MOVWF dH
    MOVLW 0xE8
    MOVWF dL

    delay1:
    DECFSZ dL,1,0
    BRA delay1;
    DECFSZ dH,1,0
    BRA delay1;

    BCF LATC, 2, 0;Zera pino do buzzer
    MOVLW 0x04
    MOVWF dH
    MOVLW 0xE8
    MOVWF dL

    delay2:
    DECFSZ dL,1,0
    BRA delay2;
    DECFSZ dH,1,0

    BRA delay2;
    BRA loop
end;
