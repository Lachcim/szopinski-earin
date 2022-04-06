/*
    EARIN LABORATORY 3
    MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
    https://github.com/Lachcim/szopinski-earin
    This file contains input prompt.
*/

#include <cstdio>
#include "minmax.h"

char get_first_player() {
    char output = 0;

    while (output != 'X' && output != 'O') {
        std::fputs("Which player would you like to go first? [x/o] ", stdout);
        std::scanf(" %c", &output);
        output &= 0xDF;
    }

    return output;
}

void print_board(const Board& board) {
    int indices[] = {6, 7, 8, 3, 4, 5, 0, 1, 2};

    for (int i = 0; i < 9; i++) {
        std::putc(board.get_char(indices[i]), stdout);

        if (i % 3 == 2)
            std::putc('\n', stdout);
    }
}

int get_move(const Board& board) {
    char output;

    while (true) {
        std::fputs("Make your move [1-9 as on your keypad]: ", stdout);
        std::scanf(" %c", &output);

        if (output >= '1' && output <= '9' && board.can_place(output - '1'))
            break;
    }

    return output - '1';
}

int main() {
    std::fputs("You are player X. ", stdout);
    char first_player = get_first_player();

    Board board;

    if (first_player == 'O') {
        move opponent_move = get_best_move(board, 'O');
        board = board.derive(opponent_move.position, 'O');

        std::puts("Your opponent made the first move:");
        print_board(board);
    }

    while (true) {
        board = board.derive(get_move(board), 'X');

        std::puts("You made your move:");
        print_board(board);

        if (board.get_winner())
            break;

        move opponent_move = get_best_move(board, 'O');
        board = board.derive(opponent_move.position, 'O');

        std::puts("Your opponent made their move:");
        print_board(board);

        if (board.get_winner())
            break;
    }

    switch (board.get_winner()) {
        case 'X': std::puts("You win."); break; //a likely story haha
        case 'O': std::puts("Your opponent wins."); break;
        case '=': std::puts("The game ends in a draw."); break;
    }
}
