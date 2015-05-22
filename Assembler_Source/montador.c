#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "defs.h"
#include "montador.h"
#include "parser.h"
#include "structs.h"

/* *** Externas *** */
extern char Look;

/* *** Globais *** */
unsigned short alloc_cnt = END_STATIC_DATA_START;

/* *** Prototipos Locais *** */
void AdicionarLabelsFixos(void);
void DetectarLabels(void);
void MontarInstrucoes(void);
int BuscaInstrucao(char *);
int BuscaRegistrador(char *);
char * ConverteRegistrador(int);
unsigned short RecebeNumero(void);
unsigned short RecebeEndereco(void);
unsigned short GetBit(unsigned short, unsigned short);
char * NumPBinString(short);
char * NumPBinString4(short);

void Montar(void)
{

    parser_Message("Encontrando labels...");
    AdicionarLabelsFixos();
    DetectarLabels();
    parser_Message("Montando codigo...");
    parser_Write("-- Codigo gerado pelo montador");
    parser_Write("WIDTH=16;");
    parser_Write("DEPTH=32768;"); /* Tamanho da memoria aqui. */
    parser_Write("ADDRESS_RADIX=UNS;");
    parser_Write("DATA_RADIX=BIN;");
    parser_Write("CONTENT BEGIN");
    parser_Message("Inicializando buffer de saida...");
    parser_init_out_buffer();
    MontarInstrucoes();
    parser_Message("Descarregando buffer de saida...");
    parser_flush_program();
    parser_Write("END;");
    parser_Message("Concluido.");

}

void AdicionarLabelsFixos(void)
{
    AddLabel(L_DYN_DATA_START_STR,END_DYN_DATA_START);
    AddLabel(L_DYN_DATA_END_STR,END_DYN_DATA_END);
    AddLabel(L_SYSTEM_CALL_STR,END_SYSTEM_CALL);
    AddLabel(L_STACK_END_STR,END_STACK_END);
    AddLabel(L_STACK_START_STR,END_STACK_START);
    AddLabel(L_SERIAL_RX_STR,END_SERIAL_RX);
    AddLabel(L_SERIAL_TX_STR,END_SERIAL_TX);
    AddLabel(L_TIMER_REG_STR,END_TIMER_REG);
    AddLabel(L_ARG0_STR,END_ARG(0));
    AddLabel(L_ARG1_STR,END_ARG(1));
    AddLabel(L_ARG2_STR,END_ARG(2));
    AddLabel(L_ARG3_STR,END_ARG(3));
    AddLabel(L_ARG4_STR,END_ARG(4));
    AddLabel(L_ARG5_STR,END_ARG(5));
    AddLabel(L_ARG6_STR,END_ARG(6));
    AddLabel(L_ARG7_STR,END_ARG(7));
    AddLabel(L_ARG8_STR,END_ARG(8));
    AddLabel(L_ARG9_STR,END_ARG(9));
    AddLabel(L_RET_STR,END_RET);
    AddLabel(L_INTP_TIMER_STR,END_INTP_TIMER);
    AddLabel(L_INTP_KEYB_STR,END_INTP_KEYB);
    AddLabel(L_INTP_SYST_STR,END_INTP_SYST);
    AddLabel(L_INTP_STACK_OVER_STR,END_INTP_STACK_OVER);
    AddLabel(L_INTP_STACK_UNDER_STR,END_INTP_STACK_UNDER);
    AddLabel(L_INTP_DIV_BY_ZERO_STR,END_INTP_DIV_BY_ZERO);
    AddLabel(L_INTP_SERIAL_STR,END_INTP_SERIAL);
    AddLabel(L_INTP_RESET_STR,END_INTP_RESET);
}

