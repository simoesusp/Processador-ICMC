; labyrinth snake

; nome - numUSP
; nome - numUSP
; nome - numUSP

;---- inicio da declaracao de variaveis -----

msg_start: string "PRESS ANY KEY TO START" ; mensagem de inicio.

; mapas iniciais do jogo.
map_01: string "                                        #########################################@ o o o o o o o o o o o o o o o o o  $## o#o#o###########$#########$#o####### ##o## # o o o o o o o o o o o # o o o # ## o $#o#######o########### #o o#o###o#o##o#### # o o o # o o #o $ o### #  $# # ## o o $ o o o#o#o###o  o o o #o  o #o#o## ############ # $ ###$#####o# ##### # ##$ o o o o o  o o#o  o o o o o o o  o o## # ########o# # ###o#### #### ##### # ##o#o o#o$o#o #o o  o o o#o#o #o o o o#o## # # # # # ######o#o#o o o o# o#$#  # ##o#o#o#o#o#o# o o  o # ##### # ## ## #o## # # # # # #o######## $  o o#o o o o  ## #o#o$o#o o#  o o o o  o  $ o o o o o ##$  o o o o o o $###o# ##### #o## ## # ## #o#### ##### # o o #o o o o# o#$# o#o## # o o o o o o#####o####o####o o  o # ##o#o#### ##### o o o o o o o ####o####o## # # o o o o o## ##o### ###o o o o o# ##o#o#o## ##### # $ # #  $  # ##o # # #o## # o o $ o o $#o# #o o# #o o#o ##o#o# ##o#o#o## ##### # #o# o # # o # o#o # #o## # # o o o o o  $ #o#o $ o#o#o # ##o# ##o  #### ##### ## ## ##o#o## ##o#o#o  o## #$  o o o o o o o o o o o o o o o #o ## ## ### ######## ###### ###### #####  ##$  o o $ o o o  $ o o o o o o $ o o  $######################################## "

cur_map: var #1200 ; guarda o mapa atual atualizado na memoria
snake: var #1200 ; vetor com as posicoes dos segmentos do player.
p_head: var #1 ; guarda o indice da cabeca do player na lista.
p_tail: var #1 ; guarda o indice da cauda do player na lista.

;---- fim da declaracao de variaveis -----

;---- inicio do programa principal -----

main:

	loadn r0, #609			; posicao na tela onde a mensagem sera escrita
	loadn r1, #msg_start	; carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #2816			; seleciona a cor da mensagem
	call print_str  

	loadn r7, #0 ; seed para o mapa aleatório

	loop_wait_start: ; espera o jogador iniciar.

		inchar r0 ; tenta receber input.
		
		loadn r1, #255 ; verifica se o input ocorreu.
		cmp r0, r1
		jne call_start ; inicia o jogo.

		inc r7 ; caso nao haja input, incrementa o contador da seed.
		jmp loop_wait_start ; continua o loop.
		
	call_start:
	
	call start_game ; inicia um novo jogo.
	
	; TODO: limpar tela
	jmp main ; reinicia o jogo.
	
;---- fim do programa principal -----
	
;---- inicio das subrotinas -----

;  rotina de impresao de mensagens:    
;	r0 = posicao da tela que o primeiro caractere da mensagem sera' impresso;  
;	r1 = endereco onde comeca a mensagem; 
;	r2 = cor da mensagem.   
;	obs: a mensagem sera' impressa ate' encontrar "/0"
print_str:

	push r0	; protege os valores dos registradores que serao usados na subrotina na pilha.
	push r1
	push r2
	push r3
	push r4	
	
	loadn r3, #'\0'	; criterio de parada

	loop_print_str:	

		loadi r4, r1 ; carrega o char a ser printado.
		
		cmp r4, r3 ; verifica o criterio de parada.
		jeq print_str_exit
		
		add r4, r2, r4 ; printa o char.
		outchar r4, r0
		
		inc r0
		inc r1
		jmp loop_print_str ; continua o loop.
		
	print_str_exit:	

		pop r4 ; resgata os valores dos registradores utilizados na subrotina da pilha
		pop r3
		pop r2
		pop r1
		pop r0
		
	rts

; inicia um novo jogo.
start_game:

	push r1 ; protege os valores dos registradores que serao usados na subrotina na pilha.

	call draw_stage ; desenha o estagio.
	call game_loop ; chama o loop principal do jogo.
	
	pop r1 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	
	rts

