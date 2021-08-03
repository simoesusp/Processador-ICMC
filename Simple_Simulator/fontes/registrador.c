#include <stdbool.h>

#include "registrador.h"

registrador_t cria_registrador() {
    return (registrador_t) {.valor = 0, .incrementa = false, .decrementa = false, .load = false};
}

void cria_registradores(registrador_t registradores[]) {
    for (int i = 0; i < NUMERO_REGISTRADORES; i++) {
        registradores[i] = cria_registrador();
    }
}

void reseta_sinais_registrador(registrador_t *registrador) {
    registrador->incrementa = false;
    registrador->decrementa = false;
    registrador->load = false;
}

void atualiza_registrador(registrador_t *registrador, unsigned int valor_load) {
    if (registrador->load) {
        registrador->valor = valor_load;
    }
    if (registrador->incrementa) {
        (registrador->valor)++;
    }
    if (registrador->decrementa) {
        (registrador->valor)--;
    }
}
