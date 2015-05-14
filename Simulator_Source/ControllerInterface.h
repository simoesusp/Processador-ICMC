#ifndef CONTROLLERINTERFACE_H
#define CONTROLLERINTERFACE_H

#include <gtk/gtk.h>

class ControllerInterface
{	public:
		// ----- Registradores --------
		virtual void AlteraRegistradores(GtkWidget **TextEntryRegs) = 0;


		// ------- Teclado --------
		virtual bool userInput(const char *tecla) = 0;

		virtual void reset() = 0;

		virtual int getKey() = 0;


		// ---- comandos de set -------
		virtual void setDelay(int valor) = 0;

		virtual void setResetVideo(bool valor) = 0;

		virtual void setRegistradorHex(bool valor) = 0;

		virtual void switchExecucao() = 0;


		// ---- comandos de get --------
		virtual bool getHex() = 0;

		virtual void notifyProcessamento() = 0;
};

#endif
