;---Jogo da Forca---;

; Estrutura do Jogo:
;	<Jogo da Forca>
;main:
;   Seta parametros...
;   Call InputPalavra
;   Call DesenhaForca
;
;	Loop:
;		Call InputLetra
;		Call Compara
;		Call TestaFim
;		jmp Loop
;
;   Halt
;
;InputPalavra:
;   -- Pede para um jogador digitar uma palava para o outro adivinhar
;   Call DigitaLetra
;
;DigitaLetra:
;   -- Le o teclado ate' que uma tecla seja pressionada
;
;DesenhaForca:
;   Seta parametros...
;   Call LimpaTela
;   Call DesenhaTela
;   RTS
;
;DesenhaTela:
;   -- Desenha uma tela inteira 40 x 30
;   Seta parametros...
;
;	Loop:
;		call ImprimeStr ; Call ImprimeStr  30 vezes    (Tem essa funcao no Hello4.asm)
;		add r0, r0, 40  ; incrementaposicao para a segunda linha na tela!
;		add r1, r1, 41  ; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!)
;		cmp r0, 1200
;		jne Loop
;	RTS
;
;LimpaTela:
;   -- Limpa toda a tela
;
;ImprimeSTR:
;   -- Imprime uma String na tela(Tem essa funcao no Hello4.asm)
;
;InputLetra:
;	-- O jogador digita uma Letra e testa se ja' foi digitada
;	Seta Parametros...
;	Printf (Digite uma Letra)
;	Loop:		-- Compara Letra com todas as letras da lista Trylist
;		Call DigitaLetra
;		If(TryListSize == 0) goto Fim
;		For i = 0 to TryListSize-1  {
;			If(Letra == TryList[i]) {
;				Printf(Letra Repetida)
;				Printf(TryList)
;				Goto Loop
;				}
;			}
; Fim:
;	TryList[TryListSize] = Letra	    -- Se nao esta' na Lista, acrescente na Lista
;	TryListSize++
;	TryList[TryListSize] = /0	     	-- Poe /0 no Final!!
;	RTS
;
;Compara
;	-- Compara a Letra digitada para ver se pertence a Palavra
;	Seta Parametros...
;	FlagAcerto == 0
;	For i = 0 to PalavraSize-1 {
;		If(Letra == palavra[i]) {
;			Printf(Letra  --> PosicaoFixa+i)
;			Acerto++
;			FlagAcerto = 1
;			}
;		}
;
;		If(FlagAcerto == 0) {
;			Erro++
;			Switch(Erro) {
;				Case 1 -> Desenha Cabeca
;					. . .
;				Case 7 -> Desenha Perna Direita
;			}
;		}
;	RTS
;
;
;TestaFim:
;		-- Rotina que testa se o Jogo terminou
;		-- Se acertou todas as letras da palavra
;		-- ou Se ja' desenhou todo o carinha
;	Seta Parametros...
;	If(Erro == 8) {
;		Printf(TelaEnforcado)
;		Printf(Palavra)
;
;		Printf(Quer Jogar Novamente??)
;		Call DigLetra
;		If(Letra == S) {
;			Call ApagaTela
;			Pop R0		-- Como da' um Goto direto pro Main tem que esvasiar a pilha do Call TestaFim
;			Goto Main
;			}
;		else Halt
;		}
;	If(Acerto == PalavraSize){
;		Printf(Voce Venceu)
;
;		Printf(Quer Jogar Novamente??)
;		Call DigLetra
;		If(Letra == S) {
;			Call ApagaTela
;			Pop R0		-- Como da' um Goto direto pro Main tem que esvasiar a pilha do Call TestaFim
;			Goto Main
;			}
;		else Halt
;       }
;	RTS

jmp main

;---- Declaracao de Variaveis Globais -----
; Sao todas aquelas que precisam ser vistas por mais de uma funcao: Evita a passagem de parametros!!!
; As variaveis locais de cada funcao serao alocadas nos Registradores internos = r0 - r7

Palavra: var #41	; Vetor para Armazenar as letras da Palavra
PalavraSize: var #1	; Tamanho da Palavra
Letra: var #1		; Contem a letra que foi digitada
TryList: var #60	; Lista com as letras ja' digitadas
TryListSize: var #1	; Tamanho da Lista com as letras ja' digitadas
Acerto: var #1		; Contador de Acertos
Erro: var #1			; Contador de Erros

