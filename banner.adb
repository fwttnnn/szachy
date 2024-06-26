with Ada.Text_IO;

package body Banner is
    use Ada.Text_IO;

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

end Banner;
