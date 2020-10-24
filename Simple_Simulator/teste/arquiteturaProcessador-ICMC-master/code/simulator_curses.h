//---------------------------------------------------
// Simulator Curses
// By: Breno Cunha Queiroz and Maria Eduarda Kawakami
// Date: 19/06/20
//---------------------------------------------------
#ifndef SIMULATOR_CURSES_H
#define SIMULATOR_CURSES_H

#include <curses.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "defines.h"

#define WINDOW_WIDTH 40
#define WINDOW_HEIGHT 30

// Struct para receber o estado atual da maquina
typedef struct _estado_da_maquina_curses{
	unsigned int memoria[TAMANHO_MEMORIA];
	int reg[8];
	int PC;
	int SP;
	int state;
} estado_da_maquina_curses;

// Inicializa o curses e cria as janelas
void curses_create_window();
void curses_destroy_window();
// Define cores e pares
void curses_setup();

// Chamar em loop para atualizar a tela do curses
void curses_update(estado_da_maquina_curses estado);

// Desenhar topBar
void curses_init_top_bar_window();
void curses_draw_top_bar_window(estado_da_maquina_curses estado);

// Desenhar janela do simulador
void curses_init_out_window();
// Imprime um caractere na tela
void curses_out_char(char c, int pos, int cor);

// Desenhar janela de codigo
void curses_init_code_window();
void curses_draw_code_window(estado_da_maquina_curses estado);
void show_program(WINDOW* codeWindow, int y, estado_da_maquina_curses estado);

#endif// SIMULATOR_CURSES_H
