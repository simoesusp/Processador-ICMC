Autor: Marcel Koti Lamada
email: marcelokkamada@gmail.com

1. Compilando o compilador:

    Para compilar, é necessário primeiro instalar algumas dependências:
        "sudo apt install bison flex g++"

    Depois de instalar as dependências, execute "make"
    
    O comando "make" irá compilar o código do compilador e salvar no arquivo "parser"
    
2. O que o compilador nao suporta:
    alocacao dinamica
    includes
    tipos de dados alem de int e char
    structs e unions
    typedefs
    arrays com tres ou mais dimensoes
    switch
    
3. Para testar:    
    operadores de comparacao que contenham igual (ex: >=)
    funcoes com return void, mas com return dentro da funcao
    
4. Bugs:
    no exemplo do Pacman:
        a animacao dele movendo para a direita nao aparece
        algumas vezes ele atravessa a parede
    
5. Features para serem adicionadas:
    permitir codigo assembly dentro do .c
    switch
