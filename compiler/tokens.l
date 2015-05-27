%{
#include <string>
#include "node.hpp"
#include <stdio.h>
#include "parser.hpp"

#define TOKEN(t) (yylval.token = t)
#define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)

extern int debug;
%}

D  [0-9]
L  [a-zA-Z_]
H  [a-fA-F0-9]
E  ([Ee][+-]?{D}+)
P  ([Pp][+-]?{D}+)
FS (f|F|l|L)
IS ((u|U)|(u|U)?(l|L|ll|LL)|(l|L|ll|LL)(u|U))

eol "\n"

%option yylineno
%option noyywrap

%x COMMENT

%%

    /* Simbolos de Atribuicao */
"="			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "IGUAL"); return TOKEN(IGUAL);              }
">>="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MAIOR_MAIOR_IGUAL"); return TOKEN(MAIOR_MAIOR_IGUAL);  }
"<<="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MENOR_MENOR_IGUAL"); return TOKEN(MENOR_MENOR_IGUAL);  }
"+="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MAIS_IGUAL"); return TOKEN(MAIS_IGUAL);         }
"-="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MENOS_IGUAL"); return TOKEN(MENOS_IGUAL);        }
"*="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "ASTERISCO_IGUAL"); return TOKEN(ASTERISCO_IGUAL);    }
"/="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "BARRA_IGUAL"); return TOKEN(BARRA_IGUAL);        }
"%="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "PORCENTAGEM_IGUAL"); return TOKEN(PORCENTAGEM_IGUAL);  }
"&="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "AMPERSAND_IGUAL"); return TOKEN(AMPERSAND_IGUAL);    }
"^="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CIRCUNFLEXO_IGUAL"); return TOKEN(CIRCUNFLEXO_IGUAL);  }
"|="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "PIPE_IGUAL"); return TOKEN(PIPE_IGUAL);         }

    /* Operadores Aritimeticos */
"-"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MENOS"); return TOKEN(MENOS);              }
"+"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MAIS"); return TOKEN(MAIS);               }
"*"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "ASTERISCO"); return TOKEN(ASTERISCO);          }
"/"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "BARRA"); return TOKEN(BARRA);              }
"%"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "PORCENTAGEM"); return TOKEN(PORCENTAGEM);        }
"++"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MAIS_MAIS"); return TOKEN(MAIS_MAIS);          }
"--"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MENOS_MENOS"); return TOKEN(MENOS_MENOS);        }
">>"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MAIOR_MAIOR"); return TOKEN(MAIOR_MAIOR);        }
"<<"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MENOR_MENOR"); return TOKEN(MENOR_MENOR);        }
"^"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CIRCUNFLEXO"); return TOKEN(CIRCUNFLEXO);        }
"|"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "PIPE"); return TOKEN(PIPE);               }

    /* Operadores Relacionais */
"<="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MENOR_IGUAL"); return TOKEN(MENOR_IGUAL); }
">="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MAIOR_IGUAL"); return TOKEN(MAIOR_IGUAL); }
"=="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "IGUAL_IGUAL"); return TOKEN(IGUAL_IGUAL); }
"!="			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "EXCLAMACAO_IGUAL"); return TOKEN(EXCLAMACAO_IGUAL); }
"<"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MENOR"); return TOKEN(MENOR); }
">"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "MAIOR"); return TOKEN(MAIOR); }

    /* Operadores Logicos */
"&&"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "AMPERSAND_AMPERSAND"); return TOKEN(AMPERSAND_AMPERSAND); }
"||"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "PIPE_PIPE"); return TOKEN(PIPE_PIPE); }

    /* Operadores Unarios */
"&"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "AMPERSAND"); return TOKEN(AMPERSAND); }
"!"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "EXCLAMACAO"); return TOKEN(EXCLAMACAO); }
"~"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "TIL"); return TOKEN(TIL); }

    /* Outros Simbolos */
