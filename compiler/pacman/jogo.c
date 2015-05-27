// por enquanto nao temos includes

/*
; ------- TABELA DE CORES -------
; adicione ao caracter para adicionar a cor correspondente

; 0 branco							0000
; 255 marrom						0001
; 512 verde							0010
; 768 oliva							0011
; 1024 azul marinho			        0100
; 1280 roxo							0101
; 1537 teal							0110
; 1793 prata						0111
; 2048 cinza						1000
; 2304 vermelho					    1001
; 2561 lima							1010
; 2816 amarelo					    1011
; 3072 azul							1100
; 3328 rosa							1101
; 3584 aqua							1110
; 3839 preto						1111
*/

// como nao tem define, usa variaveis globais
int cor_branca = 0;
int cor_amarela = 2816;
int cor_azul = 3072;


// ---- pacman -----
int caracterPacmanEsqAberto  = 1; // 8;
int caracterPacmanEsqFechado = 2; // 16;

int caracterPacmanDirAberto  = 3; // 24;
int caracterPacmanDirFechado = 4; // 32;

int caracterPacmanCimaAberto  = 5; // 40;
int caracterPacmanCimaFechado = 6; // 48;

int caracterPacmanBaixoAberto  = 7; // 56;
int caracterPacmanBaixoFechado = 8; // 64;

// ----- comida --------
int caracterComida = 0; // posicao no charmap

    // caracter do personagem
    char c = caracterPacmanDirAberto;

    // direcao e estado
    int direcao = 1;
    int estado = 0; // 1 - fechado, 0 aberto

    // posicao inicial do personagem
    int pos_x = 1;
    int pos_y = 1;

void resolve_direcao() {
    // imprime o pacman na direcao certa
    if(direcao == 0)        c = caracterPacmanEsqAberto;
    else if(direcao == 1)   c = caracterPacmanDirAberto;
    else if(direcao == 2)   c = caracterPacmanCimaAberto;
    else if(direcao == 3)   c = caracterPacmanBaixoAberto;
    c += estado;
    printf(pos_x, pos_y, "%c", c + cor_amarela);
    estado = 1 - estado;
}

// o main nao tem argumentos e nao retorna nada
void main() {
    int i, j;

    // Mapa = 30 x 40

    // nao se esquecer de contar o \0 no fim de cada string
    char mapa[30][29] = {
        { "############################" },
        { "#............##............#" }, 
        { "#.####.#####.##.#####.####.#" },
        { "#.####.#####.##.#####.####.#" },
        { "#.####.#####.##.#####.####.#" },
        { "#..........................#" },
        { "#.####.##.########.##.####.#" },
        { "#.####.##.########.##.####.#" },
        { "#......##....##....##......#" },
        { "######.##### ## #####.######" },
        { "     #.##          ##.#     " },
        { "     #.## ###--### ##.#     " },
        { "######.## #      # ##.######" },
        { "      .   #      #   .      " },
        { "######.## #      # ##.######" },
        { "     #.## ######## ##.#     " },
        { "     #.##          ##.#     " },
        { "     #.## ######## ##.#     " },
        { "######.## ######## ##.######" },
        { "#............##............#" },
        { "#.####.#####.##.#####.####.#" },
        { "#.####.#####.##.#####.####.#" },
        { "#...##...          ...##...#" },
        { "###.##.## ######## ##.##.###" },
        { "###.##.## ######## ##.##.###" },
        { "#......##    ##    ##......#" },
        { "#.########## ## ##########.#" },
        { "#.########## ## ##########.#" },
        { "#...........    ...........#" },
        { "############################" }
    };

    int cor = cor_branca;
    // imprime o mapa
    for(i = 0; i < 30; i++) {

        for(j = 0; j < 28; j++) {

            if(mapa[i][j] == '#')
                cor = cor_azul;

            if(mapa[i][j] == '.')
                cor = cor_branca;

            if(mapa[i][j] == ' ')
                cor = cor_branca;

            printf(i, j, "%c", mapa[i][j] + cor);
        }
    }

    // imprime informacoes do jogo
    printf(1, 29, "Jogo do");
    printf(2, 29, "Pacman v2.0");
    printf(4, 29, "Controles:");
    printf(5, 29, "w - Sobe");
    printf(6, 29, "a - Esq");
    printf(7, 29, "s - Desce");
    printf(8, 29, "d - Dir");

    // imprime o personagem
    printf(pos_x, pos_y, "%c", c);

    // score
    int score = 0;
    printf(10, 29, "Score: %d", score);

    // vidas
    int vidas = 3;
    printf(11, 29, "Vidas: %d", vidas);

    // tecla pressionada pelo usuario
    char key = 'l';

    // loop do jogo
    while(key != 'q') {
        // recebe a tecla
        key = getch();

        // esquerda y--
        if(key == 'a' && pos_y > 1) {   // lembrar que nao tem numero negativo

            // se for muro, nao move
            if(mapa[pos_x][pos_y-1] == '#')
                continue;

            printf(pos_x, pos_y, " ");  // apaga a posicao anterior
            pos_y--;
            direcao = 0;
            resolve_direcao();
        }

        // direita y++
        if(key == 'd' && pos_y < 27) {

            // se for muro, nao move
            if(mapa[pos_x][pos_y+1] == '#')
                continue;

            printf(pos_x, pos_y, " ");  // apaga a posicao anterior
            pos_y++;
            direcao = 1;
            resolve_direcao();
        }

        // desce x++
        if(key == 's' && pos_x < 28) {

            // se for muro, nao move
            if(mapa[pos_x+1][pos_y] == '#')
                continue;

            printf(pos_x, pos_y, " ");  // apaga a posicao anterior
            pos_x++;
            direcao = 3;
            resolve_direcao();
        }

        // sobe x--
        if(key == 'w' && pos_x > 1) {

            // se for muro, nao move
            if(mapa[pos_x-1][pos_y] == '#')
                continue;

            printf(pos_x, pos_y, " ");  // apaga a posicao anterior
            pos_x--;
            direcao = 2;
            resolve_direcao();
        }

        // atualiza o mapa, se for comida
        if(mapa[pos_x][pos_y] == '.') {
            score++;
            printf(10, 36, "%d", score);
            mapa[pos_x][pos_y] = ' ';
        }
    }

    return;
}

