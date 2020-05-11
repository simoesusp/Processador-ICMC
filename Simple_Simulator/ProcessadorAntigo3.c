// gcc ProcessadorAntigo.c -O3 -march=native -o simulador -Wall -lm
    // -lm is option to execute math.h library file.


#define TAMANHO_PALAVRA 16
#define TAMANHO_MEMORIA 32768

// Estados do Processador
#define STATE_RESET 0
#define STATE_FETCH 1
#define STATE_DECODE 2
#define STATE_EXECUTE 3
#define STATE_EXECUTE2 4
#define STATE_HALTED 5

// Opcodes das Instrucoes:
// Data Manipulation:
	#define LOAD 48       // "110000"; -- LOAD Rx END  -- Rx <- M[END]  Format: < inst(6) | Rx(3) | xxxxxxx >  + 16bit END
	#define STORE 49      // "110001"; -- STORE END Rx -- M[END] <- Rx  Format: < inst(6) | Rx(3) | xxxxxxx >  + 16bit END
	#define LOADIMED 56   // "111000"; -- LOAD Rx Nr  (b0=0)   -- Rx <- Nr    ou   Load SP Nr (b0=1)  -- SP <- Nr    Format: < inst(6) | Rx(3) | xxxxxxb0 >  + 16bit Numero
	#define LOADINDEX 60  // "111100"; -- LOAD Rx Ry   -- Rx <- M[Ry]	Format: < inst(6) | Rx(3) | Ry(3) | xxxx >
	#define STOREINDEX 61 // "111101"; -- STORE Rx Ry  -- M[Rx] <- Ry	Format: < inst(6) | Rx(3) | Ry(3) | xxxx >
	#define MOV	51        // "110011"; -- MOV Rx Ry    -- Rx <- Ry	  	Format: < inst(6) | Rx(3) | Ry(3) | xxxx >


// I/O Instructions:
	#define OUTCHAR	50  // "110010"; -- OUTCHAR Rx Ry -- Video[Ry] <- Char(Rx)								Format: < inst(6) | Rx(3) | Ry(3) | xxxx >
	#define INCHAR 53   // "110101"; -- INCHAR Rx     -- Rx[7..0] <- KeyPressed	Rx[15..8] <- 0´s  Format: < inst(6) | Rx(3) | xxxxxxx >


// Aritmethic Instructions(All should begin wiht "10"):
	#define ADD 32      // "100000"; -- ADD Rx Ry Rz / ADDC Rx Ry Rz  	-- Rx <- Ry + Rz / Rx <- Ry + Rz + C  -- b0=Carry	  	Format: < inst(6) | Rx(3) | Ry(3) | Rz(3)| C >
	#define SUB 33      // "100001"; -- SUB Rx Ry Rz / SUBC Rx Ry Rz  	-- Rx <- Ry - Rz / Rx <- Ry - Rz + C  -- b0=Carry	  	Format: < inst(6) | Rx(3) | Ry(3) | Rz(3)| C >
	#define MULT 34     // "100010"; -- MUL Rx Ry Rz  / MUL Rx Ry Rz	-- Rx <- Ry * Rz / Rx <- Ry * Rz + C  -- b0=Carry		Format: < inst(6) | Rx(3) | Ry(3) | Rz(3)| C >
	#define DIV	35      // "100011"; -- DIV Rx Ry Rz 			-- Rx <- Ry / Rz / Rx <- Ry / Rz + C  -- b0=Carry		Format: < inst(6) | Rx(3) | Ry(3) | Rz(3)| C >
	#define INC	36      // "100100"; -- INC Rx / DEC Rx                 		-- Rx <- Rx + 1 / Rx <- Rx - 1  -- b6= INC/DEC : 0/1	Format: < inst(6) | Rx(3) | b6 | xxxxxx >
	#define LMOD 37     // "100101"; -- MOD Rx Ry Rz   			-- Rx <- Ry MOD Rz 	  	Format: < inst(6) | Rx(3) | Ry(3) | Rz(3)| x >


