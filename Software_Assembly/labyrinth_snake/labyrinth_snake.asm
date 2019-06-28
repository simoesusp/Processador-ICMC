; labyrinth snake
; configure para clock automatico de 1MHz.

; Julia Carolina Frare Peixoto - 10734727
; Luís Eduardo Rozante de Freitas Pereira - 10734794
; Maurílio da Motta Meireles - 10734501

jmp main ; inicia o programa

;---- inicio da declaracao de variaveis -----

msg_title: string "LABYRINTH SNAKE" ; mensagem de titulo.
msg_start: string "PRESS 'SPACE' TO START" ; mensagem de inicio.
msg_end: string "GAME OVER" ; mensagem de game over.
msg_restart: string "PRESS 'SPACE' TO RESTART" ; mensagem de reinicio.

; mapas iniciais do jogo.
map_01: string "                                        #########################################@ o o o o o o o o o o o o o o o o o  $## o#o#o###########$#########$#o####### ##o## # o o o o o o o o o o o # o o o # ## o $#o#######o########### #o o#o###o#o##o#### # o o o # o o #o $ o### #  $# # ## o o $ o o o#o#o###o  o o o #o  o #o#o## ############ # $ ###$#####o# ##### # ##$ o o o o o  o o#o  o o o o o o o  o o## # ########o# # ###o#### #### ##### # ##o#o o#o$o#o #o o  o o o#o#o #o o o o#o## # # # # # ######o#o#o o o o# o#$#  # ##o#o#o#o#o#o# o o  o # ##### # ## ## #o## # # # # # #o######## $  o o#o o o o  ## #o#o$o#o o#  o o o o  o  $ o o o o o ##$  o o o o o o $###o# ##### #o## ## # ## #o#### ##### # o o #o o o o# o#$# o#o## # o o o o o o#####o####o####o o  o # ##o#o#### ##### o o o o o o o ####o####o## # # o o o o o## ##o### ###o o o o o# ##o#o#o## ##### # $ # #  $  # ##o # # #o## # o o $ o o $#o# #o o# #o o#o ##o#o# ##o#o#o## ##### # #o# o # # o # o#o # #o## # # o o o o o  $ #o#o $ o#o#o # ##o# ##o  #### ##### ## ## ##o#o## ##o#o#o  o## #$  o o o o o o o o o o o o o o o #o ## ## ### ######## ###### ###### #####  ##$  o o $ o o o  $ o o o o o o $ o o  $######################################## "
map_02: string "                                        #########################################$ o o o o o o o $    $ o o o o o o o $## #################################### ##o#$ o o o   o o o    o o o   o o o $#o## # #######o####o######o####o####### # ##o#o#$ o  $  o o o    o o o  $  o $#o#o## # # # #o# ####o######o####o#o# # # # ##o#o#o#o# # #$ o  o  o  o $# # #o#o#o#o## # #   o  o# ## o####o ## #o  o   # # ##o#o#o###o###o#$o o  o o$#o###o###o#o#o## # # #$  # o  o###  ###o  o #  $# # # ##o#o# o # o # o #$    $# o # o # o # #o## #  o ## #o#o#o# #oo# #o#o#o# ## o  # ##$ o #o  $# # #   o$ o   # # #$  o# o $## # ## ####o# #   o @o   # #o#### ## # ##o#o o o  $ #o#o# #oo# #o#o# $  o o o#o## # ### ###o# o #$    $# o #o### ### # ##o#o#  o o  o  o###  ###o  o  o o  #o#o## # #$# # # #o#$o o  o o$#o# # # #$# # ##o#o  #o#$#o# ## o####o ## #o#$#o#  o#o## # ### # # #$ o  o  o  o $# # # ### # ##o#o o o o o####o######o####o o o o o#o## # #######  o   o    o   o  ####### # ##o#o o $ o o# #$########$# #o o $ o o#o## # ####### # #  oooooo  # # ####### # ##o#$ o o o $#$ o oooooo o $#$ o o o $#o## #################################### ##$ o o o o o o o $    $ o o o o o o o $######################################## "
map_03: string "                                        #########################################$ o o o o o o o $ @o $ o o o o o o o $##  ##### # #### ######## #### # #####  ###o#  o  #o#$ # #$    $# # $#o#  o  #o###  #o# #o# # o#o# #oo# #o#o # #o# #o#  ##$## # # #o o o o #oo# o o o o# # # ##$##  #o $ o##o###o# #oo# #o###o##o $ o#  ###o# # # o  o # #$    $# # o  o # # #o###  #o# #o####o#o########o#o####o# #o#  ##$##  o  o o  o o o  o o o  o o  o  ##$##  # ########o#o###oo###o#o######## #  ## o#o o o o $ # #$    $# # $ o o o o#o ##o o ######o o# o  oo  o #o o###### o o##  # #$  $# # # o  oo  o # # #$  $# #  ## o#o  ## o # # #$    $# # # o ##  o#o ##  o #o ## $ o o##$  $##o o $ ## o# o  ## o#o#   ## o##  ##  ##  ##o ##   #o#o ##o # #o#$ ## o##o #oo# o##o ## $#o# # o##  #o# ## o#o  ## o  o ##  o#o ## #o#  ##$## # o o o # o o$  $o o # o o o # ##$##  #o#o#####o#o  $ ## $  o#o#####o#o#  ###o# # o o o # ## o##o ## # o o o # #o###  #o# #$#o#o#o## o##o ##o#o#o#$# #o#  ##$## #o  # # # o $ ## $ o # # #  o# ##$##  #o###o o $#o o $##$ o o#$ o o###o#  ###o# o   ##### ########## #####   o #o###  #####o o o o o o##o o o o o o#####  ##$ o o o o o o o $ ## $ o o o o o o o $######################################## "

