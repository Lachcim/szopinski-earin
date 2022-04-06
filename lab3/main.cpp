/*
    EARIN LABORATORY 3
    MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
    https://github.com/Lachcim/szopinski-earin
    This file contains input prompt.
*/

#include "board.h"
#include "minmax.h"
#include <cstdio>

int main() {
    Board board;
    move best_move = get_best_move(board, 'O');
    std::printf("best pos: %d\nbest value: %d\n", best_move.position, best_move.value);
}
