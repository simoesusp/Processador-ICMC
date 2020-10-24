; Trabalho ORG
;
;Jogo: Snake
;
; Murillo Sobral
; nUSP: 6792109
; mhsobrall@gmail.com

jmp main

; Variaveis da Cobra ------------------

cabecaPos : var #1 		; variavel de posição da cabeça da cobra
static cabecaPos, #540 	; posição inicial da cobra

caudaPos : var #1 		; variavel de posição da cauda da cobra (ultima posição)
static caudaPos, #538 	; posição inicial da cauda da cobra

corpoPos : var #100		; Tamanho do corpo e corpo inicial
static corpoPos + #0, #540
static corpoPos + #1, #539
static corpoPos + #2, #538

tamCobra : var #1 		; Tamanho da cobra e tamanho inicial
static tamCobra, #3

; Caracteres da cabeça da cobra--------

CaracterCabeca : var #1 
static CaracterCabeca, #'>' ; cabeça inicial (indo para a direita)

CabecaEsq : var #1
CabecaDir : var #1
CabecaCima : var #1
CabecaBaixo : var #1

static CabecaEsq, #'<' ; possibilidades para a cabeça
static CabecaDir, #'>'
static CabecaCima, #'^'
static CabecaBaixo, #'V'

CaracterCorpo : var #1
static CaracterCorpo, #'@' ; caracter do corpo
; -------------------------------

; Variaveis da comida -----------

CaracterComida : var #1
static CaracterComida, #'O' ; caracter da comida

comidaPos : var #1
static comidaPos, #425 ; posição da comida

comidaPode : var #1
static comidaPode, #0 ; posição possivel da comida

; Variaveis de movimentação -----

Direcao : var #1
Static Direcao, #2 ; indo para a direita inicialmente

; Variaveis de score

scoredezena : var #1
scoreunidade : var #1
scorecentena : var #1

static scoreunidade, #'0'
static scoredezena, #'0'
static scorecentena, #'0'

posicaodezena : var #1
posicaounidade : var #1
posicaocentena : var #1

static posicaounidade, #77
static posicaodezena, #76
static posicaocentena, #75

; Variaveis de velocidade

valordelay : var #1
offsetdelay : var #1
decdelay : var #1

static decdelay, #100
static valordelay, #65000
static offsetdelay, #5

;
; inicio do programa
;
main :
			call constroiCenario ; constroi cenario e tela de menu
		
		
		; Espera até o usuário apertar enter para começar o jogo
		loadn r2, #13 ; Caracter do enter
		
loopmenu: 

		inchar r1 ; Le teclado

		cmp r1,r2
		jeq iniciaJogo ; Se apertou enter, inicia o jogo.	
		jmp loopmenu   ; Se não, fica em loop	

iniciaJogo: ; --------------------- INICIO
		
		call apagaMenu ; Apaga o menu do jogo
		
							    ; Desenha cobra inicial
		load r0,cabecaPos       ; Carrega posição da cabeça
		load r1,CaracterCabeca	; carrega caracter da cabeça
		outchar r1,r0			; desenha cabeça
		
		dec r0					; decrementa posição para desenhar o resto do corpo
		load r1,CaracterCorpo	; carrega caracter do corpo
		outchar r1,r0			; desenha um segmento do corpo
		dec r0
		outchar r1,r0			; desenha outro segmento do corpo
		
		load r0, comidaPos		; Carrega posição da comida
		load r1, CaracterComida ; carrega caracter da comida
		outchar r1,r0			; desenha comida na tela
				
resetacomida: 					; reseta posição da comida para a primeria possivel do vetor 'comida'
		loadn r6,#0				

movebixo: 						; loop para movimentação da cobra
		loadn r0,#1037			; carrega tamanho do vetor de posições possiveis da comida
		cmp r0,r6				; compara r6 com o tamanho do vetor
		jle resetacomida		; se r6 for maior, reseta o valor de r6 para zero
		loadn r1,#5				; case nao for maior, incremeta em 5
		add r6,r6,r1			; isso fara com que a comida apareça em uma posição aleatoria salva nesse vetor 'comida'
		
		call Movimenta			; função que realiza movimentação da cobra (também checa colisões)
		
		loadn r0, #0
		load r1, valordelay
		
delay:	
	push r0
	push r1
	
	loadn r1, #5  ; a
   Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	loadn r0, #300000	; b
   Delay_volta: 
	dec r0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	jnz Delay_volta	
	dec r1
	jnz Delay_volta2
		
	cmp r1,r0				; Delay, para controlar a velocidade da cobra
	jeq movebixo			; ao terminar o delay, retorna para movimentação da cobra	
	inc r0
	jmp delay
	jmp FIM
		
Movimenta: ; ------------------------------------------------------------- Inicia movimentação da cobra

		; Checa se alguma tecla de movimento foi pressionada
		inchar r0
		loadn r1,#'w' ; Tecla de cima
		cmp r1,r0
		jeq mudaDirCima
		loadn r1,#'s'; Tecla de baixo
		cmp r1,r0
		jeq mudaDirBaixo
		loadn r1,#'d' ; Tecla de direita
		cmp r1,r0
		jeq mudaDirDireita
		loadn r1,#'a' ; Tecla de esquerda
		cmp r1,r0
		jeq mudaDirEsquerda
		
		jmp Movimenta2
		
; Atualiza direção de movimento
mudaDirCima: 
			 load r2, Direcao			; Carrega direção atual
			 loadn r3,#3				; Carrega direção que não poderia mudar o movimento
			 cmp r2,r3					; Compara se são iguais
			 jeq Movimenta2				; Se sim, não altera direção
			 load r1,CabecaCima			; Se não, carrega caracter de cabeça para cima
			 store CaracterCabeca, r1	; atualiza caracter da cabeça com o carregado acima
			 loadn r0,#1				; carrega 1 em r0
			 store Direcao,r0			; atualiza direção como 1 (cima)
			 jmp Movimenta2
mudaDirDireita: 						; O mesmo para as outras direções		
			 load r2, Direcao
			 loadn r3,#4
			 cmp r2,r3
			 jeq Movimenta2
			 load r1,CabecaDir
			 store CaracterCabeca, r1
			 loadn r0,#2 
			 store Direcao,r0
			 jmp Movimenta2
mudaDirBaixo: 
			 load r2, Direcao
			 loadn r3,#1
			 cmp r2,r3
			 jeq Movimenta2
			 load r1,CabecaBaixo
			 store CaracterCabeca, r1 
			 loadn r0,#3
			 store Direcao,r0
			 jmp Movimenta2
mudaDirEsquerda: 
			 load r2, Direcao
			 loadn r3,#2
			 cmp r2,r3
			 jeq Movimenta2
			 load r1,CabecaEsq
			 store CaracterCabeca, r1 
			 loadn r0,#4
			 store Direcao,r0
			 jmp Movimenta2

; Continua movimentação da cobra
Movimenta2:
		
		; Apaga a cauda atual
		loadn r0,#' '			; Caracter de apagar
		loadn r1, #corpoPos		; vetor de posições da cobra
		load r2, tamCobra		; tamanho da cobra
		
		dec r2					; decrementa tamanho da cobra para acessar ultima posição do vetor (cauda)
		add r3,r1,r2			; carrega em r3 posição do ultimo elemento do vetor
		
		loadi r4,r3				; carrega em r4 valor na ultima posição do vetor
		
		outchar r0,r4			; apaga cauda
	
		load r0, Direcao		; Verifica qual a direção demovimento, para calcular a nova posição da cabeça
		loadn r1, #1; 
		cmp r1,r0
		jeq moveCima			; Cima
		loadn r1,#3;
		cmp r1,r0
		jeq moveBaixo			; Baixo
		loadn r1,#2 ; 
		cmp r1,r0
		jeq moveDireita			; Esquerda
		loadn r1,#4 ;
		cmp r1,r0
		jeq moveEsquerda		; Direita
		
moveCima:						; Movimenta cabeça para cima
		loadn r0,#40
		load r3,CaracterCorpo
		load r4,CaracterCabeca
		load r1,cabecaPos
		
		sub r2,r1,r0
		store cabecaPos, r2
		
		jmp Movimenta3
		
moveDireita:					; Movimenta cabeça para a direita
		loadn r0,#1
		load r3,CaracterCorpo
		load r4,CaracterCabeca
		load r1,cabecaPos
		
		add r2,r1,r0
		store cabecaPos, r2
		
		jmp Movimenta3 
		
moveBaixo:						; Movimenta cabeça para baixo
		loadn r0,#40
		load r3,CaracterCorpo
		load r4,CaracterCabeca
		load r1,cabecaPos
		
		add r2,r1,r0
		store cabecaPos, r2
		
		jmp Movimenta3
		
moveEsquerda:					; Movimenta cabeça para a esquerda
		loadn r0,#1
		load r3,CaracterCorpo
		load r4,CaracterCabeca
		load r1,cabecaPos
		
		sub r2,r1,r0
		store cabecaPos, r2
		
		jmp Movimenta3
		
Movimenta3:				   	

		outchar r3,r1	   ; Movimenta a cabeça
		outchar r4,r2	   ; Desenhando um segmento do corpo na posição anterior, e o caracter de cabeça na nova posição calculada	

		call Colisao	   ; função que checa colisao com as paredes com o corpo e com a comida	
		call atualizaCorpo ; função atualiza as posições do vetor de posições da cobra com um shift right nos valores

return:
		load r0, cabecaPos ; Atualiza posição da cabeça no vetor de posições
		store corpoPos, r0
		rts
		
;----------------------------------------------------------------------------------------- FIM MOVIMENTA

Colisao:
		
		load r0, cabecaPos
		
		load r1, comidaPos ; Checa colisão com a comida
		cmp r0,r1
		jeq incrementa
		
		loadn r1,#muro	   ; Checa colisão com as paredes
		loadn r2,#'#'
		add r1,r1,r0
		loadi r3,r1
		cmp r2,r3
		jeq GameOver	   
		
		loadn r0, #corpoPos ; Checa colisão com o proprio corpo
		load r1, cabecaPos
		loadn r2, #1
		load r3, tamCobra
		inc r0

loopcolisao:		
		cmp r3,r2
		jeq fimcolisao
		loadi r4,r0
		cmp r4,r1
		jeq GameOver
		inc r2
		inc r0
		jmp loopcolisao
		
fimcolisao:
		rts
		
incrementa: ; Caso em que a cobra comeu a comida

		load r0, tamCobra ; Incrementa tamanho da cobra e redesenha a comida
		inc r0
		store tamCobra, r0
		
		call atualizaCorpo
		
		load r0, CaracterComida
		loadn r1,#comida
		add r3,r6,r1
		loadi r2,r3
		; Idealmente verifica se em r2 é posição valida
		
		loadn r4,#corpoPos
		load r5,tamCobra
		loadn r7,#0
		
loopposvalida:
		cmp r7,r5 ; Verifica se percorreu toda a cobra
		jeq desenhacomida
		loadi r1,r4 
		cmp r1,r2 ; Verifica se a posição da comida estр em cima da cobra
		jeq naovalida
		
		inc r4
		inc r7
		
		jmp loopposvalida
		
naovalida:
		loadn r1,#1
		outchar r0,r1
		
		load r2,comidaPode

desenhacomida:		
		store comidaPos, r2
		outchar r0,r2
		
		; Controle de velocidade da cobra
		
		load r0, offsetdelay ; carrega o contador de aumento da velocidade
		loadn r1,#0
		cmp r1,r0			 ; quando o contador atinge zero, aumenta a velocidade da cobra
		jeq aumentavelo		 ; 	
		
		dec r0				 ; se nao for zero, decrementa o contador
		store offsetdelay,r0 ; armazena o novo valor
		
		jmp score			 ; atualiza o score do jogo

aumentavelo:				 ; Aqui acontece quando o contador atinge zero
		loadn r0,#5			 ; Reinicializa o contador de velocidade 
		store offsetdelay,r0 ; Armazena valor
		
		load r0,decdelay	 ; Carrega valor de aumento da velocidade	
		load r1,valordelay   ; Carrega valor de delay
		loadn r2,#300		 ; Carrega valor minimo do delay, antes do nivel mais dificil
		
		jmp continua		 ; senão, continua execuусo

		
continua:				
		sub r1,r1,r0		 ; subtrai o valor de delay, para aumentar a velocidade	
		store valordelay,r1
		
		; Atualiza score
score:
		load r0, scoreunidade	; Soma um ponto na unidade
		loadn r1, #'9'			; Se a unidade ja for 9, então vai pra somar na dezena
		cmp r1, r0
		jeq somadezena
		
		inc r0  
		store scoreunidade, r0
		
		jmp atualizascore
		
somadezena: 					; Soma um na dezena
		loadn r0, #'0'			
		store scoreunidade, r0
		
		load r0, scoredezena
		loadn r1, #'9'			; Se a dezena é 9, então vai somar na centena
		cmp r1, r0
		jeq somacentena
		
		inc r0  
		store scoredezena, r0
		
		jmp atualizascore
		
somacentena:					; Soma um na centena
		loadn r0, #'0'
		store scoredezena, r0
		
		load r0, scorecentena
		loadn r1, #'9'			; Se a centena é 9, então da gameover, é impossível chegar a pontuação de 900 ja que a cobra tem tamanho maximo de 100
		cmp r1, r0
		jeq GameOver
		
		inc r0  
		store scorecentena, r0
		
atualizascore:					; Reescreve o score na tela para atualizar a pontuação
		load r0,scoreunidade
		load r1,posicaounidade
		outchar r0,r1
		
		load r0,scoredezena
		load r1,posicaodezena
		outchar r0,r1
		
		load r0,scorecentena
		load r1,posicaocentena
		outchar r0,r1
		
		jmp return

;--------------------------------------------- GAME OVER
GameOver:
		
		loadn r0, #gameover ; Caracter que constitui a parede
		
		;Constrзi parede superior
		loadn r1, #81
		loadn r2, #1200
		
		add r0,r0,r1
		
