/* A Bison parser, made by GNU Bison 3.6.4.  */

/* Bison interface for Yacc-like parsers in C

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

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

#line 162 "parser.hpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_HPP_INCLUDED  */
