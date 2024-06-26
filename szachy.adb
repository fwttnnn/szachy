with pgn_h; use pgn_h;
with pgn_coordinate_h; use pgn_coordinate_h;
with pgn_piece_h; use pgn_piece_h;
with pgn_moves_h; use pgn_moves_h;
with pgn_util_h; use pgn_util_h;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Ada.Characters.Handling; use Ada.Characters.Handling;

procedure Szachy is
    Pgn : access pgn_t;
    Pgn_Move : access uu_pgn_moves_item_t;

    type Player is (White, Black);

    BOARD_MAX_ROW : constant Integer := 7;
    BOARD_MAX_COL : constant Integer := 7;

    BOARD_WIDTH : constant Integer := BOARD_MAX_ROW + 1;
    BOARD_HEIGHT : constant Integer := BOARD_MAX_COL + 1;

    type Board_Mat_Row is range 0 .. BOARD_MAX_ROW;
    type Board_Mat_Col is range 0 .. BOARD_MAX_COL;
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
            Put (Integer (-(Integer (I) - BOARD_WIDTH)), Width => 0);

            for J in Board_Mat_Col loop
                Put (" ");
                Put (Board (I, J));
            end loop;
            New_Line;

        end loop;

        Put (" ");
        for I in Board_Mat_Row loop
            Put (" ");
            Put (Character'Val (Character'Pos ('a') + I));
        end loop;
        New_Line;
    end Put_Board_Line;

    procedure Put_Banner is
    begin
        New_Line;
        Put_Line ("        '||                           ");
        Put_Line ("  ....   || ..     ....   ....   .... ");
        Put_Line (".|   ''  ||' ||  .|...|| ||. '  ||. ' ");
        Put_Line ("||       ||  ||  ||      . '|.. . '|..");
        Put_Line (" '|...' .||. ||.  '|...' |'..|' |'..|'");
        New_Line;
    end Put_Banner;

    function Is_Piece_Eq_To_Player (P : Player; piece : Character) return Boolean is
    begin
        return (P = Player'(White) and Is_Upper(piece)) or (P = BLACK and Is_Lower(piece));
    end Is_Piece_Eq_To_Player;

    function Is_Coor_Inside_Board (X, Y : Integer) return Boolean is
    begin
        return (X >= 0 and X <= BOARD_MAX_ROW) and (Y >= 0 and Y <= BOARD_MAX_COL);
    end Is_Coor_Inside_Board;

    procedure Move_Castles (Board : in out Board_Mat; P : Player; Player_Move : pgn_move_t) is
    begin
        case Player_Move.Castles is
            when PGN_CASTLING_KINGSIDE =>
                case P is
                    when Player'(White) =>
                        board(7, 4) := ' ';
                        board(7, 5) := 'R';
                        board(7, 6) := 'K';
                        board(7, 7) := ' ';
                    when Player'(Black) =>
                        board(0, 4) := ' ';
                        board(0, 5) := 'r';
                        board(0, 6) := 'k';
                        board(0, 7) := ' ';
                end case;
            when PGN_CASTLING_QUEENSIDE =>
                case P is
                    when Player'(White) =>
                        board(7, 0) := ' ';
                        board(7, 2) := 'K';
                        board(7, 3) := 'R';
                        board(7, 5) := ' ';
                    when Player'(Black) =>
                        board(0, 0) := ' ';
                        board(0, 2) := 'k';
                        board(0, 3) := 'r';
                        board(0, 5) := ' ';
                end case;
            when others =>
                Put_Line ("szachy: unreachable!");
        end case;
    end Move_Castles;

    function Move_Pawn_Possible (Board : in out Board_Mat; P : Player; X, Y : Integer; Player_Move : pgn_move_t) return Boolean is
        Dest_X : Integer := char'Pos (Player_Move.Dest.X) - Character'Pos ('a');
        Dest_Y : Integer := -(Integer (Player_Move.Dest.Y) - BOARD_HEIGHT);
    begin
        case P is
            when Player'(White) =>
                if (X = Dest_X and Y - 1 = Dest_Y) then return TRUE; end if;
                if (X = Dest_X and Y - 2 = Dest_Y) then return TRUE; end if;

                if (Boolean (Player_Move.Captures)) then
                    if (X - 1 = Dest_X and Y - 1 = Dest_Y) then return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y - 1), Board_Mat_Col (X - 1))); end if;
                    if (X + 1 = Dest_X and Y - 1 = Dest_Y) then return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y - 1), Board_Mat_Col (X + 1))); end if;
                end if;

                if (Boolean (Player_Move.En_Passant) and X - 1 = Dest_X and Y - 1 = Dest_Y) then return TRUE; end if;
                if (Boolean (Player_Move.En_Passant) and X + 1 = Dest_X and Y - 1 = Dest_Y) then return TRUE; end if;
            when Player'(Black) =>
                if (X = Dest_X and y + 1 = Dest_Y) then return TRUE; end if;
                if (X = Dest_X and y + 2 = Dest_Y) then return TRUE; end if;

                if (Boolean (Player_Move.Captures)) then
                    if (X - 1 = Dest_X and Y + 1 = Dest_Y) then return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y + 1), Board_Mat_Col (X - 1))); end if;
                    if (X + 1 = Dest_X and Y + 1 = Dest_Y) then return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y + 1), Board_Mat_Col (X + 1))); end if;
                end if;

                if (Boolean (Player_Move.En_Passant) and X - 1 = Dest_X and Y + 1 = Dest_Y) then return TRUE; end if;
                if (Boolean (Player_Move.En_Passant) and X + 1 = Dest_X and Y + 1 = Dest_Y) then return TRUE; end if;
        end case;
        return FALSE;
    end Move_Pawn_Possible;

    function Move_Knight_Possible (Board : in out Board_Mat; P : Player; X, Y : Integer; Player_Move : pgn_move_t) return Boolean is
        Dest_X : Integer := char'Pos (Player_Move.Dest.X) - Character'Pos ('a');
        Dest_Y : Integer := -(Integer (Player_Move.Dest.Y) - BOARD_HEIGHT);
    begin
        if (Is_Coor_Inside_Board(X - 1, Y + 2) and (X - 1 = Dest_X and Y + 2 = Dest_Y)) then
            return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y + 2), Board_Mat_Col (X - 1)));
        end if;
        if (Is_Coor_Inside_Board(X + 1, Y + 2) and (X + 1 = Dest_X and Y + 2 = Dest_Y)) then
            return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y + 2), Board_Mat_Col (X + 1)));
        end if;

        if (Is_Coor_Inside_Board(X - 2, Y + 1) and (X - 2 = Dest_X and Y + 1 = Dest_Y)) then
            return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y + 1), Board_Mat_Col (X - 2)));
        end if;
        if (Is_Coor_Inside_Board(X + 2, Y + 1) and (X + 2 = Dest_X and Y + 1 = Dest_Y)) then
            return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y + 1), Board_Mat_Col (X + 2)));
        end if;

        if (Is_Coor_Inside_Board(X - 1, Y - 2) and (X - 1 = Dest_X and Y - 2 = Dest_Y)) then
            return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y - 2), Board_Mat_Col (X - 1)));
        end if;
        if (Is_Coor_Inside_Board(X + 1, Y - 2) and (X + 1 = Dest_X and Y - 2 = Dest_Y)) then
            return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y - 2), Board_Mat_Col (X + 1)));
        end if;

        if (Is_Coor_Inside_Board(X - 2, Y - 1) and (X - 2 = Dest_X and Y - 1 = Dest_Y)) then
            return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y - 1), Board_Mat_Col (X - 2)));
        end if;
        if (Is_Coor_Inside_Board(X + 2, Y - 1) and (X + 2 = Dest_X and Y - 1 = Dest_Y)) then
            return not Is_Piece_Eq_To_Player(P, Board(Board_Mat_Row (Y - 1), Board_Mat_Col (X + 2)));
        end if;
        return FALSE;
    end Move_Knight_Possible;

    function Move_Bishop_Possible (Board : in out Board_Mat; P : Player; X, Y : Integer; Player_Move : pgn_move_t) return Boolean is
        Dest_X : Integer := char'Pos (Player_Move.Dest.X) - Character'Pos ('a');
        Dest_Y : Integer := -(Integer (Player_Move.Dest.Y) - BOARD_HEIGHT);
    begin
        for I in 1 .. BOARD_MAX_COL loop
            if (X + I = Dest_X and Y + I = Dest_Y) then return Is_Coor_Inside_Board(X + I, Y + I); end if;
            if (X + I = Dest_X and Y - I = Dest_Y) then return Is_Coor_Inside_Board(X + I, Y - I); end if;
            if (X - I = Dest_X and Y - I = Dest_Y) then return Is_Coor_Inside_Board(X - I, Y - I); end if;
            if (X - I = Dest_X and Y + I = Dest_Y) then return Is_Coor_Inside_Board(X - I, Y + I); end if;
        end loop;
        return FALSE;
    end Move_Bishop_Possible;

    function Move_Is_Possible (Board : in out Board_Mat; P : Player; X, Y : Integer; Player_Move : pgn_move_t) return Boolean is
    begin
        case Player_Move.Piece is
            when PGN_PIECE_PAWN =>
                return Move_Pawn_Possible (Board, P, X, Y, Player_Move);
            when PGN_PIECE_KNIGHT =>
                return Move_Knight_Possible (Board, P, X, Y, Player_Move);
            when PGN_PIECE_BISHOP =>
                return Move_Bishop_Possible (Board, P, X, Y, Player_Move);
            when others =>
                return FALSE;
        end case;
    end Move_Is_Possible;

    procedure Move (Board : in out Board_Mat; P : Player; Player_Move : pgn_move_t) is
        X : Integer;
        Y : Integer;
    begin
        if (Player_Move.Castles /= 0) then
            Move_Castles (Board, P, Player_Move);
            return;
        end if;

        for I in Board_Mat_Row loop
            for J in Board_Mat_Col loop
                if (To_Upper (Board(I, J)) = Character (Pgn_Piece_To_Char (Player_Move.Piece)) and Is_Piece_Eq_To_Player (P, Board(I, J))) then
                    X := Integer (J);
                    Y := Integer (I);

                    -- TODO: make use of Player_Move.From.* coordinate
                    if (Move_Is_Possible (Board, P, X, Y, Player_Move)) then
                        Board(Board_Mat_Row (-(Integer (Player_Move.Dest.Y) - BOARD_WIDTH)), char'Pos (Player_Move.Dest.X) - Character'Pos ('a')) := Board(I, J);
                        Board(I, J) := ' ';

                        if (Player_Move.En_Passant) then
                            Board(Board_Mat_Row (-(Integer (Player_Move.Dest.Y) - BOARD_WIDTH) + (if P = Player'(White) then 1 else -1)), char'Pos (Player_Move.Dest.X) - Character'Pos ('a') + 1) := ' ';
                        end if;

                        Put_Board_Line (Board);
                        New_Line;
                        return;
                    end if;
                end if;
            end loop;
        end loop;
    end Move;

begin
    Pgn := Pgn_Init;
    Pgn_Parse (Pgn, Interfaces.C.Strings.New_String ("[White ""Fischer, Robert J.""]" & LF & "[Black ""Spassky, Boris V.""]" & LF & "1. e4 e5 2. Nf3 Nc6 3. Bb5 3... a6 4. Ba4 Nf6 5. O-O Be7 6. Re1 b5 7. Bb3 d6 8. c3 O-O 9. h3 Nb8 10. d4 Nbd7 11. c4 c6 12. cxb5 axb5 13. Nc3 Bb7 14. Bg5 b4 15. Nb1 h6 16. Bh4 c5 17. dxe5 Nxe4 18. Bxe7 Qxe7 19. exd6 Qf6 20. Nbd2 Nxd6 21. Nc4 Nxc4 22. Bxc4 Nb6 23. Ne5 Rae8 24. Bxf7+ Rxf7 25. Nxf7 Rxe1+ 26. Qxe1 Kxf7 27. Qe3 Qg5 28. Qxg5 hxg5 29. b3 Ke6 30. a3 Kd6 31. axb4 cxb4 32. Ra5 Nd5 33. f3 Bc8 34. Kf2 Bf5 35. Ra7 g6 36. Ra6+ Kc5 37. Ke1 Nf4 38. g3 Nxh3 39. Kd2 Kb5 40. Rd6 Kc5 41. Ra6 Nf2 42. g4 Bd3 43. Re6 1/2-1/2"));

    Put_Banner;
    Put_Board_Line (Board);
    New_Line;

    for I in 0 .. Pgn.moves.length - 1 loop
        Pgn_Move := Moves_Access_Nth (Pgn.Moves, I);

        Move (Board, Player'(White), Pgn_Move.White);
        Move (Board, Player'(Black), Pgn_Move.Black);
    end loop;

    Pgn_Cleanup (Pgn);
end Szachy;