; Mensagens que serao impressas na tela
Msn1: string "Digite a palavra (Enter para sair): "
Msn2: string "Digite uma letra"
Msn3: string "                "
Msn4: string "Voce Venceu! Uhuuuu! )"
Msn5: string "Quer jogar novamente? <s/n>"
Msn6: string "Voce Perdeu! /"
Msn7: string "Letra ja foi digitada, digite novamente!Letras: "
Msn8: string "                                        "


;---- Inicio do Programa Principal -----
main:
	; Inicialisa as variaveis Globais
	loadn r0, #0
	store Acerto, r0	; Contador de Acertos
	store Erro, r0		; Contador de Erros
	store TryList, r0	; Salva '\0' na primeira posicao de TryList
	store TryListSize, r0	; Zera o tamanho da TryList

	call inputPalavra
	;call printPalavra	; Testa se a palavra foi digitada corretamente!!

	call DesForca
	
	loop:
		call inputLetra
		call Compara
		call TestaFim
	jmp loop

	halt	; Nunca chega aqui !!! Mas nao custa nada colocar!!!!
	
;---- Fim do Programa Principal -----
	
	
;---- Inicio das Subrotinas -----

;********************************************************
;                   INPUT UMA PALAVRA
;********************************************************
inputPalavra:	; Rotina que recebe uma palavra para que o segundo usuario tente adivinhar
	;salva as variaveis anteriores e inicializa as novas
	push fr		; Protege o registrador de flags
	push r0		; Recebe letra digitada
	push r1		; codigo do enter
	push r2		; Contador de letras para o vetor que armazena a palavra
	push r3		; ponteiro para palavra
	push r4		; palavra[r3+r2]
	push r5		; Tamanho maximo da palavra

	loadn r1, #13		; codigo enter
	loadn r2, #0		; inicia r2 = 0
	loadn r3, #Palavra	; ponteiro para palavra
	loadn r5, #40		; Tamanho maximo da palavra
	;----------------

	call printDigPalavra	; Seleciona uma mensagem para imprimir - Digite uma palavra!!

   inputPalavra_Loop:
		call digLetra		; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	   		
		load r0, Letra				; Letra --> r0
		cmp r0, r1					;comparacao se r0 eh enter(13)
		jeq inputPalavra_Fim		; VAi para o fim se Enter!
		
		add r4, r3, r2
		storei r4, r0				; palavra[r2] = Letra

		inc r2
		store PalavraSize, r2			; Atualiza o tamanho da palavra
		cmp r2, r5						; verifica se r2 = 40
		jne inputPalavra_Loop			; Se for, sai, senao goto loop!!
				
   inputPalavra_Fim:
	; Poe um /0 no final da palavra pra poder imprimir e testar!!
	loadn r0, #0
	add r4, r3, r2
	storei r4, r0				; palavra[r2] = /0

	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts		
			
;------------------------		
;********************************************************
;                   DIGITE UMA LETRA
;********************************************************

digLetra:	; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push fr		; Protege o registrador de flags
	push r0
	push r1
	push r2
	loadn r1, #255	; Se nao digitar nada vem 255
	loadn r2, #0	; Logo que programa a FPGA o inchar vem 0

   digLetra_Loop:
		inchar r0			; Le o teclado, se nada for digitado = 255
		cmp r0, r1			;compara r0 com 255
		jeq digLetra_Loop	; Fica lendo ate' que digite uma tecla valida
		cmp r0, r2			;compara r0 com 0
		jeq digLetra_Loop	; Le novamente pois Logo que programa a FPGA o inchar vem 0

	store Letra, r0			; Salva a tecla na variavel global "Letra"
	
   digLetra_Loop2:	
		inchar r0			; Le o teclado, se nada for digitado = 255
		cmp r0, r1			;compara r0 com 255
		jne digLetra_Loop2	; Fica lendo ate' que digite uma tecla valida
	
	pop r2
	pop r1
	pop r0
	pop fr
	rts



;--------------------------
;********************************************************
;                   IMPRIME DIGITE UMA PALAVRA
;********************************************************
	
