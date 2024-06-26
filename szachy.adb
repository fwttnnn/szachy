with Ada.Text_IO; use Ada.Text_IO;
with pgn_h; use pgn_h;
with pgn_moves_h; use pgn_moves_h;
with pgn_util_h; use pgn_util_h;

with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

procedure Szachy is
    Pgn : access pgn_t;
    Move : access uu_pgn_moves_item_t;

begin
    Pgn := Pgn_Init;
    Pgn_Parse (Pgn, Interfaces.C.Strings.New_String ("[Result ""1/0""]" & LF & "1. ex4 e5 2. Nf3 Nc6 3. Bb5"));

    for I in 0 .. Pgn.moves.length - 1 loop
        Move := Moves_Access_Nth (Pgn.Moves, I);
        Put_Line (Interfaces.C.To_Ada (Move.White.Notation));
        Put_Line (Interfaces.C.To_Ada (Move.Black.Notation));
        Put (LF);
    end loop;

    Put_Line ("Hello, from Ada.");

    Pgn_Cleanup (Pgn);
end Szachy;
