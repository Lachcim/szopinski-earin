/*
    EARIN LABORATORY 3
    MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
    https://github.com/Lachcim/szopinski-earin
    This file declares the min-max algorithm subroutine and defines data structures.
*/

#ifndef MINMAX_H
#define MINMAX_H

#include "board.h"

struct move {
    int position;
    int value;
};

move get_best_move(const Board&, char);

#endif
