library IEEE;
use IEEE.std_logic_1164.all;

entity andsim is
begin

end;

architecture sim of andsim is
signal a : std_logic;
signal b : std_logic;
signal y : std_logic;

begin

process begin
  a <= '0';
  b <= '1';

  wait for 5 ns;
  y <= a and b;
  --y <= a and b after 5 ns; -- a and b don't have a value at t=0!

  wait for 5 ns;

  report "Value of y is " & to_string(y);

  wait;
end process;

end;