cur_map: var #1200 ; guarda o mapa atual atualizado na memoria
snake: var #1200 ; vetor com as posicoes dos segmentos do player.
p_head: var #1 ; guarda o indice da cabeca do player na lista.
p_tail: var #1 ; guarda o indice da cauda do player na lista.
points: var #1 ; guarda a pontuacao do jogador.

;---- fim da declaracao de variaveis -----

;---- inicio do programa principal -----

main:

	; printa o titulo.
	loadn r0, #492			; posicao na tela onde a mensagem sera escrita
	loadn r1, #msg_title	; carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #512			; seleciona a cor da mensagem
	call print_str  

	; printa a mensagem de inicio.
	loadn r0, #689			; posicao na tela onde a mensagem sera escrita
	loadn r1, #msg_start	; carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0			; seleciona a cor da mensagem
	call print_str  

	loadn r7, #0 ; seed para o mapa aleatório

	loop_wait_start: ; espera o jogador iniciar.

		loadn r0, #0 ; limpa o registrador que recebera input.
		inchar r0 ; tenta receber input.
		
		loadn r1, #' ' ; verifica se o input ocorreu.
		cmp r0, r1
		jeq call_start ; inicia o jogo.

		inc r7 ; caso nao haja input, incrementa o contador da seed.
		jmp loop_wait_start ; continua o loop.
		
	call_start:
	
	call start_game ; inicia um novo jogo.
	
	call clear_screen ; limpa a tela apos o final do jogo.
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

	loadn r1, #0 ; inicializa os pontos.
	store points, r1

	call draw_stage ; desenha o estagio.
	call gameplay_loop ; chama o loop principal do jogo.
	
	pop r1 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	
	rts

; desenha o estagio a partir de um mapa base
; parametros:
;	r7: seed do mapa a ser usado.
draw_stage:

	push r0	; protege os valores dos registradores que serao usados na subrotina na pilha.
	push r1
	push r2
	push r4
	push r5
	push r6
	push r7

	loadn r0, #3 ; numero total de maps.
	mod r7, r7, r0 ; calcula qual mapa usar.
	inc r7
	
	loadn r1, #1 ; usado para comparacao
	
	seed_1: 
		cmp r1, r7 ; verifica se a seed aponta para o mapa 1.
		jne seed_2
		
			loadn r1, #map_01 ; carrega o mapa 1.
			jmp seeded
	
	seed_2:
		inc r1
		cmp r1, r7 ; verifica se a seed aponta para o mapa 2.
		jne seed_3
		
			loadn r1, #map_02 ; carrega o mapa 2.
			jmp seeded
		
	seed_3:
	
		loadn r1, #map_03 ; carrega o mapa que sobrar (3).
	
	seeded:
	
	loadn r0, #1199 ; carrega o offset do ultimo char.
	loadn r6, #cur_map ; carrega o mapa da memoria.
	
	add r1, r0, r1 ; carrega a posicao apos o ultimo char no mapa base.
	add r6, r0, r6 ; carrega a posicao apos o ultimo char no mapa da memoria.

	; desenha o estágio.
	draw_loop:	

		loadi r4, r1 ; carrega o char a ser printado.		
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
		
		dec r1 ; reposiciona no mapa base.
		dec r6 ; reposiciona no mapa da memoria.
		dec r0 ; reposiciona na tela.
		
		jnz draw_loop ; criterio de parada.
		
	draw_exit:

		; printa os pontos inicias.
		loadn r0, #0
		loadn r4, #'0'
		outchar r4, r0
		
		; printa o numero da fase.
		loadn r0, #1199
		loadn r2, #256
		add r4, r4, r7 ; obtem o char do numero.
		
		add r4, r4, r2 ; adiciona a cor.
		outchar r4, r0 ; printa o numero do mapa.
	
		pop r7 ; resgata os valores dos registradores utilizados na subrotina da pilha.
		pop r6
		pop r5 
		pop r4
		pop r2
		pop r1
		pop r0
		
	rts

