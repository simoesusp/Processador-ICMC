; Teste das instrucoes que vao sendo implementadas!


; 4 Perguntas ao implemantar as instrucoes:
;	1) O Que preciso fazer para esta instrucao?
;	2) Onde Comeca: Pegar o que tem que fazer e ir voltando ate' chegar em um registrador (ie. PC)
;	3) Qual e' a Sequencia de Operacoes: Descrever todos os comandos que tem que dar nos cilos de Dec e Exec
;	4) Ja' terminou??? Cumpriu o que tinha que fazer??? O PC esta' pronto para a proxima instrucao (cuidado com Load, Loadn, Store, Jmp, Call)

	; Teste do Loadn
	loadn r0, #0		
	loadn r1, #'A'		
	outchar r1, r0	
	
	; Teste do Load	
	loadn r0, #2
	load r1, Dado
	outchar r1, r0
	
	; Teste do Store
	loadn r1, #'C'
	store Dado, r1
	load r2, Dado
	loadn r0, #4
	outchar r2, r0
	
	; Teste do Storei e Loadi
	loadn r1, #Dado
	loadn r0, #'D'
	storei r1, r0
	loadi r2, r1
	loadn r0, #6
	outchar r2, r0
	
	; Teste do Move
	loadn r1, #'E'
	mov r2, r1
	loadn r0, #8
	outchar r2, r0
	
	; Teste do Add
	loadn r1, #'E'
	loadn r2, #1
	add r3, r1, r2
	loadn r0, #10
	outchar r3, r0		; Printa F na linha 10
	
	; Teste do Sub
	loadn r1, #'H'
	loadn r2, #1
	sub r3, r1, r2
	loadn r0, #12
	outchar r3, r0		; Printa G na linha 12

	; Teste do Mult
	loadn r1, #3
	loadn r2, #2
	mul r3, r1, r2
	loadn r4, #'B'
	add r3, r4, r3
	loadn r0, #14
	outchar r3, r0		; Printa H na linha 14

	; Teste do Div
	loadn r1, #6
	loadn r2, #2
	div r3, r1, r2
	loadn r4, #'F'
	add r3, r4, r3
	loadn r0, #16
	outchar r3, r0		; Printa I na linha 16

	; Teste do Inc / Dec
	inc r0
	inc r0
	loadn r3, #'K'
	dec r3
	outchar r3, r0		; Printa J na linha 18
	
	; Teste do And
	loadn r1, #254
	loadn r2, #5
	and r3, r1, r2
	loadn r4, #'G'
	add r3, r4, r3
	loadn r0, #20
	outchar r3, r0		; Printa K na linha 20
	
	; Teste do Or
	loadn r1, #4
	loadn r2, #3
	or r3, r1, r2
	loadn r4, #'E'
	add r3, r4, r3
	loadn r0, #22
	outchar r3, r0		; Printa L na linha 22
	
	; Teste do Xor
	loadn r1, #5
	loadn r2, #3
	xor r3, r1, r2
	loadn r4, #'G'
	add r3, r4, r3
	loadn r0, #24
	outchar r3, r0		; Printa M na linha 24
	
	; Teste do CMP e JMP
	loadn r0, #26
	loadn r1, #5
	loadn r2, #3
	loadn r3, #'O'
	loadn r4, #'N'
	cmp r1, r2
	jgr Maior
	outchar r3, r0		; Printa O na linha 26
	jmp SaiJMP
Maior:
	outchar r4, r0		; Printa N na linha 26
	jmp SaiJMP
	
SaiJMP:

	; Teste do CALL e RTS
	loadn r0, #28
	loadn r1, #5
	loadn r2, #3
	loadn r3, #'P'
	loadn r4, #'Q'
	cmp r1, r2
	cgr CallMaior
	cel CallMenorIgual
	jmp CallSai
CallMaior:
	outchar r3, r0		; Printa P na linha 28
	rts
CallMenorIgual:
	outchar r4, r0		; Printa Q na linha 28
	rts

CallSai:	

	; Teste do PUSH e POP
	loadn r0, #30
	loadn r1, #'R'
	push r1
	pop r2
	outchar r2, r0		; Printa R na linha 30
	
	
	
Fim:	
	halt

	
Dado : var #1
static Dado + #0, #'B'
	
	
	
	
	
	
	
	
	
	