// Logic Instructions (All should begin wiht "01"):
	#define LAND 18     // "010010"; -- AND Rx Ry Rz  	-- Rz <- Rx AND Ry	Format: < inst(6) | Rx(3) | Ry(3) | Rz(3)| x >
	#define LOR 19      // "010011"; -- OR Rx Ry Rz   	-- Rz <- Rx OR Ry		Format: < inst(6) | Rx(3) | Ry(3) | Rz(3)| x >
	#define LXOR 20     // "010100"; -- XOR Rx Ry Rz  	-- Rz <- Rx XOR Ry	Format: < inst(6) | Rx(3) | Ry(3) | Rz(3)| x >
	#define LNOT 21     // "010101"; -- NOT Rx Ry       	-- Rx <- NOT(Ry)		Format: < inst(6) | Rx(3) | Ry(3) | xxxx >
	#define SHIFT 16    // "010000"; -- SHIFTL0 Rx,n / SHIFTL1 Rx,n / SHIFTR0 Rx,n / SHIFTR1 Rx,n / ROTL Rx,n / ROTR Rx,n
                        //           -- Format: < inst(6) | Rx(3) |  b6 b5 b4 | nnnn >
	#define CMP 22      // "010110"; -- CMP Rx Ry  		-- Compare Rx and Ry and set FR :  FL = <...|over|carry|zero|equal|lesser|greater>	  Format: < inst(6) | Rx(3) | Ry(3) | xxxx >

// FLOW CONTROL Instructions:
	#define JMP 2       // "000010"; -- JMP END    -- PC <- 16bit END 							  : b9-b6 = COND		Format: < inst(6) | COND(4) | xxxxxx >   + 16bit END
	#define CALL 3      // "000011"; -- CALL END   -- M[SP] <- PC | SP-- | PC <- 16bit END   : b9-b6 = COND	  	Format: < inst(6) | COND(4) | xxxxxx >   + 16bit END
	#define RTS	4       // "000100"; -- RTS        -- SP++ | PC <- M[SP] | b6=Rx/FR: 1/0	  							Format: < inst(6) | xxxxxxxxxx >
	#define PUSH 5      // "000101"; -- PUSH Rx / PUSH FR  -- M[SP] <- Rx / M[SP] <- FR | SP-- 	  			  : b6=Rx/FR: 0/1		Format: < inst(6) | Rx(3) | b6 | xxxxxx >
	#define POP	6       // "000110"; -- POP Rx  / POP FR   -- SP++ | Rx <- M[SP]  / FR <- M[SP]	  			  : b6=Rx/FR: 0/1		Format: < inst(6) | Rx(3) | b6 | xxxxxx >


// Control Instructions:
	#define NOP	0       // "000000"; -- NOP            -- Do Nothing	 	Format: < inst(6) | xxxxxxxxxx >
	#define HALT 15     // "001111"; -- HALT           -- Stop Here		Format: < inst(6) | xxxxxxxxxx >
	#define SETC 8      // "001000"; -- CLEARC / SETC  -- Set/Clear Carry: b9 = 1-set; 0-clear	 Format: < inst(6) | b9 | xxxxxxxxx >
	#define BREAKP 14   // "001110"; -- BREAKP         -- Break Point: Pausa execussao		Format: < inst(6) | xxxxxxxxxx >



//#include <curses.h>     //  Novo Terminal cheio de funcoes!!!
#include <stdlib.h>     // Rand
#include <stdio.h>      // Printf
#include <fcntl.h>      // Fileopen - Fileclose - fprintf - fscanf
#include <math.h>

unsigned int mem[TAMANHO_MEMORIA]; // Vetor que representa a Memoria de programa e de dados do Processador
int reg[8]; // 8 registradores



//  Processa dados do Arquivo CPU.MIF
void le_arquivo(void);

//processa uma linha completa e retorna o número codificado
int processa_linha(char* linha); 

// Funcao que separa somente o pedaco de interesse do IR;
int pega_pedaco(int ir, int a, int b); 

// Rotate Left 16 bits
unsigned int _rotl(const unsigned int value, int shift);

// Rotate Right 16 bits
unsigned int _rotr(const unsigned int value, int shift);


