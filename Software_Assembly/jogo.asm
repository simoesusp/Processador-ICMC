; snake

jmp main

msg_start: string "PRESS 'A' TO START"

main:
	loadn r0, #610		; posicao na tela onde a mensagem sera' escrita
	loadn r1, #msg_start	; carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #2816		; seleciona a cor da mensagem
	
	call imprimestr   ;  r0 = posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   obs: a mensagem sera' impressa ate' encontrar "/0"

	loadn r5, #0 ;seed para o mapa aleatório

	wait_start:

		inchar r0
		
		loadn r1, #'a'
		
		cmp r0, r1
		jeq call_start 
		
		loadn r1, #'A'
		
		cmp r0, r1
		jeq call_start 

		inc r5
		jmp wait_start
		call_start:
			call start_game

	halt
	
;---- fim do programa principal -----
	
;---- inicio das subrotinas -----
	
imprimestr:	;  rotina de impresao de mensagens:    r0 = posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; criterio de parada

imprimestrloop:	
	loadi r4, r1
	cmp r4, r3
	jeq imprimestrsai
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp imprimestrloop
	
imprimestrsai:	
	pop r4	; resgata os valores dos registradores utilizados na subrotina da pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts

clear_range:

	push r7	; protege o r7 na pilha para preservar seu valor

	loadn r7, #' '

clear_range_loop:	

	cmp r0, r1 
	jeq clear_range_exit
	outchar r7, r0
	inc r0
	jmp clear_range_loop
	
clear_range_exit:	
	pop r7	; resgata os valores dos registradores utilizados na subrotina da pilha
	rts

start_game:

	push r0

	loadn r0, #610
	loadn r1, #628
	call clear_range
	call draw_stage
	
	pop r0
	
	rts
	
draw_stage:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	
	loadn r0, #0
	loadn r1, #39
	
	loadn r2, #'x'
	loadn r5, #3328
	add r2, r2, r5
	
	loadn r3, #40
	loadn r4, #1200
	
	stage_loop1:
		outchar r2, r0
		add r0, r0, r3
		nop
		nop
		outchar r2, r1	
		
		add r1, r1, r3
		
		cmp r0, r4
		jle stage_loop1
		
	loadn r0, #1
	loadn r1, #1161
	
	stage_loop2:
		outchar r2, r0
		inc r0
		nop
		nop
		outchar r2, r1
		
		inc r1
		
		cmp r0, r3
		jle stage_loop2
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	
	rts