printDigPalavra:	; Seleciona uma mensagem para imprimir - Digite uma palavra!!
	push fr		; Protege o registrador de flags
	push r0
	push r1
	push r2
	
	loadn r0, #0		; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #Msn1		; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0		; Seleciona a COR da Mensagem
	
	call ImprimeStr   ;  r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	
	pop r2
	pop r1
	pop r0	
	pop fr
	rts

;--------------------------
;********************************************************
;                   IMPRIME A PALAVRA DIGITADA
;********************************************************
	
printPalavra:	; Seleciona uma mensagem para imprimir - Digite uma palavra!!
	push fr		; Protege o registrador de flags
	push r0
	push r1
	push r2
	
	loadn r0, #0		; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #Palavra	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0		; Seleciona a COR da Mensagem
	
	call ImprimeStr   	; r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	
	pop r2
	pop r1
	pop r0	
	pop fr
	rts	
	
;---------------------------	
;********************************************************
;                   IMPRIME STRING
;********************************************************
	
ImprimeStr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push fr		; Protege o registrador de flags
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3
		jeq ImprimeStr_Sai
		add r4, r2, r4
		outchar r4, r0
		inc r0
		inc r1
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
;------------------------	
	
	
;********************************************************
;                   DESENHA FORCA
;********************************************************
DesForca:
	push fr		; Protege o registrador de flags
	push r0  ;;caracter
	push r1  ;;posicao
	push r2  ;;incremento X40
	push r3  ;;tamanho da palavra
	
	call ApagaTela	; Apaga a tela!!
	
	loadn r2, #40
	loadn r0, #'-'
	loadn r1, #42
	outchar r0, r1 	;;escreve o - na posicao 42, para nao grudar na tela
	inc r1 		;;r1 = 43
	outchar r0, r1  ;;desenha o - de novo
	inc r1 		;;r1 = 44
	outchar r0, r1  ;;desenha o - de novo
	inc r1 		;;r1 = 45
	outchar r0, r1  ;;desenha o - de novo
	inc r1 		;;r1 = 46
	outchar r0, r1  ;;desenha o - de novo

	loadn r0, #'/'	; Suporte
	loadn r1, #83
	outchar r0, r1
	
	loadn r0, #2345	;41 (')') + 2304 (vermelho) = 2345 ; Corda da Forca Vermelha
	loadn r1, #86 
	outchar r0, r1
	
	;Poste vertical
	loadn r0, #'I'  ; Poste
	loadn r1, #82 	;;incrementa de 40 em 40 pra ir pra baixo
	outchar r0, r1
	add r1, r1, r2 	;;coloca em r1(1�) o 40(que tava no r2) mais o r1 -->anda pra baixo
	outchar r0, r1
	add r1, r1, r2
	outchar r0, r1
	add r1, r1, r2
	outchar r0, r1
	add r1, r1, r2
	outchar r0, r1
	add r1, r1, r2
	outchar r0, r1
	add r1, r1, r2
	outchar r0, r1
	
	; Assoalho da Forca
	loadn r0, #'='
	sub r1, r1, r2
	inc r1
	outchar r0, r1
	inc r1
	outchar r0, r1
	inc r1
	loadn r0, #'^'	; Alcapao!!
	outchar r0, r1
	inc r1
	outchar r0, r1
	inc r1
	outchar r0, r1
	loadn r0, #'='
	inc r1
	outchar r0, r1
	inc r1
	outchar r0, r1
	
	loadn r0, #'I'
	add r1, r1, r2
	outchar r0, r1
	
	
	; Pe da Forca
	loadn r0, #'/'
	loadn r1, #361
	outchar r0, r1
	inc r1
	outchar r0, r1
	inc r1
	outchar r0, r1
	inc r1
	inc r1
	inc r1
	inc r1
	inc r1
	outchar r0, r1
	inc r1
	outchar r0, r1
	inc r1
	outchar r0, r1
	
		
	; Loop para desenhar os _ de cada letra
	loadn r0, #'_'
	loadn r1, #481   ;;inicializa o for

	load r3, PalavraSize  ;;carrega em r3 o conte�do da mem�ria apontada por PalavraSize.	
	
   DesForca_Loop: 
		outchar r0, r1  ;;label for(r3=PalavraSize;r3>0;r3--)
		inc r1 			;;posi��o da tela vai 1 pra direita
		dec r3 			;;recebe PalavraSize eh o tamanho do for  ;; r3 --;
		jnz DesForca_Loop ;;volta no loop se r3 nao for 0 ;;
	
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
;----------------
	
