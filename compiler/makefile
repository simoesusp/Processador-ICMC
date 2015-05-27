all: parser

clean:
	rm parser.cpp parser.hpp parser tokens.cpp parser.output

# opcao -d gera o .h parser.hpp
# opcao -o gera o parser.cpp
# opcao -v gera o parser.output
parser.cpp: parser.y
	bison -v -d -o $@ $^

parser.hpp: parser.cpp node.hpp

tokens.cpp: tokens.l parser.hpp
	flex -o $@ $^

parser: parser.cpp tokens.cpp node.cpp parser.y
	g++ -o $@ parser.cpp tokens.cpp node.cpp -lfl