; faz o loop principal do jogo.
gameplay_loop:

	push r0 ; protege os valores dos registradores que serao usados na subrotina na pilha.
	push r1
	push r2
	push r6
	push r7

	game_loop:

		loadn r0, #0 ; limpa o registrador que recebera input.
		inchar r0 ; recebe input.
		
		input_w: ; move o jogador para a frente.
		
			loadn r1, #'w' ; verifica se o player pressionou para cima.
			cmp r0, r1
			jeq input_forward
			
			loadn r1, #'W' ; verifica se o player pressionou para cima (maiuscula).
			cmp r0, r1
			jne input_s				
			
			input_forward: ; marca que o player tentou mover para cima.
			
				loadn r1, #255 ; carrega para comparacao.
				wait_release_key_w: ; espera a tecla ser solta.
			
					inchar r2
					cmp r1, r2 ; condicao de saida.
					jeq wait_release_key_w_exit
					
					jmp wait_release_key_w ; continua o loop.
				wait_release_key_w_exit:
			
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
			
				loadn r1, #255 ; carrega para comparacao.
				wait_release_key_s: ; espera a tecla ser solta.
			
					inchar r2
					cmp r1, r2 ; condicao de saida.
					jeq wait_release_key_s_exit
					
					jmp wait_release_key_s ; continua o loop.
				wait_release_key_s_exit:
				
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
			
				loadn r1, #255 ; carrega para comparacao.
				wait_release_key_a: ; espera a tecla ser solta.
			
					inchar r2
					cmp r1, r2 ; condicao de saida.
					jeq wait_release_key_a_exit
					
					jmp wait_release_key_a ; continua o loop.
				wait_release_key_a_exit:
				
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
			
				loadn r1, #255 ; carrega para comparacao.
				wait_release_key_d: ; espera a tecla ser solta.
			
					inchar r2
					cmp r1, r2 ; condicao de saida.
					jeq wait_release_key_d_exit
					
					jmp wait_release_key_d ; continua o loop.
				wait_release_key_d_exit:
			
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
				
					call update_points
					jmp checked
			
			l_checked_obstacle: ; verifica se o player colidiu com um obstaculo.
				loadn r6, #2
				cmp r6, r7
				jne checked
				
					jmp end_game ; finaliza o jogo.
			
			checked:
			
				call redraw_player ; redesenha o player.
		
		end_input_check:
		
		call hold ; aguarda por alguns ciclos.
		
		jmp game_loop ; continua o loop.
	
	end_game:
	
		loadn r0, #608			; posicao na tela onde a mensagem sera escrita
		loadn r1, #msg_restart	; carrega r1 com o endereco do vetor que contem a mensagem
		loadn r2, #0			; seleciona a cor da mensagem
		call print_str
		
		loadn r0, #31			; posicao na tela onde a mensagem sera escrita
		loadn r1, #msg_end		; carrega r1 com o endereco do vetor que contem a mensagem
		loadn r2, #2304			; seleciona a cor da mensagem
		call print_str  
		
		loop_wait_restart: ; espera o jogador reiniciar.

			loadn r0, #0 ; limpa o registrador que recebera input.
			inchar r0 ; tenta receber input.
			
			loadn r1, #' ' ; verifica se o input ocorreu.
			cmp r0, r1			
			jeq call_restart ; reinicia o jogo.

			jmp loop_wait_restart ; continua o loop.
		
	call_restart:
	
	loadn r1, #255 ; carrega para comparacao.
	wait_release_key_restart: ; espera a tecla ser solta.

		inchar r0
		cmp r1, r0 ; condicao de saida.
		jeq wait_release_key_restart_exit
		
		jmp wait_release_key_restart ; continua o loop.
	wait_release_key_restart_exit:
	
	call hold ; faz um delay antes de recomecar.
	
	pop r7 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r6
	pop r2
	pop r1
	pop r0
	
	rts

