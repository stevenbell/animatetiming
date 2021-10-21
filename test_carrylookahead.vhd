-- Ripple-carry takes 620ps
-- This takes 410ps

library IEEE;
use IEEE.std_logic_1164.all;

entity test_carrylookahead is
end;

architecture sim of test_carrylookahead is

component prop2 is
  port (
    signal a   : in std_logic_vector(1 downto 0);
    signal b   : in std_logic_vector(1 downto 0);
    signal cin : in std_logic;
    signal r    : out std_logic_vector(1 downto 0);
    signal cout : out std_logic
  );
end component;

signal a   : std_logic_vector(7 downto 0);
signal b   : std_logic_vector(7 downto 0);
signal cin : std_logic; -- Carry into the whole thing

signal r    : std_logic_vector(7 downto 0);
signal carry : std_logic_vector(3 downto 0); -- Carry out of each block

begin

  b0 : prop2 port map(a(1 downto 0), b(1 downto 0), cin, r(1 downto 0), carry(0));
  b1 : prop2 port map(a(3 downto 2), b(3 downto 2), carry(0), r(3 downto 2), carry(1));
  b2 : prop2 port map(a(5 downto 4), b(5 downto 4), carry(1), r(5 downto 4), carry(2));
  b3 : prop2 port map(a(7 downto 6), b(7 downto 6), carry(2), r(7 downto 6), carry(3));

  process begin
    a <= "11111111";
    b <= "00000000";
    cin <= '1';

    wait for 700 ps; -- Should be long enough
    wait; -- Halt here
  end process;

end;


