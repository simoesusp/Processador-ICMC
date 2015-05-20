;Cristiano Lacerda 8531737
;Eduardo Pacheco  8632455
	jmp main
ship_pos: var #1 ; posição atual e anterior da nave

enemiesPos: var #128 ; posição atual 128(max) de inimigos
nEnemies: var #1
maxEnemies: var #1

fShoot: var #1


lives: var #1
score: var #1
seed: var #1

shots_pos: var #3
cmax_shots: var #1
negative_one: var #1

vidas: string "Vidas:"
placar: string "Placar:"


end_screen1: string "Voce perdeu!!"
end_screen2: string "Deseja jogar outra vez?"
end_screen3: string "1. Sim"
end_screen4: string "2. Nao"

welcome_screen1: string "Bem vindo ao nosso jogo"
welcome_screen2: string "Aperte qualquer tecla para jogar"

main:

	call Welcome
	call init
	loadn r0, #0
	loadn r2, #0


Game_Run:
	
	

	call print_info
	loadn r1, #15
	mod r1, r0, r1
	cmp r1, r2		
	ceq MoveSpaceShip	

	loadn r1, #1
	mod r1, r0, r1
	cmp r1, r2		
	ceq action_shot	

	loadn r1, #60
	mod r1, r0, r1
	cmp r1, r2		
	ceq Enemies	

	call Delay
	inc r0 	
	jmp Game_Run


Welcome:
	
	
	
	push r0
	push r1
	call clean_screen
	loadn r0, #welcome_screen1
	loadn r1, #130
	call print_str
	loadn r0, #welcome_screen2
	loadn r1, #165
	call print_str
	call getchar
	store seed, r6
	call clean_screen
	pop r1
	pop r0
	rts




Loose:

	
	call clean_screen
	loadn r0, #end_screen1
	loadn r1, #130
	call print_str
	loadn r0, #end_screen2
	loadn r1, #170
	call print_str
	loadn r0, #end_screen3
	loadn r1, #210
	call print_str
	loadn r0, #end_screen4
	loadn r1, #250
	call print_str
	call getchar
	loadn r1, #'1'
	cmp r1, r7
	jeq main
	loadn r6, #'2'
	cmp r6, r7
	jne Loose
	halt



rand:  ;			int rand[r7] (max[r1])
	

	push r2
	push r3
	push r4
	load r0, seed
	loadn r2, #512
	loadn r3, #1009
	loadn r4, #7 
	mul r7, r0, r2
	add r7, r7, r2
	div r7, r7, r4
	store seed, r7
	mod r7, r0, r1
	pop r4
	pop r3
	pop r2
	rts

getchar:	; char getchar ()

	push r0
	push r1
	loadn r0, #255
	loadn r1, #251

getchar_waitInput:

	inc r6
	cmp r1, r6
	ceq reset
	inchar r7
	cmp r7, r0
	
	jeq getchar_waitInput

	pop r1
	pop r0
	rts

reset: 

	loadn r6, #0
	rts



clean_screen:
	push r0
	push r1
	push r2
	loadn r0, #255
	loadn r1, #1200
	loadn r2, #0
	
clean_loop:
	
	outchar r0, r2
	inc r2
	cmp r2, r1
	jne clean_loop
	
clean_end:
	
	pop r2
	pop r1
	pop r0
	rts



init:

	push r0
	push r1
	push r2
	push r3
	push r4
	;zera o placar
	loadn r0, #0
	loadn r1, #score
	storei r1, r0
	;seta as vidas
	loadn r0, #3
	loadn r1, #lives
	storei r1, r0
	;zera a posição da nave	
	loadn r0, #1180
	loadn r1, #ship_pos
	storei r1, r0	
	;zera a posição dos inimigos 11000 representa que o inimigo não existe
	loadn r0, #11000
	loadn r1, #enemiesPos
	loadn r2, #128
	loadn r3, #0
	store nEnemies, r3
	loadn r4, #1
	store maxEnemies, r4
enemies_loop:
	storei r1, r0
	inc r1
	inc r3
	cmp r2, r3
	jne enemies_loop
	;zera a posição dos tiros 11000 representa que o tiro não existe
	loadn r0, #11000
	loadn r1, #shots_pos
	loadn r2, #3
	loadn r3, #0
shoots_loop:
	storei r1, r0
	inc r1
	inc r3
	cmp r2, r3
	jne shoots_loop

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