/* Atencao: Uma instrucao por linha e um label por linha apenas! */
void DetectarLabels(void)
{

    parser_Init();
    char * str_tmp;
    char * str_tmp1;
    char str_msg[STRTAM];
    unsigned short end_cnt = 0;
    int op_code = 0;
    unsigned short aux = 0;

    while (Look != EOF)
    {
        str_tmp = parser_GetItem_s();
        op_code = BuscaInstrucao(str_tmp);
        if (op_code == LABEL_CODE)
        {
            parser_Match(':');
            AddLabel(str_tmp,end_cnt);
            sprintf(str_msg,"Label \"%s\" em 0x%x.",str_tmp,end_cnt);
            parser_Message(str_msg);
        }
        else if (op_code == VAR_CODE)
        {
            /* Faz parsing da pseudo-instrucao e pula 'n' enderecos */
            aux = RecebeNumero();
            end_cnt += aux;
        }
        else if (op_code == STRING_CODE)
        {
            /* Faz parsing da string, conta caracteres e pula o numero
               de caracteres + 1. */
            parser_Match_noskip('"');
            while (Look != '"')
            {
                if (Look == '\\')
                {
                    parser_GetChar();
                }
                end_cnt++;
                parser_GetChar();
            }
            parser_Match('"');
            end_cnt++;
        }
        else if (op_code == ALLOC_CODE)
        {
            /*
            alloc Label, #Nr

            Observacoes : alloc aloca, em tempo de montagem, um espaco
               (com base no numero) na parte da memoria para dados estaticos e
               cria um label para este espaco.

               Observacoes : alloc deve receber apenas numeros positivos (unsigned)
            */
            str_tmp1 = parser_GetItem_s();
            AddLabel(str_tmp1,alloc_cnt);
            sprintf(str_msg,"Label \"%s\" em 0x%x.",str_tmp1,alloc_cnt);
            free(str_tmp1);
            parser_Message(str_msg);
            parser_Match(',');
            aux = RecebeNumero();
            alloc_cnt += aux;
            if (alloc_cnt == END_STATIC_DATA_END+1)
                parser_Warning("Alloc ultrapassou o espaco de dados estaticos.");
        }
        else
        {
            /* Se for intrucao entao soma end_cnt
            conforme numero de linhas de endereco
            que esta funcao necessita.

            Tambem pula a declaracao da instrucao. */
            switch (op_code)
            {

            /* Loads e Stores */
            case LOAD_CODE :
            case STORE_CODE :
            case LOADIMED_CODE :
            case STOREIMED_CODE :
                parser_SkipUntil(','); 
                parser_SkipUntilEnd(); 
                end_cnt+=2; 
                break;
            case LOADINDEX_CODE :
            case STOREINDEX_CODE :
            case INPUT_CODE :
            case OUTPUT_CODE :
                parser_SkipUntil(',');
                parser_SkipUntilEnd();
                end_cnt++;
                break;

            /* BRA : instr +- () -> [...] */
            case BRA_CODE :
            case BEQ_CODE :
            case BNE_CODE :
            case BZ_CODE :
            case BNZ_CODE :
            case BC_CODE :
            case BNC_CODE :
            case BGT_CODE :
            case BLT_CODE :
            case BEG_CODE :
            case BEL_CODE :
            case BO_CODE :
            case BNO_CODE :
			    /* BRA nao implementado! */
                parser_Abort("BRA nao implementado!");				
                parser_SkipUntilEnd();
                end_cnt++;
                break;

            /* Instrucoes de 3 argumentos e 1 linha : instr (), (), () -> [...] */
            case ADD_CODE :
            case ADDC_CODE :
            case SUB_CODE :
            case SUBC_CODE :
            case MUL_CODE :
            case DIV_CODE :
	    case LMOD_CODE :	    
            case AND_CODE :
            case OR_CODE :
            case XOR_CODE :
                parser_SkipUntil(',');
                parser_SkipUntil(',');
                parser_SkipUntilEnd();
                end_cnt++;
                break;

            /* Instrucoes de 2 argumentos e 1 linha : instr (), () -> [...] */
            case NOT_CODE :	/* Eu pus aqui pois sera' Rx <- Not Ry */
	    case MOV_CODE :
            case OUTCHAR_CODE :
            case CMP_CODE :
                parser_SkipUntil(',');
                parser_SkipUntilEnd();
                end_cnt++;
                break;

            /* Instrucoes de 1 argumento e 2 linhas : instr () -> [...] + [...] */
            case JMP_CODE :
            case JEQ_CODE :
            case JNE_CODE :
            case JZ_CODE :
            case JNZ_CODE :
            case JC_CODE :
            case JNC_CODE :
            case JGT_CODE :
            case JLT_CODE :
            case JEG_CODE :
            case JEL_CODE :
            case JO_CODE :
            case JNO_CODE :
	    case JDZ_CODE :
	    case JN_CODE :
            case CALL_CODE :
            case CEQ_CODE :
            case CNE_CODE :
            case CZ_CODE :
            case CNZ_CODE :
            case CC_CODE :
            case CNC_CODE :
            case CGT_CODE :
            case CLT_CODE :
            case CEG_CODE :
            case CEL_CODE :
            case CO_CODE :
            case CNO_CODE :
	    case CDZ_CODE :
	    case CN_CODE :
                parser_SkipUntilEnd();
                end_cnt+=2;
                break;

            /* Instrucoes de 1 argumento e 1 linha : instr () -> [...] */
            case INCHAR_CODE :
            case INC_CODE :
            case DEC_CODE :
/*            case NOT_CODE :  */
            case SHIFTL0_CODE :
            case SHIFTL1_CODE :
            case SHIFTR0_CODE :
            case SHIFTR1_CODE :
            case ROTL_CODE :
            case ROTR_CODE :
            case SET_CODE :
            case SEQ_CODE :
            case SNE_CODE :
            case SZ_CODE :
            case SNZ_CODE :
            case SC_CODE :
            case SNC_CODE :
            case SGT_CODE :
            case SLT_CODE :
            case SEG_CODE :
            case SEL_CODE :
            case SO_CODE :
            case SNO_CODE :
            case PUSH_CODE :
            case POP_CODE :
            case CALLR_CODE :
            case JMPR_CODE :
                parser_SkipUntilEnd();
                end_cnt++;
                break;

            /* Instrucoes sem argumentos e 1 linha : instr -> [...] */
            case RTS_CODE :
            case RTI_CODE :
            case HALT_CODE :
            case BREAKP_CODE :	    
            case SETC_CODE :
            case CLEARC_CODE :
            case NOP_CODE :
                end_cnt++;
                break;

            /* Pseudo-instrucoes */
            case STATIC_CODE :
                parser_SkipUntil(',');
                parser_SkipUntilEnd();
                break;
            case EQU_CODE :
                parser_SkipUntilEnd();
                break;

            default :
                parser_Abort("Instrucao invalida!");
                break;
            }
        }
        free(str_tmp);
    }
    parser_Rewind();
}