; desenha o estagio a partir de um mapa base
; parametros:
;	r7: seed do mapa a ser usado.
draw_stage:

	push r0	; protege os valores dos registradores que serao usados na subrotina na pilha.
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r0, #0 ; carrega o offset inicial.
	loadn r1, #map_01 ; carrega o mapa (TODO - adicionar multiplos mapas).
	loadn r3, #'\0'	; criterio de parada.	
	loadn r6, #cur_map ; carrega o mapa da memoria.

	; desenha o estágio.
	draw_loop:	

		loadi r4, r1 ; carrega o char a ser printado.
		
		cmp r4, r3 ; verifica o criterio de parada.
		jeq draw_exit
		
		storei r6, r4 ; guarda o mapa na memoria para usar no jogo
		
		draw_wall: ; verifica se eh uma parede e carrega a cor certa.
			loadn r5, #'#'
			cmp r4, r5
			jne draw_money
			
			loadn r2, #256
			add r4, r2, r4
			jmp end_draw
		
		draw_money: ; verifica se eh dinheiro e carrega a cor certa.
			loadn r5, #'o'
			cmp r4, r5
			jne draw_extra_money
			
			loadn r2, #2816
			add r4, r2, r4
			jmp end_draw
		
		draw_extra_money: ; verifica se eh dinheiro bonus e carrega a cor certa.
			loadn r5, #'$'
			cmp r4, r5
			jne draw_player
			
			loadn r2, #3328
			add r4, r2, r4
			jmp end_draw
		
		draw_player: ; verifica se eh o player,e carrega a cor certa e marca a posicao inicial..
			loadn r5, #'@'
			cmp r4, r5
			jne end_draw
			
			loadn r5, #0 ; guarda a posicao inicial do jogador.
			store snake, r0
			store p_head, r5
			store p_tail, r5
			
			loadn r2, #1536
			add r4, r2, r4
		
		end_draw:
		
		outchar r4, r0 ; escreve o caracter.
		
		inc r0
		inc r1
		inc r6
		
		jmp draw_loop
		
	draw_exit:

		; printa os pontos inicias.
		loadn r0, #0
		loadn r4, #'0'
		outchar r4, r0
		
		; printa o numero da fase.
		loadn r0, #1199
		loadn r2, #256
		
		loadn r5, #1 ; numero de mapas.
		mod r3, r7, r5 ; obetem o numero do mapa atual.
		add r3, r3, r5 ; adiciona 1 ao numero
		add r4, r4, r3 ; obtem o char do numero.
		
		add r4, r4, r2 ; adiciona a cor.
		outchar r4, r0 ; printa o numero do mapa.
	
		pop r6 ; resgata os valores dos registradores utilizados na subrotina da pilha.
		pop r5 
		pop r4	
		pop r3
		pop r2
		pop r1
		pop r0
		
	rts

; faz o loop principal do jogo.
game_loop:

	inchar r0 ; recebe input.
	
	input_w: ; move o jogador para a frente.
	
		loadn r1, #'w' ; verifica se o player pressionou para cima.
		cmp r0, r1
		jeq input_forward
		
		loadn r1, #'W' ; verifica se o player pressionou para cima (maiuscula).
		cmp r0, r1
		jne input_s
		
		input_forward: ; marca que o player tentou mover para cima.
			loadn r6, #1
			loadn r7, #0
			jmp yes_input
	
	input_s:
	
		loadn r1, #'s' ; verifica se o player pressionou para baixo.
		cmp r0, r1
		jeq input_down
		
		loadn r1, #'S' ; verifica se o player pressionou para baixo (maiuscula).
		cmp r0, r1
		jne input_a
		
		input_down: ; marca que o player tentou mover para baixo.
			loadn r6, #2
			loadn r7, #0
			jmp yes_input
	
	input_a:
	
		loadn r1, #'a' ; verifica se o player pressionou para esquerda.
		cmp r0, r1
		jeq input_left
		
		loadn r1, #'A' ; verifica se o player pressionou para esquerda (maiuscula).
		cmp r0, r1
		jne input_d
		
		input_left:	; marca que o player tentou mover para esquerda.
			loadn r6, #0
			loadn r7, #2
			jmp yes_input
	
	input_d:
	
		loadn r1, #'d' ; verifica se o player pressionou para direita.
		cmp r0, r1
		jeq input_right
		
		loadn r1, #'D' ; verifica se o player pressionou para direita (maiuscula).
		cmp r0, r1
		jne end_input_check
		
		input_right: ; marca que o player tentou mover para direita.
			loadn r6, #0
			loadn r7, #1
			jmp yes_input
		
	yes_input: ; verifica se houve input valido.
	
		call update_pos ; atualiza a posicao do player.
		call check_pos ; checa o que ha na nova posicao do player.
		
		l_checked_money:
			loadn r6, #1 ; verifica se o player coletou dinheiro.
			cmp r6, r7
			jne l_checked_obstacle
			
				; call update_points
				jmp checked
		
		l_checked_obstacle: ; verifica se o player colidiu com um obstaculo.
			loadn r6, #2
			cmp r6, r7
			jne checked
			
				halt ; TEMP
				jmp checked
		
		checked:
		
			call redraw_player ; redesenha o player.
	
	end_input_check:
	
	jmp game_loop ; continua o loop.
	
	rts
	
