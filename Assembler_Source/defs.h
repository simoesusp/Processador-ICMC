#ifndef _DEFS_
#define _DEFS_

/* Definicoes gerais das instrucoes (op code 'interno') */

#define LOAD_CODE               1
#define STORE_CODE              2
#define LOADIMED_CODE           84
#define LOADINDEX_CODE          85
#define STOREIMED_CODE          86
#define STOREINDEX_CODE         87
#define MOV_CODE                3
#define OUTCHAR_CODE            4
#define INCHAR_CODE             5
#define ADD_CODE                6
#define ADDC_CODE               7
#define SUB_CODE                8
#define SUBC_CODE               9
#define MUL_CODE                10
#define DIV_CODE                11
#define INC_CODE                12
#define DEC_CODE                13
#define AND_CODE                14
#define OR_CODE                 15
#define XOR_CODE                16
#define NOT_CODE                17
#define SHIFTL0_CODE            18
#define SHIFTL1_CODE            19
#define SHIFTR0_CODE            20
#define SHIFTR1_CODE            21
#define ROTL_CODE               22
#define ROTR_CODE               23
#define CMP_CODE                24
#define BRA_CODE                25
#define BEQ_CODE                26
#define BNE_CODE                27
#define BZ_CODE                 28
#define BNZ_CODE                29
#define BC_CODE                 30
#define BNC_CODE                31
#define BGT_CODE                32
#define BLT_CODE                33
#define BEG_CODE                34
#define BEL_CODE                35
#define BO_CODE                 36
#define BNO_CODE                37
#define JMP_CODE                38
#define JEQ_CODE                39
#define JNE_CODE                40
#define JZ_CODE                 41
#define JNZ_CODE                42
#define JC_CODE                 43
#define JNC_CODE                44
#define JGT_CODE                45
#define JLT_CODE                46
#define JEG_CODE                47
#define JEL_CODE                48
#define JO_CODE                 49
#define JNO_CODE                50
#define CALL_CODE               51
#define CEQ_CODE                52
#define CNE_CODE                53
#define CZ_CODE                 54
#define CNZ_CODE                55
#define CC_CODE                 56
#define CNC_CODE                57
#define CGT_CODE                58
#define CLT_CODE                59
#define CEG_CODE                60
#define CEL_CODE                61
#define CO_CODE                 62
#define CNO_CODE                63
#define SET_CODE                64
#define SEQ_CODE                65
#define SNE_CODE                66
#define SZ_CODE                 67
#define SNZ_CODE                68
#define SC_CODE                 69
#define SNC_CODE                70
#define SGT_CODE                71
#define SLT_CODE                72
#define SEG_CODE                73
#define SEL_CODE                74
#define SO_CODE                 75
#define SNO_CODE                76
#define RTS_CODE                77
#define RTI_CODE                78
#define PUSH_CODE               79
#define POP_CODE                80
#define HALT_CODE               81
#define SETC_CODE               82
#define CLEARC_CODE             83
#define CALLR_CODE              88
#define JMPR_CODE               89
#define JDZ_CODE                90
#define JN_CODE                 91
#define CDZ_CODE                92
#define CN_CODE                 93
#define BREAKP_CODE             94
#define LMOD_CODE               95
#define NOP_CODE                0
#define INPUT_CODE              96
#define OUTPUT_CODE             97

/* Definicoes dos op codes (binarios em strings) */

/* Data Manipulation Instructions: */
#define LOAD            "110000"
#define STORE           "110001"
#define LOADIMED        "111000"
#define STOREIMED       "111001"
#define LOADINDEX       "111100"
#define STOREINDEX      "111101"
#define MOV             "110011"

/* Peripheric Instructions: */
#define INPUT	        "111110"
#define OUTPUT          "111111"

/* I/O Instructions: */
#define OUTCHAR         "110010"
#define INCHAR          "110101"

/* Aritmethic Instructions(All should begin with "10"):	*/
#define ADD             "100000"
#define SUB             "100001"
#define MUL             "100010"
#define DIV             "100011"
#define INC             "100100"
#define LMOD            "100101"


/* Logic Instructions (All should begin with "01"): */
#define LAND            "010010"
#define LOR             "010011"
#define LXOR            "010100"
#define LNOT            "010101"
#define SHIFT           "010000"
#define CMP             "010110"

/* FLOW CONTROL Instructions: */
#define BRA             "000001"
#define JMP             "000010"
#define CALL            "000011"
#define RTS             "000100"
#define RTI             "000100" /* RTI e um RTS por enquanto. */
#define PUSH            "000101"
#define POP             "000110"
/* Adddendum */
#define SET             "000111"
#define CALLR           "001001"
#define JMPR            "001010"

/* Control Instructions: */
#define NOP             "000000"
#define HALT            "001111"
#define CLEARC          "001000"
#define BREAKP		"001110"

