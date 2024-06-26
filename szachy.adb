with Ada.Text_IO; use Ada.Text_IO;
with pgn_h; use pgn_h;

with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

procedure Szachy is
    Pgn : access pgn_t;
begin
    Pgn := Pgn_Init;
    Pgn_Parse (Pgn, Interfaces.C.Strings.New_String ("[Result ""1/0""]" & LF & "1. ex4 e5 2. Nf3 Nc6 3. Bb5"));

    Put_Line ("Hello, from Ada.");

    Pgn_Cleanup (Pgn);
end Szachy;
