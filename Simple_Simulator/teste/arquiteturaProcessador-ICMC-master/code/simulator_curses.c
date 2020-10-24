//---------------------------------------------------
// Simulator Curses
// By: Breno Cunha Queiroz and Maria Eduarda Kawakami
// Date: 19/06/20
//---------------------------------------------------
#include "simulator_curses.h"
#include "utils.h"

//Curses colors
#define WIN_COLOR_BLACK 16
#define WIN_COLOR_WHITE 17
#define WIN_COLOR_RED 18
#define WIN_COLOR_BLUE 19
#define WIN_COLOR_GREEN 20
#define WIN_COLOR_GRAY 21

// Cores simulador
#define SIM_COLOR_PRETO 0
#define SIM_COLOR_MARROM 1
#define SIM_COLOR_VERDE 2
#define SIM_COLOR_OLIVA 3
#define SIM_COLOR_AZUL_MARINHO 4
#define SIM_COLOR_ROXO 5
#define SIM_COLOR_TEAL 6
#define SIM_COLOR_PRATA 7
#define SIM_COLOR_CINZA 8
#define SIM_COLOR_VERMELHO 9
#define SIM_COLOR_LIMA 10
#define SIM_COLOR_AMARELO 11
#define SIM_COLOR_AZUL 12
#define SIM_COLOR_ROSA 13
#define SIM_COLOR_AQUA 14
#define SIM_COLOR_BRANCO 15

//Curses pairs
#define PAIR_BACKGROUND 16
#define PAIR_TITLES 17
#define PAIR_NUMBERS 18
#define PAIR_REGISTERS 19
#define PAIR_CODE 20

// Pares simulador
#define SIM_PAIR_BRANCO 0
#define SIM_PAIR_MARROM 1
#define SIM_PAIR_VERDE 2
#define SIM_PAIR_OLIVA 3
#define SIM_PAIR_AZUL_MARINHO 4
#define SIM_PAIR_ROXO 5
#define SIM_PAIR_TEAL 6
#define SIM_PAIR_PRATA 7
#define SIM_PAIR_CINZA 8
#define SIM_PAIR_VERMELHO 9
#define SIM_PAIR_LIMA 10
#define SIM_PAIR_AMARELO 11
#define SIM_PAIR_AZUL 12
#define SIM_PAIR_ROSA 13
#define SIM_PAIR_AQUA 14
#define SIM_PAIR_PRETO 15

#define TAMANHO_MEMORIA 32768

// Barra onde mostra os registradores
WINDOW* topBar;
// Tela de saida dos caracteres da simulacao
WINDOW* outWindow;
//Tela onde mostra o código
WINDOW* codeWindow;

void curses_create_window()
{
	// Inicializa o curses, cria cores e pares
	curses_setup();

	// Cria janelas no terminal
	int maxX=0, maxY=0;
	// Recebe tamanho maximo de y e x
	getmaxyx(stdscr, maxY, maxX);

	// Cria janela topBar
	topBar = newwin(3, maxX, 0, 0);
	// Cria janela de código
	codeWindow = newwin(maxY-3, 70, 3, 0);
	// Cria janela de outchar
	outWindow = newwin(WINDOW_HEIGHT+1, WINDOW_WIDTH, 3, maxX-WINDOW_WIDTH);

	if(topBar == NULL || outWindow == NULL || codeWindow == NULL)
	{
		printf("[Curses] Nao foi possivel criar as janelas.\n");
		exit(1);
	}
	refresh();

	// Limpa a tela para comecar a desenhar
	curses_init_top_bar_window();
	curses_init_code_window();
	curses_init_out_window();
}

void curses_destroy_window()
{
	// TODO
	// Estou usando "stty sane" no Makefile para arrumar a bagunca do curses
	// O ideal seria arrumar de alguma forma quando destroi a janela
	endwin();
}

