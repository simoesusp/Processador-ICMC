/* A Bison parser, made by GNU Bison 3.6.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.6.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 11 "parser.y"

#include "node.hpp"
#include <string>
#include <stdio.h>
#include <iostream>
#include <sstream>
#include <assert.h>

#define YYDEBUG 1

/* ***** Precisamos disso aqui para fazer o parser funcionar ***** */
extern int yylex();                 // funcao do lexico que retorna o proximo token
int yyerror(const char *errmsg);    // funcao que mostra uma mensagem de erro qnd o parser acha um erro gramatical no codigo

extern FILE *yyin;                  // ponteiro para o arquivo de entrada. Precisa dele para chamar o parser mais de uma vez
extern int yylineno;                // numero da linha

using namespace std;

/* ***** Isso aqui e' para a parte semantica ***** */
TAD *t;                             // tabela de simbolos

bool declarado = false;
bool preProcessamento = false;

// debug
int debug = 0;
bool debug_sintatico = false;
bool debug_instrucao = true;

// nao ter return em funcao que nao eh void
// declarar uma funcao dentro de outra
int stack = 28000;      // inicio da stack na memoria
int offset = 0;
int ifseq = 0;
int loopseq = 0;
vector<int> loop_stack;
vector<int> if_stack;


int initialization_size = 0;

int salva_stack = -1;
string salva_identificador;
int stack_ampersand = -1;

int flag_ponteiro = -1;

// caso especial de matriz
int endereco_base;
int offset_linha;
int offset_coluna;

vector<int> initializer_list;

// caso especial do printf
int begin_printf = 0;
vector<int> printf_args;
int correcao_printf_string = 0;

typedef enum {nenhuma, ampersand, asterisco, exclamacao, menos} operacao_unaria;
operacao_unaria operacao = nenhuma;


typedef enum {eq, mul_eq, div_eq, mod_eq, add_eq, sub_eq, inc_eq, dec_eq, land_eq, lxor_eq, lor_eq} tipo_atribuicao;
tipo_atribuicao atribuicao = eq;

int stack_antes_de_entrar_no_escopo; // para a stack voltar para a posicao que estava apos sair do escopo

Entrada *f = NULL;              // referencia para a funcao corrente
Entrada *e = NULL;
bool begin_parametro = false;   // flag para comecar a guarda tudo como parametro
bool type_void = false;         // flag para checa o tipo void, funciona junto com isFunctionVoid
vector<int> arg_list;

int insideLoop = 0;             // serve para evitar breaks fora de loops
bool isFunctionVoid = false;    // serve para evitar returns em funcoes void
bool funcao_tem_return = false; // serve para evitar que funcao void tenha return

vector<int> switch_stack;
int insideSwitch = 0;
int insideCase = 0;
int statement_seq = 0;
int case_seq = 0;
int switch_seq = 0;

// mensagens de erro
void errorMsg(string msg);
void warningMsg(string msg);

// verifica se o identificador que esta sendo declarado ja esta na tabela de simbolos
bool declarando(string &id);
bool referenciando(string &id);

void declara_variaveis_e_parametros(string id, int nbytes);
void declara_label(string id);
void declara_funcao(string id);

// como nao tem include, o arquivo deve ter main para ser executado
bool tem_main = false;
bool is_main = false;

int mapa[32000];

int correcao_stack_matriz = -1; // correcao da posicao da stack quando se declara matriz

void checa_label(string id);

void referencia_funcao(string id);

string int_or_char(string id);

void push(string value, int a);

string to_str(int value);

void expressao_binaria(char op);

void relacao_binaria(char op);

void msg_sintatico(string msg);

void msg_instrucao(string msg);

void salva_tipo(string tipo);

void function_definition();


#line 201 "parser.cpp"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_PARSER_HPP_INCLUDED
# define YY_YY_PARSER_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    STRING_LITERAL = 258,          /* STRING_LITERAL  */
    IDENTIFIER = 259,              /* IDENTIFIER  */
    CONSTANT = 260,                /* CONSTANT  */
    MENOR = 261,                   /* MENOR  */
    MAIOR = 262,                   /* MAIOR  */
    MENOR_IGUAL = 263,             /* MENOR_IGUAL  */
    MAIOR_IGUAL = 264,             /* MAIOR_IGUAL  */
    IGUAL_IGUAL = 265,             /* IGUAL_IGUAL  */
    EXCLAMACAO_IGUAL = 266,        /* EXCLAMACAO_IGUAL  */
    AMPERSAND_AMPERSAND = 267,     /* AMPERSAND_AMPERSAND  */
    PIPE_PIPE = 268,               /* PIPE_PIPE  */
    EXCLAMACAO = 269,              /* EXCLAMACAO  */
    IGUAL = 270,                   /* IGUAL  */
    MAIS_IGUAL = 271,              /* MAIS_IGUAL  */
    MENOS_IGUAL = 272,             /* MENOS_IGUAL  */
    ASTERISCO_IGUAL = 273,         /* ASTERISCO_IGUAL  */
    BARRA_IGUAL = 274,             /* BARRA_IGUAL  */
    MAIOR_MAIOR_IGUAL = 275,       /* MAIOR_MAIOR_IGUAL  */
    MENOR_MENOR_IGUAL = 276,       /* MENOR_MENOR_IGUAL  */
    PORCENTAGEM_IGUAL = 277,       /* PORCENTAGEM_IGUAL  */
    CIRCUNFLEXO_IGUAL = 278,       /* CIRCUNFLEXO_IGUAL  */
    AMPERSAND_IGUAL = 279,         /* AMPERSAND_IGUAL  */
    PIPE_IGUAL = 280,              /* PIPE_IGUAL  */
    VOID = 281,                    /* VOID  */
    INT = 282,                     /* INT  */
    CHAR = 283,                    /* CHAR  */
    BOOL = 284,                    /* BOOL  */
    IF = 285,                      /* IF  */
    ELSE = 286,                    /* ELSE  */
    FOR = 287,                     /* FOR  */
    WHILE = 288,                   /* WHILE  */
    BREAK = 289,                   /* BREAK  */
    SWITCH = 290,                  /* SWITCH  */
    CASE = 291,                    /* CASE  */
    CONTINUE = 292,                /* CONTINUE  */
    INCLUDE = 293,                 /* INCLUDE  */
    GOTO = 294,                    /* GOTO  */
    RETURN = 295,                  /* RETURN  */
    CONST = 296,                   /* CONST  */
    DEFAULT = 297,                 /* DEFAULT  */
    EXTERN = 298,                  /* EXTERN  */
    STATIC = 299,                  /* STATIC  */
    MAIS = 300,                    /* MAIS  */
    MENOS = 301,                   /* MENOS  */
    MAIS_MAIS = 302,               /* MAIS_MAIS  */
    MENOS_MENOS = 303,             /* MENOS_MENOS  */
    ASTERISCO = 304,               /* ASTERISCO  */
    BARRA = 305,                   /* BARRA  */
    PORCENTAGEM = 306,             /* PORCENTAGEM  */
    CIRCUNFLEXO = 307,             /* CIRCUNFLEXO  */
    DOIS_PONTOS = 308,             /* DOIS_PONTOS  */
    VIRGULA = 309,                 /* VIRGULA  */
    PONTO_VIRGULA = 310,           /* PONTO_VIRGULA  */
    INTERROGACAO = 311,            /* INTERROGACAO  */
    SUSTENIDO = 312,               /* SUSTENIDO  */
    ABRE_COLCHETES = 313,          /* ABRE_COLCHETES  */
    FECHA_COLCHETES = 314,         /* FECHA_COLCHETES  */
    ABRE_PARENTESES = 315,         /* ABRE_PARENTESES  */
    FECHA_PARENTESES = 316,        /* FECHA_PARENTESES  */
    ABRE_CHAVES = 317,             /* ABRE_CHAVES  */
    FECHA_CHAVES = 318,            /* FECHA_CHAVES  */
    MENOR_MENOR = 319,             /* MENOR_MENOR  */
    MAIOR_MAIOR = 320,             /* MAIOR_MAIOR  */
    PIPE = 321,                    /* PIPE  */
    AMPERSAND = 322,               /* AMPERSAND  */
    TIL = 323,                     /* TIL  */
    BREAKP = 324,                  /* BREAKP  */
    GETCH = 325,                   /* GETCH  */
    PRINTF = 326,                  /* PRINTF  */
    UNSIGNED = 327,                /* UNSIGNED  */
    UNION = 328,                   /* UNION  */
    TYPE_NAME = 329,               /* TYPE_NAME  */
    TYPEDEF = 330,                 /* TYPEDEF  */
    STRUCT = 331,                  /* STRUCT  */
    SIZEOF = 332,                  /* SIZEOF  */
    SIGNED = 333,                  /* SIGNED  */
    RESTRICT = 334,                /* RESTRICT  */
    REGISTER = 335,                /* REGISTER  */
    INLINE = 336,                  /* INLINE  */
    IMAGINARY = 337,               /* IMAGINARY  */
    ELLIPSIS = 338,                /* ELLIPSIS  */
    DO = 339,                      /* DO  */
    COMPLEX = 340,                 /* COMPLEX  */
    AUTO = 341,                    /* AUTO  */
    VOLATILE = 342,                /* VOLATILE  */
    ENUM = 343,                    /* ENUM  */
    PONTO = 344,                   /* PONTO  */
    DOUBLE = 345,                  /* DOUBLE  */
    SHORT = 346,                   /* SHORT  */
    LONG = 347,                    /* LONG  */
    FLOAT = 348                    /* FLOAT  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 141 "parser.y"

    int token;
    std::string *string;

#line 349 "parser.cpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_HPP_INCLUDED  */
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_STRING_LITERAL = 3,             /* STRING_LITERAL  */
  YYSYMBOL_IDENTIFIER = 4,                 /* IDENTIFIER  */
  YYSYMBOL_CONSTANT = 5,                   /* CONSTANT  */
  YYSYMBOL_MENOR = 6,                      /* MENOR  */
  YYSYMBOL_MAIOR = 7,                      /* MAIOR  */
  YYSYMBOL_MENOR_IGUAL = 8,                /* MENOR_IGUAL  */
  YYSYMBOL_MAIOR_IGUAL = 9,                /* MAIOR_IGUAL  */
  YYSYMBOL_IGUAL_IGUAL = 10,               /* IGUAL_IGUAL  */
  YYSYMBOL_EXCLAMACAO_IGUAL = 11,          /* EXCLAMACAO_IGUAL  */
  YYSYMBOL_AMPERSAND_AMPERSAND = 12,       /* AMPERSAND_AMPERSAND  */
  YYSYMBOL_PIPE_PIPE = 13,                 /* PIPE_PIPE  */
  YYSYMBOL_EXCLAMACAO = 14,                /* EXCLAMACAO  */
  YYSYMBOL_IGUAL = 15,                     /* IGUAL  */
  YYSYMBOL_MAIS_IGUAL = 16,                /* MAIS_IGUAL  */
  YYSYMBOL_MENOS_IGUAL = 17,               /* MENOS_IGUAL  */
  YYSYMBOL_ASTERISCO_IGUAL = 18,           /* ASTERISCO_IGUAL  */
  YYSYMBOL_BARRA_IGUAL = 19,               /* BARRA_IGUAL  */
  YYSYMBOL_MAIOR_MAIOR_IGUAL = 20,         /* MAIOR_MAIOR_IGUAL  */
  YYSYMBOL_MENOR_MENOR_IGUAL = 21,         /* MENOR_MENOR_IGUAL  */
  YYSYMBOL_PORCENTAGEM_IGUAL = 22,         /* PORCENTAGEM_IGUAL  */
  YYSYMBOL_CIRCUNFLEXO_IGUAL = 23,         /* CIRCUNFLEXO_IGUAL  */
  YYSYMBOL_AMPERSAND_IGUAL = 24,           /* AMPERSAND_IGUAL  */
  YYSYMBOL_PIPE_IGUAL = 25,                /* PIPE_IGUAL  */
  YYSYMBOL_VOID = 26,                      /* VOID  */
  YYSYMBOL_INT = 27,                       /* INT  */
  YYSYMBOL_CHAR = 28,                      /* CHAR  */
  YYSYMBOL_BOOL = 29,                      /* BOOL  */
  YYSYMBOL_IF = 30,                        /* IF  */
  YYSYMBOL_ELSE = 31,                      /* ELSE  */
  YYSYMBOL_FOR = 32,                       /* FOR  */
  YYSYMBOL_WHILE = 33,                     /* WHILE  */
  YYSYMBOL_BREAK = 34,                     /* BREAK  */
  YYSYMBOL_SWITCH = 35,                    /* SWITCH  */
  YYSYMBOL_CASE = 36,                      /* CASE  */
  YYSYMBOL_CONTINUE = 37,                  /* CONTINUE  */
  YYSYMBOL_INCLUDE = 38,                   /* INCLUDE  */
  YYSYMBOL_GOTO = 39,                      /* GOTO  */
  YYSYMBOL_RETURN = 40,                    /* RETURN  */
  YYSYMBOL_CONST = 41,                     /* CONST  */
  YYSYMBOL_DEFAULT = 42,                   /* DEFAULT  */
  YYSYMBOL_EXTERN = 43,                    /* EXTERN  */
  YYSYMBOL_STATIC = 44,                    /* STATIC  */
  YYSYMBOL_MAIS = 45,                      /* MAIS  */
  YYSYMBOL_MENOS = 46,                     /* MENOS  */
  YYSYMBOL_MAIS_MAIS = 47,                 /* MAIS_MAIS  */
  YYSYMBOL_MENOS_MENOS = 48,               /* MENOS_MENOS  */
  YYSYMBOL_ASTERISCO = 49,                 /* ASTERISCO  */
  YYSYMBOL_BARRA = 50,                     /* BARRA  */
  YYSYMBOL_PORCENTAGEM = 51,               /* PORCENTAGEM  */
  YYSYMBOL_CIRCUNFLEXO = 52,               /* CIRCUNFLEXO  */
  YYSYMBOL_DOIS_PONTOS = 53,               /* DOIS_PONTOS  */
  YYSYMBOL_VIRGULA = 54,                   /* VIRGULA  */
  YYSYMBOL_PONTO_VIRGULA = 55,             /* PONTO_VIRGULA  */
  YYSYMBOL_INTERROGACAO = 56,              /* INTERROGACAO  */
  YYSYMBOL_SUSTENIDO = 57,                 /* SUSTENIDO  */
  YYSYMBOL_ABRE_COLCHETES = 58,            /* ABRE_COLCHETES  */
  YYSYMBOL_FECHA_COLCHETES = 59,           /* FECHA_COLCHETES  */
  YYSYMBOL_ABRE_PARENTESES = 60,           /* ABRE_PARENTESES  */
  YYSYMBOL_FECHA_PARENTESES = 61,          /* FECHA_PARENTESES  */
  YYSYMBOL_ABRE_CHAVES = 62,               /* ABRE_CHAVES  */
  YYSYMBOL_FECHA_CHAVES = 63,              /* FECHA_CHAVES  */
  YYSYMBOL_MENOR_MENOR = 64,               /* MENOR_MENOR  */
  YYSYMBOL_MAIOR_MAIOR = 65,               /* MAIOR_MAIOR  */
  YYSYMBOL_PIPE = 66,                      /* PIPE  */
  YYSYMBOL_AMPERSAND = 67,                 /* AMPERSAND  */
  YYSYMBOL_TIL = 68,                       /* TIL  */
  YYSYMBOL_BREAKP = 69,                    /* BREAKP  */
  YYSYMBOL_GETCH = 70,                     /* GETCH  */
  YYSYMBOL_PRINTF = 71,                    /* PRINTF  */
  YYSYMBOL_UNSIGNED = 72,                  /* UNSIGNED  */
  YYSYMBOL_UNION = 73,                     /* UNION  */
  YYSYMBOL_TYPE_NAME = 74,                 /* TYPE_NAME  */
  YYSYMBOL_TYPEDEF = 75,                   /* TYPEDEF  */
  YYSYMBOL_STRUCT = 76,                    /* STRUCT  */
  YYSYMBOL_SIZEOF = 77,                    /* SIZEOF  */
  YYSYMBOL_SIGNED = 78,                    /* SIGNED  */
  YYSYMBOL_RESTRICT = 79,                  /* RESTRICT  */
  YYSYMBOL_REGISTER = 80,                  /* REGISTER  */
  YYSYMBOL_INLINE = 81,                    /* INLINE  */
  YYSYMBOL_IMAGINARY = 82,                 /* IMAGINARY  */
  YYSYMBOL_ELLIPSIS = 83,                  /* ELLIPSIS  */
  YYSYMBOL_DO = 84,                        /* DO  */
  YYSYMBOL_COMPLEX = 85,                   /* COMPLEX  */
  YYSYMBOL_AUTO = 86,                      /* AUTO  */
  YYSYMBOL_VOLATILE = 87,                  /* VOLATILE  */
  YYSYMBOL_ENUM = 88,                      /* ENUM  */
  YYSYMBOL_PONTO = 89,                     /* PONTO  */
  YYSYMBOL_DOUBLE = 90,                    /* DOUBLE  */
  YYSYMBOL_SHORT = 91,                     /* SHORT  */
  YYSYMBOL_LONG = 92,                      /* LONG  */
  YYSYMBOL_FLOAT = 93,                     /* FLOAT  */
  YYSYMBOL_YYACCEPT = 94,                  /* $accept  */
  YYSYMBOL_primary_expression = 95,        /* primary_expression  */
  YYSYMBOL_postfix_expression = 96,        /* postfix_expression  */
  YYSYMBOL_argument_expression_list = 97,  /* argument_expression_list  */
  YYSYMBOL_unary_expression = 98,          /* unary_expression  */
  YYSYMBOL_unary_operator = 99,            /* unary_operator  */
  YYSYMBOL_cast_expression = 100,          /* cast_expression  */
  YYSYMBOL_multiplicative_expression = 101, /* multiplicative_expression  */
  YYSYMBOL_additive_expression = 102,      /* additive_expression  */
  YYSYMBOL_shift_expression = 103,         /* shift_expression  */
  YYSYMBOL_relational_expression = 104,    /* relational_expression  */
  YYSYMBOL_equality_expression = 105,      /* equality_expression  */
  YYSYMBOL_and_expression = 106,           /* and_expression  */
  YYSYMBOL_exclusive_or_expression = 107,  /* exclusive_or_expression  */
  YYSYMBOL_inclusive_or_expression = 108,  /* inclusive_or_expression  */
  YYSYMBOL_logical_and_expression = 109,   /* logical_and_expression  */
  YYSYMBOL_logical_or_expression = 110,    /* logical_or_expression  */
  YYSYMBOL_conditional_expression = 111,   /* conditional_expression  */
  YYSYMBOL_assignment_expression = 112,    /* assignment_expression  */
  YYSYMBOL_assignment_operator = 113,      /* assignment_operator  */
  YYSYMBOL_expression = 114,               /* expression  */
  YYSYMBOL_constant_expression = 115,      /* constant_expression  */
  YYSYMBOL_declaration = 116,              /* declaration  */
  YYSYMBOL_declaration_specifiers = 117,   /* declaration_specifiers  */
  YYSYMBOL_init_declarator_list = 118,     /* init_declarator_list  */
  YYSYMBOL_init_declarator = 119,          /* init_declarator  */
  YYSYMBOL_storage_class_specifier = 120,  /* storage_class_specifier  */
  YYSYMBOL_type_specifier = 121,           /* type_specifier  */
  YYSYMBOL_struct_or_union_specifier = 122, /* struct_or_union_specifier  */
  YYSYMBOL_struct_or_union = 123,          /* struct_or_union  */
  YYSYMBOL_struct_declaration_list = 124,  /* struct_declaration_list  */
  YYSYMBOL_struct_declaration = 125,       /* struct_declaration  */
  YYSYMBOL_specifier_qualifier_list = 126, /* specifier_qualifier_list  */
  YYSYMBOL_struct_declarator_list = 127,   /* struct_declarator_list  */
  YYSYMBOL_struct_declarator = 128,        /* struct_declarator  */
  YYSYMBOL_enum_specifier = 129,           /* enum_specifier  */
  YYSYMBOL_enumerator_list = 130,          /* enumerator_list  */
  YYSYMBOL_enumerator = 131,               /* enumerator  */
  YYSYMBOL_type_qualifier = 132,           /* type_qualifier  */
  YYSYMBOL_function_specifier = 133,       /* function_specifier  */
  YYSYMBOL_declarator = 134,               /* declarator  */
  YYSYMBOL_direct_declarator = 135,        /* direct_declarator  */
  YYSYMBOL_pointer = 136,                  /* pointer  */
  YYSYMBOL_type_qualifier_list = 137,      /* type_qualifier_list  */
  YYSYMBOL_type_name = 138,                /* type_name  */
  YYSYMBOL_abstract_declarator = 139,      /* abstract_declarator  */
  YYSYMBOL_direct_abstract_declarator = 140, /* direct_abstract_declarator  */
  YYSYMBOL_initializer = 141,              /* initializer  */
  YYSYMBOL_initializer_list = 142,         /* initializer_list  */
  YYSYMBOL_designation = 143,              /* designation  */
  YYSYMBOL_designator_list = 144,          /* designator_list  */
  YYSYMBOL_designator = 145,               /* designator  */
  YYSYMBOL_statement = 146,                /* statement  */
  YYSYMBOL_breakp_statement = 147,         /* breakp_statement  */
  YYSYMBOL_getch_statement = 148,          /* getch_statement  */
  YYSYMBOL_opt_args = 149,                 /* opt_args  */
  YYSYMBOL_printf = 150,                   /* printf  */
  YYSYMBOL_printf_statement = 151,         /* printf_statement  */
  YYSYMBOL_labeled_statement = 152,        /* labeled_statement  */
  YYSYMBOL_begin_case = 153,               /* begin_case  */
  YYSYMBOL_compound_statement = 154,       /* compound_statement  */
  YYSYMBOL_block_item_list = 155,          /* block_item_list  */
  YYSYMBOL_block_item = 156,               /* block_item  */
  YYSYMBOL_expression_statement = 157,     /* expression_statement  */
  YYSYMBOL_selection_statement = 158,      /* selection_statement  */
  YYSYMBOL_begin_switch = 159,             /* begin_switch  */
  YYSYMBOL_begin_labeled = 160,            /* begin_labeled  */
  YYSYMBOL_begin_else = 161,               /* begin_else  */
  YYSYMBOL_iteration_statement = 162,      /* iteration_statement  */
  YYSYMBOL_begin_labeled5 = 163,           /* begin_labeled5  */
  YYSYMBOL_begin_while = 164,              /* begin_while  */
  YYSYMBOL_begin_labeled2 = 165,           /* begin_labeled2  */
  YYSYMBOL_begin_for = 166,                /* begin_for  */
  YYSYMBOL_begin_labeled3 = 167,           /* begin_labeled3  */
  YYSYMBOL_begin_labeled4 = 168,           /* begin_labeled4  */
  YYSYMBOL_jump_statement = 169,           /* jump_statement  */
  YYSYMBOL_translation_unit = 170,         /* translation_unit  */
  YYSYMBOL_external_declaration = 171,     /* external_declaration  */
  YYSYMBOL_function_definition = 172,      /* function_definition  */
  YYSYMBOL_opt_parametros = 173,           /* opt_parametros  */
  YYSYMBOL_parameter_list = 174,           /* parameter_list  */
  YYSYMBOL_parameter_declaration = 175,    /* parameter_declaration  */
  YYSYMBOL_begin_funcao = 176,             /* begin_funcao  */
  YYSYMBOL_begin_parametro = 177,          /* begin_parametro  */
  YYSYMBOL_end_parametro = 178             /* end_parametro  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int16 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if 1

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
# define YYCOPY_NEEDED 1
#endif /* 1 */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  53
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1192

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  94
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  85
/* YYNRULES -- Number of rules.  */
#define YYNRULES  236
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  391

