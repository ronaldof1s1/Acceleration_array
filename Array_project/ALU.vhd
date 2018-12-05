library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity ALU is
  port(
    A : in  std_logic_vector(31 downto 0);
    B : in  std_logic_vector(31 downto 0);
    operation : in  std_logic_vector(2 downto 0);
    result  : out std_logic_vector(31 downto 0)
  );
end ALU;

architecture ALU of ALU is
begin
  process(A, B, operation)
  begin
    case operation is

      when "000" =>
        result <= A + B;

      when "001" =>
        result <= A - B;                  -- subtraction

      when "010" =>
        result <= A and B;                -- and

      when "011" =>
        result <= A or B;                 -- or

      when "100" =>
        result <= A xor B;                -- xor

      when "101" =>
        result <= not A;                  -- not A

      when "110" =>
        result <= not B;                  -- not B
      when others =>
        result <= A;
    end case;
  end process;
end architecture;
