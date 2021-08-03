#include <stdbool.h>

#include "operacao.h"
#include "flag.h"
#include "ula.h"


enum _Tipo {
    ARITMETICA = 1,
    LOGICA
};

enum _Shift {
    SHIFTL0,
    SHIFTL1,
    SHIFTR0,
    SHIFTR1,
    ROTL = 2,
    ROTR,
};


static unsigned int _VALOR_MAXIMO = 0xffff;


static resultado_ula_t _operacao_aritmetica(unsigned int x, unsigned int y, int carry, bool tem_carry, operacao_t operacao);
static resultado_ula_t _operacao_logica(unsigned int x, unsigned int y, operacao_t operacao);
static unsigned int _rotaciona_esquerda(unsigned int bits, int shift);
static unsigned int _rotaciona_direita(unsigned int bits, int shift);


resultado_ula_t ula(unsigned int x, unsigned int y, int carry, bool tem_carry, operacao_t operacao) {
	switch(pega_pedaco(operacao, 5, 4)) {
        case ARITMETICA:
            return _operacao_aritmetica(x, y, carry, tem_carry, operacao);
        
        case LOGICA:
            return _operacao_logica(x, y, operacao);
	}

    return (resultado_ula_t) {.valor = 0, .fr = 0};
}

unsigned int shift(unsigned int bits, unsigned int ir) {
    unsigned int _shift = pega_pedaco(ir, 3, 0);

    switch(pega_pedaco(ir, 6, 4)) {
        case SHIFTL0: 
            return bits << _shift;
        
        case SHIFTL1:
            return ~(~(bits) << _shift);
        
        case SHIFTR0:
            return bits >> _shift;
        
        case SHIFTR1:
            return ~(~(bits) >> _shift);
    }

    if(pega_pedaco(ir, 6, 5) == ROTL) {
        return _rotaciona_esquerda(bits, _shift);
    }

    return _rotaciona_direita(bits, _shift);
}


static resultado_ula_t _operacao_aritmetica(unsigned int x, unsigned int y, int carry, bool tem_carry, operacao_t operacao) {
    unsigned int valor;
    bool fr[TAMANHO_PALAVRA] = {false};

    switch(operacao) {
        case ADD:
            valor = tem_carry ? x + y + carry : x + y;
            if (valor > _VALOR_MAXIMO) {
                fr[CARRY] = true;
                valor -= _VALOR_MAXIMO;
            }
            else {
                fr[CARRY] = false;
            }
            break;
        
        case SUB:
            valor = x - y;
            fr[NEGATIVO] = valor < 0;
            break;
        
        case MULT:
            valor = x * y;
            fr[OVERFLOW_ARITMETICO] = valor > _VALOR_MAXIMO;
            break;
        
        case DIV:
            if (y == 0) {
                valor = 0;
                fr[DIVISAO_POR_ZERO] = true;
            }
            else {
                valor = x / y;
                fr[DIVISAO_POR_ZERO] = false;
            }
            break;
        
        case MOD:
            if (y == 0) {
                valor = 0;
                fr[DIVISAO_POR_ZERO] = true;
            }
            else {
                valor = x % y;
                fr[DIVISAO_POR_ZERO] = false;
            }
            break;
        
        default:
            valor = x;
    }

    fr[ZERO] = valor == 0;

    return (resultado_ula_t) {.valor = valor, .fr = flags_para_inteiro(fr)};
}

static resultado_ula_t _operacao_logica(unsigned int x, unsigned int y, operacao_t operacao) {
    unsigned int valor;
    bool fr[TAMANHO_PALAVRA] = {false};

    if(operacao == CMP) {
        valor = x;
        fr[IGUAL] = x == y;
        fr[MENOR] = x < y;
        fr[MAIOR] = x > y;
    }
    else {
        switch(operacao) {
            case AND:
                valor = x & y;
                break;
            
            case XOR:
                valor = x ^ y;
                break;
            
            case OR:
                valor = x | y;
                break;
            
            case NOT:
                valor = ~x & _VALOR_MAXIMO;
                break;
            
            default:
                valor = x;
        }

        fr[ZERO] = valor == 0;
    }

    return (resultado_ula_t) {.valor = valor, .fr = flags_para_inteiro(fr)};
}

static unsigned int _rotaciona_esquerda(unsigned int bits, int shift) {
	if ((shift &= TAMANHO_PALAVRA * 8 - 1) == 0) {
		return bits;
    }
    
	return (bits << shift) | (bits >> (TAMANHO_PALAVRA * 8 - shift));
}

static unsigned int _rotaciona_direita(unsigned int bits, int shift) {
	if ((shift &= TAMANHO_PALAVRA * 8 - 1) == 0) {
		return bits;
    }
    
	return (bits >> shift) | (bits << (TAMANHO_PALAVRA * 8 - shift));
}
