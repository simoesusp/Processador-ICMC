// gcc simple_simulator.c -O3 -march=native -o simulador -Wall -lm
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
//----------------

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

// Selecao do Mux4 --> E´ so´ colocar: 0, 1, 2 ... 7  para selecionar os Registradores

// Selecao do Mux5
//#define sPC 0
#define sM3 1

// Selecao do Mux6
//#define sULA 0
//#define sDATA_OUT 1


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

unsigned int MEMORY[TAMANHO_MEMORIA]; // Vetor que representa a Memoria de programa e de dados do Processador
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
    int PC, IR, SP, MAR, rx, ry, rz, COND, RW, DATA_OUT;
    int LoadPC, IncPC, LoadIR, LoadSP, IncSP, DecSP, LoadMAR, LoadFR;
    int M1, M2, M3, M4, M5, M6
    int selM1, selM2, selM3, selM4, selM5, selM6
    int LoadReg[8];
    int FR[16];  // Flag Register: <...|Negativo|StackUnderflow|StackOverflow|DivByZero|ArithmeticOverflow|carry|zero|equal|lesser|greater>
    int opcode;
    int temp;
    unsigned char state=0; // reset
    int OP, x, y, result;  // ULA


    le_arquivo();

inicio:
    printf("Rodando...\n");

    state = STATE_RESET;


    // Loop principal do processador: Nunca para!!
loop:

	//key = getchar();   

// Executa Load dos Registradores
        if(LoadIR) IR = DATA_OUT;
    
        if(LoadPC) PC = DATA_OUT;
    
        if(IncPC) PC++;
    
        if(LoadMAR) MAR = DATA_OUT;
    
        if(LoadSP) SP = M3;
    
        if(IncSP) SP++;
    
        if(DecSP) SP--;

        if(LoadFR) FR = M6; // ** Tem que trasfrmar em Vetor
    
        // Carrega dados do Mux 2 para os registradores
        rx = pega_pedaco(IR,9,7);
        ry = pega_pedaco(IR,6,4);
        rz = pega_pedaco(IR,3,1);

        if(LoadReg(rx)) reg(rx) = M2;

// Operacao de Escrita da Memoria
        if (RW == 1) MEMORY[M1] = M5;
        
// ---------------------------------------

// Reinicializa os Loads dos registradores
    for(i=0;i<8;i++)
        LoadReg[i] = 0;

    RW = 0;
        
    LoadIR  = 0;
    LoadMAR = 0;
    LoadPC  = 0;
    IncPC   = 0;
    LoadSP  = 0;
    IncSP   = 0;
    DecSP   = 0;
    LoadFR  = 0;

         

