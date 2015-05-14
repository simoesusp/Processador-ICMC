#ifndef MODEL_H
#define MODEL_H

#include "Mneumonicos.h"
#include "ModelInterface.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>		// para a funcao delay
#include <curses.h>	// para a captura de caracteres do inchar
#include <math.h>		// para a funcao pow
#include <pthread.h>

using namespace std;

class Model : public ModelInterface
{	private:
		// ------ MVC ---------
		Video *Vid;
		Instrucoes *Ins;
		Registradores *Reg;
		ControllerInterface *controller;

		// --- Registradores ------
		int rx, ry, rz;

		int reg[8];
		int pc, ir, sp;
		bool FR[16];

		// ---- Memoria --------
		int mem[TAMANHO_MEMORIA]; // Vetor que representa a Memoria de programa e de dados do Processador

		// ---- Nome dos arquivos ------
		char cpuram[64];
		char charmap[64];

		// -- buffer dos caracteres do charmap --
		short int **chars;

		// -- propriedades do charmap ----
		int charmapwidth;
		int charmapdepth;

		// -- Processamento ---
		pthread_t out;

		int key;
		int auxpc;
		int pc2;
		int varDelay;
		bool automatico;

		// -- Video ---
		pixblock *block;


	public:
		Model(char *cpuram, char *charmap);
		~Model();

		void setController(ControllerInterface *controller);

		void reset();

		void updateAll();

		// ------ Registradores ----------------
		void registraRegistrador(Registradores *r);

		void removeRegistrador();


		// --- registradores gerais ---
		int getRegistrador(int regN);

		void setRegistrador(int *vetor);


		// -------- PC -----------
		int getPC();

		void setPC(int valor);


		// -------- IR -----------
		int getIR();

		void setIR(int valor);


		// -------- SP -----------
		int getSP();

		void setSP(int valor);


		// -------- FR -----------
		bool getFR(int N);

		void setFR(int N, bool valor);


		// ------ Instrucoes -------------------
		void registraInstrucoes(Instrucoes *i);

		void removeInstrucoes();

		void processa();

		int pega_pedaco(int ir, int a, int b);


		// ------ Video -------------------
		void registraVideo(Video *v);

		void removeVideo();

		short int** getChars();

		pixblock* getPixblock();

		void resetVideo();

		// -------- arquivos.mif -----------
		int processa_linha(char *linha);

		void GravaArquivo(char *nome);

		void load_charmap(char* filename);


		// ---- cpuram.mif e charmap.mif -------
		char* getCharmap();

		char* getCpuram();

		int getCharmapdepth();

		int getCharmapwidth();


		// ------ Memoria --------
		int getMem(int pos);


		// ------ Processador ---------
		bool getProcessamento();
		void setProcessamento(bool automatico);

		void delay();

		unsigned int _rotl(const unsigned int value, int shift);

		unsigned int _rotr(const unsigned int value, int shift);

		void processador();

		int getDelay();

		void setDelay(int valor);
};

#endif

