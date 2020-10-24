//---------------------------------------------------
// Architecture OpenGL
// By: Breno Cunha Queiroz and Maria Eduarda Kawakami
// Date: 11/06/20
//---------------------------------------------------

#include "architecture_opengl.h"
#include <math.h>

GLFWwindow* window;

// Selecao do Mux1
#define sPC 0
#define sMAR 1
#define sM4 2
#define sSP 3

// Selecao do Mux2
#define sULA 0
#define sDATA_OUT 1
//#define sM4 2
//#define sSP 3
#define sTECLADO 4

// Selecao do Mux3 --> E´ so´ colocar: 0, 1, 2 ... 7  para selecionar os Registradores

// Selecao do Mux4 --> E´ so´ colocar: 0, 1, 2 ... 7  para selecionar os Registradores ou 8 para entrar o nr. 1

// Selecao do Mux5
//#define sPC 0
#define sM3 1

// Selecao do Mux6
//#define sULA 0
//#define sDATA_OUT 1
//
extern int LoadPC, IncPC, LoadIR, LoadSP, IncSP, DecSP, LoadMAR, LoadFR;
extern int selM1, selM2, selM3, selM4, selM5, selM6;
extern int RW;
extern int LoadReg[8];
extern int Video;

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
	openGL_draw_mux_paths();
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
	
	// 1
	openGL_draw_line(0.0, 0.6, 0.0, 0.65);
	openGL_draw_line(0.0, 0.65, -0.02, 0.63);
	
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
	openGL_draw_rectangle(-0.8, 0.15, 0.2, 0.45);
	// Small boxes
	openGL_draw_rectangle(-0.8, 0.15, 0.15, 0.08);
	openGL_draw_rectangle(-0.8, 0.27, 0.15, 0.08);
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
		if(selM3 == r)
			openGL_draw_path_arrow(x-totalWidth/2+dist*r, y-size/2, -0.55-(0.25/2)+(0.25/(qtyRegisters-1))*r, 0.535, 'y');
		else
			openGL_draw_path_arrow(x-totalWidth/2+dist*r, y-size/2, -0.55-(0.25/2)+(0.25/(qtyRegisters-1))*r, 0.535, 'n');
		
		// Registers to M4
		if(selM4 == r)
			openGL_draw_path_arrow(x-totalWidth/2+dist*r, y-size/2, -0.25-(0.25/2)+(0.25/(qtyRegisters-1))*r, 0.535, 'y');
		else
			openGL_draw_path_arrow(x-totalWidth/2+dist*r, y-size/2, -0.25-(0.25/2)+(0.25/(qtyRegisters-1))*r, 0.535, 'n');
	}
	// 1
	if(selM4 == 8)
		openGL_draw_path_arrow(-0.02, 0.58, -0.25-(0.25/2)+0.25, 0.535, 'y');
	else
		openGL_draw_path_arrow(-0.02, 0.58, -0.25-(0.25/2)+0.25, 0.535, 'n');
	
	// MAR to M1
	if(selM1 == sMAR)
		openGL_draw_path_arrow(0.4, -0.76, 0.5, -0.635, 'y');
	else
		openGL_draw_path_arrow(0.4, -0.76, 0.5, -0.635, 'n');

  	// PC to M1
	if(selM1 == sPC || selM5 == sPC)
	{
		openGL_draw_dot_paths(0.6, -0.7, 'y');
		openGL_draw_path(0.6, -0.76, 0.6, -0.7, 'y');	
	}
	else
	{
		openGL_draw_dot_paths(0.6, -0.7, 'n');
		openGL_draw_path(0.6, -0.76, 0.6, -0.7, 'n');	
	}

	if(selM1 == sPC)
		openGL_draw_path_arrow(0.6, -0.7, 0.6, -0.635, 'y');	
	else
		openGL_draw_path_arrow(0.6, -0.7, 0.6, -0.635, 'n');	

	// SP to M1
	if(selM1 == sSP)
		openGL_draw_path_arrow(0.85, -0.76, 0.7, -0.635, 'y');
	else
		openGL_draw_path_arrow(0.85, -0.76, 0.7, -0.635, 'n');

	// FR to IR
	// TODO
	openGL_draw_path(0.0, 0.17, 0.0, 0.5, 'n');
	openGL_draw_path_arrow(0.0, 0.5, 0.11, 0.5, 'n');

	if(selM3 == 8)
		openGL_draw_path(-0.05, 0.17, -0.05, 0.2, 'y');
	else
		openGL_draw_path(-0.05, 0.17, -0.05, 0.2, 'n');
	
	// FR to M3
	if(selM3 == 8)
	{
		openGL_draw_path(-0.05, 0.2, -0.05, 0.4, 'y');
		openGL_draw_path(-0.05, 0.4, -0.75, 0.4, 'y');
		openGL_draw_path(-0.75, 0.4, -0.75, 0.535, 'y');
		openGL_draw_path_arrow(-0.75, 0.535, -0.55-0.125, 0.535, 'y');
	}
	else
	{
		openGL_draw_path(-0.05, 0.2, -0.05, 0.4, 'n');
		openGL_draw_path(-0.05, 0.4, -0.75, 0.4, 'n');
		openGL_draw_path(-0.75, 0.4, -0.75, 0.535, 'n');
		openGL_draw_path_arrow(-0.75, 0.535, -0.55-0.125, 0.535, 'n');
	}

	// FR to ULA
	// TODO
	openGL_draw_dot_paths(-0.05, 0.2, 'n');
	openGL_draw_path(-0.05, 0.2, -0.18, 0.2, 'n');
	openGL_draw_path(-0.18, 0.2, -0.18, 0, 'n');
	openGL_draw_path_arrow(-0.18, 0, -0.26, 0, 'n');

	// PC to M5
	if(selM5 == sPC)
	{
		openGL_draw_path(0.6, -0.7, 0.97, -0.7, 'y');
		openGL_draw_path(0.97, -0.7, 0.97, 0.85, 'y');
		openGL_draw_path(0.97, 0.85, 0.65, 0.85, 'y');
		openGL_draw_path_arrow(0.65, 0.85, 0.65, 0.735, 'y');
	}
	else
	{
		openGL_draw_path(0.6, -0.7, 0.97, -0.7, 'n');
		openGL_draw_path(0.97, -0.7, 0.97, 0.85, 'n');
		openGL_draw_path(0.97, 0.85, 0.65, 0.85, 'n');
		openGL_draw_path_arrow(0.65, 0.85, 0.65, 0.735, 'n');
	}

	// SP to M2
	if(selM2 == sSP)
	{
		openGL_draw_path(0.75, -0.67, 0.87, -0.67, 'y');
		openGL_draw_dot_paths(0.75, -0.67, 'y');
		openGL_draw_path(0.87, -0.67, 0.87, -0.5,'y');
		openGL_draw_path_arrow(0.87, -0.5, -0.465, -0.5, 'y');
	}
	else
	{
		openGL_draw_path(0.75, -0.67, 0.87, -0.67, 'n');
		openGL_draw_dot_paths(0.75, -0.67, 'n');
		openGL_draw_path(0.87, -0.67, 0.87, -0.5,'n');
		openGL_draw_path_arrow(0.87, -0.5, -0.465, -0.5, 'n');
	}

}

