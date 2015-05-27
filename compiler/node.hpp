#ifndef NODE_HPP
#define NODE_HPP

#include <vector>
#include <string>
#include <iostream>

using namespace std;

typedef enum {variavel, tipo, funcao, parametro, constante, label} identificador;

class Entrada {
    public:
        // atributos gerais, todos tem
        string nome;
        identificador id;

        // atributos de variavel
        Entrada *tipo;
        int endereco;
        int ponteiro;

        // atributos de tipo
        int nbytes;
        Entrada *tipo_elementar;

        // atributos de constante
        // Tipo
        string valor;

        // atributos de funcoes
        vector<Entrada> parametros;

        // atributos de labels
        Entrada *funcao;

        Entrada(string &nome, identificador id);

        // precisa usar essa funcao para que o vector parametros tenha copias do parametros e nao ponteiros
        // se o vector tiver ponteiros, qnd terminar o escopo dos parametros vai dar segmentation fault
        // ao tentar acessar os parametros da funcao
        void insereParametro(Entrada *p);
};

typedef vector<Entrada*> Escopo;

class TAD {
    private:
        int nivel;
        int nBuiltinTypes;
        vector<Escopo> tabela;
        vector<Entrada*> labelList;

    public:
        TAD();

        ~TAD();

        // ----- ESCOPO ------
        void insereEscopo();

        void removeEscopo();

        // ----- FUNCOES DE BUSCA -----
        Entrada* declarado(string &nome);

        Entrada* busca(string nome, bool *declarado);

        vector<Entrada> variaveis_escopo();

        // ----- INSERCOES NA TABELA -----
        Entrada* insere(string id, bool *declarado2, Entrada *entrada);

        Entrada* insereFuncao(string id, Entrada *tipo, int nparametros);

        Entrada* insereVariavel(string id, Entrada *tipo);

        Entrada* insereConstante(string id, Entrada *tipo, string valor);

        Entrada* insereParametro(string id, Entrada *tipo);

        Entrada* insereTipo(string id, Entrada *te);

        // ---------- LABELS ----------
        Entrada* insereLabel(string id, bool *declarado, Entrada *f);

        bool buscaLabel(string nome, Entrada *funcao);

        void labelLog();

        // ----- FUNCOES DE DEBUG -----
        void log();

        // FILTRO
        int filtro(int stack);
        int getEscopo();
        string buscaEndereco(int endereco);
};

#endif