void MontarInstrucoes(void)
{
    parser_Init();

    char * str_tmp;
    char * str_tmp1;
    char * str_tmp2;
    char * str_tmp3;
    char str_msg[STRTAM];
    unsigned short end_cnt = 0;
    unsigned short aux = 0;
    unsigned short aux2 = 0;
    unsigned short aux3 = 0;
    unsigned short i = 0;
    int op_code = 0;
    int val1;
    int val2;
    int val3;

    while (Look != EOF)
    {

        if (end_cnt == END_PROGRAM_END+1)
            parser_Warning("Espaco para programa ultrapassado!");

        str_tmp = parser_GetItem_s();
        op_code = BuscaInstrucao(str_tmp);
        if (op_code != LABEL_CODE)
        {
            switch (op_code)
            {
                /* ==============
                   Load Rx, End
                   ==============
                */
                
                case LOAD_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    val2 = RecebeEndereco();
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = NumPBinString(val2);
                    sprintf(str_msg,"%s%s0000000",LOAD,str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    free(str_tmp2);
                    break;
                
                /* ==============
                   Store End, Rx
                   ==============
                */
                
                case STORE_CODE :
                    val2 = RecebeEndereco();
                    parser_Match(',');
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = NumPBinString(val2);
                    sprintf(str_msg,"%s%s0000000",STORE,str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    free(str_tmp2);
                    break;

                /* ==============
                   Loadd Rx, #Nr
                   ==============
                */

                case LOADIMED_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    val2 = RecebeNumero();
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = NumPBinString(val2);
                    sprintf(str_msg,"%s%s0000000",LOADIMED,str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    free(str_tmp2);
                    break;

                /* ==============
                   INPUT Rx, Ry
                   ==============
                */
                
                case INPUT_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    sprintf(str_msg,"%s%s%s0000",INPUT,str_tmp1,str_tmp2);
                    free(str_tmp1);
                    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    printf("case INPUT CODE\n");
                    break;
                
                /* ==============
	Loadi Rx, Ry
                   ==============
                */
                
                case LOADINDEX_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    sprintf(str_msg,"%s%s%s0000",LOADINDEX,str_tmp1,str_tmp2);
                    free(str_tmp1);
                    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                
                /* ==============
                   Stored Rx, #Nr
                   ==============
                */
                
                case STOREIMED_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    val2 = RecebeNumero();
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = NumPBinString(val2);
                    sprintf(str_msg,"%s%s0000000",STOREIMED,str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    free(str_tmp2);
                    break;
                    
                /* ==============
                   OUTPUT Rx, Ry
                   ==============
                */
                
                case OUTPUT_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    sprintf(str_msg,"%s%s%s0000",OUTPUT,str_tmp1,str_tmp2);
                    free(str_tmp1);
                    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    printf("case OUTPUT CODE\n");
                    break;
                    
                /* ==============

	Storei Rx, Ry
                   ==============
                */
                
                case STOREINDEX_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    sprintf(str_msg,"%s%s%s0000",STOREINDEX,str_tmp1,str_tmp2);
                    free(str_tmp1);
                    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Mov Rx, Ry
                   ==============
                */
                
                case MOV_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
		    if(val1 == SP_CODE){
			str_tmp2 = ConverteRegistrador(val2);
			sprintf(str_msg,"%s%s0000011",MOV,str_tmp2);
			free(str_tmp2);
			}
		    else if(val2 == SP_CODE){
			str_tmp1 = ConverteRegistrador(val1);
			sprintf(str_msg,"%s%s0000001",MOV,str_tmp1);
			free(str_tmp1);
			}
		    else {
			str_tmp1 = ConverteRegistrador(val1);
			str_tmp2 = ConverteRegistrador(val2);
			sprintf(str_msg,"%s%s%s0000",MOV,str_tmp1,str_tmp2);
			free(str_tmp1);
			free(str_tmp2);
			}
		    
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;                    

                /* ==============
                   Outchar Rx, Ry
                   ==============
                */

                case OUTCHAR_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    sprintf(str_msg,"%s%s%s0000",OUTCHAR,str_tmp1,str_tmp2);
                    free(str_tmp1);
                    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Inchar Rx
                   ==============
                */

                case INCHAR_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s0000000",INCHAR,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Add Rx, Ry, Rz
                   ==============
                */

                case ADD_CODE :
                    str_tmp1 = parser_GetItem_s(); /* ADD sem carry */
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s0",ADD,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Addc Rx, Ry, Rz
                   ==============
                */

                case ADDC_CODE :
                    str_tmp1 = parser_GetItem_s(); /* ADD com carry */
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s1",ADD,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Sub Rx, Ry, Rz
                   ==============
                */

                case SUB_CODE :
                    str_tmp1 = parser_GetItem_s(); /* SUB sem carry */
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s0",SUB,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Subc Rx, Ry, Rz
                   ==============
                */

                case SUBC_CODE :
                    str_tmp1 = parser_GetItem_s(); /* SUB com carry */
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s1",SUB,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Mul Rx, Ry, Rz
                   ==============
                */

                case MUL_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s0",MUL,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Div Rx, Ry, Rz
                   ==============
                */

                case DIV_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s0",DIV,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Inc Rx
                   Observacoes: Inc nao funcionara corretamente para nos. complemento de 2.
                   ==============
                */

                case INC_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s0000000",INC,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Dec Rx
                   Observacoes: Dec nao funcionara corretamente para nos. complemento de 2.
                   ==============
                */

                case DEC_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s1000000",INC,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   And Rx, Ry, Rz
                   ==============
                */

                case AND_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s0",LAND,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
	Mod Rx, Ry, Rz
                   ==============
                */

                case LMOD_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s0",LMOD,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============                   
	Or Rx, Ry, Rz
                   ==============
                */

                case OR_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s0",LOR,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Xor Rx, Ry, Rz
                   ==============
                */

                case XOR_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    parser_Match(',');
                    str_tmp3 = parser_GetItem_s();
                    val3 = BuscaRegistrador(str_tmp3);
                    free(str_tmp3);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    str_tmp3 = ConverteRegistrador(val3);
                    sprintf(str_msg,"%s%s%s%s0",LXOR,str_tmp1,str_tmp2,str_tmp3);
                    free(str_tmp1);
                    free(str_tmp2);
                    free(str_tmp3);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;

                /* ==============
                   Not Rx Ry
                   ==============
                */
               
                case NOT_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    sprintf(str_msg,"%s%s%s0000",LNOT,str_tmp1,str_tmp2);
                    free(str_tmp1);
                    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;                    

                /* ==============
   
   
   
   
   
                Shiftl0 Rx, #n
                   ==============
                */
                
                case SHIFTL0_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);		    
		    
		    parser_Match(',');
                    val2 = RecebeNumero();
                    str_tmp2 = NumPBinString4(val2);
		    
                    sprintf(str_msg,"%s%s000%s",SHIFT,str_tmp1,str_tmp2);
                    free(str_tmp1);
		    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Shiftl1 Rx, #n
                   ==============
                */
                
                case SHIFTL1_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);		    
		    
		    parser_Match(',');
                    val2 = RecebeNumero();
                    str_tmp2 = NumPBinString4(val2);
		    
                    sprintf(str_msg,"%s%s001%s",SHIFT,str_tmp1,str_tmp2);
                    free(str_tmp1);
		    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Shiftr0 Rx, #n
                   ==============
                */
                
                case SHIFTR0_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);		    
		    
		    parser_Match(',');
                    val2 = RecebeNumero();
                    str_tmp2 = NumPBinString4(val2);
		    
                    sprintf(str_msg,"%s%s010%s",SHIFT,str_tmp1,str_tmp2);
                    free(str_tmp1);
		    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Shiftr1 Rx, #n
                   ==============
                */
                
                case SHIFTR1_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);		    
		    
		    parser_Match(',');
                    val2 = RecebeNumero();
                    str_tmp2 = NumPBinString4(val2);
		    
                    sprintf(str_msg,"%s%s011%s",SHIFT,str_tmp1,str_tmp2);
                    free(str_tmp1);
		    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Rotl Rx, #n
                   ==============
                */
                
                case ROTL_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);		    
		    
		    parser_Match(',');
                    val2 = RecebeNumero();
                    str_tmp2 = NumPBinString4(val2);
		    
                    sprintf(str_msg,"%s%s100%s",SHIFT,str_tmp1,str_tmp2);
                    free(str_tmp1);
		    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Rotr Rx, #n
                   ==============
                */
                
                case ROTR_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);		    
		    
		    parser_Match(',');
                    val2 = RecebeNumero();
                    str_tmp2 = NumPBinString4(val2);
		    
                    sprintf(str_msg,"%s%s110%s",SHIFT,str_tmp1,str_tmp2);
                    free(str_tmp1);
		    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Cmp Rx, Ry, #n
                   ==============
                */
                
                case CMP_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    parser_Match(',');
                    str_tmp2 = parser_GetItem_s();
                    val2 = BuscaRegistrador(str_tmp2);
                    free(str_tmp2);
                    str_tmp1 = ConverteRegistrador(val1);
                    str_tmp2 = ConverteRegistrador(val2);
                    sprintf(str_msg,"%s%s%s0000",CMP,str_tmp1,str_tmp2);
                    free(str_tmp1);
                    free(str_tmp2);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Bra +/- T
                   ==============
                */
                
                case BRA_CODE :
                    
                /* ==============
                   Beq +/- T
                   ==============
                */
                
                case BEQ_CODE :
                    
                /* ==============
                   Bne +/- T
                   ==============
                */
                
                case BNE_CODE :
                    
                /* ==============
                   Bz +/- T
                   ==============
                */
                
                case BZ_CODE :
                
                /* ==============
                   Bnz +/- T
                   ==============
                */
                
                case BNZ_CODE :
                
                /* ==============
                   Bc +/- T
                   ==============
                */
                
                case BC_CODE :
                
                /* ==============
                   Bnc +/- T
                   ==============
                */
                
                case BNC_CODE :
                
                /* ==============
                   Bgt +/- T
                   ==============
                */
                
                case BGT_CODE :
                
                /* ==============
                   Blt +/- T
                   ==============
                */
                
                case BLT_CODE :
                
                /* ==============
                   Beg +/- T
                   ==============
                */
                
                case BEG_CODE :
                
                /* ==============
                   Bel +/- T
                   ==============
                */
                
                case BEL_CODE :
                
                /* ==============
                   Bo +/- T
                   ==============
                */
                
                case BO_CODE :
                
                /* ==============
                   Bno +/- T
                   ==============
                */
                
                case BNO_CODE :

                /* ==============
                   Jmp End
                   ==============
                */
                
                case JMP_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,NO_COND);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Jeq End
                   ==============
                */
                
                case JEQ_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_EQ);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Jne End
                   ==============
                */
                
                case JNE_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_NE);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Jz End
                   ==============
                */
                
                case JZ_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_Z);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Jnz End
                   ==============
                */
                
                case JNZ_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_NZ);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Jc End
                   ==============
                */
                
                case JC_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_C);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Jnc End
                   ==============
                */
                
                case JNC_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_NC);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Jgt End
                   ==============
                */
                
                case JGT_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_GT);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Jlt End
                   ==============
                */
                
                case JLT_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_LT);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Jeg End
                   ==============
                */
                
                case JEG_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_EG);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Jel End
                   ==============
                */
                
                case JEL_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_EL);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Jo End
                   ==============
                */
                
                case JO_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_O);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Jno End
                   ==============
                */
                
                case JNO_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_NO);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;

                /* ==============
                   Jdz End
                   ==============
                */
                
                case JDZ_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_DZ);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;

                /* ==============
                   Jn End
                   ==============
                */
                
                case JN_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",JMP,COND_N);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;

                /* ==============		
                   Call End
                   ==============
                */
                
                case CALL_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,NO_COND);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Ceq End
                   ==============
                */
                
                case CEQ_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_EQ);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Cne End
                   ==============
                */
                
                case CNE_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_NE);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Cz End
                   ==============
                */
                
                case CZ_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_Z);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Cnz End
                   ==============
                */
                
                case CNZ_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_NZ);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Cc End
                   ==============
                */
                
                case CC_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_C);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Cnc End
                   ==============
                */
                
                case CNC_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_NC);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Cgt End
                   ==============
                */
                
                case CGT_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_GT);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Clt End
                   ==============
                */
                
                case CLT_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_LT);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Ceg End
                   ==============
                */
                
                case CEG_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_EG);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Cel End
                   ==============
                */
                
                case CEL_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_EL);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Co End
                   ==============
                */
                
                case CO_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_O);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                
                /* ==============
                   Cno End
                   ==============
                */
                
                case CNO_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_NO);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Cdz End
                   ==============
                */
                
                case CDZ_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_DZ);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============
                   Cn End
                   ==============
                */
                
                case CN_CODE :
                    val1 = RecebeEndereco();
                    str_tmp1 = NumPBinString(val1);
                    sprintf(str_msg,"%s%s000000",CALL,COND_N);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    sprintf(str_msg,"%s",str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt +=1;
                    free(str_tmp1);
                    break;
                    
                /* ==============		
                   Set Rz
                   ==============
                */
                
                case SET_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,NO_COND,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Seq Rz
                   ==============
                */
                
                case SEQ_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_EQ,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Sne Rz
                   ==============
                */
                
                case SNE_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_NE,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Sz Rz
                   ==============
                */
                
                case SZ_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_Z,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Snz Rz
                   ==============
                */
                
                case SNZ_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_NZ,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                
                /* ==============
                   Sc Rz
                   ==============
                */
                
                case SC_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_C,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Snc Rz
                   ==============
                */
                
                case SNC_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_NC,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                
                /* ==============
                   Sgt Rz
                   ==============
                */
                
                case SGT_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_GT,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                
                /* ==============
                   Slt Rz
                   ==============
                */
                
                case SLT_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_LT,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                
                /* ==============
                   Seg Rz
                   ==============
                */
                
                case SEG_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_EG,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Sel Rz
                   ==============
                */
                
                case SEL_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_EL,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   So Rz
                   ==============
                */
                
                case SO_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_O,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                
                /* ==============
                   Sno Rz
                   ==============
                */
                
                case SNO_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s00%s0",SET,COND_NO,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                
                /* ==============
                   Rts
                   ==============
                */
                
                case RTS_CODE :
                    sprintf(str_msg,"%s0000000000",RTS);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Rti
                   ==============
                */
                
                case RTI_CODE :
                    sprintf(str_msg,"%s0000000000",RTI);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Push Rx
                   ==============
                */
                
                case PUSH_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
		    
		    if(val1 == FR_CODE)
			sprintf(str_msg,"%s0001000000",PUSH);
		    else {
			str_tmp1 = ConverteRegistrador(val1);
			sprintf(str_msg,"%s%s0000000",PUSH,str_tmp1);
			free(str_tmp1);
			}
  		    parser_Write_Inst(str_msg,end_cnt);
		    end_cnt += 1;
                    break;
                    
                /* ==============
                   Pop Rx
                   ==============
                */
                    
                case POP_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
		    
		    if(val1 == FR_CODE)
			sprintf(str_msg,"%s0001000000",POP);
		    else {
			str_tmp1 = ConverteRegistrador(val1);
			sprintf(str_msg,"%s%s0000000",POP,str_tmp1);
			free(str_tmp1);
			}
		    parser_Write_Inst(str_msg,end_cnt);
		    end_cnt += 1;
                    break;
                
                /* ==============
                   Halt
                   ==============
                */

                case HALT_CODE :
                    sprintf(str_msg,"%s0000000000",HALT);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                  Breakp
                   ==============
                */

                case BREAKP_CODE :
                    sprintf(str_msg,"%s0000000000",BREAKP);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============		
                   Setc
                   ==============
                */
                
                case SETC_CODE :
                    sprintf(str_msg,"%s1000000000",CLEARC);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Clearc
                   ==============
                */
                
                case CLEARC_CODE :
                    sprintf(str_msg,"%s0000000000",CLEARC);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Callr Rx
                   ==============
                */
                
                case CALLR_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s0000000",CALLR,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Jmpr Rx
                   ==============
                */
                
                case JMPR_CODE :
                    str_tmp1 = parser_GetItem_s();
                    val1 = BuscaRegistrador(str_tmp1);
                    free(str_tmp1);
                    str_tmp1 = ConverteRegistrador(val1);
                    sprintf(str_msg,"%s%s0000000",JMPR,str_tmp1);
                    free(str_tmp1);
                    parser_Write_Inst(str_msg,end_cnt);
                    end_cnt += 1;
                    break;
                    
                /* ==============
                   Nop
                   ==============
                */

                case NOP_CODE :
                    parser_Write_Inst("0000000000000000",end_cnt);
                    end_cnt+=1;
                    break;

                /* Pseudo-Instrucoes */

                /* ==============
                   Var #Nr
                   Observacoes : Var so deve receber numeros positivos (nao utilize Labels!)
                   ==============
                */
                case VAR_CODE :
                    aux = RecebeNumero();
                    for (i = 0; i < aux; i++)
                        parser_Write_Inst("0000000000000000",end_cnt+i);
                    end_cnt += aux;
                    break;

                /* ==============
                   String "..."
                   Observacoes : Pseudo-instrucao que copia a string nesta regiao da memoria.
                   ==============
                */
                case STRING_CODE :
                    parser_Match_noskip('"');
                    i = 0;
                    while (Look != '"')
                    {
                        if (Look == '\\')
                        {
                            parser_Match('\\');
                            switch (Look)
                            {
                            case 'n' :
                                str_tmp1 = NumPBinString((unsigned short)'\n');
                                break;
                            case '0' :
                                str_tmp1 = NumPBinString((unsigned short)'\0');
                                break;
                            case '\\' :
                                str_tmp1 = NumPBinString((unsigned short)'\\');
                                break;
						    case '\"' :
								str_tmp1 = NumPBinString((unsigned short)'\"');
                            default :
                                parser_Abort("Caractere invalido na string!.");
                                break;
                            }
                            parser_Write_Inst(str_tmp1,end_cnt+i);
                            free(str_tmp1);
                            parser_GetChar();
                        }
                        else
                        {
                            str_tmp1 = NumPBinString((unsigned short)Look);
                            parser_Write_Inst(str_tmp1,end_cnt+i);
                            free(str_tmp1);
                            parser_GetChar();
                        }
                        i++;
                    }
                    parser_Match('"');
                    str_tmp1 = NumPBinString((unsigned short)'\0');
                    parser_Write_Inst(str_tmp1,end_cnt+i);
                    free(str_tmp1);
                    i++;
                    end_cnt+=i;
                    break;

                /* ==============
                   Static End, #Nr
                   ou
                   Static End + #Nr, #Nr

                   Observacoes : Endereco indicado recebera o valor indicado pelo numero.
                   Atencao : A montagem do programa pode acabar sobre-escrevendo este
                             endereco com outro valor. Utilize preferencialmente para regioes
                             fora do espaco do programa.
                   ==============
                */

                case STATIC_CODE :
                    aux = RecebeEndereco();
                    if (Look == '+')
                    {
                        parser_Match('+');
                        aux3 = RecebeNumero();
                        aux += aux3;
                    }
                    parser_Match(',');
                    aux2 = RecebeNumero();
                    str_tmp1 = NumPBinString(aux2);
                    parser_Write_Inst(str_tmp1,aux);
                    free(str_tmp1);
                    break;

                /* ==============
                   Alloc Label, #Nr
                   Observacoes : Veja descricao na deteccao de labels.
                   ==============
                */

                case ALLOC_CODE :
                    parser_SkipUntil(',');
                    parser_SkipUntilEnd();
                    break;

                default :
                    parser_SkipUntilEnd();
                    parser_Warning("Instrucao invalida!");
                    break;
            }
        }
        else if (op_code == LABEL_CODE) parser_Match(':');
        free(str_tmp);
    }
}