void curses_setup()
{
	// Inicializa janela do curses
	initscr();
	noecho();
	clear();
	//raw();
	keypad(stdscr, TRUE);
	curs_set(FALSE);
	timeout(0);

	// Checa se o terminal suporta as cores
	if (has_colors() == FALSE) 
	{
		endwin();
		printf("[Curses] Seu terminal nao suporta as cores.\n");
		exit(1);
	}
	start_color();
	
	// Cria as cores
	init_color(WIN_COLOR_BLACK, 100, 100, 100);
	init_color(WIN_COLOR_WHITE, 1000, 1000, 1000);
	init_color(WIN_COLOR_RED, 1000, 500, 500);
	init_color(WIN_COLOR_BLUE, 500, 500, 1000);
	init_color(WIN_COLOR_GREEN, 500, 1000, 500);
	init_color(WIN_COLOR_GRAY, 300, 300, 300);

	// Cria cores do simulador
	init_color(SIM_COLOR_BRANCO, 1000, 1000, 1000);
	init_color(SIM_COLOR_MARROM, 360, 200, 200);
	init_color(SIM_COLOR_VERDE, 0, 1000, 0);
	init_color(SIM_COLOR_OLIVA, 1000, 1000, 1000);
	init_color(SIM_COLOR_AZUL_MARINHO, 1000, 1000, 1000);
	init_color(SIM_COLOR_ROXO, 1000, 1000, 1000);
	init_color(SIM_COLOR_TEAL, 1000, 1000, 1000);
	init_color(SIM_COLOR_PRATA, 1000, 1000, 1000);
	init_color(SIM_COLOR_CINZA, 1000, 1000, 1000);
	init_color(SIM_COLOR_VERMELHO, 1000, 0, 0);
	init_color(SIM_COLOR_LIMA, 1000, 1000, 1000);
	init_color(SIM_COLOR_AMARELO, 1000, 1000, 0);
	init_color(SIM_COLOR_AZUL, 0, 0, 1000);
	init_color(SIM_COLOR_ROSA, 1000, 1000, 1000);
	init_color(SIM_COLOR_AQUA, 1000, 1000, 1000);
	init_color(SIM_COLOR_PRETO, 0, 0, 0);

	// Cores dos caracteres do simulador
	init_color(WIN_COLOR_BLACK, 100, 100, 100);
	init_color(WIN_COLOR_WHITE, 1000, 1000, 1000);
	init_color(WIN_COLOR_RED, 1000, 500, 500);
	init_color(WIN_COLOR_BLUE, 500, 500, 1000);
	init_color(WIN_COLOR_GREEN, 500, 1000, 500);
	init_color(WIN_COLOR_GRAY, 300, 300, 300);
	
	// Cria pares com as cores
	init_pair(PAIR_BACKGROUND, WIN_COLOR_BLACK, WIN_COLOR_BLACK);
	init_pair(PAIR_NUMBERS, WIN_COLOR_WHITE, WIN_COLOR_BLACK);
	init_pair(PAIR_TITLES, WIN_COLOR_GREEN, WIN_COLOR_GRAY);
	init_pair(PAIR_REGISTERS, WIN_COLOR_BLUE, WIN_COLOR_BLACK);
	init_pair(PAIR_CODE, WIN_COLOR_WHITE, WIN_COLOR_BLACK);
	
	// Cria pares do simulador
	init_pair(SIM_PAIR_BRANCO,SIM_COLOR_BRANCO, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_MARROM,SIM_COLOR_MARROM, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_VERDE,SIM_COLOR_VERDE, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_OLIVA,SIM_COLOR_OLIVA, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_AZUL_MARINHO,SIM_COLOR_AZUL_MARINHO, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_ROXO,SIM_COLOR_ROXO, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_TEAL,SIM_COLOR_TEAL, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_PRATA,SIM_COLOR_PRATA, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_CINZA,SIM_COLOR_CINZA, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_VERMELHO,SIM_COLOR_VERMELHO, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_LIMA,SIM_COLOR_LIMA, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_AMARELO,SIM_COLOR_AMARELO, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_AZUL,SIM_COLOR_AZUL, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_ROSA,SIM_COLOR_ROSA, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_AQUA,SIM_COLOR_AQUA, SIM_COLOR_PRETO);
	init_pair(SIM_PAIR_PRETO,SIM_COLOR_PRETO, SIM_COLOR_PRETO);

	// Set background color
	bkgd(COLOR_PAIR(PAIR_BACKGROUND));

}

