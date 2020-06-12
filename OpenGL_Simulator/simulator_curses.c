#include "simulator_curses.h"

//Curses colors
#define WIN_COLOR_BLACK 1
#define WIN_COLOR_WHITE 2
#define WIN_COLOR_RED 3
#define WIN_COLOR_BLUE 4
#define WIN_COLOR_GREEN 5
#define WIN_COLOR_GRAY 6

//Curses pairs
#define PAIR_BACKGROUND 1
#define PAIR_TITLES 2
#define PAIR_NUMBERS 3
#define PAIR_REGISTERS 4

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
	outWindow = newwin(WINDOW_HEIGHT, WINDOW_WIDTH, 3, 0);

	if(topBar == NULL || outWindow == NULL)
	{
		printf("[Curses] Nao foi possivel criar as janelas.\n");
		exit(1);
	}
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
	curs_set(FALSE);

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
	
	// Cria pares com as cores
	init_pair(PAIR_BACKGROUND, WIN_COLOR_BLACK, WIN_COLOR_BLACK);
	init_pair(PAIR_NUMBERS, WIN_COLOR_WHITE, WIN_COLOR_BLACK);
	init_pair(PAIR_TITLES, WIN_COLOR_GREEN, WIN_COLOR_GRAY);
	init_pair(PAIR_REGISTERS, WIN_COLOR_BLUE, WIN_COLOR_BLACK);

	// Set background color
	bkgd(COLOR_PAIR(PAIR_BACKGROUND));
}

void curses_update()
{
	curses_draw_top_bar();
	curses_draw_window();
}

void curses_draw_top_bar() {
	int maxX, maxY;
	getmaxyx(topBar,maxY,maxX);
	wclear(topBar);

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
	//int reg[] = {1, 10, 4, 30, 45, 20, 100, 64000};
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
//	wattr_on(win, COLOR_PAIR(PAIR_TITLES), NULL);
//	char title_win[] = "WINDOW";
//   	wmove(win, posY+1, WIDTH/2-strlen(title_win)/2);
//	wprintw(win, "%s", title_win);
//	wattr_off(win, COLOR_PAIR(PAIR_TITLES), NULL);
//	
//	//Drawing window
//	for(x=0; x<WIDTH; x++){
//		for(y=posY+2; y<HEIGHT; y++){
//			wattr_on(win, COLOR_PAIR(PAIR_NUMBERS), NULL);
//			mvwprintw(win, y, x, " ");
//		}
//	}
}
