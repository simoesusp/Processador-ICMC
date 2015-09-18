; falta:
; desabilitar a colisao dos fantasmas quando estao brancos
; fazer a IA dos fantasmas
; - colocar os pontos de decisao nas intersecoes
; - colocar os tres modos de operacao dos fantasmas


; Autor: Marcelo Koti Kamada
; Demo: jogo Pacman


jmp main


; ----- muro --------
CaracterMuro : var #1

static CaracterMuro, #3102



; ---- pacman -----
CaracterPacmanEsqAberto : var #1
CaracterPacmanDirAberto : var #1
CaracterPacmanCimaAberto : var #1
CaracterPacmanBaixoAberto : var #1

CaracterPacmanEsqFechado : var #1
CaracterPacmanDirFechado : var #1
CaracterPacmanCimaFechado : var #1
CaracterPacmanBaixoFechado : var #1

static CaracterPacmanEsqAberto, #61
static CaracterPacmanDirAberto, #63
static CaracterPacmanCimaAberto, #58
static CaracterPacmanBaixoAberto, #46

static CaracterPacmanEsqFechado, #59
static CaracterPacmanDirFechado, #62
static CaracterPacmanCimaFechado, #47
static CaracterPacmanBaixoFechado, #45


; ----- vitamina --------
CaracterVitamina : var #1
static CaracterVitamina, #39


; ----- comida --------
CaracterComida : var #1

static CaracterComida, #26


; ----- PACMAN -------
PosicaoPacman : var #1
static PosicaoPacman, #60

UltimoEstadoPacman : var #1
static UltimoEstadoPacman, #1

ResetPacman : var #1
static ResetPacman, #0

lockMovimento : var #1
static lockMovimento, #0

timerMovimento : var #1
static timerMovimento, #0

; ------- SCORE -------
Milhar : var #1
PosMilhar : var #1

Centena : var #1
PosCentena : var #1

Dezena : var #1
PosDezena : var #1

Unidade : var #1
PosUnidade : var #1

static Milhar, #'0'
static PosMilhar, #1166

static Centena, #'0'
static PosCentena, #1167

static Dezena, #'0'
static PosDezena, #1168

static Unidade, #'0'
static PosUnidade, #1169

; ------- TABELA DE CORES -------
; adicione ao caracter para adicionar a cor correspondente

; 0 branco							0000
; 255 marrom						0001
; 512 verde							0010
; 768 oliva							0011
; 1024 azul marinho			0100
; 1280 roxo							0101
; 1537 teal							0110
; 1793 prata						0111
; 2048 cinza						1000
; 2304 vermelho					1001
; 2561 lima							1010
; 2816 amarelo					1011
; 3072 azul							1100
; 3328 rosa							1101
; 3584 aqua							1110
; 3839 branco						1111

CorAmarela : var #1
static CorAmarela, #2816


; ------- fantasma ---------
estado_olho : var #1
static estado_olho, #0

estadoFantasmao : var #1
static estadoFantasmao, #0

contadorFantasmao : var #1
static contadorFantasmao, #0

timerFantasma : var #1
static timerFantasma, #0


fantasmaEstaDoente : var #1
static fantasmaEstaDoente, #0
; ------- fantasma ---------


; Pac aberto 96
; Pac fechado 100
; comida 104


; --------- start ----------
timerStart : var #1
static timerStart, #0

estadoStart : var #1
static estadoStart, #0
; --------- start ----------


; -------- continue --------
estadoContinue : var #1
static estadoContinue, #0
; -------- continue --------



; ------- animacao --------
estadoAnimacao : var #1
static estadoAnimacao, #0

PosAnimacao : var #1
static PosAnimacao, #652

PacmanAnimacao : var #1
static PacmanAnimacao, #2916

iteracoesAnimacao : var #1
static iteracoesAnimacao, #0
; ------- animacao --------

; ------ fantasma 1 -------
posFantasma1 : var #1
static posFantasma1, #980

estadoFantasma1 : var #1
static estadoFantasma1, #0

caracterFantasma1Dir1 : var #1
static caracterFantasma1Dir1, #44

caracterFantasma1Dir2 : var #1
static caracterFantasma1Dir2, #43

caracterFantasma1Esq1 : var #1
static caracterFantasma1Esq1, #41

caracterFantasma1Esq2 : var #1
static caracterFantasma1Esq2, #40
; ------ fantasma 1 -------

; ------ fantasma 2 -------
posFantasma2 : var #1
static posFantasma2, #981

estadoFantasma2 : var #1
static estadoFantasma2, #0

caracterFantasma2Dir1 : var #1
static caracterFantasma2Dir1, #44

caracterFantasma2Dir2 : var #1
static caracterFantasma2Dir2, #43

caracterFantasma2Esq1 : var #1
static caracterFantasma2Esq1, #41

caracterFantasma2Esq2 : var #1
static caracterFantasma2Esq2, #40
; ------ fantasma 2 -------



; ------ fantasma 3 -------
posFantasma3 : var #1
static posFantasma3, #1020

estadoFantasma3 : var #1
static estadoFantasma3, #0

caracterFantasma3Dir1 : var #1
static caracterFantasma3Dir1, #44

caracterFantasma3Dir2 : var #1
static caracterFantasma3Dir2, #43

caracterFantasma3Esq1 : var #1
static caracterFantasma3Esq1, #41

caracterFantasma3Esq2 : var #1
static caracterFantasma3Esq2, #40
; ------ fantasma 3 -------






; ------ fantasma 4 -------
posFantasma4 : var #1
static posFantasma4, #1021

estadoFantasma4 : var #1
static estadoFantasma4, #0

caracterFantasma4Dir1 : var #1
static caracterFantasma4Dir1, #44

caracterFantasma4Dir2 : var #1
static caracterFantasma4Dir2, #43

caracterFantasma4Esq1 : var #1
static caracterFantasma4Esq1, #41

caracterFantasma4Esq2 : var #1
static caracterFantasma4Esq2, #40
; ------ fantasma 3 -------


caracterFantasmaDoente : var #1
static caracterFantasmaDoente, #42



; ------ vitoria -----------
flagVitoria : var #1
static flagVitoria, #0
; ------ vitoria -----------


; ------ Vidas ---------
posicaoVidas : var #1
static posicaoVidas, #1190

numeroVidas : var #1
static numeroVidas, #3
; ------ Vidas ---------



; ------ jogo -----------

main:
	loadn r0, #0
	store flagVitoria, r0

	call ImprimeIntro
	call Intro

	call Reset
	call ImprimeTelaInicial

	call CarregaCorPacman

	load r1, CaracterPacmanDirAberto
	load r0, PosicaoPacman

	outchar r1, r0

a:
	push r5
	push r7

	loadn r5, #1
	load r7, flagVitoria

	cmp r5, r7
	jeq b

	pop r7
	pop r5

	call movimentacao

	push r5
	push r6

	loadn r5, #1
	load r6, fantasmaEstaDoente

	cmp r5, r6
	jeq jkha

	call olho_fantasma

	call movimenta_fantasmao

jkha:
	pop r6
	pop r5

	call downTimer

	jmp a


b:
	call ImprimeEncerramento
	call Encerramento

	jmp main


downTimer:
	push r3
	push r4

	load r3, fantasmaEstaDoente
	loadn r4, #0
	cmp r3, r4
	jeq dt_fim
	jmp estaDoente

estaDoente:
	load r3, timerFantasma

	cmp r3, r4
	jeq fantasmaSeRecupera

	dec r3
	store timerFantasma, r3

dt_fim:
	pop r4
	pop r3
	rts

fantasmaSeRecupera:
	push r2

	loadn r2, #FantasmaSaudavel
	call fantasmaDoente

	loadn r2, #0
	store fantasmaEstaDoente, r2

	pop r2
	jmp dt_fim



; -----  Reset ---------
Reset:
	push r0
	push r1
	push r2
	push r3
	push r4

	loadn r0, #60
	store PosicaoPacman, r0

	loadn r0, #'0'

	store Unidade, r0
	store Dezena, r0
	store Centena, r0
	store Milhar, r0

	loadn r0, #1
	store UltimoEstadoPacman, r0

	loadn r0, #1200
	loadn r1, #0
	loadn r2, #MapaInicial
	loadn r3, #ResetMapa

reset_volta:
	cmp r1, r0
	jeq reset_fim
	loadi r4, r3
	storei r2, r4

	inc r1
	inc r2
	inc r3
	jmp reset_volta

reset_fim:
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; -----  Reset ---------




; ------------- MOVIMENTACAO -----------------
; assume que:
; r0 possui a posicao
; r1 possui o caracter do pacman da ultima posicao

movimentacao:
	push r2
	push r3

	ir r3

	;loadn r2, #'A'
	loadn r2, #2
	cmp	r2, r3
	ceq testeEsq ; esq

	;loadn r2, #'D'
	loadn r2, #1
	cmp	r2, r3
	ceq testeDir ; dir

	;loadn r2, #'W'
	loadn r2, #3
	cmp	r2, r3
	ceq testeSobe ; sobe

	;loadn r2, #'S' 4
	loadn r2, #4
	cmp	r2, r3
	ceq testeDesce ; desce

	call continuaMov

	call delay_kamada
	
	pop r3
	pop r2
	rts
; ------------- MOVIMENTACAO -----------------


testeEsq:
	push r0
	push r3
	push r5

	dec r0
	call colisao
	inc r0

	loadn r5, #1
	cmp r3, r5

	jeq testeEsq_fim

	loadn r5, #1
	store lockMovimento, r5

testeEsq_fim:
	pop r5
	pop r3
	pop r0
	rts

testeDir:
	push r0
	push r3
	push r5

	inc r0
	call colisao
	dec r0

	loadn r5, #1
	cmp r3, r5

	jeq testeDir_fim

	loadn r5, #2
	store lockMovimento, r5

testeDir_fim:
	pop r5
	pop r3
	pop r0
	rts

testeSobe:
	push r0
	push r3
	push r5

	loadn r5, #40

	sub r0, r0, r5
	call colisao
	add r0, r0, r5

	loadn r5, #1
	cmp r3, r5

	jeq testeSobe_fim

	loadn r5, #3
	store lockMovimento, r5

testeSobe_fim:
	pop r5
	pop r3
	pop r0
	rts

testeDesce:
	push r0
	push r3
	push r5

	loadn r5, #40

	add r0, r0, r5
	call colisao
	sub r0, r0, r5

	loadn r5, #1
	cmp r3, r5

	jeq testeDesce_fim

	loadn r5, #4
	store lockMovimento, r5

testeDesce_fim:
	pop r5
	pop r3
	pop r0
	rts



; --------- continua movimento ---------------
continuaMov:
	push r3
	push r4

	load r3, fantasmaEstaDoente
	loadn r4, #1

	cmp r3, r4
	jeq cm_2
	jmp cm_1

cm_2:
	loadn r4, #100
	jmp cm_3

cm_1:
	loadn r4, #5
	jmp cm_3

cm_3:
	load r3, timerMovimento

	cmp r4, r3
	jle resetaTimerMovimento

	inc r3
	jmp cm_fim

resetaTimerMovimento:
	load r3, lockMovimento
	loadn r4, #0

	cmp r3, r4
	jeq cm_fim

	inc r4
	cmp r3, r4
	ceq esq; esq

	inc r4
	cmp r3, r4
	ceq dir; dir

	inc r4
	cmp r3, r4
	ceq sobe; sobe

	inc r4
	cmp r3, r4
	ceq desce; desce

	loadn r3, #0

cm_fim:
	store timerMovimento, r3
	pop r4
	pop r3
	rts
; --------- continua movimento ---------------






; --------------- COLISAO --------------------
; r0 possui a posicao do pacman

colisao:
	push r5
	push r6
	push r7

	loadn r5, #MapaInicial
	add r5, r5, r0
	
	loadi r7, r5					; carrega o caracter que esta na posicao r0 do mapa
	loadn r6, #2395				; carrega o muro

	cmp r7, r6						; se o caracter nao for o muro
	jle continua					; tudo bem, continua
	jmp bateu

continua:
	load r6, CaracterComida
	cmp r7, r6
	ceq come

	load r6, CaracterVitamina
	cmp r7, r6
	ceq vitamina

	loadn r3, #0
	jmp hg

bateu:
	loadn r3, #1
	jmp hg

hg:
	pop r7
	pop r6
	pop r5
	rts

come:
	loadn r6, #32 ; carrega Espaco
	storei r5, r6
	call IncrementaScore
	rts


vitamina:
	loadn r6, #32 ; carrega Espaco
	storei r5, r6

	push r2

	loadn r2, #3000
	store timerFantasma, r2

	loadn r2, #FantasmaDoente
	call fantasmaDoente

	loadn r2, #1
	store fantasmaEstaDoente, r2

	pop r2
	rts

; --------------- COLISAO --------------------



; --------- ATRAVESSA ESQ -> DIR -------------
atravessaEsqDir:
	loadn r7, #520	; outro lado
	store PosicaoPacman, r7

	pop r7
	jmp f1

e1:
	push r7
	loadn r7, #480	; travessia
	cmp r7, r0
	jeq atravessaEsqDir

	pop r7
	jmp d1

; --------- ATRAVESSA ESQ -> DIR -------------




; -------------- Esquerda --------------------
esq:
	call F1_esq
	call F2_dir
	call F3_sobe
	call F4_desce

	push r3
	push r4

	store PosicaoPacman, r0

	dec r0
	call colisao
	inc r0

	loadn r4, #1
	cmp r3, r4
	jeq e1

f1:
	loadn r3, #0
	outchar r3, r0 ; apaga a posicao antiga

	load r3, UltimoEstadoPacman
	loadn r4, #0

	cmp r3, r4	; esta com a boca aberta?
	jeq a1			; aberta = 1, fechada = 0
	jmp b1
	jmp c1

a1:	; boca fechada
	load r1, CaracterPacmanEsqFechado
	inc r3
	jmp c1

b1:	; boca aberta
	load r1, CaracterPacmanEsqAberto
	dec r3
	jmp c1

c1:
	load r0, PosicaoPacman

	store UltimoEstadoPacman, r3
	dec r0
	outchar r1, r0	; apaga a posicao anterior

	store PosicaoPacman, r0

d1:
	pop r4
	pop r3
	rts
; -------------- Esquerda --------------------





; --------- ATRAVESSA DIR -> ESQ -------------
atravessaDirEsq:
	loadn r7, #479	; outro lado
	store PosicaoPacman, r7

	pop r7
	jmp f2

e2:
	push r7
	loadn r7, #519	; travessia
	cmp r7, r0

	jeq atravessaDirEsq

	pop r7
	jmp d2

; --------- ATRAVESSA DIR -> ESQ -------------






; -------------- DIREITA --------------------
dir:
	call F1_dir
	call F2_esq
	call F3_desce
	call F4_sobe

	push r3
	push r4

	store PosicaoPacman, r0

	inc r0
	call colisao
	dec r0

	loadn r4, #1
	cmp r3, r4
	jeq e2

f2:
	loadn r3, #0
	outchar r3, r0 ; apaga a posicao antiga

	load r3, UltimoEstadoPacman
	loadn r4, #0

	cmp r3, r4	; esta com a boca aberta?
	jeq a2			; aberta = 1, fechada = 0
	jmp b2
	jmp c2

a2:	; boca fechada
	load r1, CaracterPacmanDirFechado
	inc r3
	jmp c2

b2:	; boca aberta
	load r1, CaracterPacmanDirAberto
	dec r3
	jmp c2

c2:
	load r0, PosicaoPacman

	store UltimoEstadoPacman, r3
	inc r0
	outchar r1, r0	; apaga a posicao anterior

	store PosicaoPacman, r0

d2:
	pop r4
	pop r3
	rts
; -------------- DIREITA --------------------




; ---------------- SOBE --------------------
sobe:
	call F1_sobe
	call F2_desce
	call F3_dir
	call F4_esq

	push r2
	push r3
	push r4

	store PosicaoPacman, r0

	loadn r2, #40

	sub r0, r0, r2
	call colisao
	add r0, r0, r2

	loadn r4, #1
	cmp r3, r4
	jeq d3

	loadn r3, #0
	outchar r3, r0 ; apaga a posicao antiga

	load r3, UltimoEstadoPacman
	loadn r4, #0

	cmp r3, r4	; esta com a boca aberta?
	jeq a3			; aberta = 1, fechada = 0
	jmp b3
	jmp c3

a3:	; boca fechada
	load r1, CaracterPacmanCimaFechado
	inc r3
	jmp c3

b3:	; boca aberta
	load r1, CaracterPacmanCimaAberto
	dec r3
	jmp c3

c3:
	load r0, PosicaoPacman

	store UltimoEstadoPacman, r3
	loadn r2, #40
	sub r0, r0, r2
	outchar r1, r0	; apaga a posicao anterior

	store PosicaoPacman, r0

d3:
	pop r4
	pop r3
	pop r2
	rts
; ---------------- SOBE --------------------




; --------------- DESCE --------------------
desce:
	call F1_desce
	call F2_sobe
	call F3_esq
	call F4_dir

	push r2
	push r3
	push r4

	store PosicaoPacman, r0

	loadn r2, #40

	add r0, r0, r2
	call colisao
	sub r0, r0, r2

	loadn r4, #1
	cmp r3, r4
	jeq d4

	loadn r3, #0
	outchar r3, r0 ; apaga a posicao antiga

	load r3, UltimoEstadoPacman
	loadn r4, #0

	cmp r3, r4	; esta com a boca aberta?
	jeq a4			; aberta = 1, fechada = 0
	jmp b4
	jmp c4

a4:	; boca fechada
	load r1, CaracterPacmanBaixoFechado
	inc r3
	jmp c4

b4:	; boca aberta
	load r1, CaracterPacmanBaixoAberto
	dec r3
	jmp c4

c4:
	load r0, PosicaoPacman

	store UltimoEstadoPacman, r3

	loadn r2, #40
	add r0, r0, r2
	outchar r1, r0	; apaga a posicao anterior

	store PosicaoPacman, r0

d4:
	pop r4
	pop r3
	pop r2
	rts
; --------------- DESCE --------------------



; --------------- SCORE --------------------
IncrementaScore:
	push r0
	push r1

	call verificaVitoria

	loadn r0, #'9'
	load r1, Unidade
	cmp r0, r1
	jeq IncDezena
	jmp IncUnidade

volta1:
	pop r1
	pop r0
	rts

IncDezena:
	push r2
	push r3

	load r2, PosUnidade
	loadn r3, #'0'

	store Unidade, r3
	outchar r3, r2

	loadn r2, #'9'
	load r3, Dezena
	cmp r2, r3
	jeq IncCentena

	load r2, PosDezena
	load r3, Dezena
	inc r3

	store Dezena, r3
	outchar r3, r2

volta2:
	pop r3
	pop r2
	jmp volta1

IncUnidade:
	push r2
	push r3

	load r2, PosUnidade
	load r3, Unidade
	inc r3

	store Unidade, r3
	outchar r3, r2

	pop r3
	pop r2
	jmp volta1

IncCentena:
	push r2
	push r3

	load r2, PosDezena
	loadn r3, #'0'

	store Dezena, r3
	outchar r3, r2

	load r2, PosCentena
	load r3, Centena
	inc r3

	store Centena, r3
	outchar r3, r2

	pop r3
	pop r2
	jmp volta2
; --------------- SCORE --------------------





; --------- verifica vitoria ---------------
verificaVitoria:
	push r5
	push r6

	load r5, Centena
	loadn r6, #'3'

	cmp r5, r6
	jeq vv_prox1
	jmp vv_fim

vv_prox1:
	load r5, Dezena
	loadn r6, #'2'

	cmp r5, r6
	jeq vv_prox2
	jmp vv_fim


vv_prox2:
	load r5, Unidade
	loadn r6, #'9'

	cmp r5, r6
	jeq vv_vitoria
	jmp vv_fim

vv_fim:
	pop r6
	pop r5
	rts



vv_vitoria:
	loadn r5, #1
	store flagVitoria, r5
	jmp vv_fim

; --------- verifica vitoria ---------------





; ----------- CarregaCorPacman -----------
CarregaCorPacman:
	push r0
	push r1

	loadn r0, #1
	load r1, ResetPacman
	cmp r0, r1
	jeq CCP_fim

	load r0, CorAmarela

	load r1, CaracterPacmanEsqAberto
	add r1, r1, r0
	store CaracterPacmanEsqAberto, r1

	load r1, CaracterPacmanEsqFechado
	add r1, r1, r0
	store CaracterPacmanEsqFechado, r1



	load r1, CaracterPacmanDirAberto
	add r1, r1, r0
	store CaracterPacmanDirAberto, r1

	load r1, CaracterPacmanDirFechado
	add r1, r1, r0
	store CaracterPacmanDirFechado, r1



	load r1, CaracterPacmanCimaAberto
	add r1, r1, r0
	store CaracterPacmanCimaAberto, r1

	load r1, CaracterPacmanCimaFechado
	add r1, r1, r0
	store CaracterPacmanCimaFechado, r1



	load r1, CaracterPacmanBaixoAberto
	add r1, r1, r0
	store CaracterPacmanBaixoAberto, r1

	load r1, CaracterPacmanBaixoFechado
	add r1, r1, r0
	store CaracterPacmanBaixoFechado, r1



	loadn r0, #2304

	load r1, caracterFantasma1Esq1
	add r1, r1, r0
	store caracterFantasma1Esq1, r1

	load r1, caracterFantasma1Esq2
	add r1, r1, r0
	store caracterFantasma1Esq2, r1

	load r1, caracterFantasma1Dir1
	add r1, r1, r0
	store caracterFantasma1Dir1, r1

	load r1, caracterFantasma1Dir2
	add r1, r1, r0
	store caracterFantasma1Dir2, r1


	loadn r0, #3328

	load r1, caracterFantasma2Esq1
	add r1, r1, r0
	store caracterFantasma2Esq1, r1

	load r1, caracterFantasma2Esq2
	add r1, r1, r0
	store caracterFantasma2Esq2, r1

	load r1, caracterFantasma2Dir1
	add r1, r1, r0
	store caracterFantasma2Dir1, r1

	load r1, caracterFantasma2Dir2
	add r1, r1, r0
	store caracterFantasma2Dir2, r1



	loadn r0, #512

	load r1, caracterFantasma3Esq1
	add r1, r1, r0
	store caracterFantasma3Esq1, r1

	load r1, caracterFantasma3Esq2
	add r1, r1, r0
	store caracterFantasma3Esq2, r1

	load r1, caracterFantasma3Dir1
	add r1, r1, r0
	store caracterFantasma3Dir1, r1

	load r1, caracterFantasma3Dir2
	add r1, r1, r0
	store caracterFantasma3Dir2, r1





	loadn r0, #1536

	load r1, caracterFantasma4Esq1
	add r1, r1, r0
	store caracterFantasma4Esq1, r1

	load r1, caracterFantasma4Esq2
	add r1, r1, r0
	store caracterFantasma4Esq2, r1

	load r1, caracterFantasma4Dir1
	add r1, r1, r0
	store caracterFantasma4Dir1, r1

	load r1, caracterFantasma4Dir2
	add r1, r1, r0
	store caracterFantasma4Dir2, r1

	loadn r0, #1190
	store posicaoVidas, r0

	loadn r0, #3
	store numeroVidas, r0

	loadn r0, #1
	store ResetPacman, r0

CCP_fim:
	pop r1
	pop r0
	rts

; ----------- CarregaCorPacman -----------




; ------- Imprime Intro ----------
ImprimeIntro:
	push r0
	loadn r0, #intro;
	call CarregaMapa
	pop r0
	rts
; ------- Imprime Intro ----------

; ---------- Intro ---------------
Intro:
	push r1
	push r2

	loadn r1, #0
	; loadn r2, #13 ; numero do enter
	loadn r2, #5

intro_volta:
	ir r1
	cmp r1, r2
	jeq intro_fim	; se for o enter
	call piscaPressStart
	jmp intro_volta


intro_fim:
	pop r2
	pop r1
	rts
; ---------- Intro ---------------




; ----- Imprime caracter maior --------
; r0 posicao
; r1 caracter

outchar2:
	push r0
	push r1
	push r2

	outchar r1, r0

	inc r0
	inc r1
	outchar r1, r0

	dec r0

	loadn r2, #40
	add r0, r0, r2
	inc r1
	outchar r1, r0

	inc r0
	inc r1
	outchar r1, r0

	pop r2
	pop r1
	pop r0
	rts
; ----- Imprime caracter maior --------




; ---- Pisca Press Start -------------
piscaPressStart:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r2, timerStart
	loadn r3, #600

	cmp r2, r3
	jeq pps_a
	jmp pps_fim

pps_a:
	call animacaoIntro

	load r2, estadoStart
	loadn r3, #0

	cmp r2, r3
	jeq pps_visivel
	jmp pps_escondido

pps_visivel:
	loadn r2, #1
	store estadoStart, r2
	loadn r2, #start
	jmp pps_b

pps_escondido:
	loadn r2, #0
	store estadoStart, r2
	loadn r2, #start2
	jmp pps_b

pps_b:
	loadn r0, #930	; posicao de impressao

	loadn r3, #20
	loadn r4, #0

klasd:
	cmp r3, r4
	jeq fffff

	loadi r5, r2
	outchar r5, r0

	inc r0
	inc r2
	inc r4
	jmp klasd

fffff:
	loadn r2, #0
	jmp pps_fim

pps_fim:
	inc r2
	store timerStart, r2

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; ---- Pisca Press Start -------------


start : var #20
static start + #0, #'P'
static start + #1, #'R'
static start + #2, #'E'
static start + #3, #'S'
static start + #4, #'S'
static start + #5, #' '
static start + #6, #'E'
static start + #7, #'N'
static start + #8, #'T'
static start + #9, #'E'
static start + #10, #'R'
static start + #11, #' '
static start + #12, #'T'
static start + #13, #'O'
static start + #14, #' '
static start + #15, #'S'
static start + #16, #'T'
static start + #17, #'A'
static start + #18, #'R'
static start + #19, #'T'


start2 : var #20
static start2 + #0, #' '
static start2 + #1, #' '
static start2 + #2, #' '
static start2 + #3, #' '
static start2 + #4, #' '
static start2 + #5, #' '
static start2 + #6, #' '
static start2 + #7, #' '
static start2 + #8, #' '
static start2 + #9, #' '
static start2 + #10, #' '
static start2 + #11, #' '
static start2 + #12, #' '
static start2 + #13, #' '
static start2 + #14, #' '
static start2 + #15, #' '
static start2 + #16, #' '
static start2 + #17, #' '
static start2 + #18, #' '
static start2 + #19, #' '



; -------- animacaoIntro -------
animacaoIntro:
	push r0
	push r1

	load r0, estadoAnimacao
	loadn r1, #0

	cmp r0, r1
	jeq animacao0

	inc r1
	cmp r0, r1
	jeq animacao1

	inc r1
	cmp r0, r1
	jeq animacao2
	
	inc r1
	cmp r0, r1
	jeq animacao3

	inc r1
	cmp r0, r1
	jeq animacao4

	inc r1
	cmp r0, r1
	jeq animacao5

	inc r1
	cmp r0, r1
	jeq animacao6

	inc r1
	cmp r0, r1
	jeq animacao7

	inc r1
	cmp r0, r1
	jeq animacao8

	inc r1
	cmp r0, r1
	jeq animacao9

	inc r1
	cmp r0, r1
	jeq animacao10

	inc r1
	cmp r0, r1
	jeq animacao11

	inc r1
	cmp r0, r1
	jeq animacao12

animacao_fim:
	pop r1
	pop r0
	rts
; -------- animacaoIntro -------


; -------- animacao0 -------
animacao0:
	push r2
	push r3

	loadn r0, #640 ; inicio da linha
	loadn r1, #104 ; comida
	loadn r2, #0
	loadn r3, #20

ani0_volta:
	cmp r2, r3
	jeq ani0_fim

	call outchar2

	inc r2
	inc r0
	inc r0
	jmp ani0_volta

ani0_fim:
	pop r3
	pop r2

	loadn r0, #1
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao0 -------



; -------- animacao1 -------
animacao1:
	loadn r0, #640
	loadn r1, #2912
	call outchar2

	loadn r0, #2
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao1 -------



; -------- animacao2 -------
animacao2:
	loadn r0, #640
	loadn r1, #116
	call outchar2

	loadn r0, #642
	loadn r1, #2916
	call outchar2

	loadn r0, #3
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao2 -------



; -------- animacao3 -------
animacao3:
	loadn r0, #640
	loadn r1, #2412 ;2304
	call outchar2

	loadn r0, #642
	loadn r1, #116
	call outchar2

	loadn r0, #644
	loadn r1, #2912
	call outchar2

	loadn r0, #4
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao3 -------



; -------- animacao4 -------
animacao4:
	loadn r0, #640
	loadn r1, #620 ;512
	call outchar2

	loadn r0, #642
	loadn r1, #2416 ; 2304
	call outchar2

	loadn r0, #644
	loadn r1, #116
	call outchar2

	loadn r0, #646
	loadn r1, #2916
	call outchar2

	loadn r0, #5
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao4 -------


; -------- animacao5 -------
animacao5:
	loadn r0, #640
	loadn r1, #3436 ; 3328
	call outchar2

	loadn r0, #642
	loadn r1, #624 ; 512
	call outchar2

	loadn r0, #644
	loadn r1, #2412
	call outchar2

	loadn r0, #646
	loadn r1, #116
	call outchar2

	loadn r0, #648
	loadn r1, #2912
	call outchar2

	loadn r0, #6
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao5 -------


; -------- animacao6 -------
animacao6:
	loadn r0, #640
	loadn r1, #1644 ; 3328
	call outchar2

	loadn r0, #642
	loadn r1, #3440 ; 3328
	call outchar2

	loadn r0, #644
	loadn r1, #620 ; 512
	call outchar2

	loadn r0, #646
	loadn r1, #2416
	call outchar2

	loadn r0, #648
	loadn r1, #116
	call outchar2

	loadn r0, #650
	loadn r1, #2916
	call outchar2

	loadn r0, #7
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao6 -------





; -------- animacao7 -------
animacao7:
	loadn r0, #14 ; numero de vezes
	load r1, iteracoesAnimacao

	cmp r0, r1
	jeq ani6_a
	jmp ani6_b

ani6_b:
	push r2

	load r0, PosAnimacao
	loadn r1, #2
	sub r0, r0, r1
	loadn r1, #116

	call outchar2

	loadn r1, #10
	sub r0, r0, r1
	loadn r1, #116

	call outchar2

	load r1, iteracoesAnimacao

	inc r1
	store iteracoesAnimacao, r1

	load r0, PosAnimacao
	load r1, PacmanAnimacao

	call outchar2

	inc r0
	inc r0
	store PosAnimacao, r0

	loadn r2, #2912
	cmp r1, r2

	jeq	ani6_c
	jmp	ani6_d

ani6_c:
	loadn r1, #2916
	store PacmanAnimacao, r1
	
	dec r0
	dec r0

	loadn r2, #4
	sub r0, r0, r2

	loadn r1, #2412
	call outchar2

	loadn r2, #2
	sub r0, r0, r2

	loadn r1, #624
	call outchar2

	sub r0, r0, r2
	loadn r1, #3436
	call outchar2

	sub r0, r0, r2
	loadn r1, #1648
	call outchar2

	pop r2
	jmp animacao_fim


ani6_d:
	loadn r1, #2912
	store PacmanAnimacao, r1

	dec r0
	dec r0

	loadn r2, #4
	sub r0, r0, r2

	loadn r1, #2416
	call outchar2

	loadn r2, #2
	sub r0, r0, r2

	loadn r1, #620
	call outchar2

	sub r0, r0, r2
	loadn r1, #3440
	call outchar2

	sub r0, r0, r2
	loadn r1, #1644
	call outchar2

	pop r2
	jmp animacao_fim

ani6_a:
	loadn r1, #652
	store PosAnimacao, r1

	loadn r1, #0
	store iteracoesAnimacao, r1

	loadn r1, #8
	store estadoAnimacao, r1

	jmp animacao_fim
; -------- animacao7 -------


; -------- animacao8 -------
animacao8:
	loadn r0, #668
	loadn r1, #116
	call outchar2

	loadn r0, #670
	loadn r1, #1648
	call outchar2

	loadn r0, #672
	loadn r1, #3436
	call outchar2

	loadn r0, #674
	loadn r1, #624
	call outchar2

	loadn r0, #676
	loadn r1, #2412
	call outchar2

	loadn r0, #678
	loadn r1, #116
	call outchar2

	loadn r0, #9
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao8 -------


; -------- animacao9 -------
animacao9:

	loadn r0, #670
	loadn r1, #116
	call outchar2

	loadn r0, #672
	loadn r1, #1644
	call outchar2

	loadn r0, #674
	loadn r1, #3440
	call outchar2

	loadn r0, #676
	loadn r1, #620
	call outchar2

	loadn r0, #678
	loadn r1, #2416
	call outchar2

	loadn r0, #10
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao9 -------



