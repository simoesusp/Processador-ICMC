#include "mux.h"


void cria_mux(mux_t mux[]) {
    for (int i = 0; i < NUMERO_MUX; i++) {
        mux[i].valor = 0;
        mux[i].selecao = 0;
    }
}
