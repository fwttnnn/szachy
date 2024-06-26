pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package pgn_check_h is
   type pgn_check_t is 
     (PGN_CHECK_NONE,
      PGN_CHECK_SINGLE,
      PGN_CHECK_DOUBLE)
   with Convention => C;  -- /usr/include/pgn/check.h:7
end pgn_check_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
