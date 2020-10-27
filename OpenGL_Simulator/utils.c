//---------------------------------------------------
// Utils
// By: Breno Cunha Queiroz and Maria Eduarda Kawakami
// Date: 12/06/20
//---------------------------------------------------
#include "utils.h"

int pega_pedaco(int ir, int a, int b){
	int pedaco=0;

	// Separa somente o pedaco de interesse;

	/* Essa operação retira o numero do registrador entre o a-b bit
	   da instrução, realizando um right-shift de b posições
	   e aplicando uma máscara de n-bits, onde n = nr. 1's entre a e b
	   Obs.:    & - AND
	   >> - right-shift

	   ex.: Rx = 0x0007 & IR >> 7;
	   */
	pedaco = ((pow(2,(a-b+1)))-1);
	pedaco = pedaco & ir >> b;

	return pedaco;
}