"("			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "ABRE_PARENTESES"); return TOKEN(ABRE_PARENTESES); }
")"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "FECHA_PARENTESES"); return TOKEN(FECHA_PARENTESES); }
";"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "PONTO_VIRGULA"); return TOKEN(PONTO_VIRGULA); }
","			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "VIRGULA"); return TOKEN(VIRGULA); }
":"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "DOIS_PONTOS"); return TOKEN(DOIS_PONTOS); }
("{"|"<%")		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "ABRE_CHAVES"); return TOKEN(ABRE_CHAVES); }
("}"|"%>")		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "FECHA_CHAVES"); return TOKEN(FECHA_CHAVES); }
("["|"<:")		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "ABRE_COLCHETES"); return TOKEN(ABRE_COLCHETES); }
("]"|":>")		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "FECHA_COLCHETES"); return TOKEN(FECHA_COLCHETES); }
"?"			                { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "INTERROGACAO"); return TOKEN(INTERROGACAO); }

    /* Palavras Reservadas */

    /* Tipos de Dados */
"char"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CHAR"); return TOKEN(CHAR); }
"int"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "INT"); return TOKEN(INT); }
"void"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "VOID"); return TOKEN(VOID); }

    /* Desvio de Execucao */
"if"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "IF"); return TOKEN(IF); }
"else"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "ELSE"); return TOKEN(ELSE); }
"switch"		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "SWITCH"); return TOKEN(SWITCH); }
"case"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CASE"); return TOKEN(CASE); }
"default"		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "DEFAULT"); return TOKEN(DEFAULT); }
"break"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "BREAK"); return TOKEN(BREAK); }
"continue"		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONTINUE"); return TOKEN(CONTINUE); }
"goto"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "GOTO"); return TOKEN(GOTO); }

    /* Loops */
"for"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "FOR"); return TOKEN(FOR); }
"while"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "WHILE"); return TOKEN(WHILE); }

    /* Outras Palavras Reservadas */

"_Bool"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "BOOL"); return TOKEN(BOOL); }
"const"			            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONST"); return TOKEN(CONST); }
"extern"		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "EXTERN"); return TOKEN(EXTERN); }
"return"		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "RETURN"); return TOKEN(RETURN); }
"static"		            { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "STATIC"); return TOKEN(STATIC); }

"breakp"                    { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "BREAKP"); return TOKEN(BREAKP); }
"getch"                     { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "GETCH"); return TOKEN(GETCH); }
"printf"                    { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "PRINTF"); return TOKEN(PRINTF); }

{L}({L}|{D})*		        { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "IDENTIFIER"); return IDENTIFIER; }

0[xX]{H}+{IS}?		        { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }
0[0-7]*{IS}?		        { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }
[1-9]{D}*{IS}?		        { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }
L?'(\\.|[^\\'\n])+'	        { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }

{D}+{E}{FS}?		        { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }
{D}*"."{D}+{E}?{FS}?	    { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }
{D}+"."{D}*{E}?{FS}?	    { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }
0[xX]{H}+{P}{FS}?	        { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }
0[xX]{H}*"."{H}+{P}?{FS}?   { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }
0[xX]{H}+"."{H}*{P}?{FS}?   { SAVE_TOKEN; if(debug) printf("@(%d): achou %s - %s\n", yylineno, yytext, "CONSTANT"); return CONSTANT; }


L?\"(\\.|[^\\"\n])*\"	    {   //SAVE_TOKEN; 

                                yylval.string = new std::string(yytext, 1, yyleng-2);
                                if(debug) 
                                    printf("@(%d): achou %s - %s\n", yylineno, yytext, "STRING_LITERAL"); 
                                //yylval.string->erase(yylval.string->begin());
                                //yylval.string->erase(yylval.string->end());
                                return STRING_LITERAL; 
                            }

[ \t\v\n\f]		            { }

    /* comments */
"/*"                        { BEGIN(COMMENT); }
"//".*       

<COMMENT>"*/"               { BEGIN(INITIAL); }
<COMMENT><<EOF>>            { return 1;  }
<COMMENT>{eol}              { }
<COMMENT>.
<<EOF>>                     { yyterminate(); }
.                           { }

%%