/* Definicoes das condicoes (binarios em strings) */
#define NO_COND         "0000"
#define COND_EQ         "0001"
#define COND_NE         "0010"
#define COND_Z          "0011"
#define COND_NZ         "0100"
#define COND_C          "0101"
#define COND_NC         "0110"
#define COND_GT         "0111"
#define COND_LT         "1000"
#define COND_EG         "1001"
#define COND_EL         "1010"
#define COND_O          "1011"
#define COND_NO         "1100"
#define COND_DZ         "1101"
#define COND_N          "1110"


/* Definicoes das strings das funcoes */

/* LOAD */
#define LOAD_STR                "LOAD"
#define LOADIMED_STR            "LOADN"
#define LOADINDEX_STR           "LOADI"

/* STORE */
#define STORE_STR               "STORE"
#define STOREIMED_STR           "STOREN"
#define STOREINDEX_STR          "STOREI"

#define MOV_STR                 "MOV"
#define INCHAR_STR              "INCHAR"
#define OUTCHAR_STR             "OUTCHAR"

#define INPUT_STR               "INPUT"
#define OUTPUT_STR              "OUTPUT"

/* ADD */
#define ADD_STR                 "ADD"
#define ADDC_STR                "ADDC"

/* SUB */
#define SUB_STR                 "SUB"
#define SUBC_STR                "SUBC"

#define MUL_STR                 "MUL"
#define DIV_STR                 "DIV"

/* INC */
#define INC_STR                 "INC"
#define DEC_STR                 "DEC"
#define LMOD_STR                "MOD"


#define AND_STR                 "AND"
#define OR_STR                  "OR"
#define XOR_STR                 "XOR"
#define NOT_STR                 "NOT"
    
/* SHIFT */
#define SHIFTL0_STR             "SHIFTL0"
#define SHIFTL1_STR             "SHIFTL1"
#define SHIFTR0_STR             "SHIFTR0"
#define SHIFTR1_STR             "SHIFTR1"
#define ROTL_STR                "ROTL"
#define ROTR_STR                "ROTR"

#define CMP_STR                 "CMP"

/* BRA */
#define BRA_STR                 "BRA"
#define BEQ_STR                 "BEQ"
#define BNE_STR                 "BNE"
#define BZ_STR                  "BZ"
#define BNZ_STR                 "BNZ"
#define BC_STR                  "BC"
#define BNC_STR                 "BNC"
#define BGT_STR                 "BGT"
#define BLT_STR                 "BLT"
#define BEG_STR                 "BEG"
#define BEL_STR                 "BEL"
#define BO_STR                  "BOV"
#define BNO_STR                 "BNO"

/* JMP */
#define JMP_STR                 "JMP"
#define JEQ_STR                 "JEQ"
#define JNE_STR                 "JNE"
#define JZ_STR                  "JZ"
#define JNZ_STR                 "JNZ"
#define JC_STR                  "JC"
#define JNC_STR                 "JNC"
#define JGT_STR                 "JGR"
#define JLT_STR                 "JLE"
#define JEG_STR                 "JEG"
#define JEL_STR                 "JEL"
#define JO_STR                  "JOV"
#define JNO_STR                 "JNO"
#define JDZ_STR                 "JDZ"
#define JN_STR                  "JN"


/* CALL */
#define CALL_STR                "CALL"
#define CEQ_STR                 "CEQ"
#define CNE_STR                 "CNE"
#define CZ_STR                  "CZ"
#define CNZ_STR                 "CNZ"
#define CC_STR                  "CC"
#define CNC_STR                 "CNC"
#define CGT_STR                 "CGR"
#define CLT_STR                 "CLE"
#define CEG_STR                 "CEG"
#define CEL_STR                 "CEL"
#define CO_STR                  "COV"
#define CNO_STR                 "CNO"
#define CDZ_STR                 "CDZ"
#define CN_STR                  "CN"

/* SET */
#define SET_STR                 "SET"
#define SEQ_STR                 "SEQ"
#define SNE_STR                 "SNE"
#define SZ_STR                  "SZ"
#define SNZ_STR                 "SNZ"
#define SC_STR                  "SC"
#define SNC_STR                 "SNC"
#define SGT_STR                 "SGT"
#define SLT_STR                 "SLT"
#define SEG_STR                 "SEG"
#define SEL_STR                 "SEL"
#define SO_STR                  "SOV"
#define SNO_STR                 "SNO"

/* Callr e Jmpr */
#define CALLR_STR               "CALLR"
#define JMPR_STR                "JMPR"

/* RTS */
#define RTS_STR                 "RTS"
#define RTI_STR                 "RTI"

/* PUSH & POP */
#define PUSH_STR                "PUSH"
#define POP_STR                 "POP"

#define NOP_STR                 "NOP"
#define HALT_STR                "HALT"
#define BREAKP_STR              "BREAKP"


/* SETC */
#define SETC_STR                "SETC"
#define CLEARC_STR              "CLEARC"


/* Definicoes dos codigos dos registradores */
#define REG0_CODE 0
#define REG1_CODE 1
#define REG2_CODE 2
#define REG3_CODE 3
#define REG4_CODE 4
#define REG5_CODE 5
#define REG6_CODE 6
#define REG7_CODE 7
#define FR_CODE 8
#define SP_CODE 9
/* #define REGZ_CODE 9 */