loop2:	cmp r1,r2
		jeq reinicia
		loadi r3,r0
		outchar r3,r1
		inc r1
		inc r0
		jmp loop2
		
reinicia:
		; Reinicia variaveis
		loadn r0,#3           ; reinicia tamanho da cobra
		store tamCobra, r0
		
		loadn r0, #corpoPos   ; reinicia posição da cobra
		loadn r1, #540
		storei r0, r1
		store cabecaPos, r1
		dec r1
		inc r0
		storei r0,r1
		dec r1
		inc r0
		storei r0,r1
		
		loadn r0,#5			; Atualiza contador de velocidade
		store offsetdelay,r0
		
		loadn r0,#425
		store comidaPos, r0 ; reinica posição da comida
		
		loadn r0,#65000
		store valordelay, r0 ; reinicia velocidade da cobra
		
		; Reinicia posição inicial da cobra para a direita
		load r0,CabecaDir	
		store CaracterCabeca, r0
		loadn r0, #2
		store Direcao, r0
		;-------------------------------------------------
		
		; Reinicia placar do jogo
		loadn r0,#'0'
		store scoreunidade,r0
		load r1,posicaounidade
		outchar r0,r1
		
		loadn r0,#'0'
		store scoredezena,r0
		load r1,posicaodezena
		outchar r0,r1
		
		loadn r0,#'0'
		store scorecentena,r0
		load r1,posicaocentena
		outchar r0,r1
		;-------------------------
		
		loadn r2, #13
		jmp loopmenu
		
; Atualiza as posições da cobra, realizando um 'shift right' no vetor de posições da cobra
atualizaCorpo:
		
		loadn r0, #corpoPos ; posição inicial de posições da cobra
		load r1, tamCobra   ; tamanho da cobra
		loadn r2,#0         ; posição atual no vetor de posições
		loadn r3,#0			; auxiliar
		
loopatualiza:
		
		cmp r2,r1           ; verifica se chegou ao fim do vetor
		jeq fimatualiza     ; se sim termina
		
		mov r4, r3			; copia em auxiliar
		loadi r3, r0		; salva valor da posição atual do vetor
		storei r0, r4		; carrega valor salvo anteriormente se necessário para a posição atual
		
		inc r0				; incrementa posição do vetor
		inc r2
		
		jmp loopatualiza
		
fimatualiza: 
		store comidaPode, r4
		rts
			 
apagaMenu: ; Apaga a região central da tela onde escreve game over e o menu inicial

		loadn r0, #575
		loadn r1, #586
		loadn r3, #40
		loadn r4, #80
		loadn r2, #' '
		
loopapagamenu:
		cmp r0,r1
		jeq fimapagamenu
		
		outchar r2,r0
		add r5,r0,r4
		outchar r2,r5
		add r5,r5,r3
		outchar r2,r5
		
		inc r0
		jmp loopapagamenu
		
fimapagamenu: rts ; ---------------------------------
		
constroiCenario:

		loadn r0, #muro ; Caracter que constitui a parede
		
		loadn r1, #0
		loadn r2, #1200
						; Um loop percorre todo o vetor que constitui o cenрrio inicial declarado como 'muro'
loop1:	cmp r1,r2
		jeq fimcenario
		loadi r3,r0
		outchar r3,r1
		inc r1
		inc r0
		jmp loop1
		
fimcenario: rts
		
FIM:		
		halt

;-------------------------------  CENARIO INICIAL

muro : var #1200