#define YYMAXUTOK   348


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   215,   215,   221,   224,   229,   242,   248,   280,   318,
     347,   385,   388,   397,   409,   421,   432,   436,   443,   446,
     453,   460,   511,   514,   520,   524,   528,   531,   535,   538,
     545,   548,   554,   557,   561,   565,   572,   575,   579,   586,
     589,   593,   600,   603,   607,   611,   615,   622,   625,   629,
     636,   639,   646,   649,   656,   659,   666,   669,   676,   679,
     686,   689,   696,   699,   768,   772,   776,   780,   784,   788,
     792,   796,   800,   804,   808,   815,   818,   824,   830,   833,
     839,   842,   845,   848,   851,   854,   857,   860,   866,   869,
     875,   885,   916,   919,   922,   925,   928,   934,   938,   942,
     946,   950,   954,   958,   962,   965,   968,   972,   975,   978,
     984,   987,   990,   996,   999,  1005,  1008,  1014,  1020,  1023,
    1026,  1029,  1035,  1038,  1044,  1047,  1050,  1056,  1059,  1062,
    1065,  1068,  1074,  1077,  1083,  1086,  1092,  1095,  1098,  1104,
    1110,  1113,  1122,  1127,  1147,  1191,  1194,  1197,  1200,  1206,
    1209,  1215,  1218,  1224,  1227,  1230,  1236,  1239,  1242,  1245,
    1248,  1251,  1254,  1257,  1263,  1270,  1276,  1279,  1282,  1285,
    1291,  1297,  1300,  1306,  1309,  1315,  1318,  1321,  1324,  1327,
    1330,  1333,  1336,  1342,  1350,  1359,  1360,  1369,  1381,  1392,
    1537,  1540,  1546,  1554,  1572,  1575,  1581,  1584,  1590,  1593,
    1599,  1602,  1608,  1615,  1622,  1634,  1643,  1661,  1671,  1685,
    1689,  1703,  1720,  1729,  1742,  1757,  1769,  1785,  1793,  1799,
    1807,  1819,  1828,  1844,  1847,  1853,  1856,  1862,  1868,  1869,
    1875,  1878,  1884,  1888,  1894,  1911,  1923
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if 1
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "STRING_LITERAL",
  "IDENTIFIER", "CONSTANT", "MENOR", "MAIOR", "MENOR_IGUAL", "MAIOR_IGUAL",
  "IGUAL_IGUAL", "EXCLAMACAO_IGUAL", "AMPERSAND_AMPERSAND", "PIPE_PIPE",
  "EXCLAMACAO", "IGUAL", "MAIS_IGUAL", "MENOS_IGUAL", "ASTERISCO_IGUAL",
  "BARRA_IGUAL", "MAIOR_MAIOR_IGUAL", "MENOR_MENOR_IGUAL",
  "PORCENTAGEM_IGUAL", "CIRCUNFLEXO_IGUAL", "AMPERSAND_IGUAL",
  "PIPE_IGUAL", "VOID", "INT", "CHAR", "BOOL", "IF", "ELSE", "FOR",
  "WHILE", "BREAK", "SWITCH", "CASE", "CONTINUE", "INCLUDE", "GOTO",
  "RETURN", "CONST", "DEFAULT", "EXTERN", "STATIC", "MAIS", "MENOS",
  "MAIS_MAIS", "MENOS_MENOS", "ASTERISCO", "BARRA", "PORCENTAGEM",
  "CIRCUNFLEXO", "DOIS_PONTOS", "VIRGULA", "PONTO_VIRGULA", "INTERROGACAO",
  "SUSTENIDO", "ABRE_COLCHETES", "FECHA_COLCHETES", "ABRE_PARENTESES",
  "FECHA_PARENTESES", "ABRE_CHAVES", "FECHA_CHAVES", "MENOR_MENOR",
  "MAIOR_MAIOR", "PIPE", "AMPERSAND", "TIL", "BREAKP", "GETCH", "PRINTF",
  "UNSIGNED", "UNION", "TYPE_NAME", "TYPEDEF", "STRUCT", "SIZEOF",
  "SIGNED", "RESTRICT", "REGISTER", "INLINE", "IMAGINARY", "ELLIPSIS",
  "DO", "COMPLEX", "AUTO", "VOLATILE", "ENUM", "PONTO", "DOUBLE", "SHORT",
  "LONG", "FLOAT", "$accept", "primary_expression", "postfix_expression",
  "argument_expression_list", "unary_expression", "unary_operator",
  "cast_expression", "multiplicative_expression", "additive_expression",
  "shift_expression", "relational_expression", "equality_expression",
  "and_expression", "exclusive_or_expression", "inclusive_or_expression",
  "logical_and_expression", "logical_or_expression",
  "conditional_expression", "assignment_expression", "assignment_operator",
  "expression", "constant_expression", "declaration",
  "declaration_specifiers", "init_declarator_list", "init_declarator",
  "storage_class_specifier", "type_specifier", "struct_or_union_specifier",
  "struct_or_union", "struct_declaration_list", "struct_declaration",
  "specifier_qualifier_list", "struct_declarator_list",
  "struct_declarator", "enum_specifier", "enumerator_list", "enumerator",
  "type_qualifier", "function_specifier", "declarator",
  "direct_declarator", "pointer", "type_qualifier_list", "type_name",
  "abstract_declarator", "direct_abstract_declarator", "initializer",
  "initializer_list", "designation", "designator_list", "designator",
  "statement", "breakp_statement", "getch_statement", "opt_args", "printf",
  "printf_statement", "labeled_statement", "begin_case",
  "compound_statement", "block_item_list", "block_item",
  "expression_statement", "selection_statement", "begin_switch",
  "begin_labeled", "begin_else", "iteration_statement", "begin_labeled5",
  "begin_while", "begin_labeled2", "begin_for", "begin_labeled3",
  "begin_labeled4", "jump_statement", "translation_unit",
  "external_declaration", "function_definition", "opt_parametros",
  "parameter_list", "parameter_declaration", "begin_funcao",
  "begin_parametro", "end_parametro", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323,   324,
     325,   326,   327,   328,   329,   330,   331,   332,   333,   334,
     335,   336,   337,   338,   339,   340,   341,   342,   343,   344,
     345,   346,   347,   348
};
#endif

#define YYPACT_NINF (-259)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-235)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
    1005,  -259,  -259,  -259,  -259,  -259,  -259,  -259,  -259,  -259,
    -259,  -259,  -259,  -259,  -259,  -259,  -259,  -259,  -259,    15,
    -259,  -259,  -259,  -259,  -259,     7,  1005,  1005,  -259,    16,
    -259,  1005,  1005,   237,  -259,  -259,   -41,    55,    51,    31,
    -259,   155,  -259,    69,  -259,   152,   124,  -259,  -259,    46,
    1099,  -259,  -259,  -259,  -259,    55,   145,    -9,  -259,   183,
    -259,  -259,    31,    40,  -259,   657,   136,  -259,  -259,   640,
    1099,  1099,  1031,  -259,    48,  1099,    -5,   944,     6,  -259,
     140,  -259,  -259,  -259,  -259,    86,  -259,  -259,  -259,  -259,
     970,   970,  -259,   510,   559,  -259,  -259,   130,   996,  -259,
      13,   158,   944,  -259,   154,   169,   165,   248,   212,   141,
     167,   151,   215,    34,  -259,  -259,  -259,  -259,    40,   172,
     186,  -259,  1073,  -259,  -259,  -259,   944,   181,  -259,   189,
    -259,     8,  -259,  -259,  -259,  -259,  -259,  -259,   191,   944,
     693,   510,  -259,  -259,  -259,   -37,   104,   201,   944,   243,
    -259,    29,   657,    -1,  -259,   206,   510,  -259,  -259,  -259,
     267,  -259,  -259,  -259,  -259,  -259,  -259,  -259,  -259,  -259,
    -259,  -259,   944,  -259,   944,   944,   944,   944,   944,   944,
     944,   944,   944,   944,   944,   944,   944,   944,   944,   944,
     944,   944,   944,  -259,   152,  -259,   214,   640,  -259,  -259,
      48,  -259,   944,  -259,   274,    89,  -259,    -6,  -259,   223,
     944,  -259,   732,    56,   111,  -259,   227,   768,   228,  -259,
     559,  -259,  -259,  -259,  -259,  -259,   225,  -259,  -259,  -259,
    -259,  -259,   154,   154,   169,   169,   165,   165,   165,   165,
     248,   248,   212,   141,   167,   151,   215,   185,  -259,   328,
    -259,  -259,  -259,  -259,   229,   231,   944,  -259,   230,  -259,
     232,  -259,   234,  -259,   233,   227,   807,   559,  -259,  -259,
    -259,   657,   230,   944,   110,   235,  -259,  -259,   242,   238,
     944,   244,   286,   843,   249,  -259,  -259,   246,  -259,   610,
     190,  -259,    18,  -259,  -259,   245,  -259,  -259,  -259,   419,
    -259,  -259,  -259,  -259,   247,   254,  -259,  -259,   944,  -259,
    -259,  -259,  -259,   261,  -259,   262,    52,  -259,  -259,   610,
     944,  -259,   944,   249,  -259,   251,  -259,   197,  -259,   610,
    -259,   271,  -259,   944,  -259,  -259,   944,   859,   100,  -259,
    -259,  -259,  -259,    58,    59,   610,  -259,  -259,  -259,   266,
     280,   131,  -259,   859,  -259,  -259,   610,  -259,   610,  -259,
     944,   944,  -259,   610,  -259,   918,   277,  -259,   132,   281,
    -259,  -259,   135,   610,  -259,   610,   282,   333,   610,  -259,
    -259,  -259,   284,  -259,   944,   146,  -259,   944,   285,  -259,
    -259
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    97,   100,    98,   106,   136,    93,    94,   105,   114,
     109,    92,   113,   104,   137,    96,   139,    95,   138,     0,
     103,    99,   101,   102,   226,     0,    80,    82,   107,     0,
     108,    84,    86,     0,   223,   225,   131,     0,   142,   145,
      78,     0,    88,    90,   141,     0,     0,    81,    83,   112,
       0,    85,    87,     1,   224,     0,   134,     0,   132,     0,
     149,   147,   146,     0,    79,     0,   142,   140,   235,   228,
       0,   119,     0,   115,     0,   121,     0,     0,     0,   127,
       0,   150,   148,    89,     5,     2,     4,    29,    26,    27,
       0,     0,    25,     0,     0,    24,    28,     0,     0,    11,
      18,    30,     0,    32,    36,    39,    42,    47,    50,    52,
      54,    56,    58,    60,    62,   164,    91,     3,     0,     0,
     229,   230,     0,   118,   111,   116,     0,     0,   122,   124,
     120,     0,   128,    30,    77,   135,   129,   133,   143,     0,
       0,     0,    19,    20,    75,     0,   151,     0,     0,     0,
     166,     0,     0,     0,   171,     0,     0,    22,    13,    14,
       0,    64,    68,    69,    65,    66,    71,    70,    67,    73,
      72,    74,     0,    21,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   233,     0,   236,     0,     0,   110,   125,
       0,   117,     0,   130,     0,     0,     7,     0,    16,     0,
       0,     6,     0,     0,   153,   152,   154,     0,     0,   174,
       0,   165,   167,   170,   172,   184,     0,    12,    63,    33,
      34,    35,    37,    38,    40,    41,    43,    44,    45,    46,
      48,    49,    51,    53,    55,    57,    59,     0,   232,     0,
     227,   231,   123,   126,     0,     9,     0,     8,     0,    76,
      25,   157,     0,   163,     0,   155,     0,     0,    31,   173,
     168,     0,    23,     0,     2,     0,   215,   213,     0,     0,
       0,     0,     0,     0,     0,   200,   194,     0,   188,     0,
       0,   198,     0,   199,   181,     0,   182,   175,   176,     0,
     196,   177,   178,   179,     0,     0,   180,   144,     0,    17,
     161,   158,   156,    25,   159,     0,     0,   169,    61,     0,
       0,   220,     0,     0,   219,     0,   221,     0,   193,     0,
     183,     0,   201,     0,   195,   197,     0,     0,     0,   162,
     160,    15,   190,     0,     0,     0,   218,   222,   192,     0,
       0,     0,   217,     0,    10,   206,     0,   205,     0,   191,
       0,     0,   214,     0,   216,     0,   202,   204,     0,     0,
     208,   212,     0,     0,   207,     0,     0,     0,     0,   210,
     203,   209,   185,   211,     0,     0,   186,     0,     0,   187,
     189
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -259,  -259,  -259,  -259,   -52,  -259,   -76,    92,    94,    77,
      97,   156,   153,   150,   157,   159,  -259,   -62,   -65,  -259,
     -88,  -108,  -236,   -24,  -259,   283,  -259,     1,  -259,  -259,
     275,   -31,    10,  -259,   144,  -259,   293,   -55,     4,  -259,
     -58,   -36,     3,  -259,    11,   138,   139,   -59,    82,   160,
    -259,   199,  -132,  -259,  -259,  -259,  -259,  -259,  -259,    36,
     170,  -259,    79,  -258,  -259,  -259,  -259,  -259,  -259,     9,
    -259,  -259,  -259,  -259,  -259,  -259,  -259,   346,  -259,  -259,
    -259,   187,  -259,  -259,  -259
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    99,   100,   207,   101,   102,   103,   104,   105,   106,
     107,   108,   109,   110,   111,   112,   113,   114,   144,   172,
     290,   135,    24,    25,    41,    42,    26,    71,    28,    29,
      72,    73,    74,   127,   128,    30,    57,    58,    75,    32,
      43,    44,    45,    62,   147,   215,   216,   150,   151,   152,
     153,   154,   293,   294,   117,   385,   295,   296,   297,   329,
     298,   299,   300,   301,   302,   358,   356,   375,   303,   373,
     304,   363,   305,   365,   353,   306,    33,    34,    35,   119,
     120,   121,    46,    69,   196
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
     115,    27,    47,    48,    31,   145,   116,    51,    52,    67,
      56,    38,    56,   291,   223,   134,   129,   210,   199,    36,
      49,    55,    66,   137,   211,   133,   173,    27,    27,   115,
      31,    31,    27,    27,    27,    31,    31,    31,   142,   143,
     218,   125,    61,    60,    66,    78,   157,   191,   256,   131,
     133,   205,    66,   145,    79,   257,    39,   148,   132,    56,
     158,   159,    40,   291,   134,    82,    81,    39,   145,   136,
     118,   203,     5,    40,   133,   208,   137,    37,    50,   352,
      39,   123,   193,   220,    65,   130,   134,   115,   149,    39,
     192,   125,   221,   222,   253,   364,   133,    39,   229,   230,
     231,   126,   160,   146,   247,    39,   220,   228,    70,    59,
      14,  -234,   210,   210,   212,   341,   213,   263,    18,   355,
     357,   194,   133,   133,   133,   133,   133,   133,   133,   133,
     133,   133,   133,   133,   133,   133,   133,   133,   133,   133,
     134,   268,   129,   210,   139,   259,   140,   262,   255,   214,
     133,   146,   209,    39,   210,   115,    66,   331,   248,   354,
      77,   270,   212,   319,   213,   133,   146,   226,   139,   212,
     140,   213,   323,   161,   162,   163,   164,   165,   166,   167,
     168,   169,   170,   171,    68,   210,   210,   342,    80,   210,
     155,   309,   362,   376,    59,   327,   371,   348,   118,   138,
     387,   315,   115,   174,   175,   176,   115,   388,   187,    63,
      64,   318,   317,   359,   177,   178,   214,   189,   134,   188,
     338,   133,   185,   186,   366,   292,   367,   190,   133,   179,
     180,   370,   343,   195,   344,   200,   201,    53,   273,   210,
     197,   379,   202,   380,   210,   332,   383,   219,   351,   204,
      27,   210,   347,    31,   181,   182,   183,   184,   236,   237,
     238,   239,   217,     1,     2,     3,     4,   225,   350,   232,
     233,   227,   368,   234,   235,   292,   249,   372,     5,   254,
       6,     7,   240,   241,   258,   266,   272,   269,   307,   308,
     325,   310,   267,   311,   312,   320,   369,   321,   322,   324,
      27,   330,   328,    31,   349,   333,   346,   336,   374,     8,
       9,    10,    11,    12,   337,    13,    14,    15,    16,   386,
     339,   340,   389,    17,    18,    19,   360,    20,    21,    22,
      23,    84,   274,    86,   361,   377,   382,   381,   384,   244,
     390,   243,    87,   242,   252,   122,    83,   245,    76,   316,
     246,   264,   224,   265,     1,     2,     3,     4,   275,   345,
     276,   277,   278,   279,   280,   281,   250,   282,   283,     5,
     284,     6,     7,    88,    89,    90,    91,    92,   335,    54,
     271,   378,     0,   285,   251,     0,     0,     0,    93,     0,
     249,   286,     0,     0,     0,    95,    96,   287,    97,   288,
       8,     9,    10,    11,    12,    98,    13,    14,    15,    16,
       0,     0,   289,     0,    17,    18,    19,     0,    20,    21,
      22,    23,    84,   274,    86,     0,     0,     0,     0,     0,
       0,     0,     0,    87,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     1,     2,     3,     4,   275,
       0,   276,   277,   278,   279,   280,   281,     0,   282,   283,
       5,   284,     6,     7,    88,    89,    90,    91,    92,     0,
       0,     0,     0,     0,   285,     0,     0,     0,     0,    93,
       0,   249,   334,     0,     0,     0,    95,    96,   287,    97,
     288,     8,     9,    10,    11,    12,    98,    13,    14,    15,
      16,     0,     0,   289,     0,    17,    18,    19,     0,    20,
      21,    22,    23,    84,    85,    86,     0,     0,     0,     0,
       0,     0,     0,     0,    87,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     1,     2,     3,     4,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     5,     0,     0,     0,    88,    89,    90,    91,    92,
       0,     0,    84,    85,    86,     0,     0,     0,     0,     0,
      93,     0,     0,    87,     0,     0,     0,    95,    96,     0,
      97,     0,     8,     9,    10,     0,    12,    98,    13,    14,
       0,     0,     0,     0,     0,     0,     0,    18,    19,     0,
      20,    21,    22,    23,    88,    89,    90,    91,    92,     0,
       0,     0,     0,    84,   274,    86,     0,   148,     0,    93,
       0,    94,     0,     0,    87,     0,    95,    96,     0,    97,
       0,     0,     0,     0,     0,     0,    98,     0,     0,     0,
     275,     0,   276,   277,   278,   279,   280,   281,   149,   282,
     283,     0,   284,     0,     0,    88,    89,    90,    91,    92,
      84,    85,    86,     0,     0,   285,     1,     2,     3,     4,
      93,    87,   249,     0,     0,     0,     0,    95,    96,   287,
      97,   288,     0,     0,     0,     0,     0,    98,     0,     0,
       0,     0,     0,     0,   289,     0,    84,    85,    86,     0,
       0,     0,    88,    89,    90,    91,    92,    87,     0,     0,
       0,     0,     8,     9,    10,     0,    12,    93,    13,    94,
       0,     0,     0,     0,    95,    96,     0,    97,    19,     0,
      20,    21,    22,    23,    98,    84,    85,    86,    88,    89,
      90,    91,    92,     0,     0,     0,    87,     0,     0,     0,
       0,     0,     0,    93,   206,     0,     0,     0,     0,     0,
      95,    96,     0,    97,     0,     0,     0,     0,     0,     0,
      98,    84,    85,    86,     0,     0,     0,    88,    89,    90,
      91,   260,    87,     0,     0,     0,     0,     0,     0,     0,
       0,   261,    93,     0,     0,     0,     0,     0,     0,    95,
      96,     0,    97,     0,     0,     0,     0,     0,     0,    98,
      84,    85,    86,    88,    89,    90,    91,    92,     0,     0,
       0,    87,     0,     0,     0,     0,     0,     0,    93,     0,
     267,     0,     0,     0,     0,    95,    96,     0,    97,     0,
       0,     0,     0,     0,     0,    98,    84,    85,    86,     0,
       0,     0,    88,    89,    90,    91,   313,    87,     0,     0,
       0,     0,    84,    85,    86,     0,   314,    93,     0,     0,
       0,     0,     0,    87,    95,    96,     0,    97,     0,     0,
       0,     0,     0,     0,    98,     0,     0,     0,    88,    89,
      90,    91,    92,     0,     0,     0,     0,     0,   326,     0,
       0,     0,     0,    93,    88,    89,    90,    91,    92,     0,
      95,    96,     0,    97,   285,     0,     0,     0,     0,    93,
      98,    84,    85,    86,     0,     0,    95,    96,     0,    97,
       0,     0,    87,     0,     0,     0,    98,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    84,    85,    86,
       0,     0,     0,     0,     0,     0,     0,     0,    87,     0,
       0,     0,     0,    88,    89,    90,    91,    92,     0,     0,
       0,     0,     0,    84,    85,    86,     0,     0,    93,   371,
       0,     0,     0,     0,    87,    95,    96,     0,    97,    88,
      89,    90,    91,    92,     0,    98,     0,     0,     0,    84,
      85,    86,     0,     0,    93,     0,     0,     0,     0,     0,
      87,    95,    96,     0,    97,    88,    89,    90,    91,    92,
       0,    98,     0,     0,     0,     0,     0,     0,     0,     0,
     141,     1,     2,     3,     4,     0,     0,    95,    96,     0,
      97,    88,    89,    90,    91,    92,     5,    98,     6,     7,
       0,     0,     0,     0,     0,     0,   156,     1,     2,     3,
       4,     0,     0,    95,    96,     0,    97,     0,     0,     0,
       0,     0,     5,    98,     0,     0,     0,     8,     9,    10,
      11,    12,     0,    13,    14,    15,    16,     0,     0,     0,
       0,    17,    18,    19,   124,    20,    21,    22,    23,     1,
       2,     3,     4,     8,     9,    10,     0,    12,     0,    13,
      14,     0,     0,     0,     5,     0,     0,     0,    18,    19,
       0,    20,    21,    22,    23,     1,     2,     3,     4,     0,
       0,     0,     0,     0,     0,     0,   198,     0,     0,     0,
       5,     0,     0,     0,     0,     8,     9,    10,     0,    12,
       0,    13,    14,     0,     0,     0,     0,     0,     0,     0,
      18,    19,     0,    20,    21,    22,    23,     0,     0,     0,
       0,     8,     9,    10,     0,    12,     0,    13,    14,     0,
       0,     0,     0,     0,     0,     0,    18,    19,     0,    20,
      21,    22,    23
};

