# SimuladorMIPS
REA (Recurso Educacional Aberto) para a disciplina de Organização e Arquitetura de Computadores.

O trabalho foi desenvolvido como um complemento para o projeto Processador-ICMC - https://github.com/simoesusp/Processador-ICMC, criado pelo professor Eduardo Simões, a fim de ensinar e aprender Organização e Arquitetura de Computadores.

O principal objetivo é adicionar uma ferramenta de visualização ao ambiente e facilitar o aprendizado dos alunos, familiarizando-os com o processador desenvolvido.
 
Desenvolvemos um simulador do processador que executa o código os códigos montados e mostra o estado atual do processador e os caminhos ativos em cada ciclo. A arquitetura e seus caminhos são mostrados através de uma janela do OpenGL. As linhas de instruções, os valores dos registradores, e a saída de vídeo são apresentados através de uma interface de terminal desenvolvida com curses.

Vídeo do simulador funcionando: https://youtu.be/eYd-wCxaJ6Q

<p align="center">
<img src="./img/curses.png" height="500">
<img src="./img/openGL.png" height="500">
</p>

Tentamos manter a distribuição dos componentes fiel a que o professor Eduardo Simões utiliza na imagem de apresentação da arquitetura para os alunos.
<p align="center">
 <img src="./img/arqSimoes.png" height="500">
 </p>

Atualmente a visualização está funcionando como descrito, porém, a velocidade do simulador ainda precisa ser melhorada, visto que a execução dos jogos está bem mais lenta do que o encontrado na FPGA e no atual simulador da disciplina. Acreditamos que isto está relacionado com a taxa de atualização da janela do OpenGL e do curses. Outro ponto a ser melhorado é a apresentação da arquitetura, que está $hardcoded$, o ideal seria que esta fosse variável de acordo com o código do simulador, de forma a permitir analisar outras arquiteturas construídas pelos alunos.

Agradecimentos ao Professor Eduardo Simões <3 https://github.com/simoesusp

## Instalação

### Dependências
Ubuntu e derivados: `sudo apt update && sudo apt install libglfw3-dev libglew-dev libncurses5-dev libncursesw5-dev`
Arch e derivados: `sudo pacman -Sy ncurses glew glfw-x11`

### Clone o repositório
Você pode usar HTTPS: `git clone https://github.com/simoesusp/Processador-ICMC.git`
Ou SSH: `git@github.com:simoesusp/Processador-ICMC.git`

### Compilar
Vá para o diretório do simulador: `cd Processador-ICMC/OpenGL_Simulator`
E compile: `make`

### Usagem
Basta executar o binário (`./simple-simulator`)

Você pode especificar qual `.mif` utilizar usando argumento, por exemplo:
`./simple-simulator Nave11.mif`

Caso omitido, assumirá que você tem uma chamada `cpuram.mif` no diretório atual.

## Desenvolvido por

Breno Cunha Queiroz https://github.com/Brenocq

Maria Eduarda Kawakami Moreira
