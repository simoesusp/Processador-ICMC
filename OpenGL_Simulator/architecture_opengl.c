#include "architecture_opengl.h"

GLFWwindow* window;

void openGL_create_window()
{
	// Checa se foi possivel inicializar o glfw (window manager)
	if(!glfwInit())
	{
		printf("[OpenGL] Falha ao inicializar o GLFW!\n");
		glfwTerminate();
		exit(1);
	}

	//----- Configuracao GLFW -----//
	glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

	//----- Cria janela -----//

	// Define tamanho e nome da janela
	window = glfwCreateWindow(WINDOW_OPENGL_WIDTH, WINDOW_OPENGL_HEIGHT, "Arquitetura", NULL, NULL);
	// Move a janela para a posicao (0,0) top-left
	glfwSetWindowPos(window, 0, 0);
	
	// Checa se nao foi possivel criar a janela
	if(window == NULL)
	{
		printf("[OpenGL] Falha ao criar a janela!\n");
		glfwTerminate();
		exit(1);
	}

	// Define que esta janela sera usada para desenhar
	glfwMakeContextCurrent(window);
}

void openGL_destroy_window()
{
	// Destroi a janela e termina o glfw
	glfwDestroyWindow(window);
    glfwTerminate();
}

void openGL_update()
{
	// Esta funcao atualiza o desenho na tela e checa se a janela foi fechada

	if(!glfwWindowShouldClose(window))
	{
		// Recebe se a janela foi fechada
		glfwPollEvents();
		// Limpa a tela com branco
		glClearColor(1.0, 1.0, 1.0, 1.0);
		// Limpa os dados do buffer (imagem em que vai desenhar)
		glClear(GL_COLOR_BUFFER_BIT);

		// Desenha os componentes e trilhas na janela
		openGL_draw();

		// Atualiza o que esta mostrando na janela
		// Troca a imagem que estava desenhando com a imagem que esta mostrando
		glfwSwapBuffers(window);
	}
	else
	{
		// Termina o programa se a janela foi fechada
    	glfwTerminate();
		exit(0);
	}
}

void openGL_draw()
{
	glColor3f(0, 0, 0);
	glLineWidth(2);
	
	openGL_draw_registers();
	openGL_draw_muxs();
	openGL_draw_memory();
	openGL_draw_keyboard();
	openGL_draw_video();
	openGL_draw_ula();

	glLineWidth(2);

	openGL_draw_registers_paths();
	openGL_draw_memory_paths();
	openGL_draw_keyboard_path();
	openGL_draw_mux_registers_paths();
	openGL_draw_ula_paths();
}

void openGL_draw_registers()
{
	float x = -0.4;
	float y = 0.8;
	float size = 0.1;
	float dist = 0.12;
	float qtyRegisters = 8;

	float totalWidth = (qtyRegisters-1)*dist;
	
	// Desenha os 8 registradores
	for(int r=0;r<qtyRegisters;r++)
	{
		openGL_draw_rectangle(x-totalWidth/2+dist*r, y, size, size);
	}
	
	// MAR
	openGL_draw_rectangle(0.35, -0.8, 0.18, 0.08);
	// PC
	openGL_draw_rectangle(0.6, -0.8, 0.18, 0.08);
	// SP
	openGL_draw_rectangle(0.85, -0.8, 0.18, 0.08);
	// FR
	openGL_draw_rectangle(0, 0.13, 0.18, 0.08);
	// IR
	openGL_draw_rectangle(0.2, 0.5, 0.18, 0.08);
}

void openGL_draw_muxs()
{
	// M1
	openGL_draw_mux(0.6, -0.6, 0.4, 0.07, 't');
	// M2
	openGL_draw_mux(-0.5, -0.5, 0.07, 0.25, 'l');
	// M3
	openGL_draw_mux(-0.55, 0.5, 0.25, 0.07, 'b');
	// M4
	openGL_draw_mux(-0.25, 0.5, 0.25, 0.07, 'b');
	// M5
	openGL_draw_mux(0.6, 0.7, 0.25, 0.07, 'b');
	// M6
	openGL_draw_mux(0, 0, 0.20, 0.06, 't');
}