void openGL_draw_memory_paths()
{
	// Desenha caminhos que saem da memoria
	
	// Conectado na saida da memoria
	if(LoadIR || LoadPC || LoadMAR || selM6 == sDATA_OUT || selM2 == sDATA_OUT)
		openGL_draw_path(0.4, 0, 0.2, 0, 'y');
	else
		openGL_draw_path(0.4, 0, 0.2, 0, 'n');

	// Vai para o IR
	if(LoadIR)
		openGL_draw_path_arrow(0.2, 0, 0.2, 0.46, 'y');
	else
		openGL_draw_path_arrow(0.2, 0, 0.2, 0.46, 'n');
	
	// Desce ate o M6
	if(LoadPC || LoadMAR || selM6 == sDATA_OUT || selM2 == sDATA_OUT)
	{
		openGL_draw_path(0.2, 0, 0.2, -0.1, 'y');
		openGL_draw_dot_paths(0.2, 0, 'y');
	}
	else
	{
		openGL_draw_path(0.2, 0, 0.2, -0.1, 'n');
		openGL_draw_dot_paths(0.2, 0, 'n');
	}
	
	// Ate o M6
	if(selM6 == sDATA_OUT)
	{
		openGL_draw_dot_paths(0.2, -0.1, 'y');
		openGL_draw_path(0.2, -0.1, 0, -0.1, 'y');
		openGL_draw_path_arrow(0, -0.1, 0, -0.03, 'y');
		openGL_draw_dot_paths(0.2, -0.53, 'y');
	}
	else
	{
		openGL_draw_dot_paths(0.2, -0.1, 'n');
		openGL_draw_path(0.2, -0.1, 0, -0.1, 'n');
		openGL_draw_path_arrow(0, -0.1, 0, -0.03, 'n');
	}

	// Desce do M6 ate M2
	if(LoadPC || LoadMAR || selM2 == sDATA_OUT)
	{
		openGL_draw_path(0.2, 0, 0.2, -0.53, 'y');
		openGL_draw_dot_paths(0.2, -0.53, 'y');
	}
	else
	{
		openGL_draw_path(0.2, 0, 0.2, -0.53, 'n');
		openGL_draw_dot_paths(0.2, -0.53, 'n');
	}

	// Ate a entrada do M2
	if(selM2 == sDATA_OUT)
		openGL_draw_path_arrow(0.2, -0.53, -0.465, -0.53, 'y');
	else
		openGL_draw_path_arrow(0.2, -0.53, -0.465, -0.53, 'n');
	
	// M2 ate MAR/PC
	if(LoadPC || LoadMAR)
	{
		openGL_draw_path(0.2, -0.53, 0.2, -0.92, 'y');
		openGL_draw_path(0.2, -0.92, 0.35, -0.92, 'y');
	}
	else
	{
		openGL_draw_path(0.2, -0.53, 0.2, -0.92, 'n');
		openGL_draw_path(0.2, -0.92, 0.35, -0.92, 'n');
	}
	
	// Ate MAR
	if(LoadMAR)
	{
		openGL_draw_path_arrow(0.35, -0.92, 0.35, -0.84, 'y');
		openGL_draw_dot_paths(0.35, -0.92, 'y');
	}
	else
	{
		openGL_draw_path_arrow(0.35, -0.92, 0.35, -0.84, 'n');
		openGL_draw_dot_paths(0.35, -0.92, 'n');
	}
		
	// Ate PC
	if(LoadPC)
	{
		openGL_draw_path(0.35, -0.92, 0.6, -0.92, 'y');
		openGL_draw_path_arrow(0.6, -0.92, 0.6, -0.84, 'y');
	}
	else
	{
		openGL_draw_path(0.35, -0.92, 0.6, -0.92, 'n');
		openGL_draw_path_arrow(0.6, -0.92, 0.6, -0.84, 'n');
	}
}

