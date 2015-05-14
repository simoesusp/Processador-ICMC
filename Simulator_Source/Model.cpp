#include "Model.h"
#include <iostream>

void* processaAutomatico(void *data)
{	if(data == NULL)
		return NULL;

	Model *model = (Model*) data;

	int contador = 0;

	while( model->getProcessamento() ) // automatico
	{	gdk_threads_enter();
		model->processador();
		gdk_threads_leave();

		contador++;
//*
		if(contador > 500)
		{	model->delay();
			contador = 0;
		}
//*/
	}
	gdk_threads_enter();
	model->updateAll();
	gdk_threads_leave();

	return NULL;
}

void Model::updateAll()
{	Ins->updateInstrucoes(auxpc, pc2, N_LINHAS);		// termina imprimindo o resultado
	Reg->updateRegistradores();	// e atualizando os registradores
	Reg->updateFR();
	Reg->updatePC();
	Reg->updateIR();
	Reg->updateSP();
}


// -- Construtor e destrutor ---
Model::Model(char *cpuram, char *charmap)
{	FILE *pf;
	if( (pf = fopen(cpuram, "r")) == NULL)
	{	printf("Erro ao tentar abrir: %s\n", cpuram);
		exit(1);
	}

	char linha[128];
	fgets(linha, 128, pf);
	if( strcmp("-- Codigo gerado pelo montador\n", linha) && strcmp("-- Codigo gerado pelo montador\r\n", linha) )
	{	fclose(pf);
		printf("Erro no arquivo .mif");
		exit(1);
	}
	fclose(pf);

	GravaArquivo(cpuram);
	load_charmap(charmap);

	sprintf(this->cpuram, "CPURAM: %s", cpuram);
	sprintf(this->charmap, "Charmap: %s", charmap);
	
	varDelay = MEDIA;
	automatico = false;

	block = (pixblock*) malloc( sizeof(pixblock) * 1200 );
	resetVideo();
}

Model::~Model()
{	free(block); }


void Model::setController(ControllerInterface *controller)
{	this->controller = controller; }

void Model::reset()
{	pc = 0;
	ir = 0;
 	sp = 0x7FFC;
	auxpc = 0;
	pc2 = 0;	

	int i, tmp;
	int vetor[] = {0, 0, 0, 0, 0 , 0, 0, 0};
	setRegistrador(vetor);

	for(i = 16; i-- ; )
		FR[i] = 0;

	processador();

	tmp = auxpc;

	setPC(0);
	setIR(0);
	setSP(0x7FFC);

	setRegistrador(vetor);

	for(i = 16; i-- ; )
		setFR(i, 0);

	Ins->updateInstrucoes(0, tmp, N_LINHAS);		// termina imprimindo o resultado
}


// ------ Registradores ----------------
void Model::registraRegistrador(Registradores *r)
{	Reg = r;	}

void Model::removeRegistrador()
{	Reg = NULL;	}


// --- registradores gerais ---
int Model::getRegistrador(int regN)
{	return reg[regN];	}

void Model::setRegistrador(int *vetor)
{	if(vetor != NULL)
	{	for(int i=8; i--; )
		{	if(vetor[i] >= 0)
				reg[i] = vetor[i];
		}
	}
	Reg->updateRegistradores();
}


// -------- PC -----------
int Model::getPC()
{	return pc; }

void Model::setPC(int valor)
{	if(valor >= 0)
		pc = valor;
	Reg->updatePC();
}


// -------- IR -----------
int Model::getIR()
{	return ir;	}

void Model::setIR(int valor)
{	if(valor >= 0)
		ir = valor;	
	Reg->updateIR();
}


// -------- SP -----------
int Model::getSP()
{	return sp;	}

void Model::setSP(int valor)
{	if(valor >= 0)
		sp = valor;
	Reg->updateSP();
}


// -------- FR -----------
bool Model::getFR(int N)
{	return FR[N];	}

void Model::setFR(int N, bool valor)
{	if(valor >= 0)
		FR[N] = valor;
	Reg->updateFR();
}


// ------ Instrucoes -------------------
void Model::registraInstrucoes(Instrucoes *i)
{	Ins = i;	}

void Model::removeInstrucoes()
{	Ins = NULL;	}

void Model::setProcessamento(bool automatico)
{	this->automatico = automatico; }

bool Model::getProcessamento()
{	return automatico; }

