with pgn_h; use pgn_h;
with pgn_moves_h; use pgn_moves_h;
with pgn_util_h; use pgn_util_h;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

procedure Szachy is
    Pgn : access pgn_t;
    Pgn_Move : access uu_pgn_moves_item_t;

    type Board_Mat_Row is range 1 .. 8;
    type Board_Mat_Col is range 1 .. 8;
    type Board_Mat is array (Board_Mat_Row, Board_Mat_Col) of Character;

    Board : Board_Mat := 
        (( 'r', 'n', 'b', 'q', 'k', 'b', 'n', 'r' ),
         ( 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p' ),
         ( ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ),
         ( ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ),
         ( ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ),
         ( ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ),
         ( 'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P' ),
         ( 'R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R' ));

    procedure Put_Board_Line (Board : Board_Mat) is
    begin
        for I in Board_Mat_Row loop
            Put (Integer (-(I - 8 - 1)), Width => 0);

            for J in Board_Mat_Col loop
                Put (" ");
                Put (Board (I, J));
            end loop;
            New_Line;

        end loop;

        Put (" ");
        for I in Board_Mat_Row loop
            Put (" ");
            Put (Character'Val (Character'Pos ('a') + I - 1));
        end loop;
    end Put_Board_Line;

    procedure Put_Banner is
    begin
        New_Line;
        Put_Line ("        '||                            ");
        Put_Line ("  ....   || ..     ....   ....   ....  ");
        Put_Line (".|   ''  ||' ||  .|...|| ||. '  ||. '  ");
        Put_Line ("||       ||  ||  ||      . '|.. . '|.. ");
        Put_Line (" '|...' .||. ||.  '|...' |'..|' |'..|' ");
        New_Line;
    end Put_Banner;
begin
    Pgn := Pgn_Init;
    Pgn_Parse (Pgn, Interfaces.C.Strings.New_String ("[White ""Fischer, Robert J.""]" & LF & "[Black ""Spassky, Boris V.""]" & LF & "1. e4 e5 2. Nf3 Nc6 3. Bb5 3... a6 4. Ba4 Nf6 5. O-O Be7 6. Re1 b5 7. Bb3 d6 8. c3 O-O 9. h3 Nb8 10. d4 Nbd7 11. c4 c6 12. cxb5 axb5 13. Nc3 Bb7 14. Bg5 b4 15. Nb1 h6 16. Bh4 c5 17. dxe5 Nxe4 18. Bxe7 Qxe7 19. exd6 Qf6 20. Nbd2 Nxd6 21. Nc4 Nxc4 22. Bxc4 Nb6 23. Ne5 Rae8 24. Bxf7+ Rxf7 25. Nxf7 Rxe1+ 26. Qxe1 Kxf7 27. Qe3 Qg5 28. Qxg5 hxg5 29. b3 Ke6 30. a3 Kd6 31. axb4 cxb4 32. Ra5 Nd5 33. f3 Bc8 34. Kf2 Bf5 35. Ra7 g6 36. Ra6+ Kc5 37. Ke1 Nf4 38. g3 Nxh3 39. Kd2 Kb5 40. Rd6 Kc5 41. Ra6 Nf2 42. g4 Bd3 43. Re6 1/2-1/2"));

    Put_Banner;
    Put_Board_Line (Board);

    for I in 0 .. Pgn.moves.length - 1 loop
        Pgn_Move := Moves_Access_Nth (Pgn.Moves, I);
    end loop;

    Pgn_Cleanup (Pgn);
end Szachy;
