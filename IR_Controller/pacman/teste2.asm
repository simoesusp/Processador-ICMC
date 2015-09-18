jmp main

main:
	loadn r0, #0
	loadn r5, #'a'

	loadn r1, #2
	loadn r2, #1
	loadn r3, #4
	loadn r4, #6

main_volta:
	outchar r5, r0
	ir r7

	cmp r7, r1
	ceq esquerda

	cmp r7, r2
	ceq baixo

	cmp r7, r3
	ceq direita

	cmp r7, r4
	ceq cima

	jmp main_volta

; ############### ESQUERDA ############### 

esquerda:
	push r1
	push r2
	push r3
	loadn r1, #40
	loadn r2, #0
	mod r3, r0, r1
	cmp r3, r2
	jeq esquerda_fim

	loadn r2, #' '
	outchar r2, r0

	loadn r1, #1
	sub r0, r0, r1
esquerda_fim:
	pop r3
	pop r2
	pop r1
	rts

; ############### BAIXO ############### 

baixo:
	push r1
	push r2
	push r3
	loadn r1, #40
	loadn r2, #29
	div r3, r0, r1
	cmp r3, r2
	jeq baixo_fim

	loadn r2, #' '
	outchar r2, r0

	add r0, r0, r1

baixo_fim:
	pop r3
	pop r2
	pop r1
	rts

; ############### DIREITA ############### 

direita:
	push r1
	push r2
	push r3
	loadn r1, #40
	loadn r2, #39
	mod r3, r0, r1
	cmp r3, r2
	jeq direita_fim

	loadn r2, #' '
	outchar r2, r0

	loadn r1, #1
	add r0, r0, r1

direita_fim:
	pop r3
	pop r2
	pop r1
	rts

; ############### CIMA ############### 

cima:
	push r1
	push r2
	push r3
	loadn r1, #40
	loadn r2, #0
	div r3, r0, r1
	cmp r3, r2
	jeq cima_fim

	loadn r2, #' '
	outchar r2, r0

	sub r0, r0, r1

cima_fim:
	pop r3
	pop r2
	pop r1
	rts


