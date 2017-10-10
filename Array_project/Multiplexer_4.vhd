library ieee;
use ieee.std_logic_1164.ALL;

entity Multiplexer_4 is
  port(
		A,B,C,D	: in std_logic_vector (7 downto 0);
		sel	: in std_logic_vector(1 downto 0);
		result	: out std_logic_vector (7 downto 0)
	);
end Multiplexer_4;

architecture mux of Multiplexer_4 is
begin
  process(sel,A,B,C,D)
  begin
    if (sel = "00") then
      result <= A;
    elsif (sel = "01") then
      result <= B;
    elsif (sel = "10") then
      result <= C;
    else
      result <= D;
    end if;
  end process;
end mux;