void curses_update(estado_da_maquina_curses estado)
{
	curses_draw_top_bar_window(estado);
	curses_draw_code_window(estado);
	wrefresh(codeWindow);
}

void curses_init_top_bar_window() 
{
	int maxX, maxY;
	getmaxyx(topBar,maxY,maxX);

	// Background do titulo
	wattr_on(topBar, COLOR_PAIR(PAIR_TITLES), NULL);
	for(int i=0; i<maxX; i++)
	{
   		wmove(topBar, 0, i);
		wprintw(topBar, " ");
	}
	wattr_off(topBar, COLOR_PAIR(PAIR_TITLES), NULL);

	// Titulo topBar "REGISTERS"
	wattr_on(topBar, COLOR_PAIR(PAIR_TITLES), NULL);
	char title_reg[] = "REGISTERS";
   	wmove(topBar, 0, maxX/2-strlen(title_reg)/2);
	wprintw(topBar, "%s", title_reg);
	wattr_off(topBar, COLOR_PAIR(PAIR_TITLES), NULL);
	
	// Background dos registradores
	wattr_on(topBar, COLOR_PAIR(PAIR_REGISTERS), NULL);
	for(int i=0; i<maxX; i++)
	{
   		wmove(topBar, 1, i);
		wprintw(topBar, " ");
   		wmove(topBar, 2, i);
		wprintw(topBar, " ");
	}
	wattr_off(topBar, COLOR_PAIR(PAIR_REGISTERS), NULL);

	wrefresh(topBar);
}

void curses_draw_top_bar_window(estado_da_maquina_curses estado) 
{
	int maxX, maxY;
	getmaxyx(topBar,maxY,maxX);

	// Top Bar Registers
	int qtyReg = 8;
	int sizeTextReg = 10;
	int posX, posY;
	int regPerLine = maxX/sizeTextReg;
	
	// Imprime registradores
	wattr_on(topBar, COLOR_PAIR(PAIR_REGISTERS), NULL);
	for(int i=0; i<qtyReg; i++){
		posX = i%regPerLine*sizeTextReg;
		posY = i/regPerLine+1;
		// Limpa valor antigo
		mvwprintw(topBar, posY, posX, "          ", i, estado.reg[i]);
		// Imprime valor novo
		mvwprintw(topBar, posY, posX, "R%d:%d", i, estado.reg[i]);
	}
	wattr_off(topBar, COLOR_PAIR(PAIR_REGISTERS), NULL);
	wrefresh(topBar);
}

void curses_init_out_window()
{
	int maxX, maxY;
	getmaxyx(outWindow,maxY,maxX);

	// Background do titulo
	wattr_on(outWindow, COLOR_PAIR(PAIR_TITLES), NULL);
	for(int i=0; i<maxX; i++)
	{
   		wmove(outWindow, 0, i);
		wprintw(outWindow, " ");
	}
	wattr_off(outWindow, COLOR_PAIR(PAIR_TITLES), NULL);

	// Imprime titulo
	wattr_on(outWindow, COLOR_PAIR(PAIR_TITLES), NULL);
	char title_win[] = "WINDOW";
   	wmove(outWindow, 0, WINDOW_WIDTH/2-strlen(title_win)/2);
	wprintw(outWindow, "%s", title_win);
	wattr_off(outWindow, COLOR_PAIR(PAIR_TITLES), NULL);
	
	// Drawing window
	wattr_on(outWindow, COLOR_PAIR(SIM_PAIR_PRETO), NULL);
	for(int x=0; x<WINDOW_WIDTH; x++){
		for(int y=1; y<WINDOW_HEIGHT; y++){
			mvwprintw(outWindow, y, x, " ");
		}
	}
	wattr_off(outWindow, COLOR_PAIR(SIM_PAIR_PRETO), NULL);
	
	wrefresh(outWindow);
}