; -------- animacao10 -------
animacao10:
	loadn r0, #672
	loadn r1, #116
	call outchar2

	loadn r0, #674
	loadn r1, #1648
	call outchar2

	loadn r0, #676
	loadn r1, #3436
	call outchar2

	loadn r0, #678
	loadn r1, #624
	call outchar2

	loadn r0, #11
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao10 -------


; -------- animacao11 -------
animacao11:
	loadn r0, #674
	loadn r1, #116
	call outchar2

	loadn r0, #676
	loadn r1, #1644
	call outchar2

	loadn r0, #678
	loadn r1, #3440
	call outchar2

	loadn r0, #12
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao11 -------


; -------- animacao12 -------
animacao12:
	loadn r0, #676
	loadn r1, #116
	call outchar2

	loadn r0, #678
	loadn r1, #1648
	call outchar2

	loadn r0, #0
	store estadoAnimacao, r0

	jmp animacao_fim
; -------- animacao12 -------




; ------- Imprime Tela ----------
ImprimeTelaInicial:
	push r0
	loadn r0, #MapaInicial
	call CarregaMapa
	pop r0
	rts
; ------- Imprime Tela ----------





; ------- Carrega Mapa ----------
; -- r0 deve estar com o endereco do mapa

CarregaMapa:
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	loadn r1, #0		; -- r1 = posicao na tela
	loadn r2, #1199	; -- r2 = tamanho da tela
	loadi r3, r0		; -- r3 = caracter que sera imprimido
BBB:
	outchar r3, r1
	cmp r1, r2			; -- se ja terminou de imprimir a tela inteira
	inc r1
	inc r0
	loadi r3, r0
	jne BBB

	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts

; ------- Carrega Mapa ----------



; ------- Olho Fantasma ----------
olho_fantasma:
	push r0
	push r1
	push r4

	load r0, PosicaoPacman

	loadn r1, #40
	mod r4, r0, r1

	loadn r1, #19
	cmp r4, r1
	jgr of_dir		; pacman esta na parte direita
	jmp of_esq		; pacman esta na parte esquerda

of_dir:
	loadn r1, #40
	div r4, r0, r1

	loadn r1, #14
	cmp r4, r1
	jgr of_dir_baixo	; pacman esta na parte de baixo
	jmp of_dir_cima		; pacman esta na parte de cima

of_dir_cima:	; olha para cima
	loadn r1, #1
	store estado_olho, r1
	call Blink
	jmp of_fim

of_dir_baixo:	; olha para baixo
	loadn r1, #2
	store estado_olho, r1
	call Blink
	jmp of_fim

of_esq:
	loadn r1, #40
	div r4, r0, r1

	loadn r1, #14
	cmp r4, r1
	jgr of_esq_baixo	; pacman esta na parte de baixo
	jmp of_esq_cima		; pacman esta na parte de cima

of_esq_cima:
	loadn r1, #0
	store estado_olho, r1
	call Blink
	jmp of_fim

of_esq_baixo:
	loadn r1, #3
	store estado_olho, r1
	call Blink
	jmp of_fim

of_fim:
	pop r4
	pop r1
	pop r0
	rts
; ------- Olho Fantasma ----------




; ---------- Blink --------------
Blink:
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	load r1, estado_olho
	loadn r2, #0

	cmp r1, r2
	jeq blink_a	; 0 - esq cima

	inc r2
	cmp r1, r2
	jeq blink_b ; 1 - dir cima

	inc r2
	cmp r1, r2
	jeq blink_c ; 2 - dir baixo

	inc r2
	cmp r1, r2
	jeq blink_d ; 3 - esq baixo

	jmp blink_a

blink_a:
	loadn r2, #blink
	jmp blink_p

blink_b:
	loadn r2, #blink2
	jmp blink_p

blink_c:
	loadn r2, #blink3
	jmp blink_p

blink_d:
	loadn r2, #blink4
	jmp blink_p


blink_p:
	loadn r1, #3
	loadn r3, #3
	loadn r5, #0
	loadn r6, #294 	; posicao do olho esq
	loadn r7, #40

push r2

blink_volta:

	cmp r5, r3
	jeq blink_dir

	push r2
	push r6

	loadi r4, r2		; r4 = caracter do olho
	outchar r4, r6	; desenha

	add r6, r6, r7	; prox linha
	add r2, r2, r1	; caracter correspondente

	loadi r4, r2		; r4 = caracter do olho
	outchar r4, r6	; desenha

	add r6, r6, r7	; prox linha
	add r2, r2, r1	; caracter correspondente

	loadi r4, r2		; r4 = caracter do olho
	outchar r4, r6	; desenha

	pop r6
	pop r2

	inc r2
	inc r5
	inc r6

	jmp blink_volta

blink_dir:
	pop r2
	loadn r5, #0
	loadn r6, #301 	; posicao do olho dir

blink_d2:
	cmp r5, r3
	jeq blink_fim

	push r2
	push r6

	loadi r4, r2		; r4 = caracter do olho
	outchar r4, r6	; desenha

	add r6, r6, r7	; prox linha
	add r2, r2, r1	; caracter correspondente

	loadi r4, r2		; r4 = caracter do olho
	outchar r4, r6	; desenha

	add r6, r6, r7	; prox linha
	add r2, r2, r1	; caracter correspondente

	loadi r4, r2		; r4 = caracter do olho
	outchar r4, r6	; desenha

	pop r6
	pop r2

	inc r2
	inc r5
	inc r6

	jmp blink_d2

blink_fim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts


; ---------- Blink --------------

; esq para cima
blink : var #9
static blink + #0, #' '
static blink + #1, #' '
static blink + #2, #91
static blink + #3, #' '
static blink + #4, #' '
static blink + #5, #91
static blink + #6, #91
static blink + #7, #91
static blink + #8, #91



; direita para cima
blink2 : var #9
static blink2 + #0, #91
static blink2 + #1, #' '
static blink2 + #2, #' '
static blink2 + #3, #91
static blink2 + #4, #' '
static blink2 + #5, #' '
static blink2 + #6, #91
static blink2 + #7, #91
static blink2 + #8, #91



; direita para baixo
blink3 : var #9
static blink3 + #0, #91
static blink3 + #1, #91
static blink3 + #2, #91
static blink3 + #3, #91
static blink3 + #4, #' '
static blink3 + #5, #' '
static blink3 + #6, #91
static blink3 + #7, #' '
static blink3 + #8, #' '


; esq para baixo
blink4 : var #9
static blink4 + #0, #91
static blink4 + #1, #91
static blink4 + #2, #91
static blink4 + #3, #' '
static blink4 + #4, #' '
static blink4 + #5, #91
static blink4 + #6, #' '
static blink4 + #7, #' '
static blink4 + #8, #91




; ------- movimenta_fantasmao ---------
movimenta_fantasmao:
	push r2
	push r3

	load r2, contadorFantasmao
	loadn r3, #100
	cmp r2, r3
	jeq mf_mov
	jmp mf_fim

mf_mov:
	load r3, estadoFantasmao
	loadn r2, #0
	cmp r2, r3
	jeq mf_a
	jmp mf_b

mf_a:
	loadn r2, #1
	store estadoFantasmao, r2
	call MudaPosicao2
	loadn r2, #0
	jmp mf_fim

mf_b:
	loadn r2, #0
	store estadoFantasmao, r2
	call MudaPosicao1
	loadn r2, #0
	jmp mf_fim

mf_fim:
	inc r2
	store contadorFantasmao, r2
	pop r3
	pop r2
	rts
; ------- movimenta_fantasmao ---------





; ------- MudaPosicao1 ------------
MudaPosicao1:
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	loadn r2, #Posicao1
	loadn r3, #20
	loadn r5, #0
	loadn r6, #770
	loadn r7, #40

MP1_volta1:
	cmp r5, r3
	jeq MP1_fim

	push r2
	push r6

	loadi r4, r2
	outchar r4, r6

	add r6, r6, r7
	add r2, r2, r3

	loadi r4, r2
	outchar r4, r6

	add r6, r6, r7
	add r2, r2, r3

	loadi r4, r2
	outchar r4, r6

	pop r6
	pop r2

	inc r2
	inc r5
	inc r6
	jmp MP1_volta1

MP1_fim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	rts

; ------- MudaPosicao1 ------------



; ------- MudaPosicao2 ------------
MudaPosicao2:
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7

	loadn r2, #Posicao2
	loadn r3, #20
	loadn r5, #0
	loadn r6, #770
	loadn r7, #40

MP2_volta1:
	cmp r5, r3
	jeq MP2_fim

	push r2
	push r6

	loadi r4, r2
	outchar r4, r6

	add r2, r2, r3
	add r6, r6, r7

	loadi r4, r2
	outchar r4, r6

	add r2, r2, r3
	add r6, r6, r7

	loadi r4, r2
	outchar r4, r6

	pop r6
	pop r2

	inc r2
	inc r5
	inc r6

	jmp MP2_volta1

MP2_fim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	rts

; ------- MudaPosicao2 ------------




delay_kamada:
	push r0
	push r1
	
	loadn r0, #0
	load r1, fantasmaEstaDoente	
	cmp r0, r1
	jne delay_kamada_fim

	loadn r1, #300
	
delay_kamada_volta:
	cmp r0, r1
	jeq delay_kamada_fim
	inc r0
	jmp delay_kamada_volta
delay_kamada_fim:
	pop r1
	pop r0
	rts
	









; ---------- Posicao 1 -----------
Posicao1 : var #60

; linha 1 - estado 1
static Posicao1 + #0, #2395
static Posicao1 + #1, #2395
static Posicao1 + #2, #2395
static Posicao1 + #3, #' '
static Posicao1 + #4, #2395
static Posicao1 + #5, #2395
static Posicao1 + #6, #' '
static Posicao1 + #7, #2395
static Posicao1 + #8, #2395
static Posicao1 + #9, #' '
static Posicao1 + #10, #' '
static Posicao1 + #11, #2395
static Posicao1 + #12, #2395
static Posicao1 + #13, #' '
static Posicao1 + #14, #2395
static Posicao1 + #15, #2395
static Posicao1 + #16, #' '
static Posicao1 + #17, #2395
static Posicao1 + #18, #2395
static Posicao1 + #19, #2395

; linha 2 - estado 1
static Posicao1 + #20, #2395
static Posicao1 + #21, #2395
static Posicao1 + #22, #' '
static Posicao1 + #23, #' '
static Posicao1 + #24, #2395
static Posicao1 + #25, #' '
static Posicao1 + #26, #' '
static Posicao1 + #27, #' '
static Posicao1 + #28, #2395
static Posicao1 + #29, #' '
static Posicao1 + #30, #' '
static Posicao1 + #31, #2395
static Posicao1 + #32, #' '
static Posicao1 + #33, #' '
static Posicao1 + #34, #' '
static Posicao1 + #35, #2395
static Posicao1 + #36, #' '
static Posicao1 + #37, #' '
static Posicao1 + #38, #2395
static Posicao1 + #39, #2395

; linha 3 - estado 1
static Posicao1 + #40, #2395
static Posicao1 + #41, #' '
static Posicao1 + #42, #' '
static Posicao1 + #43, #' '
static Posicao1 + #44, #' '
static Posicao1 + #45, #' '
static Posicao1 + #46, #' '
static Posicao1 + #47, #' '
static Posicao1 + #48, #' '
static Posicao1 + #49, #' '
static Posicao1 + #50, #' '
static Posicao1 + #51, #' '
static Posicao1 + #52, #' '
static Posicao1 + #53, #' '
static Posicao1 + #54, #' '
static Posicao1 + #55, #' '
static Posicao1 + #56, #' '
static Posicao1 + #57, #' '
static Posicao1 + #58, #' '
static Posicao1 + #59, #2395
; ---------- Posicao 1 -----------





; ---------- Posicao 2 -----------
Posicao2 : var #60

; linha 1 - estado 2
static Posicao2 + #0, #2395
static Posicao2 + #1, #2395
static Posicao2 + #2, #2395
static Posicao2 + #3, #2395
static Posicao2 + #4, #2395
static Posicao2 + #5, #2395
static Posicao2 + #6, #2395
static Posicao2 + #7, #2395
static Posicao2 + #8, #2395
static Posicao2 + #9, #2395
static Posicao2 + #10, #2395
static Posicao2 + #11, #2395
static Posicao2 + #12, #2395
static Posicao2 + #13, #2395
static Posicao2 + #14, #2395
static Posicao2 + #15, #2395
static Posicao2 + #16, #2395
static Posicao2 + #17, #2395
static Posicao2 + #18, #2395
static Posicao2 + #19, #2395

; linha 2 - estado 2
static Posicao2 + #20, #2395
static Posicao2 + #21, #2395
static Posicao2 + #22, #' '
static Posicao2 + #23, #2395
static Posicao2 + #24, #2395
static Posicao2 + #25, #' '
static Posicao2 + #26, #' '
static Posicao2 + #27, #2395
static Posicao2 + #28, #2395
static Posicao2 + #29, #' '
static Posicao2 + #30, #' '
static Posicao2 + #31, #2395
static Posicao2 + #32, #2395
static Posicao2 + #33, #' '
static Posicao2 + #34, #' '
static Posicao2 + #35, #2395
static Posicao2 + #36, #2395
static Posicao2 + #37, #' '
static Posicao2 + #38, #2395
static Posicao2 + #39, #2395

; linha 3 - estado 2
static Posicao2 + #40, #2395
static Posicao2 + #41, #' '
static Posicao2 + #42, #' '
static Posicao2 + #43, #' '
static Posicao2 + #44, #2395
static Posicao2 + #45, #' '
static Posicao2 + #46, #' '
static Posicao2 + #47, #2395
static Posicao2 + #48, #' '
static Posicao2 + #49, #' '
static Posicao2 + #50, #' '
static Posicao2 + #51, #' '
static Posicao2 + #52, #2395
static Posicao2 + #53, #' '
static Posicao2 + #54, #' '
static Posicao2 + #55, #2395
static Posicao2 + #56, #' '
static Posicao2 + #57, #' '
static Posicao2 + #58, #' '
static Posicao2 + #59, #2395

; ---------- Posicao 2 -----------




; ------- fantasma doente ------------
fantasmaDoente:
	push r3
	push r4
	push r5
	push r6
	push r7

	loadn r3, #14
	loadn r5, #0
	loadn r6, #213

FD_volta1:
	cmp r5, r3
	jeq FD_a

	loadi r4, r2
	outchar r4, r6

	inc r2
	inc r5
	inc r6

	jmp FD_volta1

FD_a:
	loadn r3, #16
	loadn r5, #0
	loadn r6, #252

FD_volta2:
	cmp r5, r3
	jeq FD_b

	loadi r4, r2
	outchar r4, r6

	inc r2
	inc r5
	inc r6

	jmp FD_volta2

FD_b:
	loadn r3, #20
	loadn r5, #0
	loadn r6, #290
	loadn r7, #40

FD_volta3:
	cmp r5, r3
	jeq FD_fim

	push r2
	push r6

	loadi r4, r2
	outchar r4, r6

	call FD_aux
	call FD_aux
	call FD_aux
	call FD_aux
	call FD_aux

	call FD_aux
	call FD_aux
	call FD_aux
	call FD_aux
	call FD_aux

	call FD_aux
	call FD_aux
	call FD_aux
	call FD_aux

	pop r6
	pop r2

	inc r2
	inc r5
	inc r6

	jmp FD_volta3

FD_fim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	rts


FD_aux:
	add r2, r2, r3
	add r6, r6, r7

	loadi r4, r2
	outchar r4, r6
	rts

; ------- fantasma doente ------------



; ------- Fantasma Doente -------
FantasmaDoente : var #330

static FantasmaDoente + #0, #91
static FantasmaDoente + #1, #91
static FantasmaDoente + #2, #91
static FantasmaDoente + #3, #91
static FantasmaDoente + #4, #91
static FantasmaDoente + #5, #91
static FantasmaDoente + #6, #91
static FantasmaDoente + #7, #91
static FantasmaDoente + #8, #91
static FantasmaDoente + #9, #91
static FantasmaDoente + #10, #91
static FantasmaDoente + #11, #91
static FantasmaDoente + #12, #91
static FantasmaDoente + #13, #91
static FantasmaDoente + #14, #91
static FantasmaDoente + #15, #91
static FantasmaDoente + #16, #91
static FantasmaDoente + #17, #91
static FantasmaDoente + #18, #91
static FantasmaDoente + #19, #91
static FantasmaDoente + #20, #91
static FantasmaDoente + #21, #91
static FantasmaDoente + #22, #91
static FantasmaDoente + #23, #91
static FantasmaDoente + #24, #91
static FantasmaDoente + #25, #91
static FantasmaDoente + #26, #91
static FantasmaDoente + #27, #91
static FantasmaDoente + #28, #91
static FantasmaDoente + #29, #91
static FantasmaDoente + #30, #91
static FantasmaDoente + #31, #91
static FantasmaDoente + #32, #91
static FantasmaDoente + #33, #91
static FantasmaDoente + #34, #' '
static FantasmaDoente + #35, #' '
static FantasmaDoente + #36, #' '
static FantasmaDoente + #37, #91
static FantasmaDoente + #38, #91
static FantasmaDoente + #39, #91
static FantasmaDoente + #40, #91
static FantasmaDoente + #41, #91
static FantasmaDoente + #42, #91
static FantasmaDoente + #43, #' '
static FantasmaDoente + #44, #' '
static FantasmaDoente + #45, #' '
static FantasmaDoente + #46, #91
static FantasmaDoente + #47, #91
static FantasmaDoente + #48, #91
static FantasmaDoente + #49, #91
static FantasmaDoente + #50, #91
static FantasmaDoente + #51, #91
static FantasmaDoente + #52, #91
static FantasmaDoente + #53, #91
static FantasmaDoente + #54, #' '
static FantasmaDoente + #55, #' '
static FantasmaDoente + #56, #' '
static FantasmaDoente + #57, #91
static FantasmaDoente + #58, #91
static FantasmaDoente + #59, #91
static FantasmaDoente + #60, #91
static FantasmaDoente + #61, #91
static FantasmaDoente + #62, #91
static FantasmaDoente + #63, #' '
static FantasmaDoente + #64, #' '
static FantasmaDoente + #65, #' '
static FantasmaDoente + #66, #91
static FantasmaDoente + #67, #91
static FantasmaDoente + #68, #91
static FantasmaDoente + #69, #91
static FantasmaDoente + #70, #91
static FantasmaDoente + #71, #91
static FantasmaDoente + #72, #91
static FantasmaDoente + #73, #91
static FantasmaDoente + #74, #' '
static FantasmaDoente + #75, #' '
static FantasmaDoente + #76, #' '
static FantasmaDoente + #77, #91
static FantasmaDoente + #78, #91
static FantasmaDoente + #79, #91
static FantasmaDoente + #80, #91
static FantasmaDoente + #81, #91
static FantasmaDoente + #82, #91
static FantasmaDoente + #83, #' '
static FantasmaDoente + #84, #' '
static FantasmaDoente + #85, #' '
static FantasmaDoente + #86, #91
static FantasmaDoente + #87, #91
static FantasmaDoente + #88, #91
static FantasmaDoente + #89, #91
static FantasmaDoente + #90, #91
static FantasmaDoente + #91, #91
static FantasmaDoente + #92, #91
static FantasmaDoente + #93, #91
static FantasmaDoente + #94, #91
static FantasmaDoente + #95, #91
static FantasmaDoente + #96, #91
static FantasmaDoente + #97, #91
static FantasmaDoente + #98, #91
static FantasmaDoente + #99, #91
static FantasmaDoente + #100, #91
static FantasmaDoente + #101, #91
static FantasmaDoente + #102, #91
static FantasmaDoente + #103, #91
static FantasmaDoente + #104, #91
static FantasmaDoente + #105, #91
static FantasmaDoente + #106, #91
static FantasmaDoente + #107, #91
static FantasmaDoente + #108, #91
static FantasmaDoente + #109, #91
static FantasmaDoente + #110, #91
static FantasmaDoente + #111, #91
static FantasmaDoente + #112, #91
static FantasmaDoente + #113, #91
static FantasmaDoente + #114, #91
static FantasmaDoente + #115, #91
static FantasmaDoente + #116, #91
static FantasmaDoente + #117, #91
static FantasmaDoente + #118, #91
static FantasmaDoente + #119, #91
static FantasmaDoente + #120, #91
static FantasmaDoente + #121, #91
static FantasmaDoente + #122, #91
static FantasmaDoente + #123, #91
static FantasmaDoente + #124, #91
static FantasmaDoente + #125, #91
static FantasmaDoente + #126, #91
static FantasmaDoente + #127, #91
static FantasmaDoente + #128, #91
static FantasmaDoente + #129, #91
static FantasmaDoente + #130, #91
static FantasmaDoente + #131, #91
static FantasmaDoente + #132, #91
static FantasmaDoente + #133, #91
static FantasmaDoente + #134, #91
static FantasmaDoente + #135, #91
static FantasmaDoente + #136, #91
static FantasmaDoente + #137, #91
static FantasmaDoente + #138, #91
static FantasmaDoente + #139, #91
static FantasmaDoente + #140, #91
static FantasmaDoente + #141, #91
static FantasmaDoente + #142, #91
static FantasmaDoente + #143, #91
static FantasmaDoente + #144, #91
static FantasmaDoente + #145, #91
static FantasmaDoente + #146, #91
static FantasmaDoente + #147, #91
static FantasmaDoente + #148, #91
static FantasmaDoente + #149, #91
static FantasmaDoente + #150, #91
static FantasmaDoente + #151, #91
static FantasmaDoente + #152, #91
static FantasmaDoente + #153, #91
static FantasmaDoente + #154, #91
static FantasmaDoente + #155, #91
static FantasmaDoente + #156, #91
static FantasmaDoente + #157, #91
static FantasmaDoente + #158, #91
static FantasmaDoente + #159, #91
static FantasmaDoente + #160, #91
static FantasmaDoente + #161, #91
static FantasmaDoente + #162, #91
static FantasmaDoente + #163, #91
static FantasmaDoente + #164, #91
static FantasmaDoente + #165, #91
static FantasmaDoente + #166, #91
static FantasmaDoente + #167, #91
static FantasmaDoente + #168, #91
static FantasmaDoente + #169, #91
static FantasmaDoente + #170, #91
static FantasmaDoente + #171, #91
static FantasmaDoente + #172, #91
static FantasmaDoente + #173, #91
static FantasmaDoente + #174, #91
static FantasmaDoente + #175, #' '
static FantasmaDoente + #176, #' '
static FantasmaDoente + #177, #' '
static FantasmaDoente + #178, #' '
static FantasmaDoente + #179, #' '
static FantasmaDoente + #180, #' '
static FantasmaDoente + #181, #' '
static FantasmaDoente + #182, #' '
static FantasmaDoente + #183, #' '
static FantasmaDoente + #184, #' '
static FantasmaDoente + #185, #91
static FantasmaDoente + #186, #91
static FantasmaDoente + #187, #91
static FantasmaDoente + #188, #91
static FantasmaDoente + #189, #91
static FantasmaDoente + #190, #91
static FantasmaDoente + #191, #91
static FantasmaDoente + #192, #91
static FantasmaDoente + #193, #91
static FantasmaDoente + #194, #91
static FantasmaDoente + #195, #' '
static FantasmaDoente + #196, #' '
static FantasmaDoente + #197, #' '
static FantasmaDoente + #198, #' '
static FantasmaDoente + #199, #' '
static FantasmaDoente + #200, #' '
static FantasmaDoente + #201, #' '
static FantasmaDoente + #202, #' '
static FantasmaDoente + #203, #' '
static FantasmaDoente + #204, #' '
static FantasmaDoente + #205, #91
static FantasmaDoente + #206, #91
static FantasmaDoente + #207, #91
static FantasmaDoente + #208, #91
static FantasmaDoente + #209, #91
static FantasmaDoente + #210, #91
static FantasmaDoente + #211, #91
static FantasmaDoente + #212, #91
static FantasmaDoente + #213, #91
static FantasmaDoente + #214, #91
static FantasmaDoente + #215, #' '
static FantasmaDoente + #216, #' '
static FantasmaDoente + #217, #' '
static FantasmaDoente + #218, #' '
static FantasmaDoente + #219, #' '
static FantasmaDoente + #220, #' '
static FantasmaDoente + #221, #' '
static FantasmaDoente + #222, #' '
static FantasmaDoente + #223, #' '
static FantasmaDoente + #224, #' '
static FantasmaDoente + #225, #91
static FantasmaDoente + #226, #91
static FantasmaDoente + #227, #91
static FantasmaDoente + #228, #91
static FantasmaDoente + #229, #91
static FantasmaDoente + #230, #91
static FantasmaDoente + #231, #91
static FantasmaDoente + #232, #91
static FantasmaDoente + #233, #91
static FantasmaDoente + #234, #91
static FantasmaDoente + #235, #' '
static FantasmaDoente + #236, #' '
static FantasmaDoente + #237, #' '
static FantasmaDoente + #238, #' '
static FantasmaDoente + #239, #' '
static FantasmaDoente + #240, #' '
static FantasmaDoente + #241, #' '
static FantasmaDoente + #242, #' '
static FantasmaDoente + #243, #' '
static FantasmaDoente + #244, #' '
static FantasmaDoente + #245, #91
static FantasmaDoente + #246, #91
static FantasmaDoente + #247, #91
static FantasmaDoente + #248, #91
static FantasmaDoente + #249, #91
static FantasmaDoente + #250, #91
static FantasmaDoente + #251, #91
static FantasmaDoente + #252, #91
static FantasmaDoente + #253, #91
static FantasmaDoente + #254, #91
static FantasmaDoente + #255, #91
static FantasmaDoente + #256, #91
static FantasmaDoente + #257, #91
static FantasmaDoente + #258, #91
static FantasmaDoente + #259, #91
static FantasmaDoente + #260, #91
static FantasmaDoente + #261, #91
static FantasmaDoente + #262, #91
static FantasmaDoente + #263, #91
static FantasmaDoente + #264, #91
static FantasmaDoente + #265, #91
static FantasmaDoente + #266, #91
static FantasmaDoente + #267, #91
static FantasmaDoente + #268, #91
static FantasmaDoente + #269, #91
static FantasmaDoente + #270, #91
static FantasmaDoente + #271, #91
static FantasmaDoente + #272, #91
static FantasmaDoente + #273, #91
static FantasmaDoente + #274, #91
static FantasmaDoente + #275, #91
static FantasmaDoente + #276, #91
static FantasmaDoente + #277, #91
static FantasmaDoente + #278, #91
static FantasmaDoente + #279, #91
static FantasmaDoente + #280, #91
static FantasmaDoente + #281, #91
static FantasmaDoente + #282, #91
static FantasmaDoente + #283, #91
static FantasmaDoente + #284, #91
static FantasmaDoente + #285, #91
static FantasmaDoente + #286, #91
static FantasmaDoente + #287, #91
static FantasmaDoente + #288, #91
static FantasmaDoente + #289, #91
static FantasmaDoente + #290, #91
static FantasmaDoente + #291, #91
static FantasmaDoente + #292, #' '
static FantasmaDoente + #293, #91
static FantasmaDoente + #294, #91
static FantasmaDoente + #295, #' '
static FantasmaDoente + #296, #' '
static FantasmaDoente + #297, #91
static FantasmaDoente + #298, #91
static FantasmaDoente + #299, #' '
static FantasmaDoente + #300, #' '
static FantasmaDoente + #301, #91
static FantasmaDoente + #302, #91
static FantasmaDoente + #303, #' '
static FantasmaDoente + #304, #' '
static FantasmaDoente + #305, #91
static FantasmaDoente + #306, #91
static FantasmaDoente + #307, #' '
static FantasmaDoente + #308, #91
static FantasmaDoente + #309, #91
static FantasmaDoente + #310, #91
static FantasmaDoente + #311, #' '
static FantasmaDoente + #312, #' '
static FantasmaDoente + #313, #' '
static FantasmaDoente + #314, #91
static FantasmaDoente + #315, #' '
static FantasmaDoente + #316, #' '
static FantasmaDoente + #317, #91
static FantasmaDoente + #318, #' '
static FantasmaDoente + #319, #' '
static FantasmaDoente + #320, #' '
static FantasmaDoente + #321, #' '
static FantasmaDoente + #322, #91
static FantasmaDoente + #323, #' '
static FantasmaDoente + #324, #' '
static FantasmaDoente + #325, #91
static FantasmaDoente + #326, #' '
static FantasmaDoente + #327, #' '
static FantasmaDoente + #328, #' '
static FantasmaDoente + #329, #91

; ------- Fantasma Doente -------




; ----- Fantasma Saudavel -------
FantasmaSaudavel : var #330