static const yytype_int16 yycheck[] =
{
      65,     0,    26,    27,     0,    93,    65,    31,    32,    45,
       4,     4,     4,   249,    15,    77,    74,    54,   126,     4,
       4,    62,     4,    78,    61,    77,   102,    26,    27,    94,
      26,    27,    31,    32,    33,    31,    32,    33,    90,    91,
     148,    72,    39,    39,     4,    54,    98,    13,    54,    54,
     102,   139,     4,   141,    63,    61,    49,    58,    63,     4,
      47,    48,    55,   299,   126,    62,    62,    49,   156,    63,
      69,    63,    41,    55,   126,   140,   131,    62,    62,   337,
      49,    71,   118,    54,    15,    75,   148,   152,    89,    49,
      56,   122,    63,   152,   202,   353,   148,    49,   174,   175,
     176,    53,    89,    93,   192,    49,    54,   172,    62,    58,
      79,    60,    54,    54,    58,    63,    60,    61,    87,    61,
      61,   118,   174,   175,   176,   177,   178,   179,   180,   181,
     182,   183,   184,   185,   186,   187,   188,   189,   190,   191,
     202,   217,   200,    54,    58,   210,    60,   212,    59,   146,
     202,   141,   141,    49,    54,   220,     4,   289,   194,    59,
      15,   220,    58,    53,    60,   217,   156,   156,    58,    58,
      60,    60,   280,    15,    16,    17,    18,    19,    20,    21,
      22,    23,    24,    25,    60,    54,    54,   319,     5,    54,
      60,   256,    61,    61,    58,   283,    61,   329,   197,    59,
      54,   266,   267,    49,    50,    51,   271,    61,    67,    54,
      55,   273,   271,   345,    45,    46,   213,    66,   280,    52,
     308,   273,    10,    11,   356,   249,   358,    12,   280,    64,
      65,   363,   320,    61,   322,    54,    55,     0,    53,    54,
      54,   373,    53,   375,    54,    55,   378,     4,   336,    58,
     249,    54,    55,   249,     6,     7,     8,     9,   181,   182,
     183,   184,    61,    26,    27,    28,    29,    61,   333,   177,
     178,     4,   360,   179,   180,   299,    62,   365,    41,     5,
      43,    44,   185,   186,    61,    58,    61,    59,    59,    58,
       4,    59,    62,    59,    61,    60,   361,    55,    60,    55,
     299,    55,    53,   299,    33,    60,    55,    60,    31,    72,
      73,    74,    75,    76,    60,    78,    79,    80,    81,   384,
      59,    59,   387,    86,    87,    88,    60,    90,    91,    92,
      93,     3,     4,     5,    54,    54,     3,    55,    54,   189,
      55,   188,    14,   187,   200,    70,    63,   190,    55,   267,
     191,   213,   153,   214,    26,    27,    28,    29,    30,   323,
      32,    33,    34,    35,    36,    37,   196,    39,    40,    41,
      42,    43,    44,    45,    46,    47,    48,    49,   299,    33,
     220,   372,    -1,    55,   197,    -1,    -1,    -1,    60,    -1,
      62,    63,    -1,    -1,    -1,    67,    68,    69,    70,    71,
      72,    73,    74,    75,    76,    77,    78,    79,    80,    81,
      -1,    -1,    84,    -1,    86,    87,    88,    -1,    90,    91,
      92,    93,     3,     4,     5,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    14,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    26,    27,    28,    29,    30,
      -1,    32,    33,    34,    35,    36,    37,    -1,    39,    40,
      41,    42,    43,    44,    45,    46,    47,    48,    49,    -1,
      -1,    -1,    -1,    -1,    55,    -1,    -1,    -1,    -1,    60,
      -1,    62,    63,    -1,    -1,    -1,    67,    68,    69,    70,
      71,    72,    73,    74,    75,    76,    77,    78,    79,    80,
      81,    -1,    -1,    84,    -1,    86,    87,    88,    -1,    90,
      91,    92,    93,     3,     4,     5,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    14,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    26,    27,    28,    29,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    41,    -1,    -1,    -1,    45,    46,    47,    48,    49,
      -1,    -1,     3,     4,     5,    -1,    -1,    -1,    -1,    -1,
      60,    -1,    -1,    14,    -1,    -1,    -1,    67,    68,    -1,
      70,    -1,    72,    73,    74,    -1,    76,    77,    78,    79,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    87,    88,    -1,
      90,    91,    92,    93,    45,    46,    47,    48,    49,    -1,
      -1,    -1,    -1,     3,     4,     5,    -1,    58,    -1,    60,
      -1,    62,    -1,    -1,    14,    -1,    67,    68,    -1,    70,
      -1,    -1,    -1,    -1,    -1,    -1,    77,    -1,    -1,    -1,
      30,    -1,    32,    33,    34,    35,    36,    37,    89,    39,
      40,    -1,    42,    -1,    -1,    45,    46,    47,    48,    49,
       3,     4,     5,    -1,    -1,    55,    26,    27,    28,    29,
      60,    14,    62,    -1,    -1,    -1,    -1,    67,    68,    69,
      70,    71,    -1,    -1,    -1,    -1,    -1,    77,    -1,    -1,
      -1,    -1,    -1,    -1,    84,    -1,     3,     4,     5,    -1,
      -1,    -1,    45,    46,    47,    48,    49,    14,    -1,    -1,
      -1,    -1,    72,    73,    74,    -1,    76,    60,    78,    62,
      -1,    -1,    -1,    -1,    67,    68,    -1,    70,    88,    -1,
      90,    91,    92,    93,    77,     3,     4,     5,    45,    46,
      47,    48,    49,    -1,    -1,    -1,    14,    -1,    -1,    -1,
      -1,    -1,    -1,    60,    61,    -1,    -1,    -1,    -1,    -1,
      67,    68,    -1,    70,    -1,    -1,    -1,    -1,    -1,    -1,
      77,     3,     4,     5,    -1,    -1,    -1,    45,    46,    47,
      48,    49,    14,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    59,    60,    -1,    -1,    -1,    -1,    -1,    -1,    67,
      68,    -1,    70,    -1,    -1,    -1,    -1,    -1,    -1,    77,
       3,     4,     5,    45,    46,    47,    48,    49,    -1,    -1,
      -1,    14,    -1,    -1,    -1,    -1,    -1,    -1,    60,    -1,
      62,    -1,    -1,    -1,    -1,    67,    68,    -1,    70,    -1,
      -1,    -1,    -1,    -1,    -1,    77,     3,     4,     5,    -1,
      -1,    -1,    45,    46,    47,    48,    49,    14,    -1,    -1,
      -1,    -1,     3,     4,     5,    -1,    59,    60,    -1,    -1,
      -1,    -1,    -1,    14,    67,    68,    -1,    70,    -1,    -1,
      -1,    -1,    -1,    -1,    77,    -1,    -1,    -1,    45,    46,
      47,    48,    49,    -1,    -1,    -1,    -1,    -1,    55,    -1,
      -1,    -1,    -1,    60,    45,    46,    47,    48,    49,    -1,
      67,    68,    -1,    70,    55,    -1,    -1,    -1,    -1,    60,
      77,     3,     4,     5,    -1,    -1,    67,    68,    -1,    70,
      -1,    -1,    14,    -1,    -1,    -1,    77,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,     3,     4,     5,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    14,    -1,
      -1,    -1,    -1,    45,    46,    47,    48,    49,    -1,    -1,
      -1,    -1,    -1,     3,     4,     5,    -1,    -1,    60,    61,
      -1,    -1,    -1,    -1,    14,    67,    68,    -1,    70,    45,
      46,    47,    48,    49,    -1,    77,    -1,    -1,    -1,     3,
       4,     5,    -1,    -1,    60,    -1,    -1,    -1,    -1,    -1,
      14,    67,    68,    -1,    70,    45,    46,    47,    48,    49,
      -1,    77,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      60,    26,    27,    28,    29,    -1,    -1,    67,    68,    -1,
      70,    45,    46,    47,    48,    49,    41,    77,    43,    44,
      -1,    -1,    -1,    -1,    -1,    -1,    60,    26,    27,    28,
      29,    -1,    -1,    67,    68,    -1,    70,    -1,    -1,    -1,
      -1,    -1,    41,    77,    -1,    -1,    -1,    72,    73,    74,
      75,    76,    -1,    78,    79,    80,    81,    -1,    -1,    -1,
      -1,    86,    87,    88,    63,    90,    91,    92,    93,    26,
      27,    28,    29,    72,    73,    74,    -1,    76,    -1,    78,
      79,    -1,    -1,    -1,    41,    -1,    -1,    -1,    87,    88,
      -1,    90,    91,    92,    93,    26,    27,    28,    29,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    63,    -1,    -1,    -1,
      41,    -1,    -1,    -1,    -1,    72,    73,    74,    -1,    76,
      -1,    78,    79,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      87,    88,    -1,    90,    91,    92,    93,    -1,    -1,    -1,
      -1,    72,    73,    74,    -1,    76,    -1,    78,    79,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    87,    88,    -1,    90,
      91,    92,    93
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    26,    27,    28,    29,    41,    43,    44,    72,    73,
      74,    75,    76,    78,    79,    80,    81,    86,    87,    88,
      90,    91,    92,    93,   116,   117,   120,   121,   122,   123,
     129,   132,   133,   170,   171,   172,     4,    62,     4,    49,
      55,   118,   119,   134,   135,   136,   176,   117,   117,     4,
      62,   117,   117,     0,   171,    62,     4,   130,   131,    58,
     132,   136,   137,    54,    55,    15,     4,   135,    60,   177,
      62,   121,   124,   125,   126,   132,   130,    15,    54,    63,
       5,   132,   136,   119,     3,     4,     5,    14,    45,    46,
      47,    48,    49,    60,    62,    67,    68,    70,    77,    95,
      96,    98,    99,   100,   101,   102,   103,   104,   105,   106,
     107,   108,   109,   110,   111,   112,   141,   148,   121,   173,
     174,   175,   124,   126,    63,   125,    53,   127,   128,   134,
     126,    54,    63,    98,   111,   115,    63,   131,    59,    58,
      60,    60,    98,    98,   112,   114,   126,   138,    58,    89,
     141,   142,   143,   144,   145,    60,    60,    98,    47,    48,
      89,    15,    16,    17,    18,    19,    20,    21,    22,    23,
      24,    25,   113,   100,    49,    50,    51,    45,    46,    64,
      65,     6,     7,     8,     9,    10,    11,    67,    52,    66,
      12,    13,    56,   135,   136,    61,   178,    54,    63,   115,
      54,    55,    53,    63,    58,   114,    61,    97,   112,   138,
      54,    61,    58,    60,   136,   139,   140,    61,   115,     4,
      54,    63,   141,    15,   145,    61,   138,     4,   112,   100,
     100,   100,   101,   101,   102,   102,   103,   103,   103,   103,
     104,   104,   105,   106,   107,   108,   109,   114,   135,    62,
     154,   175,   128,   115,     5,    59,    54,    61,    61,   112,
      49,    59,   112,    61,   139,   140,    58,    62,   100,    59,
     141,   143,    61,    53,     4,    30,    32,    33,    34,    35,
      36,    37,    39,    40,    42,    55,    63,    69,    71,    84,
     114,   116,   117,   146,   147,   150,   151,   152,   154,   155,
     156,   157,   158,   162,   164,   166,   169,    59,    58,   112,
      59,    59,    61,    49,    59,   112,   142,   141,   111,    53,
      60,    55,    60,   115,    55,     4,    55,   114,    53,   153,
      55,   146,    55,    60,    63,   156,    60,    60,   114,    59,
      59,    63,   146,   114,   114,   153,    55,    55,   146,    33,
     112,   114,   157,   168,    59,    61,   160,    61,   159,   146,
      60,    54,    61,   165,   157,   167,   146,   146,   114,   112,
     146,    61,   114,   163,    31,   161,    61,    54,   163,   146,
     146,    55,     3,   146,    54,   149,   112,    54,    61,   112,
      55
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    94,    95,    95,    95,    95,    95,    95,    95,    95,
      95,    96,    96,    96,    96,    96,    97,    97,    98,    98,
      98,    98,    98,    98,    99,    99,    99,    99,    99,    99,
     100,   100,   101,   101,   101,   101,   102,   102,   102,   103,
     103,   103,   104,   104,   104,   104,   104,   105,   105,   105,
     106,   106,   107,   107,   108,   108,   109,   109,   110,   110,
     111,   111,   112,   112,   113,   113,   113,   113,   113,   113,
     113,   113,   113,   113,   113,   114,   114,   115,   116,   116,
     117,   117,   117,   117,   117,   117,   117,   117,   118,   118,
     119,   119,   120,   120,   120,   120,   120,   121,   121,   121,
     121,   121,   121,   121,   121,   121,   121,   121,   121,   121,
     122,   122,   122,   123,   123,   124,   124,   125,   126,   126,
     126,   126,   127,   127,   128,   128,   128,   129,   129,   129,
     129,   129,   130,   130,   131,   131,   132,   132,   132,   133,
     134,   134,   135,   135,   135,   136,   136,   136,   136,   137,
     137,   138,   138,   139,   139,   139,   140,   140,   140,   140,
     140,   140,   140,   140,   141,   141,   142,   142,   142,   142,
     143,   144,   144,   145,   145,   146,   146,   146,   146,   146,
     146,   146,   146,   147,   148,   149,   149,   149,   150,   151,
     152,   152,   152,   153,   154,   154,   155,   155,   156,   156,
     157,   157,   158,   158,   158,   159,   160,   161,   162,   162,
     162,   162,   163,   164,   165,   166,   167,   168,   169,   169,
     169,   169,   169,   170,   170,   171,   171,   172,   173,   173,
     174,   174,   175,   175,   176,   177,   178
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     1,     1,     3,     3,     4,     4,
       7,     1,     3,     2,     2,     6,     1,     3,     1,     2,
       2,     2,     2,     4,     1,     1,     1,     1,     1,     1,
       1,     4,     1,     3,     3,     3,     1,     3,     3,     1,
       3,     3,     1,     3,     3,     3,     3,     1,     3,     3,
       1,     3,     1,     3,     1,     3,     1,     3,     1,     3,
       1,     5,     1,     3,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     3,     1,     2,     3,
       1,     2,     1,     2,     1,     2,     1,     2,     1,     3,
       1,     3,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       5,     4,     2,     1,     1,     1,     2,     3,     2,     1,
       2,     1,     1,     3,     1,     2,     3,     4,     5,     5,
       6,     2,     1,     3,     1,     3,     1,     1,     1,     1,
       2,     1,     1,     4,     7,     1,     2,     2,     3,     1,
       2,     1,     2,     1,     1,     2,     3,     2,     3,     3,
       4,     3,     4,     2,     1,     3,     1,     2,     3,     4,
       2,     1,     2,     3,     2,     1,     1,     1,     1,     1,
       1,     1,     1,     2,     3,     0,     2,     3,     1,    10,
       3,     4,     3,     1,     2,     3,     1,     2,     1,     1,
       1,     2,     5,     7,     5,     1,     1,     1,     5,     7,
       6,     7,     1,     1,     1,     1,     1,     1,     3,     2,
       2,     2,     3,     1,     2,     1,     1,     6,     0,     1,
       1,     3,     3,     2,     1,     1,     1
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        YY_LAC_DISCARD ("YYBACKUP");                              \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
# ifndef YY_LOCATION_PRINT
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif


# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yykind < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yykind], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


/* Given a state stack such that *YYBOTTOM is its bottom, such that
   *YYTOP is either its top or is YYTOP_EMPTY to indicate an empty
   stack, and such that *YYCAPACITY is the maximum number of elements it
   can hold without a reallocation, make sure there is enough room to
   store YYADD more elements.  If not, allocate a new stack using
   YYSTACK_ALLOC, copy the existing elements, and adjust *YYBOTTOM,
   *YYTOP, and *YYCAPACITY to reflect the new capacity and memory
   location.  If *YYBOTTOM != YYBOTTOM_NO_FREE, then free the old stack
   using YYSTACK_FREE.  Return 0 if successful or if no reallocation is
   required.  Return YYENOMEM if memory is exhausted.  */
static int
yy_lac_stack_realloc (YYPTRDIFF_T *yycapacity, YYPTRDIFF_T yyadd,
#if YYDEBUG
                      char const *yydebug_prefix,
                      char const *yydebug_suffix,
#endif
                      yy_state_t **yybottom,
                      yy_state_t *yybottom_no_free,
                      yy_state_t **yytop, yy_state_t *yytop_empty)
{
  YYPTRDIFF_T yysize_old =
    *yytop == yytop_empty ? 0 : *yytop - *yybottom + 1;
  YYPTRDIFF_T yysize_new = yysize_old + yyadd;
  if (*yycapacity < yysize_new)
    {
      YYPTRDIFF_T yyalloc = 2 * yysize_new;
      yy_state_t *yybottom_new;
      /* Use YYMAXDEPTH for maximum stack size given that the stack
         should never need to grow larger than the main state stack
         needs to grow without LAC.  */
      if (YYMAXDEPTH < yysize_new)
        {
          YYDPRINTF ((stderr, "%smax size exceeded%s", yydebug_prefix,
                      yydebug_suffix));
          return YYENOMEM;
        }
      if (YYMAXDEPTH < yyalloc)
        yyalloc = YYMAXDEPTH;
      yybottom_new =
        YY_CAST (yy_state_t *,
                 YYSTACK_ALLOC (YY_CAST (YYSIZE_T,
                                         yyalloc * YYSIZEOF (*yybottom_new))));
      if (!yybottom_new)
        {
          YYDPRINTF ((stderr, "%srealloc failed%s", yydebug_prefix,
                      yydebug_suffix));
          return YYENOMEM;
        }
      if (*yytop != yytop_empty)
        {
          YYCOPY (yybottom_new, *yybottom, yysize_old);
          *yytop = yybottom_new + (yysize_old - 1);
        }
      if (*yybottom != yybottom_no_free)
        YYSTACK_FREE (*yybottom);
      *yybottom = yybottom_new;
      *yycapacity = yyalloc;
    }
  return 0;
}

/* Establish the initial context for the current lookahead if no initial
   context is currently established.

   We define a context as a snapshot of the parser stacks.  We define
   the initial context for a lookahead as the context in which the
   parser initially examines that lookahead in order to select a
   syntactic action.  Thus, if the lookahead eventually proves
   syntactically unacceptable (possibly in a later context reached via a
   series of reductions), the initial context can be used to determine
   the exact set of tokens that would be syntactically acceptable in the
   lookahead's place.  Moreover, it is the context after which any
   further semantic actions would be erroneous because they would be
   determined by a syntactically unacceptable token.

   YY_LAC_ESTABLISH should be invoked when a reduction is about to be
   performed in an inconsistent state (which, for the purposes of LAC,
   includes consistent states that don't know they're consistent because
   their default reductions have been disabled).  Iff there is a
   lookahead token, it should also be invoked before reporting a syntax
   error.  This latter case is for the sake of the debugging output.

   For parse.lac=full, the implementation of YY_LAC_ESTABLISH is as
   follows.  If no initial context is currently established for the
   current lookahead, then check if that lookahead can eventually be
   shifted if syntactic actions continue from the current context.
   Report a syntax error if it cannot.  */
#define YY_LAC_ESTABLISH                                                \
do {                                                                    \
  if (!yy_lac_established)                                              \
    {                                                                   \
      YYDPRINTF ((stderr,                                               \
                  "LAC: initial context established for %s\n",          \
                  yysymbol_name (yytoken)));                            \
      yy_lac_established = 1;                                           \
      switch (yy_lac (yyesa, &yyes, &yyes_capacity, yyssp, yytoken))    \
        {                                                               \
        case YYENOMEM:                                                  \
          goto yyexhaustedlab;                                          \
        case 1:                                                         \
          goto yyerrlab;                                                \
        }                                                               \
    }                                                                   \
} while (0)

/* Discard any previous initial lookahead context because of Event,
   which may be a lookahead change or an invalidation of the currently
   established initial context for the current lookahead.

   The most common example of a lookahead change is a shift.  An example
   of both cases is syntax error recovery.  That is, a syntax error
   occurs when the lookahead is syntactically erroneous for the
   currently established initial context, so error recovery manipulates
   the parser stacks to try to find a new initial context in which the
   current lookahead is syntactically acceptable.  If it fails to find
   such a context, it discards the lookahead.  */
#if YYDEBUG
# define YY_LAC_DISCARD(Event)                                           \
do {                                                                     \
  if (yy_lac_established)                                                \
    {                                                                    \
      YYDPRINTF ((stderr, "LAC: initial context discarded due to "       \
                  Event "\n"));                                          \
      yy_lac_established = 0;                                            \
    }                                                                    \
} while (0)
#else
# define YY_LAC_DISCARD(Event) yy_lac_established = 0
#endif

/* Given the stack whose top is *YYSSP, return 0 iff YYTOKEN can
   eventually (after perhaps some reductions) be shifted, return 1 if
   not, or return YYENOMEM if memory is exhausted.  As preconditions and
   postconditions: *YYES_CAPACITY is the allocated size of the array to
   which *YYES points, and either *YYES = YYESA or *YYES points to an
   array allocated with YYSTACK_ALLOC.  yy_lac may overwrite the
   contents of either array, alter *YYES and *YYES_CAPACITY, and free
   any old *YYES other than YYESA.  */
static int
yy_lac (yy_state_t *yyesa, yy_state_t **yyes,
        YYPTRDIFF_T *yyes_capacity, yy_state_t *yyssp, yysymbol_kind_t yytoken)
{
  yy_state_t *yyes_prev = yyssp;
  yy_state_t *yyesp = yyes_prev;
  /* Reduce until we encounter a shift and thereby accept the token.  */
  YYDPRINTF ((stderr, "LAC: checking lookahead %s:", yysymbol_name (yytoken)));
  if (yytoken == YYSYMBOL_YYUNDEF)
    {
      YYDPRINTF ((stderr, " Always Err\n"));
      return 1;
    }
  while (1)
    {
      int yyrule = yypact[+*yyesp];
      if (yypact_value_is_default (yyrule)
          || (yyrule += yytoken) < 0 || YYLAST < yyrule
          || yycheck[yyrule] != yytoken)
        {
          /* Use the default action.  */
          yyrule = yydefact[+*yyesp];
          if (yyrule == 0)
            {
              YYDPRINTF ((stderr, " Err\n"));
              return 1;
            }
        }
      else
        {
          /* Use the action from yytable.  */
          yyrule = yytable[yyrule];
          if (yytable_value_is_error (yyrule))
            {
              YYDPRINTF ((stderr, " Err\n"));
              return 1;
            }
          if (0 < yyrule)
            {
              YYDPRINTF ((stderr, " S%d\n", yyrule));
              return 0;
            }
          yyrule = -yyrule;
        }
      /* By now we know we have to simulate a reduce.  */
      YYDPRINTF ((stderr, " R%d", yyrule - 1));
      {
        /* Pop the corresponding number of values from the stack.  */
        YYPTRDIFF_T yylen = yyr2[yyrule];
        /* First pop from the LAC stack as many tokens as possible.  */
        if (yyesp != yyes_prev)
          {
            YYPTRDIFF_T yysize = yyesp - *yyes + 1;
            if (yylen < yysize)
              {
                yyesp -= yylen;
                yylen = 0;
              }
            else
              {
                yyesp = yyes_prev;
                yylen -= yysize;
              }
          }
        /* Only afterwards look at the main stack.  */
        if (yylen)
          yyesp = yyes_prev -= yylen;
      }
      /* Push the resulting state of the reduction.  */
      {
        yy_state_fast_t yystate;
        {
          const int yylhs = yyr1[yyrule] - YYNTOKENS;
          const int yyi = yypgoto[yylhs] + *yyesp;
          yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyesp
                     ? yytable[yyi]
                     : yydefgoto[yylhs]);
        }
        if (yyesp == yyes_prev)
          {
            yyesp = *yyes;
            YY_IGNORE_USELESS_CAST_BEGIN
            *yyesp = YY_CAST (yy_state_t, yystate);
            YY_IGNORE_USELESS_CAST_END
          }
        else
          {
            if (yy_lac_stack_realloc (yyes_capacity, 1,
#if YYDEBUG
                                      " (", ")",
#endif
                                      yyes, yyesa, &yyesp, yyes_prev))
              {
                YYDPRINTF ((stderr, "\n"));
                return YYENOMEM;
              }
            YY_IGNORE_USELESS_CAST_BEGIN
            *++yyesp = YY_CAST (yy_state_t, yystate);
            YY_IGNORE_USELESS_CAST_END
          }
        YYDPRINTF ((stderr, " G%d", yystate));
      }
    }
}

