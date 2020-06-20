#include "simulator_curses.h"

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

// Barra onde mostra os registradores
WINDOW* topBar;
// Tela de saida dos caracteres da simulacao
WINDOW* outWindow;

extern int reg[8]; // 8 registradores

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
	// Cria janela de output
	outWindow = newwin(WINDOW_HEIGHT+1, WINDOW_WIDTH, 3, 0);

	if(topBar == NULL || outWindow == NULL)
	{
		printf("[Curses] Nao foi possivel criar as janelas.\n");
		exit(1);
	}

	// Limpa a tela para comecar a desenhar
	curses_draw_window();
	refresh();
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
	resize_term(42, 125);
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
	init_color(SIM_COLOR_AMARELO, 1000, 1000, 1000);
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

void curses_update()
{
	//curses_draw_top_bar();
	//nodelay(stdscr, TRUE);
}

void curses_draw_top_bar() {
	int maxX, maxY;
	getmaxyx(topBar,maxY,maxX);
	//wclear(topBar);

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
	
	// Top Bar Registers
	int qtyReg = 8;
	int sizeTextReg = 10;
	int posX, posY;
	int regPerLine = maxX/sizeTextReg;
	
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

	// Desenha registradores
	for(int i=0; i<qtyReg; i++){
		posX = i%regPerLine*sizeTextReg;
		posY = i/regPerLine+1;
		wattr_on(topBar, COLOR_PAIR(PAIR_REGISTERS), NULL);
		wmove(topBar, posY, posX);
		wprintw(topBar, "R%d:%d", i, reg[i]);
		wattr_off(topBar, COLOR_PAIR(PAIR_REGISTERS), NULL);
	}
	wrefresh(topBar);
}

void curses_draw_window()
{
	int maxX, maxY;
	getmaxyx(outWindow,maxY,maxX);

	wattr_on(outWindow, COLOR_PAIR(PAIR_TITLES), NULL);
	char title_win[] = "WINDOW";
   	wmove(outWindow, 0, WINDOW_WIDTH/2-strlen(title_win)/2);
	wprintw(outWindow, "%s", title_win);
	wattr_off(outWindow, COLOR_PAIR(PAIR_TITLES), NULL);
	
	//Drawing window
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

	wattr_on(outWindow, COLOR_PAIR(0), NULL);
	mvwprintw(outWindow, posY, posX, "%c", c);
	wattr_off(outWindow, COLOR_PAIR(0), NULL);

	wrefresh(outWindow);

	//wattr_on(outWindow, COLOR_PAIR(0), NULL);
	//mvprintw(posY+30, posX, "%c", c);
	//wattr_off(outWindow, COLOR_PAIR(0), NULL);
	//wrefresh(stdscr);
}
