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

int cor_branca = 0;

int cor_oliva = 768;
int cor_marrom = 255;
int cor_roxo = 1280;
int cor_verde = 512;
int cor_amarela = 2816;
int cor_azul = 3072;

int cor_vermelho = 2304;
int cor_cinza = 2048;

int tabua_esquerda = 3; // 8 * 3 = 24;
int tabua_direita = 2; // 8 * 2 = 16;
int bloco  = 1; // 8 * 1 = 8;
int bola = 0; // 8 * 0 = 0;

int pos_x = 1;

int bola_delay = 10;
int bola_x = 10;
int bola_y = 20;
int bola_direcao = 0; // 1, 2, 3, 4

void main() {
    int i, j;

    char mapa[30][30];

    for (i=0; i < 30; i++) {
        for (j=0; j < 30; j++) {
            mapa[j][i] = ' ';
        }
    }

    for (i=2; i < 30; i++) {
        for (j=0; j < 30; j++) {
            if (i == 2 || i == 29 || j == 0 || j == 29) {
                mapa[j][i] = bloco;
                printf(i, j, "%c", bloco + cor_cinza);
            }
        }
    }

    for (i = 8; i < 12; i++) {
        for (j = 2; j < 28; j++) {
            int cor;

            if (i == 8) {
                cor = cor_azul;
            }

            if (i == 9) {
                cor = cor_vermelho;
            }

            if (i == 10) {
                cor = cor_verde;
            }

            if (i == 11) {
                cor = cor_amarela;
            }

            mapa[j][i] = bloco;
            printf(i, j, "%c", bloco + cor);
        }
    }

    int score = 0;
    printf(0, 1, "Score: %d", score);

    printf(bola_y, bola_x, "%c", bola + cor_vermelho);

    char key = '!';

    int step = 0;

    while (key != 'q') {
        key = getch();

        if ((key == 'x') && (bola_direcao == 0)) {
            bola_direcao = 3;
        }

        if (key == 'd' && pos_x < 25) {
            pos_x++;
            printf(28, pos_x - 1, "%c", ' ');
        }

        if (key == 'a' && pos_x > 1) {
            pos_x--;
            printf(28, pos_x + 4, "%c", ' ');
        }

        printf(28, pos_x, "%c", tabua_direita + cor_vermelho);

        for (i=1; i < 3; i++) {
            printf(28, pos_x + i, "%c", bloco + cor_vermelho);
        }
        
        printf(28, pos_x + 3, "%c", tabua_esquerda + cor_vermelho);
        

        if (step == bola_delay) {

            step = 0;

            if (bola_direcao == 1) {
                printf(bola_y, bola_x, "%c", ' ');

                bola_y--;
                bola_x--;

                printf(bola_y, bola_x, "%c", bola + cor_vermelho);
            }


            if (bola_direcao == 2) {
                printf(bola_y, bola_x, "%c", ' ');

                bola_y--;
                bola_x++;

                printf(bola_y, bola_x, "%c", bola + cor_vermelho);
            }

            if (bola_direcao == 3) {
                printf(bola_y, bola_x, "%c", ' ');

                bola_y++;
                bola_x--;

                printf(bola_y, bola_x, "%c", bola + cor_vermelho);
            }

            if (bola_direcao == 4) {
                printf(bola_y, bola_x, "%c", ' ');

                bola_y++;
                bola_x++;

                printf(bola_y, bola_x, "%c", bola + cor_vermelho);
            }

            if (bola_y == 28) {
                bola_x = 10;
                bola_y = 20;
                bola_direcao = 0;
            }

            // Fisica da Bolinha

            if (bola_x < 2) {
                
                if (bola_direcao == 3) {
                    bola_direcao = 4;
                }

                if (bola_direcao == 1) {
                    bola_direcao = 2;
                }

            }

            if (bola_x > 27) {
                if (bola_direcao == 2) {
                    bola_direcao = 1;
                }

                if (bola_direcao == 4) {
                    bola_direcao = 3;
                }
            }

            if ((pos_x - 1 < bola_x) && (bola_x < pos_x + 4) && (bola_y == 27)) {
                if (bola_direcao == 3) {
                    bola_direcao = 1;
                }

                if (bola_direcao == 4) {
                    bola_direcao = 2;
                }
            }

            if (bola_y < 4) {
                if (bola_direcao == 1) {
                    bola_direcao = 3;
                }

                if (bola_direcao == 2) {
                    bola_direcao = 4;
                }
            }

            if (mapa[bola_x][bola_y] == bloco) {
                mapa[bola_x][bola_y] = ' ';
                
                score++;
                printf(0, 1, "Score: %d", score);

                if (bola_direcao == 1) {
                    bola_direcao = 3;
                }

                if (bola_direcao == 2) {
                    bola_direcao = 4;
                }
            }

        }

        step++;
        
    }


    return;
}

