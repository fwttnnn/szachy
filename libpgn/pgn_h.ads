pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
limited with pgn_table_h;
limited with pgn_moves_h;
with pgn_score_h;
with Interfaces.C.Strings;

package pgn_h is
   type pgn_t is record
      Metadata : access pgn_table_h.pgn_table_t;  -- /usr/include/pgn.h:25
      Moves : access pgn_moves_h.pgn_moves_t;  -- /usr/include/pgn.h:26
      Score : aliased pgn_score_h.pgn_score_t;  -- /usr/include/pgn.h:27
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn.h:24

   function Pgn_Init return access pgn_t  -- /usr/include/pgn.h:30
   with Import => True, 
        Convention => C, 
        External_Name => "pgn_init";

   procedure Pgn_Cleanup (Pgn : access pgn_t)  -- /usr/include/pgn.h:31
   with Import => True, 
        Convention => C, 
        External_Name => "pgn_cleanup";

   procedure Pgn_Parse (Pgn : access pgn_t; Str : Interfaces.C.Strings.chars_ptr)  -- /usr/include/pgn.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "pgn_parse";
end pgn_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
