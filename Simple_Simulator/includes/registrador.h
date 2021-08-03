#ifndef REGISTRADOR_H
#define REGISTRADOR_H

#include <stdbool.h>

#define NUMERO_REGISTRADORES 8

typedef struct Registrador {
    unsigned int valor;
    bool incrementa;
    bool decrementa;
    bool load;
}
registrador_t;

registrador_t cria_registrador();
void cria_registradores(registrador_t registradores[]);
void reseta_sinais_registrador(registrador_t *registrador);
void atualiza_registrador(registrador_t *registrador, unsigned int valor_load);

#endif // REGISTRADOR_H