static FantasmaSaudavel + #0, #2395
static FantasmaSaudavel + #1, #2395
static FantasmaSaudavel + #2, #2395
static FantasmaSaudavel + #3, #2395
static FantasmaSaudavel + #4, #2395
static FantasmaSaudavel + #5, #2395
static FantasmaSaudavel + #6, #2395
static FantasmaSaudavel + #7, #2395
static FantasmaSaudavel + #8, #2395
static FantasmaSaudavel + #9, #2395
static FantasmaSaudavel + #10, #2395
static FantasmaSaudavel + #11, #2395
static FantasmaSaudavel + #12, #2395
static FantasmaSaudavel + #13, #2395
static FantasmaSaudavel + #14, #2395
static FantasmaSaudavel + #15, #2395
static FantasmaSaudavel + #16, #2395
static FantasmaSaudavel + #17, #2395
static FantasmaSaudavel + #18, #2395
static FantasmaSaudavel + #19, #2395
static FantasmaSaudavel + #20, #2395
static FantasmaSaudavel + #21, #2395
static FantasmaSaudavel + #22, #2395
static FantasmaSaudavel + #23, #2395
static FantasmaSaudavel + #24, #2395
static FantasmaSaudavel + #25, #2395
static FantasmaSaudavel + #26, #2395
static FantasmaSaudavel + #27, #2395
static FantasmaSaudavel + #28, #2395
static FantasmaSaudavel + #29, #2395
static FantasmaSaudavel + #30, #2395
static FantasmaSaudavel + #31, #2395
static FantasmaSaudavel + #32, #2395
static FantasmaSaudavel + #33, #2395
static FantasmaSaudavel + #34, #' '
static FantasmaSaudavel + #35, #' '
static FantasmaSaudavel + #36, #91
static FantasmaSaudavel + #37, #2395
static FantasmaSaudavel + #38, #2395
static FantasmaSaudavel + #39, #2395
static FantasmaSaudavel + #40, #2395
static FantasmaSaudavel + #41, #' '
static FantasmaSaudavel + #42, #' '
static FantasmaSaudavel + #43, #91
static FantasmaSaudavel + #44, #2395
static FantasmaSaudavel + #45, #2395
static FantasmaSaudavel + #46, #2395
static FantasmaSaudavel + #47, #2395
static FantasmaSaudavel + #48, #2395
static FantasmaSaudavel + #49, #2395
static FantasmaSaudavel + #50, #2395
static FantasmaSaudavel + #51, #2395
static FantasmaSaudavel + #52, #2395
static FantasmaSaudavel + #53, #2395
static FantasmaSaudavel + #54, #' '
static FantasmaSaudavel + #55, #' '
static FantasmaSaudavel + #56, #91
static FantasmaSaudavel + #57, #2395
static FantasmaSaudavel + #58, #2395
static FantasmaSaudavel + #59, #2395
static FantasmaSaudavel + #60, #2395
static FantasmaSaudavel + #61, #' '
static FantasmaSaudavel + #62, #' '
static FantasmaSaudavel + #63, #91
static FantasmaSaudavel + #64, #2395
static FantasmaSaudavel + #65, #2395
static FantasmaSaudavel + #66, #2395
static FantasmaSaudavel + #67, #2395
static FantasmaSaudavel + #68, #2395
static FantasmaSaudavel + #69, #2395
static FantasmaSaudavel + #70, #2395
static FantasmaSaudavel + #71, #2395
static FantasmaSaudavel + #72, #2395
static FantasmaSaudavel + #73, #2395
static FantasmaSaudavel + #74, #91
static FantasmaSaudavel + #75, #91
static FantasmaSaudavel + #76, #91
static FantasmaSaudavel + #77, #2395
static FantasmaSaudavel + #78, #2395
static FantasmaSaudavel + #79, #2395
static FantasmaSaudavel + #80, #2395
static FantasmaSaudavel + #81, #91
static FantasmaSaudavel + #82, #91
static FantasmaSaudavel + #83, #91
static FantasmaSaudavel + #84, #2395
static FantasmaSaudavel + #85, #2395
static FantasmaSaudavel + #86, #2395
static FantasmaSaudavel + #87, #2395
static FantasmaSaudavel + #88, #2395
static FantasmaSaudavel + #89, #2395
static FantasmaSaudavel + #90, #2395
static FantasmaSaudavel + #91, #2395
static FantasmaSaudavel + #92, #2395
static FantasmaSaudavel + #93, #2395
static FantasmaSaudavel + #94, #2395
static FantasmaSaudavel + #95, #2395
static FantasmaSaudavel + #96, #2395
static FantasmaSaudavel + #97, #2395
static FantasmaSaudavel + #98, #2395
static FantasmaSaudavel + #99, #2395
static FantasmaSaudavel + #100, #2395
static FantasmaSaudavel + #101, #2395
static FantasmaSaudavel + #102, #2395
static FantasmaSaudavel + #103, #2395
static FantasmaSaudavel + #104, #2395
static FantasmaSaudavel + #105, #2395
static FantasmaSaudavel + #106, #2395
static FantasmaSaudavel + #107, #2395
static FantasmaSaudavel + #108, #2395
static FantasmaSaudavel + #109, #2395
static FantasmaSaudavel + #110, #2395
static FantasmaSaudavel + #111, #2395
static FantasmaSaudavel + #112, #2395
static FantasmaSaudavel + #113, #2395
static FantasmaSaudavel + #114, #2395
static FantasmaSaudavel + #115, #2395
static FantasmaSaudavel + #116, #2395
static FantasmaSaudavel + #117, #2395
static FantasmaSaudavel + #118, #2395
static FantasmaSaudavel + #119, #2395
static FantasmaSaudavel + #120, #2395
static FantasmaSaudavel + #121, #2395
static FantasmaSaudavel + #122, #2395
static FantasmaSaudavel + #123, #2395
static FantasmaSaudavel + #124, #2395
static FantasmaSaudavel + #125, #2395
static FantasmaSaudavel + #126, #2395
static FantasmaSaudavel + #127, #2395
static FantasmaSaudavel + #128, #2395
static FantasmaSaudavel + #129, #2395
static FantasmaSaudavel + #130, #2395
static FantasmaSaudavel + #131, #2395
static FantasmaSaudavel + #132, #2395
static FantasmaSaudavel + #133, #2395
static FantasmaSaudavel + #134, #2395
static FantasmaSaudavel + #135, #2395
static FantasmaSaudavel + #136, #2395
static FantasmaSaudavel + #137, #2395
static FantasmaSaudavel + #138, #2395
static FantasmaSaudavel + #139, #2395
static FantasmaSaudavel + #140, #2395
static FantasmaSaudavel + #141, #2395
static FantasmaSaudavel + #142, #2395
static FantasmaSaudavel + #143, #2395
static FantasmaSaudavel + #144, #2395
static FantasmaSaudavel + #145, #2395
static FantasmaSaudavel + #146, #2395
static FantasmaSaudavel + #147, #2395
static FantasmaSaudavel + #148, #2395
static FantasmaSaudavel + #149, #2395
static FantasmaSaudavel + #150, #2395
static FantasmaSaudavel + #151, #2395
static FantasmaSaudavel + #152, #2395
static FantasmaSaudavel + #153, #2395
static FantasmaSaudavel + #154, #2395
static FantasmaSaudavel + #155, #2395
static FantasmaSaudavel + #156, #2395
static FantasmaSaudavel + #157, #2395
static FantasmaSaudavel + #158, #2395
static FantasmaSaudavel + #159, #2395
static FantasmaSaudavel + #160, #2395
static FantasmaSaudavel + #161, #2395
static FantasmaSaudavel + #162, #2395
static FantasmaSaudavel + #163, #2395
static FantasmaSaudavel + #164, #2395
static FantasmaSaudavel + #165, #2395
static FantasmaSaudavel + #166, #2395
static FantasmaSaudavel + #167, #2395
static FantasmaSaudavel + #168, #2395
static FantasmaSaudavel + #169, #2395
static FantasmaSaudavel + #170, #2395
static FantasmaSaudavel + #171, #2395
static FantasmaSaudavel + #172, #2395
static FantasmaSaudavel + #173, #2395
static FantasmaSaudavel + #174, #2395
static FantasmaSaudavel + #175, #2395
static FantasmaSaudavel + #176, #2395
static FantasmaSaudavel + #177, #2395
static FantasmaSaudavel + #178, #2395
static FantasmaSaudavel + #179, #2395
static FantasmaSaudavel + #180, #2395
static FantasmaSaudavel + #181, #2395
static FantasmaSaudavel + #182, #2395
static FantasmaSaudavel + #183, #2395
static FantasmaSaudavel + #184, #2395
static FantasmaSaudavel + #185, #2395
static FantasmaSaudavel + #186, #2395
static FantasmaSaudavel + #187, #2395
static FantasmaSaudavel + #188, #2395
static FantasmaSaudavel + #189, #2395
static FantasmaSaudavel + #190, #2395
static FantasmaSaudavel + #191, #2395
static FantasmaSaudavel + #192, #2395
static FantasmaSaudavel + #193, #2395
static FantasmaSaudavel + #194, #2395
static FantasmaSaudavel + #195, #2395
static FantasmaSaudavel + #196, #2395
static FantasmaSaudavel + #197, #2395
static FantasmaSaudavel + #198, #2395
static FantasmaSaudavel + #199, #2395
static FantasmaSaudavel + #200, #2395
static FantasmaSaudavel + #201, #2395
static FantasmaSaudavel + #202, #2395
static FantasmaSaudavel + #203, #2395
static FantasmaSaudavel + #204, #2395
static FantasmaSaudavel + #205, #2395
static FantasmaSaudavel + #206, #2395
static FantasmaSaudavel + #207, #2395
static FantasmaSaudavel + #208, #2395
static FantasmaSaudavel + #209, #2395
static FantasmaSaudavel + #210, #2395
static FantasmaSaudavel + #211, #2395
static FantasmaSaudavel + #212, #2395
static FantasmaSaudavel + #213, #2395
static FantasmaSaudavel + #214, #2395
static FantasmaSaudavel + #215, #2395
static FantasmaSaudavel + #216, #2395
static FantasmaSaudavel + #217, #2395
static FantasmaSaudavel + #218, #2395
static FantasmaSaudavel + #219, #2395
static FantasmaSaudavel + #220, #2395
static FantasmaSaudavel + #221, #2395
static FantasmaSaudavel + #222, #2395
static FantasmaSaudavel + #223, #2395
static FantasmaSaudavel + #224, #2395
static FantasmaSaudavel + #225, #2395
static FantasmaSaudavel + #226, #2395
static FantasmaSaudavel + #227, #2395
static FantasmaSaudavel + #228, #2395
static FantasmaSaudavel + #229, #2395
static FantasmaSaudavel + #230, #2395
static FantasmaSaudavel + #231, #2395
static FantasmaSaudavel + #232, #2395
static FantasmaSaudavel + #233, #2395
static FantasmaSaudavel + #234, #2395
static FantasmaSaudavel + #235, #2395
static FantasmaSaudavel + #236, #2395
static FantasmaSaudavel + #237, #2395
static FantasmaSaudavel + #238, #2395
static FantasmaSaudavel + #239, #2395
static FantasmaSaudavel + #240, #2395
static FantasmaSaudavel + #241, #2395
static FantasmaSaudavel + #242, #2395
static FantasmaSaudavel + #243, #2395
static FantasmaSaudavel + #244, #2395
static FantasmaSaudavel + #245, #2395
static FantasmaSaudavel + #246, #2395
static FantasmaSaudavel + #247, #2395
static FantasmaSaudavel + #248, #2395
static FantasmaSaudavel + #249, #2395
static FantasmaSaudavel + #250, #2395
static FantasmaSaudavel + #251, #2395
static FantasmaSaudavel + #252, #2395
static FantasmaSaudavel + #253, #2395
static FantasmaSaudavel + #254, #2395
static FantasmaSaudavel + #255, #2395
static FantasmaSaudavel + #256, #2395
static FantasmaSaudavel + #257, #2395
static FantasmaSaudavel + #258, #2395
static FantasmaSaudavel + #259, #2395
static FantasmaSaudavel + #260, #2395
static FantasmaSaudavel + #261, #2395
static FantasmaSaudavel + #262, #2395
static FantasmaSaudavel + #263, #2395
static FantasmaSaudavel + #264, #2395
static FantasmaSaudavel + #265, #2395
static FantasmaSaudavel + #266, #2395
static FantasmaSaudavel + #267, #2395
static FantasmaSaudavel + #268, #2395
static FantasmaSaudavel + #269, #2395
static FantasmaSaudavel + #270, #2395
static FantasmaSaudavel + #271, #2395
static FantasmaSaudavel + #272, #2395
static FantasmaSaudavel + #273, #' '
static FantasmaSaudavel + #274, #2395
static FantasmaSaudavel + #275, #2395
static FantasmaSaudavel + #276, #' '
static FantasmaSaudavel + #277, #2395
static FantasmaSaudavel + #278, #2395
static FantasmaSaudavel + #279, #' '
static FantasmaSaudavel + #280, #' '
static FantasmaSaudavel + #281, #2395
static FantasmaSaudavel + #282, #2395
static FantasmaSaudavel + #283, #' '
static FantasmaSaudavel + #284, #2395
static FantasmaSaudavel + #285, #2395
static FantasmaSaudavel + #286, #' '
static FantasmaSaudavel + #287, #2395
static FantasmaSaudavel + #288, #2395
static FantasmaSaudavel + #289, #2395
static FantasmaSaudavel + #290, #2395
static FantasmaSaudavel + #291, #2395
static FantasmaSaudavel + #292, #' '
static FantasmaSaudavel + #293, #' '
static FantasmaSaudavel + #294, #2395
static FantasmaSaudavel + #295, #' '
static FantasmaSaudavel + #296, #' '
static FantasmaSaudavel + #297, #' '
static FantasmaSaudavel + #298, #2395
static FantasmaSaudavel + #299, #' '
static FantasmaSaudavel + #300, #' '
static FantasmaSaudavel + #301, #2395
static FantasmaSaudavel + #302, #' '
static FantasmaSaudavel + #303, #' '
static FantasmaSaudavel + #304, #' '
static FantasmaSaudavel + #305, #2395
static FantasmaSaudavel + #306, #' '
static FantasmaSaudavel + #307, #' '
static FantasmaSaudavel + #308, #2395
static FantasmaSaudavel + #309, #2395
static FantasmaSaudavel + #310, #2395
static FantasmaSaudavel + #311, #' '
static FantasmaSaudavel + #312, #' '
static FantasmaSaudavel + #313, #' '
static FantasmaSaudavel + #314, #' '
static FantasmaSaudavel + #315, #' '
static FantasmaSaudavel + #316, #' '
static FantasmaSaudavel + #317, #' '
static FantasmaSaudavel + #318, #' '
static FantasmaSaudavel + #319, #' '
static FantasmaSaudavel + #320, #' '
static FantasmaSaudavel + #321, #' '
static FantasmaSaudavel + #322, #' '
static FantasmaSaudavel + #323, #' '
static FantasmaSaudavel + #324, #' '
static FantasmaSaudavel + #325, #' '
static FantasmaSaudavel + #326, #' '
static FantasmaSaudavel + #327, #' '
static FantasmaSaudavel + #328, #' '
static FantasmaSaudavel + #329, #2395









; ------ MapaInicial ------------