;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push fr		; Protege o registrador de flags
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	pop fr
	rts
	
;----------------
	
;********************************************************
;                       INPUT LETRA
;********************************************************	
inputLetra:	
	push fr; Protege o registrador de flags
	push r0; Posicao na tela da Mensagem
	push r1; Mensagem a ser impressa
	push r2; cor, aux
	push r3; TryList( endere�o de TryList )
	push r4; TryList[i]( valor dentro de TryList )
	push r5; TryListSize
	push r6; i
	push r7; Letra
	
	loadn r0, #560	; pos
	loadn r1, #Msn2	; mensagem
	loadn r2, #0	; cor
	call ImprimeStr	; Imprime mensagem para usuario digitar letra

   inputLetra_LeLetraLoop:
	call digLetra	; le letra do teclado
	
	loadn r1, #Msn3	; mensagem em branco
	call ImprimeStr	
	
	;Verificar se letra ja foi digitada, se sim, ler outra letra
	loadn r3, #TryList
	load r5, TryListSize
	loadn r6, #0	; i = 0
	load r7, Letra
	loadn r2, #0	; aux = 0
	
   inputLetra_CheckTryList:
		;checar se a letra ja foi digitada
		cmp r6, r5	; TryListSize == 0?
		jeq inputLetra_EndInputLetra	; Se lista de letras repetidas nao contem letras, vai para o fim da rotina e aceita a letra	
		
		add r2, r3, r6	; aux =  TryList + i
		loadi r4, r2	; r4 = TryList[i]
		
		cmp r4, r7	; Trylist[i] == letra ?
		jeq inputLetra_LetraRepetida	;se ja digitada vai para LetraRepetida
		
		; Se Nao, continua testando na lista:
		inc r6		; i++	
		cmp r6, r5	; i == TryListSize?
		jle inputLetra_CheckTryList	;checa se o fim da lista foi alcan�ado
	jmp inputLetra_EndInputLetra	;se chegou ao fim da lista sem encontrar repeticao, a letra eh valida

   inputLetra_LetraRepetida:
	; Se a letra for repetida, imprime mensagem que letra ja' existe e imprime as letras repetidas
	loadn r0, #560
	loadn r1, #Msn7	; Imprime mensagem que letra ja existe
	loadn r2, #0
	call ImprimeStr	; Imprime mensagem que letra ja existe
	
	loadn r0, #608
	loadn r1, #TryList	; Vetor com Letras ja' digitadas
	loadn r2, #0
	call ImprimeStr	; Imprime letras ja digitadas
	
	jmp inputLetra_LeLetraLoop	;Le novamente uma letra

   inputLetra_EndInputLetra:
	; Armazena Letra na lista de letras repetidas TryList
	add r0, r3, r5	; r0 = TryList + TryListSize 
	storei r0, r7	; TryList[TryListSize] = Letra
	
	; Escreve '\0' no final da lista TryList
	inc r0		; r0 = (TryList + TryListSize) + 1
	loadn r2, #0	; r2 = '\0'
	storei r0, r2	; TryList[TryListSize+1] = '\0'
	
	; Soma 1 no tamanho da lista TryList
	inc r5		; TryListSize++
	store TryListSize, r5	; TryListSize = TryListSize + 1
	
	loadn r0, #560	; Apagar mensagens
	loadn r1, #Msn8
	loadn r2, #0
	call ImprimeStr 
	loadn r0, #600
	loadn r1, #Msn8
	loadn r2, #0
	call ImprimeStr 
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
	
;----------------
	
;********************************************************
;                       COMPARA
;********************************************************	

