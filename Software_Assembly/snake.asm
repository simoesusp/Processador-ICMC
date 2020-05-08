; Snake

; Danilo Henrique Cordeiro - 6791651  - dancorde@gmail.com
; Gabriel Kanegae Souza    - 10262648 - gabriel.kanegae@usp.br

SnakePos:  	var #500
SnakeSize:	var #1
Dir:		var #1 ; 0-right, 1-down, 2-left, 3-up

FoodPos:	var #1
FoodStatus:	var #1

GameOverMessage: 	string " GAME OVER "
EraseGameOver:		string "           "
RestartMessage:		string " Press 'Space' to Restart "
EraseRestart:		string "                          "

; Main
main:
	call Initialize
	call Draw_Stage
	
	loop:
		ingame_loop:
			call Draw_Snake
			call Dead_Snake
			
			call Move_Snake
			call Replace_Food
					
			call Delay
				
			jmp ingame_loop
		GameOver_loop:
			call Restart_Game
		
			jmp GameOver_loop
	
; Funções

Initialize:
		push r0
		push r1
		
		loadn r0, #3
		store SnakeSize, r0
		
		; SnakePos[0] = 460
		loadn 	r0, #SnakePos
		loadn 	r1, #460
		storei 	r0, r1
		
		; SnakePos[1] = 459
		inc 	r0
		dec 	r1
		storei 	r0, r1
		
		; SnakePos[2] = 458
		inc 	r0
		dec 	r1
		storei 	r0, r1
		
		; SnakePos[3] = 457
		inc 	r0
		dec 	r1
		storei 	r0, r1
		
		; SnakePos[4] = -1
		inc 	r0
		loadn 	r1, #0
		storei 	r0, r1
				
		call FirstPrintSnake
		
		loadn r0, #0
		store Dir, r0
		
		pop r1
		pop r0
		
		rts

FirstPrintSnake:
	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #SnakePos		; r0 = & SnakePos
	loadn r1, #'}'			; r1 = '}'
	loadi r2, r0			; r2 = SnakePos[0]
		
	loadn 	r3, #0			; r3 = 0
	
	Print_Loop:
		outchar r1, r2
		
		inc 	r0
		loadi 	r2, r0
		
		cmp r2, r3
		jne Print_Loop
	
	
	loadn 	r0, #820
	loadn 	r1, #'*'
	outchar r1, r0
	store 	FoodPos, r0
	
	pop	r3
	pop r2
	pop r1
	pop r0
	
	rts
	
EraseSnake:
	push r0
	push r1
	push r2
	push r3
	
	loadn 	r0, #SnakePos		; r0 = & SnakePos
	inc 	r0
	loadn 	r1, #' '			; r1 = ' '
	loadi 	r2, r0			; r2 = SnakePos[0]
		
	loadn 	r3, #0			; r3 = 0
	
	Print_Loop:
		outchar r1, r2
		
		inc 	r0
		loadi 	r2, r0
		
		cmp r2, r3
		jne Print_Loop
	
	pop	r3
	pop r2
	pop r1
	pop r0
	
	rts

Draw_Stage:
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r0, #0
	loadn r1, #39
	
	loadn r2, #'x'
	
	loadn r3, #40
	loadn r4, #1200
	
	Stage_Loop1:
		outchar r2, r0
		add r0, r0, r3
		nop
		nop
		outchar r2, r1	
		
		add r1, r1, r3
		
		cmp r0, r4
		jle Stage_Loop1
		
	loadn r0, #1
	loadn r1, #1161
	
	Stage_Loop2:
		outchar r2, r0
		inc r0
		nop
		nop
		outchar r2, r1
		
		inc r1
		
		cmp r0, r3
		jle Stage_Loop2
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	
	rts