static muro + #0, #'#'
static muro + #1, #' '
static muro + #2, #' '
static muro + #3, #' '
static muro + #4, #' '
static muro + #5, #' '
static muro + #6, #' '
static muro + #7, #' '
static muro + #8, #' '
static muro + #9, #' '
static muro + #10, #' '
static muro + #11, #' '
static muro + #12, #' '
static muro + #13, #' '
static muro + #14, #' '
static muro + #15, #' '
static muro + #16, #' '
static muro + #17, #' '
static muro + #18, #' '
static muro + #19, #' '
static muro + #20, #' '
static muro + #21, #' '
static muro + #22, #' '
static muro + #23, #' '
static muro + #24, #' '
static muro + #25, #' '
static muro + #26, #' '
static muro + #27, #' '
static muro + #28, #' '
static muro + #29, #' '
static muro + #30, #' '
static muro + #31, #' '
static muro + #32, #' '
static muro + #33, #' '
static muro + #34, #' '
static muro + #35, #' '
static muro + #36, #' '
static muro + #37, #' '
static muro + #38, #' '
static muro + #39, #'#'
static muro + #40, #'#'
static muro + #41, #' '
static muro + #42, #'S'
static muro + #43, #'N'
static muro + #44, #'A'
static muro + #45, #'K'
static muro + #46, #'E'
static muro + #47, #' '
static muro + #48, #' '
static muro + #49, #' '
static muro + #50, #' '
static muro + #51, #' '
static muro + #52, #' '
static muro + #53, #' '
static muro + #54, #' '
static muro + #55, #' '
static muro + #56, #' '
static muro + #57, #' '
static muro + #58, #' '
static muro + #59, #' '
static muro + #60, #' '
static muro + #61, #' '
static muro + #62, #' '
static muro + #63, #' '
static muro + #64, #' '
static muro + #65, #' '
static muro + #66, #' '
static muro + #67, #' '
static muro + #68, #' '
static muro + #69, #'S'
static muro + #70, #'C'
static muro + #71, #'O'
static muro + #72, #'R'
static muro + #73, #'E'
static muro + #74, #' '
static muro + #75, #'0'
static muro + #76, #'0'
static muro + #77, #'0'
static muro + #78, #' '
static muro + #79, #'#'
static muro + #80, #'#'
static muro + #81, #'#'
static muro + #82, #'#'
static muro + #83, #'#'
static muro + #84, #'#'
static muro + #85, #'#'
static muro + #86, #'#'
static muro + #87, #'#'
static muro + #88, #'#'
static muro + #89, #'#'
static muro + #90, #'#'
static muro + #91, #'#'
static muro + #92, #'#'
static muro + #93, #'#'
static muro + #94, #'#'
static muro + #95, #'#'
static muro + #96, #'#'
static muro + #97, #'#'
static muro + #98, #'#'
static muro + #99, #'#'
static muro + #100, #'#'
static muro + #101, #'#'
static muro + #102, #'#'
static muro + #103, #'#'
static muro + #104, #'#'
static muro + #105, #'#'
static muro + #106, #'#'
static muro + #107, #'#'
static muro + #108, #'#'
static muro + #109, #'#'
static muro + #110, #'#'
static muro + #111, #'#'
static muro + #112, #'#'
static muro + #113, #'#'
static muro + #114, #'#'
static muro + #115, #'#'
static muro + #116, #'#'
static muro + #117, #'#'
static muro + #118, #'#'
static muro + #119, #'#'
static muro + #120, #'#'
static muro + #121, #' '
static muro + #122, #' '
static muro + #123, #' '
static muro + #124, #' '
static muro + #125, #' '
static muro + #126, #' '
static muro + #127, #' '
static muro + #128, #' '
static muro + #129, #' '
static muro + #130, #' '
static muro + #131, #' '
static muro + #132, #' '
static muro + #133, #' '
static muro + #134, #' '
static muro + #135, #' '
static muro + #136, #' '
static muro + #137, #' '
static muro + #138, #' '
static muro + #139, #' '
static muro + #140, #' '
static muro + #141, #' '
static muro + #142, #' '
static muro + #143, #' '
static muro + #144, #' '
static muro + #145, #' '
static muro + #146, #' '
static muro + #147, #' '
static muro + #148, #' '
static muro + #149, #' '
static muro + #150, #' '
static muro + #151, #' '
static muro + #152, #' '
static muro + #153, #' '
static muro + #154, #' '
static muro + #155, #' '
static muro + #156, #' '
static muro + #157, #' '
static muro + #158, #' '
static muro + #159, #'#'
static muro + #160, #'#'
static muro + #161, #' '
static muro + #162, #' '
static muro + #163, #' '
static muro + #164, #' '
static muro + #165, #' '
static muro + #166, #' '
static muro + #167, #' '
static muro + #168, #' '
static muro + #169, #' '
static muro + #170, #' '
static muro + #171, #' '
static muro + #172, #' '
static muro + #173, #' '
static muro + #174, #' '
static muro + #175, #' '
static muro + #176, #' '
static muro + #177, #' '
static muro + #178, #' '
static muro + #179, #' '
static muro + #180, #' '
static muro + #181, #' '
static muro + #182, #' '
static muro + #183, #' '
static muro + #184, #' '
static muro + #185, #' '
static muro + #186, #' '
static muro + #187, #' '
static muro + #188, #' '
static muro + #189, #' '
static muro + #190, #' '
static muro + #191, #' '
static muro + #192, #' '
static muro + #193, #' '
static muro + #194, #' '
static muro + #195, #' '
static muro + #196, #' '
static muro + #197, #' '
static muro + #198, #' '
static muro + #199, #'#'
static muro + #200, #'#'
static muro + #201, #' '
static muro + #202, #' '
static muro + #203, #' '
static muro + #204, #' '
static muro + #205, #' '
static muro + #206, #' '
static muro + #207, #' '
static muro + #208, #' '
static muro + #209, #' '
static muro + #210, #' '
static muro + #211, #' '
static muro + #212, #' '
static muro + #213, #' '
static muro + #214, #' '
static muro + #215, #' '
static muro + #216, #' '
static muro + #217, #' '
static muro + #218, #' '
static muro + #219, #' '
static muro + #220, #' '
static muro + #221, #' '
static muro + #222, #' '
static muro + #223, #' '
static muro + #224, #' '
static muro + #225, #' '
static muro + #226, #' '
static muro + #227, #' '
static muro + #228, #' '
static muro + #229, #' '
static muro + #230, #' '
static muro + #231, #' '
static muro + #232, #' '
static muro + #233, #' '
static muro + #234, #' '
static muro + #235, #' '
static muro + #236, #' '
static muro + #237, #' '
static muro + #238, #' '
static muro + #239, #'#'
static muro + #240, #'#'
static muro + #241, #' '
static muro + #242, #' '
static muro + #243, #' '
static muro + #244, #' '
static muro + #245, #' '
static muro + #246, #' '
static muro + #247, #' '
static muro + #248, #' '
static muro + #249, #' '
static muro + #250, #' '
static muro + #251, #' '
static muro + #252, #' '
static muro + #253, #' '
static muro + #254, #' '
static muro + #255, #' '
static muro + #256, #' '
static muro + #257, #' '
static muro + #258, #' '
static muro + #259, #' '
static muro + #260, #' '
static muro + #261, #' '
static muro + #262, #' '
static muro + #263, #' '
static muro + #264, #' '
static muro + #265, #' '
static muro + #266, #' '
static muro + #267, #' '
static muro + #268, #' '
static muro + #269, #' '
static muro + #270, #' '
static muro + #271, #' '
static muro + #272, #' '
static muro + #273, #' '
static muro + #274, #' '
static muro + #275, #' '
static muro + #276, #' '
static muro + #277, #' '
static muro + #278, #' '
static muro + #279, #'#'
static muro + #280, #'#'
static muro + #281, #' '
static muro + #282, #' '
static muro + #283, #' '
static muro + #284, #' '
static muro + #285, #' '
static muro + #286, #' '
static muro + #287, #' '
static muro + #288, #' '
static muro + #289, #' '
static muro + #290, #' '
static muro + #291, #' '
static muro + #292, #' '
static muro + #293, #' '
static muro + #294, #' '
static muro + #295, #' '
static muro + #296, #' '
static muro + #297, #' '
static muro + #298, #' '
static muro + #299, #' '
static muro + #300, #' '
static muro + #301, #' '
static muro + #302, #' '
static muro + #303, #' '
static muro + #304, #' '
static muro + #305, #' '
static muro + #306, #' '
static muro + #307, #' '
static muro + #308, #' '
static muro + #309, #' '
static muro + #310, #' '
static muro + #311, #' '
static muro + #312, #' '
static muro + #313, #' '
static muro + #314, #' '
static muro + #315, #' '
static muro + #316, #' '
static muro + #317, #' '
static muro + #318, #' '
static muro + #319, #'#'
static muro + #320, #'#'
static muro + #321, #' '
static muro + #322, #' '
static muro + #323, #' '
static muro + #324, #' '
static muro + #325, #' '
static muro + #326, #' '
static muro + #327, #' '
static muro + #328, #' '
static muro + #329, #' '
static muro + #330, #' '
static muro + #331, #' '
static muro + #332, #' '
static muro + #333, #' '
static muro + #334, #' '
static muro + #335, #' '
static muro + #336, #' '
static muro + #337, #' '
static muro + #338, #' '
static muro + #339, #' '
static muro + #340, #' '
static muro + #341, #' '
static muro + #342, #' '
static muro + #343, #' '
static muro + #344, #' '
static muro + #345, #' '
static muro + #346, #' '
static muro + #347, #' '
static muro + #348, #' '
static muro + #349, #' '
static muro + #350, #' '
static muro + #351, #' '
static muro + #352, #' '
static muro + #353, #' '
static muro + #354, #' '
static muro + #355, #' '
static muro + #356, #' '
static muro + #357, #' '
static muro + #358, #' '
static muro + #359, #'#'
static muro + #360, #'#'
static muro + #361, #' '
static muro + #362, #' '
static muro + #363, #' '
static muro + #364, #' '
static muro + #365, #' '
static muro + #366, #' '
static muro + #367, #' '
static muro + #368, #' '
static muro + #369, #' '
static muro + #370, #' '
static muro + #371, #' '
static muro + #372, #' '
static muro + #373, #' '
static muro + #374, #' '
static muro + #375, #' '
static muro + #376, #' '
static muro + #377, #' '
static muro + #378, #' '
static muro + #379, #' '
static muro + #380, #' '
static muro + #381, #' '
static muro + #382, #' '
static muro + #383, #' '
static muro + #384, #' '
static muro + #385, #' '
static muro + #386, #' '
static muro + #387, #' '
static muro + #388, #' '
static muro + #389, #' '
static muro + #390, #' '
static muro + #391, #' '
static muro + #392, #' '
static muro + #393, #' '
static muro + #394, #' '
static muro + #395, #' '
static muro + #396, #' '
static muro + #397, #' '
static muro + #398, #' '
static muro + #399, #'#'
static muro + #400, #'#'
static muro + #401, #' '
static muro + #402, #' '
static muro + #403, #' '
static muro + #404, #' '
static muro + #405, #' '
static muro + #406, #' '
static muro + #407, #' '
static muro + #408, #' '
static muro + #409, #' '
static muro + #410, #' '
static muro + #411, #' '
static muro + #412, #' '
static muro + #413, #' '
static muro + #414, #' '
static muro + #415, #' '
static muro + #416, #' '
static muro + #417, #' '
static muro + #418, #' '
static muro + #419, #' '
static muro + #420, #' '
static muro + #421, #' '
static muro + #422, #' '
static muro + #423, #' '
static muro + #424, #' '
static muro + #425, #' '
static muro + #426, #' '
static muro + #427, #' '
static muro + #428, #' '
static muro + #429, #' '
static muro + #430, #' '
static muro + #431, #' '
static muro + #432, #' '
static muro + #433, #' '
static muro + #434, #' '
static muro + #435, #' '
static muro + #436, #' '
static muro + #437, #' '
static muro + #438, #' '
static muro + #439, #'#'
static muro + #440, #'#'
static muro + #441, #' '
static muro + #442, #' '
static muro + #443, #' '
static muro + #444, #' '
static muro + #445, #' '
static muro + #446, #' '
static muro + #447, #' '
static muro + #448, #' '
static muro + #449, #' '
static muro + #450, #' '
static muro + #451, #' '
static muro + #452, #' '
static muro + #453, #' '
static muro + #454, #' '
static muro + #455, #' '
static muro + #456, #' '
static muro + #457, #' '
static muro + #458, #' '
static muro + #459, #' '
static muro + #460, #' '
static muro + #461, #' '
static muro + #462, #' '
static muro + #463, #' '
static muro + #464, #' '
static muro + #465, #' '
static muro + #466, #' '
static muro + #467, #' '
static muro + #468, #' '
static muro + #469, #' '
static muro + #470, #' '
static muro + #471, #' '
static muro + #472, #' '
static muro + #473, #' '
static muro + #474, #' '
static muro + #475, #' '
static muro + #476, #' '
static muro + #477, #' '
static muro + #478, #' '
static muro + #479, #'#'
static muro + #480, #'#'
static muro + #481, #' '
static muro + #482, #' '
static muro + #483, #' '
static muro + #484, #' '
static muro + #485, #' '
static muro + #486, #' '
static muro + #487, #' '
static muro + #488, #' '
static muro + #489, #' '
static muro + #490, #' '
static muro + #491, #' '
static muro + #492, #' '
static muro + #493, #' '
static muro + #494, #' '
static muro + #495, #' '
static muro + #496, #' '
static muro + #497, #' '
static muro + #498, #' '
static muro + #499, #' '
static muro + #500, #' '
static muro + #501, #' '
static muro + #502, #' '
static muro + #503, #' '
static muro + #504, #' '
static muro + #505, #' '
static muro + #506, #' '
static muro + #507, #' '
static muro + #508, #' '
static muro + #509, #' '
static muro + #510, #' '
static muro + #511, #' '
static muro + #512, #' '
static muro + #513, #' '
static muro + #514, #' '
static muro + #515, #' '
static muro + #516, #' '
static muro + #517, #' '
static muro + #518, #' '
static muro + #519, #'#'
static muro + #520, #'#'
static muro + #521, #' '
static muro + #522, #' '
static muro + #523, #' '
static muro + #524, #' '
static muro + #525, #' '
static muro + #526, #' '
static muro + #527, #' '
static muro + #528, #' '
static muro + #529, #' '
static muro + #530, #' '
static muro + #531, #' '
static muro + #532, #' '
static muro + #533, #' '
static muro + #534, #' '
static muro + #535, #' '
static muro + #536, #' '
static muro + #537, #' '
static muro + #538, #' '
static muro + #539, #' '
static muro + #540, #' '
static muro + #541, #' '
static muro + #542, #' '
static muro + #543, #' '
static muro + #544, #' '
static muro + #545, #' '
static muro + #546, #' '
static muro + #547, #' '
static muro + #548, #' '
static muro + #549, #' '
static muro + #550, #' '
static muro + #551, #' '
static muro + #552, #' '
static muro + #553, #' '
static muro + #554, #' '
static muro + #555, #' '
static muro + #556, #' '
static muro + #557, #' '
static muro + #558, #' '
static muro + #559, #'#'
static muro + #560, #'#'
static muro + #561, #' '
static muro + #562, #' '
static muro + #563, #' '
static muro + #564, #' '
static muro + #565, #' '
static muro + #566, #' '
static muro + #567, #' '
static muro + #568, #' '
static muro + #569, #' '
static muro + #570, #' '
static muro + #571, #' '
static muro + #572, #' '
static muro + #573, #' '
static muro + #574, #' '
static muro + #575, #' '
static muro + #576, #' '
static muro + #577, #' '
static muro + #578, #'S'
static muro + #579, #'N'
static muro + #580, #'A'
static muro + #581, #'K'
static muro + #582, #'E'
static muro + #583, #' '
static muro + #584, #' '
static muro + #585, #' '
static muro + #586, #' '
static muro + #587, #' '
static muro + #588, #' '
static muro + #589, #' '
static muro + #590, #' '
static muro + #591, #' '
static muro + #592, #' '
static muro + #593, #' '
static muro + #594, #' '
static muro + #595, #' '
static muro + #596, #' '
static muro + #597, #' '
static muro + #598, #' '
static muro + #599, #'#'
static muro + #600, #'#'
static muro + #601, #' '
static muro + #602, #' '
static muro + #603, #' '
static muro + #604, #' '
static muro + #605, #' '
static muro + #606, #' '
static muro + #607, #' '
static muro + #608, #' '
static muro + #609, #' '
static muro + #610, #' '
static muro + #611, #' '
static muro + #612, #' '
static muro + #613, #' '
static muro + #614, #' '
static muro + #615, #' '
static muro + #616, #' '
static muro + #617, #' '
static muro + #618, #' '
static muro + #619, #' '
static muro + #620, #' '
static muro + #621, #' '
static muro + #622, #' '
static muro + #623, #' '
static muro + #624, #' '
static muro + #625, #' '
static muro + #626, #' '
static muro + #627, #' '
static muro + #628, #' '
static muro + #629, #' '
static muro + #630, #' '
static muro + #631, #' '
static muro + #632, #' '
static muro + #633, #' '
static muro + #634, #' '
static muro + #635, #' '
static muro + #636, #' '
static muro + #637, #' '
static muro + #638, #' '
static muro + #639, #'#'
static muro + #640, #'#'
static muro + #641, #' '
static muro + #642, #' '
static muro + #643, #' '
static muro + #644, #' '
static muro + #645, #' '
static muro + #646, #' '
static muro + #647, #' '
static muro + #648, #' '
static muro + #649, #' '
static muro + #650, #' '
static muro + #651, #' '
static muro + #652, #' '
static muro + #653, #' '
static muro + #654, #' '
static muro + #655, #'P'
static muro + #656, #'R'
static muro + #657, #'E'
static muro + #658, #'S'
static muro + #659, #'S'
static muro + #660, #' '
static muro + #661, #'E'
static muro + #662, #'N'
static muro + #663, #'T'
static muro + #664, #'E'
static muro + #665, #'R'
static muro + #666, #' '
static muro + #667, #' '
static muro + #668, #' '
static muro + #669, #' '
static muro + #670, #' '
static muro + #671, #' '
static muro + #672, #' '
static muro + #673, #' '
static muro + #674, #' '
static muro + #675, #' '
static muro + #676, #' '
static muro + #677, #' '
static muro + #678, #' '
static muro + #679, #'#'
static muro + #680, #'#'
static muro + #681, #' '
static muro + #682, #' '
static muro + #683, #' '
static muro + #684, #' '
static muro + #685, #' '
static muro + #686, #' '
static muro + #687, #' '
static muro + #688, #' '
static muro + #689, #' '
static muro + #690, #' '
static muro + #691, #' '
static muro + #692, #' '
static muro + #693, #' '
static muro + #694, #' '
static muro + #695, #' '
static muro + #696, #'T'
static muro + #697, #'O'
static muro + #698, #' '
static muro + #699, #'B'
static muro + #700, #'E'
static muro + #701, #'G'
static muro + #702, #'I'
static muro + #703, #'N'
static muro + #704, #' '
static muro + #705, #' '
static muro + #706, #' '
static muro + #707, #' '
static muro + #708, #' '
static muro + #709, #' '
static muro + #710, #' '
static muro + #711, #' '
static muro + #712, #' '
static muro + #713, #' '
static muro + #714, #' '
static muro + #715, #' '
static muro + #716, #' '
static muro + #717, #' '
static muro + #718, #' '
static muro + #719, #'#'
static muro + #720, #'#'
static muro + #721, #' '
static muro + #722, #' '
static muro + #723, #' '
static muro + #724, #' '
static muro + #725, #' '
static muro + #726, #' '
static muro + #727, #' '
static muro + #728, #' '
static muro + #729, #' '
static muro + #730, #' '
static muro + #731, #' '
static muro + #732, #' '
static muro + #733, #' '
static muro + #734, #' '
static muro + #735, #' '
static muro + #736, #' '
static muro + #737, #' '
static muro + #738, #' '
static muro + #739, #' '
static muro + #740, #' '
static muro + #741, #' '
static muro + #742, #' '
static muro + #743, #' '
static muro + #744, #' '
static muro + #745, #' '
static muro + #746, #' '
static muro + #747, #' '
static muro + #748, #' '
static muro + #749, #' '
static muro + #750, #' '
static muro + #751, #' '
static muro + #752, #' '
static muro + #753, #' '
static muro + #754, #' '
static muro + #755, #' '
static muro + #756, #' '
static muro + #757, #' '
static muro + #758, #' '
static muro + #759, #'#'
static muro + #760, #'#'
static muro + #761, #' '
static muro + #762, #' '
static muro + #763, #' '
static muro + #764, #' '
static muro + #765, #' '
static muro + #766, #' '
static muro + #767, #' '
static muro + #768, #' '
static muro + #769, #' '
static muro + #770, #' '
static muro + #771, #' '
static muro + #772, #' '
static muro + #773, #' '
static muro + #774, #' '
static muro + #775, #' '
static muro + #776, #' '
static muro + #777, #' '
static muro + #778, #' '
static muro + #779, #' '
static muro + #780, #' '
static muro + #781, #' '
static muro + #782, #' '
static muro + #783, #' '
static muro + #784, #' '
static muro + #785, #' '
static muro + #786, #' '
static muro + #787, #' '
static muro + #788, #' '
static muro + #789, #' '
static muro + #790, #' '
static muro + #791, #' '
static muro + #792, #' '
static muro + #793, #' '
static muro + #794, #' '
static muro + #795, #' '
static muro + #796, #' '
static muro + #797, #' '
static muro + #798, #' '
static muro + #799, #'#'
static muro + #800, #'#'
static muro + #801, #' '
static muro + #802, #' '
static muro + #803, #' '
static muro + #804, #' '
static muro + #805, #' '
static muro + #806, #' '
static muro + #807, #' '
static muro + #808, #' '
static muro + #809, #' '
static muro + #810, #' '
static muro + #811, #' '
static muro + #812, #' '
static muro + #813, #' '
static muro + #814, #' '
static muro + #815, #' '
static muro + #816, #' '
static muro + #817, #' '
static muro + #818, #' '
static muro + #819, #' '
static muro + #820, #' '
static muro + #821, #' '
static muro + #822, #' '
static muro + #823, #' '
static muro + #824, #' '
static muro + #825, #' '
static muro + #826, #' '
static muro + #827, #' '
static muro + #828, #' '
static muro + #829, #' '
static muro + #830, #' '
static muro + #831, #' '
static muro + #832, #' '
static muro + #833, #' '
static muro + #834, #' '
static muro + #835, #' '
static muro + #836, #' '
static muro + #837, #' '
static muro + #838, #' '
static muro + #839, #'#'
static muro + #840, #'#'
static muro + #841, #' '
static muro + #842, #' '
static muro + #843, #' '
static muro + #844, #' '
static muro + #845, #' '
static muro + #846, #' '
static muro + #847, #' '
static muro + #848, #' '
static muro + #849, #' '
static muro + #850, #' '
static muro + #851, #' '
static muro + #852, #' '
static muro + #853, #' '
static muro + #854, #' '
static muro + #855, #' '
static muro + #856, #' '
static muro + #857, #' '
static muro + #858, #' '
static muro + #859, #' '
static muro + #860, #' '
static muro + #861, #' '
static muro + #862, #' '
static muro + #863, #' '
static muro + #864, #' '
static muro + #865, #' '
static muro + #866, #' '
static muro + #867, #' '
static muro + #868, #' '
static muro + #869, #' '
static muro + #870, #' '
static muro + #871, #' '
static muro + #872, #' '
static muro + #873, #' '
static muro + #874, #' '
static muro + #875, #' '
static muro + #876, #' '
static muro + #877, #' '
static muro + #878, #' '
static muro + #879, #'#'
static muro + #880, #'#'
static muro + #881, #' '
static muro + #882, #' '
static muro + #883, #' '
static muro + #884, #' '
static muro + #885, #' '
static muro + #886, #' '
static muro + #887, #' '
static muro + #888, #' '
static muro + #889, #' '
static muro + #890, #' '
static muro + #891, #' '
static muro + #892, #' '
static muro + #893, #' '
static muro + #894, #' '
static muro + #895, #' '
static muro + #896, #' '
static muro + #897, #' '
static muro + #898, #' '
static muro + #899, #' '
static muro + #900, #' '
static muro + #901, #' '
static muro + #902, #' '
static muro + #903, #' '
static muro + #904, #' '
static muro + #905, #' '
static muro + #906, #' '
static muro + #907, #' '
static muro + #908, #' '
static muro + #909, #' '
static muro + #910, #' '
static muro + #911, #' '
static muro + #912, #' '
static muro + #913, #' '
static muro + #914, #' '
static muro + #915, #' '
static muro + #916, #' '
static muro + #917, #' '
static muro + #918, #' '
static muro + #919, #'#'
static muro + #920, #'#'
static muro + #921, #' '
static muro + #922, #' '
static muro + #923, #' '
static muro + #924, #' '
static muro + #925, #' '
static muro + #926, #' '
static muro + #927, #' '
static muro + #928, #' '
static muro + #929, #' '
static muro + #930, #' '
static muro + #931, #' '
static muro + #932, #' '
static muro + #933, #' '
static muro + #934, #' '
static muro + #935, #' '
static muro + #936, #' '
static muro + #937, #' '
static muro + #938, #' '
static muro + #939, #' '
static muro + #940, #' '
static muro + #941, #' '
static muro + #942, #' '
static muro + #943, #' '
static muro + #944, #' '
static muro + #945, #' '
static muro + #946, #' '
static muro + #947, #' '
static muro + #948, #' '
static muro + #949, #' '
static muro + #950, #' '
static muro + #951, #' '
static muro + #952, #' '
static muro + #953, #' '
static muro + #954, #' '
static muro + #955, #' '
static muro + #956, #' '
static muro + #957, #' '
static muro + #958, #' '
static muro + #959, #'#'
static muro + #960, #'#'
static muro + #961, #' '
static muro + #962, #' '
static muro + #963, #' '
static muro + #964, #' '
static muro + #965, #' '
static muro + #966, #' '
static muro + #967, #' '
static muro + #968, #' '
static muro + #969, #' '
static muro + #970, #' '
static muro + #971, #' '
static muro + #972, #' '
static muro + #973, #' '
static muro + #974, #' '
static muro + #975, #' '
static muro + #976, #' '
static muro + #977, #' '
static muro + #978, #' '
static muro + #979, #' '
static muro + #980, #' '
static muro + #981, #' '
static muro + #982, #' '
static muro + #983, #' '
static muro + #984, #' '
static muro + #985, #' '
static muro + #986, #' '
static muro + #987, #' '
static muro + #988, #' '
static muro + #989, #' '
static muro + #990, #' '
static muro + #991, #' '
static muro + #992, #' '
static muro + #993, #' '
static muro + #994, #' '
static muro + #995, #' '
static muro + #996, #' '
static muro + #997, #' '
static muro + #998, #' '
static muro + #999, #'#'
static muro + #1000, #'#'
static muro + #1001, #' '
static muro + #1002, #' '
static muro + #1003, #' '
static muro + #1004, #' '
static muro + #1005, #' '
static muro + #1006, #' '
static muro + #1007, #' '
static muro + #1008, #' '
static muro + #1009, #' '
static muro + #1010, #' '
static muro + #1011, #' '
static muro + #1012, #' '
static muro + #1013, #' '
static muro + #1014, #' '
static muro + #1015, #' '
static muro + #1016, #' '
static muro + #1017, #' '
static muro + #1018, #' '
static muro + #1019, #' '
static muro + #1020, #' '
static muro + #1021, #' '
static muro + #1022, #' '
static muro + #1023, #' '
static muro + #1024, #' '
static muro + #1025, #' '
static muro + #1026, #' '
static muro + #1027, #' '
static muro + #1028, #' '
static muro + #1029, #' '
static muro + #1030, #' '
static muro + #1031, #' '
static muro + #1032, #' '
static muro + #1033, #' '
static muro + #1034, #' '
static muro + #1035, #' '
static muro + #1036, #' '
static muro + #1037, #' '
static muro + #1038, #' '
static muro + #1039, #'#'
static muro + #1040, #'#'
static muro + #1041, #' '
static muro + #1042, #' '
static muro + #1043, #' '
static muro + #1044, #' '
static muro + #1045, #' '
static muro + #1046, #' '
static muro + #1047, #' '
static muro + #1048, #' '
static muro + #1049, #' '
static muro + #1050, #' '
static muro + #1051, #' '
static muro + #1052, #' '
static muro + #1053, #' '
static muro + #1054, #' '
static muro + #1055, #' '
static muro + #1056, #' '
static muro + #1057, #' '
static muro + #1058, #' '
static muro + #1059, #' '
static muro + #1060, #' '
static muro + #1061, #' '
static muro + #1062, #' '
static muro + #1063, #' '
static muro + #1064, #' '
static muro + #1065, #' '
static muro + #1066, #' '
static muro + #1067, #' '
static muro + #1068, #' '
static muro + #1069, #' '
static muro + #1070, #' '
static muro + #1071, #' '
static muro + #1072, #' '
static muro + #1073, #' '
static muro + #1074, #' '
static muro + #1075, #' '
static muro + #1076, #' '
static muro + #1077, #' '
static muro + #1078, #' '
static muro + #1079, #'#'
static muro + #1080, #'#'
static muro + #1081, #' '
static muro + #1082, #' '
static muro + #1083, #' '
static muro + #1084, #' '
static muro + #1085, #' '
static muro + #1086, #' '
static muro + #1087, #' '
static muro + #1088, #' '
static muro + #1089, #' '
static muro + #1090, #' '
static muro + #1091, #' '
static muro + #1092, #' '
static muro + #1093, #' '
static muro + #1094, #' '
static muro + #1095, #' '
static muro + #1096, #' '
static muro + #1097, #' '
static muro + #1098, #' '
static muro + #1099, #' '
static muro + #1100, #' '
static muro + #1101, #' '
static muro + #1102, #' '
static muro + #1103, #' '
static muro + #1104, #' '
static muro + #1105, #' '
static muro + #1106, #' '
static muro + #1107, #' '
static muro + #1108, #' '
static muro + #1109, #' '
static muro + #1110, #' '
static muro + #1111, #' '
static muro + #1112, #' '
static muro + #1113, #' '
static muro + #1114, #' '
static muro + #1115, #' '
static muro + #1116, #' '
static muro + #1117, #' '
static muro + #1118, #' '
static muro + #1119, #'#'
static muro + #1120, #'#'
static muro + #1121, #' '
static muro + #1122, #' '
static muro + #1123, #' '
static muro + #1124, #' '
static muro + #1125, #' '
static muro + #1126, #' '
static muro + #1127, #' '
static muro + #1128, #' '
static muro + #1129, #' '
static muro + #1130, #' '
static muro + #1131, #' '
static muro + #1132, #' '
static muro + #1133, #' '
static muro + #1134, #' '
static muro + #1135, #' '
static muro + #1136, #' '
static muro + #1137, #' '
static muro + #1138, #' '
static muro + #1139, #' '
static muro + #1140, #' '
static muro + #1141, #' '
static muro + #1142, #' '
static muro + #1143, #' '
static muro + #1144, #' '
static muro + #1145, #' '
static muro + #1146, #' '
static muro + #1147, #' '
static muro + #1148, #' '
static muro + #1149, #' '
static muro + #1150, #' '
static muro + #1151, #' '
static muro + #1152, #' '
static muro + #1153, #' '
static muro + #1154, #' '
static muro + #1155, #' '
static muro + #1156, #' '
static muro + #1157, #' '
static muro + #1158, #' '
static muro + #1159, #'#'
static muro + #1160, #'#'
static muro + #1161, #'#'
static muro + #1162, #'#'
static muro + #1163, #'#'
static muro + #1164, #'#'
static muro + #1165, #'#'
static muro + #1166, #'#'
static muro + #1167, #'#'
static muro + #1168, #'#'
static muro + #1169, #'#'
static muro + #1170, #'#'
static muro + #1171, #'#'
static muro + #1172, #'#'
static muro + #1173, #'#'
static muro + #1174, #'#'
static muro + #1175, #'#'
static muro + #1176, #'#'
static muro + #1177, #'#'
static muro + #1178, #'#'
static muro + #1179, #'#'
static muro + #1180, #'#'
static muro + #1181, #'#'
static muro + #1182, #'#'
static muro + #1183, #'#'
static muro + #1184, #'#'
static muro + #1185, #'#'
static muro + #1186, #'#'
static muro + #1187, #'#'
static muro + #1188, #'#'
static muro + #1189, #'#'
static muro + #1190, #'#'
static muro + #1191, #'#'
static muro + #1192, #'#'
static muro + #1193, #'#'
static muro + #1194, #'#'
static muro + #1195, #'#'
static muro + #1196, #'#'
static muro + #1197, #'#'
static muro + #1198, #'#'
static muro + #1199, #'#'