void curses_out_char(char c, int pos, int cor)
{
	// Impede que tente desenhar em posicao invalida
	if(pos>=WINDOW_WIDTH*WINDOW_HEIGHT || pos<0)
		return;

	int posX = pos%WINDOW_WIDTH;
	int posY = pos/WINDOW_WIDTH+1;

	wattr_on(outWindow, COLOR_PAIR(cor), NULL);
	mvwprintw(outWindow, posY, posX, "%c", c);
	wattr_off(outWindow, COLOR_PAIR(cor), NULL);
	wrefresh(outWindow);
}


void curses_init_code_window()
{
	int maxX, maxY;
	// Recebe tamanho da tela
	getmaxyx(codeWindow, maxY, maxX);

	// Background code
	wattr_on(codeWindow, COLOR_PAIR(PAIR_CODE), NULL);
	for(int j=1; j<maxY; j++)
	{
		for(int i=0; i<maxX; i++)
		{
			wmove(codeWindow, j, i);
			wprintw(codeWindow, " ");
		}
	}
	mvwprintw(codeWindow, 2, 0, "----------------------------------------------------------------------");
	wattr_off(codeWindow, COLOR_PAIR(PAIR_CODE), NULL);

	// Background do titulo
	wattr_on(codeWindow, COLOR_PAIR(PAIR_TITLES), NULL);
	for(int i=0; i<maxX; i++)
	{
   		wmove(codeWindow, 0, i);
		wprintw(codeWindow, " ");
	}
	wattr_off(codeWindow, COLOR_PAIR(PAIR_TITLES), NULL);

	// Imprime titulo da janela
	wattr_on(codeWindow, COLOR_PAIR(PAIR_TITLES), NULL);
	char title_code[] = "CODE";
   	wmove(codeWindow, 0, maxX/2-strlen(title_code)/2);
	wprintw(codeWindow, "%s", title_code);
	wattr_off(codeWindow, COLOR_PAIR(PAIR_TITLES), NULL);

	wrefresh(codeWindow);
}

void curses_draw_code_window(estado_da_maquina_curses estado)
{
	int maxX, maxY;
	// Recebe tamanho da tela
	getmaxyx(codeWindow, maxY, maxX);
	
	wattr_on(codeWindow, COLOR_PAIR(PAIR_CODE), NULL); 

	switch(estado.state)
	{
		case STATE_RESET:
			mvwprintw(codeWindow, 1, 0, "state: STATE_RESET          ");
			break;
		case STATE_FETCH:
			mvwprintw(codeWindow, 1, 0, "state: STATE_FETCH          ");
			break;
		case STATE_DECODE:
			mvwprintw(codeWindow, 1, 0, "state: STATE_DECODE          ");
			break;
		case STATE_EXECUTE:
			mvwprintw(codeWindow, 1, 0, "state: STATE_EXECUTE          ");
			break;
		case STATE_EXECUTE2:
			mvwprintw(codeWindow, 1, 0, "state: STATE_EXECUTE2          ");
			break;
		case STATE_HALTED:
			mvwprintw(codeWindow, 1, 0, "state: STATE_HALTED          ");
			break;
	}

	for(int y=3; y<maxY; y++){
		int temp = 1;
		int curr_inst = pega_pedaco(estado.memoria[estado.PC], 15, 10); 
		if(curr_inst == STORE || curr_inst == LOAD || curr_inst == LOADIMED || curr_inst == JMP || curr_inst == CALL)
			temp = 2;
		show_program(codeWindow, y, estado);
		estado.PC+=temp;
	}
	wattr_off(codeWindow, COLOR_PAIR(PAIR_CODE), NULL);
	
	wrefresh(codeWindow);		
}

