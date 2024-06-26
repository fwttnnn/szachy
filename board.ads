with Player;
with pgn_moves_h;

package Board is
    use Player;
    use pgn_moves_h;

    BOARD_MAX_COL : constant Integer := 7;
    BOARD_MAX_ROW : constant Integer := 7;

    BOARD_WIDTH : constant Integer := BOARD_MAX_COL + 1;
    BOARD_HEIGHT : constant Integer := BOARD_MAX_ROW + 1;

    type Board_Mat_Col is range 0 .. BOARD_MAX_COL;
    type Board_Mat_Row is range 0 .. BOARD_MAX_ROW;
    type Board_Mat is array (Board_Mat_Col, Board_Mat_Row) of Character;

    Chess_Board : Board_Mat := 
        (( 'r', 'n', 'b', 'q', 'k', 'b', 'n', 'r' ),
         ( 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p' ),
         ( ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ),
         ( ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ),
         ( ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ),
         ( ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ),
         ( 'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P' ),
         ( 'R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R' ));

    procedure Put_Board_Line (Board : Board_Mat);
    procedure Move (Board : in out Board_Mat; P : Player_T; Player_Move : pgn_move_t);

end Board;
