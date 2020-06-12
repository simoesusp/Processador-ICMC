# Flag de debug
FLAGS = -g 
# Flags do OpenGL
FLAGS += -lGL -lGLU -lglfw -lGLEW 
# Flags de otimização
FLAGS += -O3 -march=native
# Outras flags
FLAGS += -Wall -lm

all:
	gcc -g -o simple_simulator *.c $(FLAGS) 
clear:
	rm simple_simulator
run: all
	./simple_simulator