int main()
{
    int i;
    int key;    // Le Teclado
    int pc, ir, sp, mar, rx, ry, rz, la;
    int FR[16];  // Flag Register: <...|Negativo|StackUnderflow|StackOverflow|DivByZero|ArithmeticOverflow|carry|zero|equal|lesser|greater>
    int opcode;
    int temp;
    unsigned char state=0; // reset

    le_arquivo();

inicio:
    printf("Rodando...\n");

// Reinicializa os registradores
    for(i=0;i<16;i++)
        FR[i] = 0;
    for(i=0;i<8;i++)
        reg[i] = 0;

    pc = 0;
    sp = TAMANHO_MEMORIA -1;
    state=STATE_RESET;







    // Loop principal do processador: Nunca para!!
loop:

	//key = getchar();     




switch(state)
{
 case STATE_RESET:
    // Reinicializa os registradores
    for(i=0;i<16;i++)
        FR[i] = 0;
    for(i=0;i<8;i++)
        reg[i] = 0;

    pc = 0;
    sp = TAMANHO_MEMORIA -1;

    // -----------------------------
    state=STATE_FETCH;
 break;

 case STATE_FETCH:
   // ----- Ciclo de Busca: --------
    ir = mem[pc];

    if(pc < (TAMANHO_MEMORIA - 1))
        pc++;
    else
        { printf("  \n\nUltrapassou limite da memoria, coloque um jmp no fim do código\n");
            exit(1);
        }
    // ----------- -- ---------------
    state=STATE_DECODE;
 break;

 
case STATE_DECODE:

 // ------ Ciclo de Executa: ------
  rx = pega_pedaco(ir,9,7);
  ry = pega_pedaco(ir,6,4);
  rz = pega_pedaco(ir,3,1);
    // ------------- -- --------------

  // Case das instrucoes
  opcode = pega_pedaco(ir,15,10);

  switch(opcode){
    case INCHAR:
                //timeout(9999);    // tempo que espera pelo getch()
        key = getchar();//getch();
        //timeout(0);           // tempo que espera pelo getch()
        reg[rx] = pega_pedaco(key,7,0);

        // -----------------------------
        state=STATE_FETCH;
        break;

    case OUTCHAR:
        printf("%c", reg[rx]);
        // -----------------------------
        state=STATE_FETCH;
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
        // -----------------------------
        state=STATE_FETCH;
        break;

    case STORE:
        mem[mem[pc]] = reg[rx];
        pc++;
        // -----------------------------
        state=STATE_FETCH;
        break;

    case STOREINDEX:
      mem[reg[rx]] = reg[ry];
      // -----------------------------
      state=STATE_FETCH;
      break;

    case LOAD:
      mar = mem[pc];
      pc++;
      // -----------------------------
      state=STATE_EXECUTE;
      break;

    case LOADIMED:
      reg[rx] = mem[pc];
      pc++;
      // -----------------------------
      state=STATE_FETCH;
      break;

    case LOADINDEX:
      reg[rx] = mem[reg[ry]];
      // -----------------------------
      state=STATE_FETCH;
      break;

    case LAND:
      reg[rx] = reg[ry] & reg[rz];
            FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
      if(reg[rx] == 0)
                FR[3] = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case LOR:
      reg[rx] = reg[ry] | reg[rz];
            FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
      if(reg[rx] == 0)
                FR[3] = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case LXOR:
      reg[rx] = reg[ry] ^ reg[rz];
            FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
      if(reg[rx] == 0)
                FR[3] = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case LNOT:
      reg[rx] =  ~(reg[ry]);
            FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
      if(reg[rx] == 0)
                FR[3] = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case CMP:
            //if(rx == 1200)
            //  printf("valor de ry: %d\n", ry);

      if (reg[rx] > reg[ry])
            {   FR[2] = 0; // FR = <...|zero|equal|lesser|greater>
                FR[1] = 0;
                FR[0] = 1;
            }
      else if (reg[rx] < reg[ry])
            {   FR[2] = 0; // FR = <...|zero|equal|lesser|greater>
                FR[1] = 1;
                FR[0] = 0;
            }
      else // reg[rx] == reg[ry]
            {   FR[2] = 1; // FR = <...|zero|equal|lesser|greater>
                FR[1] = 0;
                FR[0] = 0;
                //printf("rx == ry\n");
            }
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case JMP:
            la = pega_pedaco(ir,9,6);

            if((la == 0) // NO COND
                || (FR[0]==1 && (la==7))                            // GREATER
                || ((FR[2]==1 || FR[0]==1) && (la==9))  // GREATER EQUAL
                || (FR[1]==1 && (la==8))                            // LESSER
                || ((FR[2]==1 || FR[1]==1) && (la==10)) // LESSER EQUAL
                || (FR[2]==1 && (la==1))                            // EQUAL
                || (FR[2]==0 && (la==2))                            // NOT EQUAL
                || (FR[3]==1 && (la==3))                            // ZERO
                || (FR[3]==0 && (la==4))                            // NOT ZERO
                || (FR[4]==1 && (la==5))                            // CARRY
                || (FR[4]==0 && (la==6))                            // NOT CARRY
                || (FR[5]==1 && (la==11))                       // OVERFLOW
                || (FR[5]==0 && (la==12))                       // NOT OVERFLOW
                || (FR[6]==1 && (la==14))                       // NEGATIVO
                || (FR[9]==1 && (la==13)))                      // DIVBYZERO
                 { pc = mem[pc];
                                }
                else
                    pc++;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case PUSH:
      if(!pega_pedaco(ir,6,6)) // Registrador
                mem[sp] = reg[rx];
      else  // FR
            {   temp = 0;
        for(i=16; i--; )        // Converte o vetor FR para int
                    temp = temp + (int) (FR[i] * (pow(2.0,i)));
        mem[sp] = temp;
      }
      sp--;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case POP:
      sp++;
      if(!pega_pedaco(ir,6,6))  // Registrador
                reg[rx] = mem[sp];
      else // FR
            { for(i=16; i--; )              // Converte o int mem[sp] para o vetor FR
                    FR[i] = pega_pedaco(mem[sp],i,i);
      }
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case CALL:
            la = pega_pedaco(ir,9,6);

            if( (la == 0) // NO COND
               || (FR[0]==1 && (la==7))                             // GREATER
                || ((FR[2]==1 || FR[0]==1) && (la==9))  // GREATER EQUAL
                || (FR[1]==1 && (la==8))                            // LESSER
                || ((FR[2]==1 || FR[1]==1) && (la==10)) // LESSER EQUAL
                || (FR[2]==1 && (la==1))                            // EQUAL
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
      // -----------------------------
      state=STATE_FETCH;
      break;
      
      case RTS:
        sp++;
        pc = mem[sp];
        pc++;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
      case ADD:
        reg[rx] = reg[ry] + reg[rz]; // Soma sem Carry

        if(pega_pedaco(ir,0,0))   // Soma com Carry
            reg[rx] += FR[4];

                FR[3] = 0;                                  // -- FR = <...|zero|equal|lesser|greater>
                FR[4] = 0;

        if(!reg[rx]) // Se resultado = 0, seta o Flag de Zero
                    FR[3] = 1;
                else
            if(reg[rx] > 0xffff)
                    { FR[4] = 1;  // Deu Carry
            reg[rx] = reg[rx] - 0xffff;
            }
      // -----------------------------
      state=STATE_FETCH;
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
      // -----------------------------
      state=STATE_FETCH;
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
      // -----------------------------
      state=STATE_FETCH;
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
      // -----------------------------
      state=STATE_FETCH;
      break;
      
      case LMOD:
        reg[rx] = reg[ry] % reg[rz];

                FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

        if(!reg[rx])
                    FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
      // -----------------------------
      state=STATE_FETCH;
      break;
      
      case INC:
                reg[rx]++;                                  // Inc Rx
        if(pega_pedaco(ir,6,6)!=0) // Dec Rx
          reg[rx] = reg[rx] - 2;

                FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

        if(!reg[rx])
                    FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
      // -----------------------------
      state=STATE_FETCH;
      break;
      
      case SHIFT:
        FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
        if(!reg[rx])
            FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero

        switch(pega_pedaco(ir,6,4))
        {   case 0: reg[rx] = reg[rx] << pega_pedaco(ir,3,0);           break;
            case 1: reg[rx] = ~((~(reg[rx]) << pega_pedaco(ir,3,0)));   break;
            case 2: reg[rx] = reg[rx] >> pega_pedaco(ir,3,0);           break;
            case 3: reg[rx] = ~((~(reg[rx]) >> pega_pedaco(ir,3,0)));   break;
            default:
                if(pega_pedaco(ir,6,5)==2) // ROTATE LEFT
                   reg[rx] = _rotl(reg[rx],pega_pedaco(ir,3,0));
                else
                   reg[rx] = _rotr(reg[rx],pega_pedaco(ir,3,0)); 
            break;
        }
      // -----------------------------
      state=STATE_FETCH;
      break;
      
      case SETC:
        FR[4] = pega_pedaco(ir,9,9);
      // -----------------------------
      state=STATE_FETCH;
      break;
      
      case HALT:        
      // -----------------------------
      state=STATE_HALTED;
      break;

      case NOP:         
      // -----------------------------
      state=STATE_FETCH;
      break;

      case BREAKP:  
      // -----------------------------
      state=STATE_FETCH;
      break;

      default:
        //printf("Default\n");
        //printf("Rx: %d    Ry: %d  Rz: %d\nPC: %d  IR: %d  opcode: %d\n\n", rx, ry, rz, pc, ir, opcode);
      state=STATE_FETCH;
      break;
    }
    // -----------------------------
    //state=STATE_EXECUTE;
 break;

 case STATE_EXECUTE:
    // -----------------------------
    switch(opcode){
        case LOAD:
            reg[rx] = mem[mar];
            // -----------------------------
            state=STATE_FETCH;
            break;
        }
      
    //state=STATE_EXECUTE2;
 break;

 case STATE_EXECUTE2:
    // -----------------------------
    state=STATE_FETCH;
 break;

 case STATE_HALTED:
    printf("\n");
    key = getchar();
    if (key == 'r') goto inicio;
    if (key == 'q') goto fim;
 break;

 default:
 break;
}

goto loop;

fim:
	return 0;
}

//  Processa dados do Arquivo CPU.MIF
void le_arquivo(void){
    FILE *stream;   // Declara ponteiro para o arquivo
    int i, j;
    int processando = 0; // Flag para varreo o arquivo CPURAM.mif e tirar o cabecalho
 
    if ( (stream = fopen("CPURAM.mif","r")) == NULL)  // Abre o arquivo para leitura
        {
        printf("Error: File not OPEN!");
        exit(1);
        }

        char linha[110];
        j = 0;

        while (!feof(stream))   // Le linha por linha ate' o final do arquivo: eof = end of file !!
            {
            fscanf(stream,"%s", linha);  // Le uma linha inteira ate' o \n
            //printf("Line %d = %s\n", j, linha);
            char letra[2] = "00";

            if (!processando) {
                i = 0;
                do  {   // Busca por sequencias de caracteres para catar inicio do codigo
                    letra[0] = letra[1];
                    letra[1] = linha[i];
                    if ((letra[0]=='0') && (letra[1]==':') )  // Cata primeira linha de codigo omecando com "0: "
                    {
                        // Le programa e guarda no vetor mem[32768]
                        processando = 1;
                        j = 0;
                    }
                    i++;
                } while (linha[i] != '\0');

            }

            if (processando && (j < TAMANHO_MEMORIA)) {
                mem[j] = processa_linha(linha);
                if (mem[j] == -1) {
                    printf("Linha invalida (%d): '%s'", j, linha);
                }
                else {
                    //printf("Valor: %d. Linha: %s\n", mem[j], linha);
                }
                j++;
            }



        } // Fim do   while (!feof(stream))
        fclose(stream);  // Nunca esqueca um arquivo aberto!!
}

//processa uma linha completa e retorna o número codificado
//retorna -1 em caso de erro
//NOTA: Assume radix=BIN no arquivo CPURAM.MIF
int processa_linha(char* linha) {
    int i=0;
    int j=0;
    int valor=0;
    //procura o inicio do numero
    while (linha[i] != ':') {
        if (linha[i] == 0) {
            return -1;
        }
        i++;
    }

    valor = 0;
    for (j=0;j<16;j++) { //le a palavra toda
        valor <<= 1; //shifta pra esquerda entrando 0
        valor += linha[i+j+1] - '0'; //converte char pra numero 0 ou 1 o bit 15-k da palavra
    }

    return valor;
}

// Funcao que separa somente o pedaco de interesse do IR;
int pega_pedaco(int ir, int a, int b) {
    int pedaco=0;

// Separa somente o pedaco de interesse;

/* Essa operação retira o numero do registrador entre o a-b bit
           da instrução, realizando um right-shift de b posições
           e aplicando uma máscara de n-bits, onde n = nr. 1's entre a e b
           Obs.:    & - AND
                    >> - right-shift

           ex.: Rx = 0x0007 & IR >> 7;
*/
    pedaco = ((pow(2,(a-b+1)))-1);
    pedaco = pedaco & ir >> b;

    return pedaco;
}

// Rotate Left 16 bits
unsigned int _rotl(const unsigned int value, int shift) {
    if ((shift &= 16*8 - 1) == 0)
      return value;
    return (value << shift) | (value >> (16*8 - shift));
}

// Rotate Right 16 bits
unsigned int _rotr(const unsigned int value, int shift) {
    if ((shift &= 16*8 - 1) == 0)
      return value;
    return (value >> shift) | (value << (16*8 - shift));
}

