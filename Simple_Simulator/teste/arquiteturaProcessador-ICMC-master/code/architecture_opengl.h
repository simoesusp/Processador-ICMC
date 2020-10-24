//---------------------------------------------------
// Architecture OpenGL
// By: Breno Cunha Queiroz and Maria Eduarda Kawakami
// Date: 11/06/20
//---------------------------------------------------
#ifndef ARCHITECTURE_OPENGL_H
#define ARCHITECTURE_OPENGL_H

#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <stdlib.h>
#include <stdio.h>

#define WINDOW_OPENGL_WIDTH 500
#define WINDOW_OPENGL_HEIGHT 500

void openGL_create_window();
void openGL_update();
void openGL_draw();
void openGL_destroy_window();

// Funcoes para desenhar componentes
void openGL_draw_registers();
void openGL_draw_muxs();
void openGL_draw_memory();
void openGL_draw_keyboard();
void openGL_draw_video();
void openGL_draw_ula();

// Funcoes para desenhar os caminhos
void openGL_draw_registers_paths();
void openGL_draw_memory_paths();
void openGL_draw_keyboard_path();
void openGL_draw_mux_paths();
void openGL_draw_ula_paths();

// Funcoes auxiliares
void openGL_draw_line(float x0, float y0, float x1, float y1);
void openGL_draw_rectangle(float x, float y, float width, float height);
void openGL_draw_mux(float x, float y, float width, float height, char orientation);
void openGL_draw_path(float x0, float y0, float x1, float y1, char selected);
void openGL_draw_path_arrow(float x0, float y0, float x1, float y1, char selected);
void openGL_draw_dot_paths(float x, float y, char selected);

#endif// ARCHITECTURE_OPENGL_H
