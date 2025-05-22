#makefile do montador
COMPILER = gcc
FILES =  montador.c parser.c structs.c
OBJS = $(FILES:.c=.o)
NAME_FLAG = -o
LINK_FLAG = -g
COMP_FLAGS = -march=native -O3 -g
NAME = montador

all: main.o $(OBJS)
	$(COMPILER) $^ $(LINK_FLAG) $(NAME_FLAG) $(NAME)

%.o: %.c %.h defs.h
	$(COMPILER) -c $< $(COMP_FLAGS) $(NAME_FLAG) $@

main.o: main.c $(wildcard *.h)
	$(COMPILER) -c $< $(COMP_FLAGS) $(NAME_FLAG) $@

clear:
	rm *.o
	rm $(NAME)

install:
	cp $(NAME) /bin
