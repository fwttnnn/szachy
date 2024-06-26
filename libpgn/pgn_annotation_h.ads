pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package pgn_annotation_h is
   type pgn_annotation_t is 
     (PGN_ANNOTATION_NONE,
      PGN_ANNOTATION_CHECKMATE,
      PGN_ANNOTATION_GOOD_MOVE,
      PGN_ANNOTATION_EXCELLENT_MOVE,
      PGN_ANNOTATION_INTRESTING_MOVE,
      PGN_ANNOTATION_DUBIOUS_MOVE,
      PGN_ANNOTATION_MISTAKE,
      PGN_ANNOTATION_BLUNDER)
   with Convention => C;  -- /usr/include/pgn/annotation.h:7
end pgn_annotation_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
