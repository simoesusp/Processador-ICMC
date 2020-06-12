#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <curses.h>
#include <string.h>

//Window size
#define WIDTH 60
#define HEIGHT 50

//Curses colors
#define WIN_COLOR_BLACK 1
#define WIN_COLOR_WHITE 2
#define WIN_COLOR_RED 3
#define WIN_COLOR_BLUE 4
#define WIN_COLOR_GREEN 5

//Curses pairs
#define PAIR_BACKGROUND 1
#define PAIR_TITLES 2
#define PAIR_NUMBERS 3
#define PAIR_REGISTERS 4

void setup_curses();
void draw_window(WINDOW *win, int QTY_REG, int *reg);

int main(int argc, char *argv[]){
	//Variables
	char simulator_running = 1;
	int registers[] = {1, 10, 4, 30, 45, 20, 100, 193048};
	setup_curses();

	//Create simulator window
	int maxX=0, maxY=0;
	//Get window size
	getmaxyx(stdscr, maxY, maxX);
	//Create window
	WINDOW *win = newwin(HEIGHT, WIDTH, maxY/2-HEIGHT/2, maxX/2-WIDTH/2);
	refresh();
	while(simulator_running){
		draw_window(win, 8, registers);
		usleep(0.1*1000000);
		int key = getch();
		switch(key){
			case 'q':
				endwin();
				exit(0);
		}
	}
	endwin();
	return 0;
}

void setup_curses(){
	//--- Initialize window ---//
	initscr();
	noecho();
	curs_set(FALSE);

	if (has_colors() == FALSE) {
		endwin();
			printf("Your terminal does not support colors\n");
		exit(1);
	}
	start_color();
	
	//Create colors
	init_color(WIN_COLOR_BLACK, 100, 100, 100);
	init_color(WIN_COLOR_WHITE, 1000, 1000, 1000);
	init_color(WIN_COLOR_RED, 1000, 0, 0);
	init_color(WIN_COLOR_BLUE, 0, 0, 1000);
	init_color(WIN_COLOR_GREEN, 1000, 0, 0);
	
	// Create pairs
	init_pair(PAIR_BACKGROUND, WIN_COLOR_BLACK, WIN_COLOR_BLACK);
	init_pair(PAIR_NUMBERS, WIN_COLOR_WHITE, WIN_COLOR_BLACK);
	init_pair(PAIR_TITLES, WIN_COLOR_RED, WIN_COLOR_BLACK);
	init_pair(PAIR_REGISTERS, WIN_COLOR_BLUE, WIN_COLOR_BLACK);

	// Set background color
	bkgd(COLOR_PAIR(PAIR_BACKGROUND));
}

void draw_window(WINDOW *win, int QTY_REG, int *reg)
{
	int x, y, i;
	
	if(win==NULL) return;
	// Clear window
	
	wclear(win);
	
	// Top Bar Title "REGISTERS"
	wattr_on(win, COLOR_PAIR(PAIR_TITLES), NULL);
	char title_reg[] = "REGISTERS";
   	wmove(win, 0, WIDTH/2-strlen(title_reg)/2);
	wprintw(win, "%s", title_reg);
	wattr_off(win, COLOR_PAIR(PAIR_TITLES), NULL);
	
	// Top Bar Registers
	int sizeTextReg = 10;
	int regPerLine = WIDTH/sizeTextReg;
	int posX, posY;

	for(i=0; i<QTY_REG; i++){
		posX = i%regPerLine*sizeTextReg;
		posY = i/regPerLine+1;
		wattr_on(win, COLOR_PAIR(PAIR_REGISTERS), NULL);
		wmove(win, posY, posX);
		wprintw(win, "%d", reg[i]);
		wattr_off(win, COLOR_PAIR(PAIR_REGISTERS), NULL);
	}

	wattr_on(win, COLOR_PAIR(PAIR_TITLES), NULL);
	char title_win[] = "WINDOW";
   	wmove(win, posY+1, WIDTH/2-strlen(title_win)/2);
	wprintw(win, "%s", title_win);
	wattr_off(win, COLOR_PAIR(PAIR_TITLES), NULL);
	
	//Drawing window
	for(x=0; x<WIDTH; x++){
		for(y=posY+2; y<HEIGHT; y++){
			wattr_on(win, COLOR_PAIR(PAIR_NUMBERS), NULL);
			mvwprintw(win, y, x, " ");
		}
	}
	wrefresh(win);
}