void Model::processa()
{ if(automatico)
	{	//pthread_join(out, NULL);
		//pthread_create(&out, NULL, processaAutomatico, this); // cria uma thread para o Processamento

		GError *error = NULL;

		/* mexi ontem para ver se a velocidade aumentava
		int i;
		for(i=20; i--; )
		{
			if(!g_thread_create(processaAutomatico, this, TRUE, &error))
			{	g_printerr ("Failed to create YES thread: %s\n", error->message);
				return;
			}
		}
		//*/

//*
		if(!g_thread_create(processaAutomatico, this, TRUE, &error))
		{	g_printerr ("Failed to create YES thread: %s\n", error->message);
			return;
		}
//*/
		updateAll();
		return;
	}
	//pthread_join(out, NULL);
	processador(); // executa soh uma vez
	updateAll();
}


// Funcao que separa somente o pedaco de interesse do IR;
__inline int Model::pega_pedaco(int ir, int a, int b)
{ return (int)((ir & (int)  ( (int)((1 << (a+1)) - 1) )  ) >> b); }


// ------ Video -------------------
void Model::registraVideo(Video *v)
{	Vid = v;	}

void Model::removeVideo()
{ Vid = NULL;	}

short int** Model::getChars()
{	return chars; }

pixblock* Model::getPixblock()
{	return block; }

void Model::resetVideo()
{	for(int i=1200; i--; )
	{	block[i].color = BLACK;
		block[i].sym = 0;
	}
}


// -------- arquivos.mif -----------
int Model::processa_linha(char *linha)
{ unsigned int i = 0, j = 0, valor = 0;

	//procura o inicio do numero
	while(linha[i] != ':')
	{	if(!linha[i])
		 return -1;
		i++;
	}

	for(; j<16; j++)  					 	 //le a palavra toda
	{ valor <<= 1; 								 //shifta pra esquerda entrando 0
		valor += linha[i+j+1] - '0'; //converte char pra numero 0 ou 1 o bit 15-k da palavra
	}

	return valor;
}

void Model::GravaArquivo(char *nome)
{	FILE *stream;   // Declara ponteiro para o arquivo

	//  Processa dados do Arquivo CPU.MIF
	if( (stream = fopen(nome,"r")) == NULL)  // Abre o arquivo para leitura
	{ printf("Error: File not OPEN!\n");
		return;
	}

	char linha[128];
	unsigned int i, j, processando = 0;

	while(!feof(stream))   				 // Le linha por linha ate' o final do arquivo: eof = end of file !!
	{ fscanf(stream,"%s", linha);  // Le uma linha inteira ate' o \n
		char letra[3] = "00";

		if(!processando)
		{ i = 0;
		  do						// Busca por sequencias de caracteres para catar inicio do codigo
			{ letra[0] = letra[1];
		    letra[1] = linha[i];

		    if((letra[1]==':') && (letra[0]=='0') )  // Cata primeira linha de codigo comecando com "0: "
		    { // Le programa e guarda no vetor mem[32768]
		      processando = 1;
		      j = 0;
		    }
		    i++;
		  } while (linha[i] != '\0');
		}

		if(processando && (j < TAMANHO_MEMORIA))
		{ mem[j] = processa_linha(linha);

		  if(mem[j] == -1)
			 printf("Linha invalida (%d): '%s'", j, linha);
		  j++;
		}
	} // Fim do while (!feof(stream))

	fclose(stream);  // Nunca esqueca um arquivo aberto!!
}

