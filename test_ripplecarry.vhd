library IEEE;
use IEEE.std_logic_1164.all;

entity test_ripplecarry is
end;

architecture sim of test_ripplecarry is

component fulladder is
  port (
    signal a   : in std_logic;
    signal b   : in std_logic;
    signal cin : in std_logic;
    signal r    : out std_logic;
    signal cout : out std_logic
  );
end component;

signal a   : std_logic_vector(7 downto 0);
signal b   : std_logic_vector(7 downto 0);
signal cin : std_logic; -- Carry into the whole thing

signal r    : std_logic_vector(7 downto 0);
signal cout : std_logic_vector(7 downto 0); -- Carry out of each place

begin

  fa0 : fulladder port map(a(0), b(0), cin, r(0), cout(0));
  fa1 : fulladder port map(a(1), b(1), cout(0), r(1), cout(1));
  fa2 : fulladder port map(a(2), b(2), cout(1), r(2), cout(2));
  fa3 : fulladder port map(a(3), b(3), cout(2), r(3), cout(3));
  fa4 : fulladder port map(a(4), b(4), cout(3), r(4), cout(4));
  fa5 : fulladder port map(a(5), b(5), cout(4), r(5), cout(5));
  fa6 : fulladder port map(a(6), b(6), cout(5), r(6), cout(6));
  fa7 : fulladder port map(a(7), b(7), cout(6), r(7), cout(7));

  process begin
    a <= "11111111";
    b <= "00000000";
    cin <= '1';

    wait for 700 ps; -- Should be long enough
    wait; -- Halt here
  end process;

end;