; Cenрrio de GameOver -----------------------------------------------

gameover : var #1200

static gameover + #0, #'#'
static gameover + #1, #' '
static gameover + #2, #' '
static gameover + #3, #' '
static gameover + #4, #' '
static gameover + #5, #' '
static gameover + #6, #' '
static gameover + #7, #' '
static gameover + #8, #' '
static gameover + #9, #' '
static gameover + #10, #' '
static gameover + #11, #' '
static gameover + #12, #' '
static gameover + #13, #' '
static gameover + #14, #' '
static gameover + #15, #' '
static gameover + #16, #' '
static gameover + #17, #' '
static gameover + #18, #' '
static gameover + #19, #' '
static gameover + #20, #' '
static gameover + #21, #' '
static gameover + #22, #' '
static gameover + #23, #' '
static gameover + #24, #' '
static gameover + #25, #' '
static gameover + #26, #' '
static gameover + #27, #' '
static gameover + #28, #' '
static gameover + #29, #' '
static gameover + #30, #' '
static gameover + #31, #' '
static gameover + #32, #' '
static gameover + #33, #' '
static gameover + #34, #' '
static gameover + #35, #' '
static gameover + #36, #' '
static gameover + #37, #' '
static gameover + #38, #' '
static gameover + #39, #'#'
static gameover + #40, #'#'
static gameover + #41, #' '
static gameover + #42, #'S'
static gameover + #43, #'n'
static gameover + #44, #'a'
static gameover + #45, #'k'
static gameover + #46, #'e'
static gameover + #47, #' '
static gameover + #48, #'2'
static gameover + #49, #'.'
static gameover + #50, #'0'
static gameover + #51, #' '
static gameover + #52, #' '
static gameover + #53, #' '
static gameover + #54, #' '
static gameover + #55, #' '
static gameover + #56, #' '
static gameover + #57, #' '
static gameover + #58, #' '
static gameover + #59, #' '
static gameover + #60, #' '
static gameover + #61, #' '
static gameover + #62, #' '
static gameover + #63, #' '
static gameover + #64, #' '
static gameover + #65, #' '
static gameover + #66, #' '
static gameover + #67, #' '
static gameover + #68, #' '
static gameover + #69, #' '
static gameover + #70, #' '
static gameover + #71, #' '
static gameover + #72, #' '
static gameover + #73, #' '
static gameover + #74, #' '
static gameover + #75, #' '
static gameover + #76, #' '
static gameover + #77, #' '
static gameover + #78, #' '
static gameover + #79, #'#'
static gameover + #80, #'#'
static gameover + #81, #'#'
static gameover + #82, #'#'
static gameover + #83, #'#'
static gameover + #84, #'#'
static gameover + #85, #'#'
static gameover + #86, #'#'
static gameover + #87, #'#'
static gameover + #88, #'#'
static gameover + #89, #'#'
static gameover + #90, #'#'
static gameover + #91, #'#'
static gameover + #92, #'#'
static gameover + #93, #'#'
static gameover + #94, #'#'
static gameover + #95, #'#'
static gameover + #96, #'#'
static gameover + #97, #'#'
static gameover + #98, #'#'
static gameover + #99, #'#'
static gameover + #100, #'#'
static gameover + #101, #'#'
static gameover + #102, #'#'
static gameover + #103, #'#'
static gameover + #104, #'#'
static gameover + #105, #'#'
static gameover + #106, #'#'
static gameover + #107, #'#'
static gameover + #108, #'#'
static gameover + #109, #'#'
static gameover + #110, #'#'
static gameover + #111, #'#'
static gameover + #112, #'#'
static gameover + #113, #'#'
static gameover + #114, #'#'
static gameover + #115, #'#'
static gameover + #116, #'#'
static gameover + #117, #'#'
static gameover + #118, #'#'
static gameover + #119, #'#'
static gameover + #120, #'#'
static gameover + #121, #' '
static gameover + #122, #' '
static gameover + #123, #' '
static gameover + #124, #' '
static gameover + #125, #' '
static gameover + #126, #' '
static gameover + #127, #' '
static gameover + #128, #' '
static gameover + #129, #' '
static gameover + #130, #' '
static gameover + #131, #' '
static gameover + #132, #' '
static gameover + #133, #' '
static gameover + #134, #' '
static gameover + #135, #' '
static gameover + #136, #' '
static gameover + #137, #' '
static gameover + #138, #' '
static gameover + #139, #' '
static gameover + #140, #' '
static gameover + #141, #' '
static gameover + #142, #' '
static gameover + #143, #' '
static gameover + #144, #' '
static gameover + #145, #' '
static gameover + #146, #' '
static gameover + #147, #' '
static gameover + #148, #' '
static gameover + #149, #' '
static gameover + #150, #' '
static gameover + #151, #' '
static gameover + #152, #' '
static gameover + #153, #' '
static gameover + #154, #' '
static gameover + #155, #' '
static gameover + #156, #' '
static gameover + #157, #' '
static gameover + #158, #' '
static gameover + #159, #'#'
static gameover + #160, #'#'
static gameover + #161, #' '
static gameover + #162, #' '
static gameover + #163, #' '
static gameover + #164, #' '
static gameover + #165, #' '
static gameover + #166, #' '
static gameover + #167, #' '
static gameover + #168, #' '
static gameover + #169, #' '
static gameover + #170, #' '
static gameover + #171, #' '
static gameover + #172, #' '
static gameover + #173, #' '
static gameover + #174, #' '
static gameover + #175, #' '
static gameover + #176, #' '
static gameover + #177, #' '
static gameover + #178, #' '
static gameover + #179, #' '
static gameover + #180, #' '
static gameover + #181, #' '
static gameover + #182, #' '
static gameover + #183, #' '
static gameover + #184, #' '
static gameover + #185, #' '
static gameover + #186, #' '
static gameover + #187, #' '
static gameover + #188, #' '
static gameover + #189, #' '
static gameover + #190, #' '
static gameover + #191, #' '
static gameover + #192, #' '
static gameover + #193, #' '
static gameover + #194, #' '
static gameover + #195, #' '
static gameover + #196, #' '
static gameover + #197, #' '
static gameover + #198, #' '
static gameover + #199, #'#'
static gameover + #200, #'#'
static gameover + #201, #' '
static gameover + #202, #' '
static gameover + #203, #' '
static gameover + #204, #' '
static gameover + #205, #' '
static gameover + #206, #' '
static gameover + #207, #' '
static gameover + #208, #' '
static gameover + #209, #' '
static gameover + #210, #' '
static gameover + #211, #' '
static gameover + #212, #' '
static gameover + #213, #' '
static gameover + #214, #' '
static gameover + #215, #' '
static gameover + #216, #' '
static gameover + #217, #' '
static gameover + #218, #' '
static gameover + #219, #' '
static gameover + #220, #' '
static gameover + #221, #' '
static gameover + #222, #' '
static gameover + #223, #' '
static gameover + #224, #' '
static gameover + #225, #' '
static gameover + #226, #' '
static gameover + #227, #' '
static gameover + #228, #' '
static gameover + #229, #' '
static gameover + #230, #' '
static gameover + #231, #' '
static gameover + #232, #' '
static gameover + #233, #' '
static gameover + #234, #' '
static gameover + #235, #' '
static gameover + #236, #' '
static gameover + #237, #' '
static gameover + #238, #' '
static gameover + #239, #'#'
static gameover + #240, #'#'
static gameover + #241, #' '
static gameover + #242, #' '
static gameover + #243, #' '
static gameover + #244, #' '
static gameover + #245, #' '
static gameover + #246, #' '
static gameover + #247, #' '
static gameover + #248, #' '
static gameover + #249, #' '
static gameover + #250, #' '
static gameover + #251, #' '
static gameover + #252, #' '
static gameover + #253, #' '
static gameover + #254, #' '
static gameover + #255, #' '
static gameover + #256, #' '
static gameover + #257, #' '
static gameover + #258, #' '
static gameover + #259, #' '
static gameover + #260, #' '
static gameover + #261, #' '
static gameover + #262, #' '
static gameover + #263, #' '
static gameover + #264, #' '
static gameover + #265, #' '
static gameover + #266, #' '
static gameover + #267, #' '
static gameover + #268, #' '
static gameover + #269, #' '
static gameover + #270, #' '
static gameover + #271, #' '
static gameover + #272, #' '
static gameover + #273, #' '
static gameover + #274, #' '
static gameover + #275, #' '
static gameover + #276, #' '
static gameover + #277, #' '
static gameover + #278, #' '
static gameover + #279, #'#'
static gameover + #280, #'#'
static gameover + #281, #' '
static gameover + #282, #' '
static gameover + #283, #' '
static gameover + #284, #' '
static gameover + #285, #' '
static gameover + #286, #' '
static gameover + #287, #' '
static gameover + #288, #' '
static gameover + #289, #' '
static gameover + #290, #' '
static gameover + #291, #' '
static gameover + #292, #' '
static gameover + #293, #' '
static gameover + #294, #' '
static gameover + #295, #' '
static gameover + #296, #' '
static gameover + #297, #' '
static gameover + #298, #' '
static gameover + #299, #' '
static gameover + #300, #' '
static gameover + #301, #' '
static gameover + #302, #' '
static gameover + #303, #' '
static gameover + #304, #' '
static gameover + #305, #' '
static gameover + #306, #' '
static gameover + #307, #' '
static gameover + #308, #' '
static gameover + #309, #' '
static gameover + #310, #' '
static gameover + #311, #' '
static gameover + #312, #' '
static gameover + #313, #' '
static gameover + #314, #' '
static gameover + #315, #' '
static gameover + #316, #' '
static gameover + #317, #' '
static gameover + #318, #' '
static gameover + #319, #'#'
static gameover + #320, #'#'
static gameover + #321, #' '
static gameover + #322, #' '
static gameover + #323, #' '
static gameover + #324, #' '
static gameover + #325, #' '
static gameover + #326, #' '
static gameover + #327, #' '
static gameover + #328, #' '
static gameover + #329, #' '
static gameover + #330, #' '
static gameover + #331, #' '
static gameover + #332, #' '
static gameover + #333, #' '
static gameover + #334, #' '
static gameover + #335, #' '
static gameover + #336, #' '
static gameover + #337, #' '
static gameover + #338, #' '
static gameover + #339, #' '
static gameover + #340, #' '
static gameover + #341, #' '
static gameover + #342, #' '
static gameover + #343, #' '
static gameover + #344, #' '
static gameover + #345, #' '
static gameover + #346, #' '
static gameover + #347, #' '
static gameover + #348, #' '
static gameover + #349, #' '
static gameover + #350, #' '
static gameover + #351, #' '
static gameover + #352, #' '
static gameover + #353, #' '
static gameover + #354, #' '
static gameover + #355, #' '
static gameover + #356, #' '
static gameover + #357, #' '
static gameover + #358, #' '
static gameover + #359, #'#'
static gameover + #360, #'#'
static gameover + #361, #' '
static gameover + #362, #' '
static gameover + #363, #' '
static gameover + #364, #' '
static gameover + #365, #' '
static gameover + #366, #' '
static gameover + #367, #' '
static gameover + #368, #' '
static gameover + #369, #' '
static gameover + #370, #' '
static gameover + #371, #' '
static gameover + #372, #' '
static gameover + #373, #' '
static gameover + #374, #' '
static gameover + #375, #' '
static gameover + #376, #' '
static gameover + #377, #' '
static gameover + #378, #' '
static gameover + #379, #' '
static gameover + #380, #' '
static gameover + #381, #' '
static gameover + #382, #' '
static gameover + #383, #' '
static gameover + #384, #' '
static gameover + #385, #' '
static gameover + #386, #' '
static gameover + #387, #' '
static gameover + #388, #' '
static gameover + #389, #' '
static gameover + #390, #' '
static gameover + #391, #' '
static gameover + #392, #' '
static gameover + #393, #' '
static gameover + #394, #' '
static gameover + #395, #' '
static gameover + #396, #' '
static gameover + #397, #' '
static gameover + #398, #' '
static gameover + #399, #'#'
static gameover + #400, #'#'
static gameover + #401, #' '
static gameover + #402, #' '
static gameover + #403, #' '
static gameover + #404, #' '
static gameover + #405, #' '
static gameover + #406, #' '
static gameover + #407, #' '
static gameover + #408, #' '
static gameover + #409, #' '
static gameover + #410, #' '
static gameover + #411, #' '
static gameover + #412, #' '
static gameover + #413, #' '
static gameover + #414, #' '
static gameover + #415, #' '
static gameover + #416, #' '
static gameover + #417, #' '
static gameover + #418, #' '
static gameover + #419, #' '
static gameover + #420, #' '
static gameover + #421, #' '
static gameover + #422, #' '
static gameover + #423, #' '
static gameover + #424, #' '
static gameover + #425, #' '
static gameover + #426, #' '
static gameover + #427, #' '
static gameover + #428, #' '
static gameover + #429, #' '
static gameover + #430, #' '
static gameover + #431, #' '
static gameover + #432, #' '
static gameover + #433, #' '
static gameover + #434, #' '
static gameover + #435, #' '
static gameover + #436, #' '
static gameover + #437, #' '
static gameover + #438, #' '
static gameover + #439, #'#'
static gameover + #440, #'#'
static gameover + #441, #' '
static gameover + #442, #' '
static gameover + #443, #' '
static gameover + #444, #' '
static gameover + #445, #' '
static gameover + #446, #' '
static gameover + #447, #' '
static gameover + #448, #' '
static gameover + #449, #' '
static gameover + #450, #' '
static gameover + #451, #' '
static gameover + #452, #' '
static gameover + #453, #' '
static gameover + #454, #' '
static gameover + #455, #' '
static gameover + #456, #' '
static gameover + #457, #' '
static gameover + #458, #' '
static gameover + #459, #' '
static gameover + #460, #' '
static gameover + #461, #' '
static gameover + #462, #' '
static gameover + #463, #' '
static gameover + #464, #' '
static gameover + #465, #' '
static gameover + #466, #' '
static gameover + #467, #' '
static gameover + #468, #' '
static gameover + #469, #' '
static gameover + #470, #' '
static gameover + #471, #' '
static gameover + #472, #' '
static gameover + #473, #' '
static gameover + #474, #' '
static gameover + #475, #' '
static gameover + #476, #' '
static gameover + #477, #' '
static gameover + #478, #' '
static gameover + #479, #'#'
static gameover + #480, #'#'
static gameover + #481, #' '
static gameover + #482, #' '
static gameover + #483, #' '
static gameover + #484, #' '
static gameover + #485, #' '
static gameover + #486, #' '
static gameover + #487, #' '
static gameover + #488, #' '
static gameover + #489, #' '
static gameover + #490, #' '
static gameover + #491, #' '
static gameover + #492, #' '
static gameover + #493, #' '
static gameover + #494, #' '
static gameover + #495, #' '
static gameover + #496, #' '
static gameover + #497, #' '
static gameover + #498, #' '
static gameover + #499, #' '
static gameover + #500, #' '
static gameover + #501, #' '
static gameover + #502, #' '
static gameover + #503, #' '
static gameover + #504, #' '
static gameover + #505, #' '
static gameover + #506, #' '
static gameover + #507, #' '
static gameover + #508, #' '
static gameover + #509, #' '
static gameover + #510, #' '
static gameover + #511, #' '
static gameover + #512, #' '
static gameover + #513, #' '
static gameover + #514, #' '
static gameover + #515, #' '
static gameover + #516, #' '
static gameover + #517, #' '
static gameover + #518, #' '
static gameover + #519, #'#'
static gameover + #520, #'#'
static gameover + #521, #' '
static gameover + #522, #' '
static gameover + #523, #' '
static gameover + #524, #' '
static gameover + #525, #' '
static gameover + #526, #' '
static gameover + #527, #' '
static gameover + #528, #' '
static gameover + #529, #' '
static gameover + #530, #' '
static gameover + #531, #' '
static gameover + #532, #' '
static gameover + #533, #' '
static gameover + #534, #' '
static gameover + #535, #' '
static gameover + #536, #' '
static gameover + #537, #' '
static gameover + #538, #' '
static gameover + #539, #' '
static gameover + #540, #' '
static gameover + #541, #' '
static gameover + #542, #' '
static gameover + #543, #' '
static gameover + #544, #' '
static gameover + #545, #' '
static gameover + #546, #' '
static gameover + #547, #' '
static gameover + #548, #' '
static gameover + #549, #' '
static gameover + #550, #' '
static gameover + #551, #' '
static gameover + #552, #' '
static gameover + #553, #' '
static gameover + #554, #' '
static gameover + #555, #' '
static gameover + #556, #' '
static gameover + #557, #' '
static gameover + #558, #' '
static gameover + #559, #'#'
static gameover + #560, #'#'
static gameover + #561, #' '
static gameover + #562, #' '
static gameover + #563, #' '
static gameover + #564, #' '
static gameover + #565, #' '
static gameover + #566, #' '
static gameover + #567, #' '
static gameover + #568, #' '
static gameover + #569, #' '
static gameover + #570, #' '
static gameover + #571, #' '
static gameover + #572, #' '
static gameover + #573, #' '
static gameover + #574, #' '
static gameover + #575, #' '
static gameover + #576, #'G'
static gameover + #577, #'A'
static gameover + #578, #'M'
static gameover + #579, #'E'
static gameover + #580, #' '
static gameover + #581, #'O'
static gameover + #582, #'V'
static gameover + #583, #'E'
static gameover + #584, #'R'
static gameover + #585, #' '
static gameover + #586, #' '
static gameover + #587, #' '
static gameover + #588, #' '
static gameover + #589, #' '
static gameover + #590, #' '
static gameover + #591, #' '
static gameover + #592, #' '
static gameover + #593, #' '
static gameover + #594, #' '
static gameover + #595, #' '
static gameover + #596, #' '
static gameover + #597, #' '
static gameover + #598, #' '
static gameover + #599, #'#'
static gameover + #600, #'#'
static gameover + #601, #' '
static gameover + #602, #' '
static gameover + #603, #' '
static gameover + #604, #' '
static gameover + #605, #' '
static gameover + #606, #' '
static gameover + #607, #' '
static gameover + #608, #' '
static gameover + #609, #' '
static gameover + #610, #' '
static gameover + #611, #' '
static gameover + #612, #' '
static gameover + #613, #' '
static gameover + #614, #' '
static gameover + #615, #' '
static gameover + #616, #' '
static gameover + #617, #' '
static gameover + #618, #' '
static gameover + #619, #' '
static gameover + #620, #' '
static gameover + #621, #' '
static gameover + #622, #' '
static gameover + #623, #' '
static gameover + #624, #' '
static gameover + #625, #' '
static gameover + #626, #' '
static gameover + #627, #' '
static gameover + #628, #' '
static gameover + #629, #' '
static gameover + #630, #' '
static gameover + #631, #' '
static gameover + #632, #' '
static gameover + #633, #' '
static gameover + #634, #' '
static gameover + #635, #' '
static gameover + #636, #' '
static gameover + #637, #' '
static gameover + #638, #' '
static gameover + #639, #'#'
static gameover + #640, #'#'
static gameover + #641, #' '
static gameover + #642, #' '
static gameover + #643, #' '
static gameover + #644, #' '
static gameover + #645, #' '
static gameover + #646, #' '
static gameover + #647, #' '
static gameover + #648, #' '
static gameover + #649, #' '
static gameover + #650, #' '
static gameover + #651, #' '
static gameover + #652, #' '
static gameover + #653, #' '
static gameover + #654, #' '
static gameover + #655, #'P'
static gameover + #656, #'R'
static gameover + #657, #'E'
static gameover + #658, #'S'
static gameover + #659, #'S'
static gameover + #660, #' '
static gameover + #661, #'E'
static gameover + #662, #'N'
static gameover + #663, #'T'
static gameover + #664, #'E'
static gameover + #665, #'R'
static gameover + #666, #' '
static gameover + #667, #' '
static gameover + #668, #' '
static gameover + #669, #' '
static gameover + #670, #' '
static gameover + #671, #' '
static gameover + #672, #' '
static gameover + #673, #' '
static gameover + #674, #' '
static gameover + #675, #' '
static gameover + #676, #' '
static gameover + #677, #' '
static gameover + #678, #' '
static gameover + #679, #'#'
static gameover + #680, #'#'
static gameover + #681, #' '
static gameover + #682, #' '
static gameover + #683, #' '
static gameover + #684, #' '
static gameover + #685, #' '
static gameover + #686, #' '
static gameover + #687, #' '
static gameover + #688, #' '
static gameover + #689, #' '
static gameover + #690, #' '
static gameover + #691, #' '
static gameover + #692, #' '
static gameover + #693, #' '
static gameover + #694, #' '
static gameover + #695, #' '
static gameover + #696, #'T'
static gameover + #697, #'O'
static gameover + #698, #' '
static gameover + #699, #'R'
static gameover + #700, #'E'
static gameover + #701, #'T'
static gameover + #702, #'R'
static gameover + #703, #'Y'
static gameover + #704, #' '
static gameover + #705, #' '
static gameover + #706, #' '
static gameover + #707, #' '
static gameover + #708, #' '
static gameover + #709, #' '
static gameover + #710, #' '
static gameover + #711, #' '
static gameover + #712, #' '
static gameover + #713, #' '
static gameover + #714, #' '
static gameover + #715, #' '
static gameover + #716, #' '
static gameover + #717, #' '
static gameover + #718, #' '
static gameover + #719, #'#'
static gameover + #720, #'#'
static gameover + #721, #' '
static gameover + #722, #' '
static gameover + #723, #' '
static gameover + #724, #' '
static gameover + #725, #' '
static gameover + #726, #' '
static gameover + #727, #' '
static gameover + #728, #' '
static gameover + #729, #' '
static gameover + #730, #' '
static gameover + #731, #' '
static gameover + #732, #' '
static gameover + #733, #' '
static gameover + #734, #' '
static gameover + #735, #' '
static gameover + #736, #' '
static gameover + #737, #' '
static gameover + #738, #' '
static gameover + #739, #' '
static gameover + #740, #' '
static gameover + #741, #' '
static gameover + #742, #' '
static gameover + #743, #' '
static gameover + #744, #' '
static gameover + #745, #' '
static gameover + #746, #' '
static gameover + #747, #' '
static gameover + #748, #' '
static gameover + #749, #' '
static gameover + #750, #' '
static gameover + #751, #' '
static gameover + #752, #' '
static gameover + #753, #' '
static gameover + #754, #' '
static gameover + #755, #' '
static gameover + #756, #' '
static gameover + #757, #' '
static gameover + #758, #' '
static gameover + #759, #'#'
static gameover + #760, #'#'
static gameover + #761, #' '
static gameover + #762, #' '
static gameover + #763, #' '
static gameover + #764, #' '
static gameover + #765, #' '
static gameover + #766, #' '
static gameover + #767, #' '
static gameover + #768, #' '
static gameover + #769, #' '
static gameover + #770, #' '
static gameover + #771, #' '
static gameover + #772, #' '
static gameover + #773, #' '
static gameover + #774, #' '
static gameover + #775, #' '
static gameover + #776, #' '
static gameover + #777, #' '
static gameover + #778, #' '
static gameover + #779, #' '
static gameover + #780, #' '
static gameover + #781, #' '
static gameover + #782, #' '
static gameover + #783, #' '
static gameover + #784, #' '
static gameover + #785, #' '
static gameover + #786, #' '
static gameover + #787, #' '
static gameover + #788, #' '
static gameover + #789, #' '
static gameover + #790, #' '
static gameover + #791, #' '
static gameover + #792, #' '
static gameover + #793, #' '
static gameover + #794, #' '
static gameover + #795, #' '
static gameover + #796, #' '
static gameover + #797, #' '
static gameover + #798, #' '
static gameover + #799, #'#'
static gameover + #800, #'#'
static gameover + #801, #' '
static gameover + #802, #' '
static gameover + #803, #' '
static gameover + #804, #' '
static gameover + #805, #' '
static gameover + #806, #' '
static gameover + #807, #' '
static gameover + #808, #' '
static gameover + #809, #' '
static gameover + #810, #' '
static gameover + #811, #' '
static gameover + #812, #' '
static gameover + #813, #' '
static gameover + #814, #' '
static gameover + #815, #' '
static gameover + #816, #' '
static gameover + #817, #' '
static gameover + #818, #' '
static gameover + #819, #' '
static gameover + #820, #' '
static gameover + #821, #' '
static gameover + #822, #' '
static gameover + #823, #' '
static gameover + #824, #' '
static gameover + #825, #' '
static gameover + #826, #' '
static gameover + #827, #' '
static gameover + #828, #' '
static gameover + #829, #' '
static gameover + #830, #' '
static gameover + #831, #' '
static gameover + #832, #' '
static gameover + #833, #' '
static gameover + #834, #' '
static gameover + #835, #' '
static gameover + #836, #' '
static gameover + #837, #' '
static gameover + #838, #' '
static gameover + #839, #'#'
static gameover + #840, #'#'
static gameover + #841, #' '
static gameover + #842, #' '
static gameover + #843, #' '
static gameover + #844, #' '
static gameover + #845, #' '
static gameover + #846, #' '
static gameover + #847, #' '
static gameover + #848, #' '
static gameover + #849, #' '
static gameover + #850, #' '
static gameover + #851, #' '
static gameover + #852, #' '
static gameover + #853, #' '
static gameover + #854, #' '
static gameover + #855, #' '
static gameover + #856, #' '
static gameover + #857, #' '
static gameover + #858, #' '
static gameover + #859, #' '
static gameover + #860, #' '
static gameover + #861, #' '
static gameover + #862, #' '
static gameover + #863, #' '
static gameover + #864, #' '
static gameover + #865, #' '
static gameover + #866, #' '
static gameover + #867, #' '
static gameover + #868, #' '
static gameover + #869, #' '
static gameover + #870, #' '
static gameover + #871, #' '
static gameover + #872, #' '
static gameover + #873, #' '
static gameover + #874, #' '
static gameover + #875, #' '
static gameover + #876, #' '
static gameover + #877, #' '
static gameover + #878, #' '
static gameover + #879, #'#'
static gameover + #880, #'#'
static gameover + #881, #' '
static gameover + #882, #' '
static gameover + #883, #' '
static gameover + #884, #' '
static gameover + #885, #' '
static gameover + #886, #' '
static gameover + #887, #' '
static gameover + #888, #' '
static gameover + #889, #' '
static gameover + #890, #' '
static gameover + #891, #' '
static gameover + #892, #' '
static gameover + #893, #' '
static gameover + #894, #' '
static gameover + #895, #' '
static gameover + #896, #' '
static gameover + #897, #' '
static gameover + #898, #' '
static gameover + #899, #' '
static gameover + #900, #' '
static gameover + #901, #' '
static gameover + #902, #' '
static gameover + #903, #' '
static gameover + #904, #' '
static gameover + #905, #' '
static gameover + #906, #' '
static gameover + #907, #' '
static gameover + #908, #' '
static gameover + #909, #' '
static gameover + #910, #' '
static gameover + #911, #' '
static gameover + #912, #' '
static gameover + #913, #' '
static gameover + #914, #' '
static gameover + #915, #' '
static gameover + #916, #' '
static gameover + #917, #' '
static gameover + #918, #' '
static gameover + #919, #'#'
static gameover + #920, #'#'
static gameover + #921, #' '
static gameover + #922, #' '
static gameover + #923, #' '
static gameover + #924, #' '
static gameover + #925, #' '
static gameover + #926, #' '
static gameover + #927, #' '
static gameover + #928, #' '
static gameover + #929, #' '
static gameover + #930, #' '
static gameover + #931, #' '
static gameover + #932, #' '
static gameover + #933, #' '
static gameover + #934, #' '
static gameover + #935, #' '
static gameover + #936, #' '
static gameover + #937, #' '
static gameover + #938, #' '
static gameover + #939, #' '
static gameover + #940, #' '
static gameover + #941, #' '
static gameover + #942, #' '
static gameover + #943, #' '
static gameover + #944, #' '
static gameover + #945, #' '
static gameover + #946, #' '
static gameover + #947, #' '
static gameover + #948, #' '
static gameover + #949, #' '
static gameover + #950, #' '
static gameover + #951, #' '
static gameover + #952, #' '
static gameover + #953, #' '
static gameover + #954, #' '
static gameover + #955, #' '
static gameover + #956, #' '
static gameover + #957, #' '
static gameover + #958, #' '
static gameover + #959, #'#'
static gameover + #960, #'#'
static gameover + #961, #' '
static gameover + #962, #' '
static gameover + #963, #' '
static gameover + #964, #' '
static gameover + #965, #' '
static gameover + #966, #' '
static gameover + #967, #' '
static gameover + #968, #' '
static gameover + #969, #' '
static gameover + #970, #' '
static gameover + #971, #' '
static gameover + #972, #' '
static gameover + #973, #' '
static gameover + #974, #' '
static gameover + #975, #' '
static gameover + #976, #' '
static gameover + #977, #' '
static gameover + #978, #' '
static gameover + #979, #' '
static gameover + #980, #' '
static gameover + #981, #' '
static gameover + #982, #' '
static gameover + #983, #' '
static gameover + #984, #' '
static gameover + #985, #' '
static gameover + #986, #' '
static gameover + #987, #' '
static gameover + #988, #' '
static gameover + #989, #' '
static gameover + #990, #' '
static gameover + #991, #' '
static gameover + #992, #' '
static gameover + #993, #' '
static gameover + #994, #' '
static gameover + #995, #' '
static gameover + #996, #' '
static gameover + #997, #' '
static gameover + #998, #' '
static gameover + #999, #'#'
static gameover + #1000, #'#'
static gameover + #1001, #' '
static gameover + #1002, #' '
static gameover + #1003, #' '
static gameover + #1004, #' '
static gameover + #1005, #' '
static gameover + #1006, #' '
static gameover + #1007, #' '
static gameover + #1008, #' '
static gameover + #1009, #' '
static gameover + #1010, #' '
static gameover + #1011, #' '
static gameover + #1012, #' '
static gameover + #1013, #' '
static gameover + #1014, #' '
static gameover + #1015, #' '
static gameover + #1016, #' '
static gameover + #1017, #' '
static gameover + #1018, #' '
static gameover + #1019, #' '
static gameover + #1020, #' '
static gameover + #1021, #' '
static gameover + #1022, #' '
static gameover + #1023, #' '
static gameover + #1024, #' '
static gameover + #1025, #' '
static gameover + #1026, #' '
static gameover + #1027, #' '
static gameover + #1028, #' '
static gameover + #1029, #' '
static gameover + #1030, #' '
static gameover + #1031, #' '
static gameover + #1032, #' '
static gameover + #1033, #' '
static gameover + #1034, #' '
static gameover + #1035, #' '
static gameover + #1036, #' '
static gameover + #1037, #' '
static gameover + #1038, #' '
static gameover + #1039, #'#'
static gameover + #1040, #'#'
static gameover + #1041, #' '
static gameover + #1042, #' '
static gameover + #1043, #' '
static gameover + #1044, #' '
static gameover + #1045, #' '
static gameover + #1046, #' '
static gameover + #1047, #' '
static gameover + #1048, #' '
static gameover + #1049, #' '
static gameover + #1050, #' '
static gameover + #1051, #' '
static gameover + #1052, #' '
static gameover + #1053, #' '
static gameover + #1054, #' '
static gameover + #1055, #' '
static gameover + #1056, #' '
static gameover + #1057, #' '
static gameover + #1058, #' '
static gameover + #1059, #' '
static gameover + #1060, #' '
static gameover + #1061, #' '
static gameover + #1062, #' '
static gameover + #1063, #' '
static gameover + #1064, #' '
static gameover + #1065, #' '
static gameover + #1066, #' '
static gameover + #1067, #' '
static gameover + #1068, #' '
static gameover + #1069, #' '
static gameover + #1070, #' '
static gameover + #1071, #' '
static gameover + #1072, #' '
static gameover + #1073, #' '
static gameover + #1074, #' '
static gameover + #1075, #' '
static gameover + #1076, #' '
static gameover + #1077, #' '
static gameover + #1078, #' '
static gameover + #1079, #'#'
static gameover + #1080, #'#'
static gameover + #1081, #' '
static gameover + #1082, #' '
static gameover + #1083, #' '
static gameover + #1084, #' '
static gameover + #1085, #' '
static gameover + #1086, #' '
static gameover + #1087, #' '
static gameover + #1088, #' '
static gameover + #1089, #' '
static gameover + #1090, #' '
static gameover + #1091, #' '
static gameover + #1092, #' '
static gameover + #1093, #' '
static gameover + #1094, #' '
static gameover + #1095, #' '
static gameover + #1096, #' '
static gameover + #1097, #' '
static gameover + #1098, #' '
static gameover + #1099, #' '
static gameover + #1100, #' '
static gameover + #1101, #' '
static gameover + #1102, #' '
static gameover + #1103, #' '
static gameover + #1104, #' '
static gameover + #1105, #' '
static gameover + #1106, #' '
static gameover + #1107, #' '
static gameover + #1108, #' '
static gameover + #1109, #' '
static gameover + #1110, #' '
static gameover + #1111, #' '
static gameover + #1112, #' '
static gameover + #1113, #' '
static gameover + #1114, #' '
static gameover + #1115, #' '
static gameover + #1116, #' '
static gameover + #1117, #' '
static gameover + #1118, #' '
static gameover + #1119, #'#'
static gameover + #1120, #'#'
static gameover + #1121, #' '
static gameover + #1122, #' '
static gameover + #1123, #' '
static gameover + #1124, #' '
static gameover + #1125, #' '
static gameover + #1126, #' '
static gameover + #1127, #' '
static gameover + #1128, #' '
static gameover + #1129, #' '
static gameover + #1130, #' '
static gameover + #1131, #' '
static gameover + #1132, #' '
static gameover + #1133, #' '
static gameover + #1134, #' '
static gameover + #1135, #' '
static gameover + #1136, #' '
static gameover + #1137, #' '
static gameover + #1138, #' '
static gameover + #1139, #' '
static gameover + #1140, #' '
static gameover + #1141, #' '
static gameover + #1142, #' '
static gameover + #1143, #' '
static gameover + #1144, #' '
static gameover + #1145, #' '
static gameover + #1146, #' '
static gameover + #1147, #' '
static gameover + #1148, #' '
static gameover + #1149, #' '
static gameover + #1150, #' '
static gameover + #1151, #' '
static gameover + #1152, #' '
static gameover + #1153, #' '
static gameover + #1154, #' '
static gameover + #1155, #' '
static gameover + #1156, #' '
static gameover + #1157, #' '
static gameover + #1158, #' '
static gameover + #1159, #'#'
static gameover + #1160, #'#'
static gameover + #1161, #'#'
static gameover + #1162, #'#'
static gameover + #1163, #'#'
static gameover + #1164, #'#'
static gameover + #1165, #'#'
static gameover + #1166, #'#'
static gameover + #1167, #'#'
static gameover + #1168, #'#'
static gameover + #1169, #'#'
static gameover + #1170, #'#'
static gameover + #1171, #'#'
static gameover + #1172, #'#'
static gameover + #1173, #'#'
static gameover + #1174, #'#'
static gameover + #1175, #'#'
static gameover + #1176, #'#'
static gameover + #1177, #'#'
static gameover + #1178, #'#'
static gameover + #1179, #'#'
static gameover + #1180, #'#'
static gameover + #1181, #'#'
static gameover + #1182, #'#'
static gameover + #1183, #'#'
static gameover + #1184, #'#'
static gameover + #1185, #'#'
static gameover + #1186, #'#'
static gameover + #1187, #'#'
static gameover + #1188, #'#'
static gameover + #1189, #'#'
static gameover + #1190, #'#'
static gameover + #1191, #'#'
static gameover + #1192, #'#'
static gameover + #1193, #'#'
static gameover + #1194, #'#'
static gameover + #1195, #'#'
static gameover + #1196, #'#'
static gameover + #1197, #'#'
static gameover + #1198, #'#'
static gameover + #1199, #'#'