void Model::load_charmap(char* filename)
{ if(filename == NULL)
		return;

	FILE *ipf = fopen(filename, "r");

	if(ipf == NULL)
	{ printf("Error: CHARMAP.MIF not found.\n");
		return;
	}

	unsigned int i, j, widthcount, depthcount, bytecount, bytemaxcount;

	// ----- percorre ate o primeiro "=" e salva o valor de width -------
	while(fgetc(ipf) != '=') ;
	fscanf(ipf, "%d", &widthcount);
	// --------------------- -- -----------------------------------------

	// ------ percorre ate o proximo "=" e salva o valor de depth --------
	while(fgetc(ipf) != '=') ;
	fscanf(ipf, "%d", &depthcount);
	// ------------------- --- --------------------------------------------

	charmapdepth = depthcount;
	charmapwidth = widthcount;

	// -------- alocacao da matriz de caracteres ---------------------------
	chars = (short int **) malloc(depthcount*sizeof(short int *)); // aloca uma coluna da matriz

	for(i=depthcount; i--; )											 		// aloca uma linha p/ cada posicao da coluna
		chars[i] = (short int *) malloc(widthcount*sizeof(short int));
	// -------------------- -- ---------------------------------------------

	for(i = 0; i < depthcount; i++)
	{ while(fgetc(ipf) != '\t'); // pq as linhas sempre comeca com um tab e em seguida o caracter

		// ------- se for o caso de [A..B] -------------------
		if(fgetc(ipf) == '[') 								// pula o [
		{ fscanf(ipf, "%d", &bytecount);			// salva A

		  fgetc(ipf);													// pula .
		  fgetc(ipf);													// pula .

		  fscanf(ipf, "%d", &bytemaxcount);		// salva B

		  bytemaxcount -= bytecount;					// o contador de bits eh a diferenca de A e B
		}
		else // ------- senao -------
		{ fseek(ipf, -1, SEEK_CUR);						// como ja pegou o numero A na comparacao volta uma posicao p/ tras
		  fscanf(ipf, "%d", &bytecount);			// salva A em bytecount
		  bytemaxcount = 0;										// reseta bytemaxcount
		}

		while(fgetc(ipf) != ':');							// vai ate os :

		// ----- pula até os 0s e 1s que formam os caracteres ---------
		char a;
		while(1)
		{ a = fgetc(ipf);
			if(a == '1' || a == '0')
			{ fseek(ipf, -1, SEEK_CUR);
				break;
			}
		}
		// ----------------------------------------------------

		// ------ salva a parte da linha que contem 0s e 1s na matriz -----------
		for(j=0; j<widthcount; j++)
			chars[i][j] = fgetc(ipf) - 48;
		// -------------------------- -- ----------------------------------------

		// ------ preenche as linhas detro do intervao [A..B] iguais a linha A----
		while(bytemaxcount--)
		{ i++;
		  for(j=widthcount; j--; )
		  	chars[i][j] = chars[i-1][j];
		}
		// ----------------------- -- --------------------------------------------
	}
	fclose(ipf);
}


// cpuram.mif e charmap.mif
char* Model::getCharmap()
{ return charmap; }

char* Model::getCpuram()
{ return cpuram; }

int Model::getCharmapdepth()
{	return charmapdepth; }

int Model::getCharmapwidth()
{	return charmapwidth; }


// Memoria
int Model::getMem(int pos)
{	return mem[pos]; }


// Processamento
unsigned int Model::_rotl(const unsigned int value, int shift)
{ if(shift >= 16)									 				 // evita rotacoes completas
		shift = shift - (shift/16)*16; 				 // shift = shift mod 16

	unsigned int aux = value << shift;			 // shifta para a esquerda
	aux += pega_pedaco(value, 15, 16-shift); // pega os bits finais que serao deslocados para o inicio

	return aux &= 65535;										 // retorna somente os 16 primeiros bits do numero
}

unsigned int Model::_rotr(const unsigned int value, int shift)
{ if(shift >= 16)									 					// evita rotacoes completas
		shift = shift - (shift/16)*16; 					// shift = shift mod 16

	unsigned int aux = value >> shift;				// shifta para a direita
	aux += ( pega_pedaco(value, shift, 0) << (16 - shift) );  // pega os bits iniciais que serao deslocados para o final

	return aux &= 65535;											// retorna somente os 16 primeiros bits do numero
}

void Model::delay()
{ 
/*
	void Model::delay(clock_t wait)

	clock_t goal = ( wait + clock() );
	while( goal > clock() );
//*/

	//g_print("Delay: %d\n", varDelay);

	//clock_t goal = ( varDelay + clock() );
	//while( goal > clock() );
}

int Model::getDelay()
{	return varDelay; }

void Model::setDelay(int valor)
{	
	/*
	// se igual nao faz nada
		if(varDelay == valor)
			return;

		// senao, mata a thread e cria uma nova com o novo valor do delay
	*/

	varDelay = valor;
}

