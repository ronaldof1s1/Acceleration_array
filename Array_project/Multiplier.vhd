library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity Multiplier is
  port(
    A, B : in  std_logic_vector(3 downto 0);
    result: out std_logic_vector(7 downto 0)
  );
end Multiplier;

architecture Multiplier of Multiplier is
  begin
    process(A,B)
    begin
      result <= A * B;
    end process;
end Multiplier;
