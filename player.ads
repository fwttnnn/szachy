package Player is

    type Player_T is (White, Black);

    function Is_Piece_Eq_To_Player
        (P : Player_T;
         Piece : Character) return Boolean;

end Player;