void openGL_draw_keyboard_path()
{
	openGL_draw_path_arrow(-0.325, -0.6, -0.465, -0.6, 'n');
}

void openGL_draw_mux_paths()
{
	//M3 to ULA
	openGL_draw_path_arrow(-0.55, 0.465, -0.55, (0.12/2), 'y');

	//M4 to ULA
	openGL_draw_path_arrow(-0.25, 0.465, -0.25, (0.12/2), 'y');

	//M4 to Video(X)
	if(Video)
		openGL_draw_path_arrow(-0.25, 0.15, -0.725, 0.15, 'y');
	else
		openGL_draw_path_arrow(-0.25, 0.15, -0.725, 0.15, 'n');
	openGL_draw_dot_paths(-0.25, 0.15, 'y');

	//M4 to M2
	if(selM2 == sM4 || selM1 == sM4 || LoadSP)
	{
		openGL_draw_path(-0.25, 0.15, -0.15, 0.15, 'y');
		openGL_draw_path(-0.15, 0.15, -0.15, -0.47, 'y');
	}
	else
	{
		openGL_draw_path(-0.25, 0.15, -0.15, 0.15, 'n');
		openGL_draw_path(-0.15, 0.15, -0.15, -0.47, 'n');
	}

	if(selM2 == sM4)
		openGL_draw_path_arrow(-0.15, -0.47, -0.465, -0.47, 'y');
	else
		openGL_draw_path_arrow(-0.15, -0.47, -0.465, -0.47, 'n');

	if(selM1 == sM4 || LoadSP)
	{
		openGL_draw_dot_paths(-0.15, -0.47, 'y');
		openGL_draw_path(-0.15, -0.47, 0.23, -0.47, 'y');
		openGL_draw_path(0.23, -0.47, 0.23, -0.7, 'y');
		openGL_draw_dot_paths(0.23, -0.7, 'y');
	}
	else
	{
		openGL_draw_dot_paths(-0.15, -0.47, 'n');
		openGL_draw_path(-0.15, -0.47, 0.23, -0.47, 'n');
		openGL_draw_path(0.23, -0.47, 0.23, -0.7, 'n');
		openGL_draw_dot_paths(0.23, -0.7, 'n');
	}

	//M4 to M1
	if(selM1 == sM4)
	{
		openGL_draw_path(0.23, -0.7, 0.43, -0.7, 'y');
		openGL_draw_path_arrow(0.43, -0.7, 0.43, -0.635, 'y');
	}
	else
	{
		openGL_draw_path(0.23, -0.7, 0.43, -0.7, 'n');
		openGL_draw_path_arrow(0.43, -0.7, 0.43, -0.635, 'n');
	}

	//M4 to SP
	if(LoadSP)
	{
		openGL_draw_path(0.23, -0.7, 0.23, -0.97, 'y');
		openGL_draw_path(0.23, -0.97, 0.85, -0.97, 'y');
		openGL_draw_path_arrow(0.85, -0.97, 0.85, -0.84, 'y');
	}
	else
	{
		openGL_draw_path(0.23, -0.7, 0.23, -0.97, 'n');
		openGL_draw_path(0.23, -0.97, 0.85, -0.97, 'n');
		openGL_draw_path_arrow(0.85, -0.97, 0.85, -0.84, 'n');
	}

	//M1 to Memoria
	if(RW)
		openGL_draw_path_arrow(0.6, -0.565, 0.6, -0.4, 'y'); 	
	else
		openGL_draw_path_arrow(0.6, -0.565, 0.6, -0.4, 'n'); 	

	//M5 to Memoria
	if(RW)
		openGL_draw_path_arrow(0.6, 0.665, 0.6, 0.4, 'y');
	else
		openGL_draw_path_arrow(0.6, 0.665, 0.6, 0.4, 'n');

	// M6 to FR
	if(LoadFR)
		openGL_draw_path(0, 0.03, 0.0, 0.09, 'y');
	else
		openGL_draw_path(0, 0.03, 0.0, 0.09, 'n');

	// M3 to Video(char)
	if(Video)
		openGL_draw_path_arrow(-0.55, 0.27, -0.725, 0.27, 'y');
	else
		openGL_draw_path_arrow(-0.55, 0.27, -0.725, 0.27, 'n');

	openGL_draw_dot_paths(-0.55, 0.27, 'y');
	
	// M2 to registers
	int loadRegister = -1;
	for(int i=0;i<8;i++)
		if(LoadReg[i]) loadRegister = i;
	
	if(loadRegister>=0)
	{
		openGL_draw_path(-0.535, -0.5, -0.93, -0.5, 'y');
		openGL_draw_path(-0.93, -0.5, -0.93, 0.90, 'y');
		openGL_draw_path(-0.93, 0.90, -0.82, 0.9, 'y');
	}
	else
	{
		openGL_draw_path(-0.535, -0.5, -0.93, -0.5, 'n');
		openGL_draw_path(-0.93, -0.5, -0.93, 0.90, 'n');
		openGL_draw_path(-0.93, 0.90, -0.82, 0.9, 'n');
	}

	float x = -0.4;
	float y = 0.8;
	float size = 0.1;
	float dist = 0.12;
	float qtyRegisters = 8;
	float totalWidth = (qtyRegisters-1)*dist;
	// Desenha caminhos para os 8 registros
	for(int r=0;r<qtyRegisters;r++)
	{
		if(r>0)
			if(r<=loadRegister)
				openGL_draw_path(x-totalWidth/2+dist*(r-1), 0.90, x-totalWidth/2+dist*r, 0.9, 'y');
			else
				openGL_draw_path(x-totalWidth/2+dist*(r-1), 0.90, x-totalWidth/2+dist*r, 0.9, 'n');

		if(r==loadRegister)
		{
			openGL_draw_path_arrow(x-totalWidth/2+dist*r, 0.90, x-totalWidth/2+dist*r, y+size/2, 'y');
			openGL_draw_dot_paths(x-totalWidth/2+dist*r, 0.90, 'y');
		}
		else
		{
			openGL_draw_path_arrow(x-totalWidth/2+dist*r, 0.90, x-totalWidth/2+dist*r, y+size/2, 'n');
			openGL_draw_dot_paths(x-totalWidth/2+dist*r, 0.90, 'n');
		}
	}
	
	// M3 to M5
	if(selM5 == sM3)
	{
		openGL_draw_dot_paths(-0.55, 0.43, 'y');
		openGL_draw_path(-0.55, 0.43, -0.97, 0.43, 'y');
		openGL_draw_path(-0.97, 0.43, -0.97, 0.95, 'y');
		openGL_draw_path(-0.97, 0.95, 0.55, 0.95, 'y');
		openGL_draw_path_arrow(0.55, 0.95, 0.55, 0.735, 'y');
	}
	else
	{
		openGL_draw_dot_paths(-0.55, 0.43, 'n');
		openGL_draw_path(-0.55, 0.43, -0.97, 0.43, 'n');
		openGL_draw_path(-0.97, 0.43, -0.97, 0.95, 'n');
		openGL_draw_path(-0.97, 0.95, 0.55, 0.95, 'n');
		openGL_draw_path_arrow(0.55, 0.95, 0.55, 0.735, 'n');
	}
}

