#ifndef CPU_H
#define CPU_H

#include "registrador.h"
#include "flag.h"
#include "mux.h"

typedef enum Estado {
    RESETA,
    BUSCA,
    DECODIFICA,
    EXECUTA_1,
    EXECUTA_2,
    ESPERA
}
estado_t;

typedef struct Cpu {
    registrador_t registradores[NUMERO_REGISTRADORES];
    registrador_t pc, ir, sp, mar;
    registrador_flags_t fr;
    mux_t mux[NUMERO_MUX];
    estado_t estado;
}
cpu_t;

cpu_t cria_cpu();
void reseta_sinais_registradores(cpu_t *cpu);
void atualiza_registradores(cpu_t *cpu, unsigned int valor_memoria);
void atualiza_mux_1(cpu_t *cpu);
void atualiza_mux_2(cpu_t *cpu, unsigned int valor_ula, unsigned int valor_memoria, char tecla);
void atualiza_mux_3(cpu_t *cpu);
void atualiza_mux_4(cpu_t *cpu);
void atualiza_mux_5(cpu_t *cpu);
void atualiza_mux_6(cpu_t *cpu, unsigned int fr, unsigned int valor_memoria);

#endif // CPU_H
