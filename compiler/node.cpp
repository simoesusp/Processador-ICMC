#include "node.hpp"

Entrada::Entrada(string &nome, identificador id) {
    this->nome = nome;
    this->id = id;
    this->tipo = NULL;
    this->endereco = -1;
    this->nbytes = -1;
    this->tipo_elementar = NULL;
    this->valor = "NULL";
    this->funcao = NULL;
    this->ponteiro = 0;
}

void Entrada::insereParametro(Entrada *p) {
    this->parametros.push_back(*p);
}


TAD::TAD() {
    nivel = 0;
    Escopo global;
    tabela.push_back(global);

    insereTipo("int", NULL);
    insereTipo("char", NULL);
    insereTipo("void", NULL);

    nBuiltinTypes = tabela[0].size();
}

TAD::~TAD() {
    // deleta a tabela de simbolos
    for(int i = 0; i < tabela.size(); i++)
        for(int j = 0; j < tabela[i].size(); j++)
            delete tabela[i][j];

    // deleta a tabela de labels
    for(int i = 0; i < labelList.size(); i++)
        delete labelList[i];
}

// ----- ESCOPO ------
void TAD::insereEscopo() {
    nivel++;
    Escopo novoNivel;
    tabela.push_back(novoNivel);
}

void TAD::removeEscopo() {
    if(tabela.size() > nivel) {
        for(int i = 0; i < tabela[nivel].size(); i++)
            delete(tabela[nivel][i]);
        tabela.erase(tabela.begin() + nivel);
        nivel--;
    }
    else
        std::cout << "Nao existe o escopo de nivel " << nivel << " para deletar" << std::endl;
}

// ----- FUNCOES DE BUSCA -----
Entrada* TAD::declarado(string &nome) {
    int size = tabela[nivel].size();
    for(int i = 0; i < size; i++) {
        if(tabela[nivel][i]->nome.compare(nome) == 0)
            return tabela[nivel][i];
    }
    return NULL;
}

Entrada* TAD::busca(string nome, bool *declarado) {
    for(int i = nivel; i >= 0; i--)
        for(int j = 0; j < tabela[i].size(); j++)
            if(tabela[i][j]->nome.compare(nome) == 0) {
                *declarado = true;
                //std::cout << "identificador " << id << " ja exite no nivel: " << i << std::endl;
                return tabela[i][j];
            }
    *declarado = false;
    return NULL;
}

vector<Entrada> TAD::variaveis_escopo() {
    vector<Entrada> lista;
    for(int i = 0; i < tabela[nivel].size(); i++) {
        if(tabela[nivel][i]->id == variavel || tabela[nivel][i]->id == parametro)
            lista.push_back(*tabela[nivel][i]);
    }
    return lista;
}

// ----- INSERCOES NA TABELA -----
Entrada* TAD::insere(string id, bool *declarado2, Entrada *entrada) {
    Entrada *ref = declarado(id);

    if(ref != NULL) {
        *declarado2 = true;
        delete(entrada);
        cout << "Erro o identificador: " << id << " ja foi declarado no escopo " << nivel << endl;
        return ref;
    }
    *declarado2 = false;
    tabela[nivel].push_back(entrada);
    return entrada;
}

Entrada* TAD::insereFuncao(string id, Entrada *tipo, int nparametros) {
    bool declarado;
    Entrada *e = new Entrada(id, funcao);
    e->tipo = tipo;
    return insere(id, &declarado, e);
}

Entrada* TAD::insereVariavel(string id, Entrada *tipo) {
    bool declarado;
    Entrada *e = new Entrada(id, variavel);
    e->tipo = tipo;
    return insere(id, &declarado, e);
}

Entrada* TAD::insereConstante(string id, Entrada *tipo, string valor) {
    bool declarado;
    Entrada *e = new Entrada(id, constante);
    e->tipo = tipo;
    e->valor = valor;
    return insere(id, &declarado, e);
}

Entrada* TAD::insereParametro(string id, Entrada *tipo) {
    bool declarado;
    Entrada *e = new Entrada(id, parametro);
    e->tipo = tipo;
    return insere(id, &declarado, e);
}