action_shot:		; void action_shot(bool fshoot)	
	push r0
	push r1
	push r3
	push r4
	push r5


	load r0, fShoot
	loadn r1, #0	; loop i
	loadn r3, #shots_pos

actionshot_loop:
	loadi r4, r3	; current shot on action

	loadn r5, #11000
	cmp r4, r5		; if shot_pos == -1, no shot at the slot
	jeq actionshot_noshot

	loadn r5, #' '
	outchar r5, r4

	loadn r5, #40
	cmp r4, r5 		; if shot_pos < 40, end of screen
	jle actionshot_screenend
	jmp actionshot_move

actionshot_move:
	loadn r5, #40
	sub r4, r4, r5

	push r0
	mov r0, r4
	call actionshot_checkcollission
	mov r4, r7
	pop r0

	storei r3, r4
	loadn r5, #11000
	cmp r5, r4
	jne actionshot_printshot
	jmp actionshot_next

actionshot_printshot:
	loadn r5, #'|'
	outchar r5, r4
	jmp actionshot_next

actionshot_next:
	inc r1			; next shot to act
	inc r3

	load r5, cmax_shots
	cmp r1, r5
	jle actionshot_loop
	jmp actionshot_end

actionshot_screenend:
	loadn r5, #11000
	storei r3, r5	; shot vanishes
	jmp actionshot_next

actionshot_noshot:
	loadn r5, #0
	cmp r0, r5
	jeq actionshot_next

	load r4, ship_pos
	loadn r0, #0
	jmp actionshot_move

actionshot_end:

	loadn r0, #0
	store fShoot, r0
	pop r5
	pop r4
	pop r3
	pop r1
	pop r0
	rts

actionshot_checkcollission:		; int actionshot_checkcollission(int pshot);
								; returns pshot if there was no collission, otherwise -1
	push r1
	push r2
	push r3
	push r4
	push r5
	loadn r1, #0
	loadn r2, #enemiesPos
	mov r7, r0

actionshotcheckcollission_loop:
	loadi r3, r2
	cmp r3, r0
	jeq actionshotcheckcollission_collapse

actionshotcheckcollission_next:
	inc r2
	inc r1

	loadn r3, #maxEnemies
	loadi r3, r3
	cmp r1, r3
	jle actionshotcheckcollission_loop
	jmp actionshotcheckcollission_end

actionshotcheckcollission_collapse:
	loadn r4, #' '
	outchar r4, r3

	loadn r4, #30
	div r3, r3, r4		; score += (enemypos / nlines)
	loadn r4, #40
	sub r3, r4, r3
	loadn r4, #score
	loadi r5, r4
	add r3, r5, r3
	storei r4, r3

	loadn r7, #11000
	storei r2, r7
	jmp actionshotcheckcollission_next

actionshotcheckcollission_end:
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	rts


MoveSpaceShip:

	push r0
	push r1
	push r2

	load r0, ship_pos
	
	
	inchar r1

	loadn r2, #'a'
	cmp r1, r2
	ceq ShipLeft
	loadn r2, #'d'
	cmp r1, r2
	ceq ShipRight
	loadn r2, #' '
	cmp r1, r2
	ceq ShipShot
	call PrintSpaceShip	
	
	pop r2
	pop r1
	pop r0
	rts

PrintSpaceShip:

	loadn r1, #'A'
	outchar r1, r0
	rts

ShipShot:

	push r1
	loadn r1, #1
	store fShoot, r1
	pop r1
	rts

ShipLeft:
	
	push r1
	push r2
	push r3
	loadn r1, #1160
	loadn r2, #255
	cmp r0, r1
	jeq ShipStill
	outchar r2, r0
	dec r0
	store ship_pos, r0
	pop r3
	pop r2
	pop r1
	rts

ShipRight:
	
	push r1
	push r2
	push r3
	loadn r1, #1199	
	loadn r2, #255
	cmp r0, r1
	jeq ShipStill	
	outchar r2, r0
	inc r0
	store ship_pos, r0
	pop r3
	pop r2
	pop r1
	rts

ShipStill:
 	
 	pop r3
 	pop r2
 	pop r1
 	rts

Enemies:

	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	load r0, score
	loadn r1, #100
	div r0, r0, r1

	loadn r4, #1
	add r4, r4, r0
	store maxEnemies, r4

	loadn r1, #11000
	loadn r2, #0
	
	loadn r5, #enemiesPos
	loadn r6, #'O'
	

Enemies_Loop:

	loadi r3, r5
	cmp r1, r3
	ceq New_Enemy
	cmp r1, r3
	cne Move_Enemy
	inc r2
	inc r5
	cmp r2, r4


	jle Enemies_Loop

	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	
	rts

