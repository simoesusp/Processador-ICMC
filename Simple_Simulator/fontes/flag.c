#include <stdbool.h>
#include <math.h>

#include "operacao.h"
#include "flag.h"


registrador_flags_t cria_registrador_flags() {
    return (registrador_flags_t) {.flags = {false}, .load = false};
}

unsigned int flags_para_inteiro(bool flags[]) {
    unsigned int inteiro = 0;

    for (int i = TAMANHO_PALAVRA - 1; i >= 0; i--) {
        inteiro += (unsigned int)flags[i] * pow(2, i);
    }

    return inteiro;
}

void inteiro_para_flags(unsigned int inteiro, bool flags[]) {
    for (int i = TAMANHO_PALAVRA - 1; i >= 0; i--) {
        flags[i] = pega_pedaco(inteiro, i, i);
    }
}
