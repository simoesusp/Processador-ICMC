;---- Inicio do Programa em C -----

;	int A = 2;
;	int B = 3;
;	int C;

;	int main()
;	{
;		C = A + B;

;	   return 0;
;	}

;---- Declaracao de Variaveis
	loadn r6, #2
	loadn r7, #3
	store 1000, r6
	store 2000, r7

;---- Inicio do Programa Principal -----

	load r0, 1000
	load r1, 2000

	add r2, r0, r1

	store 3000, r2

	halt
;--FIM : Nao pode ter TAB na ultima linha!!