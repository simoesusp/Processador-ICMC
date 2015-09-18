#ifndef _STRUCTS_
#define _STRUCTS_

/* No. maximo de Labels */
#define MAX_LABELS 5000

/* Tamanho maximo da string de um Label */
#define LABEL_MAX_SIZE 200

/* Label */
typedef struct
{
    unsigned short End;
    char Nome[LABEL_MAX_SIZE + 1];
} Label;

void AddLabel(char *, unsigned short);
unsigned short FindLabel(char *);

#endif
