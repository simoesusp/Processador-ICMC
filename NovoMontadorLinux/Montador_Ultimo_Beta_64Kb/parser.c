#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <sys/ioctl.h>//calcula o tamanho do terminal
#include "parser.h"
#include "structs.h"
#include "defs.h"

extern FILE *out; /* Codigo de saida */
extern FILE *in; /* Codigo de entrada */
extern char* OutputFileName;

char Look; /* Ultimo caractere lido */
int curr_pos = 0; /* Posicao atual */
int curr_line = 1; /* Linha atual */
char** progr_buffer; /* String completa do programa */
long progr_size;
unsigned line_count; //quantidade de linhas do programa
char progr_buffer_out[MEM_SIZE][17]; /* Buffer de saida */
int col_count; //quantidade de colunas no terminal
char verbose;

//prototipos locais
long parser_GetFileSize();


//-------------------------------------------------------------------------------------------------------------
//funcoes que iniciam o montador


void parser_SetVerbose(char c){
	verbose=c;
}

void calcula_tamanho(){
	struct winsize w;
	ioctl (0,TIOCGWINSZ, &w);
	col_count = w.ws_col;
}

unsigned parser_CountLines(){
	unsigned count=0;
	size_t s;
	char *tmp=NULL;
	while(getline(&tmp,&s,in)>0){
		count++;
		free(tmp);
		tmp=NULL;
	}
	return count;
}

void parser_LoadProgram(){
	int i,j;
	char* tmp=NULL;
	size_t s;
	for(i=0;i<line_count;i++){
		s=getline(&tmp,&s,in);
		progr_buffer[i]=tmp;
		tmp=NULL;
		s=0;
	}
}

long parser_GetFileSize(){
	long curr=ftell(in),ret;
	if(fseek(in,0L,SEEK_END)) parser_Abort("erro indefinido ao calcular o tamanho do arquivo");
	ret=ftell(in);
	if(fseek(in,curr,SEEK_SET)) parser_Abort("erro indefinido ao calcular o tamanho do arquivo");
	return ret;
}

void CarregaPrograma(char *nome)
{
    in = fopen(nome,"r");
    if (in == NULL) parser_Abort("Nao foi possivel carregar o arquivo de programa.");

    // Vai para o fim do arquivo
    if (fseek(in, 0, SEEK_END) != 0) {
        parser_Abort("Erro ao buscar o fim do arquivo.\n");
    }

    long size = ftell(in);
    if (size == 0) {
        parser_Abort("Arquivo vazio.\n");
    }

    // Volta para o último byte
    if (fseek(in, -1, SEEK_END) != 0) {
        parser_Abort("Erro ao buscar o último byte do arquivo.\n");
    }

    int last_char = fgetc(in); // Lê o último caractere

    if (last_char != '\n') {
        fclose(in);

        // Abre para leitura e escrita
        in = fopen(nome, "a"); // modo append: evita sobrescrever
        if (in == NULL) {
            parser_Abort("Não foi possível abrir o arquivo em modo append.\n");
        }

        if (fputc('\n', in) == EOF) {
            parser_Abort("Erro ao escrever nova linha no fim do arquivo.\n");
        }

        fclose(in);
    }

    // Reabre para leitura normal
    in = fopen(nome, "r");
    if (in == NULL) {
        parser_Abort("Não foi possível reabrir o arquivo em modo leitura.\n");
    }

    line_count = parser_CountLines();

    progr_buffer = (char**) malloc(line_count*sizeof(char*));
    fseek(in,0L,SEEK_SET);
    parser_LoadProgram();
    int i=0;


    memset(progr_buffer,0,progr_size);
}

void parser_Rewind(void)
{
    curr_pos = 0;
    curr_line = 0;
}

/* Inicializa buffer de saida */
void parser_init_out_buffer(void) 
{
    int i;
  
    for(i = 0; i < MEM_SIZE; i++)
        strcpy(progr_buffer_out[i],"0000000000000000");   
}

void parser_Init(void)
{
	parser_Rewind();
    parser_GetChar();
    parser_SkipWhite();
//    parser_SkipComment();
    parser_SkipWhite();
}


//-----------------------------------------------------------------------------------------------------------
//funcoes que interagem com a tela


void parser_GetAttention(char *s){
	int sz=strlen(s),i;
	for(i=0;i<col_count/(sz+1);i++)
		printf("%s ",s);
	printf("\n");
}

void parser_Message(char *s)
{
	if(!verbose) return;
    printf("Mensagem (%d): %s\n",curr_line+1,s);
}

void parser_Warning(char *s)
{
    printf("Aviso (%d): %s\n",curr_line+1,s);
}

