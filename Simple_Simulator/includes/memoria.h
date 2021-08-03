#ifndef ARQUIVO_H
#define ARQUIVO_H

#define TAMANHO_MEMORIA 32768 // 32 KB

typedef enum Acesso {
    LEITURA,
    ESCRITA
}
acesso_t;

void le_arquivo_memoria(unsigned int memoria[]);

#endif // ARQUIVO_H
