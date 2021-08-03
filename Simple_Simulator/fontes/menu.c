#include <stdio.h>
#include <ctype.h>

#include "menu.h"


void imprime_cabecalho() {
    puts("----------------------");
    puts("   Processador ICMC   ");
    puts("----------------------");
    putchar('\n');
}

void imprime_opcoes() {
    puts("Escolha uma opcao:");
    printf("[%c] Reinicar\n", REINICAR);
    printf("[%c] Sair\n", SAIR);
}

char le_opcao() {
    char opcao;
    
    do {
        fputs("> ", stdout);
        opcao = toupper(getchar());
        
        // Elimina o \n
        getchar();
    }
    while(opcao != REINICAR && opcao != SAIR);

    putchar('\n');
    return opcao;
}
