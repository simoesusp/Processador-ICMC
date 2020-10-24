# Flags do OpenGL
FLAGS = -lGL -lGLU -lglfw -lGLEW 
# Flags do Curses
FLAGS += -lcurses
# Flags de otimização
FLAGS += -O3 -march=native
# Outras flags
FLAGS += -Wall -lm

HEADERS = simple.h headers.h
OBJECTS = program.o

all: architecture_opengl.o simulator_curses.o utils.o
	gcc -g -o simple_simulator simple_simulator.c architecture_opengl.o simulator_curses.o utils.o $(FLAGS) 

architecture_opengl.o : architecture_opengl.c
	gcc -c architecture_opengl.c $(FLAGS)

simulator_curses.o : simulator_curses.c
	gcc -c simulator_curses.c $(FLAGS)

utils.o : utils.c
	gcc -c utils.c $(FLAGS)

clean:
	rm *.o
	rm simple_simulator

run: all
	./simple_simulator
	stty sane
