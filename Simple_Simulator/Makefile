FLAGS = -O3 -march=native -Wall -lm -lcurses

all: simulador

simulador: simple_simulator.o
	gcc -o simulador simple_simulator.o $(FLAGS)

simple_simulator.o:
	gcc simple_simulator.c $(FLAGS)

clean:
	rm *.o
	rm simulador

run: simulador
	./simulador
