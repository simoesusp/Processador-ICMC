#ifndef SIMULATOR_CURSES_H
#define SIMULATOR_CURSES_H

#include <curses.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define WINDOW_WIDTH 40
#define WINDOW_HEIGHT 30

// Inicializa o curses e cria as janelas
void curses_create_window();
void curses_destroy_window();
// Define cores e pares
void curses_setup();

// Chamar em loop para atualizar a tela do curses
void curses_update();

// Desenhar topBar
void curses_draw_top_bar();

// Desenhar janela do simulador
void curses_draw_window();
void curses_out_char(char c, int pos, int cor);


#endif// SIMULATOR_CURSES_H