void openGL_draw_memory()
{
	openGL_draw_rectangle(0.6, 0, 0.4, 0.8);
}

void openGL_draw_keyboard()
{
	openGL_draw_rectangle(-0.2, -0.6, 0.25, 0.08);
}

void openGL_draw_video()
{
	// Big box
	openGL_draw_rectangle(-0.8, 0, 0.2, 0.5);
	// Small boxes
	openGL_draw_rectangle(-0.8, 0, 0.15, 0.08);
	openGL_draw_rectangle(-0.8, 0.12, 0.15, 0.08);
}

void openGL_draw_ula()
{
	float x = -0.4;
	float y = 0.0;
	float height = 0.12;
	float width = 0.4;
	float smaller = 5;

	glBegin(GL_LINES);
	{
		glVertex2f(x-width/smaller, y-height/2);
		glVertex2f(x-width/2, y+height/2);

		glVertex2f(x-width/2, y+height/2);
		glVertex2f(x-width/smaller, y+height/2);

		glVertex2f(x-width/smaller, y+height/2);
		glVertex2f(x, y+height/8);

		glVertex2f(x, y+height/8);
		glVertex2f(x+width/smaller, y+height/2);

		glVertex2f(x+width/smaller, y+height/2);
		glVertex2f(x+width/2, y+height/2);

		glVertex2f(x+width/2, y+height/2);
		glVertex2f(x+width/smaller, y-height/2);

		glVertex2f(x+width/smaller, y-height/2);
		glVertex2f(x-width/smaller, y-height/2);
	}
	glEnd();
}

void openGL_draw_registers_paths()
{
	float x = -0.4;
	float y = 0.8;
	float size = 0.1;
	float dist = 0.12;
	float qtyRegisters = 8;

	float totalWidth = (qtyRegisters-1)*dist;
	
	// Desenha os 8 registradores
	for(int r=0;r<qtyRegisters;r++)
	{
		// Registers to M3
		openGL_draw_path_arrow(x-totalWidth/2+dist*r, y-size/2, -0.55-(0.25/2)+(0.25/(qtyRegisters-1))*r, 0.535, 'n');
		// Registers to M4
		openGL_draw_path_arrow(x-totalWidth/2+dist*r, y-size/2, -0.25-(0.25/2)+(0.25/(qtyRegisters-1))*r, 0.535, 'n');
	}
}

void openGL_draw_memory_paths()
{
	// Desenha caminhos que saem da memoria
	
	// Conectado na saida da memoria
	openGL_draw_path(0.4, 0, 0.2, 0, 'n');
	// Vai para o IR
	openGL_draw_path_arrow(0.2, 0, 0.2, 0.46, 'n');
	
	// Desce ate o M6
	openGL_draw_path(0.2, 0, 0.2, -0.1, 'n');
	
	// Ate o M6
	openGL_draw_path(0.2, -0.1, 0, -0.1, 'n');
	openGL_draw_path_arrow(0, -0.1, 0, -0.03, 'n');

	// Desce do M6 ate M2
	openGL_draw_path(0.2, 0, 0.2, -0.53, 'n');

	// Ate a entrada do M2
	openGL_draw_path_arrow(0.2, -0.53, -0.465, -0.53, 'n');
	
	// M2 ate MAR/PC
	openGL_draw_path(0.2, -0.53, 0.2, -0.92, 'n');
	openGL_draw_path(0.2, -0.92, 0.35, -0.92, 'n');
	
	// Ate MAR
	openGL_draw_path_arrow(0.35, -0.92, 0.35, -0.84, 'n');
	
	// Ate PC
	openGL_draw_path(0.35, -0.92, 0.6, -0.92, 'n');
	openGL_draw_path_arrow(0.6, -0.92, 0.6, -0.84, 'n');
}

void openGL_draw_keyboard_path()
{
	openGL_draw_path_arrow(-0.325, -0.6, -0.465, -0.6, 'n');
}