; parametros:
;	r6: movimentação no eixo x.
; 		0 - sem movimemento, 1 - direita, 2 - esquerda
;	r7: movimentação no eixo 7.
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
	
	loadn r4, #'*' ; apaga a cauda do player.
	loadn r5, #1536
	add r4, r4, r5
	outchar r4, r2
	
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
	
	pop r5
	pop r4
	pop r3
	pop r1
	pop r0
	
	rts

; retorna em r7 o resultado ao checar a posição:
; 	0 - vazia, 1 - dinheiro (crescimento do player) , 2 - Obstaculo (morte do player)
check_pos:

	push r0
	push r1
	push r2
	push r3

	loadn r0, #snake ; carrega a posicao inicial do vetor do player.
	load r1, p_head ; carrega em que posicao do vetor esta a cabeca do player.
	add r3, r0, r1 ; calcula o endereco da posicao da cabeca do player.
	
	loadi r2, r3 ; carega a posicao da cabeca do player.
	
	loadn r0, #cur_map ; carrega a posicao inicial do mapa na memoria.
	add r3, r0, r2 ; carrega em que posicao do mapa esta a cabeca do player.
	
	loadi r2, r3 ; carrega o que ha no mapa na posicao da nova cabeca do player.
	
	loadn r1, #'#'
	cmp r2, r1
	jne player_head_check
	
		jmp check_die
	
	player_head_check:
	loadn r1, #'@'
	cmp r2, r1
	jne player_body_check
	
		jmp check_die
	
	player_body_check:
	loadn r1, #'*'
	cmp r2, r1
	jne money_check
	
		jmp check_die
		
	money_check:
	loadn r1, #'o'
	cmp r2, r1
	jne bonus_money_check
	
		jmp get_money
		
	bonus_money_check:
	loadn r1, #'$'
	cmp r2, r1
	jne check_empty
	
	get_money:
	
		loadn r7, #1
		jmp end_check 
		
	check_die:
	
		loadn r7, #2
		jmp end_check
		
	check_empty:
	
		loadn r7, #0		
	
	end_check:

	pop r3
	pop r2
	pop r1
	pop r0

	rts

; parametros:
;	r7: crescimento do player.
; 		0 - nao cresce, 1 - cresce
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
	
	loadn r0, #cur_map ; atualiza o mapa na memoria.
	add r0, r0, r2
	loadn r1, #'@'
	storei r0, r1
	
	loadn r0, #1
	cmp r0, r7
	jeq redrawn
	
		loadn r0, #snake ; carrega a posicao inicial do vetor do player.
		load r1, p_tail ; carrega em que posicao do vetor esta a cauda do player.
		add r3, r0, r1 ; calcula o endereco da posicao da cauda do player.
		
		loadi r2, r3 ; carega a posicao da cauda do player.
		
		loadn r0, #' ' ; apaga a cauda do player.
		outchar r0, r2
		
		loadn r3, #cur_map ; atualiza o mapa na memoria.
		add r3, r3, r2
		storei r3, r0
		
		inc r1
		store p_tail, r1
		
	redrawn:

	pop r3
	pop r2
	pop r1
	pop r0

	rts
	
	;---- fim das subrotinas -----