int BuscaInstrucao(char * nome)
{
    char str_tmp[STRTAM];
    strcpy(str_tmp,nome); /* Faz copia para nao alterar string original. */
    parser_str_to_upper(str_tmp);
    /* Busca nome de instrucao na base de instrucoes,
    se contrar retorna 'op_code interno' da instrucao,
    se nao encontrar entao retorna 'op_code' de label.
    */

    if (strcmp(str_tmp,LOAD_STR) == 0)
    {
        return LOAD_CODE;
    }
	else if(strcmp(str_tmp,LOADIMED_STR) == 0) 
	{
		return LOADIMED_CODE;
	}
	else if(strcmp(str_tmp,LOADINDEX_STR) == 0) 
	{
		return LOADINDEX_CODE;
	}
	else if(strcmp(str_tmp,INPUT_STR) == 0) 
	{
		return INPUT_CODE;
	}
	else if(strcmp(str_tmp,OUTPUT_STR) == 0) 
	{
		return OUTPUT_CODE;
	}
    else if (strcmp(str_tmp,STORE_STR) == 0)
    {
        return STORE_CODE;
    }
    else if (strcmp(str_tmp,STOREIMED_STR) == 0)
    {
        return STOREIMED_CODE;
    }
    else if (strcmp(str_tmp,STOREINDEX_STR) == 0)
    {
        return STOREINDEX_CODE;
    }
    else if (strcmp(str_tmp,MOV_STR) == 0)
    {
        return MOV_CODE;
    }
    else if (strcmp(str_tmp,INCHAR_STR) == 0)
    {
        return INCHAR_CODE;
    }
    else if (strcmp(str_tmp,OUTCHAR_STR) == 0)
    {
        return OUTCHAR_CODE;
    }
    else if (strcmp(str_tmp,ADD_STR) == 0)
    {
        return ADD_CODE;
    }
    else if (strcmp(str_tmp,ADDC_STR) == 0)
    {
        return ADDC_CODE;
    }
    else if (strcmp(str_tmp,SUB_STR) == 0)
    {
        return SUB_CODE;
    }
    else if (strcmp(str_tmp,SUBC_STR) == 0)
    {
        return SUBC_CODE;
    }
    else if (strcmp(str_tmp,MUL_STR) == 0)
    {
        return MUL_CODE;
    }
    else if (strcmp(str_tmp,DIV_STR) == 0)
    {
        return DIV_CODE;
    }
    else if (strcmp(str_tmp,INC_STR) == 0)
    {
        return INC_CODE;
    }
    else if (strcmp(str_tmp,DEC_STR) == 0)
    {
        return DEC_CODE;
    }
    else if (strcmp(str_tmp,LMOD_STR) == 0)
    {
        return LMOD_CODE;
    }
    else if (strcmp(str_tmp,AND_STR) == 0)
    {
        return AND_CODE;
    }
    else if (strcmp(str_tmp,OR_STR) == 0)
    {
        return OR_CODE;
    }
    else if (strcmp(str_tmp,XOR_STR) == 0)
    {
        return XOR_CODE;
    }
    else if (strcmp(str_tmp,NOT_STR) == 0)
    {
        return NOT_CODE;
    }
    else if (strcmp(str_tmp,SHIFTL0_STR) == 0)
    {
        return SHIFTL0_CODE;
    }
    else if (strcmp(str_tmp,SHIFTL1_STR) == 0)
    {
        return SHIFTL1_CODE;
    }
    else if (strcmp(str_tmp,SHIFTR0_STR) == 0)
    {
        return SHIFTR0_CODE;
    }
    else if (strcmp(str_tmp,SHIFTR1_STR) == 0)
    {
        return SHIFTR1_CODE;
    }
    else if (strcmp(str_tmp,ROTL_STR) == 0)
    {
        return ROTL_CODE;
    }
    else if (strcmp(str_tmp,ROTR_STR) == 0)
    {
        return ROTR_CODE;
    }
    else if (strcmp(str_tmp,CMP_STR) == 0)
    {
        return CMP_CODE;
    }
    else if (strcmp(str_tmp,BRA_STR) == 0)
    {
        return BRA_CODE;
    }
    else if (strcmp(str_tmp,BEQ_STR) == 0)
    {
        return BEQ_CODE;
    }
    else if (strcmp(str_tmp,BNE_STR) == 0)
    {
        return BNE_CODE;
    }
    else if (strcmp(str_tmp,BZ_STR) == 0)
    {
        return BZ_CODE;
    }
    else if (strcmp(str_tmp,BNZ_STR) == 0)
    {
        return BNZ_CODE;
    }
    else if (strcmp(str_tmp,BC_STR) == 0)
    {
        return BC_CODE;
    }
    else if (strcmp(str_tmp,BNC_STR) == 0)
    {
        return BNC_CODE;
    }
    else if (strcmp(str_tmp,BGT_STR) == 0)
    {
        return BGT_CODE;
    }
    else if (strcmp(str_tmp,BLT_STR) == 0)
    {
        return BLT_CODE;
    }
    else if (strcmp(str_tmp,BEG_STR) == 0)
    {
        return BEG_CODE;
    }
    else if (strcmp(str_tmp,BEL_STR) == 0)
    {
        return BEL_CODE;
    }
    else if (strcmp(str_tmp,BO_STR) == 0)
    {
        return BO_CODE;
    }
    else if (strcmp(str_tmp,BNO_STR) == 0)
    {
        return BNO_CODE;
    }
    else if (strcmp(str_tmp,JMP_STR) == 0)
    {
        return JMP_CODE;
    }
    else if (strcmp(str_tmp,JEQ_STR) == 0)
    {
        return JEQ_CODE;
    }
    else if (strcmp(str_tmp,JNE_STR) == 0)
    {
        return JNE_CODE;
    }
    else if (strcmp(str_tmp,JZ_STR) == 0)
    {
        return JZ_CODE;
    }
    else if (strcmp(str_tmp,JNZ_STR) == 0)
    {
        return JNZ_CODE;
    }
    else if (strcmp(str_tmp,JC_STR) == 0)
    {
        return JC_CODE;
    }
    else if (strcmp(str_tmp,JNC_STR) == 0)
    {
        return JNC_CODE;
    }
    else if (strcmp(str_tmp,JGT_STR) == 0)
    {
        return JGT_CODE;
    }
    else if (strcmp(str_tmp,JLT_STR) == 0)
    {
        return JLT_CODE;
    }
    else if (strcmp(str_tmp,JEG_STR) == 0)
    {
        return JEG_CODE;
    }
    else if (strcmp(str_tmp,JEL_STR) == 0)
    {
        return JEL_CODE;
    }
    else if (strcmp(str_tmp,JO_STR) == 0)
    {
        return JO_CODE;
    }
    else if (strcmp(str_tmp,JNO_STR) == 0)
    {
        return JNO_CODE;
    }
    else if (strcmp(str_tmp,JN_STR) == 0)
    {
        return JN_CODE;
    }
    else if (strcmp(str_tmp,JDZ_STR) == 0)
    {
        return JDZ_CODE;
    }
    else if (strcmp(str_tmp,CALL_STR) == 0)
    {
        return CALL_CODE;
    }
    else if (strcmp(str_tmp,CEQ_STR) == 0)
    {
        return CEQ_CODE;
    }
    else if (strcmp(str_tmp,CNE_STR) == 0)
    {
        return CNE_CODE;
    }
    else if (strcmp(str_tmp,CZ_STR) == 0)
    {
        return CZ_CODE;
    }
    else if (strcmp(str_tmp,CNZ_STR) == 0)
    {
        return CNZ_CODE;
    }
    else if (strcmp(str_tmp,CC_STR) == 0)
    {
        return CC_CODE;
    }
    else if (strcmp(str_tmp,CNC_STR) == 0)
    {
        return CNC_CODE;
    }
    else if (strcmp(str_tmp,CGT_STR) == 0)
    {
        return CGT_CODE;
    }
    else if (strcmp(str_tmp,CLT_STR) == 0)
    {
        return CLT_CODE;
    }
    else if (strcmp(str_tmp,CEG_STR) == 0)
    {
        return CEG_CODE;
    }
    else if (strcmp(str_tmp,CEL_STR) == 0)
    {
        return CEL_CODE;
    }
    else if (strcmp(str_tmp,CO_STR) == 0)
    {
        return CO_CODE;
    }
    else if (strcmp(str_tmp,CNO_STR) == 0)
    {
        return CNO_CODE;
    }
    else if (strcmp(str_tmp,CN_STR) == 0)
    {
        return CN_CODE;
    }
    else if (strcmp(str_tmp,CDZ_STR) == 0)
    {
        return CDZ_CODE;
    }
    else if (strcmp(str_tmp,SET_STR) == 0)
    {
        return SET_CODE;
    }
    else if (strcmp(str_tmp,SEQ_STR) == 0)
    {
        return SEQ_CODE;
    }
    else if (strcmp(str_tmp,SNE_STR) == 0)
    {
        return SNE_CODE;
    }
    else if (strcmp(str_tmp,SZ_STR) == 0)
    {
        return SZ_CODE;
    }
    else if (strcmp(str_tmp,SNZ_STR) == 0)
    {
        return SNZ_CODE;
    }
    else if (strcmp(str_tmp,SC_STR) == 0)
    {
        return SC_CODE;
    }
    else if (strcmp(str_tmp,SNC_STR) == 0)
    {
        return SNC_CODE;
    }
    else if (strcmp(str_tmp,SGT_STR) == 0)
    {
        return SGT_CODE;
    }
    else if (strcmp(str_tmp,SLT_STR) == 0)
    {
        return SLT_CODE;
    }
    else if (strcmp(str_tmp,SEG_STR) == 0)
    {
        return SEG_CODE;
    }
    else if (strcmp(str_tmp,SEL_STR) == 0)
    {
        return SEL_CODE;
    }
    else if (strcmp(str_tmp,SO_STR) == 0)
    {
        return SO_CODE;
    }
    else if (strcmp(str_tmp,SNO_STR) == 0)
    {
        return SNO_CODE;
    }
    else if (strcmp(str_tmp,RTS_STR) == 0)
    {
        return RTS_CODE;
    }
    else if (strcmp(str_tmp,RTI_STR) == 0)
    {
        return RTI_CODE;
    }
    else if (strcmp(str_tmp,PUSH_STR) == 0)
    {
        return PUSH_CODE;
    }
    else if (strcmp(str_tmp,POP_STR) == 0)
    {
        return POP_CODE;
    }
    else if (strcmp(str_tmp,HALT_STR) == 0)
    {
        return HALT_CODE;
    }	
    else if (strcmp(str_tmp,BREAKP_STR) == 0)
    {
        return BREAKP_CODE;	
    }
    else if (strcmp(str_tmp,SETC_STR) == 0)
    {
        return SETC_CODE;
    }
    else if (strcmp(str_tmp,CLEARC_STR) == 0)
    {
        return CLEARC_CODE;
    }
    else if (strcmp(str_tmp,CALLR_STR) == 0)
    {
        return CALLR_CODE;
    }
    else if (strcmp(str_tmp,JMPR_STR) == 0)
    {
        return JMPR_CODE;
    }
    else if (strcmp(str_tmp,NOP_STR) == 0)
    {
        return NOP_CODE;
    }

    /* Pseudo-instrucoes */
    else if (strcmp(str_tmp,EQU_STR) == 0)
    {
        return EQU_CODE;
    }
    else if (strcmp(str_tmp,VAR_STR) == 0)
    {
        return VAR_CODE;
    }
    else if (strcmp(str_tmp,STATIC_STR) == 0)
    {
        return STATIC_CODE;
    }
    else if (strcmp(str_tmp,STRING_STR) == 0)
    {
        return STRING_CODE;
    }
    else if (strcmp(str_tmp,ALLOC_STR) == 0)
    {
        return ALLOC_CODE;
    }

    return LABEL_CODE;
}