/* Context of a parse error.  */
typedef struct
{
  yy_state_t *yyssp;
  yy_state_t *yyesa;
  yy_state_t **yyes;
  YYPTRDIFF_T *yyes_capacity;
  yysymbol_kind_t yytoken;
} yypcontext_t;

/* Put in YYARG at most YYARGN of the expected tokens given the
   current YYCTX, and return the number of tokens stored in YYARG.  If
   YYARG is null, return the number of expected tokens (guaranteed to
   be less than YYNTOKENS).  Return YYENOMEM on memory exhaustion.
   Return 0 if there are more than YYARGN expected tokens, yet fill
   YYARG up to YYARGN. */
static int
yypcontext_expected_tokens (const yypcontext_t *yyctx,
                            yysymbol_kind_t yyarg[], int yyargn)
{
  /* Actual size of YYARG. */
  int yycount = 0;

  int yyx;
  for (yyx = 0; yyx < YYNTOKENS; ++yyx)
    {
      yysymbol_kind_t yysym = YY_CAST (yysymbol_kind_t, yyx);
      if (yysym != YYSYMBOL_YYerror && yysym != YYSYMBOL_YYUNDEF)
        switch (yy_lac (yyctx->yyesa, yyctx->yyes, yyctx->yyes_capacity, yyctx->yyssp, yysym))
          {
          case YYENOMEM:
            return YYENOMEM;
          case 1:
            continue;
          default:
            if (!yyarg)
              ++yycount;
            else if (yycount == yyargn)
              return 0;
            else
              yyarg[yycount++] = yysym;
          }
    }
  if (yyarg && yycount == 0 && 0 < yyargn)
    yyarg[0] = YYSYMBOL_YYEMPTY;
  return yycount;
}




#ifndef yystrlen
# if defined __GLIBC__ && defined _STRING_H
#  define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
# else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
# endif
#endif

#ifndef yystpcpy
# if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#  define yystpcpy stpcpy
# else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
# endif
#endif

#ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;
      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
#endif


static int
yy_syntax_error_arguments (const yypcontext_t *yyctx,
                           yysymbol_kind_t yyarg[], int yyargn)
{
  /* Actual size of YYARG. */
  int yycount = 0;
  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
       In the first two cases, it might appear that the current syntax
       error should have been detected in the previous state when yy_lac
       was invoked.  However, at that time, there might have been a
       different syntax error that discarded a different initial context
       during error recovery, leaving behind the current lookahead.
  */
  if (yyctx->yytoken != YYSYMBOL_YYEMPTY)
    {
      int yyn;
      YYDPRINTF ((stderr, "Constructing syntax error message\n"));
      if (yyarg)
        yyarg[yycount] = yyctx->yytoken;
      ++yycount;
      yyn = yypcontext_expected_tokens (yyctx,
                                        yyarg ? yyarg + 1 : yyarg, yyargn - 1);
      if (yyn == YYENOMEM)
        return YYENOMEM;
      else if (yyn == 0)
        YYDPRINTF ((stderr, "No expected tokens.\n"));
      else
        yycount += yyn;
    }
  return yycount;
}

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.  In order to see if a particular token T is a
   valid looakhead, invoke yy_lac (YYESA, YYES, YYES_CAPACITY, YYSSP, T).

   Return 0 if *YYMSG was successfully written.  Return -1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return YYENOMEM if the
   required number of bytes is too large to store or if
   yy_lac returned YYENOMEM.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                const yypcontext_t *yyctx)
{
  enum { YYARGS_MAX = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  yysymbol_kind_t yyarg[YYARGS_MAX];
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* Actual size of YYARG. */
  int yycount = yy_syntax_error_arguments (yyctx, yyarg, YYARGS_MAX);
  if (yycount == YYENOMEM)
    return YYENOMEM;

  switch (yycount)
    {
#define YYCASE_(N, S)                       \
      case N:                               \
        yyformat = S;                       \
        break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
#undef YYCASE_
    }

  /* Compute error message size.  Don't count the "%s"s, but reserve
     room for the terminator.  */
  yysize = yystrlen (yyformat) - 2 * yycount + 1;
  {
    int yyi;
    for (yyi = 0; yyi < yycount; ++yyi)
      {
        YYPTRDIFF_T yysize1
          = yysize + yytnamerr (YY_NULLPTR, yytname[yyarg[yyi]]);
        if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
          yysize = yysize1;
        else
          return YYENOMEM;
      }
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return -1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yytname[yyarg[yyi++]]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize;

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    yy_state_t yyesa[20];
    yy_state_t *yyes;
    YYPTRDIFF_T yyes_capacity;

  /* Whether LAC context is established.  A Boolean.  */
  int yy_lac_established = 0;
  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yynerrs = 0;
  yystate = 0;
  yyerrstatus = 0;

  yystacksize = YYINITDEPTH;
  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;

  yyes = yyesa;
  yyes_capacity = 20;
  if (YYMAXDEPTH < yyes_capacity)
    yyes_capacity = YYMAXDEPTH;


  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    {
      YY_LAC_ESTABLISH;
      goto yydefault;
    }
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      YY_LAC_ESTABLISH;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  YY_LAC_DISCARD ("shift");
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  {
    int yychar_backup = yychar;
    switch (yyn)
      {
  case 2:
#line 215 "parser.y"
                     { 
		msg_sintatico("IDENTIFIER");
        if(referenciando(*(yyvsp[0].string)))
        push(to_str(t->busca(*(yyvsp[0].string), &declarado)->endereco), 1);
        initialization_size = 1;
	}
#line 2514 "parser.cpp"
    break;

  case 3:
#line 221 "parser.y"
                      {
		msg_sintatico("getch_statement");
    }
#line 2522 "parser.cpp"
    break;

  case 4:
#line 224 "parser.y"
                { 
		msg_sintatico("CONSTANT");
        push(*(yyvsp[0].string), 2); 
        initialization_size = 1;
	}
#line 2532 "parser.cpp"
    break;

  case 5:
#line 229 "parser.y"
                        { 
		msg_sintatico("STRING_LITERAL");
        if(begin_printf)
            correcao_printf_string = stack;

        string aux = *(yyvsp[0].string), aux2; 
        for(int i=0; i < aux.size(); i++) { 
            aux2 = aux[i]; 
            push(aux2, 3); 
        }
        push("0", 2);   // coloca um \0 no fim da string
        initialization_size = aux.size()+1;
	}
#line 2550 "parser.cpp"
    break;

  case 6:
#line 242 "parser.y"
                                                        { 
		msg_sintatico("ABRE_PARENTESES expression FECHA_PARENTESES");
        /*
            NAO PRECISA FAZER NADA
        */
	}
#line 2561 "parser.cpp"
    break;

  case 7:
#line 248 "parser.y"
                                                        { 
        msg_sintatico("primary_expression: IDENTIFIER ABRE_PARENTESES args_list FECHA_PARENTESES");

        referencia_funcao(*(yyvsp[-2].string));

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() ==0) {
            msg_instrucao("; call funcao: " + *(yyvsp[-2].string));
            msg_instrucao("; salvando as variaveis do escopo");

            // salva as variaveis do escopo para permitir recursao
            vector<Entrada> lista = t->variaveis_escopo();
            for(int i = 0; i < lista.size(); i++) {
                cout << "load r0, " << lista[i].endereco << endl
                     << "push r0" << endl;
            }

            msg_instrucao("; nao tem parametros");

            cout << "call " << "__function_label_" << *(yyvsp[-2].string) << "__" << endl;

            msg_instrucao("; recupera as variaveis do escopo da funcao");

            // recupera as variaveis do escopo para permitir recursao
            for(int i = lista.size()-1; i >= 0 ; i--) {
                cout << "pop r0" << endl
                     << "store " << lista[i].endereco << ", r0" << endl;
            }
            cout << endl;
        }
        arg_list.clear();
        initialization_size = 1;
	}
#line 2598 "parser.cpp"
    break;

  case 8:
#line 280 "parser.y"
                                                                                { 
		msg_sintatico("postfix_expression ABRE_PARENTESES argument_expression_list FECHA_PARENTESES");

        referencia_funcao(*(yyvsp[-3].string));

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() ==0) {
            msg_instrucao("; call funcao: " + *(yyvsp[-3].string));
            msg_instrucao("; salvando as variaveis do escopo");

            // salva as variaveis do escopo para permitir recursao
            vector<Entrada> lista = t->variaveis_escopo();
            for(int i = 0; i < lista.size(); i++) {
                cout << "load r0, " << lista[i].endereco << endl
                     << "push r0" << endl;
            }

            msg_instrucao("; salvando os argumentos da funcao: " + f->parametros.size());

            // salva os argumentos da funcao
            for(int i = 0; i < arg_list.size(); i++) {
                cout << "load r0, " << arg_list[i] << endl
                     << "push r0" << endl;
            }

            cout << "call " << "__function_label_" << *(yyvsp[-3].string) << "__" << endl;

            msg_instrucao("; recupera as variaveis do escopo da funcao");

            // recupera as variaveis do escopo para permitir recursao
            for(int i = lista.size()-1; i >= 0 ; i--) {
                cout << "pop r0" << endl
                     << "store " << lista[i].endereco << ", r0" << endl;
            }
            cout << endl;
        }
        arg_list.clear();
        initialization_size = 1;
	}
#line 2641 "parser.cpp"
    break;

  case 9:
#line 318 "parser.y"
                                                                { 
		msg_sintatico("postfix_expression ABRE_COLCHETES expression FECHA_COLCHETES");
/*
        if(!preProcessamento) {
        cout<< "load r0, " << stack+2 << endl
            << "loadn r1, #" << stack+1 << endl
            << "add r7, r0, r1" << endl
            << "store " << stack+2 << ", r7" << endl;
        stack++;
        }
*/
        referenciando(*(yyvsp[-3].string));
        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() == 0) {
            if(debug_instrucao) 
                cout << "; " << t->buscaEndereco(stack) << "(" << stack << ") recebe o conteudo da variavel: " << *(yyvsp[-3].string) << endl; 

            endereco_base = t->busca(*(yyvsp[-3].string), &declarado)->endereco;

            cout<< "load r0, " << stack + 1 << endl
                << "load r1, " << endereco_base << endl
                << "sub r7, r1, r0" << endl
                << "loadi r1, r7" << endl
                << "store " << stack+1 << ", r1" << endl;
            stack_ampersand = -2;

            mapa[stack+1] = -2;
        }
        initialization_size = 1;
	}
#line 2675 "parser.cpp"
    break;

  case 10:
#line 347 "parser.y"
                                                                                                     { 
		msg_sintatico("postfix_expression ABRE_COLCHETES expression FECHA_COLCHETES");
/*
        if(!preProcessamento) {
        cout<< "load r0, " << stack+2 << endl
            << "loadn r1, #" << stack+1 << endl
            << "add r7, r0, r1" << endl
            << "store " << stack+2 << ", r7" << endl;
        stack++;
        }
*/
        referenciando(*(yyvsp[-6].string));  
        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() == 0) {
            if(debug_instrucao) 
                cout << "; " << t->buscaEndereco(stack) << "(" << stack << ") recebe o conteudo da variavel: " << *(yyvsp[-6].string) << endl; 

            endereco_base = t->busca(*(yyvsp[-6].string), &declarado)->endereco;

            cout<< "load r0, " << stack + 1 << endl
                << "load r1, " << stack + 2 << endl
                << "load r2, " << endereco_base << endl
                << "sub r2, r2, r1" << endl
                << "loadi r1, r2" << endl
                << "sub r7, r1, r0" << endl
                << "loadi r1, r7" << endl
                << "store " << stack+2 << ", r1" << endl;

            cout << "; matriz, valor da stack " << stack+2 << endl;
            mapa[stack+2] = -2;

            stack++;
            stack_ampersand = -2;
        }
        initialization_size = 1;
	}
#line 2715 "parser.cpp"
    break;

  case 11:
#line 385 "parser.y"
                             { 
		msg_sintatico("primary_expression");
	}
#line 2723 "parser.cpp"
    break;

  case 12:
#line 388 "parser.y"
                                                { 
		msg_sintatico("postfix_expression PONTO IDENTIFIER");
	}
#line 2731 "parser.cpp"
    break;

  case 13:
#line 397 "parser.y"
                                        { 
		msg_sintatico("postfix_expression MAIS_MAIS");
        if(!preProcessamento) {
        cout<< "load r0, " << stack+1 << endl
            << "inc r0" << endl
            << "store " << stack+1 << ", r0" << endl;
        if(mapa[stack+1] == -2)
            cout << "storei r7, r0"<< endl;
        else
            cout << "store " << mapa[stack+1] << ", r0" << endl;
        }
	}
#line 2748 "parser.cpp"
    break;

  case 14:
#line 409 "parser.y"
                                        { 
		msg_sintatico("postfix_expression MENOS_MENOS");
        if(!preProcessamento) {
        cout<< "load r0, " << stack+1 << endl
            << "dec r0" << endl
            << "store " << stack+1 << ", r0" << endl;
        if(mapa[stack+1] == -2)
            cout << "storei r7, r0"<< endl;
        else
            cout << "store " << mapa[stack+1] << ", r0" << endl;
        }
	}
#line 2765 "parser.cpp"
    break;

  case 15:
#line 421 "parser.y"
                                                                                                { 
		msg_sintatico("ABRE_PARENTESES type_name FECHA_PARENTESES ABRE_CHAVES initializer_list FECHA_CHAVES");
	}
#line 2773 "parser.cpp"
    break;

  case 16:
#line 432 "parser.y"
                                { 
		msg_sintatico("assignment_expression");
        arg_list.push_back(stack+1);
	}
#line 2782 "parser.cpp"
    break;

  case 17:
#line 436 "parser.y"
                                                                { 
		msg_sintatico("argument_expression_list VIRGULA assignment_expression");
        arg_list.push_back(stack+1);
	}
#line 2791 "parser.cpp"
    break;

  case 18:
#line 443 "parser.y"
                             { 
		msg_sintatico("postfix_expression");
	}
#line 2799 "parser.cpp"
    break;

  case 19:
#line 446 "parser.y"
                                        { 
		msg_sintatico("MAIS_MAIS unary_expression");
        if(!preProcessamento)
        cout<< "load r0, " << stack+1 << endl
            << "inc r0" << endl
            << "store " << stack+1 << endl;
	}
#line 2811 "parser.cpp"
    break;

  case 20:
#line 453 "parser.y"
                                        { 
		msg_sintatico("MENOS_MENOS unary_expression");
        if(!preProcessamento)
        cout<< "load r0, " << stack+1 << endl
            << "dec r0" << endl
            << "store " << stack+1 << endl;
	}
#line 2823 "parser.cpp"
    break;

  case 21:
#line 460 "parser.y"
                                     { 
		msg_sintatico("unary_operator cast_expression");

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() ==0)
        switch(operacao) {
            case ampersand:
                if(stack_ampersand == -1)
                    errorMsg("ampersand deve ser usado com variaveis");

                if(!preProcessamento) {
                    msg_instrucao("; endereco");

                    if(stack_ampersand == -2) {   // caso especial de matriz
                        stack++;
                        cout << "store " << stack << ", r7" << endl << endl; 
                        stack--;  
                    }
                    else {
                        stack++;
                        ostringstream convert;
                        convert << stack_ampersand;
                        push(convert.str(), 2);
                    }
                }
                stack_ampersand = -1;
                break;

            case asterisco:
                cout<< "load r0, " << stack+1 << endl
                    << "loadi r1, r0" << endl
                    << "store " << stack+1 << ", r1" << endl;
                break;

            case menos:
                cout<< "load r0, " << stack+1 << endl
                    << "loadn r1, #0" << endl
                    << "sub r1, r1, r0" << endl
                    << "store " << stack+1 << ", r1" << endl;
                break;

            case exclamacao:
                cout<< "load r0, " << stack+1 << endl
                    << "not r0, r0" << endl
                    << "store " << stack+1 << ", r0" << endl;
                break;

            default:
                break;
        }
        operacao = nenhuma;
	}
