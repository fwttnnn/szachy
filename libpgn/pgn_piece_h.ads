pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package pgn_piece_h is
   PGN_PIECE_PAWN_CHAR : aliased constant Character := 'P';  --  /usr/include/pgn/piece.h:10
   PGN_PIECE_ROOK_CHAR : aliased constant Character := 'R';  --  /usr/include/pgn/piece.h:11
   PGN_PIECE_KNIGHT_CHAR : aliased constant Character := 'N';  --  /usr/include/pgn/piece.h:12
   PGN_PIECE_BISHOP_CHAR : aliased constant Character := 'B';  --  /usr/include/pgn/piece.h:13
   PGN_PIECE_QUEEN_CHAR : aliased constant Character := 'Q';  --  /usr/include/pgn/piece.h:14
   PGN_PIECE_KING_CHAR : aliased constant Character := 'K';  --  /usr/include/pgn/piece.h:15

   type pgn_piece_t is 
     (PGN_PIECE_UNKNOWN,
      PGN_PIECE_PAWN,
      PGN_PIECE_ROOK,
      PGN_PIECE_KNIGHT,
      PGN_PIECE_BISHOP,
      PGN_PIECE_QUEEN,
      PGN_PIECE_KING)
   with Convention => C;  -- /usr/include/pgn/piece.h:17
end pgn_piece_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
