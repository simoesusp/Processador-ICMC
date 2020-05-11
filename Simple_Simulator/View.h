#ifndef VIEW_H
#define VIEW_H

#include "Video.h"
#include "Instrucoes.h"
#include "Registradores.h"

#include <gtk/gtk.h>
#include <string.h>

#include "ModelInterface.h"
#include "ControllerInterface.h"

#include "Mneumonicos.h"

class View : public Instrucoes, public Registradores, public Video
{	private:
		// -------- MVC --------
		ModelInterface *model;
		static ControllerInterface *controller;

		// ---- registradores -------
		bool FR[16];
		int reg[8];
		int pc, ir, sp;

		// -------- Gtk ----------
		GtkWidget *window;

		// ------ labels ---------
		GtkWidget *labelEnd, 
							*labelP,
							*labelCharmap, 
							*labelCPURAM;

		static GtkWidget **TextEntryRegs,
												*labelR;

		GtkWidget *labelReg[8], 
							*labelIr, 
							*labelSp, 
							*labelPc, 
							*labelFR;

		char textoLabelPC[16];
		char textoLabelIR[16];
		char textoLabelSP[16];

		// ----- Instrucoes ---------
		GtkTextBuffer *buffer;

		// ------- Video --------

		short int **chars;	// ainda nao eh usado
		int charmapdepth;
		int charmapwidth;

		// -- charmap e cpuram ---
		char *charmap;
		char *cpuram;

		cairo_surface_t *surface;

	public:
		GtkWidget *outputarea;
		pixblock *block;

		View(ModelInterface *model, ControllerInterface *controller);

		~View();

		// ----- Registradores -----
		void updatePC();

		void updateIR();

		void updateSP();

		void updateFR();

		void updateRegistradores();

		GtkWidget** getRegistradores();


		// -------- Video --------
		void updateVideo(int pos);

		void _draw_pixmap(cairo_t *cr, int offset, int x, int y, int size, int color);

		static gboolean ViewerExpose(GtkWidget *widget, GdkEventExpose *event, gpointer data);

		// ----- Instrucoes -------
		void updateInstrucoes(unsigned int atual, unsigned int proxima, unsigned int linhas); 

		void Imprime(unsigned int atual, unsigned int proxima, unsigned int linhas);

		void show_program(int linha, int pc, int sp);

		// ---- interface grafica ------

		void criaJanela(const char *nome);

		GtkWidget* criaMenu();

		void criaFile(GtkWidget *menubar);

		void criaEditar(GtkWidget *menubar);

		void criarLabelsSuperior(GtkWidget *vbox);

		void criarLabelsInferior(GtkWidget *vbox);

		static gboolean teclado(GtkWidget *widget, GdkEventKey *event, gpointer data);

		static void destroy (GtkWidget *window, gpointer data);

		void criarAreaVisualizacao(GtkWidget *hbox);

		void criarAreaTexto(GtkWidget *hbox);

		void escrever_na_tela(const char *string, int linha, int size);


		// ----- botoes ------
		static void PressionaBotaoRegistradorDec(GtkWidget *widget);

		static void PressionaBotaoRegistradorHex(GtkWidget *widget);

		static void PressionaBotaoResetVideoSim(GtkWidget *widget);

		static void PressionaBotaoResetVideoNao(GtkWidget *widget);

		static void PressionaVelocidadeMuitoRapida();

		static void PressionaVelocidadeRapida();

		static void PressionaVelocidadeMedia();

		static void PressionaVelocidadeLenta();

		static void PressionaVelocidadeMuitoLenta();

		// ---- labels -----
		void TravaRegs();

		void DestravaRegs();

};

#endif

