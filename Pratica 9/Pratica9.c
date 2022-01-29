#include <xc.h>
#include <stdio.h>
#include <stdlib.h>

#pragma config CPUDIV = OSC1_PLL2
#pragma config FOSC = HS
#pragma config WDT = OFF
#pragma config PBADEN = OFF
#pragma config LVP = OFF
#pragma config MCLRE = ON
#pragma config PWRT = ON
#pragma config XINST = OFF 

int conv = 0;

void main(void) {
    //Configuracao das entradas e saidas
    TRISAbits.RA0 = 1; //entrada analogica
    TRISCbits.RC0 = 0; //saida lampada
    
    //Configuracao do conversor A/D
    ADCON0bits.CHS = 0b0000; //selecionando canal 0 - RA5
    ADCON1bits.VCFG0 = 0b00; //Referencia de tensao = Vss (negativo) e Vdd (positivo)
    ADCON1bits.PCFG = 0b1110 //habilitando pino do AN0 como analogico
    ADCON2bits.ADFM = 0; //justificado a esquerda
    ADCON2bits.ADCS = 0b101; //divisao da freqeuncia de oscilacao por 16
    ADCON2bits.ACQT = 0b110; //tempo de aquisicao de 16*TAD
    
    //Configuracao do Timer 2
    T2CONbits.T2CKPS = 0b01 //prescaler de 4
    CCP2CONbits.CCP2M = 0b1111; //ccp configurado para operar no modo PWM
    T2CONbits.TMR2ON = 1 // liga o Timer 2
    
    ADCON0bits.ADON = 1; //ligar conversor A/D
    
    //Item 1 - inicializacao do PWM com 50% de DC
    CCP2CONbits.DC2B = 0x00;
    CCPR2L = 0x80; //0x80 = 0d128
    
    while (1){
        ADCON0bits.GO = 1; //inicia conversao A/D
        while (ADCON0bits.GO == 1){
            conv = ADRES;
            CCP2CONbits.DC2B = ADRESL >> 6;
        }
        
    }
    
}
