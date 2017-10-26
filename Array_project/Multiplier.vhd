library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity Multiplier is
  port(
    A, B : in  std_logic_vector(7 downto 0);
    result: out std_logic_vector(7 downto 0)
  );
end Multiplier;

architecture Multiplier of Multiplier is
  signal res : std_logic_vector(15 downto 0);
  begin
    res <= A * B;
    process(A,B,res)
    begin
      result <= res(15 downto 8);
    end process;
end Multiplier;