comida : var #1038
static comida + #0, #121
static comida + #1, #122
static comida + #2, #123
static comida + #3, #124
static comida + #4, #125
static comida + #5, #126
static comida + #6, #127
static comida + #7, #128
static comida + #8, #129
static comida + #9, #130
static comida + #10, #131
static comida + #11, #132
static comida + #12, #133
static comida + #13, #134
static comida + #14, #135
static comida + #15, #136
static comida + #16, #137
static comida + #17, #138
static comida + #18, #139
static comida + #19, #140
static comida + #20, #141
static comida + #21, #142
static comida + #22, #143
static comida + #23, #144
static comida + #24, #145
static comida + #25, #146
static comida + #26, #147
static comida + #27, #148
static comida + #28, #149
static comida + #29, #150
static comida + #30, #151
static comida + #31, #152
static comida + #32, #153
static comida + #33, #154
static comida + #34, #155
static comida + #35, #156
static comida + #36, #157
static comida + #37, #158
static comida + #40, #161
static comida + #41, #162
static comida + #42, #163
static comida + #43, #164
static comida + #44, #165
static comida + #45, #166
static comida + #46, #167
static comida + #47, #168
static comida + #48, #169
static comida + #49, #170
static comida + #50, #171
static comida + #51, #172
static comida + #52, #173
static comida + #53, #174
static comida + #54, #175
static comida + #55, #176
static comida + #56, #177
static comida + #57, #178
static comida + #58, #179
static comida + #59, #180
static comida + #60, #181
static comida + #61, #182
static comida + #62, #183
static comida + #63, #184
static comida + #64, #185
static comida + #65, #186
static comida + #66, #187
static comida + #67, #188
static comida + #68, #189
static comida + #69, #190
static comida + #70, #191
static comida + #71, #192
static comida + #72, #193
static comida + #73, #194
static comida + #74, #195
static comida + #75, #196
static comida + #76, #197
static comida + #77, #198
static comida + #80, #201
static comida + #81, #202
static comida + #82, #203
static comida + #83, #204
static comida + #84, #205
static comida + #85, #206
static comida + #86, #207
static comida + #87, #208
static comida + #88, #209
static comida + #89, #210
static comida + #90, #211
static comida + #91, #212
static comida + #92, #213
static comida + #93, #214
static comida + #94, #215
static comida + #95, #216
static comida + #96, #217
static comida + #97, #218
static comida + #98, #219
static comida + #99, #220
static comida + #100, #221
static comida + #101, #222
static comida + #102, #223
static comida + #103, #224
static comida + #104, #225
static comida + #105, #226
static comida + #106, #227
static comida + #107, #228
static comida + #108, #229
static comida + #109, #230
static comida + #110, #231
static comida + #111, #232
static comida + #112, #233
static comida + #113, #234
static comida + #114, #235
static comida + #115, #236
static comida + #116, #237
static comida + #117, #238
static comida + #120, #241
static comida + #121, #242
static comida + #122, #243
static comida + #123, #244
static comida + #124, #245
static comida + #125, #246
static comida + #126, #247
static comida + #127, #248
static comida + #128, #249
static comida + #129, #250
static comida + #130, #251
static comida + #131, #252
static comida + #132, #253
static comida + #133, #254
static comida + #134, #255
static comida + #135, #256
static comida + #136, #257
static comida + #137, #258
static comida + #138, #259
static comida + #139, #260
static comida + #140, #261
static comida + #141, #262
static comida + #142, #263
static comida + #143, #264
static comida + #144, #265
static comida + #145, #266
static comida + #146, #267
static comida + #147, #268
static comida + #148, #269
static comida + #149, #270
static comida + #150, #271
static comida + #151, #272
static comida + #152, #273
static comida + #153, #274
static comida + #154, #275
static comida + #155, #276
static comida + #156, #277
static comida + #157, #278
static comida + #160, #281
static comida + #161, #282
static comida + #162, #283
static comida + #163, #284
static comida + #164, #285
static comida + #165, #286
static comida + #166, #287
static comida + #167, #288
static comida + #168, #289
static comida + #169, #290
static comida + #170, #291
static comida + #171, #292
static comida + #172, #293
static comida + #173, #294
static comida + #174, #295
static comida + #175, #296
static comida + #176, #297
static comida + #177, #298
static comida + #178, #299
static comida + #179, #300
static comida + #180, #301
static comida + #181, #302
static comida + #182, #303
static comida + #183, #304
static comida + #184, #305
static comida + #185, #306
static comida + #186, #307
static comida + #187, #308
static comida + #188, #309
static comida + #189, #310
static comida + #190, #311
static comida + #191, #312
static comida + #192, #313
static comida + #193, #314
static comida + #194, #315
static comida + #195, #316
static comida + #196, #317
static comida + #197, #318
static comida + #200, #321
static comida + #201, #322
static comida + #202, #323
static comida + #203, #324
static comida + #204, #325
static comida + #205, #326
static comida + #206, #327
static comida + #207, #328
static comida + #208, #329
static comida + #209, #330
static comida + #210, #331
static comida + #211, #332
static comida + #212, #333
static comida + #213, #334
static comida + #214, #335
static comida + #215, #336
static comida + #216, #337
static comida + #217, #338
static comida + #218, #339
static comida + #219, #340
static comida + #220, #341
static comida + #221, #342
static comida + #222, #343
static comida + #223, #344
static comida + #224, #345
static comida + #225, #346
static comida + #226, #347
static comida + #227, #348
static comida + #228, #349
static comida + #229, #350
static comida + #230, #351
static comida + #231, #352
static comida + #232, #353
static comida + #233, #354
static comida + #234, #355
static comida + #235, #356
static comida + #236, #357
static comida + #237, #358
static comida + #240, #361
static comida + #241, #362
static comida + #242, #363
static comida + #243, #364
static comida + #244, #365
static comida + #245, #366
static comida + #246, #367
static comida + #247, #368
static comida + #248, #369
static comida + #249, #370
static comida + #250, #371
static comida + #251, #372
static comida + #252, #373
static comida + #253, #374
static comida + #254, #375
static comida + #255, #376
static comida + #256, #377
static comida + #257, #378
static comida + #258, #379
static comida + #259, #380
static comida + #260, #381
static comida + #261, #382
static comida + #262, #383
static comida + #263, #384
static comida + #264, #385
static comida + #265, #386
static comida + #266, #387
static comida + #267, #388
static comida + #268, #389
static comida + #269, #390
static comida + #270, #391
static comida + #271, #392
static comida + #272, #393
static comida + #273, #394
static comida + #274, #395
static comida + #275, #396
static comida + #276, #397
static comida + #277, #398
static comida + #280, #401
static comida + #281, #402
static comida + #282, #403
static comida + #283, #404
static comida + #284, #405
static comida + #285, #406
static comida + #286, #407
static comida + #287, #408
static comida + #288, #409
static comida + #289, #410
static comida + #290, #411
static comida + #291, #412
static comida + #292, #413
static comida + #293, #414
static comida + #294, #415
static comida + #295, #416
static comida + #296, #417
static comida + #297, #418
static comida + #298, #419
static comida + #299, #420
static comida + #300, #421
static comida + #301, #422
static comida + #302, #423
static comida + #303, #424
static comida + #304, #425
static comida + #305, #426
static comida + #306, #427
static comida + #307, #428
static comida + #308, #429
static comida + #309, #430
static comida + #310, #431
static comida + #311, #432
static comida + #312, #433
static comida + #313, #434
static comida + #314, #435
static comida + #315, #436
static comida + #316, #437
static comida + #317, #438
static comida + #320, #441
static comida + #321, #442
static comida + #322, #443
static comida + #323, #444
static comida + #324, #445
static comida + #325, #446
static comida + #326, #447
static comida + #327, #448
static comida + #328, #449
static comida + #329, #450
static comida + #330, #451
static comida + #331, #452
static comida + #332, #453
static comida + #333, #454
static comida + #334, #455
static comida + #335, #456
static comida + #336, #457
static comida + #337, #458
static comida + #338, #459
static comida + #339, #460
static comida + #340, #461
static comida + #341, #462
static comida + #342, #463
static comida + #343, #464
static comida + #344, #465
static comida + #345, #466
static comida + #346, #467
static comida + #347, #468
static comida + #348, #469
static comida + #349, #470
static comida + #350, #471
static comida + #351, #472
static comida + #352, #473
static comida + #353, #474
static comida + #354, #475
static comida + #355, #476
static comida + #356, #477
static comida + #357, #478
static comida + #360, #481
static comida + #361, #482
static comida + #362, #483
static comida + #363, #484
static comida + #364, #485
static comida + #365, #486
static comida + #366, #487
static comida + #367, #488
static comida + #368, #489
static comida + #369, #490
static comida + #370, #491
static comida + #371, #492
static comida + #372, #493
static comida + #373, #494
static comida + #374, #495
static comida + #375, #496
static comida + #376, #497
static comida + #377, #498
static comida + #378, #499
static comida + #379, #500
static comida + #380, #501
static comida + #381, #502
static comida + #382, #503
static comida + #383, #504
static comida + #384, #505
static comida + #385, #506
static comida + #386, #507
static comida + #387, #508
static comida + #388, #509
static comida + #389, #510
static comida + #390, #511
static comida + #391, #512
static comida + #392, #513
static comida + #393, #514
static comida + #394, #515
static comida + #395, #516
static comida + #396, #517
static comida + #397, #518
static comida + #400, #521
static comida + #401, #522
static comida + #402, #523
static comida + #403, #524
static comida + #404, #525
static comida + #405, #526
static comida + #406, #527
static comida + #407, #528
static comida + #408, #529
static comida + #409, #530
static comida + #410, #531
static comida + #411, #532
static comida + #412, #533
static comida + #413, #534
static comida + #414, #535
static comida + #415, #536
static comida + #416, #537
static comida + #417, #538
static comida + #418, #539
static comida + #419, #540
static comida + #420, #541
static comida + #421, #542
static comida + #422, #543
static comida + #423, #544
static comida + #424, #545
static comida + #425, #546
static comida + #426, #547
static comida + #427, #548
static comida + #428, #549
static comida + #429, #550
static comida + #430, #551
static comida + #431, #552
static comida + #432, #553
static comida + #433, #554
static comida + #434, #555
static comida + #435, #556
static comida + #436, #557
static comida + #437, #558
static comida + #440, #561
static comida + #441, #562
static comida + #442, #563
static comida + #443, #564
static comida + #444, #565
static comida + #445, #566
static comida + #446, #567
static comida + #447, #568
static comida + #448, #569
static comida + #449, #570
static comida + #450, #571
static comida + #451, #572
static comida + #452, #573
static comida + #453, #574
static comida + #454, #575
static comida + #455, #576
static comida + #456, #577
static comida + #457, #578
static comida + #458, #579
static comida + #459, #580
static comida + #460, #581
static comida + #461, #582
static comida + #462, #583
static comida + #463, #584
static comida + #464, #585
static comida + #465, #586
static comida + #466, #587
static comida + #467, #588
static comida + #468, #589
static comida + #469, #590
static comida + #470, #591
static comida + #471, #592
static comida + #472, #593
static comida + #473, #594
static comida + #474, #595
static comida + #475, #596
static comida + #476, #597
static comida + #477, #598
static comida + #480, #601
static comida + #481, #602
static comida + #482, #603
static comida + #483, #604
static comida + #484, #605
static comida + #485, #606
static comida + #486, #607
static comida + #487, #608
static comida + #488, #609
static comida + #489, #610
static comida + #490, #611
static comida + #491, #612
static comida + #492, #613
static comida + #493, #614
static comida + #494, #615
static comida + #495, #616
static comida + #496, #617
static comida + #497, #618
static comida + #498, #619
static comida + #499, #620
static comida + #500, #621
static comida + #501, #622
static comida + #502, #623
static comida + #503, #624
static comida + #504, #625
static comida + #505, #626
static comida + #506, #627
static comida + #507, #628
static comida + #508, #629
static comida + #509, #630
static comida + #510, #631
static comida + #511, #632
static comida + #512, #633
static comida + #513, #634
static comida + #514, #635
static comida + #515, #636
static comida + #516, #637
static comida + #517, #638
static comida + #520, #641
static comida + #521, #642
static comida + #522, #643
static comida + #523, #644
static comida + #524, #645
static comida + #525, #646
static comida + #526, #647
static comida + #527, #648
static comida + #528, #649
static comida + #529, #650
static comida + #530, #651
static comida + #531, #652
static comida + #532, #653
static comida + #533, #654
static comida + #534, #655
static comida + #535, #656
static comida + #536, #657
static comida + #537, #658
static comida + #538, #659
static comida + #539, #660
static comida + #540, #661
static comida + #541, #662
static comida + #542, #663
static comida + #543, #664
static comida + #544, #665
static comida + #545, #666
static comida + #546, #667
static comida + #547, #668
static comida + #548, #669
static comida + #549, #670
static comida + #550, #671
static comida + #551, #672
static comida + #552, #673
static comida + #553, #674
static comida + #554, #675
static comida + #555, #676
static comida + #556, #677
static comida + #557, #678
static comida + #560, #681
static comida + #561, #682
static comida + #562, #683
static comida + #563, #684
static comida + #564, #685
static comida + #565, #686
static comida + #566, #687
static comida + #567, #688
static comida + #568, #689
static comida + #569, #690
static comida + #570, #691
static comida + #571, #692
static comida + #572, #693
static comida + #573, #694
static comida + #574, #695
static comida + #575, #696
static comida + #576, #697
static comida + #577, #698
static comida + #578, #699
static comida + #579, #700
static comida + #580, #701
static comida + #581, #702
static comida + #582, #703
static comida + #583, #704
static comida + #584, #705
static comida + #585, #706
static comida + #586, #707
static comida + #587, #708
static comida + #588, #709
static comida + #589, #710
static comida + #590, #711
static comida + #591, #712
static comida + #592, #713
static comida + #593, #714
static comida + #594, #715
static comida + #595, #716
static comida + #596, #717
static comida + #597, #718
static comida + #600, #721
static comida + #601, #722
static comida + #602, #723
static comida + #603, #724
static comida + #604, #725
static comida + #605, #726
static comida + #606, #727
static comida + #607, #728
static comida + #608, #729
static comida + #609, #730
static comida + #610, #731
static comida + #611, #732
static comida + #612, #733
static comida + #613, #734
static comida + #614, #735
static comida + #615, #736
static comida + #616, #737
static comida + #617, #738
static comida + #618, #739
static comida + #619, #740
static comida + #620, #741
static comida + #621, #742
static comida + #622, #743
static comida + #623, #744
static comida + #624, #745
static comida + #625, #746
static comida + #626, #747
static comida + #627, #748
static comida + #628, #749
static comida + #629, #750
static comida + #630, #751
static comida + #631, #752
static comida + #632, #753
static comida + #633, #754
static comida + #634, #755
static comida + #635, #756
static comida + #636, #757
static comida + #637, #758
static comida + #640, #761
static comida + #641, #762
static comida + #642, #763
static comida + #643, #764
static comida + #644, #765
static comida + #645, #766
static comida + #646, #767
static comida + #647, #768
static comida + #648, #769
static comida + #649, #770
static comida + #650, #771
static comida + #651, #772
static comida + #652, #773
static comida + #653, #774
static comida + #654, #775
static comida + #655, #776
static comida + #656, #777
static comida + #657, #778
static comida + #658, #779
static comida + #659, #780
static comida + #660, #781
static comida + #661, #782
static comida + #662, #783
static comida + #663, #784
static comida + #664, #785
static comida + #665, #786
static comida + #666, #787
static comida + #667, #788
static comida + #668, #789
static comida + #669, #790
static comida + #670, #791
static comida + #671, #792
static comida + #672, #793
static comida + #673, #794
static comida + #674, #795
static comida + #675, #796
static comida + #676, #797
static comida + #677, #798
static comida + #680, #801
static comida + #681, #802
static comida + #682, #803
static comida + #683, #804
static comida + #684, #805
static comida + #685, #806
static comida + #686, #807
static comida + #687, #808
static comida + #688, #809
static comida + #689, #810
static comida + #690, #811
static comida + #691, #812
static comida + #692, #813
static comida + #693, #814
static comida + #694, #815
static comida + #695, #816
static comida + #696, #817
static comida + #697, #818
static comida + #698, #819
static comida + #699, #820
static comida + #700, #821
static comida + #701, #822
static comida + #702, #823
static comida + #703, #824
static comida + #704, #825
static comida + #705, #826
static comida + #706, #827
static comida + #707, #828
static comida + #708, #829
static comida + #709, #830
static comida + #710, #831
static comida + #711, #832
static comida + #712, #833
static comida + #713, #834
static comida + #714, #835
static comida + #715, #836
static comida + #716, #837
static comida + #717, #838
static comida + #720, #841
static comida + #721, #842
static comida + #722, #843
static comida + #723, #844
static comida + #724, #845
static comida + #725, #846
static comida + #726, #847
static comida + #727, #848
static comida + #728, #849
static comida + #729, #850
static comida + #730, #851
static comida + #731, #852
static comida + #732, #853
static comida + #733, #854
static comida + #734, #855
static comida + #735, #856
static comida + #736, #857
static comida + #737, #858
static comida + #738, #859
static comida + #739, #860
static comida + #740, #861
static comida + #741, #862
static comida + #742, #863
static comida + #743, #864
static comida + #744, #865
static comida + #745, #866
static comida + #746, #867
static comida + #747, #868
static comida + #748, #869
static comida + #749, #870
static comida + #750, #871
static comida + #751, #872
static comida + #752, #873
static comida + #753, #874
static comida + #754, #875
static comida + #755, #876
static comida + #756, #877
static comida + #757, #878
static comida + #760, #881
static comida + #761, #882
static comida + #762, #883
static comida + #763, #884
static comida + #764, #885
static comida + #765, #886
static comida + #766, #887
static comida + #767, #888
static comida + #768, #889
static comida + #769, #890
static comida + #770, #891
static comida + #771, #892
static comida + #772, #893
static comida + #773, #894
static comida + #774, #895
static comida + #775, #896
static comida + #776, #897
static comida + #777, #898
static comida + #778, #899
static comida + #779, #900
static comida + #780, #901
static comida + #781, #902
static comida + #782, #903
static comida + #783, #904
static comida + #784, #905
static comida + #785, #906
static comida + #786, #907
static comida + #787, #908
static comida + #788, #909
static comida + #789, #910
static comida + #790, #911
static comida + #791, #912
static comida + #792, #913
static comida + #793, #914
static comida + #794, #915
static comida + #795, #916
static comida + #796, #917
static comida + #797, #918
static comida + #800, #921
static comida + #801, #922
static comida + #802, #923
static comida + #803, #924
static comida + #804, #925
static comida + #805, #926
static comida + #806, #927
static comida + #807, #928
static comida + #808, #929
static comida + #809, #930
static comida + #810, #931
static comida + #811, #932
static comida + #812, #933
static comida + #813, #934
static comida + #814, #935
static comida + #815, #936
static comida + #816, #937
static comida + #817, #938
static comida + #818, #939
static comida + #819, #940
static comida + #820, #941
static comida + #821, #942
static comida + #822, #943
static comida + #823, #944
static comida + #824, #945
static comida + #825, #946
static comida + #826, #947
static comida + #827, #948
static comida + #828, #949
static comida + #829, #950
static comida + #830, #951
static comida + #831, #952
static comida + #832, #953
static comida + #833, #954
static comida + #834, #955
static comida + #835, #956
static comida + #836, #957
static comida + #837, #958
static comida + #840, #961
static comida + #841, #962
static comida + #842, #963
static comida + #843, #964
static comida + #844, #965
static comida + #845, #966
static comida + #846, #967
static comida + #847, #968
static comida + #848, #969
static comida + #849, #970
static comida + #850, #971
static comida + #851, #972
static comida + #852, #973
static comida + #853, #974
static comida + #854, #975
static comida + #855, #976
static comida + #856, #977
static comida + #857, #978
static comida + #858, #979
static comida + #859, #980
static comida + #860, #981
static comida + #861, #982
static comida + #862, #983
static comida + #863, #984
static comida + #864, #985
static comida + #865, #986
static comida + #866, #987
static comida + #867, #988
static comida + #868, #989
static comida + #869, #990
static comida + #870, #991
static comida + #871, #992
static comida + #872, #993
static comida + #873, #994
static comida + #874, #995
static comida + #875, #996
static comida + #876, #997
static comida + #877, #998
static comida + #880, #1001
static comida + #881, #1002
static comida + #882, #1003
static comida + #883, #1004
static comida + #884, #1005
static comida + #885, #1006
static comida + #886, #1007
static comida + #887, #1008
static comida + #888, #1009
static comida + #889, #1010
static comida + #890, #1011
static comida + #891, #1012
static comida + #892, #1013
static comida + #893, #1014
static comida + #894, #1015
static comida + #895, #1016
static comida + #896, #1017
static comida + #897, #1018
static comida + #898, #1019
static comida + #899, #1020
static comida + #900, #1021
static comida + #901, #1022
static comida + #902, #1023
static comida + #903, #1024
static comida + #904, #1025
static comida + #905, #1026
static comida + #906, #1027
static comida + #907, #1028
static comida + #908, #1029
static comida + #909, #1030
static comida + #910, #1031
static comida + #911, #1032
static comida + #912, #1033
static comida + #913, #1034
static comida + #914, #1035
static comida + #915, #1036
static comida + #916, #1037
static comida + #917, #1038
static comida + #920, #1041
static comida + #921, #1042
static comida + #922, #1043
static comida + #923, #1044
static comida + #924, #1045
static comida + #925, #1046
static comida + #926, #1047
static comida + #927, #1048
static comida + #928, #1049
static comida + #929, #1050
static comida + #930, #1051
static comida + #931, #1052
static comida + #932, #1053
static comida + #933, #1054
static comida + #934, #1055
static comida + #935, #1056
static comida + #936, #1057
static comida + #937, #1058
static comida + #938, #1059
static comida + #939, #1060
static comida + #940, #1061
static comida + #941, #1062
static comida + #942, #1063
static comida + #943, #1064
static comida + #944, #1065
static comida + #945, #1066
static comida + #946, #1067
static comida + #947, #1068
static comida + #948, #1069
static comida + #949, #1070
static comida + #950, #1071
static comida + #951, #1072
static comida + #952, #1073
static comida + #953, #1074
static comida + #954, #1075
static comida + #955, #1076
static comida + #956, #1077
static comida + #957, #1078
static comida + #960, #1081
static comida + #961, #1082
static comida + #962, #1083
static comida + #963, #1084
static comida + #964, #1085
static comida + #965, #1086
static comida + #966, #1087
static comida + #967, #1088
static comida + #968, #1089
static comida + #969, #1090
static comida + #970, #1091
static comida + #971, #1092
static comida + #972, #1093
static comida + #973, #1094
static comida + #974, #1095
static comida + #975, #1096
static comida + #976, #1097
static comida + #977, #1098
static comida + #978, #1099
static comida + #979, #1100
static comida + #980, #1101
static comida + #981, #1102
static comida + #982, #1103
static comida + #983, #1104
static comida + #984, #1105
static comida + #985, #1106
static comida + #986, #1107
static comida + #987, #1108
static comida + #988, #1109
static comida + #989, #1110
static comida + #990, #1111
static comida + #991, #1112
static comida + #992, #1113
static comida + #993, #1114
static comida + #994, #1115
static comida + #995, #1116
static comida + #996, #1117
static comida + #997, #1118
static comida + #1000, #1121
static comida + #1001, #1122
static comida + #1002, #1123
static comida + #1003, #1124
static comida + #1004, #1125
static comida + #1005, #1126
static comida + #1006, #1127
static comida + #1007, #1128
static comida + #1008, #1129
static comida + #1009, #1130
static comida + #1010, #1131
static comida + #1011, #1132
static comida + #1012, #1133
static comida + #1013, #1134
static comida + #1014, #1135
static comida + #1015, #1136
static comida + #1016, #1137
static comida + #1017, #1138
static comida + #1018, #1139
static comida + #1019, #1140
static comida + #1020, #1141
static comida + #1021, #1142
static comida + #1022, #1143
static comida + #1023, #1144
static comida + #1024, #1145
static comida + #1025, #1146
static comida + #1026, #1147
static comida + #1027, #1148
static comida + #1028, #1149
static comida + #1029, #1150
static comida + #1030, #1151
static comida + #1031, #1152
static comida + #1032, #1153
static comida + #1033, #1154
static comida + #1034, #1155
static comida + #1035, #1156
static comida + #1036, #1157
static comida + #1037, #1158