Compara:	; Rotina que compara a letra digitada para ver se ela prertence a palavra
	push fr		; Protege o registrador de flags
	push r0	; Flag  Acertou a Letra
	push r1	; i = 0
	push r2	; PalavraSize
	push r3	; Letra
	push r4	; #Palavra
	push r5	; palavra + i
	push r6	; Posicao na Tela onde a letra da palavra vai ser escrita
	push r7	; Aux: Pos na tela e palavra[i]

	loadn r0, #0	; Flag  Acertou a Letra = 0
	loadn r1, #0	; i = 0
	load r2, PalavraSize
	load r3, Letra
	loadn r4, #Palavra
	;r5 = palavra + i	
	loadn r6, #481	; -- Posicao na Tela onde a letra da palavra vai ser escrita

   Compara_Loop:	; While ( i < PalavraSize )
		; Testa se ja' testou todas as letras da palavra
		cmp r1, r2	; i < PalavraSize ?
		jeq Compara_Fim
		
		; Testa se a Letra digitada pertence a palavra na posicao i
		add r5, r4, r1	; r5 = palavra + i
		loadi r7, r5	; r7 = palavra[i]
		cmp r3, r7	; Letra == palavra[i] ?
		jne Compara_NaoPertence
		
		add r7, r6, r1	; r7 = pos na tela : r7 = posicao inicial + i
		outchar r3, r7	; imprime Letra na tela no _ correspondente
		
		load r7, Acerto	; Incrementa o contador de acertos
		inc r7		; Acerto++
		store Acerto, r7
		
		inc r1; i++
		loadn r0, #1	; Flag  Acertou a Letra = 1
		jmp Compara_Loop

   Compara_NaoPertence:
	; Se nao Achou a Letra, incrementa o i e volta pro Loop
	inc r1		; i++
	jmp Compara_Loop

   Compara_Fim:
	; Se terminou de testar a letra digitada com todas as letras da palavra
	
	; Testa se ouve um acerto
	loadn r7, #1
	cmp r0, r7	; Flag  Acertou a Letra == 1 ?
	jeq Compara_FimSwitch	; Se SIM, sai da rotina!
	
	; Se NAO, incrementa o ERRO e desenha as partes do boneco
	load r7, Erro	; Se nao acertou, incrementa o contador de Erro!
	inc r7			; Erro++
	store Erro, r7
	
	; Switch Erro (r7)
   ; Case 1
	loadn r0, #1
	cmp r7, r0	; Se erro = 1
	jne Compara_Case2
	loadn r1, #'O'	; Desenha a cabeca
	loadn r2, #126
	outchar r1, r2
	jmp Compara_FimSwitch	; Break do Switch

   Compara_Case2:
	loadn r0, #2	; Se erro = 2
	cmp r7, r0
	jne Compara_Case3
	loadn r1, #'H'	; Desenha a barriga
	loadn r2, #166
	outchar r1, r2
	jmp Compara_FimSwitch	; Break do Switch

   Compara_Case3:
	loadn r0, #3	; Se erro = 3
	cmp r7, r0
	jne Compara_Case4
	loadn r1, #'U'	; Desenha a bundinha
	loadn r2, #206
	outchar r1, r2
	jmp Compara_FimSwitch	; Break do Switch
	
   Compara_Case4:
	loadn r0, #4	; Se erro = 4
	cmp r7, r0
	jne Compara_Case5
	loadn r1, #'/'	; Desenha o bra�oesq
	loadn r2, #165
	outchar r1, r2
	jmp Compara_FimSwitch	; Break do Switch

   Compara_Case5:
	loadn r0, #5	; Se erro = 5
	cmp r7, r0
	jne Compara_Case6
	loadn r1, #'\\'	; Desenha o bra�odir
	loadn r2, #167
	outchar r1, r2
	jmp Compara_FimSwitch	; Break do Switch

   Compara_Case6:
	loadn r0, #6	; Se erro = 6
	cmp r7, r0
	jne Compara_Case7
	loadn r1, #'/'	; Desenha a pernaesq
	loadn r2, #245
	outchar r1, r2
	jmp Compara_FimSwitch	; Break do Switch	

   Compara_Case7:
	loadn r0, #7	; Se erro = 7
	cmp r7, r0
	jne Compara_Case8
	loadn r1, #'\\'	; Desenha a pernadir
	loadn r2, #247
	outchar r1, r2
	jmp Compara_FimSwitch	; Break do Switch	


   Compara_Case8:	; Game Over!!
	loadn r0, #8	; Se erro = 8
	cmp r7, r0
	jne Compara_FimSwitch
	; Era pra abrir o Alcapao e enforcar o Carinha, 
	; mas resolvi imprimir uma Tela completa na rotina Testa Fim!!
	; Entao aqui nao faz nada!!

   Compara_FimSwitch:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts


