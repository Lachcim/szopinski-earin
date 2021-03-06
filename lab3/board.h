/*
    EARIN LABORATORY 3
    MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
    https://github.com/Lachcim/szopinski-earin
    This file defines the board class.
*/

#ifndef BOARD_H
#define BOARD_H

class Board {
    char fields[9];

    public:
        Board();

        Board derive(int, char) const;
        char get_char(int) const;
        bool can_place(int) const;
        char get_winner() const;
};

#endif
