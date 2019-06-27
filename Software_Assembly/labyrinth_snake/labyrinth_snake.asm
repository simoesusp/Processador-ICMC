; snake

jmp main

msg_start: string "PRESS ANY KEY TO START"

map_01: string "                                        #########################################@ o o o o o o o o o o o o o o o o o  $## o#o#o###########$#########$#o####### ##o## # o o o o o o o o o o o # o o o # ## o $#o#######o########### #o o#o###o#o##o#### # o o o # o o #o $ o### #  $# # ## o o $ o o o#o#o###o  o o o #o  o #o#o## ############ # $ ###$#####o# ##### # ##$ o o o o o  o o#o  o o o o o o o  o o## # ########o# # ###o#### #### ##### # ##o#o o#o$o#o #o o  o o o#o#o #o o o o#o## # # # # # ######o#o#o o o o# o#$#  # ##o#o#o#o#o#o# o o  o # ##### # ## ## #o## # # # # # #o######## $  o o#o o o o  ## #o#o$o#o o#  o o o o  o  $ o o o o o ##$  o o o o o o $###o# ##### #o## ## # ## #o#### ##### # o o #o o o o# o#$# o#o## # o o o o o o#####o####o####o o  o # ##o#o#### ##### o o o o o o o ####o####o## # # o o o o o## ##o### ###o o o o o# ##o#o#o## ##### # $ # #  $  # ##o # # #o## # o o $ o o $#o# #o o# #o o#o ##o#o# ##o#o#o## ##### # #o# o # # o # o#o # #o## # # o o o o o  $ #o#o $ o#o#o # ##o# ##o  #### ##### ## ## ##o#o## ##o#o#o  o## #$  o o o o o o o o o o o o o o o #o ## ## ### ######## ###### ###### #####  ##$  o o $ o o o  $ o o o o o o $ o o  $######################################## "

cur_map: var #1200
snake: var #1200
p_head: var #1
p_tail: var #1

main:

	loadn r0, #608		; posicao na tela onde a mensagem sera' escrita
	loadn r1, #msg_start	; carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #2816		; seleciona a cor da mensagem
	
	call imprimestr   ;  r0 = posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   obs: a mensagem sera' impressa ate' encontrar "/0"

	loadn r5, #0 ;seed para o mapa aleatório

	wait_start:

		loadn r7, #snake 

		inchar r0
		
		loadn r1, #255
		
		cmp r0, r1
		jne call_start

		inc r5
		jmp wait_start
		call_start:
		
		call start_game
		; guarda o inicio do jogador.
		call game_loop
		
		; TODO: limpar tela
		jmp main ; reinicia o jogo.

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

start_game:

	push r1

	loadn r1, #map_01	; carrega r1 com o endereco do vetor que contem a mensagem
	call draw_stage
	
	pop r1
	
	rts
	
draw_stage:	;  rotina de impresao de mensagens:    r1 = mapa a ser desenhado

	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r2 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5 ; protege o r5 na pilha para ser usado na subrotina
	push r7 ; protege o r7 na pilha para ser usado na subrotina

	loadn r0, #0
	loadn r3, #'\0'	; criterio de parada
	loadn r7, #cur_map

; desenha o estágio.
draw_loop:	

	loadi r4, r1
	
	cmp r4, r3
	jeq draw_exit
	
	storei r7, r4 ; guarda o mapa na memoria para usar no jogo
	
	; seta a cor para as paredes.
	loadn r5, #'#'
	cmp r4, r5
	jne draw_money
	
	loadn r2, #256
	add r4, r2, r4
	jmp end_draw
	
	draw_money:
	; seta a cor para o dinheiro.
	loadn r5, #'o'
	cmp r4, r5
	jne draw_extra_money
	
	loadn r2, #2816
	add r4, r2, r4
	jmp end_draw
	
	draw_extra_money:
	; seta a cor para o dinheiro bonus.
	loadn r5, #'$'
	cmp r4, r5
	jne draw_player
	
	loadn r2, #3328
	add r4, r2, r4
	jmp end_draw
	
	draw_player:
	; seta a cor para o jogador.
	loadn r5, #'@'
	cmp r4, r5
	jne end_draw
	
	; guarda o inicio do jogador.
	loadn r5, #0
	store snake, r0
	store p_head, r5
	store p_tail, r5
	
	; escreve o caracter.
	loadn r2, #1536
	add r4, r2, r4
	
	end_draw:
	
	outchar r4, r0
	
	inc r0
	inc r1
	inc r7
	
	jmp draw_loop
	
