#ifndef _PARSER_
#define _PARSER_

#define MAX_BUFF_SIZE 1000000

#define TAB 0x9
#define CR 0xA

#define STRTAM 200

#define TRUE 1
#define FALSE 0

/* Carregamento do arquivo */
int CarregaPrograma(char *);

/* Funcoes */
void parser_Rewind(void);
void parser_Message(char *);
void parser_Warning(char *);
void parser_Halt(void);
char parser_UpCase(char);
void parser_GetChar(void);
void parser_Error(char *);
void parser_Abort(char *);
void parser_Expected(char *);
void parser_Match(char);
void parser_Match_noskip(char);
int parser_IsAlpha(char);
int parser_IsDigit(char);
int parser_IsAlNum(char);
int parser_IsWhite(char);
void parser_SkipWhite(void);
void parser_SkipComment(void);
void parser_SkipUntil(char);
void parser_SkipUntilEnd(void);
char *parser_GetItem_s(void);
char *parser_GetNum_s(void);
int parser_IsInt(char *);
void parser_Init(void);
void parser_Write(char *);
void parser_Write_Inst(char *, unsigned int);
void parser_str_to_upper(char *);
void parser_init_out_buffer(void);
void parser_flush_program(void);

#endif