/* Definicoes dos registradores (binarios em strings) */
#define REG0 "000"
#define REG1 "001"
#define REG2 "010"
#define REG3 "011"
#define REG4 "100"
#define REG5 "101"
#define REG6 "110"
#define REG7 "111"

/* Definicoes das strings de registradores */
#define REG0_STR "R0"
#define REG1_STR "R1"
#define REG2_STR "R2"
#define REG3_STR "R3"
#define REG4_STR "R4"
#define REG5_STR "R5"
#define REG6_STR "R6"
#define REG7_STR "R7"
#define FR_STR   "FR"
#define SP_STR   "SP"
/* #define REGZ_STR "RZ" */

/*

  Modelo de memoria

  Obs.: Este modelo nao precisa ser seguido, mas a
  pseudo-instrucao 'alloc' nao devera ser usada
  neste caso.

  [00000 - 16384] : Programa e variaveis (16kw 32kb)
  [16385 - 24576] : Dados estaticos (8kw 16kb)
  [24577 - 30681] : Dados dinamicos (6kw 12kb)
  [30682]         : System call
  [30683 - 30689] : Folga
  [30690 - 32738] : Stack (2kw 4kb)
  [32739 - 32745] : Folga
  [32746]         : Rx
  [32747]         : Tx
  [32748]         : Timer
  [32749 - 32758] : Argumentos
  [32759]	  : Retorno
  [32760 - 32767] : Interrupcoes

*/

/* Definicoes da memoria */
/* Final do espaco de programa */
#define END_PROGRAM_END                 16384
/* Inicio do espaco de dados estativos (alloc) */
#define END_STATIC_DATA_START           16385
/* Final do espaco de dados estaticos */
#define END_STATIC_DATA_END             24576
/* Inicio do espaco de dados dinamicos */
#define END_DYN_DATA_START              24577
/* Final do espaco de dados dinamicos */
#define END_DYN_DATA_END                30681
/* Final do especo para programas e dados */
#define END_PROGRAM_DATA_END            30681
/* Se escrever neste endereco entao causa interrupcao de sistema */
#define END_SYSTEM_CALL                 30682
/* Pilha (folga de 8 palavras) */
#define END_STACK_END                   30690
#define END_STACK_START                 32738
/* Mapeamento em memoria dos registradores de serial e timer */
#define END_SERIAL_RX                   32746
#define END_SERIAL_TX                   32747
#define END_TIMER_REG                   32748
/* Enderecos de posicoes para passagem de argumentos (ate 10 argumentos) */
#define END_ARG(X)                      ((X) + (32749))
/* Endereco de posicao para retorno de funcoes */
#define END_RET                         32759
/* Enderecos das interrupcoes */
#define END_INTP_TIMER                  32760
#define END_INTP_KEYB                   32761
#define END_INTP_SYST                   32762
#define END_INTP_STACK_OVER             32763
#define END_INTP_STACK_UNDER            32764
#define END_INTP_DIV_BY_ZERO            32765
#define END_INTP_SERIAL                 32766
#define END_INTP_RESET                  32767

/* Strings para labels fixos */
/* Inicio da memoria dinamica */
#define L_DYN_DATA_START_STR            "Dynamic_data_start"
#define L_DYN_DATA_END_STR              "Dynamic_data_end"
/* Chamada do sistema */
#define L_SYSTEM_CALL_STR               "System_call"
/* Pilha */
#define L_STACK_END_STR                 "Stack_end"
#define L_STACK_START_STR               "Stack_start"
/* Registradores mapeados em memoria */
#define L_SERIAL_RX_STR                 "Serial_RX"
#define L_SERIAL_TX_STR                 "Serial_TX"
#define L_TIMER_REG_STR                 "Timer"
/* Argumentos */
#define L_ARG0_STR                      "Arg0"
#define L_ARG1_STR                      "Arg1"
#define L_ARG2_STR                      "Arg2"
#define L_ARG3_STR                      "Arg3"
#define L_ARG4_STR                      "Arg4"
#define L_ARG5_STR                      "Arg5"
#define L_ARG6_STR                      "Arg6"
#define L_ARG7_STR                      "Arg7"
#define L_ARG8_STR                      "Arg8"
#define L_ARG9_STR                      "Arg9"
/* Retorno */
#define L_RET_STR                       "Ret"
/* Interrupcoes */
#define L_INTP_TIMER_STR                "Interrupt_Timer"
#define L_INTP_KEYB_STR                 "Interrupt_Keyboard"
#define L_INTP_SYST_STR                 "Interrupt_System"
#define L_INTP_STACK_OVER_STR           "Interrupt_Stack_Overflow"
#define L_INTP_STACK_UNDER_STR          "Interrupt_Stack_Underflow"
#define L_INTP_DIV_BY_ZERO_STR          "Interrupt_Division_by_zero"
#define L_INTP_SERIAL_STR               "Interrupt_Serial_Ready"
#define L_INTP_RESET_STR                "Interrupt_Reset"

/* Tamanho da memoria */
#define MEM_SIZE 32768

#endif