draw_exit:

	; printa os pontos inicias.
	loadn r0, #0
	loadn r4, #'0'
	outchar r4, r0
	
	; printa o numero da fase.
	loadn r0, #1199
	loadn r2, #256
	loadn r4, #'1'
	add r4, r2, r4
	outchar r4, r0
	
	pop r7 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r5 
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
game_loop:

	inchar r0
	
		loadn r1, #'w'
		cmp r0, r1
		jne input_W
		
		loadn r6, #1
		loadn r7, #0
		jmp yes_input
	
	input_W:
	
		loadn r1, #'W'
		cmp r0, r1
		jne input_s
		
		loadn r6, #1
		loadn r7, #0
		jmp yes_input
	
	input_s:
	
		loadn r1, #'s'
		cmp r0, r1
		jne input_S
		
		loadn r6, #2
		loadn r7, #0
		jmp yes_input
	
	input_S:
	
		loadn r1, #'S'
		cmp r0, r1
		jne input_a
		
		loadn r6, #2
		loadn r7, #0
		jmp yes_input
	
	input_a:
	
		loadn r1, #'a'
		cmp r0, r1
		jne input_A
		
		loadn r6, #0
		loadn r7, #2
		jmp yes_input
	
	input_A:
	
		loadn r1, #'A'
		cmp r0, r1
		jne input_d
		
		loadn r6, #0
		loadn r7, #2
		jmp yes_input
	
	input_d:
	
		loadn r1, #'d'
		cmp r0, r1
		jne input_D
		
		loadn r6, #0
		loadn r7, #1
		jmp yes_input
	
	input_D:
	
		loadn r1, #'D'
		cmp r0, r1
		jne end_input_check
		
		loadn r6, #0
		loadn r7, #1
		
	yes_input:
	
		call update_pos ; atualiza a posicao do player.
		call redraw_player ; redesenha o player.
		jmp end_input_check
	
	end_input_check:
	
	jmp game_loop
	
	rts

; parametros:
;	r6: movementação no eixo x.
; 		0 - sem movimemento, 1 - direita, 2 - esquerda
;	r6: movementação no eixo x.
; 		0 - sem movimemento, 1 - cima, 2 - baixo
; retorna a nova posicao do player em r2.
update_pos:

	push r0
	push r1
	push r3
	push r4
	push r5
	
	loadn r0, #snake ; carrega a posicao inicial do vetor do player.
	load r1, p_head ; carrega em que posicao do vetor esta a cabeca do player.
	add r3, r0, r1 ; calcula o endereco da posicao da cabeca do player.
	
	loadi r2, r3 ; carega a posicao atual da cabeca do player.
	
	loadn r4, #40
	
	loadn r5, #1
	cmp r6, r5
	jne move_right
		
		sub r2, r2, r4
		jmp end_move
	
	move_right:
	cmp r7, r5
	jne move_down
	
		inc r2
		jmp end_move
	
	move_down:
	loadn r5, #2
	cmp r6, r5
	jne move_left
	
		add r2, r2, r4
		jmp end_move
	
	move_left:
	cmp r7, r5
	jne end_move
	
		dec r2
		jmp end_move
	
	end_move:
	
	inc r1 ; calcula a nova posicao no vetor da cabeca do player.
	loadn r5, #1200
	mod r1, r1, r5
	
	store p_head, r1 ; guarda na memoria.
	
	add r3, r0, r1 ; calcula o endereco da posicao da cabeca do player.
	storei r3, r2 ; guarda a posicao da cabeca do jogador na memoria.
	
	load r3, p_tail ; atualiza a posicao da calda do jogador no vetor.
	
	loadn r4, #1 ; detecta se a calda do jogador deve ser atualiza
	sub r0, r1, r3
	cmp r0, r4
	jel end_update_pos
	
		inc r3 ; atualzia a calda do jogador.
		loadn r0, #1200
		mod r3, r3, r0
		store p_tail, r3
		
	end_update_pos:
	
	pop r5
	pop r4
	pop r3
	pop r1
	pop r0
	
	rts
	
redraw_player:
	
	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #snake ; carrega a posicao inicial do vetor do player.
	load r1, p_head ; carrega em que posicao do vetor esta a nova cabeca do player.
	add r3, r0, r1 ; calcula o endereco da posicao da nova cabeca do player.
	
	loadi r2, r3 ; carega a posicao nova da cabeca do player.
	
	loadn r0, #'@' ; printa a nova cabeca do player.
	loadn r1, #1536
	add r0, r0, r1
	outchar r0, r2
	
	loadn r0, #snake ; carrega a posicao inicial do vetor do player.
	load r1, p_tail ; carrega em que posicao do vetor esta a calda do player.
	add r3, r0, r1 ; calcula o endereco da posicao da calda do player.
	
	loadi r2, r3 ; carega a posicao da calda do player.
	
	loadn r0, #' ' ; apaga a calda do player.
	outchar r0, r2

	pop r3
	pop r2
	pop r1
	pop r0

	rts