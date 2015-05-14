;Relogio em Assembly

;Secao de declaracao de variaveis GLOBAIS
;R0 -> Segundos
;R1 -> Minutos
;R2 -> Hora
;R3 -> #60
;R4 -> #24
;R5 -> ParametroPrint
;R6 -> ParametroPrint

;Codigo principal
main:
	call InitRelogio
	
    loop:
		call PrintHMS
		call Logica
		call Delay
		jmp loop
	
;Funcoes

InitRelogio:	; Inicialisa os registradores de Hora, Minuto e Segundo e constantes como variaveis globais!!!
	Loadn R0, #0	; Segundo				
	Loadn R1, #0	; Minuto
	Loadn R2, #0	; Hora
	Loadn R3, #60
	Loadn R4, #24
	
	RTS							;return

;--------------------------
	
PrintHMS:
	;Printa a hora
	Mov R5, R2
	Loadn R6, #10
	call PrintR5R6	; r5=numero - r6=posicao
	
	;Printa os ':' entre as horas
	Loadn R5, #':'
	Loadn R6, #12
	Outchar R5, R6	; r5=':' - r6=posicao
	
	;Printa os minutos
	Inc R6
	Mov R5, R1
	call PrintR5R6	; r5=numero - r6=posicao
	
	;Printa os ':' entre as horas
	Loadn R5, #':'
	Inc R6
	Outchar R5, R6	; r5=':' - r6=posicao
	
	;Printa os segundos
	Inc R6
	Mov R5, R0
	call PrintR5R6	; r5=numero - r6=posicao
	
	RTS
	
;-----------------	
	
Logica:
	Inc R0					;Segundos++
	Cmp R0, R3				;Segundos = 60
	JNE Logica_FIM						;JumpNotEqual
		Loadn R0, #0
		Inc R1				;Minutos++
		Cmp R1, R3			;Minutos = 60
		JNE Logica_FIM
			Loadn R1, #0
			Inc R2			;Hora++
			CMP R2, R4		;Hora = 24
			JNE Logica_FIM
				Loadn R2, #0
Logica_FIM: 	RTS



;----------------------------------
Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	Push R0
	Push R1
	
	Loadn R1, #5  ; a
   Delay_volta2:				; contador de tempo quebrado em duas partes (dois loops de decremento)
	Loadn R0, #3000	; b
   Delay_volta: 
	Dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	JNZ Delay_volta	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS							;return

;-------------------------------



;Primeiro numero a ser impresso (zero) esta na posicao 48 == Cod. ASCII do Zero
;Por isso soma-se 48 ao valor a ser impresso
;Abaixo tambem se encontra a logica para imprimir um numero de 2 digitos (tipo 21)
PrintR5R6:	; R5 contem um numero de ate' 2 digitos     e    R6 a posicao onde vai imprimir na tela
	Push R0
	Push R1
	Push R2
	Push R3
	
	Loadn R0, #10
	Loadn R2, #48
	
	Div R1, R5, R0	; Divide o numeo por 10 para imprimir a dezena
	
	Add R3, R1, R2	; Soma 48 ao numero pra dar o Cod.  ASCII do numero
	Outchar R3, R6
	
	Inc R6			; Incrementa a posicao na tela
	
	Mul R1, R1, R0	; Multiplica a dezena por 10
	Sub R1, R5, R1	; Pra subtrair do numero e pegar o resto
	
	Add R1, R1, R2	; Soma 48 ao numero pra dar o Cod.  ASCII do numero
	Outchar R1, R6
	
	Pop R3
	Pop R2
	Pop R1
	Pop R0
	
	RTS

	
