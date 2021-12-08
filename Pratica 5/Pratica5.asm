#include <p18f4550.inc>
    config CPUDIV = OSC1_PLL2 ;
    config FOSC = HS ;
    config WDT = OFF ;
    config PBADEN = OFF;
    config LVP = OFF ;
    config MCLRE = ON ;
    config PWRT = ON ;
    #define dU 0x00;
    #define dH 0x01;
    #define dL 0x02;
    org 0x00;
    BCF INTCON2,7,0 ;Habilitando resistor pull-up
    MOVLW 0x0F
    MOVWF ADCON1,0 ;Desativar conversor A/D
    MOVLW 0xFF ;
    MOVWF TRISB,0
    MOVLW 0x00
    MOVWF TRISC,0
    MOVLW 0x00
    MOVWF TRISD,0
    MOVLW 0xFF
    MOVWF LATD,0
loop:
    BTFSS PORTB, 0, 0 ;Condição para acionar Led
    CALL LED ;Chamando sub-rotina Led
    BTFSS PORTB,1, 0 ;Condição para acionar Buzzer
    CALL BUZZER ;Chamando sub-rotina buzzer
    bra loop
LED:
    BTG LATD,0,0 ;Toggle com o Led
    ;Passando valores para os endereços para fazer o delay dentro da sub-rotina
    ;F = 1Hz
    MOVLW 0x0D 
    MOVWF dU,0
    MOVLW 0xB7
    MOVWF dH,0
    MOVLW 0x35
    MOVWF dL,0
    CALL delay
return
BUZZER:
    BTG LATC,2,0 ;Toggle com o Buzzer
    ;Passando valores para os endereços para fazer o delay dentro da sub-rotina
    ;F = 2,5kHz
     MOVLW 0x01
    MOVWF dU,0
    MOVLW 0x02
    MOVWF dH,0
    MOVLW 0x4E
    MOVWF dL,0
    CALL delay
return
delay:
    DECFSZ dL,1,0
    BRA delay;
    DECFSZ dH,1,0
    BRA delay;
    DECFSZ dU,1,0
    bra delay;
    return
end
