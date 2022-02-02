#include <stdio.h>
#include <stdlib.h>
#include <xc.h>

#pragma config CPUDIV=OSC1_PLL2
#pragma config FOSC = HS
#pragma config WDT = OFF
#pragma config PBADEN = OFF
#pragma config LVP = OFF
#pragma config MCLRE = ON
#pragma config PWRT = ON
#pragma config XINST = OFF

int conv = 0;

void main() {
    //Configuracao das entradas e saidas
    TRISAbits.RA0 = 1; //entrada analogica
    TRISCbits.RC1 = 0; //saida lampada

    //Configuracao conversor A/D
    ADCON0bits.CHS = 0b0000; //selecionando canal 0 - RA5
    ADCON1bits.VCFG0 = 0b00; //referencia de tensao = Vss (negativo) e Vdd (positivo)
    ADCON1bits.PCFG = 0b1110; //habilitando pino AN0 como analogico
    ADCON2bits.ADFM = 0; //justificando a esquerda
    ADCON2bits.ADCS = 0b101; //divisao da frequencia de oscilacao por 16
    ADCON2bits.ACQT = 0b110; //tempo de aquisicao de 16*TAD

    //Configuracao do Timer 2
    T2CONbits.T2CKPS = 0b01; //prescaler de 4
    CCP2CONbits.CCP2M = 0b1111; //ccp configurado no modo pwm
    T2CONbits.TMR2ON = 1; //liga timer 2

    ADCON0bits.ADON = 1; //liga conversor a/d
    
    //Item 1 - inicializacao do PWM com 50% de Duty Cycle
    CCP2CONbits.DC2B = 0x00;
    CCPR2L = 0x80;
    
    while(1){
        ADCON0bits.GO = 1;
        while(ADCON0bits.GO == 1){
            CCPR2L = ADRESH;
            CCP2CONbits.DC2B = ADRESL >> 6;
        }
    }
}
