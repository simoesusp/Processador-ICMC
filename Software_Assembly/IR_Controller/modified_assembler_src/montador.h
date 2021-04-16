#ifndef _MONTADOR_
#define _MONTADOR_

#define LABEL_CODE 	100
#define EQU_CODE 	101

/* Pseudo-instrucoes (op code 'interno') */
#define VAR_CODE	102
#define STATIC_CODE 	103
#define STRING_CODE 	104
#define ALLOC_CODE	105

/* Pseudo-instrucoes (strings) */
#define EQU_STR		"EQU"
#define VAR_STR 	"VAR"
#define STATIC_STR 	"STATIC"
#define STRING_STR 	"STRING"
#define ALLOC_STR	"ALLOC"

void Montar(void);

#endif