#line 2879 "parser.cpp"
    break;

  case 22:
#line 511 "parser.y"
                                { 
		msg_sintatico("SIZEOF unary_expression");
	}
#line 2887 "parser.cpp"
    break;

  case 23:
#line 514 "parser.y"
                                                        { 
		msg_sintatico("SIZEOF ABRE_PARENTESES type_name FECHA_PARENTESES");
	}
#line 2895 "parser.cpp"
    break;

  case 24:
#line 520 "parser.y"
                    { 
		msg_sintatico("AMPERSAND");
        operacao = ampersand;
	}
#line 2904 "parser.cpp"
    break;

  case 25:
#line 524 "parser.y"
                { 
		msg_sintatico("ASTERISCO2");
        operacao = asterisco;
	}
#line 2913 "parser.cpp"
    break;

  case 26:
#line 528 "parser.y"
                { 
		msg_sintatico("MAIS");
	}
#line 2921 "parser.cpp"
    break;

  case 27:
#line 531 "parser.y"
                { 
		msg_sintatico("MENOS");
        operacao = menos;
	}
#line 2930 "parser.cpp"
    break;

  case 28:
#line 535 "parser.y"
                { 
		msg_sintatico("TIL");
	}
#line 2938 "parser.cpp"
    break;

  case 29:
#line 538 "parser.y"
                        { 
		msg_sintatico("EXCLAMACAO");
        operacao = exclamacao;
	}
#line 2947 "parser.cpp"
    break;

  case 30:
#line 545 "parser.y"
                           { 
		msg_sintatico("unary_expression");
	}
#line 2955 "parser.cpp"
    break;

  case 31:
#line 548 "parser.y"
                                                                        { 
		msg_sintatico("ABRE_PARENTESES type_name FECHA_PARENTESES cast_expression");
	}
#line 2963 "parser.cpp"
    break;

  case 32:
#line 554 "parser.y"
                          { 
		msg_sintatico("cast_expression");
	}
#line 2971 "parser.cpp"
    break;

  case 33:
#line 557 "parser.y"
                                                                { 
		msg_sintatico("multiplicative_expression ASTERISCO cast_expression");
        expressao_binaria('*'); 
	}
#line 2980 "parser.cpp"
    break;

  case 34:
#line 561 "parser.y"
                                                        { 
		msg_sintatico("multiplicative_expression BARRA cast_expression");
        expressao_binaria('/'); 
	}
#line 2989 "parser.cpp"
    break;

  case 35:
#line 565 "parser.y"
                                                                { 
		msg_sintatico("multiplicative_expression '' cast_expression");
        expressao_binaria('%'); 
	}
#line 2998 "parser.cpp"
    break;

  case 36:
#line 572 "parser.y"
                                    { 
		msg_sintatico("multiplicative_expression");
	}
#line 3006 "parser.cpp"
    break;

  case 37:
#line 575 "parser.y"
                                                                { 
		msg_sintatico("additive_expression MAIS multiplicative_expression");
        expressao_binaria('+'); 
	}
#line 3015 "parser.cpp"
    break;

  case 38:
#line 579 "parser.y"
                                                                { 
		msg_sintatico("additive_expression MENOS multiplicative_expression");
        expressao_binaria('-'); 
	}
#line 3024 "parser.cpp"
    break;

  case 39:
#line 586 "parser.y"
                              { 
		msg_sintatico("additive_expression");
	}
#line 3032 "parser.cpp"
    break;

  case 40:
#line 589 "parser.y"
                                                        { 
		msg_sintatico("shift_expression MENOR_MENOR additive_expression");
        expressao_binaria('l'); 
	}
#line 3041 "parser.cpp"
    break;

  case 41:
#line 593 "parser.y"
                                                        { 
		msg_sintatico("shift_expression MAIOR_MAIOR additive_expression");
        expressao_binaria('r'); 
	}
#line 3050 "parser.cpp"
    break;

  case 42:
#line 600 "parser.y"
                           { 
		msg_sintatico("shift_expression");
	}
#line 3058 "parser.cpp"
    break;

  case 43:
#line 603 "parser.y"
                                                        { 
		msg_sintatico("relational_expression MENOR shift_expression");
        relacao_binaria('<');
	}
#line 3067 "parser.cpp"
    break;

  case 44:
#line 607 "parser.y"
                                                        { 
		msg_sintatico("relational_expression MAIOR shift_expression");
        relacao_binaria('>');
	}
#line 3076 "parser.cpp"
    break;

  case 45:
#line 611 "parser.y"
                                                                { 
		msg_sintatico("relational_expression MENOR_IGUAL shift_expression");
        relacao_binaria('m');
	}
#line 3085 "parser.cpp"
    break;

  case 46:
#line 615 "parser.y"
                                                                { 
		msg_sintatico("relational_expression MAIOR_IGUAL shift_expression");
        relacao_binaria('M');
	}
#line 3094 "parser.cpp"
    break;

  case 47:
#line 622 "parser.y"
                                { 
		msg_sintatico("relational_expression");
	}
#line 3102 "parser.cpp"
    break;

  case 48:
#line 625 "parser.y"
                                                                { 
		msg_sintatico("equality_expression IGUAL_IGUAL relational_expression");
        relacao_binaria('=');
	}
#line 3111 "parser.cpp"
    break;

  case 49:
#line 629 "parser.y"
                                                                        { 
		msg_sintatico("equality_expression EXCLAMACAO_IGUAL relational_expression");
        relacao_binaria('!');
	}
#line 3120 "parser.cpp"
    break;

  case 50:
#line 636 "parser.y"
                              { 
		msg_sintatico("equality_expression");
	}
#line 3128 "parser.cpp"
    break;

  case 51:
#line 639 "parser.y"
                                                        { 
		msg_sintatico("and_expression AMPERSAND equality_expression");
        expressao_binaria('&'); 
	}
#line 3137 "parser.cpp"
    break;

  case 52:
#line 646 "parser.y"
                         { 
		msg_sintatico("and_expression");
	}
#line 3145 "parser.cpp"
    break;

  case 53:
#line 649 "parser.y"
                                                                { 
		msg_sintatico("exclusive_or_expression CIRCUNFLEXO and_expression");
        expressao_binaria('^'); 
	}
#line 3154 "parser.cpp"
    break;

  case 54:
#line 656 "parser.y"
                                  { 
		msg_sintatico("exclusive_or_expression");
	}
#line 3162 "parser.cpp"
    break;

  case 55:
#line 659 "parser.y"
                                                                { 
		msg_sintatico("inclusive_or_expression PIPE exclusive_or_expression");
        expressao_binaria('|'); 
	}
#line 3171 "parser.cpp"
    break;

  case 56:
#line 666 "parser.y"
                                  { 
		msg_sintatico("inclusive_or_expression");
	}
#line 3179 "parser.cpp"
    break;

  case 57:
#line 669 "parser.y"
                                                                                { 
		msg_sintatico("logical_and_expression AMPERSAND_AMPERSAND inclusive_or_expression");
        relacao_binaria('e');
	}
#line 3188 "parser.cpp"
    break;

  case 58:
#line 676 "parser.y"
                                 { 
		msg_sintatico("logical_and_expression");
	}
#line 3196 "parser.cpp"
    break;

  case 59:
#line 679 "parser.y"
                                                                { 
		msg_sintatico("logical_or_expression PIPE_PIPE logical_and_expression");
        relacao_binaria('o');
	}
#line 3205 "parser.cpp"
    break;

  case 60:
#line 686 "parser.y"
                                { 
		msg_sintatico("logical_or_expression");
	}
#line 3213 "parser.cpp"
    break;

  case 61:
#line 689 "parser.y"
                                                                                        { 
		msg_sintatico("logical_or_expression INTERROGACAO expression DOIS_PONTOS conditional_expression");
        relacao_binaria('?');
	}
#line 3222 "parser.cpp"
    break;

  case 62:
#line 696 "parser.y"
                                 { 
		msg_sintatico("conditional_expression");
	}
#line 3230 "parser.cpp"
    break;

  case 63:
#line 699 "parser.y"
                                                                        { 
		msg_sintatico("unary_expression assignment_operator assignment_expression");

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() ==0) {
            if(debug_instrucao)
                cout<< "; assignment salvando no endereco apontado por: " << t->buscaEndereco(stack+2) << "(" << stack+2 << ") o conteudo de " 
                    << t->buscaEndereco(stack+1) << "(" << stack+1 << ")" << endl;

            cout<< "load r0, " << stack+1 << endl; // resultado
            switch(atribuicao) {
                case eq:
                    break;

                case mul_eq: 
                    cout<< "load r1, " << stack+2 << endl;
                    cout << "mul r0, r1, r0" << endl;
                    break;

                case div_eq:
                    cout<< "load r1, " << stack+2 << endl;
                    cout << "div r0, r1, r0" << endl;
                    break;

                case mod_eq:
                    cout<< "load r1, " << stack+2 << endl;
                    cout << "mod r0, r1, r0" << endl;
                    break;

                case add_eq:
                    cout<< "load r1, " << stack+2 << endl;
                    cout << "add r0, r1, r0" << endl;
                    break;

                case sub_eq:
                    cout<< "load r1, " << stack+2 << endl;
                    cout << "sub r0, r1, r0" << endl;
                    break;

                case dec_eq:
                    cout<< "dec r0" << endl;
                    break;

                case inc_eq:
                    cout<< "inc r0" << endl;
                    break;

                case land_eq:
                case lor_eq:
                case lxor_eq:
                default:
                    break;
            }
            cout << "; valor da stack: " << stack << endl;
            if(mapa[stack+2] > 0) {
                cout<< "store " << mapa[stack+2] << ", r0 ; variavel " << t->buscaEndereco(mapa[stack+2]) << " recebe o conteudo de r0" << endl << endl; 
                mapa[stack+2] = -1;
            }
            else if(mapa[stack+2] == -2) {
                cout<< "storei r7, r0 ; endereco apontado por r7 recebe o conteudo de r0" << endl << endl; 
                mapa[stack+2] = -1;
            }
            else 
                errorMsg("acesso errado a matriz");
            stack = stack+2;
        }
	}
#line 3301 "parser.cpp"
    break;

  case 64:
#line 768 "parser.y"
                { 
		msg_sintatico("IGUAL");
        atribuicao = eq;
	}
#line 3310 "parser.cpp"
    break;

  case 65:
#line 772 "parser.y"
                        { 
		msg_sintatico("ASTERISCO_IGUAL");
        atribuicao = mul_eq;
	}
#line 3319 "parser.cpp"
    break;

  case 66:
#line 776 "parser.y"
                        { 
		msg_sintatico("BARRA_IGUAL");
        atribuicao = div_eq;
	}
#line 3328 "parser.cpp"
    break;

  case 67:
#line 780 "parser.y"
                        { 
		msg_sintatico("PORCENTAGEM_IGUAL");
        atribuicao = mod_eq;
	}
#line 3337 "parser.cpp"
    break;

  case 68:
#line 784 "parser.y"
                        { 
		msg_sintatico("MAIS_IGUAL");
        atribuicao = add_eq;
	}
#line 3346 "parser.cpp"
    break;

  case 69:
#line 788 "parser.y"
                        { 
		msg_sintatico("MENOS_IGUAL");
        atribuicao = sub_eq;
	}
#line 3355 "parser.cpp"
    break;

  case 70:
#line 792 "parser.y"
                        { 
		msg_sintatico("MENOR_MENOR_IGUAL");
        atribuicao = dec_eq;
	}
#line 3364 "parser.cpp"
    break;

  case 71:
#line 796 "parser.y"
                        { 
		msg_sintatico("MAIOR_MAIOR_IGUAL");
        atribuicao = inc_eq;
	}
#line 3373 "parser.cpp"
    break;

  case 72:
#line 800 "parser.y"
                        { 
		msg_sintatico("AMPERSAND_IGUAL");
        atribuicao = land_eq;
	}
#line 3382 "parser.cpp"
    break;

  case 73:
#line 804 "parser.y"
                        { 
		msg_sintatico("CIRCUNFLEXO_IGUAL");
        atribuicao = lxor_eq;
	}
#line 3391 "parser.cpp"
    break;

  case 74:
#line 808 "parser.y"
                        { 
		msg_sintatico("PIPE_IGUAL");
        atribuicao = lor_eq;
	}
#line 3400 "parser.cpp"
    break;

  case 75:
#line 815 "parser.y"
                                { 
		msg_sintatico("assignment_expression");
	}
#line 3408 "parser.cpp"
    break;

  case 76:
#line 818 "parser.y"
                                                { 
		msg_sintatico("expression VIRGULA assignment_expression");
	}
#line 3416 "parser.cpp"
    break;

  case 77:
#line 824 "parser.y"
                                 { 
		msg_sintatico("conditional_expression");
	}
#line 3424 "parser.cpp"
    break;

  case 78:
#line 830 "parser.y"
                                               { 
		msg_sintatico("declaration_specifiers PONTO_VIRGULA");
	}
#line 3432 "parser.cpp"
    break;

  case 79:
#line 833 "parser.y"
                                                                { 
		msg_sintatico("declaration_specifiers init_declarator_list PONTO_VIRGULA");
	}
#line 3440 "parser.cpp"
    break;

  case 80:
#line 839 "parser.y"
                                  { 
		msg_sintatico("storage_class_specifier");
	}
#line 3448 "parser.cpp"
    break;

  case 81:
#line 842 "parser.y"
                                                        { 
		msg_sintatico("storage_class_specifier declaration_specifiers");
	}
#line 3456 "parser.cpp"
    break;

  case 82:
#line 845 "parser.y"
                        { 
		msg_sintatico("type_specifier");
	}