MapaInicial	: var #1200
static MapaInicial + #0, #3105
static MapaInicial + #1, #3109
static MapaInicial + #2, #3109
static MapaInicial + #3, #3109
static MapaInicial + #4, #3109
static MapaInicial + #5, #3109
static MapaInicial + #6, #3109
static MapaInicial + #7, #3109
static MapaInicial + #8, #3109
static MapaInicial + #9, #3109
static MapaInicial + #10, #3109
static MapaInicial + #11, #3109
static MapaInicial + #12, #3109
static MapaInicial + #13, #3107
static MapaInicial + #14, #3105
static MapaInicial + #15, #3109
static MapaInicial + #16, #3109
static MapaInicial + #17, #3109
static MapaInicial + #18, #3109
static MapaInicial + #19, #3109
static MapaInicial + #20, #3109
static MapaInicial + #21, #3109
static MapaInicial + #22, #3109
static MapaInicial + #23, #3109
static MapaInicial + #24, #3109
static MapaInicial + #25, #3107
static MapaInicial + #26, #3105
static MapaInicial + #27, #3109
static MapaInicial + #28, #3109
static MapaInicial + #29, #3109
static MapaInicial + #30, #3109
static MapaInicial + #31, #3109
static MapaInicial + #32, #3109
static MapaInicial + #33, #3109
static MapaInicial + #34, #3109
static MapaInicial + #35, #3109
static MapaInicial + #36, #3109
static MapaInicial + #37, #3109
static MapaInicial + #38, #3109
static MapaInicial + #39, #3107
static MapaInicial + #40, #3110
static MapaInicial + #41, #39
static MapaInicial + #42, #'Z'
static MapaInicial + #43, #'Z'
static MapaInicial + #44, #'Z'
static MapaInicial + #45, #'Z'
static MapaInicial + #46, #'Z'
static MapaInicial + #47, #'Z'
static MapaInicial + #48, #'Z'
static MapaInicial + #49, #'Z'
static MapaInicial + #50, #'Z'
static MapaInicial + #51, #'Z'
static MapaInicial + #52, #'Z'
static MapaInicial + #53, #3110
static MapaInicial + #54, #3110
static MapaInicial + #55, #'Z'
static MapaInicial + #56, #'Z'
static MapaInicial + #57, #'Z'
static MapaInicial + #58, #'Z'
static MapaInicial + #59, #'Z'
static MapaInicial + #60, #'Z'
static MapaInicial + #61, #'Z'
static MapaInicial + #62, #'Z'
static MapaInicial + #63, #'Z'
static MapaInicial + #64, #'Z'
static MapaInicial + #65, #3110
static MapaInicial + #66, #3110
static MapaInicial + #67, #'Z'
static MapaInicial + #68, #'Z'
static MapaInicial + #69, #'Z'
static MapaInicial + #70, #'Z'
static MapaInicial + #71, #'Z'
static MapaInicial + #72, #'Z'
static MapaInicial + #73, #'Z'
static MapaInicial + #74, #'Z'
static MapaInicial + #75, #'Z'
static MapaInicial + #76, #'Z'
static MapaInicial + #77, #'Z'
static MapaInicial + #78, #39
static MapaInicial + #79, #3110
static MapaInicial + #80, #3110
static MapaInicial + #81, #'Z'
static MapaInicial + #82, #3105
static MapaInicial + #83, #3109
static MapaInicial + #84, #3109
static MapaInicial + #85, #3107
static MapaInicial + #86, #'Z'
static MapaInicial + #87, #3105
static MapaInicial + #88, #3109
static MapaInicial + #89, #3109
static MapaInicial + #90, #3109
static MapaInicial + #91, #3107
static MapaInicial + #92, #'Z'
static MapaInicial + #93, #3110
static MapaInicial + #94, #3110
static MapaInicial + #95, #'Z'
static MapaInicial + #96, #3105
static MapaInicial + #97, #3109
static MapaInicial + #98, #3109
static MapaInicial + #99, #3109
static MapaInicial + #100, #3109
static MapaInicial + #101, #3109
static MapaInicial + #102, #3109
static MapaInicial + #103, #3107
static MapaInicial + #104, #'Z'
static MapaInicial + #105, #3110
static MapaInicial + #106, #3110
static MapaInicial + #107, #'Z'
static MapaInicial + #108, #3105
static MapaInicial + #109, #3109
static MapaInicial + #110, #3109
static MapaInicial + #111, #3109
static MapaInicial + #112, #3107
static MapaInicial + #113, #'Z'
static MapaInicial + #114, #3105
static MapaInicial + #115, #3109
static MapaInicial + #116, #3109
static MapaInicial + #117, #3107
static MapaInicial + #118, #'Z'
static MapaInicial + #119, #3110
static MapaInicial + #120, #3110
static MapaInicial + #121, #'Z'
static MapaInicial + #122, #3108
static MapaInicial + #123, #3109
static MapaInicial + #124, #3109
static MapaInicial + #125, #3106
static MapaInicial + #126, #'Z'
static MapaInicial + #127, #3108
static MapaInicial + #128, #3109
static MapaInicial + #129, #3109
static MapaInicial + #130, #3109
static MapaInicial + #131, #3106
static MapaInicial + #132, #'Z'
static MapaInicial + #133, #3108
static MapaInicial + #134, #3106
static MapaInicial + #135, #'Z'
static MapaInicial + #136, #3108
static MapaInicial + #137, #3109
static MapaInicial + #138, #3109
static MapaInicial + #139, #3109
static MapaInicial + #140, #3109
static MapaInicial + #141, #3109
static MapaInicial + #142, #3109
static MapaInicial + #143, #3106
static MapaInicial + #144, #'Z'
static MapaInicial + #145, #3108
static MapaInicial + #146, #3106
static MapaInicial + #147, #'Z'
static MapaInicial + #148, #3108
static MapaInicial + #149, #3109
static MapaInicial + #150, #3109
static MapaInicial + #151, #3109
static MapaInicial + #152, #3106
static MapaInicial + #153, #'Z'
static MapaInicial + #154, #3108
static MapaInicial + #155, #3109
static MapaInicial + #156, #3109
static MapaInicial + #157, #3106
static MapaInicial + #158, #'Z'
static MapaInicial + #159, #3110
static MapaInicial + #160, #3110
static MapaInicial + #161, #'Z'
static MapaInicial + #162, #'Z'
static MapaInicial + #163, #'Z'
static MapaInicial + #164, #'Z'
static MapaInicial + #165, #'Z'
static MapaInicial + #166, #'Z'
static MapaInicial + #167, #'Z'
static MapaInicial + #168, #'Z'
static MapaInicial + #169, #'Z'
static MapaInicial + #170, #'Z'
static MapaInicial + #171, #'Z'
static MapaInicial + #172, #'Z'
static MapaInicial + #173, #'Z'
static MapaInicial + #174, #'Z'
static MapaInicial + #175, #'Z'
static MapaInicial + #176, #'Z'
static MapaInicial + #177, #'Z'
static MapaInicial + #178, #'Z'
static MapaInicial + #179, #'Z'
static MapaInicial + #180, #'Z'
static MapaInicial + #181, #'Z'
static MapaInicial + #182, #'Z'
static MapaInicial + #183, #'Z'
static MapaInicial + #184, #'Z'
static MapaInicial + #185, #'Z'
static MapaInicial + #186, #'Z'
static MapaInicial + #187, #'Z'
static MapaInicial + #188, #'Z'
static MapaInicial + #189, #'Z'
static MapaInicial + #190, #'Z'
static MapaInicial + #191, #'Z'
static MapaInicial + #192, #'Z'
static MapaInicial + #193, #'Z'
static MapaInicial + #194, #'Z'
static MapaInicial + #195, #'Z'
static MapaInicial + #196, #'Z'
static MapaInicial + #197, #'Z'
static MapaInicial + #198, #'Z'
static MapaInicial + #199, #3110
static MapaInicial + #200, #3110
static MapaInicial + #201, #'Z'
static MapaInicial + #202, #3102
static MapaInicial + #203, #3109
static MapaInicial + #204, #3109
static MapaInicial + #205, #3103
static MapaInicial + #206, #'Z'
static MapaInicial + #207, #3105
static MapaInicial + #208, #3109
static MapaInicial + #209, #3109
static MapaInicial + #210, #3103
static MapaInicial + #211, #'Z'
static MapaInicial + #212, #'Z'
static MapaInicial + #213, #2395
static MapaInicial + #214, #2395
static MapaInicial + #215, #2395
static MapaInicial + #216, #2395
static MapaInicial + #217, #2395
static MapaInicial + #218, #2395
static MapaInicial + #219, #2395
static MapaInicial + #220, #2395
static MapaInicial + #221, #2395
static MapaInicial + #222, #2395
static MapaInicial + #223, #2395
static MapaInicial + #224, #2395
static MapaInicial + #225, #2395
static MapaInicial + #226, #2395
static MapaInicial + #227, #'Z'
static MapaInicial + #228, #'Z'
static MapaInicial + #229, #3102
static MapaInicial + #230, #3109
static MapaInicial + #231, #3109
static MapaInicial + #232, #3107
static MapaInicial + #233, #'Z'
static MapaInicial + #234, #3102
static MapaInicial + #235, #3109
static MapaInicial + #236, #3109
static MapaInicial + #237, #3103
static MapaInicial + #238, #'Z'
static MapaInicial + #239, #3110
static MapaInicial + #240, #3110
static MapaInicial + #241, #'Z'
static MapaInicial + #242, #'Z'
static MapaInicial + #243, #'Z'
static MapaInicial + #244, #'Z'
static MapaInicial + #245, #'Z'
static MapaInicial + #246, #'Z'
static MapaInicial + #247, #3110
static MapaInicial + #248, #3110
static MapaInicial + #249, #'Z'
static MapaInicial + #250, #'Z'
static MapaInicial + #251, #'Z'
static MapaInicial + #252, #2395
static MapaInicial + #253, #2395
static MapaInicial + #254, #2395
static MapaInicial + #255, #2395
static MapaInicial + #256, #2395
static MapaInicial + #257, #2395
static MapaInicial + #258, #2395
static MapaInicial + #259, #2395
static MapaInicial + #260, #2395
static MapaInicial + #261, #2395
static MapaInicial + #262, #2395
static MapaInicial + #263, #2395
static MapaInicial + #264, #2395
static MapaInicial + #265, #2395
static MapaInicial + #266, #2395
static MapaInicial + #267, #2395
static MapaInicial + #268, #'Z'
static MapaInicial + #269, #'Z'
static MapaInicial + #270, #'Z'
static MapaInicial + #271, #3110
static MapaInicial + #272, #3110
static MapaInicial + #273, #'Z'
static MapaInicial + #274, #'Z'
static MapaInicial + #275, #'Z'
static MapaInicial + #276, #'Z'
static MapaInicial + #277, #'Z'
static MapaInicial + #278, #'Z'
static MapaInicial + #279, #3110
static MapaInicial + #280, #3108
static MapaInicial + #281, #3109
static MapaInicial + #282, #3109
static MapaInicial + #283, #3109
static MapaInicial + #284, #3109
static MapaInicial + #285, #3107
static MapaInicial + #286, #'Z'
static MapaInicial + #287, #3110
static MapaInicial + #288, #3110
static MapaInicial + #289, #'Z'
static MapaInicial + #290, #2395
static MapaInicial + #291, #2395
static MapaInicial + #292, #2395
static MapaInicial + #293, #2395
static MapaInicial + #294, #' '
static MapaInicial + #295, #' '
static MapaInicial + #296, #91
static MapaInicial + #297, #2395
static MapaInicial + #298, #2395
static MapaInicial + #299, #2395
static MapaInicial + #300, #2395
static MapaInicial + #301, #' '
static MapaInicial + #302, #' '
static MapaInicial + #303, #91
static MapaInicial + #304, #2395
static MapaInicial + #305, #2395
static MapaInicial + #306, #2395
static MapaInicial + #307, #2395
static MapaInicial + #308, #2395
static MapaInicial + #309, #2395
static MapaInicial + #310, #'Z'
static MapaInicial + #311, #3110
static MapaInicial + #312, #3110
static MapaInicial + #313, #'Z'
static MapaInicial + #314, #3105
static MapaInicial + #315, #3109
static MapaInicial + #316, #3109
static MapaInicial + #317, #3109
static MapaInicial + #318, #3109
static MapaInicial + #319, #3106
static MapaInicial + #320, #' '
static MapaInicial + #321, #' '
static MapaInicial + #322, #' '
static MapaInicial + #323, #' '
static MapaInicial + #324, #' '
static MapaInicial + #325, #3110
static MapaInicial + #326, #'Z'
static MapaInicial + #327, #3110
static MapaInicial + #328, #3110
static MapaInicial + #329, #'Z'
static MapaInicial + #330, #2395
static MapaInicial + #331, #2395
static MapaInicial + #332, #2395
static MapaInicial + #333, #2395
static MapaInicial + #334, #' '
static MapaInicial + #335, #' '
static MapaInicial + #336, #91
static MapaInicial + #337, #2395
static MapaInicial + #338, #2395
static MapaInicial + #339, #2395
static MapaInicial + #340, #2395
static MapaInicial + #341, #' '
static MapaInicial + #342, #' '
static MapaInicial + #343, #91
static MapaInicial + #344, #2395
static MapaInicial + #345, #2395
static MapaInicial + #346, #2395
static MapaInicial + #347, #2395
static MapaInicial + #348, #2395
static MapaInicial + #349, #2395
static MapaInicial + #350, #'Z'
static MapaInicial + #351, #3110
static MapaInicial + #352, #3110
static MapaInicial + #353, #'Z'
static MapaInicial + #354, #3110
static MapaInicial + #355, #' '
static MapaInicial + #356, #' '
static MapaInicial + #357, #' '
static MapaInicial + #358, #' '
static MapaInicial + #359, #' '
static MapaInicial + #360, #' '
static MapaInicial + #361, #' '
static MapaInicial + #362, #' '
static MapaInicial + #363, #' '
static MapaInicial + #364, #' '
static MapaInicial + #365, #3110
static MapaInicial + #366, #'Z'
static MapaInicial + #367, #3110
static MapaInicial + #368, #3110
static MapaInicial + #369, #'Z'
static MapaInicial + #370, #2395
static MapaInicial + #371, #2395
static MapaInicial + #372, #2395
static MapaInicial + #373, #2395
static MapaInicial + #374, #91
static MapaInicial + #375, #91
static MapaInicial + #376, #91
static MapaInicial + #377, #2395
static MapaInicial + #378, #2395
static MapaInicial + #379, #2395
static MapaInicial + #380, #2395
static MapaInicial + #381, #91
static MapaInicial + #382, #91
static MapaInicial + #383, #91
static MapaInicial + #384, #2395
static MapaInicial + #385, #2395
static MapaInicial + #386, #2395
static MapaInicial + #387, #2395
static MapaInicial + #388, #2395
static MapaInicial + #389, #2395
static MapaInicial + #390, #'Z'
static MapaInicial + #391, #3110
static MapaInicial + #392, #3110
static MapaInicial + #393, #'Z'
static MapaInicial + #394, #3110
static MapaInicial + #395, #' '
static MapaInicial + #396, #' '
static MapaInicial + #397, #' '
static MapaInicial + #398, #' '
static MapaInicial + #399, #' '
static MapaInicial + #400, #' '
static MapaInicial + #401, #' '
static MapaInicial + #402, #' '
static MapaInicial + #403, #' '
static MapaInicial + #404, #' '
static MapaInicial + #405, #3110
static MapaInicial + #406, #'Z'
static MapaInicial + #407, #3110
static MapaInicial + #408, #3110
static MapaInicial + #409, #'Z'
static MapaInicial + #410, #2395
static MapaInicial + #411, #2395
static MapaInicial + #412, #2395
static MapaInicial + #413, #2395
static MapaInicial + #414, #2395
static MapaInicial + #415, #2395
static MapaInicial + #416, #2395
static MapaInicial + #417, #2395
static MapaInicial + #418, #2395
static MapaInicial + #419, #2395
static MapaInicial + #420, #2395
static MapaInicial + #421, #2395
static MapaInicial + #422, #2395
static MapaInicial + #423, #2395
static MapaInicial + #424, #2395
static MapaInicial + #425, #2395
static MapaInicial + #426, #2395
static MapaInicial + #427, #2395
static MapaInicial + #428, #2395
static MapaInicial + #429, #2395
static MapaInicial + #430, #'Z'
static MapaInicial + #431, #3110
static MapaInicial + #432, #3110
static MapaInicial + #433, #'Z'
static MapaInicial + #434, #3110
static MapaInicial + #435, #' '
static MapaInicial + #436, #' '
static MapaInicial + #437, #' '
static MapaInicial + #438, #' '
static MapaInicial + #439, #' '
static MapaInicial + #440, #3109
static MapaInicial + #441, #3109
static MapaInicial + #442, #3109
static MapaInicial + #443, #3109
static MapaInicial + #444, #3109
static MapaInicial + #445, #3106
static MapaInicial + #446, #'Z'
static MapaInicial + #447, #3108
static MapaInicial + #448, #3106
static MapaInicial + #449, #'Z'
static MapaInicial + #450, #2395
static MapaInicial + #451, #2395
static MapaInicial + #452, #2395
static MapaInicial + #453, #2395
static MapaInicial + #454, #2395
static MapaInicial + #455, #2395
static MapaInicial + #456, #2395
static MapaInicial + #457, #2395
static MapaInicial + #458, #2395
static MapaInicial + #459, #2395
static MapaInicial + #460, #2395
static MapaInicial + #461, #2395
static MapaInicial + #462, #2395
static MapaInicial + #463, #2395
static MapaInicial + #464, #2395
static MapaInicial + #465, #2395
static MapaInicial + #466, #2395
static MapaInicial + #467, #2395
static MapaInicial + #468, #2395
static MapaInicial + #469, #2395
static MapaInicial + #470, #'Z'
static MapaInicial + #471, #3108
static MapaInicial + #472, #3106
static MapaInicial + #473, #'Z'
static MapaInicial + #474, #3108
static MapaInicial + #475, #3109
static MapaInicial + #476, #3109
static MapaInicial + #477, #3109
static MapaInicial + #478, #3109
static MapaInicial + #479, #3109
static MapaInicial + #480, #' '
static MapaInicial + #481, #' '
static MapaInicial + #482, #' '
static MapaInicial + #483, #' '
static MapaInicial + #484, #' '
static MapaInicial + #485, #' '
static MapaInicial + #486, #'Z'
static MapaInicial + #487, #'Z'
static MapaInicial + #488, #'Z'
static MapaInicial + #489, #'Z'
static MapaInicial + #490, #2395
static MapaInicial + #491, #2395
static MapaInicial + #492, #2395
static MapaInicial + #493, #2395
static MapaInicial + #494, #2395
static MapaInicial + #495, #2395
static MapaInicial + #496, #2395
static MapaInicial + #497, #2395
static MapaInicial + #498, #2395
static MapaInicial + #499, #2395
static MapaInicial + #500, #2395
static MapaInicial + #501, #2395
static MapaInicial + #502, #2395
static MapaInicial + #503, #2395
static MapaInicial + #504, #2395
static MapaInicial + #505, #2395
static MapaInicial + #506, #2395
static MapaInicial + #507, #2395
static MapaInicial + #508, #2395
static MapaInicial + #509, #2395
static MapaInicial + #510, #'Z'
static MapaInicial + #511, #'Z'
static MapaInicial + #512, #'Z'
static MapaInicial + #513, #'Z'
static MapaInicial + #514, #' '
static MapaInicial + #515, #' '
static MapaInicial + #516, #' '
static MapaInicial + #517, #' '
static MapaInicial + #518, #' '
static MapaInicial + #519, #' '
static MapaInicial + #520, #3109
static MapaInicial + #521, #3109
static MapaInicial + #522, #3109
static MapaInicial + #523, #3109
static MapaInicial + #524, #3109
static MapaInicial + #525, #3107
static MapaInicial + #526, #'Z'
static MapaInicial + #527, #3105
static MapaInicial + #528, #3107
static MapaInicial + #529, #'Z'
static MapaInicial + #530, #2395
static MapaInicial + #531, #2395
static MapaInicial + #532, #2395
static MapaInicial + #533, #2395
static MapaInicial + #534, #2395
static MapaInicial + #535, #2395
static MapaInicial + #536, #2395
static MapaInicial + #537, #2395
static MapaInicial + #538, #2395
static MapaInicial + #539, #2395
static MapaInicial + #540, #2395
static MapaInicial + #541, #2395
static MapaInicial + #542, #2395
static MapaInicial + #543, #2395
static MapaInicial + #544, #2395
static MapaInicial + #545, #2395
static MapaInicial + #546, #2395
static MapaInicial + #547, #2395
static MapaInicial + #548, #2395
static MapaInicial + #549, #2395
static MapaInicial + #550, #'Z'
static MapaInicial + #551, #3105
static MapaInicial + #552, #3107
static MapaInicial + #553, #'Z'
static MapaInicial + #554, #3105
static MapaInicial + #555, #3109
static MapaInicial + #556, #3109
static MapaInicial + #557, #3109
static MapaInicial + #558, #3109
static MapaInicial + #559, #3109
static MapaInicial + #560, #' '
static MapaInicial + #561, #' '
static MapaInicial + #562, #' '
static MapaInicial + #563, #' '
static MapaInicial + #564, #' '
static MapaInicial + #565, #3110
static MapaInicial + #566, #'Z'
static MapaInicial + #567, #3110
static MapaInicial + #568, #3110
static MapaInicial + #569, #'Z'
static MapaInicial + #570, #2395
static MapaInicial + #571, #2395
static MapaInicial + #572, #2395
static MapaInicial + #573, #2395
static MapaInicial + #574, #2395
static MapaInicial + #575, #2395
static MapaInicial + #576, #2395
static MapaInicial + #577, #2395
static MapaInicial + #578, #2395
static MapaInicial + #579, #2395
static MapaInicial + #580, #2395
static MapaInicial + #581, #2395
static MapaInicial + #582, #2395
static MapaInicial + #583, #2395
static MapaInicial + #584, #2395
static MapaInicial + #585, #2395
static MapaInicial + #586, #2395
static MapaInicial + #587, #2395
static MapaInicial + #588, #2395
static MapaInicial + #589, #2395
static MapaInicial + #590, #'Z'
static MapaInicial + #591, #3110
static MapaInicial + #592, #3110
static MapaInicial + #593, #'Z'
static MapaInicial + #594, #3110
static MapaInicial + #595, #' '
static MapaInicial + #596, #' '
static MapaInicial + #597, #' '
static MapaInicial + #598, #' '
static MapaInicial + #599, #' '
static MapaInicial + #600, #' '
static MapaInicial + #601, #' '
static MapaInicial + #602, #' '
static MapaInicial + #603, #' '
static MapaInicial + #604, #' '
static MapaInicial + #605, #3110
static MapaInicial + #606, #'Z'
static MapaInicial + #607, #3110
static MapaInicial + #608, #3110
static MapaInicial + #609, #'Z'
static MapaInicial + #610, #2395
static MapaInicial + #611, #2395
static MapaInicial + #612, #2395
static MapaInicial + #613, #2395
static MapaInicial + #614, #2395
static MapaInicial + #615, #2395
static MapaInicial + #616, #2395
static MapaInicial + #617, #2395
static MapaInicial + #618, #2395
static MapaInicial + #619, #2395
static MapaInicial + #620, #2395
static MapaInicial + #621, #2395
static MapaInicial + #622, #2395
static MapaInicial + #623, #2395
static MapaInicial + #624, #2395
static MapaInicial + #625, #2395
static MapaInicial + #626, #2395
static MapaInicial + #627, #2395
static MapaInicial + #628, #2395
static MapaInicial + #629, #2395
static MapaInicial + #630, #'Z'
static MapaInicial + #631, #3110
static MapaInicial + #632, #3110
static MapaInicial + #633, #'Z'
static MapaInicial + #634, #3110
static MapaInicial + #635, #' '
static MapaInicial + #636, #' '
static MapaInicial + #637, #' '
static MapaInicial + #638, #' '
static MapaInicial + #639, #' '
static MapaInicial + #640, #' '
static MapaInicial + #641, #' '
static MapaInicial + #642, #' '
static MapaInicial + #643, #' '
static MapaInicial + #644, #' '
static MapaInicial + #645, #3110
static MapaInicial + #646, #'Z'
static MapaInicial + #647, #3110
static MapaInicial + #648, #3110
static MapaInicial + #649, #'Z'
static MapaInicial + #650, #2395
static MapaInicial + #651, #2395
static MapaInicial + #652, #2395
static MapaInicial + #653, #2395
static MapaInicial + #654, #2395
static MapaInicial + #655, #2395
static MapaInicial + #656, #2395
static MapaInicial + #657, #2395
static MapaInicial + #658, #2395
static MapaInicial + #659, #2395
static MapaInicial + #660, #2395
static MapaInicial + #661, #2395
static MapaInicial + #662, #2395
static MapaInicial + #663, #2395
static MapaInicial + #664, #2395
static MapaInicial + #665, #2395
static MapaInicial + #666, #2395
static MapaInicial + #667, #2395
static MapaInicial + #668, #2395
static MapaInicial + #669, #2395
static MapaInicial + #670, #'Z'
static MapaInicial + #671, #3110
static MapaInicial + #672, #3110
static MapaInicial + #673, #'Z'
static MapaInicial + #674, #3110
static MapaInicial + #675, #' '
static MapaInicial + #676, #' '
static MapaInicial + #677, #' '
static MapaInicial + #678, #' '
static MapaInicial + #679, #' '
static MapaInicial + #680, #' '
static MapaInicial + #681, #' '
static MapaInicial + #682, #' '
static MapaInicial + #683, #' '
static MapaInicial + #684, #' '
static MapaInicial + #685, #3110
static MapaInicial + #686, #'Z'
static MapaInicial + #687, #3110
static MapaInicial + #688, #3110
static MapaInicial + #689, #'Z'
static MapaInicial + #690, #2395
static MapaInicial + #691, #2395
static MapaInicial + #692, #2395
static MapaInicial + #693, #2395
static MapaInicial + #694, #2395
static MapaInicial + #695, #2395
static MapaInicial + #696, #2395
static MapaInicial + #697, #2395
static MapaInicial + #698, #2395
static MapaInicial + #699, #2395
static MapaInicial + #700, #2395
static MapaInicial + #701, #2395
static MapaInicial + #702, #2395
static MapaInicial + #703, #2395
static MapaInicial + #704, #2395
static MapaInicial + #705, #2395
static MapaInicial + #706, #2395
static MapaInicial + #707, #2395
static MapaInicial + #708, #2395
static MapaInicial + #709, #2395
static MapaInicial + #710, #'Z'
static MapaInicial + #711, #3110
static MapaInicial + #712, #3110
static MapaInicial + #713, #'Z'
static MapaInicial + #714, #3110
static MapaInicial + #715, #' '
static MapaInicial + #716, #' '
static MapaInicial + #717, #' '
static MapaInicial + #718, #' '
static MapaInicial + #719, #' '
static MapaInicial + #720, #3105
static MapaInicial + #721, #3109
static MapaInicial + #722, #3109
static MapaInicial + #723, #3109
static MapaInicial + #724, #3109
static MapaInicial + #725, #3106
static MapaInicial + #726, #'Z'
static MapaInicial + #727, #3108
static MapaInicial + #728, #3106
static MapaInicial + #729, #'Z'
static MapaInicial + #730, #2395
static MapaInicial + #731, #2395
static MapaInicial + #732, #2395
static MapaInicial + #733, #2395
static MapaInicial + #734, #2395
static MapaInicial + #735, #2395
static MapaInicial + #736, #2395
static MapaInicial + #737, #2395
static MapaInicial + #738, #2395
static MapaInicial + #739, #2395
static MapaInicial + #740, #2395
static MapaInicial + #741, #2395
static MapaInicial + #742, #2395
static MapaInicial + #743, #2395
static MapaInicial + #744, #2395
static MapaInicial + #745, #2395
static MapaInicial + #746, #2395
static MapaInicial + #747, #2395
static MapaInicial + #748, #2395
static MapaInicial + #749, #2395
static MapaInicial + #750, #'Z'
static MapaInicial + #751, #3108
static MapaInicial + #752, #3106
static MapaInicial + #753, #'Z'
static MapaInicial + #754, #3108
static MapaInicial + #755, #3109
static MapaInicial + #756, #3109
static MapaInicial + #757, #3109
static MapaInicial + #758, #3109
static MapaInicial + #759, #3107
static MapaInicial + #760, #3110
static MapaInicial + #761, #'Z'
static MapaInicial + #762, #'Z'
static MapaInicial + #763, #'Z'
static MapaInicial + #764, #'Z'
static MapaInicial + #765, #'Z'
static MapaInicial + #766, #'Z'
static MapaInicial + #767, #'Z'
static MapaInicial + #768, #'Z'
static MapaInicial + #769, #'Z'
static MapaInicial + #770, #2395
static MapaInicial + #771, #2395
static MapaInicial + #772, #2395
static MapaInicial + #773, #3871
static MapaInicial + #774, #2395
static MapaInicial + #775, #2395
static MapaInicial + #776, #3871
static MapaInicial + #777, #2395
static MapaInicial + #778, #2395
static MapaInicial + #779, #3871
static MapaInicial + #780, #3871
static MapaInicial + #781, #2395
static MapaInicial + #782, #2395
static MapaInicial + #783, #3871
static MapaInicial + #784, #2395
static MapaInicial + #785, #2395
static MapaInicial + #786, #3871
static MapaInicial + #787, #2395
static MapaInicial + #788, #2395
static MapaInicial + #789, #2395
static MapaInicial + #790, #'Z'
static MapaInicial + #791, #'Z'
static MapaInicial + #792, #'Z'
static MapaInicial + #793, #'Z'
static MapaInicial + #794, #'Z'
static MapaInicial + #795, #'Z'
static MapaInicial + #796, #'Z'
static MapaInicial + #797, #'Z'
static MapaInicial + #798, #'Z'
static MapaInicial + #799, #3110
static MapaInicial + #800, #3110
static MapaInicial + #801, #'Z'
static MapaInicial + #802, #3105
static MapaInicial + #803, #3109
static MapaInicial + #804, #3109
static MapaInicial + #805, #3107
static MapaInicial + #806, #'Z'
static MapaInicial + #807, #3105
static MapaInicial + #808, #3107
static MapaInicial + #809, #'Z'
static MapaInicial + #810, #2395
static MapaInicial + #811, #2395
static MapaInicial + #812, #3871
static MapaInicial + #813, #3871
static MapaInicial + #814, #2395
static MapaInicial + #815, #3871
static MapaInicial + #816, #3871
static MapaInicial + #817, #3871
static MapaInicial + #818, #2395
static MapaInicial + #819, #3871
static MapaInicial + #820, #3871
static MapaInicial + #821, #2395
static MapaInicial + #822, #3871
static MapaInicial + #823, #3871
static MapaInicial + #824, #3871
static MapaInicial + #825, #2395
static MapaInicial + #826, #3871
static MapaInicial + #827, #3871
static MapaInicial + #828, #2395
static MapaInicial + #829, #2395
static MapaInicial + #830, #'Z'
static MapaInicial + #831, #3105
static MapaInicial + #832, #3107
static MapaInicial + #833, #'Z'
static MapaInicial + #834, #3105
static MapaInicial + #835, #3109
static MapaInicial + #836, #3109
static MapaInicial + #837, #3107
static MapaInicial + #838, #'Z'
static MapaInicial + #839, #3110
static MapaInicial + #840, #3110
static MapaInicial + #841, #'Z'
static MapaInicial + #842, #3108
static MapaInicial + #843, #3109
static MapaInicial + #844, #3107
static MapaInicial + #845, #3110
static MapaInicial + #846, #'Z'
static MapaInicial + #847, #3108
static MapaInicial + #848, #3106
static MapaInicial + #849, #'Z'
static MapaInicial + #850, #2395
static MapaInicial + #851, #3871
static MapaInicial + #852, #3871
static MapaInicial + #853, #3871
static MapaInicial + #854, #3871
static MapaInicial + #855, #3871
static MapaInicial + #856, #3871
static MapaInicial + #857, #3871
static MapaInicial + #858, #3871
static MapaInicial + #859, #3871
static MapaInicial + #860, #3871
static MapaInicial + #861, #3871
static MapaInicial + #862, #3871
static MapaInicial + #863, #3871
static MapaInicial + #864, #3871
static MapaInicial + #865, #3871
static MapaInicial + #866, #3871
static MapaInicial + #867, #3871
static MapaInicial + #868, #3871
static MapaInicial + #869, #2395
static MapaInicial + #870, #'Z'
static MapaInicial + #871, #3108
static MapaInicial + #872, #3106
static MapaInicial + #873, #'Z'
static MapaInicial + #874, #3110
static MapaInicial + #875, #3105
static MapaInicial + #876, #3109
static MapaInicial + #877, #3106
static MapaInicial + #878, #'Z'
static MapaInicial + #879, #3110
static MapaInicial + #880, #3110
static MapaInicial + #881, #'Z'
static MapaInicial + #882, #'Z'
static MapaInicial + #883, #'Z'
static MapaInicial + #884, #3110
static MapaInicial + #885, #3110
static MapaInicial + #886, #'Z'
static MapaInicial + #887, #'Z'
static MapaInicial + #888, #'Z'
static MapaInicial + #889, #'Z'
static MapaInicial + #890, #'Z'
static MapaInicial + #891, #'Z'
static MapaInicial + #892, #'Z'
static MapaInicial + #893, #'Z'
static MapaInicial + #894, #'Z'
static MapaInicial + #895, #'Z'
static MapaInicial + #896, #'Z'
static MapaInicial + #897, #'Z'
static MapaInicial + #898, #'Z'
static MapaInicial + #899, #'Z'
static MapaInicial + #900, #'Z'
static MapaInicial + #901, #'Z'
static MapaInicial + #902, #'Z'
static MapaInicial + #903, #'Z'
static MapaInicial + #904, #'Z'
static MapaInicial + #905, #'Z'
static MapaInicial + #906, #'Z'
static MapaInicial + #907, #'Z'
static MapaInicial + #908, #'Z'
static MapaInicial + #909, #'Z'
static MapaInicial + #910, #'Z'
static MapaInicial + #911, #'Z'
static MapaInicial + #912, #'Z'
static MapaInicial + #913, #'Z'
static MapaInicial + #914, #3110
static MapaInicial + #915, #3110
static MapaInicial + #916, #'Z'
static MapaInicial + #917, #'Z'
static MapaInicial + #918, #'Z'
static MapaInicial + #919, #3110
static MapaInicial + #920, #3108
static MapaInicial + #921, #3109
static MapaInicial + #922, #3107
static MapaInicial + #923, #'Z'
static MapaInicial + #924, #3110
static MapaInicial + #925, #3110
static MapaInicial + #926, #'Z'
static MapaInicial + #927, #3105
static MapaInicial + #928, #3107
static MapaInicial + #929, #'Z'
static MapaInicial + #930, #3105
static MapaInicial + #931, #3109
static MapaInicial + #932, #3109
static MapaInicial + #933, #3109
static MapaInicial + #934, #3109
static MapaInicial + #935, #3109
static MapaInicial + #936, #3109
static MapaInicial + #937, #3109
static MapaInicial + #938, #3109
static MapaInicial + #939, #3109
static MapaInicial + #940, #3109
static MapaInicial + #941, #3109
static MapaInicial + #942, #3109
static MapaInicial + #943, #3109
static MapaInicial + #944, #3109
static MapaInicial + #945, #3109
static MapaInicial + #946, #3109
static MapaInicial + #947, #3109
static MapaInicial + #948, #3109
static MapaInicial + #949, #3107
static MapaInicial + #950, #'Z'
static MapaInicial + #951, #3105
static MapaInicial + #952, #3107
static MapaInicial + #953, #'Z'
static MapaInicial + #954, #3110
static MapaInicial + #955, #3110
static MapaInicial + #956, #'Z'
static MapaInicial + #957, #3105
static MapaInicial + #958, #3109
static MapaInicial + #959, #3106
static MapaInicial + #960, #3105
static MapaInicial + #961, #3109
static MapaInicial + #962, #3106
static MapaInicial + #963, #'Z'
static MapaInicial + #964, #3108
static MapaInicial + #965, #3106
static MapaInicial + #966, #'Z'
static MapaInicial + #967, #3110
static MapaInicial + #968, #3110
static MapaInicial + #969, #'Z'
static MapaInicial + #970, #3110
static MapaInicial + #971, #'Z'
static MapaInicial + #972, #'Z'
static MapaInicial + #973, #'Z'
static MapaInicial + #974, #'Z'
static MapaInicial + #975, #'Z'
static MapaInicial + #976, #'Z'
static MapaInicial + #977, #'Z'
static MapaInicial + #978, #'Z'
static MapaInicial + #979, #'Z'
static MapaInicial + #980, #'Z'
static MapaInicial + #981, #'Z'
static MapaInicial + #982, #'Z'
static MapaInicial + #983, #'Z'
static MapaInicial + #984, #'Z'
static MapaInicial + #985, #'Z'
static MapaInicial + #986, #'Z'
static MapaInicial + #987, #'Z'
static MapaInicial + #988, #'Z'
static MapaInicial + #989, #3110
static MapaInicial + #990, #'Z'
static MapaInicial + #991, #3110
static MapaInicial + #992, #3110
static MapaInicial + #993, #'Z'
static MapaInicial + #994, #3108
static MapaInicial + #995, #3106
static MapaInicial + #996, #'Z'
static MapaInicial + #997, #3108
static MapaInicial + #998, #3109
static MapaInicial + #999, #3107
static MapaInicial + #1000, #3110
static MapaInicial + #1001, #'Z'
static MapaInicial + #1002, #'Z'
static MapaInicial + #1003, #'Z'
static MapaInicial + #1004, #'Z'
static MapaInicial + #1005, #'Z'
static MapaInicial + #1006, #'Z'
static MapaInicial + #1007, #3110
static MapaInicial + #1008, #3110
static MapaInicial + #1009, #'Z'
static MapaInicial + #1010, #3110
static MapaInicial + #1011, #'Z'
static MapaInicial + #1012, #'Z'
static MapaInicial + #1013, #'Z'
static MapaInicial + #1014, #'Z'
static MapaInicial + #1015, #'Z'
static MapaInicial + #1016, #'Z'
static MapaInicial + #1017, #'Z'
static MapaInicial + #1018, #'Z'
static MapaInicial + #1019, #'Z'
static MapaInicial + #1020, #'Z'
static MapaInicial + #1021, #'Z'
static MapaInicial + #1022, #'Z'
static MapaInicial + #1023, #'Z'
static MapaInicial + #1024, #'Z'
static MapaInicial + #1025, #'Z'
static MapaInicial + #1026, #'Z'
static MapaInicial + #1027, #'Z'
static MapaInicial + #1028, #'Z'
static MapaInicial + #1029, #3110
static MapaInicial + #1030, #'Z'
static MapaInicial + #1031, #3110
static MapaInicial + #1032, #3110
static MapaInicial + #1033, #'Z'
static MapaInicial + #1034, #'Z'
static MapaInicial + #1035, #'Z'
static MapaInicial + #1036, #'Z'
static MapaInicial + #1037, #'Z'
static MapaInicial + #1038, #'Z'
static MapaInicial + #1039, #3110
static MapaInicial + #1040, #3110
static MapaInicial + #1041, #'Z'
static MapaInicial + #1042, #3102
static MapaInicial + #1043, #3109
static MapaInicial + #1044, #3109
static MapaInicial + #1045, #3109
static MapaInicial + #1046, #3109
static MapaInicial + #1047, #3109
static MapaInicial + #1048, #3106
static MapaInicial + #1049, #'Z'
static MapaInicial + #1050, #3108
static MapaInicial + #1051, #3109
static MapaInicial + #1052, #3109
static MapaInicial + #1053, #3109
static MapaInicial + #1054, #3109
static MapaInicial + #1055, #3109
static MapaInicial + #1056, #3109
static MapaInicial + #1057, #3109
static MapaInicial + #1058, #3103
static MapaInicial + #1059, #' '
static MapaInicial + #1060, #' '
static MapaInicial + #1061, #3102
static MapaInicial + #1062, #3109
static MapaInicial + #1063, #3109
static MapaInicial + #1064, #3109
static MapaInicial + #1065, #3109
static MapaInicial + #1066, #3109
static MapaInicial + #1067, #3109
static MapaInicial + #1068, #3109
static MapaInicial + #1069, #3106
static MapaInicial + #1070, #'Z'
static MapaInicial + #1071, #3108
static MapaInicial + #1072, #3109
static MapaInicial + #1073, #3109
static MapaInicial + #1074, #3109
static MapaInicial + #1075, #3109
static MapaInicial + #1076, #3109
static MapaInicial + #1077, #3103
static MapaInicial + #1078, #'Z'
static MapaInicial + #1079, #3110
static MapaInicial + #1080, #3110
static MapaInicial + #1081, #39
static MapaInicial + #1082, #'Z'
static MapaInicial + #1083, #'Z'
static MapaInicial + #1084, #'Z'
static MapaInicial + #1085, #'Z'
static MapaInicial + #1086, #'Z'
static MapaInicial + #1087, #'Z'
static MapaInicial + #1088, #'Z'
static MapaInicial + #1089, #'Z'
static MapaInicial + #1090, #'Z'
static MapaInicial + #1091, #'Z'
static MapaInicial + #1092, #'Z'
static MapaInicial + #1093, #'Z'
static MapaInicial + #1094, #'Z'
static MapaInicial + #1095, #'Z'
static MapaInicial + #1096, #'Z'
static MapaInicial + #1097, #'Z'
static MapaInicial + #1098, #'Z'
static MapaInicial + #1099, #'Z'
static MapaInicial + #1100, #'Z'
static MapaInicial + #1101, #'Z'
static MapaInicial + #1102, #'Z'
static MapaInicial + #1103, #'Z'
static MapaInicial + #1104, #'Z'
static MapaInicial + #1105, #'Z'
static MapaInicial + #1106, #'Z'
static MapaInicial + #1107, #'Z'
static MapaInicial + #1108, #'Z'
static MapaInicial + #1109, #'Z'
static MapaInicial + #1110, #'Z'
static MapaInicial + #1111, #'Z'
static MapaInicial + #1112, #'Z'
static MapaInicial + #1113, #'Z'
static MapaInicial + #1114, #'Z'
static MapaInicial + #1115, #'Z'
static MapaInicial + #1116, #'Z'
static MapaInicial + #1117, #'Z'
static MapaInicial + #1118, #39
static MapaInicial + #1119, #3110
static MapaInicial + #1120, #3108
static MapaInicial + #1121, #3109
static MapaInicial + #1122, #3109
static MapaInicial + #1123, #3109
static MapaInicial + #1124, #3109
static MapaInicial + #1125, #3109
static MapaInicial + #1126, #3109
static MapaInicial + #1127, #3109
static MapaInicial + #1128, #3109
static MapaInicial + #1129, #3109
static MapaInicial + #1130, #3109
static MapaInicial + #1131, #3109
static MapaInicial + #1132, #3109
static MapaInicial + #1133, #3109
static MapaInicial + #1134, #3109
static MapaInicial + #1135, #3109
static MapaInicial + #1136, #3109
static MapaInicial + #1137, #3109
static MapaInicial + #1138, #3109
static MapaInicial + #1139, #3109
static MapaInicial + #1140, #3109
static MapaInicial + #1141, #3109
static MapaInicial + #1142, #3109
static MapaInicial + #1143, #3109
static MapaInicial + #1144, #3109
static MapaInicial + #1145, #3109
static MapaInicial + #1146, #3109
static MapaInicial + #1147, #3109
static MapaInicial + #1148, #3109
static MapaInicial + #1149, #3109
static MapaInicial + #1150, #3109
static MapaInicial + #1151, #3109
static MapaInicial + #1152, #3109
static MapaInicial + #1153, #3109
static MapaInicial + #1154, #3109
static MapaInicial + #1155, #3109
static MapaInicial + #1156, #3109
static MapaInicial + #1157, #3109
static MapaInicial + #1158, #3109
static MapaInicial + #1159, #3106
static MapaInicial + #1160, #'S'
static MapaInicial + #1161, #'C'
static MapaInicial + #1162, #'O'
static MapaInicial + #1163, #'R'
static MapaInicial + #1164, #'E'
static MapaInicial + #1165, #' '
static MapaInicial + #1166, #'0'
static MapaInicial + #1167, #'0'
static MapaInicial + #1168, #'0'
static MapaInicial + #1169, #'0'
static MapaInicial + #1170, #' '
static MapaInicial + #1171, #' '
static MapaInicial + #1172, #' '
static MapaInicial + #1173, #' '
static MapaInicial + #1174, #' '
static MapaInicial + #1175, #' '
static MapaInicial + #1176, #' '
static MapaInicial + #1177, #' '
static MapaInicial + #1178, #' '
static MapaInicial + #1179, #' '
static MapaInicial + #1180, #' '
static MapaInicial + #1181, #' '
static MapaInicial + #1182, #'L'
static MapaInicial + #1183, #'I'
static MapaInicial + #1184, #'V'
static MapaInicial + #1185, #'E'
static MapaInicial + #1186, #'S'
static MapaInicial + #1187, #' '
static MapaInicial + #1188, #'0'
static MapaInicial + #1189, #'0'
static MapaInicial + #1190, #'0'
static MapaInicial + #1191, #' '
static MapaInicial + #1192, #' '
static MapaInicial + #1193, #' '
static MapaInicial + #1194, #' '
static MapaInicial + #1195, #' '
static MapaInicial + #1196, #' '
static MapaInicial + #1197, #' '
static MapaInicial + #1198, #' '
static MapaInicial + #1199, #' '





; tela de introducao
intro : var #1200

