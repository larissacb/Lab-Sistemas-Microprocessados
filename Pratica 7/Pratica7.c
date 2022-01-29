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

#define _XTAL_FREQ 4000000

int cont = 0;
void main(int argc, char** argv) {

    //Declaracao de variaveis
    char num[10] = {0b00111111, 0b00000110, 0b01011011, 0b1001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111};
    
    //Configuracoes
    TRISD = 0x00; //saida 7 seg
    TRISA = 0x00; //saida transistor de acionamento
    ADCON1 = 0x0F; //desabilita conversor AD

    TMR0L = 0x69;
    TMR0H = 0x67;

    T0CON = 0x86;
    
    INTCONbits.GIE = 1;
    INTCONbits.TMR0IE = 1;

    while(1){
        LATAbits.LA5 = 1;
        LATD = num[cont];
        if (cont == 10){
            cont = 0;
        }
    }
}

void interrupt IntTimer (void){
    if (INTCONbits.TMR0IF == 1){
        INTCONbits.TMR0IF = 0; //zera a flag
        TMR0L = 0x69;
        TMR0H = 0x67;
        cont++;
    }
}

