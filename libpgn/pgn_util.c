#include "pgn_util.h"

void moves_foreach(pgn_moves_t *moves, void (*callback)(pgn_move_t *move))
{
    for (size_t i = 0; i < moves->length; i++) {
        callback(&moves->values[i].white);
        callback(&moves->values[i].black);
    }
}

__pgn_moves_item_t *moves_access_nth(pgn_moves_t *moves, unsigned long nth)
{
    return &moves->values[nth];
}
