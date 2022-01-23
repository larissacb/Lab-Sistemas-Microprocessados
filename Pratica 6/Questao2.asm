    #include <p18f4550.inc>
    config CPUDIV = OSC1_PLL2 ;
    config FOSC = HS ;
    config WDT = OFF ;
    config PBADEN = OFF;
    config LVP = OFF ;
    config MCLRE = ON ;
    config PWRT = ON ;

    #define TMRL 0x69;
    #define TMRH 0x67;
    org 0x00;
    bra start

    org 0x0200
start:
    BCF INTCON2,7,0 ;Habilitando resistor pull-up
    MOVLW 0x0F
    MOVWF ADCON1,0 ;Desativar conversor A/D

    ;Confirugacao dos pinos
    BCF TRISE, 0; configuração do LED Bicolor RE0
    BCF TRISE, 1; configuração do LED Bicolor RE1

    MOVLW 0xFF;
    MOVWF TRISB; Configurando todo o PORTB para ser entrada

    BCF TRISD, 0; Configurando pino do LED vermelho como saida
    BCF TRISC, 2; Configurando pindo do Buzzer como saida

    ;Borda de sensibilidade
    BCF INTCON2, 6; Configurando borda de sensibilidade de INT0 - borda de descida
    BCF INTCON2, 5; Configurando borda de sensibilidade de INT1 - borda de descida

    ;Configuracoes das Interrupcoes
    BSF INTCON, 7; setando o bit do GIE
    BSF INTCON, 5; setando o bit do TIMEROIE
    BCF INTCON, 2; zerando o bit da flag do Timer
    BCF INTCON, 1; zerando o bit da flag de INT0
    BCF INTCON3, 0; zerando o bit da flag de INT1

    BSF INTCON, 4; Habilita INT0
    BSF INTCON3, 3; Habilita INT1

    ;Configuracao inicial T0START
    MOVLW TMRL
    MOVWF 0x00,0;
    MOVLW TMRH;
    MOVWF 0x01, 0;

    MOVFF 0x00, TMR0L;
    MOVFF 0x01, TMR0H;

    ;Configuracoes do timer 0
    MOVLW 0x06 ;Definindo o prescaler como 128
    MOVWF T0CON;
    BCF T0CON, 6; Definindo timer 0 como de 16 bits

    ;Estado Incial do Led Bicolor
    BSF LATE, 0;Setando bit 0 do LATE - Led Bicolor
    BCF LATE, 1;Zerando bit 1 do LATE - Led bicolor

loop:

    bra loop

inttimer:
     BCF INTCON, 2; zerando o bit da flag do Timer
     MOVFF 0x00, TMR0L;Passando o valor de T0START para o Timer
     MOVFF 0x01, TMR0H;Passando o valor de T0START para o Timer
     BTG LATE,0; Toggle bit 0 LATE
     BTG LATE, 1;Toggle bit 1 LATE
     RETFIE

LIGA:
    BCF INTCON, 1; zerando o bit da flag de INT0
    BSF T0CON, 7; Ligando timer 0
    RETFIE

DESLIGA:
    BCF INTCON3, 0; zerando o bit da flag de INT1
    BCF T0CON, 7; Desligando timer 0
    RETFIE

;Interrupção
    org 0x08;
INTERRUPT:
	;Teste e desvio para interrupcao Timer 0
        BTFSC INTCON, TMR0IF, 0;
        bra inttimer;
	;Teste e desvio para interrupcao RB0 - Chave 1
	BTFSC INTCON, INT0IF, 0;
	bra LIGA;
	;Teste e desvio para interrupcao RB1 - Chave 2
	BTFSC INTCON3, INT1IF, 0;
	bra DESLIGA;
    end

end
