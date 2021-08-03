#include <math.h>


unsigned int pega_pedaco(unsigned int bits, int mais_significativo, int menos_significativo) {
	unsigned int pedaco = pow(2, mais_significativo - menos_significativo + 1) - 1;
	pedaco &= bits >> menos_significativo;

	return pedaco;
}
