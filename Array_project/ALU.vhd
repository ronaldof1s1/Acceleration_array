library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity ALU is
  Generic (N : integer);
  port(
    A : in  std_logic_vector(N-1 downto 0);
    B : in  std_logic_vector(N-1 downto 0);
    control : in  std_logic_vector(2 downto 0);
    result  : out std_logic_vector(N-1 downto 0)
  );
end ALU;

architecture ALU of ALU is

  signal result_sum : std_logic_vector(N downto 0);
  signal carry : std_logic;

begin
  process(A, B, control)
  begin
    case control is

      when "000" =>
        -- result_sum <= ('0' & A) + ('0' & B);
        -- result <= result_sum(7 downto 0); -- sum
        -- carry <= result_sum(8);
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