; atualiza a posicao do player baseada no input.
; parametros:
;	r6: movimentação no eixo x.
; 		0 - sem movimemento, 1 - direita, 2 - esquerda
;	r7: movimentação no eixo 7.
; 		0 - sem movimemento, 1 - cima, 2 - baixo
; retorna a nova posicao do player em r2.
update_pos:

	push r0 ; protege os valores dos registradores que serao usados na subrotina na pilha.
	push r1
	push r3
	push r4
	push r5
	
	loadn r0, #snake ; carrega a posicao inicial do vetor do player.
	load r1, p_head ; carrega em que posicao do vetor esta a cabeca do player.
	add r3, r0, r1 ; calcula o endereco da posicao da cabeca do player.
	
	loadi r2, r3 ; carega a posicao atual da cabeca do player.
	
	loadn r4, #'*' ; transforma a cabeca antiga do player em corpo.
	loadn r5, #1536
	add r4, r4, r5
	outchar r4, r2
	
	loadn r4, #40 ; guarda o tamanho de uma linha.
	
	move_up:
	loadn r5, #1
	cmp r6, r5 ; detecta se o input eh para cima.
		jne move_right
			
			sub r2, r2, r4 ; calcula a nova posicao da cabeca do player.
			jmp end_move
	
	move_right:
	cmp r7, r5 ; detecta se o input eh para direita.
		jne move_down
		
			inc r2 ; calcula a nova posicao da cabeca do player.
			jmp end_move
	
	move_down:
	loadn r5, #2 ; detecta se o input eh para baixo.
	cmp r6, r5
		jne move_left
		
			add r2, r2, r4 ; calcula a nova posicao da cabeca do player.
			jmp end_move
	
	move_left:
	cmp r7, r5 ; detecta se o input eh para esquerda.
		jne end_move
		
			dec r2 ; calcula a nova posicao da cabeca do player.
			jmp end_move
	
	end_move:
	
	inc r1 ; calcula a nova posicao no vetor da cabeca do player.
	loadn r5, #1200
	mod r1, r1, r5
	
	store p_head, r1 ; guarda na memoria.
	
	add r3, r0, r1 ; calcula o endereco da posicao da cabeca do player.
	storei r3, r2 ; guarda a posicao da cabeca do jogador na memoria.
	
	pop r5 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r4
	pop r3
	pop r1
	pop r0
	
	rts

; checa a posicao para a qual o player se moveu.
; retorna em r7 o resultado ao checar a posição:
; 	0 - vazia, 1 - dinheiro (crescimento do player) , 2 - Obstaculo (morte do player)
check_pos:

	push r0 ; protege os valores dos registradores que serao usados na subrotina na pilha.
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
	
	loadn r1, #'#' ; checa se o jogador andou para uma parede.
		cmp r2, r1
		jne player_head_check
	
		jmp check_die
	
	player_head_check: ; checa se o jogador andou para a propria cabeca.
		loadn r1, #'@'
		cmp r2, r1
		jne player_body_check
	
		jmp check_die
	
	player_body_check: ; checa se o jogador andou para o proprio corpo.
		loadn r1, #'*'
		cmp r2, r1
		jne money_check
	
		jmp check_die
		
	money_check: ; checa se o jogador andou para um dinheiro.
		loadn r1, #'o'
		cmp r2, r1
		jne bonus_money_check
	
		load r1, points ; adiciona pontos ao jogador.
		loadn r7, #1
		add r1, r1, r7
		store points, r1
		jmp get_money
		
	bonus_money_check: ; checa se o jogador andou para um dinheiro bonus.
		loadn r1, #'$'
		cmp r2, r1
		jne check_empty
	
		load r1, points ; adiciona pontos bonus ao jogador.
		loadn r7, #4
		add r1, r1, r7
		store points, r1
	
	get_money: ; marca que o jogador conseguiu dinheiro (deve crescer e atualizar pontos).
	
		loadn r7, #1
		jmp end_check 
		
	check_die: ; marca que o jogador colidiu (deve morrer e acabar o jogo).
	
		loadn r7, #2
		jmp end_check
		
	check_empty: ; marca que o jogador andou para um espaco vazio (deve apenas se movimentar).
	
		loadn r7, #0		
	
	end_check:

	pop r3 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r2
	pop r1
	pop r0

	rts

; redesenha o player.
; parametros:
;	r7: crescimento do player.
; 		0 - nao cresce, 1 - cresce
redraw_player:
	
	push r0 ; protege os valores dos registradores que serao usados na subrotina na pilha.
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
	cmp r0, r7 ; apaga a cauda do player caso ele nao tenha crescido.
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
		
		inc r1 ; atualiza a posicao da cauda no vetor.
		store p_tail, r1
		
	redrawn:

	pop r3 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r2
	pop r1
	pop r0

	rts
	