static intro + #0, #' '
static intro + #1, #' '
static intro + #2, #' '
static intro + #3, #' '
static intro + #4, #' '
static intro + #5, #' '
static intro + #6, #' '
static intro + #7, #' '
static intro + #8, #' '
static intro + #9, #' '
static intro + #10, #' '
static intro + #11, #' '
static intro + #12, #' '
static intro + #13, #' '
static intro + #14, #' '
static intro + #15, #' '
static intro + #16, #' '
static intro + #17, #' '
static intro + #18, #' '
static intro + #19, #' '
static intro + #20, #' '
static intro + #21, #' '
static intro + #22, #' '
static intro + #23, #' '
static intro + #24, #' '
static intro + #25, #' '
static intro + #26, #' '
static intro + #27, #' '
static intro + #28, #' '
static intro + #29, #' '
static intro + #30, #' '
static intro + #31, #' '
static intro + #32, #' '
static intro + #33, #' '
static intro + #34, #' '
static intro + #35, #' '
static intro + #36, #' '
static intro + #37, #' '
static intro + #38, #' '
static intro + #39, #' '
static intro + #40, #' '
static intro + #41, #' '
static intro + #42, #' '
static intro + #43, #' '
static intro + #44, #' '
static intro + #45, #' '
static intro + #46, #' '
static intro + #47, #' '
static intro + #48, #' '
static intro + #49, #' '
static intro + #50, #' '
static intro + #51, #' '
static intro + #52, #' '
static intro + #53, #' '
static intro + #54, #' '
static intro + #55, #' '
static intro + #56, #' '
static intro + #57, #' '
static intro + #58, #' '
static intro + #59, #' '
static intro + #60, #' '
static intro + #61, #' '
static intro + #62, #' '
static intro + #63, #' '
static intro + #64, #' '
static intro + #65, #' '
static intro + #66, #' '
static intro + #67, #' '
static intro + #68, #' '
static intro + #69, #' '
static intro + #70, #' '
static intro + #71, #' '
static intro + #72, #' '
static intro + #73, #' '
static intro + #74, #' '
static intro + #75, #' '
static intro + #76, #' '
static intro + #77, #' '
static intro + #78, #' '
static intro + #79, #' '
static intro + #80, #' '
static intro + #81, #' '
static intro + #82, #' '
static intro + #83, #' '
static intro + #84, #' '
static intro + #85, #' '
static intro + #86, #' '
static intro + #87, #' '
static intro + #88, #' '
static intro + #89, #' '
static intro + #90, #' '
static intro + #91, #' '
static intro + #92, #' '
static intro + #93, #' '
static intro + #94, #' '
static intro + #95, #' '
static intro + #96, #' '
static intro + #97, #' '
static intro + #98, #' '
static intro + #99, #' '
static intro + #100, #' '
static intro + #101, #' '
static intro + #102, #' '
static intro + #103, #' '
static intro + #104, #' '
static intro + #105, #' '
static intro + #106, #' '
static intro + #107, #' '
static intro + #108, #' '
static intro + #109, #' '
static intro + #110, #' '
static intro + #111, #' '
static intro + #112, #' '
static intro + #113, #' '
static intro + #114, #' '
static intro + #115, #' '
static intro + #116, #' '
static intro + #117, #' '
static intro + #118, #' '
static intro + #119, #' '
static intro + #120, #' '
static intro + #121, #' '
static intro + #122, #' '
static intro + #123, #' '
static intro + #124, #' '
static intro + #125, #' '
static intro + #126, #2395
static intro + #127, #2395
static intro + #128, #' '
static intro + #129, #' '
static intro + #130, #' '
static intro + #131, #' '
static intro + #132, #' '
static intro + #133, #' '
static intro + #134, #' '
static intro + #135, #' '
static intro + #136, #' '
static intro + #137, #' '
static intro + #138, #' '
static intro + #139, #' '
static intro + #140, #' '
static intro + #141, #' '
static intro + #142, #' '
static intro + #143, #' '
static intro + #144, #' '
static intro + #145, #' '
static intro + #146, #' '
static intro + #147, #' '
static intro + #148, #' '
static intro + #149, #' '
static intro + #150, #' '
static intro + #151, #' '
static intro + #152, #' '
static intro + #153, #' '
static intro + #154, #' '
static intro + #155, #' '
static intro + #156, #' '
static intro + #157, #' '
static intro + #158, #' '
static intro + #159, #' '
static intro + #160, #' '
static intro + #161, #' '
static intro + #162, #' '
static intro + #163, #' '
static intro + #164, #' '
static intro + #165, #' '
static intro + #166, #2395
static intro + #167, #' '
static intro + #168, #2395
static intro + #169, #' '
static intro + #170, #' '
static intro + #171, #' '
static intro + #172, #' '
static intro + #173, #' '
static intro + #174, #' '
static intro + #175, #' '
static intro + #176, #' '
static intro + #177, #' '
static intro + #178, #' '
static intro + #179, #' '
static intro + #180, #' '
static intro + #181, #' '
static intro + #182, #' '
static intro + #183, #' '
static intro + #184, #' '
static intro + #185, #' '
static intro + #186, #' '
static intro + #187, #' '
static intro + #188, #' '
static intro + #189, #' '
static intro + #190, #' '
static intro + #191, #' '
static intro + #192, #' '
static intro + #193, #' '
static intro + #194, #' '
static intro + #195, #' '
static intro + #196, #' '
static intro + #197, #' '
static intro + #198, #' '
static intro + #199, #' '
static intro + #200, #' '
static intro + #201, #' '
static intro + #202, #' '
static intro + #203, #' '
static intro + #204, #' '
static intro + #205, #' '
static intro + #206, #2395
static intro + #207, #' '
static intro + #208, #2395
static intro + #209, #' '
static intro + #210, #' '
static intro + #211, #2395
static intro + #212, #' '
static intro + #213, #' '
static intro + #214, #2395
static intro + #215, #2395
static intro + #216, #2395
static intro + #217, #' '
static intro + #218, #2395
static intro + #219, #' '
static intro + #220, #' '
static intro + #221, #' '
static intro + #222, #2395
static intro + #223, #' '
static intro + #224, #' '
static intro + #225, #2395
static intro + #226, #' '
static intro + #227, #' '
static intro + #228, #2395
static intro + #229, #' '
static intro + #230, #' '
static intro + #231, #' '
static intro + #232, #2395
static intro + #233, #' '
static intro + #234, #' '
static intro + #235, #' '
static intro + #236, #' '
static intro + #237, #' '
static intro + #238, #' '
static intro + #239, #' '
static intro + #240, #' '
static intro + #241, #' '
static intro + #242, #' '
static intro + #243, #' '
static intro + #244, #' '
static intro + #245, #' '
static intro + #246, #2395
static intro + #247, #' '
static intro + #248, #2395
static intro + #249, #' '
static intro + #250, #2395
static intro + #251, #' '
static intro + #252, #2395
static intro + #253, #' '
static intro + #254, #2395
static intro + #255, #' '
static intro + #256, #' '
static intro + #257, #' '
static intro + #258, #2395
static intro + #259, #2395
static intro + #260, #' '
static intro + #261, #2395
static intro + #262, #2395
static intro + #263, #' '
static intro + #264, #2395
static intro + #265, #' '
static intro + #266, #2395
static intro + #267, #' '
static intro + #268, #2395
static intro + #269, #2395
static intro + #270, #' '
static intro + #271, #' '
static intro + #272, #2395
static intro + #273, #' '
static intro + #274, #' '
static intro + #275, #' '
static intro + #276, #' '
static intro + #277, #' '
static intro + #278, #' '
static intro + #279, #' '
static intro + #280, #' '
static intro + #281, #' '
static intro + #282, #' '
static intro + #283, #' '
static intro + #284, #' '
static intro + #285, #' '
static intro + #286, #2395
static intro + #287, #2395
static intro + #288, #' '
static intro + #289, #' '
static intro + #290, #2395
static intro + #291, #' '
static intro + #292, #2395
static intro + #293, #' '
static intro + #294, #2395
static intro + #295, #' '
static intro + #296, #' '
static intro + #297, #' '
static intro + #298, #2395
static intro + #299, #' '
static intro + #300, #2395
static intro + #301, #' '
static intro + #302, #2395
static intro + #303, #' '
static intro + #304, #2395
static intro + #305, #' '
static intro + #306, #2395
static intro + #307, #' '
static intro + #308, #2395
static intro + #309, #' '
static intro + #310, #2395
static intro + #311, #' '
static intro + #312, #2395
static intro + #313, #' '
static intro + #314, #' '
static intro + #315, #' '
static intro + #316, #' '
static intro + #317, #' '
static intro + #318, #' '
static intro + #319, #' '
static intro + #320, #' '
static intro + #321, #' '
static intro + #322, #' '
static intro + #323, #' '
static intro + #324, #' '
static intro + #325, #' '
static intro + #326, #2395
static intro + #327, #' '
static intro + #328, #' '
static intro + #329, #' '
static intro + #330, #2395
static intro + #331, #2395
static intro + #332, #2395
static intro + #333, #' '
static intro + #334, #2395
static intro + #335, #' '
static intro + #336, #' '
static intro + #337, #' '
static intro + #338, #2395
static intro + #339, #' '
static intro + #340, #' '
static intro + #341, #' '
static intro + #342, #2395
static intro + #343, #' '
static intro + #344, #2395
static intro + #345, #2395
static intro + #346, #2395
static intro + #347, #' '
static intro + #348, #2395
static intro + #349, #' '
static intro + #350, #' '
static intro + #351, #2395
static intro + #352, #2395
static intro + #353, #' '
static intro + #354, #' '
static intro + #355, #' '
static intro + #356, #' '
static intro + #357, #' '
static intro + #358, #' '
static intro + #359, #' '
static intro + #360, #' '
static intro + #361, #' '
static intro + #362, #' '
static intro + #363, #' '
static intro + #364, #' '
static intro + #365, #' '
static intro + #366, #2395
static intro + #367, #' '
static intro + #368, #' '
static intro + #369, #' '
static intro + #370, #2395
static intro + #371, #' '
static intro + #372, #2395
static intro + #373, #' '
static intro + #374, #2395
static intro + #375, #' '
static intro + #376, #' '
static intro + #377, #' '
static intro + #378, #2395
static intro + #379, #' '
static intro + #380, #' '
static intro + #381, #' '
static intro + #382, #2395
static intro + #383, #' '
static intro + #384, #2395
static intro + #385, #' '
static intro + #386, #2395
static intro + #387, #' '
static intro + #388, #2395
static intro + #389, #' '
static intro + #390, #' '
static intro + #391, #' '
static intro + #392, #2395
static intro + #393, #' '
static intro + #394, #' '
static intro + #395, #' '
static intro + #396, #' '
static intro + #397, #' '
static intro + #398, #' '
static intro + #399, #' '
static intro + #400, #' '
static intro + #401, #' '
static intro + #402, #' '
static intro + #403, #' '
static intro + #404, #' '
static intro + #405, #' '
static intro + #406, #2395
static intro + #407, #' '
static intro + #408, #' '
static intro + #409, #' '
static intro + #410, #2395
static intro + #411, #' '
static intro + #412, #2395
static intro + #413, #' '
static intro + #414, #2395
static intro + #415, #2395
static intro + #416, #2395
static intro + #417, #' '
static intro + #418, #2395
static intro + #419, #' '
static intro + #420, #' '
static intro + #421, #' '
static intro + #422, #2395
static intro + #423, #' '
static intro + #424, #2395
static intro + #425, #' '
static intro + #426, #2395
static intro + #427, #' '
static intro + #428, #2395
static intro + #429, #' '
static intro + #430, #' '
static intro + #431, #' '
static intro + #432, #2395
static intro + #433, #' '
static intro + #434, #' '
static intro + #435, #' '
static intro + #436, #' '
static intro + #437, #' '
static intro + #438, #' '
static intro + #439, #' '
static intro + #440, #' '
static intro + #441, #' '
static intro + #442, #' '
static intro + #443, #' '
static intro + #444, #' '
static intro + #445, #' '
static intro + #446, #' '
static intro + #447, #' '
static intro + #448, #' '
static intro + #449, #' '
static intro + #450, #' '
static intro + #451, #' '
static intro + #452, #' '
static intro + #453, #' '
static intro + #454, #' '
static intro + #455, #' '
static intro + #456, #' '
static intro + #457, #' '
static intro + #458, #' '
static intro + #459, #' '
static intro + #460, #' '
static intro + #461, #' '
static intro + #462, #' '
static intro + #463, #' '
static intro + #464, #' '
static intro + #465, #' '
static intro + #466, #' '
static intro + #467, #' '
static intro + #468, #' '
static intro + #469, #' '
static intro + #470, #' '
static intro + #471, #' '
static intro + #472, #' '
static intro + #473, #' '
static intro + #474, #' '
static intro + #475, #' '
static intro + #476, #' '
static intro + #477, #' '
static intro + #478, #' '
static intro + #479, #' '
static intro + #480, #' '
static intro + #481, #' '
static intro + #482, #' '
static intro + #483, #' '
static intro + #484, #' '
static intro + #485, #' '
static intro + #486, #' '
static intro + #487, #' '
static intro + #488, #' '
static intro + #489, #' '
static intro + #490, #' '
static intro + #491, #' '
static intro + #492, #' '
static intro + #493, #' '
static intro + #494, #' '
static intro + #495, #' '
static intro + #496, #' '
static intro + #497, #' '
static intro + #498, #' '
static intro + #499, #' '
static intro + #500, #' '
static intro + #501, #' '
static intro + #502, #' '
static intro + #503, #' '
static intro + #504, #' '
static intro + #505, #' '
static intro + #506, #' '
static intro + #507, #' '
static intro + #508, #' '
static intro + #509, #' '
static intro + #510, #' '
static intro + #511, #' '
static intro + #512, #' '
static intro + #513, #' '
static intro + #514, #' '
static intro + #515, #' '
static intro + #516, #' '
static intro + #517, #' '
static intro + #518, #' '
static intro + #519, #' '
static intro + #520, #' '
static intro + #521, #' '
static intro + #522, #' '
static intro + #523, #' '
static intro + #524, #' '
static intro + #525, #' '
static intro + #526, #' '
static intro + #527, #' '
static intro + #528, #' '
static intro + #529, #' '
static intro + #530, #' '
static intro + #531, #' '
static intro + #532, #' '
static intro + #533, #' '
static intro + #534, #' '
static intro + #535, #' '
static intro + #536, #' '
static intro + #537, #' '
static intro + #538, #' '
static intro + #539, #' '
static intro + #540, #' '
static intro + #541, #' '
static intro + #542, #' '
static intro + #543, #' '
static intro + #544, #' '
static intro + #545, #' '
static intro + #546, #' '
static intro + #547, #' '
static intro + #548, #' '
static intro + #549, #' '
static intro + #550, #' '
static intro + #551, #' '
static intro + #552, #' '
static intro + #553, #' '
static intro + #554, #' '
static intro + #555, #' '
static intro + #556, #' '
static intro + #557, #' '
static intro + #558, #' '
static intro + #559, #' '
static intro + #560, #' '
static intro + #561, #' '
static intro + #562, #' '
static intro + #563, #' '
static intro + #564, #' '
static intro + #565, #' '
static intro + #566, #' '
static intro + #567, #' '
static intro + #568, #' '
static intro + #569, #' '
static intro + #570, #' '
static intro + #571, #' '
static intro + #572, #' '
static intro + #573, #' '
static intro + #574, #' '
static intro + #575, #' '
static intro + #576, #' '
static intro + #577, #' '
static intro + #578, #' '
static intro + #579, #' '
static intro + #580, #' '
static intro + #581, #' '
static intro + #582, #' '
static intro + #583, #' '
static intro + #584, #' '
static intro + #585, #' '
static intro + #586, #' '
static intro + #587, #' '
static intro + #588, #' '
static intro + #589, #' '
static intro + #590, #' '
static intro + #591, #' '
static intro + #592, #' '
static intro + #593, #' '
static intro + #594, #' '
static intro + #595, #' '
static intro + #596, #' '
static intro + #597, #' '
static intro + #598, #' '
static intro + #599, #' '
static intro + #600, #' '
static intro + #601, #' '
static intro + #602, #' '
static intro + #603, #' '
static intro + #604, #' '
static intro + #605, #' '
static intro + #606, #' '
static intro + #607, #' '
static intro + #608, #' '
static intro + #609, #' '
static intro + #610, #' '
static intro + #611, #' '
static intro + #612, #' '
static intro + #613, #' '
static intro + #614, #' '
static intro + #615, #' '
static intro + #616, #' '
static intro + #617, #' '
static intro + #618, #' '
static intro + #619, #' '
static intro + #620, #' '
static intro + #621, #' '
static intro + #622, #' '
static intro + #623, #' '
static intro + #624, #' '
static intro + #625, #' '
static intro + #626, #' '
static intro + #627, #' '
static intro + #628, #' '
static intro + #629, #' '
static intro + #630, #' '
static intro + #631, #' '
static intro + #632, #' '
static intro + #633, #' '
static intro + #634, #' '
static intro + #635, #' '
static intro + #636, #' '
static intro + #637, #' '
static intro + #638, #' '
static intro + #639, #' '
static intro + #640, #' '
static intro + #641, #' '
static intro + #642, #' '
static intro + #643, #' '
static intro + #644, #' '
static intro + #645, #' '
static intro + #646, #' '
static intro + #647, #' '
static intro + #648, #' '
static intro + #649, #' '
static intro + #650, #' '
static intro + #651, #' '
static intro + #652, #' '
static intro + #653, #' '
static intro + #654, #' '
static intro + #655, #' '
static intro + #656, #' '
static intro + #657, #' '
static intro + #658, #' '
static intro + #659, #' '
static intro + #660, #' '
static intro + #661, #' '
static intro + #662, #' '
static intro + #663, #' '
static intro + #664, #' '
static intro + #665, #' '
static intro + #666, #' '
static intro + #667, #' '
static intro + #668, #' '
static intro + #669, #' '
static intro + #670, #' '
static intro + #671, #' '
static intro + #672, #' '
static intro + #673, #' '
static intro + #674, #' '
static intro + #675, #' '
static intro + #676, #' '
static intro + #677, #' '
static intro + #678, #' '
static intro + #679, #' '
static intro + #680, #' '
static intro + #681, #' '
static intro + #682, #' '
static intro + #683, #' '
static intro + #684, #' '
static intro + #685, #' '
static intro + #686, #' '
static intro + #687, #' '
static intro + #688, #' '
static intro + #689, #' '
static intro + #690, #' '
static intro + #691, #' '
static intro + #692, #' '
static intro + #693, #' '
static intro + #694, #' '
static intro + #695, #' '
static intro + #696, #' '
static intro + #697, #' '
static intro + #698, #' '
static intro + #699, #' '
static intro + #700, #' '
static intro + #701, #' '
static intro + #702, #' '
static intro + #703, #' '
static intro + #704, #' '
static intro + #705, #' '
static intro + #706, #' '
static intro + #707, #' '
static intro + #708, #' '
static intro + #709, #' '
static intro + #710, #' '
static intro + #711, #' '
static intro + #712, #' '
static intro + #713, #' '
static intro + #714, #' '
static intro + #715, #' '
static intro + #716, #' '
static intro + #717, #' '
static intro + #718, #' '
static intro + #719, #' '
static intro + #720, #' '
static intro + #721, #' '
static intro + #722, #' '
static intro + #723, #' '
static intro + #724, #' '
static intro + #725, #' '
static intro + #726, #' '
static intro + #727, #' '
static intro + #728, #' '
static intro + #729, #' '
static intro + #730, #' '
static intro + #731, #' '
static intro + #732, #' '
static intro + #733, #' '
static intro + #734, #' '
static intro + #735, #' '
static intro + #736, #' '
static intro + #737, #' '
static intro + #738, #' '
static intro + #739, #' '
static intro + #740, #' '
static intro + #741, #' '
static intro + #742, #' '
static intro + #743, #' '
static intro + #744, #' '
static intro + #745, #' '
static intro + #746, #' '
static intro + #747, #' '
static intro + #748, #' '
static intro + #749, #' '
static intro + #750, #' '
static intro + #751, #' '
static intro + #752, #' '
static intro + #753, #' '
static intro + #754, #' '
static intro + #755, #' '
static intro + #756, #' '
static intro + #757, #' '
static intro + #758, #' '
static intro + #759, #' '
static intro + #760, #' '
static intro + #761, #' '
static intro + #762, #' '
static intro + #763, #' '
static intro + #764, #' '
static intro + #765, #' '
static intro + #766, #' '
static intro + #767, #' '
static intro + #768, #' '
static intro + #769, #' '
static intro + #770, #' '
static intro + #771, #' '
static intro + #772, #' '
static intro + #773, #' '
static intro + #774, #' '
static intro + #775, #' '
static intro + #776, #' '
static intro + #777, #' '
static intro + #778, #' '
static intro + #779, #' '
static intro + #780, #' '
static intro + #781, #' '
static intro + #782, #' '
static intro + #783, #' '
static intro + #784, #' '
static intro + #785, #' '
static intro + #786, #' '
static intro + #787, #' '
static intro + #788, #' '
static intro + #789, #' '
static intro + #790, #' '
static intro + #791, #' '
static intro + #792, #' '
static intro + #793, #' '
static intro + #794, #' '
static intro + #795, #' '
static intro + #796, #' '
static intro + #797, #' '
static intro + #798, #' '
static intro + #799, #' '
static intro + #800, #' '
static intro + #801, #' '
static intro + #802, #' '
static intro + #803, #' '
static intro + #804, #' '
static intro + #805, #' '
static intro + #806, #' '
static intro + #807, #' '
static intro + #808, #' '
static intro + #809, #' '
static intro + #810, #' '
static intro + #811, #' '
static intro + #812, #' '
static intro + #813, #' '
static intro + #814, #' '
static intro + #815, #' '
static intro + #816, #' '
static intro + #817, #' '
static intro + #818, #' '
static intro + #819, #' '
static intro + #820, #' '
static intro + #821, #' '
static intro + #822, #' '
static intro + #823, #' '
static intro + #824, #' '
static intro + #825, #' '
static intro + #826, #' '
static intro + #827, #' '
static intro + #828, #' '
static intro + #829, #' '
static intro + #830, #' '
static intro + #831, #' '
static intro + #832, #' '
static intro + #833, #' '
static intro + #834, #' '
static intro + #835, #' '
static intro + #836, #' '
static intro + #837, #' '
static intro + #838, #' '
static intro + #839, #' '
static intro + #840, #' '
static intro + #841, #' '
static intro + #842, #' '
static intro + #843, #' '
static intro + #844, #' '
static intro + #845, #' '
static intro + #846, #' '
static intro + #847, #' '
static intro + #848, #' '
static intro + #849, #' '
static intro + #850, #' '
static intro + #851, #' '
static intro + #852, #' '
static intro + #853, #' '
static intro + #854, #' '
static intro + #855, #' '
static intro + #856, #' '
static intro + #857, #' '
static intro + #858, #' '
static intro + #859, #' '
static intro + #860, #' '
static intro + #861, #' '
static intro + #862, #' '
static intro + #863, #' '
static intro + #864, #' '
static intro + #865, #' '
static intro + #866, #' '
static intro + #867, #' '
static intro + #868, #' '
static intro + #869, #' '
static intro + #870, #' '
static intro + #871, #' '
static intro + #872, #' '
static intro + #873, #' '
static intro + #874, #' '
static intro + #875, #' '
static intro + #876, #' '
static intro + #877, #' '
static intro + #878, #' '
static intro + #879, #' '
static intro + #880, #' '
static intro + #881, #' '
static intro + #882, #' '
static intro + #883, #' '
static intro + #884, #' '
static intro + #885, #' '
static intro + #886, #' '
static intro + #887, #' '
static intro + #888, #' '
static intro + #889, #' '
static intro + #890, #' '
static intro + #891, #' '
static intro + #892, #' '
static intro + #893, #' '
static intro + #894, #' '
static intro + #895, #' '
static intro + #896, #' '
static intro + #897, #' '
static intro + #898, #' '
static intro + #899, #' '
static intro + #900, #' '
static intro + #901, #' '
static intro + #902, #' '
static intro + #903, #' '
static intro + #904, #' '
static intro + #905, #' '
static intro + #906, #' '
static intro + #907, #' '
static intro + #908, #' '
static intro + #909, #' '
static intro + #910, #' '
static intro + #911, #' '
static intro + #912, #' '
static intro + #913, #' '
static intro + #914, #' '
static intro + #915, #' '
static intro + #916, #' '
static intro + #917, #' '
static intro + #918, #' '
static intro + #919, #' '
static intro + #920, #' '
static intro + #921, #' '
static intro + #922, #' '
static intro + #923, #' '
static intro + #924, #' '
static intro + #925, #' '
static intro + #926, #' '
static intro + #927, #' '
static intro + #928, #' '
static intro + #929, #' '
static intro + #930, #'P'
static intro + #931, #'R'
static intro + #932, #'E'
static intro + #933, #'S'
static intro + #934, #'S'
static intro + #935, #' '
static intro + #936, #'E'
static intro + #937, #'N'
static intro + #938, #'T'
static intro + #939, #'E'
static intro + #940, #'R'
static intro + #941, #' '
static intro + #942, #'T'
static intro + #943, #'O'
static intro + #944, #' '
static intro + #945, #'S'
static intro + #946, #'T'
static intro + #947, #'A'
static intro + #948, #'R'
static intro + #949, #'T'
static intro + #950, #' '
static intro + #951, #' '
static intro + #952, #' '
static intro + #953, #' '
static intro + #954, #' '
static intro + #955, #' '
static intro + #956, #' '
static intro + #957, #' '
static intro + #958, #' '
static intro + #959, #' '
static intro + #960, #' '
static intro + #961, #' '
static intro + #962, #' '
static intro + #963, #' '
static intro + #964, #' '
static intro + #965, #' '
static intro + #966, #' '
static intro + #967, #' '
static intro + #968, #' '
static intro + #969, #' '
static intro + #970, #' '
static intro + #971, #' '
static intro + #972, #' '
static intro + #973, #' '
static intro + #974, #' '
static intro + #975, #' '
static intro + #976, #' '
static intro + #977, #' '
static intro + #978, #' '
static intro + #979, #' '
static intro + #980, #' '
static intro + #981, #' '
static intro + #982, #' '
static intro + #983, #' '
static intro + #984, #' '
static intro + #985, #' '
static intro + #986, #' '
static intro + #987, #' '
static intro + #988, #' '
static intro + #989, #' '
static intro + #990, #' '
static intro + #991, #' '
static intro + #992, #' '
static intro + #993, #' '
static intro + #994, #' '
static intro + #995, #' '
static intro + #996, #' '
static intro + #997, #' '
static intro + #998, #' '
static intro + #999, #' '
static intro + #1000, #' '
static intro + #1001, #' '
static intro + #1002, #' '
static intro + #1003, #' '
static intro + #1004, #' '
static intro + #1005, #' '
static intro + #1006, #' '
static intro + #1007, #' '
static intro + #1008, #' '
static intro + #1009, #' '
static intro + #1010, #' '
static intro + #1011, #' '
static intro + #1012, #' '
static intro + #1013, #' '
static intro + #1014, #' '
static intro + #1015, #' '
static intro + #1016, #' '
static intro + #1017, #' '
static intro + #1018, #' '
static intro + #1019, #' '
static intro + #1020, #' '
static intro + #1021, #' '
static intro + #1022, #' '
static intro + #1023, #' '
static intro + #1024, #' '
static intro + #1025, #' '
static intro + #1026, #' '
static intro + #1027, #' '
static intro + #1028, #' '
static intro + #1029, #' '
static intro + #1030, #' '
static intro + #1031, #' '
static intro + #1032, #' '
static intro + #1033, #' '
static intro + #1034, #' '
static intro + #1035, #' '
static intro + #1036, #' '
static intro + #1037, #' '
static intro + #1038, #' '
static intro + #1039, #' '
static intro + #1040, #' '
static intro + #1041, #' '
static intro + #1042, #' '
static intro + #1043, #' '
static intro + #1044, #' '
static intro + #1045, #' '
static intro + #1046, #' '
static intro + #1047, #' '
static intro + #1048, #' '
static intro + #1049, #' '
static intro + #1050, #' '
static intro + #1051, #' '
static intro + #1052, #' '
static intro + #1053, #' '
static intro + #1054, #' '
static intro + #1055, #' '
static intro + #1056, #' '
static intro + #1057, #' '
static intro + #1058, #' '
static intro + #1059, #' '
static intro + #1060, #' '
static intro + #1061, #' '
static intro + #1062, #' '
static intro + #1063, #' '
static intro + #1064, #' '
static intro + #1065, #' '
static intro + #1066, #' '
static intro + #1067, #' '
static intro + #1068, #' '
static intro + #1069, #' '
static intro + #1070, #' '
static intro + #1071, #' '
static intro + #1072, #' '
static intro + #1073, #' '
static intro + #1074, #' '
static intro + #1075, #' '
static intro + #1076, #' '
static intro + #1077, #' '
static intro + #1078, #' '
static intro + #1079, #' '
static intro + #1080, #' '
static intro + #1081, #' '
static intro + #1082, #' '
static intro + #1083, #' '
static intro + #1084, #' '
static intro + #1085, #' '
static intro + #1086, #' '
static intro + #1087, #' '
static intro + #1088, #' '
static intro + #1089, #' '
static intro + #1090, #' '
static intro + #1091, #' '
static intro + #1092, #' '
static intro + #1093, #' '
static intro + #1094, #' '
static intro + #1095, #' '
static intro + #1096, #' '
static intro + #1097, #' '
static intro + #1098, #' '
static intro + #1099, #' '
static intro + #1100, #' '
static intro + #1101, #' '
static intro + #1102, #' '
static intro + #1103, #' '
static intro + #1104, #' '
static intro + #1105, #' '
static intro + #1106, #' '
static intro + #1107, #' '
static intro + #1108, #' '
static intro + #1109, #' '
static intro + #1110, #' '
static intro + #1111, #' '
static intro + #1112, #' '
static intro + #1113, #' '
static intro + #1114, #' '
static intro + #1115, #' '
static intro + #1116, #' '
static intro + #1117, #' '
static intro + #1118, #' '
static intro + #1119, #' '
static intro + #1120, #' '
static intro + #1121, #' '
static intro + #1122, #' '
static intro + #1123, #' '
static intro + #1124, #' '
static intro + #1125, #' '
static intro + #1126, #' '
static intro + #1127, #' '
static intro + #1128, #' '
static intro + #1129, #' '
static intro + #1130, #' '
static intro + #1131, #' '
static intro + #1132, #' '
static intro + #1133, #' '
static intro + #1134, #' '
static intro + #1135, #' '
static intro + #1136, #' '
static intro + #1137, #' '
static intro + #1138, #' '
static intro + #1139, #' '
static intro + #1140, #' '
static intro + #1141, #' '
static intro + #1142, #' '
static intro + #1143, #' '
static intro + #1144, #' '
static intro + #1145, #' '
static intro + #1146, #' '
static intro + #1147, #' '
static intro + #1148, #' '
static intro + #1149, #' '
static intro + #1150, #' '
static intro + #1151, #' '
static intro + #1152, #' '
static intro + #1153, #' '
static intro + #1154, #' '
static intro + #1155, #' '
static intro + #1156, #' '
static intro + #1157, #' '
static intro + #1158, #' '
static intro + #1159, #' '
static intro + #1160, #' '
static intro + #1161, #' '
static intro + #1162, #' '
static intro + #1163, #' '
static intro + #1164, #' '
static intro + #1165, #' '
static intro + #1166, #' '
static intro + #1167, #' '
static intro + #1168, #' '
static intro + #1169, #' '
static intro + #1170, #' '
static intro + #1171, #' '
static intro + #1172, #' '
static intro + #1173, #' '
static intro + #1174, #' '
static intro + #1175, #' '
static intro + #1176, #' '
static intro + #1177, #' '
static intro + #1178, #' '
static intro + #1179, #' '
static intro + #1180, #' '
static intro + #1181, #' '
static intro + #1182, #' '
static intro + #1183, #' '
static intro + #1184, #' '
static intro + #1185, #' '
static intro + #1186, #' '
static intro + #1187, #' '
static intro + #1188, #' '
static intro + #1189, #' '
static intro + #1190, #' '
static intro + #1191, #' '
static intro + #1192, #' '
static intro + #1193, #' '
static intro + #1194, #' '
static intro + #1195, #' '
static intro + #1196, #' '
static intro + #1197, #' '
static intro + #1198, #' '
static intro + #1199, #' '




ResetMapa : var #1200

