#ifndef MNEUMONICOS_H
#define MNEUMONICOS_H

#define TAMANHO_PALAVRA 16
#define TAMANHO_MEMORIA 32768

#define LOAD 48
#define STORE 49
#define LOADIMED 56
#define LOADINDEX 60
#define STOREINDEX 61
#define MOV	51
#define OUTCHAR	50
#define INCHAR 53
#define ADD 32
#define SUB 33
#define MULT 34
#define DIV	35
#define INC	36
#define LMOD 37
#define LAND 18
#define LOR 19
#define LXOR 20
#define LNOT 21
#define SHIFT 16
#define CMP 22
#define JMP 2
#define CALL 3
#define RTS	4
#define PUSH 5
#define POP	6
#define NOP	0
#define HALT 15
#define SETC 8
#define BREAKP 14

#define TAM 5       // Numero de instrucoes de duas linhas


#define BLACK 15
#define BROWN 1
#define GREEN 2
#define OLIVE 3
#define NAVY 4
#define PURPLE 5
#define TEAL 6
#define SILVER 7
#define GRAY 8
#define RED 9
#define LIME 10
#define YELLOW 11
#define BLUE 12
#define FUCHSIA 13
#define AQUA 14
#define WHITE 0


#define N_LINHAS 35

#ifndef _linux_

#define MUITO_RAPIDA 1
#define RAPIDA 			 3
#define MEDIA 			 25
#define LENTA				 50
#define MUITO_LENTA  100

#else
#define MUITO_RAPIDA 1
#define RAPIDA 			 10000
#define MEDIA 			 25000
#define LENTA				 50000
#define MUITO_LENTA  100000

#endif

#endif