void show_program(WINDOW* codeWindow,int y, estado_da_maquina_curses estado) 
{
	// Codigo retirado do simulador do Simoes
    int x = 0;
	// Evita que o pc aponte para um lugar que nao esta na memoria
	int pc = estado.PC;
	int SP = estado.SP;


	if(pc >= TAMANHO_MEMORIA) return;
	int rx = pega_pedaco(estado.memoria[pc],9,7);
    int ry = pega_pedaco(estado.memoria[pc],6,4);
    int rz = pega_pedaco(estado.memoria[pc],3,1);

	// Limpa a linha
    mvwprintw(codeWindow,y,x, "                                                                         ");

	// Recebe o IR da memoria
	int ir = estado.memoria[pc];
    switch(pega_pedaco(ir,15,10)){
        case INCHAR:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  INCHAR R%d            |   R%d <- TECLADO ", pc, rx, rx);
            break;

        case OUTCHAR:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  OUTCHAR R%d, R%d       |   VIDEO[R%d] <- CHAR[R%d] ", pc, rx, ry, rx, ry);
            break;

        case MOV:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  MOV R%d, R%d           |   R%d <- R%d ", pc, rx, ry, rx, ry);
            break;

        case STORE:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  STORE %05d, R%d      |   MEM[%d] <- R%d ", pc, estado.memoria[pc+1], rx, estado.memoria[pc+1], rx);
            break;

        case STOREINDEX:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  STOREI R%d, R%d        |   MEM[R%d] <- R%d ", pc, rx, ry, rx, ry);
            break;

        case LOAD:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  LOAD R%d, %05d       |   R%d <- MEM[%d] ", pc, rx, estado.memoria[pc+1], rx, estado.memoria[pc+1]);
            break;

        case LOADIMED:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  LOADN R%d, #%05d     |   R%d <- #%d ", pc, rx, estado.memoria[pc+1], rx, estado.memoria[pc+1]);
            break;

        case LOADINDEX:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  LOADI R%d, R%d         |   R%d <- MEM[R%d] ", pc, rx, ry, rx, ry);
            break;

        case LAND:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  AND R%d, R%d, R%d       |   R%d <- R%d and R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case LOR:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  OR R%d, R%d, R%d        |   R%d <- R%d or R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case LXOR:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  XOR R%d, R%d, R%d       |   R%d <- R%d xor R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case LNOT:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  NOT R%d, R%d           |   R%d <- R%d ", pc, rx, ry, rx, ry);
            break;

        case CMP:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  CMP R%d, R%d           |   FR <- <equal|lesser|greater> ", pc, rx, ry);
            break;

        case JMP:
            if(pega_pedaco(ir,9,6) == 0) // NO COND
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JMP #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==7)) // GREATER
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JGR #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==9)) // GREATER EQUAL
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JEG #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==8)) // LESSER
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JLE #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==10)) // LESSER EQUAL
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JEL #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==1)) // EQUAL
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JEQ #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==2)) // NOT EQUAL
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JNE #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==3)) // ZERO
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JZ #%05d            |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==4)) // NOT ZERO
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JNZ #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==5)) // CARRY
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JC #%05d            |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==6)) // NOT CARRY
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JNC #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==11)) // OVERFLOW
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JOV #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==12)) // NOT OVERFLOW
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JNO #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==14)) // NEGATIVO
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JN #%05d            |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==13)) // DIVBYZERO
                mvwprintw(codeWindow,y,x, "PC: %05d  |  JDZ #%05d           |   PC <- #%05d ", pc, estado.memoria[pc+1], estado.memoria[pc+1]);

            break;

        case PUSH:
            if(pega_pedaco(ir,6,6)==0) { // Registrador
                mvwprintw(codeWindow,y,x, "PC: %05d  |  PUSH R%d              |   MEM[%d] <- R%d] ", pc, rx, SP, rx);
                }
            else {                      // FR
                mvwprintw(codeWindow,y,x, "PC: %05d  |  PUSH FR              |   MEM[%d] <- FR] ", pc, SP);
                }
            break;

        case POP:
            if(pega_pedaco(ir,6,6)==0) { // Registrador
                mvwprintw(codeWindow,y,x, "PC: %05d  |  POP R%d               |   R%d <- MEM[%d] ", pc, rx, rx, SP);
                }
            else {                      // FR
                mvwprintw(codeWindow,y,x, "PC: %05d  |  POP FR               |   FR <- MEM[%d] ", pc, SP);
                }
            break;

        case CALL:
            if(pega_pedaco(ir,9,6) == 0) // NO COND
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CALL #%05d          |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==7)) // GREATER
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CGR #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==9)) // GREATER EQUAL
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CEG #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==8)) // LESSER
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CLE #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==10)) // LESSER EQUAL
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CEL #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==1)) // EQUAL
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CEQ #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==2)) // NOT EQUAL
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CNE #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==3)) // ZERO
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CZ #%05d            |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==4)) // NOT ZERO
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CNZ #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==5)) // CARRY
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CC #%05d            |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==6)) // NOT CARRY
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CNC #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==11)) // OVERFLOW
                mvwprintw(codeWindow,y,x, "PC: %05d  |  COV #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==12)) // NOT OVERFLOW
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CNO #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==14)) // NEGATIVO
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CN #%05d            |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);
            if((pega_pedaco(ir,9,6)==13)) // DIVBYZERO
                mvwprintw(codeWindow,y,x, "PC: %05d  |  CDZ #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, estado.memoria[pc+1], SP, estado.memoria[pc+1]);

            break;

        case RTS:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  RTS                  |   SP++; PC <- MEM[%d]; PC++ ", pc, SP);
            break;

        case ADD:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  ADD R%d, R%d, R%d       |   R%d <- R%d + R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case SUB:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  SUB R%d, R%d, R%d       |   R%d <- R%d - R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case MULT:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  MULT R%d, R%d, R%d      |   R%d <- R%d * R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case DIV:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  DIV R%d, R%d, R%d       |   R%d <- R%d / R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case LMOD:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  MOD R%d, R%d, R%d       |   R%d <- R%d % R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case INC:
            if(pega_pedaco(ir,6,6)==0) { // Inc Rx
                mvwprintw(codeWindow,y,x, "PC: %05d  |  INC R%d               |   R%d <- R%d + 1 ", pc, rx, rx, rx);
                }
            else  {                      // Dec Rx
                mvwprintw(codeWindow,y,x, "PC: %05d  |  DEC R%d               |   R%d <- R%d - 1 ", pc, rx, rx, rx);
                }
            break;

        case SHIFT:
            if(pega_pedaco(ir,6,4)==0) // SHIFT LEFT 0
                mvwprintw(codeWindow,y,x, "PC: %05d  |  SHIFTL0 R%d, #%02d      |   R%d <-'0'  << %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,4)==1) // SHIFT LEFT 1
                mvwprintw(codeWindow,y,x, "PC: %05d  |  SHIFTL1 R%d, #%02d      |   R%d <-'1'  << %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,4)==2) // SHIFT RIGHT 0
                mvwprintw(codeWindow,y,x, "PC: %05d  |  SHIFTR0 R%d, #%02d      |   '0'-> R%d   >> %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,4)==3) // SHIFT RIGHT 1
                mvwprintw(codeWindow,y,x, "PC: %05d  |  SHIFTR1 R%d, #%02d      |   '1'-> R%d   >> %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,5)==2) // ROTATE LEFT
                mvwprintw(codeWindow,y,x, "PC: %05d  |  ROTL R%d, #%02d         |   R%d <- R%d   << %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,5)==3) // ROTATE RIGHT
                mvwprintw(codeWindow,y,x, "PC: %05d  |  ROTR R%d, #%02d         |   R%d -> R%d   >> %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));

            break;

        case SETC:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  SETC                 |   C <- %d ", pc, pega_pedaco(ir,9,9));
            break;

        case HALT:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  HALT                 |   Pausa a execussao", pc);
            break;

        case NOP:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  NOOP                 |   Do nothing ", pc);
            break;

        case BREAKP:
            mvwprintw(codeWindow,y,x, "PC: %05d  |  BREAKP #%05d        |   Break Point ", pc, pega_pedaco(ir,9,0));
            break;
    }
}
