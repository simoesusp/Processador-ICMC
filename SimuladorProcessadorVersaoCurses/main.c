// Simulador ELD2
// Versao abre o arquivo CPU.MIF e le as instrucoes
// Arrumar o OUTCHAR

// Dicas da NCurses:

//        COLOR_BLACK   0
//        COLOR_RED     1
//        COLOR_GREEN   2
//        COLOR_YELLOW  3
//        COLOR_BLUE    4
//        COLOR_MAGENTA 5
//        COLOR_CYAN    6
//        COLOR_WHITE   7

//    A_NORMAL        Normal display (no highlight)
//    A_STANDOUT      Best highlighting mode of the terminal.
//    A_UNDERLINE     Underlining
//    A_REVERSE       Reverse video
//    A_BLINK         Blinking  --> e' o unico qu enao funciona!!!
//    A_DIM           Half bright
//    A_BOLD          Extra bright or bold
//    A_PROTECT       Protected mode
//    A_INVIS         Invisible or blank mode
//    A_ALTCHARSET    Alternate character set
//    A_CHARTEXT      Bit-mask to extract a character
//    COLOR_PAIR(n)   Color-pair number n



#define TAMANHO_PALAVRA 16
#define TAMANHO_MEMORIA 32768

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



#include <curses.h>     //  Novo Terminal cheio de funcoes!!!
#include <stdlib.h>     // Rand
#include <stdio.h>      // Printf
#include <fcntl.h>      // Fileopen - Fileclose - fprintf - fscanf

unsigned int mem[TAMANHO_MEMORIA]; // Vetor que representa a Memoria de programa e de dados do Processador
int reg[8];

#define TAM 5       // Numero de instrucoes de duas linhas
int line2_instruction[TAM] = { STORE, LOAD, LOADIMED, JMP, CALL };

int charmap[64] = {32, 65, 66, 67, 68, 69, 70, 71, 72, 73,
                   74, 75, 76, 77, 78, 79, 80, 81, 82, 83,
                   84, 85, 86, 87, 88, 89, 90, 91, 92, 93,
                   94, 60, 101,33, 34, 35, 36, 37, 38, 39,
                   40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
                   50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
                   60, 61, 62, 63};



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

