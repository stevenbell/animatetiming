library IEEE;
use IEEE.std_logic_1164.all;

entity fulladder is
  port (
    signal a   : in std_logic;
    signal b   : in std_logic;
    signal cin : in std_logic;
    signal r    : out std_logic;
    signal cout : out std_logic
  );
end;

architecture sim of fulladder is

-- Standard delay table from Harris
constant PD_NAND2 : time := 20 ps;
constant PD_NOR2 : time := 30 ps;
constant PD_AND2 : time := 30 ps;
constant PD_OR2 : time := 40 ps;
constant PD_XOR2 : time := 60 ps;

signal axorb : std_logic;
signal aandb : std_logic;
signal candaxorb : std_logic;

begin

  axorb <= a xor b after PD_XOR2;
  r <= cin xor axorb after PD_XOR2;

  aandb <= a and b after PD_AND2;
  candaxorb <= cin and axorb after PD_AND2;
  cout <= aandb or candaxorb after PD_OR2;

end;