int BuscaRegistrador(char * nome)
{
    parser_str_to_upper(nome);
    /* Retorna codigo do registrador, dependendo do texto
    (poderá ser Rx, rx ou texto de EQU de registrador) */
    if (strcmp(nome,REG0_STR) == 0)
    {
        return REG0_CODE;
    }
    else if (strcmp(nome,REG1_STR) == 0)
    {
        return REG1_CODE;
    }
    else if (strcmp(nome,REG2_STR) == 0)
    {
        return REG2_CODE;
    }
    else if (strcmp(nome,REG3_STR) == 0)
    {
        return REG3_CODE;
    }
    else if (strcmp(nome,REG4_STR) == 0)
    {
        return REG4_CODE;
    }
    else if (strcmp(nome,REG5_STR) == 0)
    {
        return REG5_CODE;
    }
    else if (strcmp(nome,REG6_STR) == 0)
    {
        return REG6_CODE;
    }
    else if (strcmp(nome,REG7_STR) == 0)
    {
        return REG7_CODE;
    }
    else if (strcmp(nome,FR_STR) == 0)
    {
        return FR_CODE;
    }
    else if (strcmp(nome,SP_STR) == 0)
    {
        return SP_CODE;
    }
    else
    {
        /* Busca EQU. Se nao encontrar, entao retorna erro. */
        /* IMPLEMENTE-ME */
        parser_Abort("Registrador invalido!");  /* <- remover esta linha */
    }
    return -1;
}