void parser_Error(char *s)
{
    parser_GetAttention("ERRO");
    printf("\nErro (linha %d): %s\n",curr_line+1,s);
}

void parser_Write(char *texto)
{
    fprintf(out,"%s\n",texto);
//    printf("Escrito : %s\n",texto);
}

void parser_Halt(void)
{
#ifndef __linux__
    system("pause");
#endif
    exit(1);
}

void parser_Abort(char *s)
{
	char ss[STRTAM];
	sprintf(ss,"rm %s",OutputFileName);
	system(ss);
    parser_Error(s);
    parser_Halt();
}


//-----------------------------------------------------------------------------
//funcoes de comparacao


int parser_IsAlNum(char c)
{
    return (isalpha(c) || isdigit(c) || c=='.' || c=='-' || c=='_');
}

int parser_IsWhite(char c)
{
    return (c==' ' || c==TAB || c=='\n' || c=='\r');
}

int parser_IsInt(char *s)
{
    int i=0;
    for (i=0;i<strlen(s);i++)
        if (!isdigit(s[i]) && s[i]!='-')
        {
            parser_Abort("Inteiro esperado");
            return FALSE;
        }
    return TRUE;
}

//---------------------------------------------------------------------------
//funcoes que mexem no codigo


//getchar automaticamente pula comentarios
void parser_GetChar(void)
{
    Look = progr_buffer[curr_line][curr_pos];
    if(Look==';'){
	    Look='\n';
    }
    if(Look=='\n'){
	    curr_pos=0;
	    do{
		    curr_line++;
	    }while(curr_line<line_count && (progr_buffer[curr_line][0]=='\n' || progr_buffer[curr_line][0]==';'));
	    if(curr_line==line_count) Look = EOF;
    }else
	    curr_pos++;
}

void parser_Match(char x)
{
    if (Look != x)
    {
        char ss[STRTAM+strlen(progr_buffer[curr_line])];
	if(x==':'){
		char tmp[STRTAM];
		sprintf(ss,"%s",progr_buffer[curr_line]);
		sprintf(tmp,"\'%c\' esperado",x);
		strcat(ss,tmp);
	}else
		sprintf(ss,"\'%c\' esperado",x);
        parser_Abort(ss);
    }
    else
    {
        parser_GetChar();
        parser_SkipWhite();
//        parser_SkipComment();
        parser_SkipWhite();
    }
}

void parser_Match_noskip(char x)
{
    if (Look != x)
    {
        char ss[STRTAM];
        sprintf(ss,"\'%c\' esperado",x);
        parser_Abort(ss);
    }
    else
    {
        parser_GetChar();
    }
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
//    parser_SkipComment();
    parser_SkipWhite();
}

void parser_SkipUntilEnd(void)
{
	int old_line=curr_line;
	while(old_line == curr_line){
		parser_GetChar();
		if (Look == EOF) break;
	}
	/*
    while (Look != '\n' && Look != '\r')
    {
        parser_GetChar();
        if (Look == EOF) break;
    }
    */
    parser_SkipWhite();
//    parser_SkipComment();
    parser_SkipWhite();
}

/* Pega nome de label, registrador ou intrucao */
char * parser_GetItem_s(void)
{
    char *Token;
    Token = (char *)calloc(STRTAM,sizeof(char));
    int i=0;
    if (!parser_IsAlNum(Look)) parser_Abort("Label, Instrucao ou Registrador esperado");
    while (parser_IsAlNum(Look))
    {
        Token[i]=Look;
        parser_GetChar();
        i++;
        if (i>LABEL_MAX_SIZE-1) parser_Abort("Menos caracteres esperados");
    }
    Token[i]='\0';
    parser_SkipWhite();
//    parser_SkipComment();
    parser_SkipWhite();
    return Token;
}

/* Pega Numero (como string) */
char * parser_GetNum_s(void)
{
    char *Value;
    Value = (char *)calloc(STRTAM,sizeof(char));
    int i=0;
    if (!isdigit(Look)) parser_Abort("Numero esperado");
    while (isdigit(Look))
    {
        Value[i]=Look;
        parser_GetChar();
        i++;
        if (i>STRTAM-1) parser_Abort("Menos caracteres esperados");
    }
    Value[i]='\0';
    parser_SkipWhite();
    parser_SkipComment();
    parser_SkipWhite();
    return Value;
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
        str[i] = toupper(str[i]);
        i = i + 1;
    }
}

/* Descarrega buffer de saida no arquivo */
void parser_flush_program(void) 
{
    int i;
    
    for(i = 0; i < MEM_SIZE; i++)
        fprintf(out,"%d:%.16s;\n",i,progr_buffer_out[i]);
}
