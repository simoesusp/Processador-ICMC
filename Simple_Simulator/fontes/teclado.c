#include <stdbool.h>
#include <termios.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>


// DESCONTINUADA: função marcada para ser descontinuada e substituida
bool esta_teclando() {
    struct termios terminal_antigo, terminal_novo;

    // Configura o terminal
    tcgetattr(STDIN_FILENO, &terminal_antigo);
    terminal_novo = terminal_antigo;
    terminal_novo.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &terminal_novo);

    // Atualiza a flag do stdin
    int flag = fcntl(STDIN_FILENO, F_GETFL);
    fcntl(STDIN_FILENO, F_SETFL, flag | O_NONBLOCK);

    char tecla = getchar();

    // Reseta as configurações
    tcsetattr(STDIN_FILENO, TCSANOW, &terminal_antigo);
    fcntl(STDIN_FILENO, F_SETFL, flag);

    if(tecla != EOF) {
        ungetc(tecla, stdin);
        return true;
    }

    return false;
}
