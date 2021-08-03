#ifndef FLAG_H
#define FLAG_H

#include <stdbool.h>
#include "operacao.h"

typedef struct RegistradorFlag {
    bool flags[TAMANHO_PALAVRA];
    bool load;
}
registrador_flags_t;

enum Flag {
    MAIOR,
    MENOR,
    IGUAL,
    ZERO,
    CARRY,
    OVERFLOW_ARITMETICO,
    DIVISAO_POR_ZERO,
    OVERFLOW_PILHA,
    UNDERFLOW_PILHA,
    NEGATIVO
};

registrador_flags_t cria_registrador_flags();
unsigned int flags_para_inteiro(bool flags[]);
void inteiro_para_flags(unsigned int inteiro, bool fr[]);

#endif // FLAG_H
