/*
    falta:
        funcao - simulador esta bugado

        switch com problemas na gramatica
        atualizar mapa para matriz e vetor

        nao suporta matriz ou vetor sem indice
*/

%{
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

%}

%union {
    int token;
    std::string *string;
}

    /* Adicionei aos meus */
%token <string> STRING_LITERAL IDENTIFIER CONSTANT

    /* operadores relacionais */
%token <token> MENOR        MAIOR
%token <token> MENOR_IGUAL  MAIOR_IGUAL
%token <token> IGUAL_IGUAL  EXCLAMACAO_IGUAL

    /* operadores logicos */
%token <token> AMPERSAND_AMPERSAND
%token <token> PIPE_PIPE
%token <token> EXCLAMACAO

    /* simbolos de atribuicao */
%token <token> IGUAL
%token <token> MAIS_IGUAL 			MENOS_IGUAL
%token <token> ASTERISCO_IGUAL 		BARRA_IGUAL
%token <token> MAIOR_MAIOR_IGUAL 	MENOR_MENOR_IGUAL
%token <token> PORCENTAGEM_IGUAL CIRCUNFLEXO_IGUAL AMPERSAND_IGUAL PIPE_IGUAL

    /* tipos */
%token <string> VOID INT CHAR BOOL

    /* palavras reservadas */
%token <token> IF	ELSE
%token <token> FOR	WHILE
%token <token> BREAK SWITCH CASE CONTINUE INCLUDE GOTO RETURN CONST DEFAULT EXTERN STATIC

    /* operadores aritimeticos */
%token <token> MAIS MENOS
%token <token> MAIS_MAIS    MENOS_MENOS
%token <token> ASTERISCO    BARRA
%token <token> PORCENTAGEM  CIRCUNFLEXO

    /* simbolos auxiliares */
%token <token> DOIS_PONTOS VIRGULA PONTO_VIRGULA INTERROGACAO SUSTENIDO
%token <token> ABRE_COLCHETES   FECHA_COLCHETES
%token <token> ABRE_PARENTESES  FECHA_PARENTESES
%token <token> ABRE_CHAVES      FECHA_CHAVES

    /* operadores bitwise */
%token <token> MENOR_MENOR MAIOR_MAIOR
%token <token> PIPE AMPERSAND TIL

%token <token> BREAKP GETCH PRINTF


// nao suportados
%token <token> UNSIGNED UNION TYPE_NAME TYPEDEF STRUCT SIZEOF SIGNED RESTRICT REGISTER INLINE IMAGINARY ELLIPSIS
%token <token>  DO COMPLEX AUTO VOLATILE ENUM PONTO

%token <string> DOUBLE SHORT LONG FLOAT


    // esse cara eh o que faz aparecer a mensagem de erro
%define parse.lac full
%define parse.trace
%define parse.error verbose

%language "C"

%start translation_unit

%%

