#include <stdbool.h>
#include <stdlib.h>
#include <limits.h>
#include <stdio.h>

#include "operacao.h"
#include "memoria.h"


enum _Letra {
    ANTERIOR,
    ATUAL
};


static const unsigned int _NUMERO_INVALIDO = UINT_MAX;
static const char _NOME_ARQUIVO_MEMORIA[] = "cpuram.mif";
static const int _TAMANHO_MAXIMO_LINHA = 110;


static unsigned int _processa_linha(const char* linha);


void le_arquivo_memoria(unsigned int memoria[]) {
	FILE *arquivo_memoria = fopen(_NOME_ARQUIVO_MEMORIA, "r");
	if (arquivo_memoria == NULL) {
		fprintf(stderr, "Erro na abertura do arquivo %s\n", _NOME_ARQUIVO_MEMORIA);
		exit(EXIT_FAILURE);
	}

	bool processando = false;
	char linha[_TAMANHO_MAXIMO_LINHA];

	while (fscanf(arquivo_memoria, "%s", linha) != EOF) {
		char letras[2] = {'0', '0'};
        int indice_memoria;

		// Lê o cabeçalho
		if (!processando) {
			int i = 0;

			do {
				letras[ANTERIOR] = letras[ATUAL];
				letras[ATUAL] = linha[i];

				// Começa a processar ao encontrar "0:"
				if (letras[ANTERIOR] == '0' && letras[ATUAL] == ':') {
					processando = true;
					indice_memoria = 0;
				}
			}
            while (linha[++i] != '\0');
		}

		// Processa a linha e salva na memória
		if (processando && indice_memoria < TAMANHO_MEMORIA) {
			memoria[indice_memoria] = _processa_linha(linha);

			if (memoria[indice_memoria] == _NUMERO_INVALIDO) {
				fprintf(stderr, "Linha %d invalida: %s\n", indice_memoria, linha);
                exit(EXIT_FAILURE);
			}

			indice_memoria++;
		}
	}

	fclose(arquivo_memoria);
}


static unsigned int _caracter_para_digito(char caracter) {
    return (unsigned int)caracter - '0';
}

// Processa a linha e retorna o número codificado
static unsigned int _processa_linha(const char* linha) {
    int inicio_numero;
    for (inicio_numero = 0; linha[inicio_numero] != ':'; inicio_numero++) {
        if (linha[inicio_numero] == '\0') {
            return _NUMERO_INVALIDO;
        }
    }

    unsigned int numero = 0;
    for (int i = 1; i <= TAMANHO_PALAVRA; i++) {
        numero <<= 1;
        numero += _caracter_para_digito(linha[inicio_numero + i]);
    }

	return numero;
}
