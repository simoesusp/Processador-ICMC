#ifndef OPERACAO_H
#define OPERACAO_H

#define TAMANHO_PALAVRA 16

typedef enum Operacao {
    // Controle
    NOP    = 0,  // 000000
    SETC   = 8,  // 001000
    BREAKP = 14, // 001110
    HALT   = 15, // 001111

    // Fluxo
    JMP  = 2, // 000010
    CALL = 3, // 000011
    RTS  = 4, // 000100

    // Pilha
    PUSH = 5, // 000101
    POP  = 6, // 000110

    // Lógicas
    SHIFT = 16, // 010000
    AND   = 18, // 010010
    OR    = 19, // 010011
    XOR   = 20, // 010100
    NOT   = 21, // 010101
    CMP   = 22, // 010110

    // Aritméticas
    ADD  = 32, // 100000
    SUB  = 33, // 100001
    MULT = 34, // 100010
    DIV  = 35, // 100011
    INC  = 36, // 100100
    MOD  = 37, // 100101

    // Manipulação de Dados
    LOAD   = 48, // 110000
    STORE  = 49, // 110001
    LOADN  = 56, // 111000
    LOADI  = 60, // 111100
    STOREI = 61, // 111101
    MOV    = 51, // 110011

    // Entrada e Saída
    OUTCHAR = 50, // 110010
    INCHAR  = 53  // 110101
}
operacao_t;

typedef enum Jump {
    JUMP,
    JEQ,
    JNE,
    JZ,
    JNZ,
    JC,
    JNC,
    JGR,
    JLE,
    JEG,
    JEL,
    JOV,
    JNOV,
    JN,
    JDZ
}
jump_t;

unsigned int pega_pedaco(unsigned int bits, int mais_significativo, int menos_significativo);

#endif // OPERACAO_H