/*
    Referencia as variaveis e constantes
*/
primary_expression
	: IDENTIFIER { 
		msg_sintatico("IDENTIFIER");
        if(referenciando(*$1))
        push(to_str(t->busca(*$1, &declarado)->endereco), 1);
        initialization_size = 1;
	}
    | getch_statement {
		msg_sintatico("getch_statement");
    }
    | CONSTANT	{ 
		msg_sintatico("CONSTANT");
        push(*$1, 2); 
        initialization_size = 1;
	}
    | STRING_LITERAL	{ 
		msg_sintatico("STRING_LITERAL");
        if(begin_printf)
            correcao_printf_string = stack;

        string aux = *$1, aux2; 
        for(int i=0; i < aux.size(); i++) { 
            aux2 = aux[i]; 
            push(aux2, 3); 
        }
        push("0", 2);   // coloca um \0 no fim da string
        initialization_size = aux.size()+1;
	}
    | ABRE_PARENTESES expression FECHA_PARENTESES	{ 
		msg_sintatico("ABRE_PARENTESES expression FECHA_PARENTESES");
        /*
            NAO PRECISA FAZER NADA
        */
	}
    | IDENTIFIER ABRE_PARENTESES FECHA_PARENTESES	{ 
        msg_sintatico("primary_expression: IDENTIFIER ABRE_PARENTESES args_list FECHA_PARENTESES");

        referencia_funcao(*$1);

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() ==0) {
            msg_instrucao("; call funcao: " + *$1);
            msg_instrucao("; salvando as variaveis do escopo");

            // salva as variaveis do escopo para permitir recursao
            vector<Entrada> lista = t->variaveis_escopo();
            for(int i = 0; i < lista.size(); i++) {
                cout << "load r0, " << lista[i].endereco << endl
                     << "push r0" << endl;
            }

            msg_instrucao("; nao tem parametros");

            cout << "call " << "__function_label_" << *$1 << "__" << endl;

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
    | IDENTIFIER ABRE_PARENTESES argument_expression_list FECHA_PARENTESES	{ 
		msg_sintatico("postfix_expression ABRE_PARENTESES argument_expression_list FECHA_PARENTESES");

        referencia_funcao(*$1);

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() ==0) {
            msg_instrucao("; call funcao: " + *$1);
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

            cout << "call " << "__function_label_" << *$1 << "__" << endl;

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
    | IDENTIFIER ABRE_COLCHETES expression FECHA_COLCHETES	{ 
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
        referenciando(*$1);
        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() == 0) {
            if(debug_instrucao) 
                cout << "; " << t->buscaEndereco(stack) << "(" << stack << ") recebe o conteudo da variavel: " << *$1 << endl; 

            endereco_base = t->busca(*$1, &declarado)->endereco;

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
    | IDENTIFIER ABRE_COLCHETES expression FECHA_COLCHETES ABRE_COLCHETES expression FECHA_COLCHETES { 
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
        referenciando(*$1);  
        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() == 0) {
            if(debug_instrucao) 
                cout << "; " << t->buscaEndereco(stack) << "(" << stack << ") recebe o conteudo da variavel: " << *$1 << endl; 

            endereco_base = t->busca(*$1, &declarado)->endereco;

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
    ;

postfix_expression
	: primary_expression { 
		msg_sintatico("primary_expression");
	}
    | postfix_expression PONTO IDENTIFIER	{ 
		msg_sintatico("postfix_expression PONTO IDENTIFIER");
	}
    /*
    | postfix_expression ASTERISCO IDENTIFIER	{ 
		msg_sintatico("postfix_expression ASTERISCO IDENTIFIER");
        //NAO E' PONTEIRO
	}
    */
    | postfix_expression MAIS_MAIS	{ 
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
    | postfix_expression MENOS_MENOS	{ 
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
    | ABRE_PARENTESES type_name FECHA_PARENTESES ABRE_CHAVES initializer_list FECHA_CHAVES	{ 
		msg_sintatico("ABRE_PARENTESES type_name FECHA_PARENTESES ABRE_CHAVES initializer_list FECHA_CHAVES");
	}
    /*
    | ABRE_PARENTESES type_name FECHA_PARENTESES ABRE_CHAVES initializer_list VIRGULA FECHA_CHAVES	{ 
		msg_sintatico("ABRE_PARENTESES type_name FECHA_PARENTESES ABRE_CHAVES initializer_list VIRGULA FECHA_CHAVES");
	}
    */
	;

argument_expression_list
	: assignment_expression { 
		msg_sintatico("assignment_expression");
        arg_list.push_back(stack+1);
	}
    | argument_expression_list VIRGULA assignment_expression	{ 
		msg_sintatico("argument_expression_list VIRGULA assignment_expression");
        arg_list.push_back(stack+1);
	}
	;

unary_expression
	: postfix_expression { 
		msg_sintatico("postfix_expression");
	}
    | MAIS_MAIS unary_expression	{ 
		msg_sintatico("MAIS_MAIS unary_expression");
        if(!preProcessamento)
        cout<< "load r0, " << stack+1 << endl
            << "inc r0" << endl
            << "store " << stack+1 << endl;
	}
    | MENOS_MENOS unary_expression	{ 
		msg_sintatico("MENOS_MENOS unary_expression");
        if(!preProcessamento)
        cout<< "load r0, " << stack+1 << endl
            << "dec r0" << endl
            << "store " << stack+1 << endl;
	}
    | unary_operator cast_expression { 
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
    | SIZEOF unary_expression	{ 
		msg_sintatico("SIZEOF unary_expression");
	}
    | SIZEOF ABRE_PARENTESES type_name FECHA_PARENTESES	{ 
		msg_sintatico("SIZEOF ABRE_PARENTESES type_name FECHA_PARENTESES");
	}
	;

unary_operator
	: AMPERSAND { 
		msg_sintatico("AMPERSAND");
        operacao = ampersand;
	}
    | ASTERISCO	{ 
		msg_sintatico("ASTERISCO2");
        operacao = asterisco;
	}
    | MAIS	{ 
		msg_sintatico("MAIS");
	}
    | MENOS	{ 
		msg_sintatico("MENOS");
        operacao = menos;
	}
    | TIL	{ 
		msg_sintatico("TIL");
	}
    | EXCLAMACAO	{ 
		msg_sintatico("EXCLAMACAO");
        operacao = exclamacao;
	}
	;

cast_expression
	: unary_expression { 
		msg_sintatico("unary_expression");
	}
    | ABRE_PARENTESES type_name FECHA_PARENTESES cast_expression	{ 
		msg_sintatico("ABRE_PARENTESES type_name FECHA_PARENTESES cast_expression");
	}
	;

multiplicative_expression // OK
	: cast_expression { 
		msg_sintatico("cast_expression");
	}
    | multiplicative_expression ASTERISCO cast_expression	{ 
		msg_sintatico("multiplicative_expression ASTERISCO cast_expression");
        expressao_binaria('*'); 
	}
    | multiplicative_expression BARRA cast_expression	{ 
		msg_sintatico("multiplicative_expression BARRA cast_expression");
        expressao_binaria('/'); 
	}
    | multiplicative_expression PORCENTAGEM cast_expression	{ 
		msg_sintatico("multiplicative_expression '' cast_expression");
        expressao_binaria('%'); 
	}
	;

additive_expression // OK
	: multiplicative_expression { 
		msg_sintatico("multiplicative_expression");
	}
    | additive_expression MAIS multiplicative_expression	{ 
		msg_sintatico("additive_expression MAIS multiplicative_expression");
        expressao_binaria('+'); 
	}
    | additive_expression MENOS multiplicative_expression	{ 
		msg_sintatico("additive_expression MENOS multiplicative_expression");
        expressao_binaria('-'); 
	}
	;

shift_expression // OK
	: additive_expression { 
		msg_sintatico("additive_expression");
	}
    | shift_expression MENOR_MENOR additive_expression	{ 
		msg_sintatico("shift_expression MENOR_MENOR additive_expression");
        expressao_binaria('l'); 
	}
    | shift_expression MAIOR_MAIOR additive_expression	{ 
		msg_sintatico("shift_expression MAIOR_MAIOR additive_expression");
        expressao_binaria('r'); 
	}
	;

relational_expression // testar
	: shift_expression { 
		msg_sintatico("shift_expression");
	}
    | relational_expression MENOR shift_expression	{ 
		msg_sintatico("relational_expression MENOR shift_expression");
        relacao_binaria('<');
	}
    | relational_expression MAIOR shift_expression	{ 
		msg_sintatico("relational_expression MAIOR shift_expression");
        relacao_binaria('>');
	}
    | relational_expression MENOR_IGUAL shift_expression	{ 
		msg_sintatico("relational_expression MENOR_IGUAL shift_expression");
        relacao_binaria('m');
	}
    | relational_expression MAIOR_IGUAL shift_expression	{ 
		msg_sintatico("relational_expression MAIOR_IGUAL shift_expression");
        relacao_binaria('M');
	}
	;

equality_expression // testar
	: relational_expression { 
		msg_sintatico("relational_expression");
	}
    | equality_expression IGUAL_IGUAL relational_expression	{ 
		msg_sintatico("equality_expression IGUAL_IGUAL relational_expression");
        relacao_binaria('=');
	}
    | equality_expression EXCLAMACAO_IGUAL relational_expression	{ 
		msg_sintatico("equality_expression EXCLAMACAO_IGUAL relational_expression");
        relacao_binaria('!');
	}
	;

and_expression // testar
	: equality_expression { 
		msg_sintatico("equality_expression");
	}
    | and_expression AMPERSAND equality_expression	{ 
		msg_sintatico("and_expression AMPERSAND equality_expression");
        expressao_binaria('&'); 
	}
	;

exclusive_or_expression // testar
	: and_expression { 
		msg_sintatico("and_expression");
	}
    | exclusive_or_expression CIRCUNFLEXO and_expression	{ 
		msg_sintatico("exclusive_or_expression CIRCUNFLEXO and_expression");
        expressao_binaria('^'); 
	}
	;

inclusive_or_expression // OK
	: exclusive_or_expression { 
		msg_sintatico("exclusive_or_expression");
	}
    | inclusive_or_expression PIPE exclusive_or_expression	{ 
		msg_sintatico("inclusive_or_expression PIPE exclusive_or_expression");
        expressao_binaria('|'); 
	}
	;

logical_and_expression // testar
	: inclusive_or_expression { 
		msg_sintatico("inclusive_or_expression");
	}
    | logical_and_expression AMPERSAND_AMPERSAND inclusive_or_expression	{ 
		msg_sintatico("logical_and_expression AMPERSAND_AMPERSAND inclusive_or_expression");
        relacao_binaria('e');
	}
	;

logical_or_expression // testar
	: logical_and_expression { 
		msg_sintatico("logical_and_expression");
	}
    | logical_or_expression PIPE_PIPE logical_and_expression	{ 
		msg_sintatico("logical_or_expression PIPE_PIPE logical_and_expression");
        relacao_binaria('o');
	}
	;

conditional_expression // testar
	: logical_or_expression { 
		msg_sintatico("logical_or_expression");
	}
    | logical_or_expression INTERROGACAO expression DOIS_PONTOS conditional_expression	{ 
		msg_sintatico("logical_or_expression INTERROGACAO expression DOIS_PONTOS conditional_expression");
        relacao_binaria('?');
	}
	;

assignment_expression
	: conditional_expression { 
		msg_sintatico("conditional_expression");
	}
    | unary_expression assignment_operator assignment_expression	{ 
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
	;

assignment_operator // OK
	: IGUAL { 
		msg_sintatico("IGUAL");
        atribuicao = eq;
	}
    | ASTERISCO_IGUAL	{ 
		msg_sintatico("ASTERISCO_IGUAL");
        atribuicao = mul_eq;
	}
    | BARRA_IGUAL	{ 
		msg_sintatico("BARRA_IGUAL");
        atribuicao = div_eq;
	}
    | PORCENTAGEM_IGUAL	{ 
		msg_sintatico("PORCENTAGEM_IGUAL");
        atribuicao = mod_eq;
	}
    | MAIS_IGUAL	{ 
		msg_sintatico("MAIS_IGUAL");
        atribuicao = add_eq;
	}
    | MENOS_IGUAL	{ 
		msg_sintatico("MENOS_IGUAL");
        atribuicao = sub_eq;
	}
    | MENOR_MENOR_IGUAL	{ 
		msg_sintatico("MENOR_MENOR_IGUAL");
        atribuicao = dec_eq;
	}
    | MAIOR_MAIOR_IGUAL	{ 
		msg_sintatico("MAIOR_MAIOR_IGUAL");
        atribuicao = inc_eq;
	}
    | AMPERSAND_IGUAL	{ 
		msg_sintatico("AMPERSAND_IGUAL");
        atribuicao = land_eq;
	}
    | CIRCUNFLEXO_IGUAL	{ 
		msg_sintatico("CIRCUNFLEXO_IGUAL");
        atribuicao = lxor_eq;
	}
    | PIPE_IGUAL	{ 
		msg_sintatico("PIPE_IGUAL");
        atribuicao = lor_eq;
	}
	;

expression
	: assignment_expression { 
		msg_sintatico("assignment_expression");
	}
    | expression VIRGULA assignment_expression	{ 
		msg_sintatico("expression VIRGULA assignment_expression");
	}
	;

constant_expression
	: conditional_expression { 
		msg_sintatico("conditional_expression");
	}
	;

declaration
	: declaration_specifiers PONTO_VIRGULA { 
		msg_sintatico("declaration_specifiers PONTO_VIRGULA");
	}
    | declaration_specifiers init_declarator_list PONTO_VIRGULA	{ 
		msg_sintatico("declaration_specifiers init_declarator_list PONTO_VIRGULA");
	}
	;

declaration_specifiers
	: storage_class_specifier { 
		msg_sintatico("storage_class_specifier");
	}
    | storage_class_specifier declaration_specifiers	{ 
		msg_sintatico("storage_class_specifier declaration_specifiers");
	}
    | type_specifier	{ 
		msg_sintatico("type_specifier");
	}
    | type_specifier declaration_specifiers	{ 
		msg_sintatico("type_specifier declaration_specifiers");
	}
    | type_qualifier	{ 
		msg_sintatico("type_qualifier");
	}
    | type_qualifier declaration_specifiers	{ 
		msg_sintatico("type_qualifier declaration_specifiers");
	}
    | function_specifier	{ 
		msg_sintatico("function_specifier");
	}
    | function_specifier declaration_specifiers	{ 
		msg_sintatico("function_specifier declaration_specifiers");
	}
	;

init_declarator_list
	: init_declarator { 
		msg_sintatico("init_declarator");
	}
    | init_declarator_list VIRGULA init_declarator	{ 
		msg_sintatico("init_declarator_list VIRGULA init_declarator");
	}
	;

init_declarator
	: declarator { 
		msg_sintatico("declarator");
        if(correcao_stack_matriz != -1 && stack != correcao_stack_matriz) {
            msg_instrucao("acerta o ponteiro da matriz/vetor");
            //cout << "stack: " << stack << endl;
            //cout << "correcao: " << correcao_stack_matriz << endl;
            stack = correcao_stack_matriz;
            correcao_stack_matriz = -1;
        }
	}
    | declarator IGUAL initializer	{ 
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
	;

storage_class_specifier
	: TYPEDEF { 
		msg_sintatico("TYPEDEF");
	}
    | EXTERN	{ 
		msg_sintatico("EXTERN");
	}
    | STATIC	{ 
		msg_sintatico("STATIC");
	}
    | AUTO	{ 
		msg_sintatico("AUTO");
	}
    | REGISTER	{ 
		msg_sintatico("REGISTER");
	}
	;

type_specifier
	: VOID { 
		msg_sintatico("VOID");
        salva_tipo("void");
	}
    | CHAR	{ 
		msg_sintatico("CHAR");
        salva_tipo("char");
	}
    | SHORT	{ 
		msg_sintatico("SHORT");
        salva_tipo("short");
	}
    | INT	{ 
		msg_sintatico("INT");
        salva_tipo("int");
	}
    | LONG	{ 
		msg_sintatico("LONG");
        salva_tipo("long");
	}
    | FLOAT	{ 
		msg_sintatico("FLOAT");
        salva_tipo("long");
	}
    | DOUBLE	{ 
		msg_sintatico("DOUBLE");
        salva_tipo("double");
	}
    | SIGNED	{ 
		msg_sintatico("SIGNED");
	}
    | UNSIGNED	{ 
		msg_sintatico("UNSIGNED");
	}
    | BOOL	{ 
		msg_sintatico("BOOL");
        salva_tipo("bool");
	}
    | struct_or_union_specifier	{ 
		msg_sintatico("struct_or_union_specifier");
	}
    | enum_specifier	{ 
		msg_sintatico("enum_specifier");
	}
    | TYPE_NAME	{ 
		msg_sintatico("TYPE_NAME");
	}
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER ABRE_CHAVES struct_declaration_list FECHA_CHAVES { 
		msg_sintatico("struct_or_union IDENTIFIER ABRE_CHAVES struct_declaration_list FECHA_CHAVES");
	}
    | struct_or_union ABRE_CHAVES struct_declaration_list FECHA_CHAVES	{ 
		msg_sintatico("struct_or_union ABRE_CHAVES struct_declaration_list FECHA_CHAVES");
	}
    | struct_or_union IDENTIFIER	{ 
		msg_sintatico("struct_or_union IDENTIFIER");
	}
	;

struct_or_union
	: STRUCT { 
		msg_sintatico("STRUCT");
	}
    | UNION	{ 
		msg_sintatico("UNION");
	}
	;

struct_declaration_list
	: struct_declaration { 
		msg_sintatico("struct_declaration");
	}
    | struct_declaration_list struct_declaration	{ 
		msg_sintatico("struct_declaration_list struct_declaration");
	}
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list PONTO_VIRGULA { 
		msg_sintatico("specifier_qualifier_list struct_declarator_list PONTO_VIRGULA");
	}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list { 
		msg_sintatico("type_specifier specifier_qualifier_list");
	}
    | type_specifier	{ 
		msg_sintatico("type_specifier");
	}
    | type_qualifier specifier_qualifier_list	{ 
		msg_sintatico("type_qualifier specifier_qualifier_list");
	}
    | type_qualifier	{ 
		msg_sintatico("type_qualifier");
	}
	;

struct_declarator_list
	: struct_declarator { 
		msg_sintatico("struct_declarator");
	}
    | struct_declarator_list VIRGULA struct_declarator	{ 
		msg_sintatico("struct_declarator_list VIRGULA struct_declarator");
	}
	;

struct_declarator
	: declarator { 
		msg_sintatico("declarator");
	}
    | DOIS_PONTOS constant_expression	{ 
		msg_sintatico("DOIS_PONTOS constant_expression");
	}
    | declarator DOIS_PONTOS constant_expression	{ 
		msg_sintatico("declarator DOIS_PONTOS constant_expression");
	}
	;

enum_specifier
	: ENUM ABRE_CHAVES enumerator_list FECHA_CHAVES { 
		msg_sintatico("ENUM ABRE_CHAVES enumerator_list FECHA_CHAVES");
	}
    | ENUM IDENTIFIER ABRE_CHAVES enumerator_list FECHA_CHAVES	{ 
		msg_sintatico("ENUM IDENTIFIER ABRE_CHAVES enumerator_list FECHA_CHAVES");
	}
    | ENUM ABRE_CHAVES enumerator_list VIRGULA FECHA_CHAVES	{ 
		msg_sintatico("ENUM ABRE_CHAVES enumerator_list VIRGULA FECHA_CHAVES");
	}
    | ENUM IDENTIFIER ABRE_CHAVES enumerator_list VIRGULA FECHA_CHAVES	{ 
		msg_sintatico("ENUM IDENTIFIER ABRE_CHAVES enumerator_list VIRGULA FECHA_CHAVES");
	}
    | ENUM IDENTIFIER	{ 
		msg_sintatico("ENUM IDENTIFIER");
	}
	;

enumerator_list
	: enumerator { 
		msg_sintatico("enumerator");
	}
    | enumerator_list VIRGULA enumerator	{ 
		msg_sintatico("enumerator_list VIRGULA enumerator");
	}
	;

enumerator
	: IDENTIFIER { 
		msg_sintatico("IDENTIFIER");
	}
    | IDENTIFIER IGUAL constant_expression	{ 
		msg_sintatico("IDENTIFIER IGUAL constant_expression");
	}
	;

type_qualifier
	: CONST { 
		msg_sintatico("CONST");
	}
    | RESTRICT	{ 
		msg_sintatico("RESTRICT");
	}
    | VOLATILE	{ 
		msg_sintatico("VOLATILE");
	}
	;

function_specifier
	: INLINE { 
		msg_sintatico("INLINE");
	}
	;

declarator
	: pointer direct_declarator { 
		msg_sintatico("pointer direct_declarator");
	}
    | direct_declarator	{ 
		msg_sintatico("direct_declarator");
	}
	;

/*
    Declaracao de variaveis
*/
direct_declarator
	: IDENTIFIER { 
		msg_sintatico("IDENTIFIER");
        declara_variaveis_e_parametros(*$1, 1);
        salva_identificador = *$1; 
	}
    | IDENTIFIER ABRE_COLCHETES CONSTANT FECHA_COLCHETES	{ 
		msg_sintatico("direct_declarator ABRE_COLCHETES CONSTANT FECHA_COLCHETES");

        declara_variaveis_e_parametros(*$1, atoi($3->c_str())+1); 
        salva_identificador = *$1;

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() == 0) {
            if(flag_ponteiro > 0)
                errorMsg("vetor de ponteiros nao e' suportado");

                msg_instrucao("acerta o ponteiro da matriz/vetor");
                cout<< "loadn r0, #" << stack << endl
                    << "store " << stack+1 << ", r0" << endl; 

            if(!begin_parametro) {
                salva_stack = stack; 
                correcao_stack_matriz = stack - atoi($3->c_str());
            }
        }
	}
    | IDENTIFIER ABRE_COLCHETES CONSTANT FECHA_COLCHETES ABRE_COLCHETES CONSTANT FECHA_COLCHETES { 
		msg_sintatico("direct_declarator ABRE_COLCHETES CONSTANT FECHA_COLCHETES");

        declara_variaveis_e_parametros(*$1, atoi($3->c_str()) * atoi($6->c_str()) + 1 + atoi($3->c_str())); 
        salva_identificador = *$1;

        if(!preProcessamento && t->getEscopo() > 0 || preProcessamento && t->getEscopo() == 0) {
            if(flag_ponteiro > 0)
                errorMsg("matriz de ponteiros nao e' suportado");

            if(!begin_parametro) {
                salva_stack = stack; 

                msg_instrucao("acerta o ponteiro da matriz/vetor");
                cout<< "loadn r0, #" << stack << endl
                    << "store " << stack+1 << ", r0" << endl; 

                int nlinhas = atoi($3->c_str());
                int ncolunas = atoi($6->c_str());
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
    /*
    | direct_declarator ABRE_COLCHETES FECHA_COLCHETES	{ 
		msg_sintatico("direct_declarator ABRE_COLCHETES FECHA_COLCHETES");
	}
    | direct_declarator ABRE_COLCHETES CONSTANT FECHA_COLCHETES	{ 
		msg_sintatico("direct_declarator ABRE_COLCHETES CONSTANT FECHA_COLCHETES");
	}
    */
	;

pointer
	: ASTERISCO { 
		msg_sintatico("ASTERISCO");
	}
    | ASTERISCO type_qualifier_list	{ 
		msg_sintatico("ASTERISCO type_qualifier_list");
	}
    | ASTERISCO pointer	{ 
		msg_sintatico("ASTERISCO pointer");
	}
    | ASTERISCO type_qualifier_list pointer	{ 
		msg_sintatico("ASTERISCO type_qualifier_list pointer");
	}
	;

type_qualifier_list
	: type_qualifier { 
		msg_sintatico("type_qualifier");
	}
    | type_qualifier_list type_qualifier	{ 
		msg_sintatico("type_qualifier_list type_qualifier");
	}
	;

type_name
	: specifier_qualifier_list { 
		msg_sintatico("specifier_qualifier_list");
	}
    | specifier_qualifier_list abstract_declarator	{ 
		msg_sintatico("specifier_qualifier_list abstract_declarator");
	}
	;

abstract_declarator
	: pointer { 
		msg_sintatico("pointer");
	}
    | direct_abstract_declarator	{ 
		msg_sintatico("direct_abstract_declarator");
	}
    | pointer direct_abstract_declarator	{ 
		msg_sintatico("pointer direct_abstract_declarator");
	}
	;

direct_abstract_declarator
	: ABRE_PARENTESES abstract_declarator FECHA_PARENTESES { 
		msg_sintatico("ABRE_PARENTESES abstract_declarator FECHA_PARENTESES");
	}
    | ABRE_COLCHETES FECHA_COLCHETES	{ 
		msg_sintatico("ABRE_COLCHETES FECHA_COLCHETES");
	}
    | ABRE_COLCHETES assignment_expression FECHA_COLCHETES	{ 
		msg_sintatico("ABRE_COLCHETES assignment_expression FECHA_COLCHETES");
	}
    | direct_abstract_declarator ABRE_COLCHETES FECHA_COLCHETES	{ 
		msg_sintatico("direct_abstract_declarator ABRE_COLCHETES FECHA_COLCHETES");
	}
    | direct_abstract_declarator ABRE_COLCHETES assignment_expression FECHA_COLCHETES	{ 
		msg_sintatico("direct_abstract_declarator ABRE_COLCHETES assignment_expression FECHA_COLCHETES");
	}
    | ABRE_COLCHETES ASTERISCO FECHA_COLCHETES	{ 
		msg_sintatico("ABRE_COLCHETES ASTERISCO FECHA_COLCHETES");
	}
    | direct_abstract_declarator ABRE_COLCHETES ASTERISCO FECHA_COLCHETES	{ 
		msg_sintatico("direct_abstract_declarator ABRE_COLCHETES ASTERISCO FECHA_COLCHETES");
	}
    | ABRE_PARENTESES FECHA_PARENTESES	{ 
		msg_sintatico("ABRE_PARENTESES FECHA_PARENTESES");
	}
	;

initializer
	: assignment_expression { 
		msg_sintatico("assignment_expression");
        if(initialization_size == 1)
            initializer_list.push_back(stack+1);
        else if(initialization_size > 1)
            initializer_list.push_back(stack+initialization_size);
	}
    | ABRE_CHAVES initializer_list FECHA_CHAVES	{ 
		msg_sintatico("ABRE_CHAVES initializer_list FECHA_CHAVES");
	}
	;

initializer_list
	: initializer { 
		msg_sintatico("initializer");
	}
    | designation initializer	{ 
		msg_sintatico("designation initializer");
	}
    | initializer_list VIRGULA initializer	{ 
		msg_sintatico("initializer_list VIRGULA initializer");
	}
    | initializer_list VIRGULA designation initializer	{ 
		msg_sintatico("initializer_list VIRGULA designation initializer");
	}
	;

designation
	: designator_list IGUAL { 
		msg_sintatico("designator_list IGUAL");
	}
	;

designator_list
	: designator { 
		msg_sintatico("designator");
	}
    | designator_list designator	{ 
		msg_sintatico("designator_list designator");
	}
	;

designator
	: ABRE_COLCHETES constant_expression FECHA_COLCHETES { 
		msg_sintatico("ABRE_COLCHETES constant_expression FECHA_COLCHETES");
	}
    | PONTO IDENTIFIER	{ 
		msg_sintatico("PONTO IDENTIFIER");
	}
	;

statement: 
        labeled_statement { 
		msg_sintatico("labeled_statement");
	}
    | compound_statement	{ 
		msg_sintatico("compound_statement");
	}
    | expression_statement	{ 
		msg_sintatico("expression_statement");
	}
    | selection_statement	{ 
		msg_sintatico("selection_statement");
	}
    | iteration_statement	{ 
		msg_sintatico("iteration_statement");
	}
    | jump_statement	{ 
		msg_sintatico("jump_statement");
	}
    | breakp_statement {
		msg_sintatico("breakp_statement");
    }
    | printf_statement {
		msg_sintatico("printf_statement");
    }
	;

breakp_statement:
        BREAKP PONTO_VIRGULA {
        msg_sintatico("breakp_statement breakp");
        if(!preProcessamento)
        cout << "breakp" << endl; 
    }
    ;

getch_statement:
        GETCH ABRE_PARENTESES FECHA_PARENTESES { 
        msg_sintatico("breakp getch abre_parenteses fecha_parenteses");
        if(!preProcessamento) {
            cout << "inchar r0" << endl; 
            cout << "store " << stack << ", r0" << endl;
            stack--;
        }
    }

opt_args:
    |   VIRGULA assignment_expression {
        msg_sintatico("opt_args VIRGULA primary_expression");
        if(correcao_printf_string > 0) {
            printf_args.push_back(correcao_printf_string);
            correcao_printf_string = 0;
        }
        else
            printf_args.push_back(stack+1);
    }
    |   opt_args VIRGULA assignment_expression {
        msg_sintatico("opt_args opt_args VIRGULA primary_expression");
        if(correcao_printf_string > 0) {
            printf_args.push_back(correcao_printf_string);
            correcao_printf_string = 0;
        }
        else
            printf_args.push_back(stack+1);
    }
    ;

printf:
        PRINTF {
        msg_sintatico("printf printf");
        if(!preProcessamento) {
            begin_printf = 1;
            //if(!printf_args.empty())
                printf_args.clear();
        }
    }
    ;

printf_statement:
        printf ABRE_PARENTESES assignment_expression VIRGULA assignment_expression VIRGULA STRING_LITERAL opt_args FECHA_PARENTESES PONTO_VIRGULA {
        msg_sintatico("breakp printf abre_parenteses primary_expression virgula primary_expression virgula string_literal opt_args fecha_parenteses");
        if(!preProcessamento) {

            string aux = *$7;
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
    ;

labeled_statement
	: IDENTIFIER DOIS_PONTOS statement { 
		msg_sintatico("IDENTIFIER DOIS_PONTOS statement");
	}
    | CASE constant_expression begin_case statement { 
		msg_sintatico("CASE constant_expression DOIS_PONTOS statement");
        cout << "; labeled_statement case, zerou" << endl;
        insideCase = 0;
        cout<< "jmp __label_statement_" << statement_seq+1 << "__" << endl;
	}
    | DEFAULT begin_case statement	{ 
		msg_sintatico("DEFAULT DOIS_PONTOS statement");
        cout << "; labeled_statement default, zerou" << endl;
        insideCase = 0;
	}
	;

begin_case:
        DOIS_PONTOS {   
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
    ;

compound_statement
	: ABRE_CHAVES FECHA_CHAVES { 
		msg_sintatico("ABRE_CHAVES FECHA_CHAVES");
	}
    | ABRE_CHAVES block_item_list FECHA_CHAVES	{ 
		msg_sintatico("ABRE_CHAVES block_item_list FECHA_CHAVES");
	}
	;

block_item_list
	: block_item { 
		msg_sintatico("block_item");
	}
    | block_item_list block_item	{ 
		msg_sintatico("block_item_list block_item");
	}
	;

block_item
	: declaration { 
		msg_sintatico("declaration");
	}
    | statement	{ 
		msg_sintatico("statement");
	}
	;

expression_statement
	: PONTO_VIRGULA { 
		msg_sintatico("PONTO_VIRGULA");
	}
    | expression PONTO_VIRGULA	{ 
		msg_sintatico("expression PONTO_VIRGULA");
	}
	;

selection_statement
	: IF ABRE_PARENTESES expression begin_labeled statement { 
		msg_sintatico("IF ABRE_PARENTESES expression FECHA_PARENTESES statement");
        if(!preProcessamento) {
            cout << "__exit_if_label" << if_stack.back() << "__:" << endl; 
            if_stack.pop_back();
        }
	}
    | IF ABRE_PARENTESES expression begin_labeled statement begin_else statement	{ 
		msg_sintatico("IF ABRE_PARENTESES expression FECHA_PARENTESES statement ELSE statement");
        if(!preProcessamento) {
            cout << "__exit_else_label" << if_stack.back() << "__:" << endl; 
            if_stack.pop_back();
        }
	}
    | SWITCH ABRE_PARENTESES expression begin_switch statement	{ 
		msg_sintatico("SWITCH ABRE_PARENTESES expression FECHA_PARENTESES statement");
        insideSwitch--;
        if(switch_stack.back() == 1)
            switch_stack.pop_back();
        else
            errorMsg("switch stack esta errada");
        switch_seq++;
	}
	;

begin_switch:
        FECHA_PARENTESES {
        if(!preProcessamento)
            cout<< "load r0, " << stack+1 << endl;
        insideSwitch++;
        switch_stack.push_back(1);
    }
    ;

begin_labeled:
        FECHA_PARENTESES { 
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
    ;

begin_else:
        ELSE { 
        msg_sintatico("begin_else else");
        if(!preProcessamento) {
            cout << "jmp __exit_else_label" << if_stack.back() << "__" << endl; 
            cout << "__exit_if_label" << if_stack.back() << "__:" << endl;
        }
    }
    ;

iteration_statement
	: begin_while ABRE_PARENTESES expression begin_labeled2 statement { 
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
    | DO statement WHILE ABRE_PARENTESES expression FECHA_PARENTESES PONTO_VIRGULA	{ 
		msg_sintatico("DO statement WHILE ABRE_PARENTESES expression FECHA_PARENTESES PONTO_VIRGULA");
        errorMsg("do while nao e' suportado nesta versao");
	}
    | begin_for ABRE_PARENTESES begin_labeled4 begin_labeled3 begin_labeled5 statement	{ 
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
    | begin_for ABRE_PARENTESES begin_labeled4 begin_labeled3 expression begin_labeled5 statement	{ 
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
	;

begin_labeled5:
        FECHA_PARENTESES { 
        if(!preProcessamento) {
        cout << "jmp __loop_label_begin"<< loop_stack.back() << "__" << endl;
        cout << "__loop_label3_begin" << loop_stack.back() << "__:" << endl;
        }
    } 
    ;

begin_while:
        WHILE { 
        msg_sintatico("begin_while while");
        msg_instrucao("while");
        loop_stack.push_back(loopseq);
            insideLoop++;
            if(!preProcessamento)
                cout << "__loop_label_begin" << loop_stack.back() << "__:" << endl; 
        switch_stack.push_back(2);
        loopseq++;
    }
    ;

begin_labeled2:
        FECHA_PARENTESES { 
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
    ;

begin_for:
        FOR { 
        msg_sintatico("begin_for for");
            insideLoop++;
            if(!preProcessamento && debug_instrucao)
                cout << ";----- begin for -----" << endl;
        switch_stack.push_back(2);
        loop_stack.push_back(loopseq);
        loopseq++;
    }
    ;

begin_labeled3:
        expression_statement {
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
    ;

begin_labeled4:
        expression_statement { 
        msg_sintatico("begin_labeled4 expression_statement");
        if(!preProcessamento)
            cout << "__loop_label_begin" << loop_stack.back() << "__:" << endl; 
    }
    ;

jump_statement // testar
	: GOTO IDENTIFIER PONTO_VIRGULA { 
		msg_sintatico("GOTO IDENTIFIER PONTO_VIRGULA");
        checa_label(*$2); 
        if(!preProcessamento && debug_sintatico) 
            cout << "jump_statement: IDENTIFIER " << *$2 << endl; 
	}
    | CONTINUE PONTO_VIRGULA	{ 
		msg_sintatico("CONTINUE PONTO_VIRGULA");
        if(insideLoop == 0) { 
            errorMsg("continue fora de loop"); 
        } 
        if(!preProcessamento)
        cout << "jmp __loop_label_begin"<< loop_stack.back() << "__" << endl;
	}
    | BREAK PONTO_VIRGULA	{ 
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
    | RETURN PONTO_VIRGULA	{ 
		msg_sintatico("RETURN PONTO_VIRGULA");
        if(!preProcessamento && f->nome != "main") {
            cout << "rts" << endl;
        }
        else if(!preProcessamento && f->nome == "main") {
            cout << "breakp" << endl;
        }
	}
    | RETURN expression PONTO_VIRGULA	{ 
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
	;

translation_unit
	: external_declaration { 
		msg_sintatico("external_declaration");
	}
    | translation_unit external_declaration	{ 
		msg_sintatico("translation_unit external_declaration");
	}
	;

external_declaration
	: function_definition { 
		msg_sintatico("function_definition");
	}
    | declaration	{ 
		msg_sintatico("declaration");
	}
	;

function_definition
	:   declaration_specifiers begin_funcao begin_parametro opt_parametros end_parametro compound_statement	{ 
		msg_sintatico("declaration_specifiers declarator compound_statement");
        function_definition();
	}
	;

opt_parametros:
    | parameter_list {
        msg_sintatico("opt_parametros parameter_list");
    }
    ;

parameter_list
	: parameter_declaration	{ 
        msg_sintatico("parameter_list parameter_declaration");
    }
    | parameter_list VIRGULA parameter_declaration { 
        msg_sintatico("parameter_list parameter_list VIRGULA parameter_declaration");
    }
	;

parameter_declaration
	: type_specifier pointer direct_declarator { 
        flag_ponteiro = -1; 
        msg_sintatico("parameter_declaration type_specifier pointer direct_declarator");
    }
	| type_specifier direct_declarator { 
        msg_sintatico("parameter_declaration type_specifier direct_declarator");
    }
	;

begin_funcao:
        IDENTIFIER { 
        msg_sintatico("begin_funcao IDENTIFIER");

        if(*$1 == "main") {
            tem_main = true;
            is_main = true;
        }

        declara_funcao(*$1); 
        t->insereEscopo(); 
        if(type_void) 
            isFunctionVoid = true; 
        stack_antes_de_entrar_no_escopo = stack; 
    }
    ;

begin_parametro:
		ABRE_PARENTESES { 
        msg_sintatico("begin_parametro ABRE_PARENTESES");

        begin_parametro = true; 
        if(!preProcessamento) {
            msg_instrucao("; declarando funcao: " + f->nome);
            cout << "__function_label_" << f->nome << "__:" << endl;
        }
    }
	;

end_parametro:
		FECHA_PARENTESES { 
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
	;

%%

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


