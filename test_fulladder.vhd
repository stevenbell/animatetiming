library IEEE;
use IEEE.std_logic_1164.all;

entity test_fulladder is
end;

architecture sim of test_fulladder is

component fulladder is
  port (
    signal a   : in std_logic;
    signal b   : in std_logic;
    signal cin : in std_logic;
    signal r    : out std_logic;
    signal cout : out std_logic
  );
end component;

signal a   : std_logic;
signal b   : std_logic;
signal cin : std_logic;
signal r    : std_logic;
signal cout : std_logic;

begin

  fa0 : fulladder port map(a, b, cin, r, cout);

  process begin
    a <= '1';
    b <= '1';
    cin <= '1';

    wait for 200 ps; -- Should be long enough
    wait; -- Halt here
  end process;

end;


