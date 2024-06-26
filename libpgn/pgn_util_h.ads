pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
limited with pgn_moves_h;

package pgn_util_h is
   procedure Moves_Foreach (moves : access pgn_moves_h.pgn_moves_t; callback : access procedure (arg1 : access pgn_moves_h.pgn_move_t))  -- pgn_util.h:6
   with Import => True, 
        Convention => C, 
        External_Name => "moves_foreach";

   function Moves_Access_Nth (moves : access pgn_moves_h.pgn_moves_t; nth : unsigned_long) return access pgn_moves_h.uu_pgn_moves_item_t  -- pgn_util.h:7
   with Import => True, 
        Convention => C, 
        External_Name => "moves_access_nth";
end pgn_util_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
