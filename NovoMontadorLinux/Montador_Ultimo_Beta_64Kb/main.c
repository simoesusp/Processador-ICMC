#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "defs.h"
#include "parser.h"
#include "structs.h"
#include "montador.h"

/* Versao do montador */
#define VERSAO "1.1"

/* Arquivos de entrada e saida */
FILE *in;
FILE *out;
char* OutputFileName;
char args;//bitmask das opcoes de montador utillizadas
//1=-o; 2=-v;

void print_help(char* s){
	printf("Uso basico: %s [nome do arquivo]\n",s);
	printf("opcoes:\n\t-o: nome do arquivo de saida, caso omitido equivale a dar o mesmo nome do arquivo trocando .asm por .mif\n");
	printf("\t-v: verbose, avisa de todos os labels que encontrar\n");
}

void CalculaOutputNome(char* s){
	    //input so tem arquivo de entrada. O nome do arquivo de saida eh igual ao de entrada trocando a extensao .asm (se tiver) por .mif, senao adicionando a extensao .mif
	    int l=strlen(s);

	    //string nao eh grande o suficiente para ter a extensao .asm
	    if(l<4){
		    OutputFileName=(char*)malloc((4+l+1)*sizeof(char));
		    strcpy(OutputFileName,s);
		    strcat(OutputFileName,".mif");
		    //coeficiente de cagaco, pra ter ctz q a string termina
		    OutputFileName[l]='\0';
	    }
	    //string tem a extensao .asm
	    else if(s[l-1]=='m' && s[l-2]=='s' && s[l-3]=='a' && s[l-4]=='.'){
		    OutputFileName=(char*)malloc((l+1)*sizeof(char));
		    strcpy(OutputFileName,s);
		    OutputFileName[l]='\0';
		    //trocando a extensao
		    OutputFileName[l-1]='f';
		    OutputFileName[l-2]='i';
		    OutputFileName[l-3]='m';
	    }
	    //string eh grande, mas n tem a extensao
	    else{
		    OutputFileName=(char*)malloc((l+4+1)*sizeof(char));
		    strcpy(OutputFileName,s);
		    strcat(OutputFileName,".mif");
		    OutputFileName[l]='\0';
	    }
}

int main(int argc, char *argv[])
{

    if (argc < 2){
        printf("Montador :\nUso 1: %s <arquivo texto de entrada> [<arquivo de saida>]\nUso 2: %s -h/--help\n",argv[0],argv[0]);
	return 1;
    }
    int l;
    parser_SetVerbose(0);
//processamento do input
    if(argc==2){
	    args=0;
	    if((strcmp(argv[1],"-h") ==0) || (strcmp(argv[1],"--help")==0) ){
		    print_help(argv[0]);
		    return 0;
	    }
	    CalculaOutputNome(argv[1]);
    }else{
	    int i=2;
	    OutputFileName=NULL;
	    args=0;
	    while(i<argc){
		    if(strcmp(argv[i],"-o")==0){
			    OutputFileName=argv[i+1];
			    i+=2;
			    args|=1;
		    }else if(strcmp(argv[i],"-v")==0){
			    args|=2;
			    parser_SetVerbose(1);
			    i++;
		    }
	    }
	    if(OutputFileName==NULL)
	    	CalculaOutputNome(argv[1]);
    }

    printf("Montador v.%s\n",VERSAO);
    
    calcula_tamanho();

    CarregaPrograma(argv[1]);

    out = fopen(OutputFileName,"w");

    if (out == NULL){
        parser_Abort("Impossivel criar arquivo para escrita!");
    }

    Montar();

    fclose(out);

    if(args&1){
	    free(OutputFileName);
    }

    return 0;

}
