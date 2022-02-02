// Baseado no programa da questão 1 da Prática 9, modifique apenas a forma de alterar o duty cycle. 
// Ao invés de usar o módulo ADC, utilize duas interrupções externas para aumentar e diminuir o duty cycle em 10% a cada acionamento. 

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
    //Configuracao do kit
    ADCON1 = 0x0F; //desabilitando conversor AD
    INTCON2bits.RBPU = 0; //habilitando resistor pull-up
    
    //Configuracao das entradas e saidas
    TRISAbits.RA0 = 1; //entrada analogica
    TRISCbits.RC1 = 0; //saida lampada
    TRISB = 0xFF; //botoes configurados como entradas
    
    //Configuracao Interrupcao Externa 0
    INTCONbits.INT0IF = 0; //zero a flag
    INTCON2bits.INTEDG0 = 0; //borda de descida
    
    //Configuracao Interrupcao Externa 1
    INTCON3bits.INT1IF = 0; //zero a flag
    INTCON2bits.INTEDG1 = 0; //borda de descida
     
    //Habilitando todas as interrupcoes
    INTCONbits.GIE = 1; //habilitando todas as interrupcoes do uC
    INTCONbits.INT0IE = 1; //habilitando INT0
    INTCON3bits.INT1IE = 1; //habilitando INT1

    //Configuracao do Timer 2
    T2CONbits.T2CKPS = 0b01; //prescaler de 4
    CCP2CONbits.CCP2M = 0b1111; //ccp configurado no modo pwm
    T2CONbits.TMR2ON = 1; //liga timer 2
    
    //Item 1 - inicializacao do PWM com 50% de Duty Cycle
    CCP2CONbits.DC2B = 0x00;
    CCPR2L = 0xFF; //passo metade do valor para a lampada

    
    while(1){
        
    }
}


void interrupt IntExt (void){
    if (INTCONbits.INT0IF == 1){
        INTCONbits.INT0IF = 0; //zera a flag
        CCPR2L-=25; //decremento 10%
        
        if(CCPR2L <= 25) {
            CCPR2L=25; //nao deixo assumir valores menores que 0
        }
    }
    
    if (INTCON3bits.INT1IF == 1){
        INTCON3bits.INT1IF = 0; //zera a flag
        CCPR2L+=25;//incremento 10% 
        
        if(CCPR2L >= 230){
             CCPR2L=230; //nao deixo assumir valores maiores que 255
        }

    }
}
