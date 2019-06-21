; snake

jmp main

msg_start: string "PRESS 'A' TO START"

map_01: string "                                        #########################################@ o o o o o o o o o o o o o o o o o  $## o#o#o###########$#########$#o####### ##o## # o o o o o o o o o o o # o o o # ## o $#o#######o########### #o o#o###o#o##o#### # o o o # o o #o $ o### #  $# # ## o o $ o o o#o#o###o  o o o #o  o #o#o## ############ # $ ###$#####o# ##### # ##$ o o o o o  o o#o  o o o o o o o  o o## # ########o# # ###o#### #### ##### # ##o#o o#o$o#o #o o  o o o#o#o #o o o o#o## # # # # # ######o#o#o o o o# o#$#  # ##o#o#o#o#o#o# o o  o # ##### # ## ## #o## # # # # # #o######## $  o o#o o o o  ## #o#o$o#o o#  o o o o  o  $ o o o o o ##$  o o o o o o $###o# ##### #o## ## # ## #o#### ##### # o o #o o o o# o#$# o#o## # o o o o o o#####o####o####o o  o # ##o#o#### ##### o o o o o o o ####o####o## # # o o o o o## ##o### ###o o o o o# ##o#o#o## ##### # $ # #  $  # ##o # # #o## # o o $ o o $#o# #o o# #o o#o ##o#o# ##o#o#o## ##### # #o# o # # o # o#o # #o## # # o o o o o  $ #o#o $ o#o#o # ##o# ##o  #### ##### ## ## ##o#o## ##o#o#o  o## #$  o o o o o o o o o o o o o o o #o ## ## ### ######## ###### ###### #####  ##$  o o $ o o o  $ o o o o o o $ o o  $######################################## "

cur_map: var #1200
snake: var #1200
p_head: var #1
p_tail: var #1

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
		call game_loop

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
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5 ; protege o r5 na pilha para ser usado na subrotina
	push r7

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
	store snake, r0
	
	loadn r5, #0
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
	
	pop r7
	pop r5 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
game_loop:

	push r0
	push r1
	
	push r6
	push r7
	
	game_loop_loop:

	inchar r0
	
	loadn r1, #'w'
	cmp r0, r1
	jne input_W
	
	loadn r6, #1
	loadn r7, #0
	
	call move_player
	jmp yes_input
	
	input_W:
	loadn r1, #'W'
	cmp r0, r1
	jne input_s
	
	loadn r6, #1
	loadn r7, #0
	
	call move_player
	jmp yes_input
	
	input_s:
	loadn r1, #'s'
	cmp r0, r1
	jne input_S
	
	loadn r6, #2
	loadn r7, #0
	
	call move_player
	jmp yes_input
	
	input_S:
	loadn r1, #'S'
	cmp r0, r1
	jne input_a
	
	loadn r6, #2
	loadn r7, #0
	
	call move_player
	jmp yes_input
	
	input_a:
	loadn r1, #'a'
	cmp r0, r1
	jne input_A
	
	loadn r6, #0
	loadn r7, #2
	
	call move_player
	jmp yes_input
	
	input_A:
	loadn r1, #'A'
	cmp r0, r1
	jne input_d
	
	loadn r6, #0
	loadn r7, #2
	
	call move_player
	jmp yes_input
	
	input_d:
	loadn r1, #'d'
	cmp r0, r1
	jne input_D
	
	loadn r6, #0
	loadn r7, #1
	
	call move_player
	jmp yes_input
	
	input_D:
	loadn r1, #'D'
	cmp r0, r1
	jne no_input
	
	loadn r6, #0
	loadn r7, #1
	
	call move_player
	jmp yes_input
	
	no_input:
	
	loadn r6, #0
	loadn r7, #0
	
	yes_input:
	
	jmp game_loop_loop
	
	pop r7
	pop r6
	
	pop r1
	pop r0
	
	rts
	
move_player:

	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	
	; carrega a cabeça do jogador.
	loadn r0, #snake
	load r1, p_head
	add r2, r0, r1
	loadi r2, r2
	
	loadn r4, #40
	
	loadn r5, #1
	cmp r6, r5
	jne move_right
	
	sub r2, r2, r4
	call check_movement
	call redraw_player
	jmp end_move
	
	move_right:
	cmp r7, r5
	jne move_down
	
	inc r2
	call check_movement
	call redraw_player
	jmp end_move
	
	move_down:
	loadn r5, #2
	cmp r6, r5
	jne move_left
	
	add r2, r2, r4
	call check_movement
	call redraw_player
	jmp end_move
	
	move_left:
	cmp r7, r5
	jne end_move
	
	dec r2
	call check_movement
	call redraw_player
	jmp end_move
	
	end_move:
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	
	rts

check_movement:

	push r5
	push r6
	push r7
	
	loadn r6, #cur_map
	add r6, r2, r6
	
	loadi r7, r6

	loadn r5, #'#'
	cmp r7, r5
	jne check_money
	
	halt
	
	check_money:
	
		loadn r5, #'o'
		cmp r7, r5
		jne check_money_bonus
		
		jmp empty
	
	check_money_bonus:
	
		loadn r5, #'$'
		cmp r7, r5
		jne check_self_tail
		
		jmp empty
	
	check_self_tail:
	
		loadn r5, #'*'
		cmp r7, r5
		jne check_self_head
		
		halt
	
	check_self_head:
	
		loadn r5, #'@'
		cmp r7, r5
		jne empty
		
		halt
	
	empty:
	
		load r5, p_tail
		
		loadn r6, #' '
		add r7, r5, r0
		loadi r5, r7
		outchar r6, r5
		
		inc r5
		store p_tail, r5
	
	checked:

	pop r7
	pop r6
	pop r5

	rts
	
redraw_player:

	push r1
	push r2
	push r3
	push r4
	push r5
	
	add r3, r1, r0
	loadi r5, r3

	; printa o corpo do jogador
	loadn r3, #'*'
	loadn r4, #1536
	add r3, r3, r4
	
	;outchar r3, r5

	; atualiza a onde na lista esta a cabeca do jogador
	inc r1
	loadn r3, #1200
	mod r1, r1, r3
	
	store p_head, r1
	
	; guarda a posicao da cabeca do jogador na lista
	add r3, r0, r1
	storei r3, r2
	
	; atualiza o mapa na memoria
	loadn r5, #cur_map
	add r5, r2, r5
	storei r5, r2
	
	; printa a nova cabeca do jogador
	loadn r3, #'@'
	loadn r4, #1536
	add r3, r3, r4
	
	outchar r3, r2

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1

	rts