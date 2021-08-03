CC = gcc
FONTES = fontes/*.c
INCLUDES = includes
BIBLIOTECAS = -lm
BINARIO = simulador

all:
	@$(CC) $(FONTES) -o $(BINARIO) -I $(INCLUDES) $(BIBLIOTECAS) -O3 -march=native

run:
	@./$(BINARIO)
