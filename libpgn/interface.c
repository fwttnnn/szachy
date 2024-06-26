#include "interface.h"

void moves_foreach(pgn_moves_t *moves, void (*callback)(pgn_move_t *move))
{
    for (size_t i = 0; i < moves->length; i++) {
        callback(&moves->values[i].white);
        callback(&moves->values[i].black);
    }
}
