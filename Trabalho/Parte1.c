

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
/*
 * 
 */
int i = 0, u = 0, d = 0, c = 0, m = 0;

void main() {

    //Declaracao de variaveis
    char num[10] = {0b00111111, 0b00000110, 0b01011011, 0b1001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111};
    
    //Configuracoes
    TRISD = 0x00; //saida 7 seg
    TRISA = 0x00; //saida transistor de acionamento
    TRISE = 0x00; //saida transistor de acionamento
    ADCON1 = 0x0F; //desabilita conversor AD

    LATAbits.LA5 = 0;
    LATAbits.LA2 = 0;
    LATEbits.LE0 = 0;
    LATEbits.LE2 = 0;

    TMR0L = 0xD9;
    TMR0H = 0xFF;

    T0CON = 0x86;
    
    INTCONbits.GIE = 1;
    INTCONbits.TMR0IE = 1;

    while(1){
        if (i == 1000){
            
            i=0;
            u++;
            
            if (u == 10){ //primeiro display - unidade dos segundos
                u=0;
                d++;

                if(d == 6){ //segundo display - dezena dos segundos
                    d=0;
                    c++;
                    
                    if (c == 10){ //terceiro display - unidade dos minutos
                        c=0;
                        m++;
                        
                        if(m == 6){ //quarto display - dezena dos minutos
                            m=0;
                        }  
                    }
                }   
            }
            
        }

        //unidade dos segundos
        if (i%2 == 0){ //impar aqui estava i%2 == 1
           LATAbits.LA5 = 0; //desligo a dezena dos minutos
           LATAbits.LA2 = 0; //desliga a unidade dos minutos
           LATEbits.LE0 = 0; //desliga dezena dos segundos
           LATEbits.LE2 = 1; //liga unidade dos segundos

           LATD = num[u]; //atualizo unidade dos segundos
        }

        //dezena dos segundos
        if (i%2 == 1){ //aqui estava i%2 == 0
            LATAbits.LA5 = 0; //desligo a dezena dos minutos
            LATAbits.LA2 = 0; //desliga a unidade dos minutos
            LATEbits.LE2 = 0; //desligo a unidade dos segundos
            LATEbits.LE0 = 1; //liga a dezena dos segundos
            
            LATD = num[d]; //atualizo dezena dos segundos
        }
        
        //unidade dos minutos
        if (i%3 == 2){ 
            LATAbits.LA5 = 0; //desligo a dezena dos minutos
            LATEbits.LE0 = 0; //desliga a dezena dos segundos
            LATEbits.LE2 = 0; //desligo a unidade dos segundos
            LATAbits.LA2 = 1; //liga a unidade dos minutos
            
            LATD = num[c]; //atualizo unidade dos minutos
        }
        
        //dezena dos minutos
        if (i%4 == 3){ 
            LATAbits.LA2 = 0; //desliga a unidade dos minutos
            LATEbits.LE0 = 0; //desliga a dezena dos segundos
            LATEbits.LE2 = 0; //desligo a unidade dos segundos
            LATAbits.LA5 = 1; //liga a dezena dos minutos
            
            LATD = num[m]; //atualizo dezena dos minutos
        }
    }
}

void interrupt IntTimer (void){
    if (INTCONbits.TMR0IF == 1){
        INTCONbits.TMR0IF = 0; //zera a flag
        TMR0L = 0xD9;
        TMR0H = 0xFF;
        i++;
    }
}

