/*
    EARIN LABORATORY 3
    MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
    https://github.com/Lachcim/szopinski-earin
    This file contains the input prompt.
*/

#include <cstdio>
#include "minmax.h"

char get_first_player() {
    char output;

    while (true) {
        std::fputs("Which player would you like to go first? [x/o] ", stdout);
        std::scanf(" %c", &output);

        output &= 0xDF;
        if (output == 'X' || output == 'O')
            return output;
    }
}

void print_board(const Board& board) {
    for (int i = 2; i >= 0; i--)
        for (int j = 0; j < 3; j++) {
            std::putc(board.get_char(i * 3 + j), stdout);

            if (j == 2)
                std::putc('\n', stdout);
        }
}

int get_move(const Board& board) {
    char output;

    while (true) {
        std::fputs("Make your move [1-9 as on your keypad]: ", stdout);
        std::scanf(" %c", &output);

        if (output >= '1' && output <= '9' && board.can_place(output - '1'))
            return output - '1';
    }
}

int main() {
    Board board;

    std::fputs("You are player X. ", stdout);

    if (get_first_player() == 'O') {
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
