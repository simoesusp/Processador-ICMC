#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include "registrador.h"
#include "operacao.h"
#include "memoria.h"
#include "flag.h"
#include "cpu.h"
#include "mux.h"


cpu_t cria_cpu() {
    cpu_t cpu;

    cria_registradores(cpu.registradores);
    cpu.pc = cria_registrador();
    cpu.ir = cria_registrador();
    cpu.mar = cria_registrador();

    cpu.sp = cria_registrador();
    cpu.sp.valor = TAMANHO_MEMORIA - 1;

    cpu.fr = cria_registrador_flags();

    cria_mux(cpu.mux);
    cpu.mux[M1].selecao = PC;
    cpu.mux[M2].selecao = MEMORIA;
    cpu.mux[M5].selecao = MUX_3;
    cpu.mux[M6].selecao = FR;

    cpu.estado = BUSCA;

    return cpu;
}


void reseta_sinais_registradores(cpu_t *cpu) {
    for(int i = 0; i < NUMERO_REGISTRADORES; i++) {
		reseta_sinais_registrador(&cpu->registradores[i]);
	}

    reseta_sinais_registrador(&cpu->pc);
    reseta_sinais_registrador(&cpu->ir);
    reseta_sinais_registrador(&cpu->sp);
    reseta_sinais_registrador(&cpu->mar);

	cpu->fr.load = false;
}

void atualiza_registradores(cpu_t *cpu, unsigned int valor_memoria) {
    atualiza_registrador(&cpu->pc, valor_memoria);
    atualiza_registrador(&cpu->ir, valor_memoria);
    atualiza_registrador(&cpu->mar, valor_memoria);

    atualiza_registrador(&cpu->sp, cpu->mux[M4].valor);

    unsigned int rx = pega_pedaco(cpu->ir.valor, 9, 7);
    atualiza_registrador(&cpu->registradores[rx], cpu->mux[M2].valor);

    if (cpu->fr.load) {
        inteiro_para_flags(cpu->mux[M6].valor, cpu->fr.flags);
    }
}


void atualiza_mux_1(cpu_t *cpu) {
    if (cpu->mux[M1].selecao == PC) {
        cpu->mux[M1].valor = cpu->pc.valor;
    }
	else if (cpu->mux[M1].selecao == MAR) {
        cpu->mux[M1].valor = cpu->mar.valor;
    }
	else if (cpu->mux[M1].selecao == MUX_4) {
        cpu->mux[M1].valor = cpu->mux[M4].valor;
    }
	else if (cpu->mux[M1].selecao == SP) {
        cpu->mux[M1].valor = cpu->sp.valor;
    }

	if(cpu->mux[M1].valor > TAMANHO_MEMORIA) {
		fprintf(stderr, "Erro, %u ultrapassa o limite de memoria\n", cpu->mux[M1].valor);
		exit(EXIT_FAILURE);
	}
}

void atualiza_mux_2(cpu_t *cpu, unsigned int valor_ula, unsigned int valor_memoria, char tecla) {
    if (cpu->mux[M2].selecao == ULA) {
        cpu->mux[M2].valor = valor_ula;
    }
	else if (cpu->mux[M2].selecao == MEMORIA) {
        cpu->mux[M2].valor = valor_memoria;
    }
	else if (cpu->mux[M2].selecao == MUX_4) {
        cpu->mux[M2].valor = cpu->mux[M4].valor;
    }
	else if (cpu->mux[M2].selecao == SP) {
        cpu->mux[M2].valor = cpu->sp.valor;
    }
	else if (cpu->mux[M2].selecao == TECLADO) {
        cpu->mux[M2].valor = tecla;
    }
}

void atualiza_mux_3(cpu_t *cpu) {
    if(cpu->mux[M3].selecao == FR) {
        cpu->mux[M3].valor = flags_para_inteiro(cpu->fr.flags);
    }
	else {
        cpu->mux[M3].valor = cpu->registradores[cpu->mux[M3].selecao].valor;
    }
}

void atualiza_mux_4(cpu_t *cpu) {
    if (cpu->mux[M4].selecao == UM) {
        cpu->mux[M4].valor = 1;
    }
    else {
        cpu->mux[M4].valor = cpu->registradores[cpu->mux[M4].selecao].valor;
    }
}

void atualiza_mux_5(cpu_t *cpu) {
    if (cpu->mux[M5].selecao == PC) {
        cpu->mux[M5].valor = cpu->pc.valor;
    }
	else if (cpu->mux[M5].selecao == MUX_3) {
        cpu->mux[M5].valor = cpu->mux[M3].valor;
    }
}

void atualiza_mux_6(cpu_t *cpu, unsigned int fr, unsigned int valor_memoria) {
    if (cpu->mux[M6].selecao == FR) {
        cpu->mux[M6].valor = fr;
    }
	else if (cpu->mux[M6].selecao == MEMORIA) {
        cpu->mux[M6].valor = valor_memoria;
    }
}