#line 3464 "parser.cpp"
    break;

  case 83:
#line 848 "parser.y"
                                                { 
		msg_sintatico("type_specifier declaration_specifiers");
	}
#line 3472 "parser.cpp"
    break;

  case 84:
#line 851 "parser.y"
                        { 
		msg_sintatico("type_qualifier");
	}
#line 3480 "parser.cpp"
    break;

  case 85:
#line 854 "parser.y"
                                                { 
		msg_sintatico("type_qualifier declaration_specifiers");
	}
#line 3488 "parser.cpp"
    break;

  case 86:
#line 857 "parser.y"
                                { 
		msg_sintatico("function_specifier");
	}
#line 3496 "parser.cpp"
    break;

  case 87:
#line 860 "parser.y"
                                                { 
		msg_sintatico("function_specifier declaration_specifiers");
	}
#line 3504 "parser.cpp"
    break;

  case 88:
#line 866 "parser.y"
                          { 
		msg_sintatico("init_declarator");
	}
#line 3512 "parser.cpp"
    break;

  case 89:
#line 869 "parser.y"
                                                        { 
		msg_sintatico("init_declarator_list VIRGULA init_declarator");
	}
#line 3520 "parser.cpp"
    break;

  case 90:
#line 875 "parser.y"
                     { 
		msg_sintatico("declarator");
        if(correcao_stack_matriz != -1 && stack != correcao_stack_matriz) {
            msg_instrucao("acerta o ponteiro da matriz/vetor");
            //cout << "stack: " << stack << endl;
            //cout << "correcao: " << correcao_stack_matriz << endl;
            stack = correcao_stack_matriz;
            correcao_stack_matriz = -1;
        }
	}
#line 3535 "parser.cpp"
    break;

  case 91:
#line 885 "parser.y"
                                        { 
		msg_sintatico("declarator IGUAL initializer");

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() ==0) {
            assert(initializer_list.size() >= 0);
            if(initializer_list.size() == 1) { // para variaveis simples e strings
                if(initialization_size > 1)
                    cout<< "loadn r0, #" << initializer_list[0] << endl;
                else if(initialization_size == 1)
                    cout<< "load r0, " << initializer_list[0] << endl;

                cout<< "store " << initializer_list[0]+1 << ", r0" << endl; 
                stack++;
            }
            
            else if(initializer_list.size() > 1) { // para vetores e matrizes
                msg_instrucao("acerta o ponteiro da matriz/vetor");
                cout << "; correcao da stack" << endl;
                if(stack != correcao_stack_matriz)
                    stack = correcao_stack_matriz;
                correcao_stack_matriz = -1;
                cout << "; stack = "<< stack << endl;
                //cout<< "loadn r0, #" << initializer_list[0] << endl
                //    << "store " << initializer_list[0]+1 << ", r0" << endl; 
            }
        }
        initializer_list.clear();
	}
#line 3568 "parser.cpp"
    break;

  case 92:
#line 916 "parser.y"
                  { 
		msg_sintatico("TYPEDEF");
	}
#line 3576 "parser.cpp"
    break;

  case 93:
#line 919 "parser.y"
                { 
		msg_sintatico("EXTERN");
	}
#line 3584 "parser.cpp"
    break;

  case 94:
#line 922 "parser.y"
                { 
		msg_sintatico("STATIC");
	}
#line 3592 "parser.cpp"
    break;

  case 95:
#line 925 "parser.y"
                { 
		msg_sintatico("AUTO");
	}
#line 3600 "parser.cpp"
    break;

  case 96:
#line 928 "parser.y"
                { 
		msg_sintatico("REGISTER");
	}
#line 3608 "parser.cpp"
    break;

  case 97:
#line 934 "parser.y"
               { 
		msg_sintatico("VOID");
        salva_tipo("void");
	}
#line 3617 "parser.cpp"
    break;

  case 98:
#line 938 "parser.y"
                { 
		msg_sintatico("CHAR");
        salva_tipo("char");
	}
#line 3626 "parser.cpp"
    break;

  case 99:
#line 942 "parser.y"
                { 
		msg_sintatico("SHORT");
        salva_tipo("short");
	}
#line 3635 "parser.cpp"
    break;

  case 100:
#line 946 "parser.y"
                { 
		msg_sintatico("INT");
        salva_tipo("int");
	}
#line 3644 "parser.cpp"
    break;

  case 101:
#line 950 "parser.y"
                { 
		msg_sintatico("LONG");
        salva_tipo("long");
	}
#line 3653 "parser.cpp"
    break;

  case 102:
#line 954 "parser.y"
                { 
		msg_sintatico("FLOAT");
        salva_tipo("long");
	}
#line 3662 "parser.cpp"
    break;

  case 103:
#line 958 "parser.y"
                { 
		msg_sintatico("DOUBLE");
        salva_tipo("double");
	}
#line 3671 "parser.cpp"
    break;

  case 104:
#line 962 "parser.y"
                { 
		msg_sintatico("SIGNED");
	}
#line 3679 "parser.cpp"
    break;

  case 105:
#line 965 "parser.y"
                { 
		msg_sintatico("UNSIGNED");
	}
#line 3687 "parser.cpp"
    break;

  case 106:
#line 968 "parser.y"
                { 
		msg_sintatico("BOOL");
        salva_tipo("bool");
	}
#line 3696 "parser.cpp"
    break;

  case 107:
#line 972 "parser.y"
                                { 
		msg_sintatico("struct_or_union_specifier");
	}
#line 3704 "parser.cpp"
    break;

  case 108:
#line 975 "parser.y"
                        { 
		msg_sintatico("enum_specifier");
	}
#line 3712 "parser.cpp"
    break;

  case 109:
#line 978 "parser.y"
                { 
		msg_sintatico("TYPE_NAME");
	}
#line 3720 "parser.cpp"
    break;

  case 110:
#line 984 "parser.y"
                                                                                      { 
		msg_sintatico("struct_or_union IDENTIFIER ABRE_CHAVES struct_declaration_list FECHA_CHAVES");
	}
#line 3728 "parser.cpp"
    break;

  case 111:
#line 987 "parser.y"
                                                                        { 
		msg_sintatico("struct_or_union ABRE_CHAVES struct_declaration_list FECHA_CHAVES");
	}
#line 3736 "parser.cpp"
    break;

  case 112:
#line 990 "parser.y"
                                        { 
		msg_sintatico("struct_or_union IDENTIFIER");
	}
#line 3744 "parser.cpp"
    break;

  case 113:
#line 996 "parser.y"
                 { 
		msg_sintatico("STRUCT");
	}
#line 3752 "parser.cpp"
    break;

  case 114:
#line 999 "parser.y"
                { 
		msg_sintatico("UNION");
	}
#line 3760 "parser.cpp"
    break;

  case 115:
#line 1005 "parser.y"
                             { 
		msg_sintatico("struct_declaration");
	}
#line 3768 "parser.cpp"
    break;

  case 116:
#line 1008 "parser.y"
                                                        { 
		msg_sintatico("struct_declaration_list struct_declaration");
	}
#line 3776 "parser.cpp"
    break;

  case 117:
#line 1014 "parser.y"
                                                                        { 
		msg_sintatico("specifier_qualifier_list struct_declarator_list PONTO_VIRGULA");
	}
#line 3784 "parser.cpp"
    break;

  case 118:
#line 1020 "parser.y"
                                                  { 
		msg_sintatico("type_specifier specifier_qualifier_list");
	}
#line 3792 "parser.cpp"
    break;

  case 119:
#line 1023 "parser.y"
                        { 
		msg_sintatico("type_specifier");
	}
#line 3800 "parser.cpp"
    break;

  case 120:
#line 1026 "parser.y"
                                                { 
		msg_sintatico("type_qualifier specifier_qualifier_list");
	}
#line 3808 "parser.cpp"
    break;

  case 121:
#line 1029 "parser.y"
                        { 
		msg_sintatico("type_qualifier");
	}
#line 3816 "parser.cpp"
    break;

  case 122:
#line 1035 "parser.y"
                            { 
		msg_sintatico("struct_declarator");
	}
#line 3824 "parser.cpp"
    break;

  case 123:
#line 1038 "parser.y"
                                                        { 
		msg_sintatico("struct_declarator_list VIRGULA struct_declarator");
	}
#line 3832 "parser.cpp"
    break;

  case 124:
#line 1044 "parser.y"
                     { 
		msg_sintatico("declarator");
	}
#line 3840 "parser.cpp"
    break;

  case 125:
#line 1047 "parser.y"
                                        { 
		msg_sintatico("DOIS_PONTOS constant_expression");
	}
#line 3848 "parser.cpp"
    break;

  case 126:
#line 1050 "parser.y"
                                                        { 
		msg_sintatico("declarator DOIS_PONTOS constant_expression");
	}
#line 3856 "parser.cpp"
    break;

  case 127:
#line 1056 "parser.y"
                                                        { 
		msg_sintatico("ENUM ABRE_CHAVES enumerator_list FECHA_CHAVES");
	}
#line 3864 "parser.cpp"
    break;

  case 128:
#line 1059 "parser.y"
                                                                { 
		msg_sintatico("ENUM IDENTIFIER ABRE_CHAVES enumerator_list FECHA_CHAVES");
	}
#line 3872 "parser.cpp"
    break;

  case 129:
#line 1062 "parser.y"
                                                                { 
		msg_sintatico("ENUM ABRE_CHAVES enumerator_list VIRGULA FECHA_CHAVES");
	}
#line 3880 "parser.cpp"
    break;

  case 130:
#line 1065 "parser.y"
                                                                        { 
		msg_sintatico("ENUM IDENTIFIER ABRE_CHAVES enumerator_list VIRGULA FECHA_CHAVES");
	}
#line 3888 "parser.cpp"
    break;

  case 131:
#line 1068 "parser.y"
                        { 
		msg_sintatico("ENUM IDENTIFIER");
	}
#line 3896 "parser.cpp"
    break;

  case 132:
#line 1074 "parser.y"
                     { 
		msg_sintatico("enumerator");
	}
#line 3904 "parser.cpp"
    break;

  case 133:
#line 1077 "parser.y"
                                                { 
		msg_sintatico("enumerator_list VIRGULA enumerator");
	}
#line 3912 "parser.cpp"
    break;

  case 134:
#line 1083 "parser.y"
                     { 
		msg_sintatico("IDENTIFIER");
	}
#line 3920 "parser.cpp"
    break;

  case 135:
#line 1086 "parser.y"
                                                { 
		msg_sintatico("IDENTIFIER IGUAL constant_expression");
	}
#line 3928 "parser.cpp"
    break;

  case 136:
#line 1092 "parser.y"
                { 
		msg_sintatico("CONST");
	}
#line 3936 "parser.cpp"
    break;

  case 137:
#line 1095 "parser.y"
                { 
		msg_sintatico("RESTRICT");
	}
#line 3944 "parser.cpp"
    break;

  case 138:
#line 1098 "parser.y"
                { 
		msg_sintatico("VOLATILE");
	}
#line 3952 "parser.cpp"
    break;

  case 139:
#line 1104 "parser.y"
                 { 
		msg_sintatico("INLINE");
	}
#line 3960 "parser.cpp"
    break;

  case 140:
#line 1110 "parser.y"
                                    { 
		msg_sintatico("pointer direct_declarator");
	}
#line 3968 "parser.cpp"
    break;

  case 141:
#line 1113 "parser.y"
                        { 
		msg_sintatico("direct_declarator");
	}
#line 3976 "parser.cpp"
    break;

  case 142:
#line 1122 "parser.y"
                     { 
		msg_sintatico("IDENTIFIER");
        declara_variaveis_e_parametros(*(yyvsp[0].string), 1);
        salva_identificador = *(yyvsp[0].string); 
	}
#line 3986 "parser.cpp"
    break;

  case 143:
#line 1127 "parser.y"
                                                                { 
		msg_sintatico("direct_declarator ABRE_COLCHETES CONSTANT FECHA_COLCHETES");

        declara_variaveis_e_parametros(*(yyvsp[-3].string), atoi((yyvsp[-1].string)->c_str())+1); 
        salva_identificador = *(yyvsp[-3].string);

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() == 0) {
            if(flag_ponteiro > 0)
                errorMsg("vetor de ponteiros nao e' suportado");

                msg_instrucao("acerta o ponteiro da matriz/vetor");
                cout<< "loadn r0, #" << stack << endl
                    << "store " << stack+1 << ", r0" << endl; 

            if(!begin_parametro) {
                salva_stack = stack; 
                correcao_stack_matriz = stack - atoi((yyvsp[-1].string)->c_str());
            }
        }
	}
#line 4011 "parser.cpp"
    break;

  case 144:
#line 1147 "parser.y"
                                                                                                 { 
		msg_sintatico("direct_declarator ABRE_COLCHETES CONSTANT FECHA_COLCHETES");

        declara_variaveis_e_parametros(*(yyvsp[-6].string), atoi((yyvsp[-4].string)->c_str()) * atoi((yyvsp[-1].string)->c_str()) + 1 + atoi((yyvsp[-4].string)->c_str())); 
        salva_identificador = *(yyvsp[-6].string);

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() == 0) {
            if(flag_ponteiro > 0)
                errorMsg("matriz de ponteiros nao e' suportado");

            if(!begin_parametro) {
                salva_stack = stack; 

                msg_instrucao("acerta o ponteiro da matriz/vetor");
                cout<< "loadn r0, #" << stack << endl
                    << "store " << stack+1 << ", r0" << endl; 

                int nlinhas = atoi((yyvsp[-4].string)->c_str());
                int ncolunas = atoi((yyvsp[-1].string)->c_str());
                int offset = stack - nlinhas;
                cout << "loadn r0, #" << stack << endl;
                for(int i = 0; i < nlinhas; i++) {
                    cout << "loadn r1, #" << offset << endl
                         << "storei r0, r1" << endl
                         << "dec r0" << endl;
                    offset = offset - ncolunas;
                }
                cout << endl;
                stack = stack - nlinhas;  // aloquei os espacos para o vetor de ponteiros da matriz
                correcao_stack_matriz = offset; 
            }
        }
	}
#line 4049 "parser.cpp"
    break;

  case 145:
#line 1191 "parser.y"
                    { 
		msg_sintatico("ASTERISCO");
	}
#line 4057 "parser.cpp"
    break;

  case 146:
#line 1194 "parser.y"
                                        { 
		msg_sintatico("ASTERISCO type_qualifier_list");
	}
#line 4065 "parser.cpp"
    break;

  case 147:
#line 1197 "parser.y"
                        { 
		msg_sintatico("ASTERISCO pointer");
	}
#line 4073 "parser.cpp"
    break;

  case 148:
#line 1200 "parser.y"
                                                { 
		msg_sintatico("ASTERISCO type_qualifier_list pointer");
	}
#line 4081 "parser.cpp"
    break;

  case 149:
#line 1206 "parser.y"
                         { 
		msg_sintatico("type_qualifier");
	}
#line 4089 "parser.cpp"
    break;

  case 150:
#line 1209 "parser.y"
                                                { 
		msg_sintatico("type_qualifier_list type_qualifier");
	}
#line 4097 "parser.cpp"
    break;

  case 151:
#line 1215 "parser.y"
                                   { 
		msg_sintatico("specifier_qualifier_list");
	}
#line 4105 "parser.cpp"
    break;

  case 152:
#line 1218 "parser.y"
                                                        { 
		msg_sintatico("specifier_qualifier_list abstract_declarator");
	}
#line 4113 "parser.cpp"
    break;

  case 153:
#line 1224 "parser.y"
                  { 
		msg_sintatico("pointer");
	}
#line 4121 "parser.cpp"
    break;

  case 154:
#line 1227 "parser.y"
                                        { 
		msg_sintatico("direct_abstract_declarator");
	}
#line 4129 "parser.cpp"
    break;

  case 155:
#line 1230 "parser.y"
                                                { 
		msg_sintatico("pointer direct_abstract_declarator");
	}
#line 4137 "parser.cpp"
    break;

  case 156:
#line 1236 "parser.y"
                                                               { 
		msg_sintatico("ABRE_PARENTESES abstract_declarator FECHA_PARENTESES");
	}
#line 4145 "parser.cpp"
    break;

  case 157:
#line 1239 "parser.y"
                                        { 
		msg_sintatico("ABRE_COLCHETES FECHA_COLCHETES");
	}
#line 4153 "parser.cpp"
    break;

  case 158:
#line 1242 "parser.y"
                                                                { 
		msg_sintatico("ABRE_COLCHETES assignment_expression FECHA_COLCHETES");
	}
#line 4161 "parser.cpp"
    break;

  case 159:
#line 1245 "parser.y"
                                                                { 
		msg_sintatico("direct_abstract_declarator ABRE_COLCHETES FECHA_COLCHETES");
	}
#line 4169 "parser.cpp"
    break;

  case 160:
#line 1248 "parser.y"
                                                                                        { 
		msg_sintatico("direct_abstract_declarator ABRE_COLCHETES assignment_expression FECHA_COLCHETES");
	}
#line 4177 "parser.cpp"
    break;

  case 161:
#line 1251 "parser.y"
                                                { 
		msg_sintatico("ABRE_COLCHETES ASTERISCO FECHA_COLCHETES");
	}
#line 4185 "parser.cpp"
    break;

  case 162:
#line 1254 "parser.y"
                                                                                { 
		msg_sintatico("direct_abstract_declarator ABRE_COLCHETES ASTERISCO FECHA_COLCHETES");
	}
#line 4193 "parser.cpp"
    break;

  case 163:
#line 1257 "parser.y"
                                        { 
		msg_sintatico("ABRE_PARENTESES FECHA_PARENTESES");
	}
#line 4201 "parser.cpp"
    break;

  case 164:
#line 1263 "parser.y"
                                { 
		msg_sintatico("assignment_expression");
        if(initialization_size == 1)
            initializer_list.push_back(stack+1);
        else if(initialization_size > 1)
            initializer_list.push_back(stack+initialization_size);
	}
#line 4213 "parser.cpp"
    break;

  case 165:
#line 1270 "parser.y"
                                                { 
		msg_sintatico("ABRE_CHAVES initializer_list FECHA_CHAVES");
	}
#line 4221 "parser.cpp"
    break;

  case 166:
#line 1276 "parser.y"
                      { 
		msg_sintatico("initializer");
	}
#line 4229 "parser.cpp"
    break;

  case 167:
#line 1279 "parser.y"
                                { 
		msg_sintatico("designation initializer");
	}
#line 4237 "parser.cpp"
    break;

  case 168:
#line 1282 "parser.y"
                                                { 
		msg_sintatico("initializer_list VIRGULA initializer");
	}
#line 4245 "parser.cpp"
    break;

  case 169:
#line 1285 "parser.y"
                                                        { 
		msg_sintatico("initializer_list VIRGULA designation initializer");
	}
#line 4253 "parser.cpp"
    break;

  case 170:
#line 1291 "parser.y"
                                { 
		msg_sintatico("designator_list IGUAL");
	}
#line 4261 "parser.cpp"
    break;

  case 171:
#line 1297 "parser.y"
                     { 
		msg_sintatico("designator");
	}
#line 4269 "parser.cpp"
    break;

  case 172:
#line 1300 "parser.y"
                                        { 
		msg_sintatico("designator_list designator");
	}
#line 4277 "parser.cpp"
    break;

  case 173:
#line 1306 "parser.y"
                                                             { 
		msg_sintatico("ABRE_COLCHETES constant_expression FECHA_COLCHETES");
	}
#line 4285 "parser.cpp"
    break;

  case 174:
#line 1309 "parser.y"
                        { 
		msg_sintatico("PONTO IDENTIFIER");
	}
#line 4293 "parser.cpp"
    break;

  case 175:
#line 1315 "parser.y"
                          { 
		msg_sintatico("labeled_statement");
	}
#line 4301 "parser.cpp"
    break;

  case 176:
#line 1318 "parser.y"
                                { 
		msg_sintatico("compound_statement");
	}
#line 4309 "parser.cpp"
    break;

  case 177:
#line 1321 "parser.y"
                                { 
		msg_sintatico("expression_statement");
	}
#line 4317 "parser.cpp"
    break;

  case 178:
#line 1324 "parser.y"
                                { 
		msg_sintatico("selection_statement");
	}
#line 4325 "parser.cpp"
    break;

  case 179:
#line 1327 "parser.y"
                                { 
		msg_sintatico("iteration_statement");
	}
#line 4333 "parser.cpp"
    break;

  case 180:
#line 1330 "parser.y"
                        { 
		msg_sintatico("jump_statement");
	}
#line 4341 "parser.cpp"
    break;

  case 181:
#line 1333 "parser.y"
                       {
		msg_sintatico("breakp_statement");
    }
#line 4349 "parser.cpp"
    break;

  case 182:
#line 1336 "parser.y"
                       {
		msg_sintatico("printf_statement");
    }
#line 4357 "parser.cpp"
    break;

  case 183:
#line 1342 "parser.y"
                             {
        msg_sintatico("breakp_statement breakp");
        if(!preProcessamento)
        cout << "breakp" << endl; 
    }
#line 4367 "parser.cpp"
    break;

  case 184:
#line 1350 "parser.y"
                                               { 
        msg_sintatico("breakp getch abre_parenteses fecha_parenteses");
        if(!preProcessamento) {
            cout << "inchar r0" << endl; 
            cout << "store " << stack << ", r0" << endl;
            stack--;
        }
    }
#line 4380 "parser.cpp"
    break;

  case 186:
#line 1360 "parser.y"
                                      {
        msg_sintatico("opt_args VIRGULA primary_expression");
        if(correcao_printf_string > 0) {
            printf_args.push_back(correcao_printf_string);
            correcao_printf_string = 0;
        }
        else
            printf_args.push_back(stack+1);
    }
#line 4394 "parser.cpp"
    break;

  case 187:
#line 1369 "parser.y"
                                               {
        msg_sintatico("opt_args opt_args VIRGULA primary_expression");
        if(correcao_printf_string > 0) {
            printf_args.push_back(correcao_printf_string);
            correcao_printf_string = 0;
        }
        else
            printf_args.push_back(stack+1);
    }
#line 4408 "parser.cpp"
    break;

  case 188:
#line 1381 "parser.y"
               {
        msg_sintatico("printf printf");
        if(!preProcessamento) {
            begin_printf = 1;
            //if(!printf_args.empty())
                printf_args.clear();
        }
    }
#line 4421 "parser.cpp"
    break;

  case 189:
#line 1392 "parser.y"
                                                                                                                                                  {
        msg_sintatico("breakp printf abre_parenteses primary_expression virgula primary_expression virgula string_literal opt_args fecha_parenteses");
        if(!preProcessamento) {

            string aux = *(yyvsp[-3].string);
            msg_instrucao("; printf(" + aux + ");");

            int comeco_da_string = stack;
            int numero_de_argumentos = 0;
            int numero_de_parametros = printf_args.size() - 2;

            //for(int i = 0; i < printf_args.size(); i++)
            //    cerr << printf_args[i] << endl;

            int j = 0;
            for(int i = 0; i < aux.length(); i++) {

                if(aux[i] == '%') {

                    switch(aux[i+1]) {

                        case 's':
                            numero_de_argumentos++;
                            if(numero_de_argumentos > numero_de_parametros)
                                errorMsg("printf faltando argumentos");
                            cout << "loadn r0, #'%'" << endl;
                            cout << "store " << stack << ", r0" << endl;
                            cout << "loadn r0, #'s'" << endl;
                            cout << "store " << stack-1 << ", r0" << endl;

                            cout << ";comeco da string: " << comeco_da_string << endl;
                            cout << ";printf_args.size(): " << printf_args.size() << endl;
                            for(int w =0 ; w < printf_args.size(); w++)
                                cout << "; " << printf_args[w] << endl;
                            cout << ";j: " << j << endl;

                            cout << "loadn r0, #" << printf_args[j] << endl;
                            //cout << "loadn r0, #" << comeco_da_string + printf_args.size() -j << endl;
                            cout << "store " << stack-2 << ", r0" << endl;
                            stack = stack - 3;
                            i++;
                            j++;
                            continue;

                        case 'd':
                            numero_de_argumentos++;
                            if(numero_de_argumentos > numero_de_parametros)
                                errorMsg("printf faltando argumentos");
                            cout << "loadn r0, #'%'" << endl;
                            cout << "store " << stack << ", r0" << endl;
                            cout << "loadn r0, #'d'" << endl;
                            cout << "store " << stack-1 << ", r0" << endl;

                            cout << ";comeco da string: " << comeco_da_string << endl;
                            cout << ";printf_args.size(): " << printf_args.size() << endl;
                            for(int w =0 ; w < printf_args.size(); w++)
                                cout << "; " << printf_args[w] << endl;
                            cout << ";j: " << j << endl;

                            cout << "loadn r0, #" << printf_args[j] << endl;
                            //cout << "loadn r0, #" << comeco_da_string + printf_args.size() -j << endl;
                            cout << "store " << stack-2 << ", r0" << endl;
                            stack = stack - 3;
                            i++;
                            j++;
                            continue;

                        case 'c':
                            numero_de_argumentos++;
                            if(numero_de_argumentos > numero_de_parametros)
                                errorMsg("printf faltando argumentos");
                            cout << "loadn r0, #'%'" << endl;
                            cout << "store " << stack << ", r0" << endl;
                            cout << "loadn r0, #'c'" << endl;
                            cout << "store " << stack-1 << ", r0" << endl;

                            cout << "loadn r0, #" << printf_args[j] << endl;
                            //cout << "loadn r0, #" << comeco_da_string + printf_args.size() -j << endl;
                            cout << "store " << stack-2 << ", r0" << endl;
                            stack = stack - 3;
                            i++;
                            j++;
                            continue;

                        case 'S':
                            numero_de_argumentos++;
                            if(numero_de_argumentos > numero_de_parametros)
                                errorMsg("printf faltando argumentos");
                            cout << "loadn r0, #'%'" << endl;
                            cout << "store " << stack << ", r0" << endl;
                            cout << "loadn r0, #'S'" << endl;
                            cout << "store " << stack-1 << ", r0" << endl;

                            cout << ";comeco da string: " << comeco_da_string << endl;
                            cout << ";printf_args.size(): " << printf_args.size() << endl;
                            for(int w =0 ; w < printf_args.size(); w++)
                                cout << "; " << printf_args[w] << endl;
                            cout << ";j: " << j << endl;

                            cout << "loadn r0, #" << printf_args[j] << endl;
                            //cout << "loadn r0, #" << comeco_da_string + printf_args.size() -j << endl;
                            cout << "store " << stack-2 << ", r0" << endl;
                            stack = stack - 3;
                            i++;
                            j++;
                            continue;

                        default:
                            break;
                    }
                }
                cout<< "loadn r0, #'" << aux[i] << "'" << endl
                    << "store " << stack << ", r0" << endl;
                stack--;
            }
            
            cout<< "loadn r0, #0" << endl
                << "store " << stack << ", r0" << endl;
            stack--;

            // Tela: 30x40
//            cout<< "load r0, " << comeco_da_string + 2 + printf_args.size() << endl
//                << "load r1, " << comeco_da_string + 1 + printf_args.size() << endl

            if(printf_args.size() > 0)
            cout<< "load r0, " << 2 + printf_args[0] << endl
                << "load r1, " << 1 + printf_args[0] << endl;
            else
            cout<< "load r0, " << 2 + comeco_da_string << endl
                << "load r1, " << 1 + comeco_da_string << endl;
        
            cout<< "loadn r2, #40" << endl
                << "mul r0, r0, r2" << endl // para achar a posicao na tela
                << "add r0, r0, r1" << endl
                << "loadn r2, #" << comeco_da_string << endl
                << "call __printf__" << endl;

            begin_printf = 0;
            //if(!printf_args.empty())
                printf_args.clear();
        }
    }
#line 4568 "parser.cpp"
    break;

  case 190:
#line 1537 "parser.y"
                                           { 
		msg_sintatico("IDENTIFIER DOIS_PONTOS statement");
	}
#line 4576 "parser.cpp"
    break;

  case 191:
#line 1540 "parser.y"
                                                    { 
		msg_sintatico("CASE constant_expression DOIS_PONTOS statement");
        cout << "; labeled_statement case, zerou" << endl;
        insideCase = 0;
        cout<< "jmp __label_statement_" << statement_seq+1 << "__" << endl;
	}
#line 4587 "parser.cpp"
    break;

  case 192:
#line 1546 "parser.y"
                                        { 
		msg_sintatico("DEFAULT DOIS_PONTOS statement");
        cout << "; labeled_statement default, zerou" << endl;
        insideCase = 0;
	}
#line 4597 "parser.cpp"
    break;

  case 193:
#line 1554 "parser.y"
                    {   
		msg_sintatico("DOIS_PONTOS");
        cout << "; dois pontos, incrementou" << endl;
        insideCase = 1;
        if(!preProcessamento) {
            cout<< "__label_case_" << case_seq << "__:" << endl;
            cout<< "load r1, " << stack+1 << endl
                << "cmp r0, r1" << endl
                << "jeq __label_statement_" << statement_seq << "__" << endl;
            cout<< "jmp __label_case_" << case_seq << "__" << endl
                << "__label_statement_" << statement_seq << "__:" << endl;
            case_seq++;
            statement_seq++;
        }
    }
#line 4617 "parser.cpp"
    break;

  case 194:
#line 1572 "parser.y"
                                   { 
		msg_sintatico("ABRE_CHAVES FECHA_CHAVES");
	}
#line 4625 "parser.cpp"
    break;

  case 195:
#line 1575 "parser.y"
                                                { 
		msg_sintatico("ABRE_CHAVES block_item_list FECHA_CHAVES");
	}
#line 4633 "parser.cpp"
    break;

  case 196:
#line 1581 "parser.y"
                     { 
		msg_sintatico("block_item");
	}
#line 4641 "parser.cpp"
    break;

  case 197:
#line 1584 "parser.y"
                                        { 
		msg_sintatico("block_item_list block_item");
	}
#line 4649 "parser.cpp"
    break;

  case 198:
#line 1590 "parser.y"
                      { 
		msg_sintatico("declaration");
	}
#line 4657 "parser.cpp"
    break;

  case 199:
#line 1593 "parser.y"
                { 
		msg_sintatico("statement");
	}
#line 4665 "parser.cpp"
    break;

  case 200:
#line 1599 "parser.y"
                        { 
		msg_sintatico("PONTO_VIRGULA");
	}
#line 4673 "parser.cpp"
    break;

  case 201:
#line 1602 "parser.y"
                                { 
		msg_sintatico("expression PONTO_VIRGULA");
	}
#line 4681 "parser.cpp"
    break;

  case 202:
#line 1608 "parser.y"
                                                                { 
		msg_sintatico("IF ABRE_PARENTESES expression FECHA_PARENTESES statement");
        if(!preProcessamento) {
            cout << "__exit_if_label" << if_stack.back() << "__:" << endl; 
            if_stack.pop_back();
        }
	}
#line 4693 "parser.cpp"
    break;

  case 203:
#line 1615 "parser.y"
                                                                                        { 
		msg_sintatico("IF ABRE_PARENTESES expression FECHA_PARENTESES statement ELSE statement");
        if(!preProcessamento) {
            cout << "__exit_else_label" << if_stack.back() << "__:" << endl; 
            if_stack.pop_back();
        }
	}
#line 4705 "parser.cpp"
    break;

  case 204:
#line 1622 "parser.y"
                                                                { 
		msg_sintatico("SWITCH ABRE_PARENTESES expression FECHA_PARENTESES statement");
        insideSwitch--;
        if(switch_stack.back() == 1)
            switch_stack.pop_back();
        else
            errorMsg("switch stack esta errada");
        switch_seq++;
	}
#line 4719 "parser.cpp"
    break;

  case 205:
#line 1634 "parser.y"
                         {
        if(!preProcessamento)
            cout<< "load r0, " << stack+1 << endl;
        insideSwitch++;
        switch_stack.push_back(1);
    }
#line 4730 "parser.cpp"
    break;

  case 206:
#line 1643 "parser.y"
                         { 
        msg_sintatico("begin_labeled fecha_parenteses");
            if(!preProcessamento) {
                ifseq++;
                if_stack.push_back(ifseq);

                cout << "load r0, " << stack+1 << endl;
                stack++;
                cout << "loadn r1, #0" << endl;
                cout << "cmp r0, r1" << endl;
                cout << "jeq __exit_if_label" << if_stack.back() << "__" << endl; // else
                cout << "jmp __if_label" << if_stack.back() << "__" << endl;
                cout << "__if_label" << if_stack.back() << "__:" << endl; 
            }
    }
#line 4750 "parser.cpp"
    break;

  case 207:
#line 1661 "parser.y"
             { 
        msg_sintatico("begin_else else");
        if(!preProcessamento) {
            cout << "jmp __exit_else_label" << if_stack.back() << "__" << endl; 
            cout << "__exit_if_label" << if_stack.back() << "__:" << endl;
        }
    }
#line 4762 "parser.cpp"
    break;

  case 208:
#line 1671 "parser.y"
                                                                          { 
		msg_sintatico("WHILE ABRE_PARENTESES expression FECHA_PARENTESES statement");
        insideLoop--;
        if(!preProcessamento) {
            cout << "jmp __loop_label_begin"<< loop_stack.back() << "__" << endl;
            cout << "__exit_loop_label" << loop_stack.back() << "__:" << endl;
            cout << "; ----- end while -----" << endl;
        }
        if(switch_stack.back() == 2)
            switch_stack.pop_back();
        else
            errorMsg("switch stack esta errada");
        loop_stack.pop_back();
	}
#line 4781 "parser.cpp"
    break;

  case 209:
#line 1685 "parser.y"
                                                                                        { 
		msg_sintatico("DO statement WHILE ABRE_PARENTESES expression FECHA_PARENTESES PONTO_VIRGULA");
        errorMsg("do while nao e' suportado nesta versao");
	}
#line 4790 "parser.cpp"
    break;

  case 210:
#line 1689 "parser.y"
                                                                                        { 
		msg_sintatico("FOR ABRE_PARENTESES expression_statement expression_statement FECHA_PARENTESES statement");
        insideLoop--;
        if(!preProcessamento) {
            cout << "jmp __loop_label2_begin"<< loop_stack.back() << "__" << endl;
            cout << "__exit_loop_label" << loop_stack.back() << "__:" << endl;
            cout << "; ----- end for -----" << endl;
        }
        if(switch_stack.back() == 2)
            switch_stack.pop_back();
        else
            errorMsg("switch stack esta errada");
        loop_stack.pop_back();
	}
#line 4809 "parser.cpp"
    break;

  case 211:
#line 1703 "parser.y"
                                                                                                        { 
		msg_sintatico("FOR ABRE_PARENTESES expression_statement expression_statement expression FECHA_PARENTESES statement");
        insideLoop--;
        if(!preProcessamento) {
            cout << "jmp __loop_label2_begin"<< loop_stack.back() << "__" << endl;
            cout << "__exit_loop_label" << loop_stack.back() << "__:" << endl;
            cout << "; ----- end for -----" << endl;
        }
        if(switch_stack.back() == 2)
            switch_stack.pop_back();
        else
            errorMsg("switch stack esta errada");
        loop_stack.pop_back();
	}
#line 4828 "parser.cpp"
    break;

  case 212:
#line 1720 "parser.y"
                         { 
        if(!preProcessamento) {
        cout << "jmp __loop_label_begin"<< loop_stack.back() << "__" << endl;
        cout << "__loop_label3_begin" << loop_stack.back() << "__:" << endl;
        }
    }
#line 4839 "parser.cpp"
    break;

  case 213:
#line 1729 "parser.y"
              { 
        msg_sintatico("begin_while while");
        msg_instrucao("while");
        loop_stack.push_back(loopseq);
            insideLoop++;
            if(!preProcessamento)
                cout << "__loop_label_begin" << loop_stack.back() << "__:" << endl; 
        switch_stack.push_back(2);
        loopseq++;
    }
#line 4854 "parser.cpp"
    break;

  case 214:
#line 1742 "parser.y"
                         { 
        msg_sintatico("begin_labeled2 fecha_parenteses");
            //stack++;
            if(!preProcessamento) {
                cout << "load r0, " << stack+1 << endl;
                cout << "loadn r1, #0" << endl;
                cout << "cmp r0, r1" << endl;
                cout << "jeq __exit_loop_label" << loop_stack.back() << "__" << endl;
                cout << "jmp __loop_label" << loop_stack.back() << "__" << endl;
                cout << "__loop_label" << loop_stack.back() << "__:" << endl;
            }
    }
#line 4871 "parser.cpp"
    break;

  case 215:
#line 1757 "parser.y"
            { 
        msg_sintatico("begin_for for");
            insideLoop++;
            if(!preProcessamento && debug_instrucao)
                cout << ";----- begin for -----" << endl;
        switch_stack.push_back(2);
        loop_stack.push_back(loopseq);
        loopseq++;
    }
#line 4885 "parser.cpp"
    break;

  case 216:
#line 1769 "parser.y"
                             {
        msg_sintatico("begin_labeled3 expression_statement");
            stack++;
            if(!preProcessamento) {
                cout << "load r0, " << stack << endl;
                cout << "loadn r1, #0" << endl;
                cout << "cmp r0, r1" << endl;
                cout << "jeq __exit_loop_label" << loop_stack.back() << "__" << endl;

                cout << "jmp __loop_label3_begin" << loop_stack.back() << "__" << endl;
                cout << "__loop_label2_begin" << loop_stack.back() << "__:" << endl;
            }
    }
#line 4903 "parser.cpp"
    break;

  case 217:
#line 1785 "parser.y"
                             { 
        msg_sintatico("begin_labeled4 expression_statement");
        if(!preProcessamento)
            cout << "__loop_label_begin" << loop_stack.back() << "__:" << endl; 
    }
#line 4913 "parser.cpp"
    break;

  case 218:
#line 1793 "parser.y"
                                        { 
		msg_sintatico("GOTO IDENTIFIER PONTO_VIRGULA");
        checa_label(*(yyvsp[-1].string)); 
        if(!preProcessamento && debug_sintatico) 
            cout << "jump_statement: IDENTIFIER " << *(yyvsp[-1].string) << endl; 
	}
#line 4924 "parser.cpp"
    break;

  case 219:
#line 1799 "parser.y"
                                { 
		msg_sintatico("CONTINUE PONTO_VIRGULA");
        if(insideLoop == 0) { 
            errorMsg("continue fora de loop"); 
        } 
        if(!preProcessamento)
        cout << "jmp __loop_label_begin"<< loop_stack.back() << "__" << endl;
	}
#line 4937 "parser.cpp"
    break;

  case 220:
#line 1807 "parser.y"
                                { 
		msg_sintatico("BREAK PONTO_VIRGULA");
        if(insideLoop == 0 && insideCase == 0) {
            cout << "; case: " << insideCase << " loop: " << insideLoop << endl; 
            errorMsg("break fora de loop"); 
        } 
        if(!preProcessamento)
            if(switch_stack.back() == 2)
                cout << "jmp __exit_loop_label" << loop_stack.back() << "__" << endl;
            else if(switch_stack.back() == 1)
                cout << "jmp __exit_switch_label" << switch_seq << "__" << endl;
	}
#line 4954 "parser.cpp"
    break;

  case 221:
#line 1819 "parser.y"
                                { 
		msg_sintatico("RETURN PONTO_VIRGULA");
        if(!preProcessamento && f->nome != "main") {
            cout << "rts" << endl;
        }
        else if(!preProcessamento && f->nome == "main") {
            cout << "breakp" << endl;
        }
	}
#line 4968 "parser.cpp"
    break;

  case 222:
#line 1828 "parser.y"
                                        { 
		msg_sintatico("RETURN expression PONTO_VIRGULA");
        if(isFunctionVoid) { 
            errorMsg("funcao void retornando valor"); 
        } 
        funcao_tem_return = true;
        if(!preProcessamento && f->nome != "main") {
            cout << "rts" << endl;
        }
        else if(!preProcessamento && f->nome == "main") {
            cout << "breakp" << endl;
        }
	}
#line 4986 "parser.cpp"
    break;

  case 223:
