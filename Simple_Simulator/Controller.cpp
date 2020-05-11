#include "Controller.h"

#include <string.h>
#include <iostream>

using namespace std;

Controller::Controller(ModelInterface *model)
{	this->model = model;
	this->model->setController(this);

	hex = false;				// comeca decimal
	automatico = false;	// comeca manual
	resetVideo = true;	// comeca resetando o video, quando dah reset

	view = new View(model, this);
	reset();
}

Controller::~Controller()
{	delete view; }

void Controller::reset()
{	model->reset();
	if(resetVideo)
	{	model->resetVideo();
		for(int i=1200; i--; )
			view->updateVideo(i);
	}
}

void Controller::AlteraRegistradores(GtkWidget **TextEntryRegs)
{	int i, j;
	int aux[8];

	for(i=8; i--; )
	{	j = charToInt(gtk_entry_get_text( GTK_ENTRY(TextEntryRegs[i])) );
		
		if( j == -1 || j > 32768) // se for 0 = erro ou maior do que um numero de 16 bits
		{	aux[i] = -1;
			continue;
		}

		aux[i] = j;
	}
	model->setRegistrador(aux);
}

int Controller::charToInt(const char *string)
{ int i;
	int tam = strlen(string);
	int fator = 1;
	int soma = 0;

	char c;

	for(i=tam; i--; )
	{	c = string[i];
		if('0' <= c && c <= '9')
			soma += fator * (c - '0');
		
		else if(hex && ('A' <= c && c <= 'F') )
			soma  += fator * (c - 'A' + 10);

		else if(hex && 'a' <= c && c <= 'f')
			soma  += fator * (c - 'a' + 10);

		else
			return -1;

		if(hex)
			fator *= 16;
		else
			fator *= 10;
	}
	return soma;
}

bool Controller::userInput(const char *tecla)
{	key = 255;

	if( strlen(tecla) > 1)
	{	if( !strcmp(tecla,"End") )
		{	if(automatico == false)
				model->processa();
			return TRUE;
		}
		else if( !strcmp(tecla, "Return") )
		{	if(automatico == false)
				AlteraRegistradores( view->getRegistradores() );
			key = 13;
			return FALSE;
		}
		else if( !strcmp(tecla, "Escape") )
		{	view->destroy(NULL, NULL); 
			return TRUE;
		}
		else if( !strcmp(tecla, "Home") )
		{	switchExecucao(); 
			return TRUE;
		}
		else if( !strcmp(tecla, "Insert") )
		{	reset(); 
			return TRUE;
		}
		else if( !strcmp(tecla, "Left") )
		{	key = 14;
			return FALSE;
		}
		else if( !strcmp(tecla, "Right") )
		{	key = 15;
			return FALSE;
		}
		else if( !strcmp(tecla, "Up") )
		{	key = 16;
			return FALSE;
		}
		else if( !strcmp(tecla, "Down") )
		{	key = 17;
			return FALSE;
		}
		
		return FALSE;
	}

	
	key = tecla[0];
	//return FALSE;
	
	return FALSE; // TRUE para impedir que o evento continue para os filhos, FALSE para permitir
}

void Controller::setRegistradorHex(bool valor)
{ hex = valor;
	model->setRegistrador(NULL); // atualiza os registradores
}

bool Controller::getHex()
{	return hex; }

void Controller::switchExecucao()
{	automatico = 1 - automatico;

	if(automatico)
	{	view->TravaRegs();
		model->setProcessamento(true);
		model->processa();
		return;
	}
	view->DestravaRegs();
	model->setProcessamento(false);
}

void Controller::notifyProcessamento()
{ automatico = false;
	view->DestravaRegs();
	model->setProcessamento(false);
}

void Controller::setResetVideo(bool valor)
{	resetVideo = valor; }

void Controller::setDelay(int valor)
{	if(valor >= 0)
		model->setDelay(valor);
}

int Controller::getKey()
{	int aux = key;
	key = 255;
	return aux;
}