; atualiza o placar.
update_points:

	push r0 ; protege os valores dos registradores que serao usados na subrotina na pilha.
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, points ; carrega os pontos.
	
	loadn r1, #0 ; posicao para printar.
	loadn r2, #0 ; usado para comparacao.
	loadn r5, #'0' ; char de referencia.
	
	print_ten_thousands:
	
		loadn r3, #10000 ; verifica as dezenas de milhares.
		div r4, r0, r3
		
		cmp r2, r4 ; se nao ha dezenas de milhares, so printa se algo ja foi printado.
		jeq print_thousands
		
			add r4, r4, r5 ; obtem o char correto.
			outchar r4, r1 ; printa.
			inc r1 ; avanca a posicao.
			dec r2 ; marca que algo foi printado.
			
			mod r0, r0, r3 ; remove o que ja foi printado do numero.
			
	print_thousands: ; verifica os milhares.
	
		loadn r3, #1000
		div r4, r0, r3
		
		cmp r2, r4 ; se nao ha milhares, so printa se algo ja foi printado.
		jeq print_hundreds 
		
			add r4, r4, r5 ; obtem o char correto.
			outchar r4, r1 ; printa.
			inc r1 ; avanca a posicao.
			dec r2 ; marca que algo foi printado.
			
			mod r0, r0, r3 ; remove o que ja foi printado do numero.
		
	print_hundreds:
	
		loadn r3, #100 ; verifica as centenas.
		div r4, r0, r3
		
		cmp r2, r4 ; se nao ha centenas, so printa se algo ja foi printado.
		jeq print_tens
		
			add r4, r4, r5 ; obtem o char correto.
			outchar r4, r1 ; printa.
			inc r1 ; avanca a posicao.
			dec r2 ; marca que algo foi printado.
			
			mod r0, r0, r3 ; remove o que ja foi printado do numero.
	
	print_tens:
	
		loadn r3, #10 ; verifica as dezenas.
		div r4, r0, r3
		
		cmp r2, r4 ; se nao ha dezenas, so printa se algo ja foi printado.
		jeq print_units
		
			add r4, r4, r5 ; obtem o char correto.
			outchar r4, r1 ; printa.
			inc r1 ; avanca a posicao.
			dec r2 ; marca que algo foi printado.
			
			mod r0, r0, r3 ; remove o que ja foi printado do numero.
	
	print_units: 
		
		cmp r2, r0 ; se nao ha unidades, so printa se algo ja foi printado.
		jeq print_extra_zero
		
			add r4, r0, r5 ; obtem o char correto.
			outchar r4, r1 ; printa.
			inc r1 ; avanca a posicao.
			dec r2 ; marca que algo foi printado.
			
	print_extra_zero:
		outchar r5, r1 ; printa um 0 extra no final.
	
	pop r5 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
		
rts

; limpa completamente a tela
clear_screen:

	push r0 ; protege os valores dos registradores que serao usados na subrotina na pilha.
	push r1

	loadn r0, #1200 ; posicao inicial;
	loadn r1, #' ' ; caracter de vazio.
	
	loop_clear_screen:
		
		dec r0
		outchar r1, r0 ; limpa a posicao da tela.
		jnz loop_clear_screen ; condicao de saida.
	
	exit_clear_screen:
	
	pop r1 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r0
	
	rts
		
hold: ; aguarda por alguns ciclos.

	
	push r0 ; protege os valores dos registradores que serao usados na subrotina na pilha.
	push r1
	push r2
	
	loadn r0, #0 ; usados para contar o loop de fora.
	loadn r2, #72 ; ciclos para desperdicar.
	
	hold_loop:
		cmp r0, r2 ; condicao de parada do loop externo.
		jeq hold_exit
		
			loadn r1, #0 ; usado para contar o loop de dentro.
		
			hold_loop_in:
			cmp r1, r2 ; condicao de parada do loop interno.
			jeq hold_exit_in
			
				nop ; noop para dar sorte.		
			
				inc r1
				jmp hold_loop_in ; continua o loop.	
			
			hold_exit_in:
		
			inc r0
			jmp hold_loop ; continua o loop.	
	
	hold_exit:
	
	pop r2 ; resgata os valores dos registradores utilizados na subrotina da pilha.
	pop r1
	pop r0

	rts
		
;---- fim das subrotinas -----