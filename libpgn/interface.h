#ifndef __LIBPGN_ADA_INTERFACE_H
#define __LIBPGN_ADA_INTERFACE_H

#include <pgn.h>

void moves_foreach(pgn_moves_t *moves, void (*callback)(pgn_move_t *move));

#endif // __LIBPGN_ADA_INTERFACE_H
