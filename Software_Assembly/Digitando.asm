;	-	Programa que simula um editor de texto	-
; Nathan Oliveira
;Obs: O programa encerra ao se digitar 'esc'
jmp main

boasvindas: string "   Word - Assembly  /-Apaga e &-Sai"


main:

loadn r0, #0 ; Carrega no registrador a posição inicial da primeira letra da string
loadn r1, #boasvindas ; Carrega a string de abertura a ser impressa
loadn r2, #3328 ; Carrega a cor da mensagem de abertura

call Imprimestring ; Impremestring(posicaoinicial,endereçostring,cor)

loadn r0, #80 ; Carrega onde o usuário vai começar a digitar
loadn r1, #0 ; Carrega a cor da letra do usuário

call Digitando ; Digitando(posicaoinicial,cor)

halt

Imprimestring:
	push r0 ; Preserva o valor de r0,r1 e r2 para não alterá-lo na main, além de r3 e r4 que poderiam estar sendo usados lá e serão necessários nessa subrotina
	push r1
	push r2
	push r3
	push r4

	loadn r3, #'\0' ;Condição de parada de impressão de string
	
Imprimestringloop:
	loadi r4,r1		;Faz um load do conteudo apontado por r1 no registrador r4
	cmp r4,r3 		
	jeq Imprimestringfim	;Ve se o caractere atual é o /0
	add r4, r4,r2			;Faz a dinamica da cor (= O + 256 é porque todos os ascii de cada cor estão enfileirados, ao somar 256 ele pega o mesmo char só que de outra cor, Obs: tem um mod implementado, então depois do aqua vem branco denovo )
	outchar r4, r0			;Escreve o caracter no endereço de r1 na posição r0 da tela
	inc r0					;Vai para proxima posição da tela
	inc r1					;Vai para a proxima posição do vetor
	jmp Imprimestringloop
	
Imprimestringfim:

	pop r4 ; Devolve os valores originais aos registradores e volta para onde foi chamada
	pop r3
	pop r2
	pop r1
	pop r0
	rts

Digitando: ; A função digitando faz o controle dos caracteres na tela enquanto o usuário digita
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	mov r2,r0 ;Reserva em r2 a posicao inicial e r2 será a posição corrente
	loadn r3, #'/' ; codigo ascii do backspace -  -não funciona ???
	loadn r4, #'&' ; codigo ascii do esc 27 - ~ 127 - como o simulador já sai com esc para testes esta o &
	loadn r5, #' '; codigo ascii do espaço
	loadn r6, #40 ; tamanho da linha
	loadn r7, #13 ; codigo ascii do enter
	
	DigitandoLoop:
	
	call RecebeChar ;atualiza r0 com o char inserido pelo usuario
	cmp r0,r3 ; verifica se é um enter, delete ou &
	jeq DigitandoApagar
	cmp r0,r4
	jeq DigitandoFim
	cmp r0,r7
	jeq DigitandoEnter
	
	outchar r0, r2
	inc r2
	jmp DigitandoLoop
	
	DigitandoEnter:
	;Para pular para a proxima linha, vê quantos caracteres faltam para acabar a linha e pula eles
	push r0
	push r1
	
	mod r1,r2,r6 ; pega em mod a posição atual da linha
	sub r0,r6,r1 ;verificam quandos faltam para o fim da linha
	add r2,r2,r0 ; pula os caracteres 
	
	pop r1
	pop r0
	jmp DigitandoLoop
	
	DigitandoApagar:
	dec r2
	outchar r5, r2
	jmp DigitandoLoop
	
	DigitandoFim:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
RecebeChar: ;a função RecebeChar é um loop que só se encerra ao receber uma entrada do usuario devolvendo o código ascii dessa tecla em r0
	push r1
	loadn r1, #255
	RecebeCharLoop:
	inchar r0 ; o Inchar devolve 255 se nenhuma tecla esta sendo precionada, então ao esperar uma tecla, ele fica testando até alguem apertar algo
	cmp r0, r1
	jeq RecebeCharLoop
	;breakp
	pop r1
	rts
