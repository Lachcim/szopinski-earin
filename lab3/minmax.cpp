/*
    EARIN LABORATORY 3
    MICHAŁ SZOPIŃSKI 300182 & TOMASZ JURANIEC 293109
    https://github.com/Lachcim/szopinski-earin
    This file implements the min-max algorithm.
*/

#include "minmax.h"

static move get_best_move(const Board& board, char player, int alpha, int beta) {
    //terminal state reached, only one outcome possible
    switch (board.get_winner()) {
        case 'X': return {-1, 1};
        case 'O': return {-1, -1};
        case '=': return {-1, 0};
    }

    //find best move to minimize the opponent's chances at winning
    move best_move = {-1, player == 'X' ? -2 : 2};

    //simulate all possible moves
    for (int pos = 0; pos < 9; pos++) {
        //skip taken fields
        if (!board.can_place(pos))
            continue;

        //derive new board and let the opponent do their worst
        Board derived = board.derive(pos, player);
        move opponent_move = get_best_move(derived, player == 'X' ? 'O' : 'X', alpha, beta);
        opponent_move.position = pos;

        if (player == 'X') {
            //pick most X-friendly value
            if (opponent_move.value > best_move.value) {
                best_move = opponent_move;
                alpha = opponent_move.value;
            }
        }
        else {
            //pick most O-friendly value
            if (opponent_move.value < best_move.value) {
                best_move = opponent_move;
                beta = opponent_move.value;
            }
        }

        //alpha-beta prunning
        if (alpha >= beta)
            break;
    }

    return best_move;
}

move get_best_move(const Board& board, char player) {
    return get_best_move(board, player, -2, 2);
}