void openGL_draw_ula_paths()
{
	// ULA to M2
	openGL_draw_path(-0.4, -0.06, -0.4, -0.4, 'n');
	openGL_draw_path_arrow(-0.4, -0.4, -0.465, -0.4, 'n');

	// ULA to M6
	if(selM6 == sULA)	
	{
		openGL_draw_path(-0.31, -0.05, -0.05, -0.05, 'y');
		openGL_draw_path_arrow(-0.05, -0.05, -0.05, -0.03, 'y'); 	
	}
	else
	{
		openGL_draw_path(-0.31, -0.05, -0.05, -0.05, 'n');
		openGL_draw_path_arrow(-0.05, -0.05, -0.05, -0.03, 'n'); 	
	}
}

void openGL_draw_line(float x0, float y0, float x1, float y1)
{
	glColor3f(0, 0, 0);
	glBegin(GL_LINES);
	{
		glVertex2f(x0, y0);
		glVertex2f(x1, y1);
	}
	glEnd();
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
		glColor3f(.5, 1, .5);
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
		glColor3f(.5, 1, .5);
	else
		glColor3f(0, 0, 0);

	float angle = atan2((y0-y1),(x0-x1));
	float angleArrow1 = angle+M_PI/6;
	float angleArrow2 = angle-M_PI/6;

	glBegin(GL_LINES);
	{
		glVertex2f(x0, y0);
		glVertex2f(x1, y1);
		// TODO: draw arrow
		glVertex2f(x1, y1);
		glVertex2f(x1+0.03*cos(angleArrow1), y1+0.03*sin(angleArrow1));

		glVertex2f(x1, y1);
		glVertex2f(x1+0.03*cos(angleArrow2), y1+0.03*sin(angleArrow2));
	}
	glEnd();
}

void openGL_draw_dot_paths(float x, float y, char selected)
{
	if(selected == 'y')
		glColor3f(.5, 1, .5);
	else
		glColor3f(0, 0, 0);

	glBegin(GL_POLYGON);
	int i;
	float raio = 0.015;
	for(i=0; i<360; i+=30){
		glVertex2f(raio*cos(i/180.f*M_PI)+x, raio*sin(i/180.f*M_PI)+y);
	}
	glEnd();
}

