pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package pgn_score_h is
   type pgn_score_t is record
      white : aliased unsigned_short;  -- /usr/include/pgn/score.h:10
      black : aliased unsigned_short;  -- /usr/include/pgn/score.h:10
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn/score.h:9
end pgn_score_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