void Model::processador()
{ unsigned int la;
	unsigned int i;
	unsigned int temp;
	unsigned int opcode;

	unsigned int letra;

  // ----- Ciclo de Busca: --------
	ir = mem[pc];

	if(pc > 32767)
	{ printf("Ultrapassou limite da memoria, coloque um jmp no fim do código\n");
		exit(1);
	}
	pc++;
	// ----------- -- ---------------

  // ------ Ciclo de Executa: ------
  rx = pega_pedaco(ir,9,7);
  ry = pega_pedaco(ir,6,4);
  rz = pega_pedaco(ir,3,1);
	// ------------- -- --------------

  // Case das instrucoes
  opcode = pega_pedaco(ir,15,10);

  switch(opcode)
	{ case INCHAR:
				//timeout(9999);    // tempo que espera pelo getch()
        key = controller->getKey();//getch();
        //timeout(0);    		// tempo que espera pelo getch()
        reg[rx] = pega_pedaco(key,7,0);

        //if(reg[rx] != 255)
			//reg[rx] = pega_pedaco(reg[rx],5,0);
			break;

    case OUTCHAR:
			if(reg[ry] > 1199 || reg[ry] < 0)
			{	cout << "ERRO - tentou escrever na posição da tela: " << reg[ry] << endl;
				break;
			}

			letra = reg[rx] & 0x7f;

			if(letra > 0)
      	temp = letra;// + 32;
			else
				temp = 0;

      block[reg[ry]].color = pega_pedaco(reg[rx], 11, 8);
      block[reg[ry]].sym = temp * 8;
			Vid->updateVideo(reg[ry]);
			break;

		case MOV:
			switch(pega_pedaco(ir,1,0))
			{ case 0:
					reg[rx] = reg[ry];
					break;
				case 1:
					reg[rx] = sp;
					break;
				default:
					sp = reg[rx];
				break;
			}
      break;

    case STORE:
      mem[mem[pc]] = reg[rx];
      pc++;
      break;

    case STOREINDEX:
      mem[reg[rx]] = reg[ry];
      break;

    case LOAD:
      reg[rx] = mem[mem[pc]];
      pc++;
      break;

    case LOADIMED:
      reg[rx] = mem[pc];
      pc++;
      break;

    case LOADINDEX:
      reg[rx] = mem[reg[ry]];
      break;

    case LAND:
      reg[rx] = reg[ry] & reg[rz];
			FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
      if(reg[rx] == 0)
				FR[3] = 1;
      break;

    case LOR:
      reg[rx] = reg[ry] | reg[rz];
			FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
      if(reg[rx] == 0)
				FR[3] = 1;
      break;

    case LXOR:
      reg[rx] = reg[ry] ^ reg[rz];
			FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
      if(reg[rx] == 0)
				FR[3] = 1;
      break;

    case LNOT:
      reg[rx] =  ~(reg[ry]);
			FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
      if(reg[rx] == 0)
				FR[3] = 1;
      break;

    case CMP:
			//if(rx == 1200)
			//	printf("valor de ry: %d\n", ry);

      if (reg[rx] > reg[ry])
			{	FR[2] = 0; // FR = <...|zero|equal|lesser|greater>
				FR[1] = 0;
				FR[0] = 1;
			}
      else if (reg[rx] < reg[ry])
			{	FR[2] = 0; // FR = <...|zero|equal|lesser|greater>
				FR[1] = 1;
				FR[0] = 0;
			}
      else // reg[rx] == reg[ry]
			{	FR[2] = 1; // FR = <...|zero|equal|lesser|greater>
				FR[1] = 0;
				FR[0] = 0;
				//printf("rx == ry\n");
			}
      break;

    case JMP:
			la = pega_pedaco(ir,9,6);

			if((la == 0) // NO COND
                || (FR[0]==1 && (la==7)) 							// GREATER
                || ((FR[2]==1 || FR[0]==1) && (la==9))  // GREATER EQUAL
                || (FR[1]==1 && (la==8)) 							// LESSER
                || ((FR[2]==1 || FR[1]==1) && (la==10)) // LESSER EQUAL
                || (FR[2]==1 && (la==1)) 							// EQUAL
                || (FR[2]==0 && (la==2)) 							// NOT EQUAL
                || (FR[3]==1 && (la==3)) 							// ZERO
                || (FR[3]==0 && (la==4)) 							// NOT ZERO
                || (FR[4]==1 && (la==5)) 							// CARRY
                || (FR[4]==0 && (la==6)) 							// NOT CARRY
                || (FR[5]==1 && (la==11)) 						// OVERFLOW
                || (FR[5]==0 && (la==12)) 						// NOT OVERFLOW
                || (FR[6]==1 && (la==14)) 						// NEGATIVO
                || (FR[9]==1 && (la==13))) 						// DIVBYZERO
                 { pc = mem[pc];
								}
                else
                    pc++;
        break;

    case PUSH:
      if(!pega_pedaco(ir,6,6)) // Registrador
				mem[sp] = reg[rx];
      else  // FR
			{	temp = 0;
        for(i=16; i--; ) 		// Converte o vetor FR para int
					temp = temp + (int) (FR[i] * (pow(2.0,i)));
        mem[sp] = temp;
      }
      sp--;
      break;

    case POP:
      sp++;
      if(!pega_pedaco(ir,6,6))  // Registrador
				reg[rx] = mem[sp];
      else // FR
			{ for(i=16; i--; )				// Converte o int mem[sp] para o vetor FR
					FR[i] = pega_pedaco(mem[sp],i,i);
      }
      break;

    case CALL:
			la = pega_pedaco(ir,9,6);

			if( (la == 0) // NO COND
               || (FR[0]==1 && (la==7)) 							// GREATER
                || ((FR[2]==1 || FR[0]==1) && (la==9))  // GREATER EQUAL
                || (FR[1]==1 && (la==8)) 							// LESSER
                || ((FR[2]==1 || FR[1]==1) && (la==10)) // LESSER EQUAL
                || (FR[2]==1 && (la==1)) 							// EQUAL
                || (FR[2]==0 && (la==2)) // NOT EQUAL
                || (FR[3]==1 && (la==3)) // ZERO
                || (FR[3]==0 && (la==4)) // NOT ZERO
                || (FR[4]==1 && (la==5)) // CARRY
                || (FR[4]==0 && (la==6)) // NOT CARRY
                || (FR[5]==1 && (la==11)) // OVERFLOW
                || (FR[5]==0 && (la==12)) // NOT OVERFLOW
                || (FR[6]==1 && (la==14)) // NEGATIVO
                || (FR[9]==1 && (la==13))) { // DIVBYZERO
                    mem[sp] = pc;
                    sp--;
                    pc = mem[pc];
                    }
                else
                    pc++;
            break;

      case RTS:
      	sp++;
        pc = mem[sp];
        pc++;
        break;

      case ADD:
        reg[rx] = reg[ry] + reg[rz]; // Soma sem Carry

        if(pega_pedaco(ir,0,0))   // Soma com Carry
        	reg[rx] += FR[4];

				FR[3] = 0; 									// -- FR = <...|zero|equal|lesser|greater>
				FR[4] = 0;

        if(!reg[rx]) // Se resultado = 0, seta o Flag de Zero
					FR[3] = 1;
				else
        	if(reg[rx] > 0xffff)
					{ FR[4] = 1;  // Deu Carry
          	reg[rx] = reg[rx] - 0xffff;
        	}
        break;

      case SUB:
        reg[rx] = reg[ry] - reg[rz]; // Subtracao sem Carry

        if(pega_pedaco(ir,0,0)==1)  // Subtracao com Carry
      	  reg[rx] += FR[4];

				FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
				FR[9] = 0;

        if(!reg[rx]) // Se resultado = 0, seta o Flag de Zero
					FR[3] = 1;
        else
        	if(reg[rx] < 0x0000)
					{ FR[9] = 1;  // Resultado e' Negativo
         	  reg[rx] = 0;
        	}
        break;

      case MULT:
        reg[rx] = reg[ry] * reg[rz]; // MULT sem Carry

        if(pega_pedaco(ir,0,0)==1)  // MULT com Carry
          reg[rx] += FR[4];

				FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
				FR[5] = 0;

        if(!reg[rx])
					FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
        else
        	if(reg[rx] > 0xffff)
						FR[5] = 1;  // Arithmetic Overflow
        break;

      case DIV:
        if(!reg[rz])
				{ FR[6] = 1;  // Arithmetic Overflow
          reg[rx] = 0;
					FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
        }
        else
				{ FR[6] = 0;

          reg[rx] = reg[ry] / reg[rz]; // DIV sem Carry
          if(pega_pedaco(ir,0,0)==1)  // DIV com Carry
          	reg[rx] += FR[4];

					FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
        	if(!reg[rx])
						FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
				}
        break;

      case LMOD:
        reg[rx] = reg[ry] % reg[rz];

				FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

        if(!reg[rx])
					FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
				break;

      case INC:
				reg[rx]++;									// Inc Rx
        if(pega_pedaco(ir,6,6)!=0) // Dec Rx
          reg[rx] = reg[rx] - 2;

				FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

        if(!reg[rx])
					FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
				break;

      case SHIFT:
				FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

        if(!reg[rx])
					FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero

				switch(pega_pedaco(ir,6,4))
        { case 0: reg[rx] = reg[rx] << pega_pedaco(ir,3,0);					break;
        	case 1: reg[rx] = ~((~(reg[rx]) << pega_pedaco(ir,3,0)));	break;
        	case 2: reg[rx] = reg[rx] >> pega_pedaco(ir,3,0);					break;
        	case 3: reg[rx] = ~((~(reg[rx]) >> pega_pedaco(ir,3,0)));	break;
					default:
        		if(pega_pedaco(ir,6,5)==2) // ROTATE LEFT
        		{  reg[rx] = _rotl(reg[rx],pega_pedaco(ir,3,0)); break; }
        	  reg[rx] = _rotr(reg[rx],pega_pedaco(ir,3,0)); break;
				}
        break;

      case SETC:
        FR[4] = pega_pedaco(ir,9,9);
        break;

      case HALT:		break;
      case NOP:			break;
      case BREAKP:	break;

			default:
				//printf("Default\n");
				//printf("Rx: %d	Ry: %d	Rz: %d\nPC: %d	IR: %d	opcode: %d\n\n", rx, ry, rz, pc, ir, opcode);
				break;
    }
	auxpc = pc;

	int ir2;

	// ----- Ciclo de Busca: --------
  ir2 = mem[pc];
	pc2 = pc + 1;
	// ----------- -- ---------------

	// Case das instrucoes
	opcode = pega_pedaco(ir2,15,10);

	switch(opcode)
	{	case JMP:
			la = pega_pedaco(ir2,9,6);

			if((la == 0) // NO COND
                || (FR[0]==1 && (la==7)) 							// GREATER
                || (FR[2]==1 && FR[0]==1 && (la==9))  // GREATER EQUAL
                || (FR[1]==1 && (la==8)) 							// LESSER
                || (FR[2]==1 && FR[1]==1 && (la==10)) // LESSER EQUAL
                || (FR[2]==1 && (la==1)) 							// EQUAL
                || (FR[2]==0 && (la==2)) 							// NOT EQUAL
                || (FR[3]==1 && (la==3)) 							// ZERO
                || (FR[3]==0 && (la==4)) 							// NOT ZERO
                || (FR[4]==1 && (la==5)) 							// CARRY
                || (FR[4]==0 && (la==6)) 							// NOT CARRY
                || (FR[5]==1 && (la==11)) 						// OVERFLOW
                || (FR[5]==0 && (la==12)) 						// NOT OVERFLOW
                || (FR[6]==1 && (la==14)) 						// NEGATIVO
                || (FR[9]==1 && (la==13))) 						// DIVBYZERO
                    pc2 = mem[pc2];
                else
                    pc2++;
        break;

    case CALL:
			la = pega_pedaco(ir2,9,6);

			if( (la == 0) // NO COND
                || (FR[0]==1 && (la==7)) // GREATER
                || (FR[2]==1 && FR[0]==1 && (la==9)) // GREATER EQUAL
                || (FR[1]==1 && (la==8)) // LESSER
                || (FR[2]==1 && FR[1]==1 && (la==10)) // LESSER EQUAL
                || (FR[2]==1 && (la==1)) // EQUAL
                || (FR[2]==0 && (la==2)) // NOT EQUAL
                || (FR[3]==1 && (la==3)) // ZERO
                || (FR[3]==0 && (la==4)) // NOT ZERO
                || (FR[4]==1 && (la==5)) // CARRY
                || (FR[4]==0 && (la==6)) // NOT CARRY
                || (FR[5]==1 && (la==11)) // OVERFLOW
                || (FR[5]==0 && (la==12)) // NOT OVERFLOW
                || (FR[6]==1 && (la==14)) // NEGATIVO
                || (FR[9]==1 && (la==13))) { // DIVBYZERO
                    pc2 = mem[pc2];
                    }
                else
                    pc2++;
            break;

    case RTS:
			pc2 = mem[sp+1];
			pc2++;
			break;

		case STORE:
		case LOAD:
		case LOADIMED:
			pc2++;
			break;

		case BREAKP:
			controller->notifyProcessamento();
			break;

		case HALT:
			controller->notifyProcessamento();
			break;

		default: break;
  }
}

