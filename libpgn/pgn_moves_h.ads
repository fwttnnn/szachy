pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
with pgn_piece_h;
with Interfaces.C.Extensions;
with pgn_check_h;
with pgn_coordinate_h;
with pgn_annotation_h;
with Interfaces.C.Strings;

package pgn_moves_h is
   PGN_CASTLING_NONE : constant := 0;  --  /usr/include/pgn/moves.h:15
   PGN_CASTLING_KINGSIDE : constant := 2;  --  /usr/include/pgn/moves.h:16
   PGN_CASTLING_QUEENSIDE : constant := 3;  --  /usr/include/pgn/moves.h:17

   PGN_MOVES_INITIAL_SIZE : constant := 32;  --  /usr/include/pgn/moves.h:19
   PGN_MOVES_GROW_SIZE : constant := 32;  --  /usr/include/pgn/moves.h:20

   PGN_MOVES_ALTERNATIVES_INITIAL_SIZE : constant := 6;  --  /usr/include/pgn/moves.h:36

   subtype anon_array1198 is Interfaces.C.char_array (0 .. 15);
   type pgn_move_t is record
      Piece : aliased pgn_piece_h.pgn_piece_t;  -- /usr/include/pgn/moves.h:25
      Promoted_To : aliased pgn_piece_h.pgn_piece_t;  -- /usr/include/pgn/moves.h:25
      Nth_Best : aliased unsigned;  -- /usr/include/pgn/moves.h:26
      Notation : aliased anon_array1198;  -- /usr/include/pgn/moves.h:27
      Castles : aliased int;  -- /usr/include/pgn/moves.h:28
      Captures : aliased Extensions.bool;  -- /usr/include/pgn/moves.h:29
      En_Passant : aliased Extensions.bool;  -- /usr/include/pgn/moves.h:30
      Check : aliased pgn_check_h.pgn_check_t;  -- /usr/include/pgn/moves.h:31
      From : aliased pgn_coordinate_h.pgn_coordinate_t;  -- /usr/include/pgn/moves.h:32
      Dest : aliased pgn_coordinate_h.pgn_coordinate_t;  -- /usr/include/pgn/moves.h:32
      Annotation : aliased pgn_annotation_h.pgn_annotation_t;  -- /usr/include/pgn/moves.h:33
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn/moves.h:24

   type pgn_moves_t;
   type uu_pgn_moves_item_t;
   type uu_pgn_moves_item_t is record
      White : aliased pgn_move_t;  -- /usr/include/pgn/moves.h:42
      Black : aliased pgn_move_t;  -- /usr/include/pgn/moves.h:43
      Alternatives : access pgn_moves_t;  -- /usr/include/pgn/moves.h:44
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn/moves.h:41

   type pgn_moves_t is record
      Values : access uu_pgn_moves_item_t;  -- /usr/include/pgn/moves.h:48
      Length : aliased unsigned_long;  -- /usr/include/pgn/moves.h:49
      Size : aliased unsigned_long;  -- /usr/include/pgn/moves.h:50
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn/moves.h:47
end pgn_moves_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