void openGL_draw_mux_registers_paths()
{
	openGL_draw_path_arrow(-0.55, 0.465, -0.55, (0.12/2), 'n');
	openGL_draw_path_arrow(-0.25, 0.465, -0.25, (0.12/2), 'n');
}

void openGL_draw_ula_paths()
{
	// ULA to M2
	
	// ULA to M6
}

void openGL_draw_rectangle(float x, float y, float width, float height)
{
	glBegin(GL_LINES);
	{
		glVertex2f(x-width/2, y-height/2);
		glVertex2f(x-width/2, y+height/2);

		glVertex2f(x-width/2, y+height/2);
		glVertex2f(x+width/2, y+height/2);

		glVertex2f(x+width/2, y+height/2);
		glVertex2f(x+width/2, y-height/2);

		glVertex2f(x+width/2, y-height/2);
		glVertex2f(x-width/2, y-height/2);
	}
	glEnd();
}

void openGL_draw_mux(float x, float y, float width, float height, char orientation)
{
	float smaller = 2.5;
	if(orientation=='t')
	{
		glBegin(GL_LINES);
		{
			glVertex2f(x-width/2, y-height/2);
			glVertex2f(x-width/smaller, y+height/2);

			glVertex2f(x-width/smaller, y+height/2);
			glVertex2f(x+width/smaller, y+height/2);

			glVertex2f(x+width/smaller, y+height/2);
			glVertex2f(x+width/2, y-height/2);

			glVertex2f(x+width/2, y-height/2);
			glVertex2f(x-width/2, y-height/2);
		}
		glEnd();
	}
	else if(orientation=='b')
	{
		glBegin(GL_LINES);
		{
			glVertex2f(x-width/smaller, y-height/2);
			glVertex2f(x-width/2, y+height/2);

			glVertex2f(x-width/2, y+height/2);
			glVertex2f(x+width/2, y+height/2);

			glVertex2f(x+width/2, y+height/2);
			glVertex2f(x+width/smaller, y-height/2);

			glVertex2f(x+width/smaller, y-height/2);
			glVertex2f(x-width/smaller, y-height/2);
		}
		glEnd();
	}
	else if(orientation=='l')
	{
		glBegin(GL_LINES);
		{
			glVertex2f(x-width/2, y-height/smaller);
			glVertex2f(x-width/2, y+height/smaller);

			glVertex2f(x-width/2, y+height/smaller);
			glVertex2f(x+width/2, y+height/2);

			glVertex2f(x+width/2, y+height/2);
			glVertex2f(x+width/2, y-height/2);

			glVertex2f(x+width/2, y-height/2);
			glVertex2f(x-width/2, y-height/smaller);
		}
		glEnd();
	}
	else if(orientation=='r')
	{
		glBegin(GL_LINES);
		{
			glVertex2f(x-width/2, y-height/2);
			glVertex2f(x-width/2, y+height/2);

			glVertex2f(x-width/2, y+height/2);
			glVertex2f(x+width/2, y+height/smaller);

			glVertex2f(x+width/2, y+height/smaller);
			glVertex2f(x+width/2, y-height/smaller);

			glVertex2f(x+width/2, y-height/smaller);
			glVertex2f(x-width/2, y-height/2);
		}
		glEnd();
	}
}

void openGL_draw_path(float x0, float y0, float x1, float y1, char selected)
{
	if(selected == 'y')
		glColor3f(0, 0, 1);
	else
		glColor3f(0, 0, 0);

	glBegin(GL_LINES);
	{
		glVertex2f(x0, y0);
		glVertex2f(x1, y1);
	}
	glEnd();
}

void openGL_draw_path_arrow(float x0, float y0, float x1, float y1, char selected)
{
	if(selected == 'y')
		glColor3f(0, 0, 1);
	else
		glColor3f(0, 0, 0);

	glBegin(GL_LINES);
	{
		glVertex2f(x0, y0);
		glVertex2f(x1, y1);
		// TODO: draw arrow
	}
	glEnd();
}
