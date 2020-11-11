all: simulador
	make simulador

run: simulador
	./simulador

clean:
	rm simulator

simulador:
	gcc simple_simulator.c -O3 -march=native -o simulador -Wall -lm -lcurses