static ResetMapa + #0, #3105
static ResetMapa + #1, #3109
static ResetMapa + #2, #3109
static ResetMapa + #3, #3109
static ResetMapa + #4, #3109
static ResetMapa + #5, #3109
static ResetMapa + #6, #3109
static ResetMapa + #7, #3109
static ResetMapa + #8, #3109
static ResetMapa + #9, #3109
static ResetMapa + #10, #3109
static ResetMapa + #11, #3109
static ResetMapa + #12, #3109
static ResetMapa + #13, #3107
static ResetMapa + #14, #3105
static ResetMapa + #15, #3109
static ResetMapa + #16, #3109
static ResetMapa + #17, #3109
static ResetMapa + #18, #3109
static ResetMapa + #19, #3109
static ResetMapa + #20, #3109
static ResetMapa + #21, #3109
static ResetMapa + #22, #3109
static ResetMapa + #23, #3109
static ResetMapa + #24, #3109
static ResetMapa + #25, #3107
static ResetMapa + #26, #3105
static ResetMapa + #27, #3109
static ResetMapa + #28, #3109
static ResetMapa + #29, #3109
static ResetMapa + #30, #3109
static ResetMapa + #31, #3109
static ResetMapa + #32, #3109
static ResetMapa + #33, #3109
static ResetMapa + #34, #3109
static ResetMapa + #35, #3109
static ResetMapa + #36, #3109
static ResetMapa + #37, #3109
static ResetMapa + #38, #3109
static ResetMapa + #39, #3107
static ResetMapa + #40, #3110
static ResetMapa + #41, #39
static ResetMapa + #42, #'Z'
static ResetMapa + #43, #'Z'
static ResetMapa + #44, #'Z'
static ResetMapa + #45, #'Z'
static ResetMapa + #46, #'Z'
static ResetMapa + #47, #'Z'
static ResetMapa + #48, #'Z'
static ResetMapa + #49, #'Z'
static ResetMapa + #50, #'Z'
static ResetMapa + #51, #'Z'
static ResetMapa + #52, #'Z'
static ResetMapa + #53, #3110
static ResetMapa + #54, #3110
static ResetMapa + #55, #'Z'
static ResetMapa + #56, #'Z'
static ResetMapa + #57, #'Z'
static ResetMapa + #58, #'Z'
static ResetMapa + #59, #'Z'
static ResetMapa + #60, #'Z'
static ResetMapa + #61, #'Z'
static ResetMapa + #62, #'Z'
static ResetMapa + #63, #'Z'
static ResetMapa + #64, #'Z'
static ResetMapa + #65, #3110
static ResetMapa + #66, #3110
static ResetMapa + #67, #'Z'
static ResetMapa + #68, #'Z'
static ResetMapa + #69, #'Z'
static ResetMapa + #70, #'Z'
static ResetMapa + #71, #'Z'
static ResetMapa + #72, #'Z'
static ResetMapa + #73, #'Z'
static ResetMapa + #74, #'Z'
static ResetMapa + #75, #'Z'
static ResetMapa + #76, #'Z'
static ResetMapa + #77, #'Z'
static ResetMapa + #78, #39
static ResetMapa + #79, #3110
static ResetMapa + #80, #3110
static ResetMapa + #81, #'Z'
static ResetMapa + #82, #3105
static ResetMapa + #83, #3109
static ResetMapa + #84, #3109
static ResetMapa + #85, #3107
static ResetMapa + #86, #'Z'
static ResetMapa + #87, #3105
static ResetMapa + #88, #3109
static ResetMapa + #89, #3109
static ResetMapa + #90, #3109
static ResetMapa + #91, #3107
static ResetMapa + #92, #'Z'
static ResetMapa + #93, #3110
static ResetMapa + #94, #3110
static ResetMapa + #95, #'Z'
static ResetMapa + #96, #3105
static ResetMapa + #97, #3109
static ResetMapa + #98, #3109
static ResetMapa + #99, #3109
static ResetMapa + #100, #3109
static ResetMapa + #101, #3109
static ResetMapa + #102, #3109
static ResetMapa + #103, #3107
static ResetMapa + #104, #'Z'
static ResetMapa + #105, #3110
static ResetMapa + #106, #3110
static ResetMapa + #107, #'Z'
static ResetMapa + #108, #3105
static ResetMapa + #109, #3109
static ResetMapa + #110, #3109
static ResetMapa + #111, #3109
static ResetMapa + #112, #3107
static ResetMapa + #113, #'Z'
static ResetMapa + #114, #3105
static ResetMapa + #115, #3109
static ResetMapa + #116, #3109
static ResetMapa + #117, #3107
static ResetMapa + #118, #'Z'
static ResetMapa + #119, #3110
static ResetMapa + #120, #3110
static ResetMapa + #121, #'Z'
static ResetMapa + #122, #3108
static ResetMapa + #123, #3109
static ResetMapa + #124, #3109
static ResetMapa + #125, #3106
static ResetMapa + #126, #'Z'
static ResetMapa + #127, #3108
static ResetMapa + #128, #3109
static ResetMapa + #129, #3109
static ResetMapa + #130, #3109
static ResetMapa + #131, #3106
static ResetMapa + #132, #'Z'
static ResetMapa + #133, #3108
static ResetMapa + #134, #3106
static ResetMapa + #135, #'Z'
static ResetMapa + #136, #3108
static ResetMapa + #137, #3109
static ResetMapa + #138, #3109
static ResetMapa + #139, #3109
static ResetMapa + #140, #3109
static ResetMapa + #141, #3109
static ResetMapa + #142, #3109
static ResetMapa + #143, #3106
static ResetMapa + #144, #'Z'
static ResetMapa + #145, #3108
static ResetMapa + #146, #3106
static ResetMapa + #147, #'Z'
static ResetMapa + #148, #3108
static ResetMapa + #149, #3109
static ResetMapa + #150, #3109
static ResetMapa + #151, #3109
static ResetMapa + #152, #3106
static ResetMapa + #153, #'Z'
static ResetMapa + #154, #3108
static ResetMapa + #155, #3109
static ResetMapa + #156, #3109
static ResetMapa + #157, #3106
static ResetMapa + #158, #'Z'
static ResetMapa + #159, #3110
static ResetMapa + #160, #3110
static ResetMapa + #161, #'Z'
static ResetMapa + #162, #'Z'
static ResetMapa + #163, #'Z'
static ResetMapa + #164, #'Z'
static ResetMapa + #165, #'Z'
static ResetMapa + #166, #'Z'
static ResetMapa + #167, #'Z'
static ResetMapa + #168, #'Z'
static ResetMapa + #169, #'Z'
static ResetMapa + #170, #'Z'
static ResetMapa + #171, #'Z'
static ResetMapa + #172, #'Z'
static ResetMapa + #173, #'Z'
static ResetMapa + #174, #'Z'
static ResetMapa + #175, #'Z'
static ResetMapa + #176, #'Z'
static ResetMapa + #177, #'Z'
static ResetMapa + #178, #'Z'
static ResetMapa + #179, #'Z'
static ResetMapa + #180, #'Z'
static ResetMapa + #181, #'Z'
static ResetMapa + #182, #'Z'
static ResetMapa + #183, #'Z'
static ResetMapa + #184, #'Z'
static ResetMapa + #185, #'Z'
static ResetMapa + #186, #'Z'
static ResetMapa + #187, #'Z'
static ResetMapa + #188, #'Z'
static ResetMapa + #189, #'Z'
static ResetMapa + #190, #'Z'
static ResetMapa + #191, #'Z'
static ResetMapa + #192, #'Z'
static ResetMapa + #193, #'Z'
static ResetMapa + #194, #'Z'
static ResetMapa + #195, #'Z'
static ResetMapa + #196, #'Z'
static ResetMapa + #197, #'Z'
static ResetMapa + #198, #'Z'
static ResetMapa + #199, #3110
static ResetMapa + #200, #3110
static ResetMapa + #201, #'Z'
static ResetMapa + #202, #3102
static ResetMapa + #203, #3109
static ResetMapa + #204, #3109
static ResetMapa + #205, #3103
static ResetMapa + #206, #'Z'
static ResetMapa + #207, #3105
static ResetMapa + #208, #3109
static ResetMapa + #209, #3109
static ResetMapa + #210, #3103
static ResetMapa + #211, #'Z'
static ResetMapa + #212, #'Z'
static ResetMapa + #213, #2395
static ResetMapa + #214, #2395
static ResetMapa + #215, #2395
static ResetMapa + #216, #2395
static ResetMapa + #217, #2395
static ResetMapa + #218, #2395
static ResetMapa + #219, #2395
static ResetMapa + #220, #2395
static ResetMapa + #221, #2395
static ResetMapa + #222, #2395
static ResetMapa + #223, #2395
static ResetMapa + #224, #2395
static ResetMapa + #225, #2395
static ResetMapa + #226, #2395
static ResetMapa + #227, #'Z'
static ResetMapa + #228, #'Z'
static ResetMapa + #229, #3102
static ResetMapa + #230, #3109
static ResetMapa + #231, #3109
static ResetMapa + #232, #3107
static ResetMapa + #233, #'Z'
static ResetMapa + #234, #3102
static ResetMapa + #235, #3109
static ResetMapa + #236, #3109
static ResetMapa + #237, #3103
static ResetMapa + #238, #'Z'
static ResetMapa + #239, #3110
static ResetMapa + #240, #3110
static ResetMapa + #241, #'Z'
static ResetMapa + #242, #'Z'
static ResetMapa + #243, #'Z'
static ResetMapa + #244, #'Z'
static ResetMapa + #245, #'Z'
static ResetMapa + #246, #'Z'
static ResetMapa + #247, #3110
static ResetMapa + #248, #3110
static ResetMapa + #249, #'Z'
static ResetMapa + #250, #'Z'
static ResetMapa + #251, #'Z'
static ResetMapa + #252, #2395
static ResetMapa + #253, #2395
static ResetMapa + #254, #2395
static ResetMapa + #255, #2395
static ResetMapa + #256, #2395
static ResetMapa + #257, #2395
static ResetMapa + #258, #2395
static ResetMapa + #259, #2395
static ResetMapa + #260, #2395
static ResetMapa + #261, #2395
static ResetMapa + #262, #2395
static ResetMapa + #263, #2395
static ResetMapa + #264, #2395
static ResetMapa + #265, #2395
static ResetMapa + #266, #2395
static ResetMapa + #267, #2395
static ResetMapa + #268, #'Z'
static ResetMapa + #269, #'Z'
static ResetMapa + #270, #'Z'
static ResetMapa + #271, #3110
static ResetMapa + #272, #3110
static ResetMapa + #273, #'Z'
static ResetMapa + #274, #'Z'
static ResetMapa + #275, #'Z'
static ResetMapa + #276, #'Z'
static ResetMapa + #277, #'Z'
static ResetMapa + #278, #'Z'
static ResetMapa + #279, #3110
static ResetMapa + #280, #3108
static ResetMapa + #281, #3109
static ResetMapa + #282, #3109
static ResetMapa + #283, #3109
static ResetMapa + #284, #3109
static ResetMapa + #285, #3107
static ResetMapa + #286, #'Z'
static ResetMapa + #287, #3110
static ResetMapa + #288, #3110
static ResetMapa + #289, #'Z'
static ResetMapa + #290, #2395
static ResetMapa + #291, #2395
static ResetMapa + #292, #2395
static ResetMapa + #293, #2395
static ResetMapa + #294, #' '
static ResetMapa + #295, #' '
static ResetMapa + #296, #91
static ResetMapa + #297, #2395
static ResetMapa + #298, #2395
static ResetMapa + #299, #2395
static ResetMapa + #300, #2395
static ResetMapa + #301, #' '
static ResetMapa + #302, #' '
static ResetMapa + #303, #91
static ResetMapa + #304, #2395
static ResetMapa + #305, #2395
static ResetMapa + #306, #2395
static ResetMapa + #307, #2395
static ResetMapa + #308, #2395
static ResetMapa + #309, #2395
static ResetMapa + #310, #'Z'
static ResetMapa + #311, #3110
static ResetMapa + #312, #3110
static ResetMapa + #313, #'Z'
static ResetMapa + #314, #3105
static ResetMapa + #315, #3109
static ResetMapa + #316, #3109
static ResetMapa + #317, #3109
static ResetMapa + #318, #3109
static ResetMapa + #319, #3106
static ResetMapa + #320, #' '
static ResetMapa + #321, #' '
static ResetMapa + #322, #' '
static ResetMapa + #323, #' '
static ResetMapa + #324, #' '
static ResetMapa + #325, #3110
static ResetMapa + #326, #'Z'
static ResetMapa + #327, #3110
static ResetMapa + #328, #3110
static ResetMapa + #329, #'Z'
static ResetMapa + #330, #2395
static ResetMapa + #331, #2395
static ResetMapa + #332, #2395
static ResetMapa + #333, #2395
static ResetMapa + #334, #' '
static ResetMapa + #335, #' '
static ResetMapa + #336, #91
static ResetMapa + #337, #2395
static ResetMapa + #338, #2395
static ResetMapa + #339, #2395
static ResetMapa + #340, #2395
static ResetMapa + #341, #' '
static ResetMapa + #342, #' '
static ResetMapa + #343, #91
static ResetMapa + #344, #2395
static ResetMapa + #345, #2395
static ResetMapa + #346, #2395
static ResetMapa + #347, #2395
static ResetMapa + #348, #2395
static ResetMapa + #349, #2395
static ResetMapa + #350, #'Z'
static ResetMapa + #351, #3110
static ResetMapa + #352, #3110
static ResetMapa + #353, #'Z'
static ResetMapa + #354, #3110
static ResetMapa + #355, #' '
static ResetMapa + #356, #' '
static ResetMapa + #357, #' '
static ResetMapa + #358, #' '
static ResetMapa + #359, #' '
static ResetMapa + #360, #' '
static ResetMapa + #361, #' '
static ResetMapa + #362, #' '
static ResetMapa + #363, #' '
static ResetMapa + #364, #' '
static ResetMapa + #365, #3110
static ResetMapa + #366, #'Z'
static ResetMapa + #367, #3110
static ResetMapa + #368, #3110
static ResetMapa + #369, #'Z'
static ResetMapa + #370, #2395
static ResetMapa + #371, #2395
static ResetMapa + #372, #2395
static ResetMapa + #373, #2395
static ResetMapa + #374, #91
static ResetMapa + #375, #91
static ResetMapa + #376, #91
static ResetMapa + #377, #2395
static ResetMapa + #378, #2395
static ResetMapa + #379, #2395
static ResetMapa + #380, #2395
static ResetMapa + #381, #91
static ResetMapa + #382, #91
static ResetMapa + #383, #91
static ResetMapa + #384, #2395
static ResetMapa + #385, #2395
static ResetMapa + #386, #2395
static ResetMapa + #387, #2395
static ResetMapa + #388, #2395
static ResetMapa + #389, #2395
static ResetMapa + #390, #'Z'
static ResetMapa + #391, #3110
static ResetMapa + #392, #3110
static ResetMapa + #393, #'Z'
static ResetMapa + #394, #3110
static ResetMapa + #395, #' '
static ResetMapa + #396, #' '
static ResetMapa + #397, #' '
static ResetMapa + #398, #' '
static ResetMapa + #399, #' '
static ResetMapa + #400, #' '
static ResetMapa + #401, #' '
static ResetMapa + #402, #' '
static ResetMapa + #403, #' '
static ResetMapa + #404, #' '
static ResetMapa + #405, #3110
static ResetMapa + #406, #'Z'
static ResetMapa + #407, #3110
static ResetMapa + #408, #3110
static ResetMapa + #409, #'Z'
static ResetMapa + #410, #2395
static ResetMapa + #411, #2395
static ResetMapa + #412, #2395
static ResetMapa + #413, #2395
static ResetMapa + #414, #2395
static ResetMapa + #415, #2395
static ResetMapa + #416, #2395
static ResetMapa + #417, #2395
static ResetMapa + #418, #2395
static ResetMapa + #419, #2395
static ResetMapa + #420, #2395
static ResetMapa + #421, #2395
static ResetMapa + #422, #2395
static ResetMapa + #423, #2395
static ResetMapa + #424, #2395
static ResetMapa + #425, #2395
static ResetMapa + #426, #2395
static ResetMapa + #427, #2395
static ResetMapa + #428, #2395
static ResetMapa + #429, #2395
static ResetMapa + #430, #'Z'
static ResetMapa + #431, #3110
static ResetMapa + #432, #3110
static ResetMapa + #433, #'Z'
static ResetMapa + #434, #3110
static ResetMapa + #435, #' '
static ResetMapa + #436, #' '
static ResetMapa + #437, #' '
static ResetMapa + #438, #' '
static ResetMapa + #439, #' '
static ResetMapa + #440, #3109
static ResetMapa + #441, #3109
static ResetMapa + #442, #3109
static ResetMapa + #443, #3109
static ResetMapa + #444, #3109
static ResetMapa + #445, #3106
static ResetMapa + #446, #'Z'
static ResetMapa + #447, #3108
static ResetMapa + #448, #3106
static ResetMapa + #449, #'Z'
static ResetMapa + #450, #2395
static ResetMapa + #451, #2395
static ResetMapa + #452, #2395
static ResetMapa + #453, #2395
static ResetMapa + #454, #2395
static ResetMapa + #455, #2395
static ResetMapa + #456, #2395
static ResetMapa + #457, #2395
static ResetMapa + #458, #2395
static ResetMapa + #459, #2395
static ResetMapa + #460, #2395
static ResetMapa + #461, #2395
static ResetMapa + #462, #2395
static ResetMapa + #463, #2395
static ResetMapa + #464, #2395
static ResetMapa + #465, #2395
static ResetMapa + #466, #2395
static ResetMapa + #467, #2395
static ResetMapa + #468, #2395
static ResetMapa + #469, #2395
static ResetMapa + #470, #'Z'
static ResetMapa + #471, #3108
static ResetMapa + #472, #3106
static ResetMapa + #473, #'Z'
static ResetMapa + #474, #3108
static ResetMapa + #475, #3109
static ResetMapa + #476, #3109
static ResetMapa + #477, #3109
static ResetMapa + #478, #3109
static ResetMapa + #479, #3109
static ResetMapa + #480, #' '
static ResetMapa + #481, #' '
static ResetMapa + #482, #' '
static ResetMapa + #483, #' '
static ResetMapa + #484, #' '
static ResetMapa + #485, #' '
static ResetMapa + #486, #'Z'
static ResetMapa + #487, #'Z'
static ResetMapa + #488, #'Z'
static ResetMapa + #489, #'Z'
static ResetMapa + #490, #2395
static ResetMapa + #491, #2395
static ResetMapa + #492, #2395
static ResetMapa + #493, #2395
static ResetMapa + #494, #2395
static ResetMapa + #495, #2395
static ResetMapa + #496, #2395
static ResetMapa + #497, #2395
static ResetMapa + #498, #2395
static ResetMapa + #499, #2395
static ResetMapa + #500, #2395
static ResetMapa + #501, #2395
static ResetMapa + #502, #2395
static ResetMapa + #503, #2395
static ResetMapa + #504, #2395
static ResetMapa + #505, #2395
static ResetMapa + #506, #2395
static ResetMapa + #507, #2395
static ResetMapa + #508, #2395
static ResetMapa + #509, #2395
static ResetMapa + #510, #'Z'
static ResetMapa + #511, #'Z'
static ResetMapa + #512, #'Z'
static ResetMapa + #513, #'Z'
static ResetMapa + #514, #' '
static ResetMapa + #515, #' '
static ResetMapa + #516, #' '
static ResetMapa + #517, #' '
static ResetMapa + #518, #' '
static ResetMapa + #519, #' '
static ResetMapa + #520, #3109
static ResetMapa + #521, #3109
static ResetMapa + #522, #3109
static ResetMapa + #523, #3109
static ResetMapa + #524, #3109
static ResetMapa + #525, #3107
static ResetMapa + #526, #'Z'
static ResetMapa + #527, #3105
static ResetMapa + #528, #3107
static ResetMapa + #529, #'Z'
static ResetMapa + #530, #2395
static ResetMapa + #531, #2395
static ResetMapa + #532, #2395
static ResetMapa + #533, #2395
static ResetMapa + #534, #2395
static ResetMapa + #535, #2395
static ResetMapa + #536, #2395
static ResetMapa + #537, #2395
static ResetMapa + #538, #2395
static ResetMapa + #539, #2395
static ResetMapa + #540, #2395
static ResetMapa + #541, #2395
static ResetMapa + #542, #2395
static ResetMapa + #543, #2395
static ResetMapa + #544, #2395
static ResetMapa + #545, #2395
static ResetMapa + #546, #2395
static ResetMapa + #547, #2395
static ResetMapa + #548, #2395
static ResetMapa + #549, #2395
static ResetMapa + #550, #'Z'
static ResetMapa + #551, #3105
static ResetMapa + #552, #3107
static ResetMapa + #553, #'Z'
static ResetMapa + #554, #3105
static ResetMapa + #555, #3109
static ResetMapa + #556, #3109
static ResetMapa + #557, #3109
static ResetMapa + #558, #3109
static ResetMapa + #559, #3109
static ResetMapa + #560, #' '
static ResetMapa + #561, #' '
static ResetMapa + #562, #' '
static ResetMapa + #563, #' '
static ResetMapa + #564, #' '
static ResetMapa + #565, #3110
static ResetMapa + #566, #'Z'
static ResetMapa + #567, #3110
static ResetMapa + #568, #3110
static ResetMapa + #569, #'Z'
static ResetMapa + #570, #2395
static ResetMapa + #571, #2395
static ResetMapa + #572, #2395
static ResetMapa + #573, #2395
static ResetMapa + #574, #2395
static ResetMapa + #575, #2395
static ResetMapa + #576, #2395
static ResetMapa + #577, #2395
static ResetMapa + #578, #2395
static ResetMapa + #579, #2395
static ResetMapa + #580, #2395
static ResetMapa + #581, #2395
static ResetMapa + #582, #2395
static ResetMapa + #583, #2395
static ResetMapa + #584, #2395
static ResetMapa + #585, #2395
static ResetMapa + #586, #2395
static ResetMapa + #587, #2395
static ResetMapa + #588, #2395
static ResetMapa + #589, #2395
static ResetMapa + #590, #'Z'
static ResetMapa + #591, #3110
static ResetMapa + #592, #3110
static ResetMapa + #593, #'Z'
static ResetMapa + #594, #3110
static ResetMapa + #595, #' '
static ResetMapa + #596, #' '
static ResetMapa + #597, #' '
static ResetMapa + #598, #' '
static ResetMapa + #599, #' '
static ResetMapa + #600, #' '
static ResetMapa + #601, #' '
static ResetMapa + #602, #' '
static ResetMapa + #603, #' '
static ResetMapa + #604, #' '
static ResetMapa + #605, #3110
static ResetMapa + #606, #'Z'
static ResetMapa + #607, #3110
static ResetMapa + #608, #3110
static ResetMapa + #609, #'Z'
static ResetMapa + #610, #2395
static ResetMapa + #611, #2395
static ResetMapa + #612, #2395
static ResetMapa + #613, #2395
static ResetMapa + #614, #2395
static ResetMapa + #615, #2395
static ResetMapa + #616, #2395
static ResetMapa + #617, #2395
static ResetMapa + #618, #2395
static ResetMapa + #619, #2395
static ResetMapa + #620, #2395
static ResetMapa + #621, #2395
static ResetMapa + #622, #2395
static ResetMapa + #623, #2395
static ResetMapa + #624, #2395
static ResetMapa + #625, #2395
static ResetMapa + #626, #2395
static ResetMapa + #627, #2395
static ResetMapa + #628, #2395
static ResetMapa + #629, #2395
static ResetMapa + #630, #'Z'
static ResetMapa + #631, #3110
static ResetMapa + #632, #3110
static ResetMapa + #633, #'Z'
static ResetMapa + #634, #3110
static ResetMapa + #635, #' '
static ResetMapa + #636, #' '
static ResetMapa + #637, #' '
static ResetMapa + #638, #' '
static ResetMapa + #639, #' '
static ResetMapa + #640, #' '
static ResetMapa + #641, #' '
static ResetMapa + #642, #' '
static ResetMapa + #643, #' '
static ResetMapa + #644, #' '
static ResetMapa + #645, #3110
static ResetMapa + #646, #'Z'
static ResetMapa + #647, #3110
static ResetMapa + #648, #3110
static ResetMapa + #649, #'Z'
static ResetMapa + #650, #2395
static ResetMapa + #651, #2395
static ResetMapa + #652, #2395
static ResetMapa + #653, #2395
static ResetMapa + #654, #2395
static ResetMapa + #655, #2395
static ResetMapa + #656, #2395
static ResetMapa + #657, #2395
static ResetMapa + #658, #2395
static ResetMapa + #659, #2395
static ResetMapa + #660, #2395
static ResetMapa + #661, #2395
static ResetMapa + #662, #2395
static ResetMapa + #663, #2395
static ResetMapa + #664, #2395
static ResetMapa + #665, #2395
static ResetMapa + #666, #2395
static ResetMapa + #667, #2395
static ResetMapa + #668, #2395
static ResetMapa + #669, #2395
static ResetMapa + #670, #'Z'
static ResetMapa + #671, #3110
static ResetMapa + #672, #3110
static ResetMapa + #673, #'Z'
static ResetMapa + #674, #3110
static ResetMapa + #675, #' '
static ResetMapa + #676, #' '
static ResetMapa + #677, #' '
static ResetMapa + #678, #' '
static ResetMapa + #679, #' '
static ResetMapa + #680, #' '
static ResetMapa + #681, #' '
static ResetMapa + #682, #' '
static ResetMapa + #683, #' '
static ResetMapa + #684, #' '
static ResetMapa + #685, #3110
static ResetMapa + #686, #'Z'
static ResetMapa + #687, #3110
static ResetMapa + #688, #3110
static ResetMapa + #689, #'Z'
static ResetMapa + #690, #2395
static ResetMapa + #691, #2395
static ResetMapa + #692, #2395
static ResetMapa + #693, #2395
static ResetMapa + #694, #2395
static ResetMapa + #695, #2395
static ResetMapa + #696, #2395
static ResetMapa + #697, #2395
static ResetMapa + #698, #2395
static ResetMapa + #699, #2395
static ResetMapa + #700, #2395
static ResetMapa + #701, #2395
static ResetMapa + #702, #2395
static ResetMapa + #703, #2395
static ResetMapa + #704, #2395
static ResetMapa + #705, #2395
static ResetMapa + #706, #2395
static ResetMapa + #707, #2395
static ResetMapa + #708, #2395
static ResetMapa + #709, #2395
static ResetMapa + #710, #'Z'
static ResetMapa + #711, #3110
static ResetMapa + #712, #3110
static ResetMapa + #713, #'Z'
static ResetMapa + #714, #3110
static ResetMapa + #715, #' '
static ResetMapa + #716, #' '
static ResetMapa + #717, #' '
static ResetMapa + #718, #' '
static ResetMapa + #719, #' '
static ResetMapa + #720, #3105
static ResetMapa + #721, #3109
static ResetMapa + #722, #3109
static ResetMapa + #723, #3109
static ResetMapa + #724, #3109
static ResetMapa + #725, #3106
static ResetMapa + #726, #'Z'
static ResetMapa + #727, #3108
static ResetMapa + #728, #3106
static ResetMapa + #729, #'Z'
static ResetMapa + #730, #2395
static ResetMapa + #731, #2395
static ResetMapa + #732, #2395
static ResetMapa + #733, #2395
static ResetMapa + #734, #2395
static ResetMapa + #735, #2395
static ResetMapa + #736, #2395
static ResetMapa + #737, #2395
static ResetMapa + #738, #2395
static ResetMapa + #739, #2395
static ResetMapa + #740, #2395
static ResetMapa + #741, #2395
static ResetMapa + #742, #2395
static ResetMapa + #743, #2395
static ResetMapa + #744, #2395
static ResetMapa + #745, #2395
static ResetMapa + #746, #2395
static ResetMapa + #747, #2395
static ResetMapa + #748, #2395
static ResetMapa + #749, #2395
static ResetMapa + #750, #'Z'
static ResetMapa + #751, #3108
static ResetMapa + #752, #3106
static ResetMapa + #753, #'Z'
static ResetMapa + #754, #3108
static ResetMapa + #755, #3109
static ResetMapa + #756, #3109
static ResetMapa + #757, #3109
static ResetMapa + #758, #3109
static ResetMapa + #759, #3107
static ResetMapa + #760, #3110
static ResetMapa + #761, #'Z'
static ResetMapa + #762, #'Z'
static ResetMapa + #763, #'Z'
static ResetMapa + #764, #'Z'
static ResetMapa + #765, #'Z'
static ResetMapa + #766, #'Z'
static ResetMapa + #767, #'Z'
static ResetMapa + #768, #'Z'
static ResetMapa + #769, #'Z'
static ResetMapa + #770, #2395
static ResetMapa + #771, #2395
static ResetMapa + #772, #2395
static ResetMapa + #773, #3871
static ResetMapa + #774, #2395
static ResetMapa + #775, #2395
static ResetMapa + #776, #3871
static ResetMapa + #777, #2395
static ResetMapa + #778, #2395
static ResetMapa + #779, #3871
static ResetMapa + #780, #3871
static ResetMapa + #781, #2395
static ResetMapa + #782, #2395
static ResetMapa + #783, #3871
static ResetMapa + #784, #2395
static ResetMapa + #785, #2395
static ResetMapa + #786, #3871
static ResetMapa + #787, #2395
static ResetMapa + #788, #2395
static ResetMapa + #789, #2395
static ResetMapa + #790, #'Z'
static ResetMapa + #791, #'Z'
static ResetMapa + #792, #'Z'
static ResetMapa + #793, #'Z'
static ResetMapa + #794, #'Z'
static ResetMapa + #795, #'Z'
static ResetMapa + #796, #'Z'
static ResetMapa + #797, #'Z'
static ResetMapa + #798, #'Z'
static ResetMapa + #799, #3110
static ResetMapa + #800, #3110
static ResetMapa + #801, #'Z'
static ResetMapa + #802, #3105
static ResetMapa + #803, #3109
static ResetMapa + #804, #3109
static ResetMapa + #805, #3107
static ResetMapa + #806, #'Z'
static ResetMapa + #807, #3105
static ResetMapa + #808, #3107
static ResetMapa + #809, #'Z'
static ResetMapa + #810, #2395
static ResetMapa + #811, #2395
static ResetMapa + #812, #3871
static ResetMapa + #813, #3871
static ResetMapa + #814, #2395
static ResetMapa + #815, #3871
static ResetMapa + #816, #3871
static ResetMapa + #817, #3871
static ResetMapa + #818, #2395
static ResetMapa + #819, #3871
static ResetMapa + #820, #3871
static ResetMapa + #821, #2395
static ResetMapa + #822, #3871
static ResetMapa + #823, #3871
static ResetMapa + #824, #3871
static ResetMapa + #825, #2395
static ResetMapa + #826, #3871
static ResetMapa + #827, #3871
static ResetMapa + #828, #2395
static ResetMapa + #829, #2395
static ResetMapa + #830, #'Z'
static ResetMapa + #831, #3105
static ResetMapa + #832, #3107
static ResetMapa + #833, #'Z'
static ResetMapa + #834, #3105
static ResetMapa + #835, #3109
static ResetMapa + #836, #3109
static ResetMapa + #837, #3107
static ResetMapa + #838, #'Z'
static ResetMapa + #839, #3110
static ResetMapa + #840, #3110
static ResetMapa + #841, #'Z'
static ResetMapa + #842, #3108
static ResetMapa + #843, #3109
static ResetMapa + #844, #3107
static ResetMapa + #845, #3110
static ResetMapa + #846, #'Z'
static ResetMapa + #847, #3108
static ResetMapa + #848, #3106
static ResetMapa + #849, #'Z'
static ResetMapa + #850, #2395
static ResetMapa + #851, #3871
static ResetMapa + #852, #3871
static ResetMapa + #853, #3871
static ResetMapa + #854, #3871
static ResetMapa + #855, #3871
static ResetMapa + #856, #3871
static ResetMapa + #857, #3871
static ResetMapa + #858, #3871
static ResetMapa + #859, #3871
static ResetMapa + #860, #3871
static ResetMapa + #861, #3871
static ResetMapa + #862, #3871
static ResetMapa + #863, #3871
static ResetMapa + #864, #3871
static ResetMapa + #865, #3871
static ResetMapa + #866, #3871
static ResetMapa + #867, #3871
static ResetMapa + #868, #3871
static ResetMapa + #869, #2395
static ResetMapa + #870, #'Z'
static ResetMapa + #871, #3108
static ResetMapa + #872, #3106
static ResetMapa + #873, #'Z'
static ResetMapa + #874, #3110
static ResetMapa + #875, #3105
static ResetMapa + #876, #3109
static ResetMapa + #877, #3106
static ResetMapa + #878, #'Z'
static ResetMapa + #879, #3110
static ResetMapa + #880, #3110
static ResetMapa + #881, #'Z'
static ResetMapa + #882, #'Z'
static ResetMapa + #883, #'Z'
static ResetMapa + #884, #3110
static ResetMapa + #885, #3110
static ResetMapa + #886, #'Z'
static ResetMapa + #887, #'Z'
static ResetMapa + #888, #'Z'
static ResetMapa + #889, #'Z'
static ResetMapa + #890, #'Z'
static ResetMapa + #891, #'Z'
static ResetMapa + #892, #'Z'
static ResetMapa + #893, #'Z'
static ResetMapa + #894, #'Z'
static ResetMapa + #895, #'Z'
static ResetMapa + #896, #'Z'
static ResetMapa + #897, #'Z'
static ResetMapa + #898, #'Z'
static ResetMapa + #899, #'Z'
static ResetMapa + #900, #'Z'
static ResetMapa + #901, #'Z'
static ResetMapa + #902, #'Z'
static ResetMapa + #903, #'Z'
static ResetMapa + #904, #'Z'
static ResetMapa + #905, #'Z'
static ResetMapa + #906, #'Z'
static ResetMapa + #907, #'Z'
static ResetMapa + #908, #'Z'
static ResetMapa + #909, #'Z'
static ResetMapa + #910, #'Z'
static ResetMapa + #911, #'Z'
static ResetMapa + #912, #'Z'
static ResetMapa + #913, #'Z'
static ResetMapa + #914, #3110
static ResetMapa + #915, #3110
static ResetMapa + #916, #'Z'
static ResetMapa + #917, #'Z'
static ResetMapa + #918, #'Z'
static ResetMapa + #919, #3110
static ResetMapa + #920, #3108
static ResetMapa + #921, #3109
static ResetMapa + #922, #3107
static ResetMapa + #923, #'Z'
static ResetMapa + #924, #3110
static ResetMapa + #925, #3110
static ResetMapa + #926, #'Z'
static ResetMapa + #927, #3105
static ResetMapa + #928, #3107
static ResetMapa + #929, #'Z'
static ResetMapa + #930, #3105
static ResetMapa + #931, #3109
static ResetMapa + #932, #3109
static ResetMapa + #933, #3109
static ResetMapa + #934, #3109
static ResetMapa + #935, #3109
static ResetMapa + #936, #3109
static ResetMapa + #937, #3109
static ResetMapa + #938, #3109
static ResetMapa + #939, #3109
static ResetMapa + #940, #3109
static ResetMapa + #941, #3109
static ResetMapa + #942, #3109
static ResetMapa + #943, #3109
static ResetMapa + #944, #3109
static ResetMapa + #945, #3109
static ResetMapa + #946, #3109
static ResetMapa + #947, #3109
static ResetMapa + #948, #3109
static ResetMapa + #949, #3107
static ResetMapa + #950, #'Z'
static ResetMapa + #951, #3105
static ResetMapa + #952, #3107
static ResetMapa + #953, #'Z'
static ResetMapa + #954, #3110
static ResetMapa + #955, #3110
static ResetMapa + #956, #'Z'
static ResetMapa + #957, #3105
static ResetMapa + #958, #3109
static ResetMapa + #959, #3106
static ResetMapa + #960, #3105
static ResetMapa + #961, #3109
static ResetMapa + #962, #3106
static ResetMapa + #963, #'Z'
static ResetMapa + #964, #3108
static ResetMapa + #965, #3106
static ResetMapa + #966, #'Z'
static ResetMapa + #967, #3110
static ResetMapa + #968, #3110
static ResetMapa + #969, #'Z'
static ResetMapa + #970, #3110
static ResetMapa + #971, #'Z'
static ResetMapa + #972, #'Z'
static ResetMapa + #973, #'Z'
static ResetMapa + #974, #'Z'
static ResetMapa + #975, #'Z'
static ResetMapa + #976, #'Z'
static ResetMapa + #977, #'Z'
static ResetMapa + #978, #'Z'
static ResetMapa + #979, #'Z'
static ResetMapa + #980, #'Z'
static ResetMapa + #981, #'Z'
static ResetMapa + #982, #'Z'
static ResetMapa + #983, #'Z'
static ResetMapa + #984, #'Z'
static ResetMapa + #985, #'Z'
static ResetMapa + #986, #'Z'
static ResetMapa + #987, #'Z'
static ResetMapa + #988, #'Z'
static ResetMapa + #989, #3110
static ResetMapa + #990, #'Z'
static ResetMapa + #991, #3110
static ResetMapa + #992, #3110
static ResetMapa + #993, #'Z'
static ResetMapa + #994, #3108
static ResetMapa + #995, #3106
static ResetMapa + #996, #'Z'
static ResetMapa + #997, #3108
static ResetMapa + #998, #3109
static ResetMapa + #999, #3107
static ResetMapa + #1000, #3110
static ResetMapa + #1001, #'Z'
static ResetMapa + #1002, #'Z'
static ResetMapa + #1003, #'Z'
static ResetMapa + #1004, #'Z'
static ResetMapa + #1005, #'Z'
static ResetMapa + #1006, #'Z'
static ResetMapa + #1007, #3110
static ResetMapa + #1008, #3110
static ResetMapa + #1009, #'Z'
static ResetMapa + #1010, #3110
static ResetMapa + #1011, #'Z'
static ResetMapa + #1012, #'Z'
static ResetMapa + #1013, #'Z'
static ResetMapa + #1014, #'Z'
static ResetMapa + #1015, #'Z'
static ResetMapa + #1016, #'Z'
static ResetMapa + #1017, #'Z'
static ResetMapa + #1018, #'Z'
static ResetMapa + #1019, #'Z'
static ResetMapa + #1020, #'Z'
static ResetMapa + #1021, #'Z'
static ResetMapa + #1022, #'Z'
static ResetMapa + #1023, #'Z'
static ResetMapa + #1024, #'Z'
static ResetMapa + #1025, #'Z'
static ResetMapa + #1026, #'Z'
static ResetMapa + #1027, #'Z'
static ResetMapa + #1028, #'Z'
static ResetMapa + #1029, #3110
static ResetMapa + #1030, #'Z'
static ResetMapa + #1031, #3110
static ResetMapa + #1032, #3110
static ResetMapa + #1033, #'Z'
static ResetMapa + #1034, #'Z'
static ResetMapa + #1035, #'Z'
static ResetMapa + #1036, #'Z'
static ResetMapa + #1037, #'Z'
static ResetMapa + #1038, #'Z'
static ResetMapa + #1039, #3110
static ResetMapa + #1040, #3110
static ResetMapa + #1041, #'Z'
static ResetMapa + #1042, #3102
static ResetMapa + #1043, #3109
static ResetMapa + #1044, #3109
static ResetMapa + #1045, #3109
static ResetMapa + #1046, #3109
static ResetMapa + #1047, #3109
static ResetMapa + #1048, #3106
static ResetMapa + #1049, #'Z'
static ResetMapa + #1050, #3108
static ResetMapa + #1051, #3109
static ResetMapa + #1052, #3109
static ResetMapa + #1053, #3109
static ResetMapa + #1054, #3109
static ResetMapa + #1055, #3109
static ResetMapa + #1056, #3109
static ResetMapa + #1057, #3109
static ResetMapa + #1058, #3103
static ResetMapa + #1059, #' '
static ResetMapa + #1060, #' '
static ResetMapa + #1061, #3102
static ResetMapa + #1062, #3109
static ResetMapa + #1063, #3109
static ResetMapa + #1064, #3109
static ResetMapa + #1065, #3109
static ResetMapa + #1066, #3109
static ResetMapa + #1067, #3109
static ResetMapa + #1068, #3109
static ResetMapa + #1069, #3106
static ResetMapa + #1070, #'Z'
static ResetMapa + #1071, #3108
static ResetMapa + #1072, #3109
static ResetMapa + #1073, #3109
static ResetMapa + #1074, #3109
static ResetMapa + #1075, #3109
static ResetMapa + #1076, #3109
static ResetMapa + #1077, #3103
static ResetMapa + #1078, #'Z'
static ResetMapa + #1079, #3110
static ResetMapa + #1080, #3110
static ResetMapa + #1081, #39
static ResetMapa + #1082, #'Z'
static ResetMapa + #1083, #'Z'
static ResetMapa + #1084, #'Z'
static ResetMapa + #1085, #'Z'
static ResetMapa + #1086, #'Z'
static ResetMapa + #1087, #'Z'
static ResetMapa + #1088, #'Z'
static ResetMapa + #1089, #'Z'
static ResetMapa + #1090, #'Z'
static ResetMapa + #1091, #'Z'
static ResetMapa + #1092, #'Z'
static ResetMapa + #1093, #'Z'
static ResetMapa + #1094, #'Z'
static ResetMapa + #1095, #'Z'
static ResetMapa + #1096, #'Z'
static ResetMapa + #1097, #'Z'
static ResetMapa + #1098, #'Z'
static ResetMapa + #1099, #'Z'
static ResetMapa + #1100, #'Z'
static ResetMapa + #1101, #'Z'
static ResetMapa + #1102, #'Z'
static ResetMapa + #1103, #'Z'
static ResetMapa + #1104, #'Z'
static ResetMapa + #1105, #'Z'
static ResetMapa + #1106, #'Z'
static ResetMapa + #1107, #'Z'
static ResetMapa + #1108, #'Z'
static ResetMapa + #1109, #'Z'
static ResetMapa + #1110, #'Z'
static ResetMapa + #1111, #'Z'
static ResetMapa + #1112, #'Z'
static ResetMapa + #1113, #'Z'
static ResetMapa + #1114, #'Z'
static ResetMapa + #1115, #'Z'
static ResetMapa + #1116, #'Z'
static ResetMapa + #1117, #'Z'
static ResetMapa + #1118, #39
static ResetMapa + #1119, #3110
static ResetMapa + #1120, #3108
static ResetMapa + #1121, #3109
static ResetMapa + #1122, #3109
static ResetMapa + #1123, #3109
static ResetMapa + #1124, #3109
static ResetMapa + #1125, #3109
static ResetMapa + #1126, #3109
static ResetMapa + #1127, #3109
static ResetMapa + #1128, #3109
static ResetMapa + #1129, #3109
static ResetMapa + #1130, #3109
static ResetMapa + #1131, #3109
static ResetMapa + #1132, #3109
static ResetMapa + #1133, #3109
static ResetMapa + #1134, #3109
static ResetMapa + #1135, #3109
static ResetMapa + #1136, #3109
static ResetMapa + #1137, #3109
static ResetMapa + #1138, #3109
static ResetMapa + #1139, #3109
static ResetMapa + #1140, #3109
static ResetMapa + #1141, #3109
static ResetMapa + #1142, #3109
static ResetMapa + #1143, #3109
static ResetMapa + #1144, #3109
static ResetMapa + #1145, #3109
static ResetMapa + #1146, #3109
static ResetMapa + #1147, #3109
static ResetMapa + #1148, #3109
static ResetMapa + #1149, #3109
static ResetMapa + #1150, #3109
static ResetMapa + #1151, #3109
static ResetMapa + #1152, #3109
static ResetMapa + #1153, #3109
static ResetMapa + #1154, #3109
static ResetMapa + #1155, #3109
static ResetMapa + #1156, #3109
static ResetMapa + #1157, #3109
static ResetMapa + #1158, #3109
static ResetMapa + #1159, #3106
static ResetMapa + #1160, #'S'
static ResetMapa + #1161, #'C'
static ResetMapa + #1162, #'O'
static ResetMapa + #1163, #'R'
static ResetMapa + #1164, #'E'
static ResetMapa + #1165, #' '
static ResetMapa + #1166, #'0'
static ResetMapa + #1167, #'0'
static ResetMapa + #1168, #'0'
static ResetMapa + #1169, #'0'
static ResetMapa + #1170, #' '
static ResetMapa + #1171, #' '
static ResetMapa + #1172, #' '
static ResetMapa + #1173, #' '
static ResetMapa + #1174, #' '
static ResetMapa + #1175, #' '
static ResetMapa + #1176, #' '
static ResetMapa + #1177, #' '
static ResetMapa + #1178, #' '
static ResetMapa + #1179, #' '
static ResetMapa + #1180, #' '
static ResetMapa + #1181, #' '
static ResetMapa + #1182, #'L'
static ResetMapa + #1183, #'I'
static ResetMapa + #1184, #'V'
static ResetMapa + #1185, #'E'
static ResetMapa + #1186, #'S'
static ResetMapa + #1187, #' '
static ResetMapa + #1188, #2877
static ResetMapa + #1189, #2877
static ResetMapa + #1190, #2877
static ResetMapa + #1191, #' '
static ResetMapa + #1192, #' '
static ResetMapa + #1193, #' '
static ResetMapa + #1194, #' '
static ResetMapa + #1195, #' '
static ResetMapa + #1196, #' '
static ResetMapa + #1197, #' '
static ResetMapa + #1198, #' '
static ResetMapa + #1199, #' '