Entrada* TAD::insereTipo(string id, Entrada *te) {
    bool declarado;
    Entrada *e = new Entrada(id, tipo);

    // acha o tipo elementar de te, e faz o novo tipo ter o mesmo tipo elementar
    if(te != NULL) {
        Entrada *a, *p;
        a = te;
        p = te->tipo_elementar;
        while(p != NULL) {
            a = p;
            p = p->tipo_elementar;
        }
        e->tipo_elementar = a;
    }
    else
        e->tipo_elementar = NULL;
    return insere(id, &declarado, e);
}

// ---------- LABELS ----------
Entrada* TAD::insereLabel(string id, bool *declarado, Entrada *f) {
    if(f == NULL)
        return NULL;

    if(f->id != funcao) {
        cout << "insercao de label falhou. o paramentro funcao nao eh do tipo funcao" << endl;
        cout << "mas eh do tipo: " << f->id << endl;
        return NULL;
    }

    *declarado = buscaLabel(id, f);

    if(*declarado == true) {
        cout << "ERRO - label: " << id << " na funcao: " << f->nome << " ja existe" << endl;
        return NULL;
    }

    Entrada *e = new Entrada(id, label);
    e->funcao = f;
    labelList.push_back(e);
    return e;
}

bool TAD::buscaLabel(string nome, Entrada *funcao) {
    for(int i = 0; i < labelList.size(); i++) {
        if(labelList[i]->nome.compare(nome) == 0 && labelList[i]->funcao == funcao)
        return true;
    }
    return false;
}

void TAD::labelLog() {
    cout << "----- Lista de Labels -----" << endl;
    for(int i = 0; i < labelList.size(); i++)
        cout << "[" << i << "] " << labelList[i]->nome << " escopo: " << labelList[i]->funcao->nome << endl;
}

// ----- FUNCOES DE DEBUG -----
void TAD::log() {
    cout << "----- TABELA DE SIMBOLOS -----" << endl;
    for(int i = tabela.size()-1; i >= 0; i--) {
        cout << "Nivel: " << i << endl;
        for(int j = tabela[i].size()-1; j >= 0; j--) {
            string id;
            Entrada *e = tabela[i][j];
            switch(e->id) {
                case funcao:        id = "funcao";          break;
                case label:         id = "label";           break;
                case constante:     id = "constante";       break;
                case tipo:          id = "tipo";            break;
                case variavel:      id = "variavel";        break;
                case parametro:     id = "parametro";       break;
            }
            cout << "Nome: " << e->nome << "	id: " << id;
            if(e->tipo != NULL)
                cout << "	Tipo: " << e->tipo->nome;

            if(e->endereco != -1)
                cout << "	Endereco " << e->endereco;

            if(e->nbytes != -1)
                cout << "	nbytes " << e->nbytes;

            if(e->tipo_elementar != NULL)
                cout << "	tipo_elementar: " << e->tipo_elementar->nome;

            if(e->id == constante)
                cout << "	valor: " << e->valor;

            if(e->parametros.size() > 0) {
                cout << "	nparametros: " << e->parametros.size() << " -> ";
                for(int i = 0; i < e->parametros.size(); i++)
                    cout << e->parametros[i].tipo->nome << " " << e->parametros[i].nome << ", ";
            }
            cout << endl;
        }
    }
    cout << "----- END TABELA DE SIMBOLOS -----" << endl;
}





// FILTRO
int TAD::filtro(int stack) {
    int offset = stack;
    for(int i = nBuiltinTypes; i < tabela[0].size(); i++) {
        if(tabela[0][i]->id == variavel) {
            tabela[0][i]->endereco = offset;
            offset -= tabela[0][i]->nbytes;
        }
        else {
            tabela[0].erase(tabela[0].begin() + i);
            i--;
        }
    }
    return offset;
}

int TAD::getEscopo() {
    return nivel;
}


string TAD::buscaEndereco(int endereco) {
    for(int i = 0; i < tabela[nivel].size(); i++) {
        if(tabela[nivel][i]->endereco == endereco) {
            return tabela[nivel][i]->nome;
        }
    }

    for(int i = nBuiltinTypes; i < tabela[0].size(); i++) {
        if(tabela[0][i]->endereco == endereco) {
            return tabela[0][i]->nome;
        }
    }

    return "endereco temporario";
}

