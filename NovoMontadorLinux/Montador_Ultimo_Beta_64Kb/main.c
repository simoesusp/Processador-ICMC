#include <stdio.h>
#include <stdlib.h>
#include "defs.h"
#include "parser.h"
#include "structs.h"
#include "montador.h"

/* Versao do montador */
#define VERSAO "0.0"

/* Arquivos de entrada e saida */
FILE *in;
FILE *out;

int main(int argc, char *argv[])
{

    if (argc < 3)
    {
        printf("Montador :\nUso : %s <arquivo texto de entrada> <arquivo .mif de saida>\n",argv[0]);
#ifndef __linux__
        system("pause");
#endif
        exit(1);
    }

    printf("Montador v.%s\n",VERSAO);

    CarregaPrograma(argv[1]);

    out = fopen(argv[2],"w");

    if (out == NULL)
    {
        parser_Abort("Impossivel criar arquivo para escrita!");
    }

    Montar();

    fclose(out);

    return 0;

}
