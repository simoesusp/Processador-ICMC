#ifndef MODELINTERFACE_H
#define MODELINTERFACE_H

#include "Video.h"
#include "Instrucoes.h"
#include "Registradores.h"
#include "ControllerInterface.h"

typedef struct
{ short int sym;
	char color;
} pixblock;

class ModelInterface
{	public:
		virtual void reset() = 0;
		virtual void setController(ControllerInterface *controller) = 0;

		// Registradores
		virtual void registraRegistrador(Registradores *r) = 0;
		virtual void removeRegistrador() = 0;

		virtual int  getRegistrador(int reg) = 0;
		virtual void setRegistrador(int *vetor) = 0;

		virtual int  getPC() = 0;
		virtual void setPC(int valor) = 0;

		virtual int  getIR() = 0;
		virtual void setIR(int valor) = 0;

		virtual int  getSP() = 0;
		virtual void setSP(int valor) = 0;

		virtual bool getFR(int N) = 0;
		virtual void setFR(int N, bool valor) = 0;


		// Instrucoes
		virtual void processa() = 0;

		virtual void registraInstrucoes(Instrucoes *i) = 0;
		virtual void removeInstrucoes() = 0;
		virtual int pega_pedaco(int ir, int a, int b) = 0;


		// Video
		virtual void registraVideo(Video *v) = 0;
		virtual void removeVideo() = 0;
		virtual short int** getChars() = 0;
		virtual pixblock* getPixblock() = 0;
		virtual void resetVideo() = 0;


		// cpuram.mif e charmap.mif
		virtual char* getCharmap() = 0;
		virtual char* getCpuram() = 0;
		virtual int getCharmapdepth() = 0;
		virtual int getCharmapwidth() = 0;


		// Memoria
		virtual int getMem(int pos) = 0;

		// ------ Processador ---------
		virtual void setProcessamento(bool automatico) = 0;

		virtual int getDelay() = 0;

		virtual void setDelay(int valor) = 0;

};

#endif
