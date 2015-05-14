#ifndef REGISTRADORES_H
#define REGISTRADORES_H

class Registradores
{	public:
		virtual void updatePC() = 0;
		virtual void updateIR() = 0;
		virtual void updateSP() = 0;
		virtual void updateFR() = 0;
		virtual void updateRegistradores() = 0;
};

#endif