Move_Snake:
	push r0	; Dir / SnakePos
	push r1	; inchar
	push r2 ; local helper
	push r3
	push r4
	
	; Sincronização
	loadn 	r0, #5000
	loadn 	r1, #0
	mod 	r0, r6, r0		; r1 = r0 % r1 (Teste condições de contorno)
	cmp 	r0, r1
	jne Move_End
	; =============
	
	Check_Food:
		load 	r0, FoodPos
		loadn 	r1, #SnakePos
		loadi 	r2, r1
		
		cmp r0, r2
		jne Spread_Move
		
		load 	r0, SnakeSize
		inc 	r0
		store 	SnakeSize, r0
		
		loadn 	r0, #0
		dec 	r0
		store 	FoodStatus, r0
		
	Spread_Move:
		loadn 	r0, #SnakePos
		loadn 	r1, #SnakePos
		load 	r2, SnakeSize
		
		add 	r0, r0, r2		; r0 = SnakePos[Size]
		
		dec 	r2				; r1 = SnakePos[Size-1]
		add 	r1, r1, r2
		
		loadn 	r4, #0
		
		Spread_Loop:
			loadi 	r3, r1
			storei 	r0, r3
			
			dec r0
			dec r1
			
			cmp r2, r4
			dec r2
			
			jne Spread_Loop	
	
	Change_Dir:
		inchar 	r1
		
		loadn r2, #100	; char r4 = 'd'
		cmp r1, r2
		jeq Move_D
		
		loadn r2, #115	; char r4 = 's'
		cmp r1, r2
		jeq Move_S
		
		loadn r2, #97	; char r4 = 'a'
		cmp r1, r2
		jeq Move_A
		
		loadn r2, #119	; char r4 = 'w'
		cmp r1, r2
		jeq Move_W		
		
		jmp Update_Move
	
		Move_D:
			loadn 	r0, #0
			; Impede de "ir pra trás"
			loadn 	r1, #2
			load  	r2, Dir
			cmp 	r1, r2
			jeq 	Move_Left
			
			store 	Dir, r0
			jmp 	Move_Right
		Move_S:
			loadn 	r0, #1
			; Impede de "ir pra trás"
			loadn 	r1, #3
			load  	r2, Dir
			cmp 	r1, r2
			jeq 	Move_Up
			
			store 	Dir, r0
			jmp 	Move_Down
		Move_A:
			loadn 	r0, #2
			; Impede de "ir pra trás"
			loadn 	r1, #0
			load  	r2, Dir
			cmp 	r1, r2
			jeq 	Move_Right
			
			store 	Dir, r0
			jmp 	Move_Left
		Move_W:
			loadn 	r0, #3
			; Impede de "ir pra trás"
			loadn 	r1, #1
			load  	r2, Dir
			cmp 	r1, r2
			jeq 	Move_Down
			
			store 	Dir, r0
			jmp 	Move_Up
	
	Update_Move:
		load 	r0, Dir
				
		loadn 	r2, #0
		cmp 	r0, r2
		jeq 	Move_Right
		
		loadn 	r2, #1
		cmp 	r0, r2
		jeq 	Move_Down
		
		loadn 	r2, #2
		cmp 	r0, r2
		jeq 	Move_Left
		
		loadn 	r2, #3
		cmp 	r0, r2
		jeq 	Move_Up
		
		jmp Move_End
		
		Move_Right:
			loadn 	r0, #SnakePos	; r0 = & SnakePos
			loadi 	r1, r0			; r1 = SnakePos[0]
			inc 	r1				; r1++
			storei 	r0, r1
			
			jmp Move_End
				
		Move_Down:
			loadn 	r0, #SnakePos	; r0 = & SnakePos
			loadi 	r1, r0			; r1 = SnakePos[0]
			loadn 	r2, #40
			add 	r1, r1, r2
			storei 	r0, r1
			
			jmp Move_End
		
		Move_Left:
			loadn 	r0, #SnakePos	; r0 = & SnakePos
			loadi 	r1, r0			; r1 = SnakePos[0]
			dec 	r1				; r1--
			storei 	r0, r1
			
			jmp Move_End
		Move_Up:
			loadn 	r0, #SnakePos	; r0 = & SnakePos
			loadi 	r1, r0			; r1 = SnakePos[0]
			loadn 	r2, #40
			sub 	r1, r1, r2
			storei 	r0, r1
			
			jmp Move_End
	
	Move_End:
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0

	rts

Replace_Food:
	push r0
	push r1

	loadn 	r0, #0
	dec 	r0
	load 	r1, FoodStatus
	cmp 	r0, r1
	
	jne Replace_End
	
	loadn r1, #0
	store FoodStatus, r1
	load  r1, FoodPos
	
	load r0, Dir
	
	loadn r2, #0
	cmp r0, r2
	jeq Replace_Right
	
	loadn r2, #1
	cmp r0, r2
	jeq Replace_Down
	
	loadn r2, #2
	cmp r0, r2
	jeq Replace_Left
	
	loadn r2, #3
	cmp r0, r2
	jeq Replace_Up
	
	Replace_Right:
		loadn r3, #355
		add r1, r1, r3
		jmp Replace_Boundaries
	Replace_Down:
		loadn r3, #445
		sub r1, r1, r3
		jmp Replace_Boundaries
	Replace_Left:
		loadn r3, #395
		sub r1, r1, r3
		jmp Replace_Boundaries
	Replace_Up:
		loadn r3, #485
		add r1, r1, r3
		jmp Replace_Boundaries
	
	
	Replace_Boundaries:
		loadn r2, #40
		cmp r1, r2
		jle Replace_Lower
		
		loadn r2, #1160
		cmp r1, r2
		jgr Replace_Upper
		
		loadn r0, #40
		loadn r3, #1
		mod r2, r1, r0
		cmp r2, r3
		jel Replace_West
		
		loadn r0, #40
		loadn r3, #39
		mod r2, r1, r0
		cmp r2, r3
		jeg Replace_East
		
		jmp Replace_Update
		
		Replace_Upper:
			loadn r1, #215
			jmp Replace_Update
		Replace_Lower:
			loadn r1, #1035
			jmp Replace_Update
		Replace_East:
			loadn r1, #835
			jmp Replace_Update
		Replace_West:
			loadn r1, #205
			jmp Replace_Update
			
		Replace_Update:
			store FoodPos, r1
			loadn r0, #'*'
			outchar r0, r1
	
	Replace_End:
		pop r1
		pop r0
	
	rts

