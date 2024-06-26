#ifndef __LIBPGN_UTILITY_ADA_H
#define __LIBPGN_UTILITY_ADA_H

#include <pgn.h>

void moves_foreach(pgn_moves_t *moves, void (*callback)(pgn_move_t *move));
__pgn_moves_item_t *moves_access_nth(pgn_moves_t *moves, unsigned long nth);

#endif // __LIBPGN_UTILITY_ADA_H 
