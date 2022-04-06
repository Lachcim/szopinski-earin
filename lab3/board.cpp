/*
    EARIN LABORATORY 3
    MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
    https://github.com/Lachcim/szopinski-earin
    This file implements the board class.
*/

#include "board.h"

Board::Board() {
    //initialize empty board
    for (int i = 0; i < 9; i++)
        fields[i] = 0;
}

Board Board::derive(int position, char player) const {
    //create a copy of the current board with the given field changed
    Board new_board(*this);
    new_board.fields[position] = player;
    return new_board;
}

char Board::get_char(int position) const {
    return fields[position] ? fields[position] : '.';
}

bool Board::can_place(int position) const {
    return fields[position] == 0;
}

char Board::get_winner() const {
    //check rows
    for (int row = 0; row <= 6; row += 3)
        if (fields[row] && fields[row] == fields[row + 1] && fields[row] == fields[row + 2])
            return fields[row];

    //check columns
    for (int col = 0; col <= 2; col++)
        if (fields[col] && fields[col] == fields[col + 3] && fields[col] == fields[col + 6])
            return fields[col];

    //check diagonals
    if (fields[0] && fields[0] == fields[4] && fields[0] == fields[8])
        return fields[0];
    if (fields[2] && fields[2] == fields[4] && fields[2] == fields[6])
        return fields[2];

    //non-terminal state
    for (int i = 0; i < 9; i++)
        if (fields[i] == 0)
            return 0;

    //draw
    return '=';
}
