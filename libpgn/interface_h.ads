pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
limited with pgn_moves_h;

package interface_h is
   procedure Moves_Foreach (moves : access pgn_moves_h.pgn_moves_t; callback : access procedure (arg1 : access pgn_moves_h.pgn_move_t))  -- interface.h:6
   with Import => True, 
        Convention => C, 
        External_Name => "moves_foreach";
end interface_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
