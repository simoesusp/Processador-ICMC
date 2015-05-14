#ifndef CONTROLLER_H
#define CONTROLLER_H

#include "View.h"
#include "ModelInterface.h"
#include "ControllerInterface.h"

class Controller : public ControllerInterface
{	private:
		View *view;
		ModelInterface *model;
		bool hex;
		bool automatico;
		bool resetVideo;

		int key;
	public:
		Controller(ModelInterface *model);

		~Controller();

		// ----- Registradores --------
		void AlteraRegistradores(GtkWidget **TextEntryRegs);

		int charToInt(const char *string);


		// ------- Teclado --------
		bool userInput(const char *tecla);

		void reset();

		int getKey();

		// ---- comandos de set -------
		void setDelay(int valor);
		void setResetVideo(bool valor);
		void setRegistradorHex(bool valor);

		void switchExecucao();


		// ---- comandos de get --------
		bool getHex();


		void notifyProcessamento();
};

#endif