#line 1844 "parser.y"
                               { 
		msg_sintatico("external_declaration");
	}
#line 4994 "parser.cpp"
    break;

  case 224:
#line 1847 "parser.y"
                                                { 
		msg_sintatico("translation_unit external_declaration");
	}
#line 5002 "parser.cpp"
    break;

  case 225:
#line 1853 "parser.y"
                              { 
		msg_sintatico("function_definition");
	}
#line 5010 "parser.cpp"
    break;

  case 226:
#line 1856 "parser.y"
                        { 
		msg_sintatico("declaration");
	}
#line 5018 "parser.cpp"
    break;

  case 227:
#line 1862 "parser.y"
                                                                                                                { 
		msg_sintatico("declaration_specifiers declarator compound_statement");
        function_definition();
	}
#line 5027 "parser.cpp"
    break;

  case 229:
#line 1869 "parser.y"
                     {
        msg_sintatico("opt_parametros parameter_list");
    }
#line 5035 "parser.cpp"
    break;

  case 230:
#line 1875 "parser.y"
                                { 
        msg_sintatico("parameter_list parameter_declaration");
    }
#line 5043 "parser.cpp"
    break;

  case 231:
#line 1878 "parser.y"
                                                   { 
        msg_sintatico("parameter_list parameter_list VIRGULA parameter_declaration");
    }
#line 5051 "parser.cpp"
    break;

  case 232:
#line 1884 "parser.y"
                                                   { 
        flag_ponteiro = -1; 
        msg_sintatico("parameter_declaration type_specifier pointer direct_declarator");
    }
#line 5060 "parser.cpp"
    break;

  case 233:
#line 1888 "parser.y"
                                           { 
        msg_sintatico("parameter_declaration type_specifier direct_declarator");
    }
#line 5068 "parser.cpp"
    break;

  case 234:
#line 1894 "parser.y"
                   { 
        msg_sintatico("begin_funcao IDENTIFIER");

        if(*(yyvsp[0].string) == "main") {
            tem_main = true;
            is_main = true;
        }

        declara_funcao(*(yyvsp[0].string)); 
        t->insereEscopo(); 
        if(type_void) 
            isFunctionVoid = true; 
        stack_antes_de_entrar_no_escopo = stack; 
    }
#line 5087 "parser.cpp"
    break;

  case 235:
#line 1911 "parser.y"
                                { 
        msg_sintatico("begin_parametro ABRE_PARENTESES");

        begin_parametro = true; 
        if(!preProcessamento) {
            msg_instrucao("; declarando funcao: " + f->nome);
            cout << "__function_label_" << f->nome << "__:" << endl;
        }
    }
#line 5101 "parser.cpp"
    break;

  case 236:
#line 1923 "parser.y"
                                 { 
        msg_sintatico("end_parametro FECHA_PARENTESES");

        begin_parametro = false; 

        if(!preProcessamento) {
            if(f->parametros.size() > 0)
                msg_instrucao("; resgatando os parametros");

            for(int i = f->parametros.size(); i--; ) {
                if(debug_instrucao)
                    cout << "pop r0 ; resgatou " << f->parametros[i].nome << endl;
                else 
                    cout << "pop r0" << endl;
                cout << "store " << f->parametros[i].endereco << ", r0" << endl;
            }
            cout << endl;
        }
    }
#line 5125 "parser.cpp"
    break;


#line 5129 "parser.cpp"

        default: break;
      }
    if (yychar_backup != yychar)
      YY_LAC_DISCARD ("yychar change");
  }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      {
        yypcontext_t yyctx
          = {yyssp, yyesa, &yyes, &yyes_capacity, yytoken};
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        if (yychar != YYEMPTY)
          YY_LAC_ESTABLISH;
        yysyntax_error_status = yysyntax_error (&yymsg_alloc, &yymsg, &yyctx);
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == -1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *,
                             YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (yymsg)
              {
                yysyntax_error_status
                  = yysyntax_error (&yymsg_alloc, &yymsg, &yyctx);
                yymsgp = yymsg;
              }
            else
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = YYENOMEM;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == YYENOMEM)
          goto yyexhaustedlab;
      }
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  /* If the stack popping above didn't lose the initial context for the
     current lookahead token, the shift below will for sure.  */
  YY_LAC_DISCARD ("error recovery");

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if 1
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  if (yyes != yyesa)
    YYSTACK_FREE (yyes);
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
  return yyresult;
}

#line 1944 "parser.y"


void function_definition() {
    assert(f != NULL);
    if(!funcao_tem_return && !isFunctionVoid)
        warningMsg("funcao " + f->nome + " nao esta retornando nenhum valor");

    stack = stack_antes_de_entrar_no_escopo; 
    t->removeEscopo(); 
    f = NULL; 
    isFunctionVoid = false; 
    funcao_tem_return = false;

    if(is_main && !preProcessamento)
        cout << "breakp" << endl;

    is_main = false;
    if(!preProcessamento)
    cout << "rts" << endl;
}

void salva_tipo(string tipo) {
    if(tipo == "void")
        type_void = true;
    else
        type_void = false;
    e = t->busca(tipo, &declarado); 
    if(e == NULL) { 
        errorMsg("tipo nao declarado"); 
    } 
}

void expressao_binaria(char op) {
    if(!preProcessamento) {
        if(debug_instrucao)
            cout << "; expressao_binaria: " << stack+2 << " " << op << " " << stack+1 << endl;

        cout << "load r0, " << stack+2 << endl
             << "load r1, " << stack+1 << endl;
        switch(op) {
            case '+': cout << "add r2, r0, r1" << endl; break;
            case '*': cout << "mul r2, r0, r1" << endl; break;
            case '-': cout << "sub r2, r0, r1" << endl; break;
            case '/': cout << "div r2, r0, r1" << endl; break;
            case '%': cout << "lmod r2, r0, r1" << endl; break;
            case 'l': cout << "shift left" << endl; break; // shift left
            case 'r': cout << "shift right" << endl; break; // shift right
            case '|': cout << "lor r0, r1, r2" << endl; break;
            case '^': cout << "lxor r0, r1, r2" << endl; break;
            case '&': cout << "land r0, r1, r2" << endl; break;
            default: errorMsg("operacao invalida"); break;
        }
        cout << "store " << stack+2 << ", r2" << endl << endl;
        stack++;
    }
}

void relacao_binaria(char op) {
    if(!preProcessamento) {
        msg_instrucao("relacao_binaria");

        cout<< "load r0, " << stack+2 << endl
            << "load r1, " << stack+1 << endl
            << "loadn r2, #" << stack+2 << endl;

        switch(op) {
            case 'e': cout<< "call __and_routine__" << endl; break;
            case 'o': cout<< "call __or_routine__" << endl; break;
            case '=': cout<< "call __equal_routine__" << endl; break;
            case '!': cout<< "call __not_equal_routine__" << endl; break;
            case 'm': cout<< "call __equal_less_routine__" << endl; break;
            case 'M': cout<< "call __equal_more_routine__" << endl; break;
            case '<': cout<< "call __less_routine__" << endl; break;
            case '>': cout<< "call __more_routine__" << endl; break;
            default: errorMsg("operacao invalida"); break;
        }
        //cout << "store " << stack+2 << ", r2" << endl << endl;
        stack++;
    }
}

// verifica se o identificador que esta sendo declarado ja esta na tabela de simbolos
bool declarando(string &id) {
    Entrada *e = t->declarado(id); 
    if(e != NULL) {
        ostringstream convert;
        convert << "O identificador " << id << " ja foi declarado";
        errorMsg(convert.str());
        return false;
    }
    return true;
}

bool referenciando(string &id) {
    bool aux;
    Entrada *e = t->busca(id, &aux);
    if(aux == false) {
        ostringstream convert;
        convert << "O identificador " << id << " nao foi declarado";
        errorMsg(convert.str());
        return false;
    }
    return true;
}

void errorMsg(string msg) { 
    if(preProcessamento) {
    std::cout << "; @(" << yylineno << ") ERRO - " << msg << endl;
    exit(1);  
    }
}

void warningMsg(string msg) { 
    if(preProcessamento)
    std::cout << "; @(" << yylineno << ") WARNING - " << msg << endl;
}

string to_str(int value) {
    char buffer[33];
    sprintf(buffer, "%d", value);
    string aux = buffer;
    return aux;
}

void push(string value, int a) {
    if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() ==0) {
        switch(a) {
            case 1: // variavel
                if(debug_instrucao) 
                    cout << "; " << t->buscaEndereco(stack) << "(" << stack << ") recebe o conteudo da variavel: " << t->buscaEndereco(atoi(value.c_str())) << "(" << value << ")" << endl; 
                cout << "load r0, " << value << endl 
                     << "store " << stack << ", r0" << endl << endl;
                stack_ampersand = atoi(value.c_str());

                mapa[stack] = atoi(value.c_str());
                break;

            case 2: // valor constante numero
                if(debug_instrucao) 
                    cout << "; " << t->buscaEndereco(stack) << "(" << stack << ") recebe o conteudo: " << value << endl; 
                cout << "loadn r0, #" << value << endl 
                     << "store " << stack << ", r0" << endl << endl;

                mapa[stack] = -1;
                break;

            case 3: // valor constante caracter
                if(debug_instrucao) 
                    cout << "; " << t->buscaEndereco(stack) << "(" << stack << ") recebe o conteudo: " << value << endl; 
                cout << "loadn r0, #'" << value << "'" << endl 
                     << "store " << stack << ", r0" << endl << endl;

                mapa[stack] = -1;
                break;

            default:
                break;
        }
        stack--;
    }
}

void declara_variaveis_e_parametros(string id, int nbytes) {
	// se for um parametro, insere na tabela de simbolos e na funcao pai
	if(begin_parametro) {
		// verifica se o parametro ja nao foi declarado
		if(declarando(id)) {
			Entrada *p = t->insereParametro(id, e);
            p->endereco = stack;
            p->ponteiro = flag_ponteiro;
            p->nbytes = nbytes;

			assert(f != NULL);
			f->insereParametro(p);
            if(!preProcessamento && debug_instrucao) 
                cout << "; variavel: " << id << " alocada em " << stack << endl << endl;
            stack--;
		}
	}
	// senao e' uma variavel sendo declarada
	else {
        if(t->getEscopo() == 0 && !preProcessamento)
            return;
		if(declarando(id)) {
			Entrada *v = t->insereVariavel(id, e);
            v->endereco = stack;
            v->ponteiro = flag_ponteiro;
            v->nbytes = nbytes;

            if(((!preProcessamento && t->getEscopo() > 0) || (preProcessamento && t->getEscopo() == 0)) && debug_instrucao) 
                cout << "; variavel: " << id << " alocada em " << stack << " com " << nbytes << " bytes" << endl << endl;
            stack--;
		}
	}
}

void declara_label(string id) {
	assert(f != NULL);
	t->insereLabel(id, &declarado, f);
}

void checa_label(string id) {
	if(t->buscaLabel(id, f) == false) {
        ostringstream convert;
        convert << "label: " << id << " nao declarada";
        errorMsg(convert.str());
	}
}

void declara_funcao(string id) {
    // se nao foi declarado, declara
    Entrada *aux = t->busca(id, &declarado);
    if(declarado == false) {
        f = t->insereFuncao(id, e, 0);
    }
    // se foi, compara os parametros
    else {
        f = aux;
        begin_parametro = true;
    }
}

void referencia_funcao(string id) {
    if(referenciando(id)) { 
        Entrada *fr = t->busca(id, &declarado);
        if(arg_list.size() != fr->parametros.size()) {
            ostringstream convert;
            convert << "funcao: " << id << " esperava: " << fr->parametros.size() << " parametros mas encontrou: " << arg_list.size() << " parametros";
            errorMsg(convert.str());
        }
        /* checagem dos tipos da funcao
        else
            for(int i = 0; i < arg_list.size(); i++) 
                if(fr->parametros[i].tipo->nome.compare(arg_list[i]) != 0) {
                    std::cout << "@(" << yylineno << ") WARNING - ";
                    cout << "funcao: " << id << " esperava: \"" << fr->parametros[i].tipo->nome << "\" mas encontrou: \"" << arg_list[i] << "\"" << endl;
                }
        */
    } 
}

string int_or_char(string id) {
    if(id[0] == '\'')
        return "char";
    return "int";
}

int yyerror(char const *s) {
	fflush(stdout);
	cout << "@(" << yylineno << ") ERRO - " << s << endl;
    exit(0);
}

void msg_sintatico(string msg) {
    if(debug_sintatico && preProcessamento)
	    cout << "; @(" << yylineno << ") SINTATICO - " << msg << endl;
}

void msg_instrucao(string msg) {
    if(debug_instrucao)
	    cout << "; @(" << yylineno << ") INSTRUCAO - " << msg << endl;
}

int main(int argc, char *argv[]) {
    if(argc < 2) {
        cout << "ERRO - Uso incorreto" << endl
             << "Uso: ./parser arquivo_testes.txt" << endl;
        return 0;
    }
    if(argc == 3)
        debug = 1;

    int yylineno_backup = yylineno; // salva o contador de linhas
    stack_antes_de_entrar_no_escopo = stack;

    t = new TAD();
    offset = stack;

    cout << ";---------- BEGIN - PRE PROCESSAMENTO ----------" << endl;
    yyin = fopen(argv[1], "r"); // abre o arquivo
    preProcessamento = true;
    yyparse();                  // processa o arquivo
    offset = t->filtro(offset);       // remove tudo da tabela de simbolos que nao seja procedure e functions
    preProcessamento = false;
    fclose(yyin);               // fecha o arquivo
    cout << ";---------- END PRE PROCESSAMENTO ----------" << endl;

    yylineno = yylineno_backup; // reseta o contador de linhas

    if(!tem_main)
        errorMsg("o arquivo deve ter um main");

    cout << ";---------- BEGIN ----------" << endl;
    stack = offset;
    if(debug_instrucao) {
        vector<Entrada> listaVarGlobal = t->variaveis_escopo();
        for(int i = 0; i < listaVarGlobal.size(); i++) {
            cout << "; variavel: " << listaVarGlobal[i].nome << " alocada em " << listaVarGlobal[i].endereco << endl << endl;
        }
    }

    yyin = fopen(argv[1], "r");

    cout << "jmp __function_label_main__" << endl;

    // r0 posicao na tela
    // r1 caractere a ser impresso
    // r2 comeco da string na memoria e indice para o load do r1
    // r3 fim da string na memoria
    // r4 caracteres %, d, s, c
    // r5 
    // r6 \0
    // r7 
    cout<< "__printf__:" << endl
        << "loadn r6, #0" << endl  

        << "__printf_loop__:" << endl
        << "loadn r4, #'%'" << endl
        << "loadi r1, r2" << endl
        << "cmp r1, r4" << endl
        << "jeq __side_printf__" << endl
        << "cmp r1, r6" << endl
        << "jeq __printf_fim__" << endl
        << "outchar r1, r0" << endl
        << "inc r0" << endl
        << "dec r2" << endl
        << "jmp __printf_loop__" << endl
        << "__printf_fim__:" << endl
        << "rts" << endl

        << "__side_printf__:" << endl
        << "dec r2" << endl
        << "loadi r5, r2" << endl

        << "loadn r4, #'d'" << endl
        << "cmp r5, r4" << endl
        << "jeq __printf_d__" << endl

        << "loadn r4, #'s'" << endl
        << "cmp r5, r4" << endl
        << "jeq __printf_s__" << endl

        << "loadn r4, #'S'" << endl
        << "cmp r5, r4" << endl
        << "jeq __printf_S__" << endl

        << "loadn r4, #'c'" << endl
        << "cmp r5, r4" << endl
        << "jeq __printf_c__" << endl

        // nao e' nenhum deles entao imprime
        << "outchar r1, r0" << endl
        << "inc r0" << endl     
        << "outchar r5, r0" << endl
        << "inc r0" << endl     
        << "jmp __printf_loop__" << endl;

    cout<< "__printf_d__:" << endl
        << "push r1" << endl
        << "loadn r1, #0" << endl

        << "dec r2" << endl
        << "loadi r5, r2" << endl
        << "loadi r5, r5" << endl
        << "dec r2" << endl
        << "loadn r7, #10" << endl

        << "__printf_d_loop__:" << endl
        << "div r4, r5, r7" << endl
        << "mul r3, r4, r7" << endl
        << "sub r3, r5, r3" << endl
        << "push r3" << endl
        << "inc r1" << endl
        << "cmp r4, r6" << endl
        << "jeq __printf_d_imprime__" << endl
        << "mov r5, r4" << endl
        << "jmp __printf_d_loop__" << endl

        << "__printf_d_imprime__:" << endl
        << "loadn r7, #'0'" << endl
        << "pop r4" << endl
        << "add r4, r4, r7" << endl
        << "outchar r4, r0" << endl
        << "inc r0" << endl
        << "dec r1" << endl
        << "cmp r1, r6" << endl
        << "jne __printf_d_imprime__" << endl

        << "pop r1" << endl
        << "jmp __printf_loop__" << endl;

    cout<< "__printf_s__:" << endl
        //<< "breakp"<< endl
        << "dec r2" << endl
        << "loadi r4, r2" << endl
        << "loadi r4, r4" << endl
        << "dec r2" << endl
        << "__side_printf_volta__:" << endl
        << "loadi r5, r4" << endl
        << "cmp r5, r6" << endl // cmp \0
        << "jeq __printf_loop__" << endl
        << "outchar r5, r0" << endl
        << "dec r4" << endl
        << "inc r0" << endl
        << "jmp __side_printf_volta__" << endl;

    cout<< "__printf_S__:" << endl
        << "dec r2" << endl
        << "loadi r4, r2" << endl
        << "dec r2" << endl
        << "__side_printf2_volta__:" << endl
        << "loadi r5, r4" << endl
        << "cmp r5, r6" << endl // cmp \0
        << "jeq __printf_loop__" << endl
        << "outchar r5, r0" << endl
        << "dec r4" << endl
        << "inc r0" << endl
        << "jmp __side_printf2_volta__" << endl;

    cout<< "__printf_c__:" << endl
        << "dec r2" << endl
        << "loadi r5, r2" << endl
        << "loadi r5, r5" << endl
        << "outchar r5, r0" << endl
        << "dec r2" << endl
        << "inc r0" << endl
        << "jmp __printf_loop__" << endl;

    // operadores logicos
    cout<< "__and_routine__:" << endl
        << "and r0, r1, r0" << endl
        << "loadn r1, #0" << endl
        << "cmp r0, r1" << endl
        << "jne __true__" << endl
        << "jmp __false__" << endl;

    cout<< "__or_routine__:" << endl
        << "or r0, r1, r0" << endl
        << "loadn r1, #0" << endl
        << "cmp r0, r1" << endl
        << "jne __true__" << endl
        << "jmp __false__" << endl;

    cout<< "__equal_routine__:" << endl
        << "cmp r0, r1" << endl
        << "jne __false__" << endl
        << "jmp __true__" << endl;

    cout<< "__not_equal_routine__:" << endl
        << "cmp r0, r1" << endl
        << "jne __true__" << endl
        << "jmp __false__" << endl;

    cout<< "__less_routine__:" << endl
        << "cmp r0, r1" << endl
        << "jle __true__" << endl
        << "jmp __false__" << endl;

    cout<< "__more_routine__:" << endl
        << "cmp r0, r1" << endl
        << "jgr __true__" << endl
        << "jmp __false__" << endl;

    cout<< "__equal_less_routine__:" << endl
        << "cmp r0, r1" << endl
        << "jel __true__" << endl
        << "jmp __false__" << endl;

    cout<< "__equal_more_routine__:" << endl
        << "cmp r0, r1" << endl
        << "jeg __true__" << endl
        << "jmp __false__" << endl;

    cout<< "__true__:" << endl
        << "loadn r0, #1" << endl
        << "storei r2, r0" << endl
        << "rts" << endl;

    cout<< "__false__:" << endl
        << "loadn r0, #0" << endl
        << "storei r2, r0" << endl
        << "rts" << endl;

    yyparse();
    fclose(yyin);
    cout << ";---------- END ----------" << endl;

    //t->log();
    //t->labelLog();
    delete t;

    return 0;
}