; objetivamos -> objetivou-se

; ---------- colisao ------------
colisaoFant:
	push r1
	load r1, PosicaoPacman

	cmp r2, r1	; posicao do fantasma
	ceq perdeVidas

	pop r1
	rts
; ---------- colisao ------------


; --------- perde vidas ---------
perdeVidas:
	push r4
	push r5

	loadn r4, #0
	load r5, numeroVidas

	cmp r4, r5
	jeq gameOver

	dec r5
	store numeroVidas, r5

	load r4, posicaoVidas ; posicao das vidas
	loadn r5, #' '				; espaco
	outchar r5, r4

	dec r4
	store posicaoVidas, r4

pv_fim:
	pop r5
	pop r4
	rts

gameOver:
	loadn r4, #1
	store flagVitoria, r4

	jmp pv_fim
; --------- perde vidas ---------



; --------- fantasmas -----------
colisaoFantasma:
	push r5
	push r6
	push r7

	loadn r5, #MapaInicial
	add r5, r5, r2

	loadi r7, r5					; carrega o caracter que esta na posicao r0 do mapa
	loadn r6, #2395				; carrega o muro

	cmp r7, r6						; se o caracter nao for o muro
	jle continuaFantasma	; tudo bem, continua
	jmp bateuFantasma

continuaFantasma:
	call colisaoFant
	loadn r3, #0
	jmp colisaoFantasmaFim

bateuFantasma:
	loadn r3, #1
	jmp colisaoFantasmaFim

colisaoFantasmaFim:
	pop r7
	pop r6
	pop r5
	rts







; ---------- ESQUERDA ----------------

Fantasma_esq:
	push r2
	push r3
	push r4

	mov r2, r1

	dec r2
	call colisaoFantasma
	inc r2

	loadn r4, #1
	cmp r4, r3
	jeq F1_c

	; ----- apaga posicao anterior ---------
	loadn r4, #MapaInicial
	add r4, r4, r2
	loadi r3, r4
	outchar r3, r2
	; ----- apaga posicao anterior ---------

	dec r2
	mov r3, r5
	loadn r4, #0
	cmp r3, r4
	jeq F1_a
	jmp F1_b

F1_a:
	loadn r5, #1

	outchar r6, r2

	jmp F1_c

F1_b:
	loadn r5, #0

	outchar r7, r2

	jmp F1_c

F1_c:
	mov r1, r2
	pop r4
	pop r3
	pop r2
	rts

; ---------- ESQUERDA ----------------








; ----------- DIREITA ----------------

Fantasma_dir:
	push r2
	push r3
	push r4

	mov r2, r1

	inc r2
	call colisaoFantasma
	dec r2

	loadn r4, #1
	cmp r4, r3
	jeq F1_ca

	; ----- apaga posicao anterior ---------
	loadn r4, #MapaInicial
	add r4, r4, r2
	loadi r3, r4
	outchar r3, r2
	; ----- apaga posicao anterior ---------

	inc r2
	mov r3, r5
	loadn r4, #0
	cmp r3, r4
	jeq F1_aa
	jmp F1_ba

F1_aa:
	loadn r5, #1
	outchar r6, r2

	jmp F1_ca

F1_ba:
	loadn r5, #0
	outchar r7, r2

	jmp F1_ca

F1_ca:
	mov r1, r2
	pop r4
	pop r3
	pop r2
	rts

; ----------- DIREITA ----------------







; ------------- SOBE ----------------

Fantasma_sobe:
	push r2
	push r3
	push r4

	mov r2, r1

	loadn r4, #40

	sub r2, r2, r4
	call colisaoFantasma
	add r2, r2, r4

	loadn r4, #1
	cmp r4, r3
	jeq F1_cb

	; ----- apaga posicao anterior ---------
	loadn r4, #MapaInicial
	add r4, r4, r2
	loadi r3, r4
	outchar r3, r2
	; ----- apaga posicao anterior ---------

	loadn r3, #40

	sub r2, r2, r3
	mov r3, r5
	loadn r4, #0
	cmp r3, r4
	jeq F1_ab
	jmp F1_bb

F1_ab:
	loadn r5, #1
	outchar r6, r2

	jmp F1_cb

F1_bb:
	loadn r5, #0
	outchar r7, r2

	jmp F1_cb

F1_cb:
	mov r1, r2
	pop r4
	pop r3
	pop r2
	rts
; ------------- SOBE ----------------






; ------------ Desce ----------------
Fantasma_desce:
	push r2
	push r3
	push r4

	mov r2, r1

	loadn r4, #40

	add r2, r2, r4
	call colisaoFantasma
	sub r2, r2, r4

	loadn r4, #1
	cmp r4, r3
	jeq F1_cc

	; ----- apaga posicao anterior ---------
	loadn r4, #MapaInicial
	add r4, r4, r2
	loadi r3, r4
	outchar r3, r2
	; ----- apaga posicao anterior ---------

	loadn r3, #40

	add r2, r2, r3
	mov r3, r5
	loadn r4, #0
	cmp r3, r4
	jeq F1_ac
	jmp F1_bc

F1_ac:
	loadn r5, #1
	outchar r6, r2

	jmp F1_cc

F1_bc:
	loadn r5, #0
	outchar r7, r2

	jmp F1_cc

F1_cc:
	mov r1, r2
	pop r4
	pop r3
	pop r2
	rts
; ------------ Desce ----------------




; --------- fantasma1 -----------
F1_esq:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F1_k

	load r6, caracterFantasma1Esq2
	load r7, caracterFantasma1Esq1
	jmp F1_p

F1_k:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F1_p:
	load r1, posFantasma1
	load r5, estadoFantasma1

	call Fantasma_esq

	store estadoFantasma1, r5
	store posFantasma1, r1

	pop r6
	pop r5
	pop r1
	rts

F1_dir:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F1_ka

	load r6, caracterFantasma1Dir2
	load r7, caracterFantasma1Dir1
	jmp F1_pa

F1_ka:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F1_pa:
	load r1, posFantasma1
	load r5, estadoFantasma1

	call Fantasma_dir

	store estadoFantasma1, r5
	store posFantasma1, r1

	pop r6
	pop r5
	pop r1
	rts


F1_sobe:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F1_kb

	load r6, caracterFantasma1Dir2
	load r7, caracterFantasma1Dir1
	jmp F1_pb

F1_kb:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F1_pb:
	load r1, posFantasma1
	load r5, estadoFantasma1

	call Fantasma_sobe

	store estadoFantasma1, r5
	store posFantasma1, r1

	pop r6
	pop r5
	pop r1
	rts


F1_desce:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F1_kc

	load r6, caracterFantasma1Esq2
	load r7, caracterFantasma1Esq1
	jmp F1_pc

F1_kc:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F1_pc:
	load r1, posFantasma1
	load r5, estadoFantasma1

	call Fantasma_desce

	store estadoFantasma1, r5
	store posFantasma1, r1

	pop r6
	pop r5
	pop r1
	rts








; --------- fantasma2 -----------
F2_esq:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F2_k

	load r6, caracterFantasma2Esq2
	load r7, caracterFantasma2Esq1
	jmp F2_p

F2_k:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F2_p:
	load r1, posFantasma2
	load r5, estadoFantasma2

	call Fantasma_esq

	store estadoFantasma2, r5
	store posFantasma2, r1

	pop r6
	pop r5
	pop r1
	rts

F2_dir:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F2_ka

	load r6, caracterFantasma2Dir2
	load r7, caracterFantasma2Dir1
	jmp F2_pa

F2_ka:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F2_pa:
	load r1, posFantasma2
	load r5, estadoFantasma2

	call Fantasma_dir

	store estadoFantasma2, r5
	store posFantasma2, r1

	pop r6
	pop r5
	pop r1
	rts


F2_sobe:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F2_kb

	load r6, caracterFantasma2Dir2
	load r7, caracterFantasma2Dir1
	jmp F2_pb

F2_kb:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F2_pb:
	load r1, posFantasma2
	load r5, estadoFantasma2

	call Fantasma_sobe

	store estadoFantasma2, r5
	store posFantasma2, r1

	pop r6
	pop r5
	pop r1
	rts


F2_desce:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F2_kc

	load r6, caracterFantasma2Esq2
	load r7, caracterFantasma2Esq1
	jmp F2_pc

F2_kc:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F2_pc:
	load r1, posFantasma2
	load r5, estadoFantasma2

	call Fantasma_desce

	store estadoFantasma2, r5
	store posFantasma2, r1

	pop r6
	pop r5
	pop r1
	rts








; --------- fantasma3 -----------
F3_esq:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F3_k

	load r6, caracterFantasma3Esq2
	load r7, caracterFantasma3Esq1
	jmp F3_p

F3_k:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F3_p:
	load r1, posFantasma3
	load r5, estadoFantasma3

	call Fantasma_esq

	store estadoFantasma3, r5
	store posFantasma3, r1

	pop r6
	pop r5
	pop r1
	rts

F3_dir:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F3_ka

	load r6, caracterFantasma3Dir2
	load r7, caracterFantasma3Dir1
	jmp F3_pa

F3_ka:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F3_pa:
	load r1, posFantasma3
	load r5, estadoFantasma3

	call Fantasma_dir

	store estadoFantasma3, r5
	store posFantasma3, r1

	pop r6
	pop r5
	pop r1
	rts


F3_sobe:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F3_kb

	load r6, caracterFantasma3Dir2
	load r7, caracterFantasma3Dir1
	jmp F3_pb

F3_kb:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F3_pb:
	load r1, posFantasma3
	load r5, estadoFantasma3

	call Fantasma_sobe

	store estadoFantasma3, r5
	store posFantasma3, r1

	pop r6
	pop r5
	pop r1
	rts


F3_desce:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F3_kc

	load r6, caracterFantasma3Esq2
	load r7, caracterFantasma3Esq1
	jmp F3_pc

F3_kc:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F3_pc:
	load r1, posFantasma3
	load r5, estadoFantasma3

	call Fantasma_desce

	store estadoFantasma3, r5
	store posFantasma3, r1

	pop r6
	pop r5
	pop r1
	rts











; --------- fantasma4 -----------
F4_esq:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F4_k

	load r6, caracterFantasma4Esq2
	load r7, caracterFantasma4Esq1
	jmp F4_p

F4_k:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F4_p:
	load r1, posFantasma4
	load r5, estadoFantasma4

	call Fantasma_esq

	store estadoFantasma4, r5
	store posFantasma4, r1

	pop r6
	pop r5
	pop r1
	rts

F4_dir:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F4_ka

	load r6, caracterFantasma4Dir2
	load r7, caracterFantasma4Dir1
	jmp F4_pa

F4_ka:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F4_pa:
	load r1, posFantasma4
	load r5, estadoFantasma4

	call Fantasma_dir

	store estadoFantasma4, r5
	store posFantasma4, r1

	pop r6
	pop r5
	pop r1
	rts


F4_sobe:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F4_kb

	load r6, caracterFantasma4Dir2
	load r7, caracterFantasma4Dir1
	jmp F4_pb

F4_kb:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F4_pb:
	load r1, posFantasma4
	load r5, estadoFantasma4

	call Fantasma_sobe

	store estadoFantasma4, r5
	store posFantasma4, r1

	pop r6
	pop r5
	pop r1
	rts


F4_desce:
	push r1
	push r5
	push r6

	loadn r1, #1
	load r5, fantasmaEstaDoente
	cmp r1, r5
	jeq F4_kc

	load r6, caracterFantasma4Esq2
	load r7, caracterFantasma4Esq1
	jmp F4_pc

F4_kc:
	load r6, caracterFantasmaDoente
	load r7, caracterFantasmaDoente

F4_pc:
	load r1, posFantasma4
	load r5, estadoFantasma4

	call Fantasma_desce

	store estadoFantasma4, r5
	store posFantasma4, r1

	pop r6
	pop r5
	pop r1
	rts















; ---------- Encerramento ---------------
Encerramento:
	push r1
	push r2

	loadn r1, #0
	; loadn r2, #13 ; numero do enter
	loadn r2, #5
	
encerramento_volta:
	ir r1
	cmp r1, r2
	jeq encerramento_fim	; se for o enter
	call piscaPressContinue
	jmp encerramento_volta


encerramento_fim:
	pop r2
	pop r1
	rts
; ---------- Encerramento ---------------


; ------- Imprime Encerramento ----------
ImprimeEncerramento:
	push r0
	loadn r0, #telaEncerramento;
	call CarregaMapa
	pop r0
	rts
; ------- Imprime Encerramento ----------


; ---- Pisca Press Continue -------------
piscaPressContinue:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r2, timerStart
	loadn r3, #600

	cmp r2, r3
	jeq ppc_a
	jmp ppc_fim

ppc_a:
	load r2, estadoContinue
	loadn r3, #0

	cmp r2, r3
	jeq ppc_visivel
	jmp ppc_escondido

ppc_visivel:
	loadn r2, #1
	store estadoContinue, r2
	loadn r2, #continue1
	jmp ppc_c

ppc_escondido:
	loadn r2, #0
	store estadoContinue, r2
	loadn r2, #continue2
	jmp ppc_c

ppc_c:
	loadn r0, #928	; posicao de impressao

	loadn r3, #23
	loadn r4, #0

asdfa:
	cmp r3, r4
	jeq ddddd

	loadi r5, r2
	outchar r5, r0

	inc r0
	inc r2
	inc r4
	jmp asdfa

ddddd:
	loadn r2, #0
	jmp ppc_fim

ppc_fim:
	inc r2
	store timerStart, r2

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
; ---- Pisca Press Continue -------------

continue1 : var #23

static continue1 + #0, #'P'
static continue1 + #1, #'R'
static continue1 + #2, #'E'
static continue1 + #3, #'S'
static continue1 + #4, #'S'
static continue1 + #5, #' '
static continue1 + #6, #'E'
static continue1 + #7, #'N'
static continue1 + #8, #'T'
static continue1 + #9, #'E'
static continue1 + #10, #'R'
static continue1 + #11, #' '
static continue1 + #12, #'T'
static continue1 + #13, #'O'
static continue1 + #14, #' '
static continue1 + #15, #'C'
static continue1 + #16, #'O'
static continue1 + #17, #'N'
static continue1 + #18, #'T'
static continue1 + #19, #'I'
static continue1 + #20, #'N'
static continue1 + #21, #'U'
static continue1 + #22, #'E'


continue2 : var #23

static continue2 + #0, #' '
static continue2 + #1, #' '
static continue2 + #2, #' '
static continue2 + #3, #' '
static continue2 + #4, #' '
static continue2 + #5, #' '
static continue2 + #6, #' '
static continue2 + #7, #' '
static continue2 + #8, #' '
static continue2 + #9, #' '
static continue2 + #10, #' '
static continue2 + #11, #' '
static continue2 + #12, #' '
static continue2 + #13, #' '
static continue2 + #14, #' '
static continue2 + #15, #' '
static continue2 + #16, #' '
static continue2 + #17, #' '
static continue2 + #18, #' '
static continue2 + #19, #' '
static continue2 + #20, #' '
static continue2 + #21, #' '
static continue2 + #22, #' '





telaEncerramento : var #1200

