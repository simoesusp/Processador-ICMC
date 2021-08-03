#ifndef MUX_H
#define MUX_H

#define NUMERO_MUX 6

typedef struct Mux {
    unsigned int valor;
    int selecao;
}
mux_t;

enum Nome {
    M1,
    M2,
    M3,
    M4,
    M5,
    M6
};

enum Selecao {
    // Mux 1
    PC    = 0,
    MAR   = 1,
    MUX_4 = 2,
    SP    = 3,

    // Mux 2
    ULA     = 0,
    MEMORIA = 1,
    TECLADO = 4,

    // Mux 3
    FR = 8,

    // Mux 4
    UM = 8,

    // Mux 5
    MUX_3 = 1
};

void cria_mux(mux_t mux[]);

#endif // MUX_H