char * ConverteRegistrador(int num)
{
    char * ret = calloc(4,sizeof(char));
    switch (num)
    {
    case REG0_CODE :
        strcpy(ret,REG0);
        break;
    case REG1_CODE :
        strcpy(ret,REG1);
        break;
    case REG2_CODE :
        strcpy(ret,REG2);
        break;
    case REG3_CODE :
        strcpy(ret,REG3);
        break;
    case REG4_CODE :
        strcpy(ret,REG4);
        break;
    case REG5_CODE :
        strcpy(ret,REG5);
        break;
    case REG6_CODE :
        strcpy(ret,REG6);
        break;
    case REG7_CODE :
        strcpy(ret,REG7);
        break;
    default :
        parser_Abort("Registrador invalido!");
    }
    ret[3] = '\0';
    return ret;
}

unsigned short RecebeNumero(void)
{

    unsigned short ret;
    char * str_tmp;

    if (Look == '#')
    {
        parser_Match('#');
        if (parser_IsDigit(Look))  /* Numero : #1234 (unsigned) */
        {
            str_tmp = parser_GetNum_s();
            ret = atoi(str_tmp);
            free(str_tmp);
            return ret;
        }
        else if (Look == '-' || Look == '+')  /* Numero com complemento de 2 : #+1234 ou #-1234 */
        {
            /* IMPLEMENTE-ME (com complemento de 2) */
        }
        else if (Look == 39)  /* Char : #'a' */
        {
            parser_Match_noskip(39);
            if (Look == '\\')  /* Char especial : #'\n' */
            {
                parser_Match('\\');
                switch (Look)
                {
                case 'n' :
                    ret = (unsigned short)'\n';
                    break;
                case 'L' :
                    ret = (unsigned short) 14;
                    break;
                case 'R' :
                    ret = (unsigned short) 15;
                    break;
                case 'U' :
                    ret = (unsigned short) 16;
                    break;
                case 'D' :
                    ret = (unsigned short) 17;
                    break;
                case '0' :
                    ret = (unsigned short)'\0';
                    break;
                case '\\' :
                    ret = (unsigned short)'\\';
                    break;
                default :
                    parser_Abort("Caractere invalido.");
                    break;
                }
                parser_GetChar();
                parser_Match(39);
                return ret;
            }
            else   /* Char normal : #'a' */
            {
                ret = (unsigned short) Look;
				// comentado para fazer com que #'a' seja o numero ASCII
				//ret = ret & 0x3f;  /* Tira os 2 bits mais significativos que e' a COR do caractere */
                parser_GetChar();
                parser_Match(39);
                return ret;
            }
        }
        else   /* Label : #Var */
        {
            str_tmp = parser_GetItem_s();
            ret = FindLabel(str_tmp);
            free(str_tmp);
            return ret;
        }
    }
    else if (parser_IsAlNum(Look))  /* EQU : X */
    {
        /* IMPLEMENTE-ME */
        parser_Abort("Numero esperado."); /* <- remover esta linha */
    }
    else
    {
        parser_Abort("Numero esperado.");
    }
    return 0;
}

