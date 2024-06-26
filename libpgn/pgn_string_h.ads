pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package pgn_string_h is
   PGN_STRING_INITIAL_SIZE : constant := 64;  --  /usr/include/pgn/string.h:9
   PGN_STRING_GROW_SIZE : constant := 32;  --  /usr/include/pgn/string.h:10

   type pgn_string_t is record
      buf : Interfaces.C.Strings.chars_ptr;  -- /usr/include/pgn/string.h:13
      length : aliased unsigned_long;  -- /usr/include/pgn/string.h:14
      size : aliased unsigned_long;  -- /usr/include/pgn/string.h:15
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn/string.h:12
end pgn_string_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
