with Ada.Characters.Handling;

package body Player is
    use Ada.Characters.Handling;

    function Is_Piece_Eq_To_Player (P : Player_T; Piece : Character) return Boolean is
    begin
        return (P = Player_T'(White) and Is_Upper(Piece)) or (P = Player_T'(Black) and Is_Lower(Piece));
    end Is_Piece_Eq_To_Player;

end Player;
