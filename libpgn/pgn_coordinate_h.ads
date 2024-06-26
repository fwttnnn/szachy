pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;

package pgn_coordinate_h is
   PGN_COORDINATE_UNKNOWN : constant := 0;  --  /usr/include/pgn/coordinate.h:4

   type pgn_coordinate_t is record
      x : aliased char;  -- /usr/include/pgn/coordinate.h:9
      y : aliased int;  -- /usr/include/pgn/coordinate.h:10
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn/coordinate.h:8
end pgn_coordinate_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