;----------------
	
;********************************************************
;                       TESTA FIM
;********************************************************	
TestaFim:	; Rotina que testa se o Jogo terminou
		; Se acertou todas as letras da palavra
		; ou Se ja' desenhou todo o carinha
	push fr		; Protege o registrador de flags
	push r0	; Posicao na Tela
	push r1	; Ponteiro para as mensagens
	push r2	; Cor das mensagens
	push r3	; Contador de Acertos
	push r4	; Tamanho da Palavra
	push r5	; Contador de Erro
	push r6	; Numero maximo de erros
	
	load r5, Erro
	loadn r6, #8	; Numero maximo de erros = 8
	load r3, Acerto
	load r4, PalavraSize
	
	cmp r5, r6	; Erro = 8
	jeq TestaFim_Perdeu	
	
	cmp r3, r4		;Acerto = PalavraSize ?
	jne TestaFim_Sai	; Se Nao, vai embora digitar outra Letra
	;Se Sim, imprime voce venceu
	loadn r0, #602
	loadn r1, #Msn4
	loadn r2, #0
	call ImprimeStr

   TestaFim_JogarNovamente:	
	;imprime quer jogar novamente
	loadn r0, #642
	loadn r1, #Msn5
	loadn r2, #0
	call ImprimeStr
	
	call digLetra
	loadn r3, #'s'
	load r4, Letra
	cmp r3, r4		; tecla == 's' ?
	jne TestaFim_FimJogo	; tecla nao e' 's'
	
	; Se quiser jogar novamente...
	call ApagaTela
	pop r6	
	pop r5	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	
	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp main
	;nao

   TestaFim_Perdeu:
	; Imprime tela com carinha enforcado!!
	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  		; cor branca!
	call ImprimeTela   	;  Rotina de Impresao de Cenario na Tela Inteira
	
	loadn r0, #2428	;124 ('|') + 2304 (vermelho) = 2428 ; Corda da Forca Vermelha
	loadn r1, #86 
	outchar r0, r1
	loadn r1, #126 
	outchar r0, r1
	
	; Imprime Palavra correta!!
	loadn r0, #481   ; inicializa posicao na tela
	loadn r1, #Palavra
	loadn R2, #2816		; cor Amarelo
	call ImprimeStr
	
	; imprime voce perdeu !!
	loadn r0, #602
	loadn r1, #Msn6
	loadn r2, #0
	call ImprimeStr
	jmp TestaFim_JogarNovamente
	

   TestaFim_FimJogo:
	call ApagaTela
	halt
	
   TestaFim_Sai:

	pop r6
	pop r5	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts

;----------------
	
;********************************************************
;                       IMPRIME TELA
;********************************************************	

ImprimeTela: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push fr		; Protege o registrador de flags
	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r4 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	
   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5		; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r5	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
				
;---------------------


; Declara e preenche tela linha por linha (40 caracteres):
tela1Linha0  : string "                                        "
tela1Linha1  : string "  -----                                 "
tela1Linha2  : string "  I   |                                 "
tela1Linha3  : string "  I   |                                 "
tela1Linha4  : string "  I   o                                 "
tela1Linha5  : string "  I  |H|                                "
tela1Linha6  : string "  I   U                                 "
tela1Linha7  : string "  I==| |==                              "
tela1Linha8  : string "  I      I                              "
tela1Linha9  : string " ///    ///                             "
tela1Linha10 : string "                                        "
tela1Linha11 : string "                                        "
tela1Linha12 : string "                                        "
tela1Linha13 : string "                                        "
tela1Linha14 : string "                                        "
tela1Linha15 : string "                                        "
tela1Linha16 : string "                                        "
tela1Linha17 : string "                                        "
tela1Linha18 : string "                                        "
tela1Linha19 : string "                                        "
tela1Linha20 : string "                                        "
tela1Linha21 : string "                                        "
tela1Linha22 : string "                                        "
tela1Linha23 : string "                                        "
tela1Linha24 : string "                                        "
tela1Linha25 : string "                                        "
tela1Linha26 : string "                                        "
tela1Linha27 : string "                                        "
tela1Linha28 : string "                                        "
tela1Linha29 : string "                                        "