static telaEncerramento + #0, #' '
static telaEncerramento + #1, #' '
static telaEncerramento + #2, #' '
static telaEncerramento + #3, #' '
static telaEncerramento + #4, #' '
static telaEncerramento + #5, #' '
static telaEncerramento + #6, #' '
static telaEncerramento + #7, #' '
static telaEncerramento + #8, #' '
static telaEncerramento + #9, #' '
static telaEncerramento + #10, #' '
static telaEncerramento + #11, #' '
static telaEncerramento + #12, #' '
static telaEncerramento + #13, #' '
static telaEncerramento + #14, #' '
static telaEncerramento + #15, #' '
static telaEncerramento + #16, #' '
static telaEncerramento + #17, #' '
static telaEncerramento + #18, #' '
static telaEncerramento + #19, #' '
static telaEncerramento + #20, #' '
static telaEncerramento + #21, #' '
static telaEncerramento + #22, #' '
static telaEncerramento + #23, #' '
static telaEncerramento + #24, #' '
static telaEncerramento + #25, #' '
static telaEncerramento + #26, #' '
static telaEncerramento + #27, #' '
static telaEncerramento + #28, #' '
static telaEncerramento + #29, #' '
static telaEncerramento + #30, #' '
static telaEncerramento + #31, #' '
static telaEncerramento + #32, #' '
static telaEncerramento + #33, #' '
static telaEncerramento + #34, #' '
static telaEncerramento + #35, #' '
static telaEncerramento + #36, #' '
static telaEncerramento + #37, #' '
static telaEncerramento + #38, #' '
static telaEncerramento + #39, #' '
static telaEncerramento + #40, #' '
static telaEncerramento + #41, #' '
static telaEncerramento + #42, #' '
static telaEncerramento + #43, #' '
static telaEncerramento + #44, #' '
static telaEncerramento + #45, #' '
static telaEncerramento + #46, #' '
static telaEncerramento + #47, #' '
static telaEncerramento + #48, #' '
static telaEncerramento + #49, #' '
static telaEncerramento + #50, #' '
static telaEncerramento + #51, #' '
static telaEncerramento + #52, #' '
static telaEncerramento + #53, #' '
static telaEncerramento + #54, #' '
static telaEncerramento + #55, #' '
static telaEncerramento + #56, #' '
static telaEncerramento + #57, #' '
static telaEncerramento + #58, #' '
static telaEncerramento + #59, #' '
static telaEncerramento + #60, #' '
static telaEncerramento + #61, #' '
static telaEncerramento + #62, #' '
static telaEncerramento + #63, #' '
static telaEncerramento + #64, #' '
static telaEncerramento + #65, #' '
static telaEncerramento + #66, #' '
static telaEncerramento + #67, #' '
static telaEncerramento + #68, #' '
static telaEncerramento + #69, #' '
static telaEncerramento + #70, #' '
static telaEncerramento + #71, #' '
static telaEncerramento + #72, #' '
static telaEncerramento + #73, #' '
static telaEncerramento + #74, #' '
static telaEncerramento + #75, #' '
static telaEncerramento + #76, #' '
static telaEncerramento + #77, #' '
static telaEncerramento + #78, #' '
static telaEncerramento + #79, #' '
static telaEncerramento + #80, #' '
static telaEncerramento + #81, #' '
static telaEncerramento + #82, #' '
static telaEncerramento + #83, #' '
static telaEncerramento + #84, #' '
static telaEncerramento + #85, #' '
static telaEncerramento + #86, #' '
static telaEncerramento + #87, #' '
static telaEncerramento + #88, #' '
static telaEncerramento + #89, #' '
static telaEncerramento + #90, #' '
static telaEncerramento + #91, #' '
static telaEncerramento + #92, #' '
static telaEncerramento + #93, #' '
static telaEncerramento + #94, #' '
static telaEncerramento + #95, #' '
static telaEncerramento + #96, #' '
static telaEncerramento + #97, #' '
static telaEncerramento + #98, #' '
static telaEncerramento + #99, #' '
static telaEncerramento + #100, #' '
static telaEncerramento + #101, #' '
static telaEncerramento + #102, #' '
static telaEncerramento + #103, #' '
static telaEncerramento + #104, #' '
static telaEncerramento + #105, #' '
static telaEncerramento + #106, #' '
static telaEncerramento + #107, #' '
static telaEncerramento + #108, #' '
static telaEncerramento + #109, #' '
static telaEncerramento + #110, #' '
static telaEncerramento + #111, #' '
static telaEncerramento + #112, #' '
static telaEncerramento + #113, #' '
static telaEncerramento + #114, #' '
static telaEncerramento + #115, #' '
static telaEncerramento + #116, #' '
static telaEncerramento + #117, #' '
static telaEncerramento + #118, #' '
static telaEncerramento + #119, #' '
static telaEncerramento + #120, #' '
static telaEncerramento + #121, #' '
static telaEncerramento + #122, #' '
static telaEncerramento + #123, #2395
static telaEncerramento + #124, #2395
static telaEncerramento + #125, #2395
static telaEncerramento + #126, #2395
static telaEncerramento + #127, #' '
static telaEncerramento + #128, #' '
static telaEncerramento + #129, #' '
static telaEncerramento + #130, #' '
static telaEncerramento + #131, #' '
static telaEncerramento + #132, #' '
static telaEncerramento + #133, #' '
static telaEncerramento + #134, #' '
static telaEncerramento + #135, #' '
static telaEncerramento + #136, #' '
static telaEncerramento + #137, #' '
static telaEncerramento + #138, #' '
static telaEncerramento + #139, #' '
static telaEncerramento + #140, #' '
static telaEncerramento + #141, #' '
static telaEncerramento + #142, #' '
static telaEncerramento + #143, #' '
static telaEncerramento + #144, #' '
static telaEncerramento + #145, #' '
static telaEncerramento + #146, #' '
static telaEncerramento + #147, #' '
static telaEncerramento + #148, #' '
static telaEncerramento + #149, #' '
static telaEncerramento + #150, #' '
static telaEncerramento + #151, #' '
static telaEncerramento + #152, #' '
static telaEncerramento + #153, #' '
static telaEncerramento + #154, #' '
static telaEncerramento + #155, #' '
static telaEncerramento + #156, #' '
static telaEncerramento + #157, #' '
static telaEncerramento + #158, #' '
static telaEncerramento + #159, #' '
static telaEncerramento + #160, #' '
static telaEncerramento + #161, #' '
static telaEncerramento + #162, #2395
static telaEncerramento + #163, #2395
static telaEncerramento + #164, #' '
static telaEncerramento + #165, #' '
static telaEncerramento + #166, #2395
static telaEncerramento + #167, #2395
static telaEncerramento + #168, #' '
static telaEncerramento + #169, #' '
static telaEncerramento + #170, #2395
static telaEncerramento + #171, #' '
static telaEncerramento + #172, #' '
static telaEncerramento + #173, #2395
static telaEncerramento + #174, #' '
static telaEncerramento + #175, #' '
static telaEncerramento + #176, #' '
static telaEncerramento + #177, #2395
static telaEncerramento + #178, #' '
static telaEncerramento + #179, #2395
static telaEncerramento + #180, #2395
static telaEncerramento + #181, #2395
static telaEncerramento + #182, #' '
static telaEncerramento + #183, #2395
static telaEncerramento + #184, #2395
static telaEncerramento + #185, #2395
static telaEncerramento + #186, #' '
static telaEncerramento + #187, #2395
static telaEncerramento + #188, #' '
static telaEncerramento + #189, #2395
static telaEncerramento + #190, #' '
static telaEncerramento + #191, #2395
static telaEncerramento + #192, #2395
static telaEncerramento + #193, #2395
static telaEncerramento + #194, #' '
static telaEncerramento + #195, #2395
static telaEncerramento + #196, #2395
static telaEncerramento + #197, #' '
static telaEncerramento + #198, #' '
static telaEncerramento + #199, #' '
static telaEncerramento + #200, #' '
static telaEncerramento + #201, #' '
static telaEncerramento + #202, #2395
static telaEncerramento + #203, #2395
static telaEncerramento + #204, #' '
static telaEncerramento + #205, #' '
static telaEncerramento + #206, #' '
static telaEncerramento + #207, #' '
static telaEncerramento + #208, #' '
static telaEncerramento + #209, #2395
static telaEncerramento + #210, #' '
static telaEncerramento + #211, #2395
static telaEncerramento + #212, #' '
static telaEncerramento + #213, #2395
static telaEncerramento + #214, #2395
static telaEncerramento + #215, #' '
static telaEncerramento + #216, #2395
static telaEncerramento + #217, #2395
static telaEncerramento + #218, #' '
static telaEncerramento + #219, #2395
static telaEncerramento + #220, #' '
static telaEncerramento + #221, #' '
static telaEncerramento + #222, #' '
static telaEncerramento + #223, #2395
static telaEncerramento + #224, #' '
static telaEncerramento + #225, #2395
static telaEncerramento + #226, #' '
static telaEncerramento + #227, #2395
static telaEncerramento + #228, #' '
static telaEncerramento + #229, #2395
static telaEncerramento + #230, #' '
static telaEncerramento + #231, #2395
static telaEncerramento + #232, #' '
static telaEncerramento + #233, #' '
static telaEncerramento + #234, #' '
static telaEncerramento + #235, #2395
static telaEncerramento + #236, #' '
static telaEncerramento + #237, #2395
static telaEncerramento + #238, #' '
static telaEncerramento + #239, #' '
static telaEncerramento + #240, #' '
static telaEncerramento + #241, #' '
static telaEncerramento + #242, #2395
static telaEncerramento + #243, #2395
static telaEncerramento + #244, #' '
static telaEncerramento + #245, #2395
static telaEncerramento + #246, #2395
static telaEncerramento + #247, #2395
static telaEncerramento + #248, #' '
static telaEncerramento + #249, #2395
static telaEncerramento + #250, #' '
static telaEncerramento + #251, #2395
static telaEncerramento + #252, #' '
static telaEncerramento + #253, #2395
static telaEncerramento + #254, #' '
static telaEncerramento + #255, #2395
static telaEncerramento + #256, #' '
static telaEncerramento + #257, #2395
static telaEncerramento + #258, #' '
static telaEncerramento + #259, #2395
static telaEncerramento + #260, #2395
static telaEncerramento + #261, #2395
static telaEncerramento + #262, #' '
static telaEncerramento + #263, #2395
static telaEncerramento + #264, #' '
static telaEncerramento + #265, #2395
static telaEncerramento + #266, #' '
static telaEncerramento + #267, #2395
static telaEncerramento + #268, #' '
static telaEncerramento + #269, #2395
static telaEncerramento + #270, #' '
static telaEncerramento + #271, #2395
static telaEncerramento + #272, #2395
static telaEncerramento + #273, #2395
static telaEncerramento + #274, #' '
static telaEncerramento + #275, #2395
static telaEncerramento + #276, #' '
static telaEncerramento + #277, #2395
static telaEncerramento + #278, #' '
static telaEncerramento + #279, #' '
static telaEncerramento + #280, #' '
static telaEncerramento + #281, #' '
static telaEncerramento + #282, #2395
static telaEncerramento + #283, #2395
static telaEncerramento + #284, #' '
static telaEncerramento + #285, #' '
static telaEncerramento + #286, #2395
static telaEncerramento + #287, #2395
static telaEncerramento + #288, #' '
static telaEncerramento + #289, #2395
static telaEncerramento + #290, #2395
static telaEncerramento + #291, #2395
static telaEncerramento + #292, #' '
static telaEncerramento + #293, #2395
static telaEncerramento + #294, #' '
static telaEncerramento + #295, #' '
static telaEncerramento + #296, #' '
static telaEncerramento + #297, #2395
static telaEncerramento + #298, #' '
static telaEncerramento + #299, #2395
static telaEncerramento + #300, #' '
static telaEncerramento + #301, #' '
static telaEncerramento + #302, #' '
static telaEncerramento + #303, #2395
static telaEncerramento + #304, #' '
static telaEncerramento + #305, #2395
static telaEncerramento + #306, #' '
static telaEncerramento + #307, #2395
static telaEncerramento + #308, #' '
static telaEncerramento + #309, #2395
static telaEncerramento + #310, #' '
static telaEncerramento + #311, #2395
static telaEncerramento + #312, #' '
static telaEncerramento + #313, #' '
static telaEncerramento + #314, #' '
static telaEncerramento + #315, #2395
static telaEncerramento + #316, #2395
static telaEncerramento + #317, #' '
static telaEncerramento + #318, #' '
static telaEncerramento + #319, #' '
static telaEncerramento + #320, #' '
static telaEncerramento + #321, #' '
static telaEncerramento + #322, #2395
static telaEncerramento + #323, #2395
static telaEncerramento + #324, #' '
static telaEncerramento + #325, #' '
static telaEncerramento + #326, #2395
static telaEncerramento + #327, #2395
static telaEncerramento + #328, #' '
static telaEncerramento + #329, #2395
static telaEncerramento + #330, #' '
static telaEncerramento + #331, #2395
static telaEncerramento + #332, #' '
static telaEncerramento + #333, #2395
static telaEncerramento + #334, #' '
static telaEncerramento + #335, #' '
static telaEncerramento + #336, #' '
static telaEncerramento + #337, #2395
static telaEncerramento + #338, #' '
static telaEncerramento + #339, #2395
static telaEncerramento + #340, #' '
static telaEncerramento + #341, #' '
static telaEncerramento + #342, #' '
static telaEncerramento + #343, #2395
static telaEncerramento + #344, #' '
static telaEncerramento + #345, #2395
static telaEncerramento + #346, #' '
static telaEncerramento + #347, #2395
static telaEncerramento + #348, #' '
static telaEncerramento + #349, #2395
static telaEncerramento + #350, #' '
static telaEncerramento + #351, #2395
static telaEncerramento + #352, #' '
static telaEncerramento + #353, #' '
static telaEncerramento + #354, #' '
static telaEncerramento + #355, #2395
static telaEncerramento + #356, #' '
static telaEncerramento + #357, #2395
static telaEncerramento + #358, #' '
static telaEncerramento + #359, #' '
static telaEncerramento + #360, #' '
static telaEncerramento + #361, #' '
static telaEncerramento + #362, #' '
static telaEncerramento + #363, #2395
static telaEncerramento + #364, #2395
static telaEncerramento + #365, #2395
static telaEncerramento + #366, #2395
static telaEncerramento + #367, #' '
static telaEncerramento + #368, #' '
static telaEncerramento + #369, #2395
static telaEncerramento + #370, #' '
static telaEncerramento + #371, #2395
static telaEncerramento + #372, #' '
static telaEncerramento + #373, #2395
static telaEncerramento + #374, #' '
static telaEncerramento + #375, #' '
static telaEncerramento + #376, #' '
static telaEncerramento + #377, #2395
static telaEncerramento + #378, #' '
static telaEncerramento + #379, #2395
static telaEncerramento + #380, #2395
static telaEncerramento + #381, #2395
static telaEncerramento + #382, #' '
static telaEncerramento + #383, #2395
static telaEncerramento + #384, #2395
static telaEncerramento + #385, #2395
static telaEncerramento + #386, #' '
static telaEncerramento + #387, #' '
static telaEncerramento + #388, #2395
static telaEncerramento + #389, #' '
static telaEncerramento + #390, #' '
static telaEncerramento + #391, #2395
static telaEncerramento + #392, #2395
static telaEncerramento + #393, #2395
static telaEncerramento + #394, #' '
static telaEncerramento + #395, #2395
static telaEncerramento + #396, #' '
static telaEncerramento + #397, #2395
static telaEncerramento + #398, #' '
static telaEncerramento + #399, #' '
static telaEncerramento + #400, #' '
static telaEncerramento + #401, #' '
static telaEncerramento + #402, #' '
static telaEncerramento + #403, #' '
static telaEncerramento + #404, #' '
static telaEncerramento + #405, #' '
static telaEncerramento + #406, #' '
static telaEncerramento + #407, #' '
static telaEncerramento + #408, #' '
static telaEncerramento + #409, #' '
static telaEncerramento + #410, #' '
static telaEncerramento + #411, #' '
static telaEncerramento + #412, #' '
static telaEncerramento + #413, #' '
static telaEncerramento + #414, #' '
static telaEncerramento + #415, #' '
static telaEncerramento + #416, #' '
static telaEncerramento + #417, #' '
static telaEncerramento + #418, #' '
static telaEncerramento + #419, #' '
static telaEncerramento + #420, #' '
static telaEncerramento + #421, #' '
static telaEncerramento + #422, #' '
static telaEncerramento + #423, #' '
static telaEncerramento + #424, #' '
static telaEncerramento + #425, #' '
static telaEncerramento + #426, #' '
static telaEncerramento + #427, #' '
static telaEncerramento + #428, #' '
static telaEncerramento + #429, #' '
static telaEncerramento + #430, #' '
static telaEncerramento + #431, #' '
static telaEncerramento + #432, #' '
static telaEncerramento + #433, #' '
static telaEncerramento + #434, #' '
static telaEncerramento + #435, #' '
static telaEncerramento + #436, #' '
static telaEncerramento + #437, #' '
static telaEncerramento + #438, #' '
static telaEncerramento + #439, #' '
static telaEncerramento + #440, #' '
static telaEncerramento + #441, #' '
static telaEncerramento + #442, #' '
static telaEncerramento + #443, #' '
static telaEncerramento + #444, #' '
static telaEncerramento + #445, #' '
static telaEncerramento + #446, #' '
static telaEncerramento + #447, #' '
static telaEncerramento + #448, #' '
static telaEncerramento + #449, #' '
static telaEncerramento + #450, #' '
static telaEncerramento + #451, #' '
static telaEncerramento + #452, #' '
static telaEncerramento + #453, #' '
static telaEncerramento + #454, #' '
static telaEncerramento + #455, #' '
static telaEncerramento + #456, #' '
static telaEncerramento + #457, #' '
static telaEncerramento + #458, #' '
static telaEncerramento + #459, #' '
static telaEncerramento + #460, #' '
static telaEncerramento + #461, #' '
static telaEncerramento + #462, #' '
static telaEncerramento + #463, #' '
static telaEncerramento + #464, #' '
static telaEncerramento + #465, #' '
static telaEncerramento + #466, #' '
static telaEncerramento + #467, #' '
static telaEncerramento + #468, #' '
static telaEncerramento + #469, #' '
static telaEncerramento + #470, #' '
static telaEncerramento + #471, #' '
static telaEncerramento + #472, #' '
static telaEncerramento + #473, #' '
static telaEncerramento + #474, #' '
static telaEncerramento + #475, #' '
static telaEncerramento + #476, #' '
static telaEncerramento + #477, #' '
static telaEncerramento + #478, #' '
static telaEncerramento + #479, #' '
static telaEncerramento + #480, #' '
static telaEncerramento + #481, #' '
static telaEncerramento + #482, #' '
static telaEncerramento + #483, #' '
static telaEncerramento + #484, #' '
static telaEncerramento + #485, #' '
static telaEncerramento + #486, #' '
static telaEncerramento + #487, #' '
static telaEncerramento + #488, #' '
static telaEncerramento + #489, #' '
static telaEncerramento + #490, #' '
static telaEncerramento + #491, #' '
static telaEncerramento + #492, #' '
static telaEncerramento + #493, #' '
static telaEncerramento + #494, #' '
static telaEncerramento + #495, #' '
static telaEncerramento + #496, #' '
static telaEncerramento + #497, #' '
static telaEncerramento + #498, #' '
static telaEncerramento + #499, #' '
static telaEncerramento + #500, #' '
static telaEncerramento + #501, #' '
static telaEncerramento + #502, #' '
static telaEncerramento + #503, #' '
static telaEncerramento + #504, #' '
static telaEncerramento + #505, #' '
static telaEncerramento + #506, #' '
static telaEncerramento + #507, #' '
static telaEncerramento + #508, #' '
static telaEncerramento + #509, #' '
static telaEncerramento + #510, #' '
static telaEncerramento + #511, #' '
static telaEncerramento + #512, #' '
static telaEncerramento + #513, #' '
static telaEncerramento + #514, #' '
static telaEncerramento + #515, #' '
static telaEncerramento + #516, #' '
static telaEncerramento + #517, #' '
static telaEncerramento + #518, #' '
static telaEncerramento + #519, #' '
static telaEncerramento + #520, #' '
static telaEncerramento + #521, #' '
static telaEncerramento + #522, #' '
static telaEncerramento + #523, #' '
static telaEncerramento + #524, #' '
static telaEncerramento + #525, #' '
static telaEncerramento + #526, #' '
static telaEncerramento + #527, #' '
static telaEncerramento + #528, #' '
static telaEncerramento + #529, #' '
static telaEncerramento + #530, #' '
static telaEncerramento + #531, #' '
static telaEncerramento + #532, #' '
static telaEncerramento + #533, #' '
static telaEncerramento + #534, #' '
static telaEncerramento + #535, #' '
static telaEncerramento + #536, #' '
static telaEncerramento + #537, #' '
static telaEncerramento + #538, #' '
static telaEncerramento + #539, #' '
static telaEncerramento + #540, #' '
static telaEncerramento + #541, #' '
static telaEncerramento + #542, #' '
static telaEncerramento + #543, #' '
static telaEncerramento + #544, #' '
static telaEncerramento + #545, #' '
static telaEncerramento + #546, #' '
static telaEncerramento + #547, #' '
static telaEncerramento + #548, #' '
static telaEncerramento + #549, #' '
static telaEncerramento + #550, #' '
static telaEncerramento + #551, #' '
static telaEncerramento + #552, #' '
static telaEncerramento + #553, #' '
static telaEncerramento + #554, #' '
static telaEncerramento + #555, #' '
static telaEncerramento + #556, #' '
static telaEncerramento + #557, #' '
static telaEncerramento + #558, #' '
static telaEncerramento + #559, #' '
static telaEncerramento + #560, #' '
static telaEncerramento + #561, #' '
static telaEncerramento + #562, #' '
static telaEncerramento + #563, #' '
static telaEncerramento + #564, #' '
static telaEncerramento + #565, #' '
static telaEncerramento + #566, #' '
static telaEncerramento + #567, #' '
static telaEncerramento + #568, #' '
static telaEncerramento + #569, #' '
static telaEncerramento + #570, #' '
static telaEncerramento + #571, #' '
static telaEncerramento + #572, #' '
static telaEncerramento + #573, #' '
static telaEncerramento + #574, #' '
static telaEncerramento + #575, #' '
static telaEncerramento + #576, #' '
static telaEncerramento + #577, #' '
static telaEncerramento + #578, #' '
static telaEncerramento + #579, #' '
static telaEncerramento + #580, #' '
static telaEncerramento + #581, #' '
static telaEncerramento + #582, #' '
static telaEncerramento + #583, #' '
static telaEncerramento + #584, #' '
static telaEncerramento + #585, #' '
static telaEncerramento + #586, #' '
static telaEncerramento + #587, #' '
static telaEncerramento + #588, #' '
static telaEncerramento + #589, #' '
static telaEncerramento + #590, #' '
static telaEncerramento + #591, #' '
static telaEncerramento + #592, #' '
static telaEncerramento + #593, #' '
static telaEncerramento + #594, #' '
static telaEncerramento + #595, #' '
static telaEncerramento + #596, #' '
static telaEncerramento + #597, #' '
static telaEncerramento + #598, #' '
static telaEncerramento + #599, #' '
static telaEncerramento + #600, #' '
static telaEncerramento + #601, #' '
static telaEncerramento + #602, #' '
static telaEncerramento + #603, #' '
static telaEncerramento + #604, #' '
static telaEncerramento + #605, #' '
static telaEncerramento + #606, #' '
static telaEncerramento + #607, #' '
static telaEncerramento + #608, #' '
static telaEncerramento + #609, #' '
static telaEncerramento + #610, #' '
static telaEncerramento + #611, #' '
static telaEncerramento + #612, #' '
static telaEncerramento + #613, #' '
static telaEncerramento + #614, #' '
static telaEncerramento + #615, #' '
static telaEncerramento + #616, #' '
static telaEncerramento + #617, #' '
static telaEncerramento + #618, #' '
static telaEncerramento + #619, #' '
static telaEncerramento + #620, #' '
static telaEncerramento + #621, #' '
static telaEncerramento + #622, #' '
static telaEncerramento + #623, #' '
static telaEncerramento + #624, #' '
static telaEncerramento + #625, #' '
static telaEncerramento + #626, #' '
static telaEncerramento + #627, #' '
static telaEncerramento + #628, #' '
static telaEncerramento + #629, #' '
static telaEncerramento + #630, #' '
static telaEncerramento + #631, #' '
static telaEncerramento + #632, #' '
static telaEncerramento + #633, #' '
static telaEncerramento + #634, #' '
static telaEncerramento + #635, #' '
static telaEncerramento + #636, #' '
static telaEncerramento + #637, #' '
static telaEncerramento + #638, #' '
static telaEncerramento + #639, #' '
static telaEncerramento + #640, #' '
static telaEncerramento + #641, #' '
static telaEncerramento + #642, #' '
static telaEncerramento + #643, #' '
static telaEncerramento + #644, #' '
static telaEncerramento + #645, #' '
static telaEncerramento + #646, #' '
static telaEncerramento + #647, #' '
static telaEncerramento + #648, #' '
static telaEncerramento + #649, #'T'
static telaEncerramento + #650, #'H'
static telaEncerramento + #651, #'A'
static telaEncerramento + #652, #'N'
static telaEncerramento + #653, #'K'
static telaEncerramento + #654, #'S'
static telaEncerramento + #655, #' '
static telaEncerramento + #656, #'F'
static telaEncerramento + #657, #'O'
static telaEncerramento + #658, #'R'
static telaEncerramento + #659, #' '
static telaEncerramento + #660, #'P'
static telaEncerramento + #661, #'L'
static telaEncerramento + #662, #'A'
static telaEncerramento + #663, #'Y'
static telaEncerramento + #664, #'I'
static telaEncerramento + #665, #'N'
static telaEncerramento + #666, #'G'
static telaEncerramento + #667, #94
static telaEncerramento + #668, #94
static telaEncerramento + #669, #94
static telaEncerramento + #670, #' '
static telaEncerramento + #671, #' '
static telaEncerramento + #672, #' '
static telaEncerramento + #673, #' '
static telaEncerramento + #674, #' '
static telaEncerramento + #675, #' '
static telaEncerramento + #676, #' '
static telaEncerramento + #677, #' '
static telaEncerramento + #678, #' '
static telaEncerramento + #679, #' '
static telaEncerramento + #680, #' '
static telaEncerramento + #681, #' '
static telaEncerramento + #682, #' '
static telaEncerramento + #683, #' '
static telaEncerramento + #684, #' '
static telaEncerramento + #685, #' '
static telaEncerramento + #686, #' '
static telaEncerramento + #687, #' '
static telaEncerramento + #688, #' '
static telaEncerramento + #689, #' '
static telaEncerramento + #690, #' '
static telaEncerramento + #691, #' '
static telaEncerramento + #692, #' '
static telaEncerramento + #693, #' '
static telaEncerramento + #694, #' '
static telaEncerramento + #695, #' '
static telaEncerramento + #696, #' '
static telaEncerramento + #697, #' '
static telaEncerramento + #698, #' '
static telaEncerramento + #699, #' '
static telaEncerramento + #700, #' '
static telaEncerramento + #701, #' '
static telaEncerramento + #702, #' '
static telaEncerramento + #703, #' '
static telaEncerramento + #704, #' '
static telaEncerramento + #705, #' '
static telaEncerramento + #706, #' '
static telaEncerramento + #707, #' '
static telaEncerramento + #708, #' '
static telaEncerramento + #709, #' '
static telaEncerramento + #710, #' '
static telaEncerramento + #711, #' '
static telaEncerramento + #712, #' '
static telaEncerramento + #713, #' '
static telaEncerramento + #714, #' '
static telaEncerramento + #715, #' '
static telaEncerramento + #716, #' '
static telaEncerramento + #717, #' '
static telaEncerramento + #718, #' '
static telaEncerramento + #719, #' '
static telaEncerramento + #720, #' '
static telaEncerramento + #721, #' '
static telaEncerramento + #722, #' '
static telaEncerramento + #723, #' '
static telaEncerramento + #724, #' '
static telaEncerramento + #725, #' '
static telaEncerramento + #726, #' '
static telaEncerramento + #727, #' '
static telaEncerramento + #728, #' '
static telaEncerramento + #729, #' '
static telaEncerramento + #730, #' '
static telaEncerramento + #731, #' '
static telaEncerramento + #732, #' '
static telaEncerramento + #733, #' '
static telaEncerramento + #734, #' '
static telaEncerramento + #735, #' '
static telaEncerramento + #736, #' '
static telaEncerramento + #737, #' '
static telaEncerramento + #738, #' '
static telaEncerramento + #739, #' '
static telaEncerramento + #740, #' '
static telaEncerramento + #741, #' '
static telaEncerramento + #742, #' '
static telaEncerramento + #743, #' '
static telaEncerramento + #744, #' '
static telaEncerramento + #745, #' '
static telaEncerramento + #746, #' '
static telaEncerramento + #747, #' '
static telaEncerramento + #748, #' '
static telaEncerramento + #749, #' '
static telaEncerramento + #750, #' '
static telaEncerramento + #751, #' '
static telaEncerramento + #752, #' '
static telaEncerramento + #753, #' '
static telaEncerramento + #754, #' '
static telaEncerramento + #755, #' '
static telaEncerramento + #756, #' '
static telaEncerramento + #757, #' '
static telaEncerramento + #758, #' '
static telaEncerramento + #759, #' '
static telaEncerramento + #760, #' '
static telaEncerramento + #761, #' '
static telaEncerramento + #762, #' '
static telaEncerramento + #763, #' '
static telaEncerramento + #764, #' '
static telaEncerramento + #765, #' '
static telaEncerramento + #766, #' '
static telaEncerramento + #767, #' '
static telaEncerramento + #768, #' '
static telaEncerramento + #769, #' '
static telaEncerramento + #770, #' '
static telaEncerramento + #771, #' '
static telaEncerramento + #772, #' '
static telaEncerramento + #773, #' '
static telaEncerramento + #774, #' '
static telaEncerramento + #775, #' '
static telaEncerramento + #776, #' '
static telaEncerramento + #777, #' '
static telaEncerramento + #778, #' '
static telaEncerramento + #779, #' '
static telaEncerramento + #780, #' '
static telaEncerramento + #781, #' '
static telaEncerramento + #782, #' '
static telaEncerramento + #783, #' '
static telaEncerramento + #784, #' '
static telaEncerramento + #785, #' '
static telaEncerramento + #786, #' '
static telaEncerramento + #787, #' '
static telaEncerramento + #788, #' '
static telaEncerramento + #789, #' '
static telaEncerramento + #790, #' '
static telaEncerramento + #791, #' '
static telaEncerramento + #792, #' '
static telaEncerramento + #793, #' '
static telaEncerramento + #794, #' '
static telaEncerramento + #795, #' '
static telaEncerramento + #796, #' '
static telaEncerramento + #797, #' '
static telaEncerramento + #798, #' '
static telaEncerramento + #799, #' '
static telaEncerramento + #800, #' '
static telaEncerramento + #801, #' '
static telaEncerramento + #802, #' '
static telaEncerramento + #803, #' '
static telaEncerramento + #804, #' '
static telaEncerramento + #805, #' '
static telaEncerramento + #806, #' '
static telaEncerramento + #807, #' '
static telaEncerramento + #808, #' '
static telaEncerramento + #809, #' '
static telaEncerramento + #810, #' '
static telaEncerramento + #811, #' '
static telaEncerramento + #812, #' '
static telaEncerramento + #813, #' '
static telaEncerramento + #814, #' '
static telaEncerramento + #815, #' '
static telaEncerramento + #816, #' '
static telaEncerramento + #817, #' '
static telaEncerramento + #818, #' '
static telaEncerramento + #819, #' '
static telaEncerramento + #820, #' '
static telaEncerramento + #821, #' '
static telaEncerramento + #822, #' '
static telaEncerramento + #823, #' '
static telaEncerramento + #824, #' '
static telaEncerramento + #825, #' '
static telaEncerramento + #826, #' '
static telaEncerramento + #827, #' '
static telaEncerramento + #828, #' '
static telaEncerramento + #829, #' '
static telaEncerramento + #830, #' '
static telaEncerramento + #831, #' '
static telaEncerramento + #832, #' '
static telaEncerramento + #833, #' '
static telaEncerramento + #834, #' '
static telaEncerramento + #835, #' '
static telaEncerramento + #836, #' '
static telaEncerramento + #837, #' '
static telaEncerramento + #838, #' '
static telaEncerramento + #839, #' '
static telaEncerramento + #840, #' '
static telaEncerramento + #841, #' '
static telaEncerramento + #842, #' '
static telaEncerramento + #843, #' '
static telaEncerramento + #844, #' '
static telaEncerramento + #845, #' '
static telaEncerramento + #846, #' '
static telaEncerramento + #847, #' '
static telaEncerramento + #848, #' '
static telaEncerramento + #849, #' '
static telaEncerramento + #850, #' '
static telaEncerramento + #851, #' '
static telaEncerramento + #852, #' '
static telaEncerramento + #853, #' '
static telaEncerramento + #854, #' '
static telaEncerramento + #855, #' '
static telaEncerramento + #856, #' '
static telaEncerramento + #857, #' '
static telaEncerramento + #858, #' '
static telaEncerramento + #859, #' '
static telaEncerramento + #860, #' '
static telaEncerramento + #861, #' '
static telaEncerramento + #862, #' '
static telaEncerramento + #863, #' '
static telaEncerramento + #864, #' '
static telaEncerramento + #865, #' '
static telaEncerramento + #866, #' '
static telaEncerramento + #867, #' '
static telaEncerramento + #868, #' '
static telaEncerramento + #869, #' '
static telaEncerramento + #870, #' '
static telaEncerramento + #871, #' '
static telaEncerramento + #872, #' '
static telaEncerramento + #873, #' '
static telaEncerramento + #874, #' '
static telaEncerramento + #875, #' '
static telaEncerramento + #876, #' '
static telaEncerramento + #877, #' '
static telaEncerramento + #878, #' '
static telaEncerramento + #879, #' '
static telaEncerramento + #880, #' '
static telaEncerramento + #881, #' '
static telaEncerramento + #882, #' '
static telaEncerramento + #883, #' '
static telaEncerramento + #884, #' '
static telaEncerramento + #885, #' '
static telaEncerramento + #886, #' '
static telaEncerramento + #887, #' '
static telaEncerramento + #888, #' '
static telaEncerramento + #889, #' '
static telaEncerramento + #890, #' '
static telaEncerramento + #891, #' '
static telaEncerramento + #892, #' '
static telaEncerramento + #893, #' '
static telaEncerramento + #894, #' '
static telaEncerramento + #895, #' '
static telaEncerramento + #896, #' '
static telaEncerramento + #897, #' '
static telaEncerramento + #898, #' '
static telaEncerramento + #899, #' '
static telaEncerramento + #900, #' '
static telaEncerramento + #901, #' '
static telaEncerramento + #902, #' '
static telaEncerramento + #903, #' '
static telaEncerramento + #904, #' '
static telaEncerramento + #905, #' '
static telaEncerramento + #906, #' '
static telaEncerramento + #907, #' '
static telaEncerramento + #908, #' '
static telaEncerramento + #909, #' '
static telaEncerramento + #910, #' '
static telaEncerramento + #911, #' '
static telaEncerramento + #912, #' '
static telaEncerramento + #913, #' '
static telaEncerramento + #914, #' '
static telaEncerramento + #915, #' '
static telaEncerramento + #916, #' '
static telaEncerramento + #917, #' '
static telaEncerramento + #918, #' '
static telaEncerramento + #919, #' '
static telaEncerramento + #920, #' '
static telaEncerramento + #921, #' '
static telaEncerramento + #922, #' '
static telaEncerramento + #923, #' '
static telaEncerramento + #924, #' '
static telaEncerramento + #925, #' '
static telaEncerramento + #926, #' '
static telaEncerramento + #927, #' '
static telaEncerramento + #928, #'P'
static telaEncerramento + #929, #'R'
static telaEncerramento + #930, #'E'
static telaEncerramento + #931, #'S'
static telaEncerramento + #932, #'S'
static telaEncerramento + #933, #' '
static telaEncerramento + #934, #'E'
static telaEncerramento + #935, #'N'
static telaEncerramento + #936, #'T'
static telaEncerramento + #937, #'E'
static telaEncerramento + #938, #'R'
static telaEncerramento + #939, #' '
static telaEncerramento + #940, #'T'
static telaEncerramento + #941, #'O'
static telaEncerramento + #942, #' '
static telaEncerramento + #943, #'C'
static telaEncerramento + #944, #'O'
static telaEncerramento + #945, #'N'
static telaEncerramento + #946, #'T'
static telaEncerramento + #947, #'I'
static telaEncerramento + #948, #'N'
static telaEncerramento + #949, #'U'
static telaEncerramento + #950, #'E'
static telaEncerramento + #951, #' '
static telaEncerramento + #952, #' '
static telaEncerramento + #953, #' '
static telaEncerramento + #954, #' '
static telaEncerramento + #955, #' '
static telaEncerramento + #956, #' '
static telaEncerramento + #957, #' '
static telaEncerramento + #958, #' '
static telaEncerramento + #959, #' '
static telaEncerramento + #960, #' '
static telaEncerramento + #961, #' '
static telaEncerramento + #962, #' '
static telaEncerramento + #963, #' '
static telaEncerramento + #964, #' '
static telaEncerramento + #965, #' '
static telaEncerramento + #966, #' '
static telaEncerramento + #967, #' '
static telaEncerramento + #968, #' '
static telaEncerramento + #969, #' '
static telaEncerramento + #970, #' '
static telaEncerramento + #971, #' '
static telaEncerramento + #972, #' '
static telaEncerramento + #973, #' '
static telaEncerramento + #974, #' '
static telaEncerramento + #975, #' '
static telaEncerramento + #976, #' '
static telaEncerramento + #977, #' '
static telaEncerramento + #978, #' '
static telaEncerramento + #979, #' '
static telaEncerramento + #980, #' '
static telaEncerramento + #981, #' '
static telaEncerramento + #982, #' '
static telaEncerramento + #983, #' '
static telaEncerramento + #984, #' '
static telaEncerramento + #985, #' '
static telaEncerramento + #986, #' '
static telaEncerramento + #987, #' '
static telaEncerramento + #988, #' '
static telaEncerramento + #989, #' '
static telaEncerramento + #990, #' '
static telaEncerramento + #991, #' '
static telaEncerramento + #992, #' '
static telaEncerramento + #993, #' '
static telaEncerramento + #994, #' '
static telaEncerramento + #995, #' '
static telaEncerramento + #996, #' '
static telaEncerramento + #997, #' '
static telaEncerramento + #998, #' '
static telaEncerramento + #999, #' '
static telaEncerramento + #1000, #' '
static telaEncerramento + #1001, #' '
static telaEncerramento + #1002, #' '
static telaEncerramento + #1003, #' '
static telaEncerramento + #1004, #' '
static telaEncerramento + #1005, #' '
static telaEncerramento + #1006, #' '
static telaEncerramento + #1007, #' '
static telaEncerramento + #1008, #' '
static telaEncerramento + #1009, #' '
static telaEncerramento + #1010, #' '
static telaEncerramento + #1011, #' '
static telaEncerramento + #1012, #' '
static telaEncerramento + #1013, #' '
static telaEncerramento + #1014, #' '
static telaEncerramento + #1015, #' '
static telaEncerramento + #1016, #' '
static telaEncerramento + #1017, #' '
static telaEncerramento + #1018, #' '
static telaEncerramento + #1019, #' '
static telaEncerramento + #1020, #' '
static telaEncerramento + #1021, #' '
static telaEncerramento + #1022, #' '
static telaEncerramento + #1023, #' '
static telaEncerramento + #1024, #' '
static telaEncerramento + #1025, #' '
static telaEncerramento + #1026, #' '
static telaEncerramento + #1027, #' '
static telaEncerramento + #1028, #' '
static telaEncerramento + #1029, #' '
static telaEncerramento + #1030, #' '
static telaEncerramento + #1031, #' '
static telaEncerramento + #1032, #' '
static telaEncerramento + #1033, #' '
static telaEncerramento + #1034, #' '
static telaEncerramento + #1035, #' '
static telaEncerramento + #1036, #' '
static telaEncerramento + #1037, #' '
static telaEncerramento + #1038, #' '
static telaEncerramento + #1039, #' '
static telaEncerramento + #1040, #' '
static telaEncerramento + #1041, #' '
static telaEncerramento + #1042, #' '
static telaEncerramento + #1043, #' '
static telaEncerramento + #1044, #' '
static telaEncerramento + #1045, #' '
static telaEncerramento + #1046, #' '
static telaEncerramento + #1047, #' '
static telaEncerramento + #1048, #' '
static telaEncerramento + #1049, #' '
static telaEncerramento + #1050, #' '
static telaEncerramento + #1051, #' '
static telaEncerramento + #1052, #' '
static telaEncerramento + #1053, #' '
static telaEncerramento + #1054, #' '
static telaEncerramento + #1055, #' '
static telaEncerramento + #1056, #' '
static telaEncerramento + #1057, #' '
static telaEncerramento + #1058, #' '
static telaEncerramento + #1059, #' '
static telaEncerramento + #1060, #' '
static telaEncerramento + #1061, #' '
static telaEncerramento + #1062, #' '
static telaEncerramento + #1063, #' '
static telaEncerramento + #1064, #' '
static telaEncerramento + #1065, #' '
static telaEncerramento + #1066, #' '
static telaEncerramento + #1067, #' '
static telaEncerramento + #1068, #' '
static telaEncerramento + #1069, #' '
static telaEncerramento + #1070, #' '
static telaEncerramento + #1071, #' '
static telaEncerramento + #1072, #' '
static telaEncerramento + #1073, #' '
static telaEncerramento + #1074, #' '
static telaEncerramento + #1075, #' '
static telaEncerramento + #1076, #' '
static telaEncerramento + #1077, #' '
static telaEncerramento + #1078, #' '
static telaEncerramento + #1079, #' '
static telaEncerramento + #1080, #' '
static telaEncerramento + #1081, #' '
static telaEncerramento + #1082, #' '
static telaEncerramento + #1083, #' '
static telaEncerramento + #1084, #' '
static telaEncerramento + #1085, #' '
static telaEncerramento + #1086, #' '
static telaEncerramento + #1087, #' '
static telaEncerramento + #1088, #' '
static telaEncerramento + #1089, #' '
static telaEncerramento + #1090, #' '
static telaEncerramento + #1091, #' '
static telaEncerramento + #1092, #' '
static telaEncerramento + #1093, #' '
static telaEncerramento + #1094, #' '
static telaEncerramento + #1095, #' '
static telaEncerramento + #1096, #' '
static telaEncerramento + #1097, #' '
static telaEncerramento + #1098, #' '
static telaEncerramento + #1099, #' '
static telaEncerramento + #1100, #' '
static telaEncerramento + #1101, #' '
static telaEncerramento + #1102, #' '
static telaEncerramento + #1103, #' '
static telaEncerramento + #1104, #' '
static telaEncerramento + #1105, #' '
static telaEncerramento + #1106, #' '
static telaEncerramento + #1107, #' '
static telaEncerramento + #1108, #' '
static telaEncerramento + #1109, #' '
static telaEncerramento + #1110, #' '
static telaEncerramento + #1111, #' '
static telaEncerramento + #1112, #' '
static telaEncerramento + #1113, #' '
static telaEncerramento + #1114, #' '
static telaEncerramento + #1115, #' '
static telaEncerramento + #1116, #' '
static telaEncerramento + #1117, #' '
static telaEncerramento + #1118, #' '
static telaEncerramento + #1119, #' '
static telaEncerramento + #1120, #' '
static telaEncerramento + #1121, #' '
static telaEncerramento + #1122, #' '
static telaEncerramento + #1123, #' '
static telaEncerramento + #1124, #' '
static telaEncerramento + #1125, #' '
static telaEncerramento + #1126, #' '
static telaEncerramento + #1127, #' '
static telaEncerramento + #1128, #' '
static telaEncerramento + #1129, #' '
static telaEncerramento + #1130, #' '
static telaEncerramento + #1131, #' '
static telaEncerramento + #1132, #' '
static telaEncerramento + #1133, #' '
static telaEncerramento + #1134, #' '
static telaEncerramento + #1135, #' '
static telaEncerramento + #1136, #' '
static telaEncerramento + #1137, #' '
static telaEncerramento + #1138, #' '
static telaEncerramento + #1139, #' '
static telaEncerramento + #1140, #' '
static telaEncerramento + #1141, #' '
static telaEncerramento + #1142, #' '
static telaEncerramento + #1143, #' '
static telaEncerramento + #1144, #' '
static telaEncerramento + #1145, #' '
static telaEncerramento + #1146, #' '
static telaEncerramento + #1147, #' '
static telaEncerramento + #1148, #' '
static telaEncerramento + #1149, #' '
static telaEncerramento + #1150, #' '
static telaEncerramento + #1151, #' '
static telaEncerramento + #1152, #' '
static telaEncerramento + #1153, #' '
static telaEncerramento + #1154, #' '
static telaEncerramento + #1155, #' '
static telaEncerramento + #1156, #' '
static telaEncerramento + #1157, #' '
static telaEncerramento + #1158, #' '
static telaEncerramento + #1159, #' '
static telaEncerramento + #1160, #' '
static telaEncerramento + #1161, #' '
static telaEncerramento + #1162, #' '
static telaEncerramento + #1163, #' '
static telaEncerramento + #1164, #' '
static telaEncerramento + #1165, #' '
static telaEncerramento + #1166, #' '
static telaEncerramento + #1167, #' '
static telaEncerramento + #1168, #' '
static telaEncerramento + #1169, #' '
static telaEncerramento + #1170, #' '
static telaEncerramento + #1171, #' '
static telaEncerramento + #1172, #' '
static telaEncerramento + #1173, #' '
static telaEncerramento + #1174, #' '
static telaEncerramento + #1175, #' '
static telaEncerramento + #1176, #' '
static telaEncerramento + #1177, #' '
static telaEncerramento + #1178, #' '
static telaEncerramento + #1179, #' '
static telaEncerramento + #1180, #' '
static telaEncerramento + #1181, #' '
static telaEncerramento + #1182, #' '
static telaEncerramento + #1183, #' '
static telaEncerramento + #1184, #' '
static telaEncerramento + #1185, #' '
static telaEncerramento + #1186, #' '
static telaEncerramento + #1187, #' '
static telaEncerramento + #1188, #' '
static telaEncerramento + #1189, #' '
static telaEncerramento + #1190, #' '
static telaEncerramento + #1191, #' '
static telaEncerramento + #1192, #' '
static telaEncerramento + #1193, #' '
static telaEncerramento + #1194, #' '
static telaEncerramento + #1195, #' '
static telaEncerramento + #1196, #' '
static telaEncerramento + #1197, #' '
static telaEncerramento + #1198, #' '
static telaEncerramento + #1199, #' '
