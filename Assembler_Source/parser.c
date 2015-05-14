#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.h"
#include "structs.h"
#include "defs.h"

extern FILE *out; /* Codigo de saida */
extern FILE *in; /* Codigo de entrada */

char Look; /* Ultimo caractere lido */
int curr_pos = 0; /* Posicao atual */
int curr_line = 0; /* Linha atual */
char * progr_buffer; /* String completa do programa */

char progr_buffer_out[MEM_SIZE][17]; /* Buffer de saida */

int CarregaPrograma(char *nome)
{
    in = fopen(nome,"r");
    if (in == NULL) parser_Abort("Nao foi possivel carregar o arquivo de programa.");

    progr_buffer = (char *)malloc((MAX_BUFF_SIZE+1)*sizeof(char));

    if (progr_buffer == NULL) parser_Abort("Memoria insuficiente para buffer do programa!");

    int i;

    for (i=0;i<=MAX_BUFF_SIZE;i++) progr_buffer[i]='\0';

    i=0;
    while (!feof(in) && i<MAX_BUFF_SIZE)
    {
        progr_buffer[i]=fgetc(in);
        i++;
    }

    fclose(in);

    return i;

}

void parser_Rewind(void)
{
    curr_pos = 0;
    curr_line = 0; /* Contagem de linhas nao e precisa. */
}

void parser_Message(char *s)
{
    printf("Mensagem (%d): %s\n",curr_line,s);
}

void parser_Warning(char *s)
{
    printf("Aviso (%d): %s\n",curr_line,s);
}

void parser_Halt(void)
{
#ifndef __linux__
    system("pause");
#endif
    exit(1);
}

char parser_UpCase(char c)
{
    if (c>='a' && c<='z') return (c - 32);
    else return c;
}

void parser_GetChar(void)
{
    Look = progr_buffer[curr_pos];
    if(Look == '\n' || Look == '\r') curr_line++;
    if (Look == '\0') Look = EOF;
    curr_pos++;
}

void parser_Error(char *s)
{
    printf("\nErro (%d): %s\n",curr_line,s);
}

void parser_Abort(char *s)
{
    parser_Error(s);
    parser_Halt();
}

void parser_Expected(char *s)
{
    char ss[200];
    sprintf(ss,"%s esperado.",s);
    parser_Abort(ss);
}

void parser_Match(char x)
{
    if (Look != x)
    {
        char ss[20];
        sprintf(ss,"\'%c\'",x);
        parser_Expected(ss);
    }
    else
    {
        parser_GetChar();
        parser_SkipWhite();
        parser_SkipComment();
        parser_SkipWhite();
    }
}

void parser_Match_noskip(char x)
{
    if (Look != x)
    {
        char ss[20];
        sprintf(ss,"\'%c\'",x);
        parser_Expected(ss);
    }
    else
    {
        parser_GetChar();
    }
}

int parser_IsAlpha(char c)
{
    if ((c>='a' && c<='z') || (c>='A' && c<='Z'))
        return TRUE;
    else return FALSE;
}

int parser_IsDigit(char c)
{
    if (c>='0' && c<='9') return TRUE;
    else return FALSE;
}

int parser_IsAlNum(char c)
{
    return (parser_IsAlpha(c) || parser_IsDigit(c) || c=='.' || c=='-' || c=='_');
}

int parser_IsWhite(char c)
{
    return (c==' ' || c==TAB || c=='\n' || c=='\r');
}

void parser_SkipWhite(void)
{
    while (parser_IsWhite(Look)) parser_GetChar();
}

void parser_SkipComment(void)
{
    while (Look == ';')
    {
        parser_GetChar();
        parser_SkipUntilEnd();
    }
}

void parser_SkipUntil(char c)
{
    while (Look != c)
    {
        parser_GetChar();
        if (Look == EOF) parser_Match(c); /* Match sempre falha, entao da erro se chegar no EOF */
    }
    parser_Match(c);
    parser_SkipWhite();
    parser_SkipComment();
    parser_SkipWhite();
}

void parser_SkipUntilEnd(void)
{
    while (Look != '\n' && Look != '\r')
    {
        parser_GetChar();
        if (Look == EOF) break;
    }
    parser_SkipWhite();
    parser_SkipComment();
    parser_SkipWhite();
}

/* Pega nome de label, registrador ou intrucao */
char * parser_GetItem_s(void)
{
    char *Token;
    Token = (char *)calloc(STRTAM,sizeof(char));
    int i=0;
    if (!parser_IsAlNum(Look)) parser_Expected("Label, Instrucao ou Registrador");
    while (parser_IsAlNum(Look))
    {
        Token[i]=Look;
        parser_GetChar();
        i++;
        if (i>LABEL_MAX_SIZE-1) parser_Expected("Menos caracteres");
    }
    Token[i]='\0';
    parser_SkipWhite();
    parser_SkipComment();
    parser_SkipWhite();
    return Token;
}

/* Pega Numero (como string) */
char * parser_GetNum_s(void)
{
    char *Value;
    Value = (char *)calloc(STRTAM,sizeof(char));
    int i=0;
    if (!parser_IsDigit(Look)) parser_Expected("Numero");
    while (parser_IsDigit(Look))
    {
        Value[i]=Look;
        parser_GetChar();
        i++;
        if (i>STRTAM-1) parser_Expected("Menos caracteres");
    }
    Value[i]='\0';
    parser_SkipWhite();
    parser_SkipComment();
    parser_SkipWhite();
    return Value;
}

int parser_IsInt(char *s)
{
    int i=0;
    for (i=0;i<strlen(s);i++)
        if (!parser_IsDigit(s[i]) && s[i]!='-')
        {
            parser_Expected("Inteiro");
            return FALSE;
        }
    return TRUE;
}

void parser_Init(void)
{
    parser_GetChar();
    parser_SkipWhite();
    parser_SkipComment();
    parser_SkipWhite();
}

void parser_Write(char *texto)
{
    fprintf(out,"%s\n",texto);
//    printf("Escrito : %s\n",texto);
}

void parser_Write_Inst(char word[17], unsigned int end)
{
    /*
    fprintf(out,"%d:%.16s;\n",end,word);
    */
    if(end >= MEM_SIZE) {
        parser_Abort("Limite da memoria ultrapassado!");
    }
    strcpy(progr_buffer_out[end],word);
//    printf("Escrito : %.16s em 0x%x\n",word,end);
}

void parser_str_to_upper(char * str)
{
    register unsigned int i = 0;
    while (i < strlen(str))
    {
        str[i] = parser_UpCase(str[i]);
        i = i + 1;
    }
}

/* Inicializa buffer de saida */
void parser_init_out_buffer(void) 
{
    int i;
  
    for(i = 0; i < MEM_SIZE; i++)
        strcpy(progr_buffer_out[i],"0000000000000000");   
}

/* Descarrega buffer de saida no arquivo */
void parser_flush_program(void) 
{
    int i;
    
    for(i = 0; i < MEM_SIZE; i++)
        fprintf(out,"%d:%.16s;\n",i,progr_buffer_out[i]);
}