Dead_Snake:
	loadn r0, #SnakePos
	loadi r1, r0
	
	; Trombou na parede direita
	loadn r2, #40
	loadn r3, #39
	mod r2, r1, r2		; r2 = r1 % r2 (Teste condições de contorno)
	cmp r2, r3
	jeq GameOver_Activate
	
	; Trombou na parede esquerda
	loadn r2, #40
	loadn r3, #0
	mod r2, r1, r2		; r2 = r1 % r2 (Teste condições de contorno)
	cmp r2, r3
	jeq GameOver_Activate
	
	; Trombou na parede esquerda
	loadn r2, #40
	cmp r1, r2
	jle GameOver_Activate
	
	; Trombou na parede esquerda
	loadn r2, #1160
	cmp r1, r2
	jgr GameOver_Activate
	
	; Trombou na própria cobra
	Collision_Check:
		load 	r2, SnakeSize
		loadn 	r3, #1
		loadi 	r4, r0			; Posição da cabeça
		
		Collision_Loop:
			inc 	r0
			loadi 	r1, r0
			cmp r1, r4
			jeq GameOver_Activate
			
			dec r2
			cmp r2, r3
			jne Collision_Loop
		
	
	jmp Dead_Snake_End
	
	GameOver_Activate:
		load 	r0, FoodPos
		loadn 	r1, #' '
		outchar r1, r0
	
		loadn r0, #615
		loadn r1, #GameOverMessage
		loadn r2, #0
		call Imprime
		
		loadn r0, #687
		loadn r1, #RestartMessage
		loadn r2, #0
		call Imprime
		
		jmp GameOver_loop
	
	Dead_Snake_End:
	
	rts

Draw_Snake:
	push r0
	push r1
	push r2
	push r3 
	
	; Sincronização
	loadn 	r0, #1000
	loadn 	r1, #0
	mod 	r0, r6, r0		; r1 = r0 % r1 (Teste condições de contorno)
	cmp 	r0, r1
	jne Draw_End
	; =============
	
	load 	r0, FoodPos
	loadn 	r1, #'*'
	outchar r1, r0
	
	loadn 	r0, #SnakePos	; r0 = & SnakePos
	loadn 	r1, #'o'		; r1 = '}'
	loadi 	r2, r0			; r2 = SnakePos[0]
	outchar r1, r2			
	
	loadn 	r0, #SnakePos	; r0 = & SnakePos
	loadn 	r1, #' '		; r1 = ' '
	load 	r3, SnakeSize	; r3 = SnakeSize
	add 	r0, r0, r3		; r0 += SnakeSize
	loadi 	r2, r0			; r2 = SnakePos[SnakeSize]
	outchar r1, r2
	
	Draw_End:
		pop	r3
		pop r2
		pop r1
		pop r0
	
	rts
;----------------------------------
Delay:
	push r0
	
	inc r6
	loadn r0, #60000
	cmp r6, r0
	jgr Reset_Timer
	
	jmp Timer_End
	
	Reset_Timer:
		loadn r6, #0
	Timer_End:		
		pop r0
	
	rts
	
Delay2: ; Delay para desenhar o cenário sem bugar
	push r0
	
	inc r6
	loadn r0, #1
	cmp r6, r0
	jgr Reset_Timer
	
	jmp Timer_End
	
	Reset_Timer:
		loadn r6, #0
	Timer_End:		
		pop r0
	
	rts

Restart_Game:
	inchar 	r0
	loadn 	r1, #' '
	
	cmp r0, r1
	jeq Restart_Activate
	
	jmp Restart_End
	
	Restart_Activate:
		loadn r0, #615
		loadn r1, #EraseGameOver
		loadn r2, #0
		call Imprime
		
		loadn r0, #687
		loadn r1, #EraseRestart
		loadn r2, #0
		call Imprime
	
		call EraseSnake
		call Initialize
		
		jmp ingame_loop
		
	Restart_End:
	
	rts

Imprime:
	push r0		; Posição na tela para imprimir a string
	push r1		; Endereço da string a ser impressa
	push r2		; Cor da mensagem
	push r3
	push r4

	
	loadn r3, #'\0'

	LoopImprime:	
		loadi r4, r1
		cmp r4, r3
		jeq SaiImprime
		add r4, r2, r4
		outchar r4, r0
		inc r0
		inc r1
		jmp LoopImprime
		
	SaiImprime:	
		pop r4	
		pop r3
		pop r2
		pop r1
		pop r0
		
	rts