unsigned short GetBit(unsigned short num, unsigned short pos)
{
    unsigned short bitmask = (1 << pos);
    return (num & bitmask) ? 1 : 0;
}

char * NumPBinString(short num)
{
    /* Converte numero para string de binarios */
    char * ret = calloc(17,sizeof(char));
    unsigned short digitos[16];

    if (ret == NULL) parser_Error("Memoria insuficiente para alocacao!");
    unsigned short i = 15;

    for (i = 0; i < 16; i++)
    {
        digitos[15-i] = GetBit((unsigned short)num,i);
    }

    for (i = 0; i < 16; i++)
    {
        ret[i] = (digitos[i] == 1) ? '1' : '0';
    }
    ret[16] = '\0';

    return ret;
}

char * NumPBinString4(short num)
{
    /* Converte numero para string de binarios com 4 bits */
    char * ret = calloc(5,sizeof(char));
    unsigned short digitos[4];

    if (ret == NULL) parser_Error("Memoria insuficiente para alocacao!");
    unsigned short i = 3;

    if (num > 15) parser_Error("Shift Rx, N com N maior que 15!");
    
    for (i = 0; i < 4; i++)
    {
        digitos[3-i] = GetBit((unsigned short)num,i);
    }

    for (i = 0; i < 4; i++)
    {
        ret[i] = (digitos[i] == 1) ? '1' : '0';
    }
    ret[4] = '\0';

    return ret;
}

unsigned short RecebeEndereco(void)
{

    unsigned short ret;
    char * str_tmp;

    if (parser_IsDigit(Look))  /* ATENCAO! Labels e EQU nao podem comecar com numeros!!! */
    {
        str_tmp = parser_GetNum_s();
        ret = atoi(str_tmp);
        free(str_tmp);
        return ret;
    }
    else   /* EQU : X ou Label : Var */
    {
        str_tmp = parser_GetItem_s();
        /* Busca EQU, se nao encontrar, busca Label */
        ret = FindLabel(str_tmp);
        free(str_tmp);
        return ret;
    }
    return 0;
}