switch(state)
{
 case STATE_RESET:
// Reinicializa os registradores
    for(i=0;i<8;i++) {
        reg[i] = 0;
        LoadReg[i] = 0;
    }
    for(i=0;i<16;i++)
        FR[i] = 0;

    PC = 0;  // inicializa na linha Zero da memoria -> Programa tem que comecar na linha Zero !!
    IR = 0;
    MAR = 0;
    SP = TAMANHO_MEMORIA -1;

    RW = 0;
    DATA_OUT = 0;  // Barramento de saida de Dados da Memoria
        
    LoadIR  = 0;
    LoadMAR = 0;
    LoadPC  = 0;
    IncPC   = 0;
    LoadSP  = 0;
    IncSP   = 0;
    DecSP   = 0;
    LoadFR  = 0;
    selM1   = sPC
    selM2   = sDATA_OUT;
    selM3   = 0;  // Pode por direto o nr. do Regisrador
    selM4   = 0;  // Pode por direto o nr. do Regisrador
    selM5   = sM3;
    selM6   = sULA;
         
    // -----------------------------
    state=STATE_FETCH;
 break;

 case STATE_FETCH:
   // ----- Ciclo de Busca: --------
    //IR = MEMORY[PC];

    selM1 = sPC;
    RW = 0;
    LoadIR = 1;
    IncPC = 1;

    // ----------- -- ---------------
    state=STATE_DECODE;
 break;

 
case STATE_DECODE:

  // Case das instrucoes
  opcode = pega_pedaco(IR,15,10);

  switch(opcode){
    case INCHAR:
        if(kbhit())    TECLADO = getchar();
        else TECLADO = 255;

        TECLADO = pega_pedaco(TECLADO,7,0);
        selM2 = sTECLADO;
        LoadReg[rx] = 1;

        // -----------------------------
        state=STATE_FETCH;
        break;

    case OUTCHAR:
        printf("%c", reg[rx]);
        // -----------------------------
        state=STATE_FETCH;
        break;

    case LOADIMED:
        // reg[rx] = mem[PC];
        // PC++;
        selM1 = sPC;
        RW = 0;
        selM2 := sDATA_OUT
        LoadReg(rx) = 1;
        IncPC = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;

    case LOAD:
        // MAR = MEMORY[PC];
        // PC++;
        selM1 = sPC;
        RW = 0;
        LoadMAR = 1; 
        IncPC = 1;
      // -----------------------------
      state=STATE_EXECUTE;
      break;

    case LOADINDEX:
        // reg[rx] = MEMORY[reg[ry]];
        selM4 = Ry;
        selM1 = sM4;
        RW = 0;
        selM2 := sDATA_OUT
        LoadReg(rx) = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;

    case STORE:
        //MEMORY[MEMORY[PC]] = reg[rx];
        //PC++;
        selM1 = sPC;
        RW = 0;
        LoadMAR = 1; 
        IncPC = 1;   
      // -----------------------------
      state=STATE_EXECUTE;
      break;

    case STOREINDEX:
        //mem[reg[rx]] = reg[ry];
        selM4 = Rx;
        selM1 = sM4;
        RW = 1;
        selM3 = Ry;
        selM5 = sM3;
      // -----------------------------
      state=STATE_FETCH;
      break;

    case MOV:
        switch(pega_pedaco(IR,1,0))
        { case 0:
                // reg[rx] = reg[ry];
                selM4 = ry;
                selM2 = sM4;
                loadReg(rx) = 1;
                break;
            case 1:
                // reg[rx] = SP;
                selM2 = sSP;
                LoadReg(rx) = 1;
                break;
            default:
                // SP = reg[rx];
                selM4 = rx;
                LoadSP = 1;
            break;
        }
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case ADD:
    case SUB:
    case MULT:
    case DIV:
    case LMOD:
    case LAND:
    case LOR:
    case LXOR:
    case LNOT:
        // reg[rx] = reg[ry] + reg[rz]; // Soma ou outra operacao
        selM3 = ry;
        selM4 = rz;
        OP = pega_pedaco(IR,15,10)
        CARRY = pega_pedaco(IR,0,0);
        selM2 = sULA;
        loadReg(rx) = 1;
        selM6 = sULA;
        LoadFR  = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case INC:
        //reg[rx]++;                                  // Inc Rx ou DEC
        selM3 = ry;
        selM4 = 8;  // 8 para selecionar o nr. 1 como entrada do MUX4
        
        if(pega_pedaco(IR,6,6) == 0) OP = ADD;  // Se IR6 = 0 --> INC
        else OP = SUB;                          // Se IR6 = 1 --> DEC

        CARRY = 0;
        selM2 = sULA;
        loadReg(rx) = 1;
        selM6 = sULA;
        LoadFR  = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;

    case CMP:
        //if(rx == ry)
        selM3 = ry;
        selM4 = rz;
        OP = pega_pedaco(IR,15,10)
        CARRY = 0;
        selM6 = sULA;
        LoadFR  = 1;
      // -----------------------------
      state=STATE_FETCH;
      break;

    case SHIFT:
        FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
        if(!reg[rx])
            FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero

        switch(pega_pedaco(IR,6,4))
        {   case 0: reg[rx] = reg[rx] << pega_pedaco(IR,3,0);           break;
            case 1: reg[rx] = ~((~(reg[rx]) << pega_pedaco(IR,3,0)));   break;
            case 2: reg[rx] = reg[rx] >> pega_pedaco(IR,3,0);           break;
            case 3: reg[rx] = ~((~(reg[rx]) >> pega_pedaco(IR,3,0)));   break;
            default:
                if(pega_pedaco(IR,6,5)==2) // ROTATE LEFT
                   reg[rx] = _rotl(reg[rx],pega_pedaco(IR,3,0));
                else
                   reg[rx] = _rotr(reg[rx],pega_pedaco(IR,3,0)); 
            break;
        }
      // -----------------------------
      state=STATE_FETCH;
      break;
            
    case JMP:
            COND = pega_pedaco(IR,9,6);

            if((COND == 0) // NO COND
                || (FR[0]==1 && (COND==7))                            // GREATER
                || ((FR[2]==1 || FR[0]==1) && (COND==9))  // GREATER EQUAL
                || (FR[1]==1 && (COND==8))                            // LESSER
                || ((FR[2]==1 || FR[1]==1) && (COND==10)) // LESSER EQUAL
                || (FR[2]==1 && (COND==1))                            // EQUAL
                || (FR[2]==0 && (COND==2))                            // NOT EQUAL
                || (FR[3]==1 && (COND==3))                            // ZERO
                || (FR[3]==0 && (COND==4))                            // NOT ZERO
                || (FR[4]==1 && (COND==5))                            // CARRY
                || (FR[4]==0 && (COND==6))                            // NOT CARRY
                || (FR[5]==1 && (COND==11))                       // OVERFLOW
                || (FR[5]==0 && (COND==12))                       // NOT OVERFLOW
                || (FR[6]==1 && (COND==14))                       // NEGATIVO
                || (FR[9]==1 && (COND==13)))                      // DIVBYZERO
                 { PC = MEMORY[PC];
                                }
                else
                    PC++;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case PUSH:
      if(!pega_pedaco(IR,6,6)) // Registrador
                MEMORY[SP] = reg[rx];
      else  // FR
            {   temp = 0;
        for(i=16; i--; )        // Converte o vetor FR para int
                    temp = temp + (int) (FR[i] * (pow(2.0,i)));
        MEMORY[SP] = temp;
      }
      SP--;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case POP:
      SP++;
      if(!pega_pedaco(IR,6,6))  // Registrador
                reg[rx] = MEMORY[SP];
      else // FR
            { for(i=16; i--; )              // Converte o int MEMORY[SP] para o vetor FR
                    FR[i] = pega_pedaco(MEMORY[SP],i,i);
      }
      // -----------------------------
      state=STATE_FETCH;
      break;
      
    case CALL:
            COND = pega_pedaco(IR,9,6);

            if( (COND == 0) // NO COND
               || (FR[0]==1 && (COND==7))                             // GREATER
                || ((FR[2]==1 || FR[0]==1) && (COND==9))  // GREATER EQUAL
                || (FR[1]==1 && (COND==8))                            // LESSER
                || ((FR[2]==1 || FR[1]==1) && (COND==10)) // LESSER EQUAL
                || (FR[2]==1 && (COND==1))                            // EQUAL
                || (FR[2]==0 && (COND==2)) // NOT EQUAL
                || (FR[3]==1 && (COND==3)) // ZERO
                || (FR[3]==0 && (COND==4)) // NOT ZERO
                || (FR[4]==1 && (COND==5)) // CARRY
                || (FR[4]==0 && (COND==6)) // NOT CARRY
                || (FR[5]==1 && (COND==11)) // OVERFLOW
                || (FR[5]==0 && (COND==12)) // NOT OVERFLOW
                || (FR[6]==1 && (COND==14)) // NEGATIVO
                || (FR[9]==1 && (COND==13))) { // DIVBYZERO
                    MEMORY[SP] = PC;
                    SP--;
                    PC = MEMORY[PC];
                    }
                else
                    PC++;
      // -----------------------------
      state=STATE_FETCH;
      break;
      
      case RTS:
        SP++;
        PC = MEMORY[SP];
        PC++;
      // -----------------------------
      state=STATE_FETCH;
      break;
 
      case SETC:
        FR[4] = pega_pedaco(IR,9,9);
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
        //printf("Rx: %d    Ry: %d  Rz: %d\nPC: %d  IR: %d  opcode: %d\n\n", rx, ry, rz, PC, ir, opcode);
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
            reg[rx] = MEMORY[MAR];
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


// Selecao do Mux4   --> Tem que vir antes do M1 e do M2 que usam M4
        if(selM4 == 8) M4 = 1;  // Seleciona 1 para fazer INC e DEC
        else M4 = reg[selM4]; 

// Selecao do Mux1
        if      (selM1 == sPC)  M1 = PC;
        else if (selM1 == sMAR) M1 = MAR;
        else if (selM1 == sM4)  M1 = M4;
        else if (selM1 == sSP)  M1 = SP;

        if(M1 > (TAMANHO_MEMORIA)) {
            M1 = 0;
            printf("  \n\nUltrapassou limite da memoria, coloque um jmp no fim do código\n");
            exit(1);
            }

// Operacao de Leitura da Memoria
        if (RW == 0) DATA_OUT = MEMORY[M1];  // Tem que vir antes do M2 que usa DATA_OUT

// Selecao do Mux3  --> Tem que vir antes da ULA e do M5
        M3 = reg[selM3];

// Operacao da ULA
        result = ULA(M3, M4, OP, &auxFR);

// Selecao do Mux2
        if      (selM2 == sULA) M2 = result;
        else if (selM2 == sDATA_OUT) M2 = DATA_OUT;
        else if (selM2 == sM4)  M2 = M4;
        else if (selM2 == sTECLADO) M2 = TECLADO;
        else if (selM2 == sSP)  M2 = SP; 

// Selecao do Mux5
        if (selM5 == sPC) M5 = PC;
        else if (selM5 == sM3) M5 = M3;

// Selecao do Mux6
        if (selM6 == sULA) M6 = auxFR;    //**Sempre recebe flags da ULA
        else if (selM6 == sDATA_OUT) M6 = DATA_OUT; //** A menos que seja POP FR, quando recebe da Memoria
        
        



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
                        // Le programa e guarda no vetor MEMORY[32768]
                        processando = 1;
                        j = 0;
                    }
                    i++;
                } while (linha[i] != '\0');

            }

            if (processando && (j < TAMANHO_MEMORIA)) {
                MEMORY[j] = processa_linha(linha);
                if (MEMORY[j] == -1) {
                    printf("Linha invalida (%d): '%s'", j, linha);
                }
                else {
                    //printf("Valor: %d. Linha: %s\n", MEMORY[j], linha);
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

