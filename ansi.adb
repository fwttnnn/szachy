with Ada.Text_IO;
with Ada.Characters.Latin_1;

package body Ansi is
    use Ada.Text_IO;
    use Ada.Characters.Latin_1;

    procedure Move_Up (N : Integer)
    is
    begin
        Put (ESC & "[" & Integer'Image (N) & "A");
    end Move_Up;

    procedure Move_Down (N : Integer)
    is
    begin
        Put (ESC & "[" & Integer'Image (N) & "B");
    end Move_Down;

    procedure Move_Right (N : Integer)
    is
    begin
        Put (ESC & "[" & Integer'Image (N) & "C");
    end Move_Right;

    procedure Move_Left (N : Integer)
    is
    begin
        Put (ESC & "[" & Integer'Image (N) & "D");
    end Move_Left;

end Ansi;