void show_program(int x,int y,int pc,int sp) {
    int rx = pega_pedaco(mem[pc],9,7);
    int ry = pega_pedaco(mem[pc],6,4);
    int rz = pega_pedaco(mem[pc],3,1);
    mvprintw(y,x, "                                                                     ");
    int ir = mem[pc];
    switch(pega_pedaco(ir,15,10)){
        case INCHAR:
            mvprintw(y,x, "PC: %05d  |  INCHAR R%d            |   R%d <- TECLADO ", pc, rx, rx);
            break;

        case OUTCHAR:
            mvprintw(y,x, "PC: %05d  |  OUTCHAR R%d, R%d       |   VIDEO[R%d] <- CHAR[R%d] ", pc, rx, ry, rx, ry);
            break;

        case MOV:
            mvprintw(y,x, "PC: %05d  |  MOV R%d, R%d           |   R%d <- R%d ", pc, rx, ry, rx, ry);
            break;

        case STORE:
            mvprintw(y,x, "PC: %05d  |  STORE %05d, R%d      |   MEM[%d] <- R%d ", pc, mem[pc+1], rx, mem[pc+1], rx);
            break;

        case STOREINDEX:
            mvprintw(y,x, "PC: %05d  |  STOREI R%d, R%d        |   MEM[R%d] <- R%d ", pc, rx, ry, rx, ry);
            break;

        case LOAD:
            mvprintw(y,x, "PC: %05d  |  LOAD R%d, %05d       |   R%d <- MEM[%d] ", pc, rx, mem[pc+1], rx, mem[pc+1]);
            break;

        case LOADIMED:
            mvprintw(y,x, "PC: %05d  |  LOADN R%d, #%05d     |   R%d <- #%d ", pc, rx, mem[pc+1], rx, mem[pc+1]);
            break;

        case LOADINDEX:
            mvprintw(y,x, "PC: %05d  |  LOADI R%d, R%d         |   R%d <- MEM[R%d] ", pc, rx, ry, rx, ry);
            break;

        case LAND:
            mvprintw(y,x, "PC: %05d  |  AND R%d, R%d, R%d       |   R%d <- R%d and R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case LOR:
            mvprintw(y,x, "PC: %05d  |  OR R%d, R%d, R%d        |   R%d <- R%d or R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case LXOR:
            mvprintw(y,x, "PC: %05d  |  XOR R%d, R%d, R%d       |   R%d <- R%d xor R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case LNOT:
            mvprintw(y,x, "PC: %05d  |  NOT R%d, R%d           |   R%d <- R%d ", pc, rx, ry, rx, ry);
            break;

        case CMP:
            mvprintw(y,x, "PC: %05d  |  CMP R%d, R%d           |   FR <- <equal|lesser|greater> ", pc, rx, ry);
            break;

        case JMP:
            if(pega_pedaco(ir,9,6) == 0) // NO COND
                mvprintw(y,x, "PC: %05d  |  JMP #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==7)) // GREATER
                mvprintw(y,x, "PC: %05d  |  JGR #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==9)) // GREATER EQUAL
                mvprintw(y,x, "PC: %05d  |  JEG #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==8)) // LESSER
                mvprintw(y,x, "PC: %05d  |  JLE #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==10)) // LESSER EQUAL
                mvprintw(y,x, "PC: %05d  |  JEL #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==1)) // EQUAL
                mvprintw(y,x, "PC: %05d  |  JEQ #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==2)) // NOT EQUAL
                mvprintw(y,x, "PC: %05d  |  JNE #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==3)) // ZERO
                mvprintw(y,x, "PC: %05d  |  JZ #%05d            |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==4)) // NOT ZERO
                mvprintw(y,x, "PC: %05d  |  JNZ #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==5)) // CARRY
                mvprintw(y,x, "PC: %05d  |  JC #%05d            |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==6)) // NOT CARRY
                mvprintw(y,x, "PC: %05d  |  JNC #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==11)) // OVERFLOW
                mvprintw(y,x, "PC: %05d  |  JOV #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==12)) // NOT OVERFLOW
                mvprintw(y,x, "PC: %05d  |  JNO #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==14)) // NEGATIVO
                mvprintw(y,x, "PC: %05d  |  JN #%05d            |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);
            if((pega_pedaco(ir,9,6)==13)) // DIVBYZERO
                mvprintw(y,x, "PC: %05d  |  JDZ #%05d           |   PC <- #%05d ", pc, mem[pc+1], mem[pc+1]);

            break;

        case PUSH:
            if(pega_pedaco(ir,6,6)==0) { // Registrador
                mvprintw(y,x, "PC: %05d  |  PUSH R%d              |   MEM[%d] <- R%d] ", pc, rx, sp, rx);
                }
            else {                      // FR
                mvprintw(y,x, "PC: %05d  |  PUSH FR              |   MEM[%d] <- FR] ", pc, sp);
                }
            break;

        case POP:
            if(pega_pedaco(ir,6,6)==0) { // Registrador
                mvprintw(y,x, "PC: %05d  |  POP R%d               |   R%d <- MEM[%d] ", pc, rx, rx, sp);
                }
            else {                      // FR
                mvprintw(y,x, "PC: %05d  |  POP FR               |   FR <- MEM[%d] ", pc, sp);
                }
            break;

        case CALL:
            if(pega_pedaco(ir,9,6) == 0) // NO COND
                mvprintw(y,x, "PC: %05d  |  CALL #%05d          |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==7)) // GREATER
                mvprintw(y,x, "PC: %05d  |  CGR #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==9)) // GREATER EQUAL
                mvprintw(y,x, "PC: %05d  |  CEG #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==8)) // LESSER
                mvprintw(y,x, "PC: %05d  |  CLE #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==10)) // LESSER EQUAL
                mvprintw(y,x, "PC: %05d  |  CEL #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==1)) // EQUAL
                mvprintw(y,x, "PC: %05d  |  CEQ #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==2)) // NOT EQUAL
                mvprintw(y,x, "PC: %05d  |  CNE #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==3)) // ZERO
                mvprintw(y,x, "PC: %05d  |  CZ #%05d            |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==4)) // NOT ZERO
                mvprintw(y,x, "PC: %05d  |  CNZ #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==5)) // CARRY
                mvprintw(y,x, "PC: %05d  |  CC #%05d            |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==6)) // NOT CARRY
                mvprintw(y,x, "PC: %05d  |  CNC #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==11)) // OVERFLOW
                mvprintw(y,x, "PC: %05d  |  COV #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==12)) // NOT OVERFLOW
                mvprintw(y,x, "PC: %05d  |  CNO #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==14)) // NEGATIVO
                mvprintw(y,x, "PC: %05d  |  CN #%05d            |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);
            if((pega_pedaco(ir,9,6)==13)) // DIVBYZERO
                mvprintw(y,x, "PC: %05d  |  CDZ #%05d           |   M[%d]<-PC; SP--; PC<-#%05d", pc, mem[pc+1], sp, mem[pc+1]);

            break;

        case RTS:
            mvprintw(y,x, "PC: %05d  |  RTS                  |   SP++; PC <- MEM[%d]; PC++ ", pc, sp);
            break;

        case ADD:
            mvprintw(y,x, "PC: %05d  |  ADD R%d, R%d, R%d       |   R%d <- R%d + R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case SUB:
            mvprintw(y,x, "PC: %05d  |  SUB R%d, R%d, R%d       |   R%d <- R%d - R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case MULT:
            mvprintw(y,x, "PC: %05d  |  MULT R%d, R%d, R%d      |   R%d <- R%d * R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case DIV:
            mvprintw(y,x, "PC: %05d  |  DIV R%d, R%d, R%d       |   R%d <- R%d / R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case LMOD:
            mvprintw(y,x, "PC: %05d  |  MOD R%d, R%d, R%d       |   R%d <- R%d % R%d ", pc, rx, ry, rz, rx, ry, rz);
            break;

        case INC:
            if(pega_pedaco(ir,6,6)==0) { // Inc Rx
                mvprintw(y,x, "PC: %05d  |  INC R%d               |   R%d <- R%d + 1 ", pc, rx, rx, rx);
                }
            else  {                      // Dec Rx
                mvprintw(y,x, "PC: %05d  |  DEC R%d               |   R%d <- R%d - 1 ", pc, rx, rx, rx);
                }
            break;

        case SHIFT:     // Nao tive paciencia de fazer diferente para cada SHIFT/ROT
            if(pega_pedaco(ir,6,4)==0) // SHIFT LEFT 0
                mvprintw(y,x, "PC: %05d  |  SHIFTL0 R%d, #%02d      |   R%d <-'0'  << %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,4)==1) // SHIFT LEFT 1
                mvprintw(y,x, "PC: %05d  |  SHIFTL1 R%d, #%02d      |   R%d <-'1'  << %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,4)==2) // SHIFT RIGHT 0
                mvprintw(y,x, "PC: %05d  |  SHIFTR0 R%d, #%02d      |   '0'-> R%d   >> %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,4)==3) // SHIFT RIGHT 1
                mvprintw(y,x, "PC: %05d  |  SHIFTR1 R%d, #%02d      |   '1'-> R%d   >> %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,5)==2) // ROTATE LEFT
                mvprintw(y,x, "PC: %05d  |  ROTL R%d, #%02d         |   R%d <- R%d   << %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,5)==3) // ROTATE RIGHT
                mvprintw(y,x, "PC: %05d  |  ROTR R%d, #%02d         |   R%d -> R%d   >> %d ", pc, rx, pega_pedaco(ir,3,0), rx, pega_pedaco(ir,3,0));

            break;

        case SETC:
            mvprintw(y,x, "PC: %05d  |  SETC                 |   C <- %d ", pc, pega_pedaco(ir,9,9));
            break;

        case HALT:
            mvprintw(y,x, "PC: %05d  |  HALT                 |   Pausa a execussao", pc);
            break;

        case NOP:
            mvprintw(y,x, "PC: %05d  |  NOOP                 |   Do nothing ", pc);
            break;

        case BREAKP:
            mvprintw(y,x, "PC: %05d  |  BREAKP #%05d        |   Break Point ", pc, pega_pedaco(ir,9,0));
            break;
    }


}

int main()
{
    FILE *stream;   // Declara ponteiro para o arquivo
    int i, j, w, k;
    int key;    // Le Teclado
    int step = 1;

    int processando = 0; // Flag para varreo o arquivo CPURAM.mif e tirar o cabecalho
    int pc, ir, sp, rx, ry, rz, auxpc;
    int FR[16];  // Flag Register: <...|Negativo|StackUnderflow|StackOverflow|DivByZero|ArithmeticOverflow|carry|zero|equal|lesser|greater>
    int x,y;
    int opcode;
    int temp;
    unsigned char uctemp;

// Configuracao da Janela da Curses
	initscr();      // Start curses mode
	noecho();       // Nao echoa as teclas digitadas no getch()
    clear();
	raw();      // Desliga um buffer que nao faz diferenca!!!
	keypad(stdscr, TRUE);   // Liga Teclado numerico e setas e F1..F12
	resize_term(42,125);    // Tamanho Maximo na tela de 1200x800 = 64,159
	curs_set(0);    // Cursor disapeer!!!
    //      0 : invisible
    //      1 : normal
    //      2 : very visible.
    start_color();          // Start color
    init_pair(4, COLOR_WHITE, COLOR_BLACK);   //Define the foreground and background for the pair number you give
    init_pair(1, COLOR_RED, COLOR_BLACK);   //Define the foreground and background for the pair number you give
    init_pair(2, COLOR_BLUE, COLOR_BLACK);   //Define the foreground and background for the pair number you give
	init_pair(3, COLOR_GREEN, COLOR_BLACK);   //Define the foreground and background for the pair number you give
    attron(COLOR_PAIR(0));  // Activate the defined collor pair
	timeout(0);    // tempo que espera pelo getch()
// Final da Configuracao da Janela da Curses

inicio:
    clear();

//  Processa dados do Arquivo CPU.MIF
	if ( (stream = fopen("CPURAM.mif","r")) == NULL)  // Abre o arquivo para leitura
		{
		printf("Error: File not OPEN!");
		exit(1);
		}

		char linha[110];

		while (!feof(stream))   // Le linha por linha ate' o final do arquivo: eof = end of file !!
            {
            fscanf(stream,"%s", linha);  // Le uma linha inteira ate' o \n
            //printf("Line %d = %s\n", j, linha);
            char letra[2] = "00";

            if (!processando) {
                i = 0;
                do	{   // Busca por sequencias de caracteres para catar inicio do codigo
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
                refresh();      // Print it on to the real screen
                j++;
            }



        } // Fim do   while (!feof(stream))
       	fclose(stream);  // Nunca esqueca um arquivo aberto!!


    // mvprintw(20,80, "Arquivo lido com sucesso");
	refresh();      // Print it on to the real screen










// Desenha tela do Processador

    for(i=83;i<(83+41);i++) {
        mvprintw(0, i, "%c", 205);
        mvprintw(13,i, "%c", 205);
        }
    for(i=1;i<13;i++) {
        mvprintw(i, 82, "%c", 186);
        mvprintw(i,124, "%c", 186);
        }
        mvprintw(0,82, "%c", 201);
        mvprintw(13,82, "%c", 200);
        mvprintw(0,83+41, "%c", 187);
        mvprintw(13,83+41, "%c", 188);


    mvprintw(38,0, "Rodando...                             ");
    mvprintw(39,0, "Tecle <HOME> para Menu                    ");
    mvprintw(40,0, "Tecle <END> para executar linha atual    ");
    mvprintw(41,0, "                                       ");








// Reinicializa os registradores
    for(i=0;i<16;i++)
        FR[i] = 0;
    for(i=0;i<8;i++)
        reg[i] = 0;

    pc = 0;
    sp = 0x7FFC;







    // Loop principal do processador: Nunca para!!
loop:

	key = getch();        // Wait for user input //mvprintw(21,80, "key = %d", key);

	if (key == KEY_HOME) {
volta2: mvprintw(38,0, "Menu:             Tecle <HOME> para Sair");
        mvprintw(39,0, "Tecle <p> para switch o passo a passo");
        mvprintw(40,0, "Tecle <r> para reiniciar o processador");
        mvprintw(41,0, "Tecle <q> para sair");
volta:  key = getch();        // Wait for user input
       	if (key == 'p') {
            if(step == 1) step = 0; else step = 1;
saip:       mvprintw(38,0, "Rodando...                                ");
            mvprintw(39,0, "Tecle <HOME> para Menu                    ");
            mvprintw(40,0, "                                          ");
            mvprintw(41,0, "                                       ");

            goto loop;}
       	if (key == 'r') goto inicio;
       	if (key == 'q') goto fim;
        if (key == KEY_HOME) goto saip;
       	goto volta;
        }


    auxpc = pc;

    // Ciclo de Busca:
    ir = mem[pc];
    pc++;



    // Ciclo de Executa:
    rx = pega_pedaco(ir,9,7);
    ry = pega_pedaco(ir,6,4);
    rz = pega_pedaco(ir,3,1);




    // Case das instrucoes
    opcode = pega_pedaco(ir,15,10);

    switch(opcode){
        case INCHAR:
            if(step == 1){
                char n;
                mvprintw(40,65, "Waiting. . .");

               	timeout(9999);    // tempo que espera pelo getch()
                key = getch();
                timeout(0);    // tempo que espera pelo getch()

                reg[rx] = pega_pedaco(key,7,0);
                if(reg[rx] != 255) reg[rx] = pega_pedaco(reg[rx],5,0);
                mvprintw(40,65, ". . .       ");
                mvprintw(41,65, "Teclac = %c    ", key);
                mvprintw(41,85, "Teclai = %d    ", reg[rx]);

                }
            else {
                reg[rx] = pega_pedaco(key,7,0);
                if(reg[rx] != 255) reg[rx] = pega_pedaco(reg[rx],5,0);

                if(key != -1){
                    mvprintw(41,65, "TeclaC = %c   ", key);
                    mvprintw(41,85, "TeclaI = %d   ", reg[rx]);
                    }
                }
            break;

        case OUTCHAR:
            y = reg[ry] / 20;
            x = (reg[ry] - (y * 20))*2;

            temp = reg[rx] & 0x3f;

            switch(pega_pedaco(reg[rx],7,6)){
                case 0:
                    attron(COLOR_PAIR(4));  // Activate the defined collor pair
                    break;
                case 1:
                    attron(COLOR_PAIR(1));  // Activate the defined collor pair
                    break;
                case 2:
                    attron(COLOR_PAIR(2));  // Activate the defined collor pair
                    break;
                case 3:
                    attron(COLOR_PAIR(3));  // Activate the defined collor pair
                    break;
                }

            if (reg[ry] < 240) mvprintw(y+1,x+83, " %c", (charmap[temp]));

            attron(COLOR_PAIR(4));  // Activate the defined collor pair
            break;

        case MOV:
            reg[rx] = reg[ry];
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
            if(reg[rx] == 0) FR[3] = 1; else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
            break;

        case LOR:
            reg[rx] = reg[ry] | reg[rz];
            if(reg[rx] == 0) FR[3] = 1; else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
            break;

        case LXOR:
            reg[rx] = reg[ry] ^ reg[rz];
            if(reg[rx] == 0) FR[3] = 1; else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
            break;

        case LNOT:
            reg[rx] =  ~(reg[ry]);
            if(reg[rx] == 0) FR[3] = 1; else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>
            break;

        case CMP:
            if (reg[rx] > reg[ry]) {
					FR[2] = 0; // FR = <...|zero|equal|lesser|greater>
					FR[1] = 0;
					FR[0] = 1;}
            else if (reg[rx] < reg[ry]) {
					FR[2] = 0; // FR = <...|zero|equal|lesser|greater>
					FR[1] = 1;
					FR[0] = 0;}

            else if (reg[rx] = reg[ry]) {
					FR[2] = 1; // FR = <...|zero|equal|lesser|greater>
					FR[1] = 0;
					FR[0] = 0;}
            break;

        case JMP:
			if((pega_pedaco(ir,9,6) == 0) // NO COND
                || (FR[0]==1 && (pega_pedaco(ir,9,6)==7)) // GREATER
                || (FR[2]==1 && FR[0]==1 && (pega_pedaco(ir,9,6)==9)) // GREATER EQUAL
                || (FR[1]==1 && (pega_pedaco(ir,9,6)==8)) // LESSER
                || (FR[2]==1 && FR[1]==1 && (pega_pedaco(ir,9,6)==10)) // LESSER EQUAL
                || (FR[2]==1 && (pega_pedaco(ir,9,6)==1)) // EQUAL
                || (FR[2]==0 && (pega_pedaco(ir,9,6)==2)) // NOT EQUAL
                || (FR[3]==1 && (pega_pedaco(ir,9,6)==3)) // ZERO
                || (FR[3]==0 && (pega_pedaco(ir,9,6)==4)) // NOT ZERO
                || (FR[4]==1 && (pega_pedaco(ir,9,6)==5)) // CARRY
                || (FR[4]==0 && (pega_pedaco(ir,9,6)==6)) // NOT CARRY
                || (FR[5]==1 && (pega_pedaco(ir,9,6)==11)) // OVERFLOW
                || (FR[5]==0 && (pega_pedaco(ir,9,6)==12)) // NOT OVERFLOW
                || (FR[6]==1 && (pega_pedaco(ir,9,6)==14)) // NEGATIVO
                || (FR[9]==1 && (pega_pedaco(ir,9,6)==13))) // DIVBYZERO
                    pc = mem[pc];
                else
                    pc++;
            break;

        case PUSH:
            if(pega_pedaco(ir,6,6)==0) { // Registrador
                mem[sp] = reg[rx];
                }
            else {                      // FR
                for(i=0; i<16; i++){   // Converte o vetor FR para int
                    temp = temp + (FR[i] * (pow(2,i)));
                    }
                mem[sp] = temp;
                }
            sp--;
            break;

        case POP:
            sp++;
            if(pega_pedaco(ir,6,6)==0) { // Registrador
                reg[rx] = mem[sp];
                }
            else {                      // FR
                for(i=0; i<16; i++){   // Converte o int mem[sp] para o vetor FR
                    FR[i] = pega_pedaco(mem[sp],i,i);
                    }
                }
            break;

        case CALL:
			if((pega_pedaco(ir,9,6) == 0) // NO COND
                || (FR[0]==1 && (pega_pedaco(ir,9,6)==7)) // GREATER
                || (FR[2]==1 && FR[0]==1 && (pega_pedaco(ir,9,6)==9)) // GREATER EQUAL
                || (FR[1]==1 && (pega_pedaco(ir,9,6)==8)) // LESSER
                || (FR[2]==1 && FR[1]==1 && (pega_pedaco(ir,9,6)==10)) // LESSER EQUAL
                || (FR[2]==1 && (pega_pedaco(ir,9,6)==1)) // EQUAL
                || (FR[2]==0 && (pega_pedaco(ir,9,6)==2)) // NOT EQUAL
                || (FR[3]==1 && (pega_pedaco(ir,9,6)==3)) // ZERO
                || (FR[3]==0 && (pega_pedaco(ir,9,6)==4)) // NOT ZERO
                || (FR[4]==1 && (pega_pedaco(ir,9,6)==5)) // CARRY
                || (FR[4]==0 && (pega_pedaco(ir,9,6)==6)) // NOT CARRY
                || (FR[5]==1 && (pega_pedaco(ir,9,6)==11)) // OVERFLOW
                || (FR[5]==0 && (pega_pedaco(ir,9,6)==12)) // NOT OVERFLOW
                || (FR[6]==1 && (pega_pedaco(ir,9,6)==14)) // NEGATIVO
                || (FR[9]==1 && (pega_pedaco(ir,9,6)==13))) { // DIVBYZERO
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
            if(pega_pedaco(ir,0,0)==1)  // Soma com Carry
                reg[rx] = reg[ry] + reg[rz] + FR[4];
             else                        // Soma sem Carry
                reg[rx] = reg[ry] + reg[rz];

            if(reg[rx] == 0) FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
             else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

            if(reg[rx] > 0xffff) {
                FR[4] = 1;  // Deu Carry
                reg[rx] = reg[rx] - 0xffff;
                }
             else FR[4] = 0;

            break;

        case SUB:
            if(pega_pedaco(ir,0,0)==1)  // Subtracao com Carry
                reg[rx] = reg[ry] - reg[rz] + FR[4];
             else                        // Subtracao sem Carry
                reg[rx] = reg[ry] - reg[rz];

            if(reg[rx] == 0) FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
             else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

            if(reg[rx] < 0x0000) {
                FR[9] = 1;  // Resultado e' Negativo
                reg[rx] = 0;
                }
             else FR[9] = 0;

            break;

        case MULT:
            if(pega_pedaco(ir,0,0)==1)  // MULT com Carry
                reg[rx] = reg[ry] * reg[rz] + FR[4];
             else                        // MULT sem Carry
                reg[rx] = reg[ry] * reg[rz];

            if(reg[rx] == 0) FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
             else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

            if(reg[rx] > 0xffff) FR[5] = 1;  // Arithmetic Overflow
             else FR[5] = 0;

            break;

        case DIV:
            if(reg[rz] == 0) {
                FR[6] = 1;  // Arithmetic Overflow
                reg[rx] = 0;
                }
             else {
                FR[6] = 0;

                if(pega_pedaco(ir,0,0)==1)  // DIV com Carry
                    reg[rx] = reg[ry] / reg[rz] + FR[4];
                 else                        // DIV sem Carry
                    reg[rx] = reg[ry] / reg[rz];
                }

            if(reg[rx] == 0) FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
             else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

            break;

        case LMOD:
            reg[rx] = reg[ry] % reg[rz];

            if(reg[rx] == 0) FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
             else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

            break;

        case INC:
            if(pega_pedaco(ir,6,6)==0) { // Inc Rx
                reg[rx]++;
                }
            else  {                      // Dec Rx
                reg[rx]--;
                }

            if(reg[rx] == 0) FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
             else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

            break;

        case SHIFT:     // Nao tive paciencia de fazer diferente para cada SHIFT/ROT
            if(pega_pedaco(ir,6,4)==0) // SHIFT LEFT 0
                reg[rx] = reg[ry] << pega_pedaco(ir,3,0);
            if(pega_pedaco(ir,6,4)==1) // SHIFT LEFT 1
                reg[rx] = ~((~(reg[ry]) << pega_pedaco(ir,3,0)));
            if(pega_pedaco(ir,6,4)==2) // SHIFT RIGHT 0
                reg[rx] = reg[ry] >> pega_pedaco(ir,3,0);
            if(pega_pedaco(ir,6,4)==3) // SHIFT RIGHT 1
                reg[rx] = ~((~(reg[ry]) >> pega_pedaco(ir,3,0)));
            if(pega_pedaco(ir,6,5)==2) // ROTATE LEFT
                reg[rx] = _rotl(reg[ry],pega_pedaco(ir,3,0));
            if(pega_pedaco(ir,6,5)==3) // ROTATE RIGHT
                reg[rx] = _rotr(reg[ry],pega_pedaco(ir,3,0));

            if(reg[rx] == 0) FR[3] = 1;  // Se resultado = 0, seta o Flag de Zero
             else FR[3] = 0; // -- FR = <...|zero|equal|lesser|greater>

            break;

        case SETC:
            FR[4] = pega_pedaco(ir,9,9);
            break;

        case HALT:
            mvprintw(38,0, "H A L T E D !!                        ");
            mvprintw(39,0, "Tecle <p> para switch o passo a passo");
            mvprintw(40,0, "Tecle <r> para reiniciar o processador");
            mvprintw(41,0, "Tecle <HOME> para sair");
voltah:     key = getch();        // Wait for user input
            if (key == 'p') {
                if(step == 1) step = 0; else step = 1;
                goto loop;}
            if (key == 'r') goto inicio;
            if (key == 'q') goto fim;
            if (key == KEY_HOME) goto loop;
       	goto voltah;
            break;

        case NOP:
            break;

        case BREAKP:
            step = 1;
            break;


    }


   if(step == 1) {
        mvprintw(25,68, "PC: %05d  IR: %05d   SP: %05d   FR: %d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d", pc, mem[pc], sp, FR[15], FR[14], FR[13], FR[12], FR[11], FR[10], FR[9], FR[8], FR[7], FR[6], FR[5], FR[4], FR[3], FR[2], FR[1], FR[0]);
        mvprintw(27,68, "R0: %06d  R1: %06d   R2: %06d   R3: %06d", reg[0], reg[1], reg[2], reg[3] );
        mvprintw(28,68, "R4: %06d  R5: %06d   R6: %06d   R7: %06d", reg[4], reg[5], reg[6], reg[7] );

        attron(A_BOLD);    //  Bolda tudo!
        mvprintw(0,0, "Linha      |     Instrucao         |     Acao");
        mvprintw(1,69, "<- Atual");
        mvprintw(3,69, "<- Proxima");
        attroff(A_BOLD);    //  Disbolda tudo!

        show_program(0,1,auxpc,sp);
        auxpc = pc;
        show_program(0,3,auxpc,sp);

        for(i=0;i<20;i++){
            temp = 1;
            for(k=0;k<TAM;k++){
                if (pega_pedaco(mem[auxpc],15,10) == line2_instruction[k])
                    temp = 2;
                }
            auxpc = auxpc + temp;
            show_program(0,i+4,auxpc,sp);
            }
        //refresh();      // Print it on to the real screen

        mvprintw(38,0, "Rodando...                                ");
        mvprintw(39,0, "Tecle <HOME> para Menu                    ");
        mvprintw(40,0, "Tecle <END> para executar linha atual    ");
        mvprintw(41,0, "                                       ");


pausa:  key = getch();        // Wait for user input
      	if (key == KEY_END) goto loop;
        if (key == KEY_HOME) goto volta2;
        goto pausa;
        }

    goto loop;

fim:
    resetty();   // Reseta o tamanho da janela!
	endwin();       // End curses mode

	return 0;
}





// Codigo Lixo

/*
// Delay008seg
    //napms(80);  // Delay em miliseconds --> Funcao do NCurses
//printf("PC: %d. IR: %d.  RX: %d.  RY: %d.  RZ: %d.\n", pc, ir, rx, ry, rz);
printf("opcode: %d\n", opcode);
if (pc == 10)   	scanf("%s", &test);


	mvprintw(y,x, "X"); // Desenha Nave
	mvprintw(0,0, "X= %2d  Y= %2d", x, y);  // Debuga Coord. Nave


// Condicoes de contorno da Nave em funcao das variaveis de tamanho da tela
    if (y == -1)
        y = LINES-1;
    if (y == LINES)
        y = 0;
    if (x == -1)
        x = COLS-1;
    if (x == COLS)
        x = 0;


void explode(int xe,int ye)
{
	int z;
// Muda cor
    start_color();          // Start color
	init_pair(1, COLOR_RED, COLOR_BLACK);   //Define the foreground and background for the pair number you give
	attron(COLOR_PAIR(1));  // Activate the defined collor pair
    attron(A_BOLD);    //  Bolda tudo!
    //attroff(A_BOLD);  // Disbolda tudo
    //attrset(A_NORMAL) // turns off all attributes and brings you to normal mode.


	for(z = 0; z<30; z=z+1)
	{
		mvprintw(ye,xe, "*");
		xe = xe + (int) (rand() %3 - 1);
		ye = ye + (int) (rand() %3 - 1);
		// Delay0.05seg
            timeout(50);  // 5 seg
            getch();      // Wait for user input
		refresh();        // Print it on to the real screen
	}
	timeout(25000);  // 25 seg
	getch();        // Wait for user input //
}
*/

