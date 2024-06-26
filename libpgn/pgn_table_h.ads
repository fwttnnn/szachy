pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
limited with pgn_string_h;
with System;
with Interfaces.C.Strings;

package pgn_table_h is
   PGN_TABLE_INITIAL_SIZE : constant := 7;  --  /usr/include/pgn/table.h:10
   PGN_TABLE_GROW_SIZE : constant := 7;  --  /usr/include/pgn/table.h:11

   type uu_pgn_table_item_t is record
      key : access pgn_string_h.pgn_string_t;  -- /usr/include/pgn/table.h:14
      value : access pgn_string_h.pgn_string_t;  -- /usr/include/pgn/table.h:15
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn/table.h:13

   type pgn_table_t is record
      items : System.Address;  -- /usr/include/pgn/table.h:19
      length : unsigned_long;  -- /usr/include/pgn/table.h:20
      size : unsigned_long;  -- /usr/include/pgn/table.h:20
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/pgn/table.h:18
end pgn_table_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