New_Enemy:
	
	push r1
	push r2
	loadn r1, #20
	loadn r2, #10
	call rand
	add r7, r7, r2
	storei r5, r7
	loadn r1, #'O'
	outchar r1, r7
	pop r2
	pop r1
	rts

Move_Enemy:

	push r1
	push r2


	loadn r1, #1170
	cmp r1, r3
	jle Hit

	loadn r1, #3
	call rand
	dec r1
	dec r1
	cmp r7, r1
	jgr Enemy_Left
	jle Enemy_Foward
	jeq Enemy_Right
	jmp Move_Enemy

	pop r2
	pop r1
	rts


Enemy_Foward:

	loadn r2, #' '
	outchar r2, r3
	loadn r2, #40
	add r3, r3, r2
	loadn r2, #'O'
	outchar r2, r3
	storei r5, r3
	pop r2
	pop r1
	rts

Enemy_Left:

	loadn r2, #' '
	outchar r2, r3
	loadn r2, #39
	add r3, r3, r2
	loadn r2, #'O'
	outchar r2, r3
	storei r5, r3
	pop r2
	pop r1
	rts

Enemy_Right:

	loadn r2, #' '
	outchar r2, r3
	loadn r2, #41
	add r3, r3, r2
	loadn r2, #'O'
	outchar r2, r3
	storei r5, r3
	pop r2
	pop r1
	rts

Hit:
	
	loadn r1, #' '
	outchar r1, r3
	loadn r3, #11000
	storei r5, r3
	call CheckLives
	pop r2
	pop r1
	rts

CheckLives:

	push r0
	push r1

	load r0, lives
	dec r0
	store lives, r0
	loadn r1, #0
	cmp r0, r1
	jeq Loose
	pop r1
	pop r0



Delay:

	Push R0
	Push R1
	
	Loadn R1, #5  ;
   Delay_volta2:				
   	Loadn R0, #200	; b
   Delay_volta: 
	Dec R0					
	JNZ Delay_volta	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS		

print_nr:		; Imprime o N na tela, apartir da posicao P
				; r0 = numero N a ser impresso.
				; r1 = posicao P.
				; r7 = retorna o numero de caracteres impressos.
	push 	r0
	push	r1
	push	r2
	push	r3
	push 	r4
	push 	r5

	loadn	r2, #'0'		; Armazena o codigo ASCII do numero zero para print
	loadn	r3, #0			; Armazena o valor zero para flag de parada
	loadn 	r4, #10			; Armazena o valor dez para pegar as casas decimais
	loadn 	r7, #0 			; Contagem de caracteres


pintnr_getDigits:
	mod 	r5, r0, r4		; r5 = n % 10
	div 	r0, r0, r4		; n /= 10
	add		r5, r5, r2		; r5 += '0'
	push	r5

	inc 	r7 				; contando caracteres

	cmp 	r0, r3
	jne 	pintnr_getDigits	; se n != 0, repita

	add r0, r1, r7 			; ultima posicao da tela a imprimir
printnr_printDigits:
	pop r2
	outchar r2, r1

	inc r1
	cmp r1, r0
	jle printnr_printDigits

	pop 	r5
	pop 	r4
	pop 	r3
	pop 	r2
	pop 	r1
	pop 	r0
	rts

print_info:

	push r0
	push r1
	push r7

	loadn r0, #placar
	loadn r1, #0
	call print_str
	add r1, r7, r1
	load r0, score
	call print_nr
	loadn r0, #vidas
	loadn r1, #30
	call print_str
	load r0, lives
	add r1, r7, r1
	call print_nr
	
	pop r7
	pop r1
	pop r0
	rts



print_str:			; Imprimi STR na tela, apartir do ponto P ate encontrar '\0'
					; r0 = string STR
					; r1 = posicao P inicial da tela
					; r7 = contagem de caracteres impressos
	push 	r0
	push	r1
	push 	r2
	push 	r3

	loadn	r2, #'\0'
	loadn	r7, #0			; Contagem de caracteres

printstr_runstr:
	loadi 	r3, r0
	cmp 	r3, r2 			; if str[i] == '\0'
	jeq		printstr_end 	; 	sai do while

	outchar r3, r1

	inc 	r0
	inc 	r1
	inc 	r7
	jmp 	printstr_runstr

printstr_end:

	pop 	r3
	pop 	r2
	pop 	r1
	pop 	r0
	rts
