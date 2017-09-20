library ieee;
use ieee.std_logic_1164.ALL;

entity Multiplexer_3 is
  generic (N : integer);
	port(
		A,B,C	: in std_logic_vector (N-1 downto 0);
		sel	: in std_logic_vector(1 downto 0);
		result	: out std_logic_vector (N-1 downto 0)
	);
end Multiplexer_3;

architecture mux of Multiplexer_3 is
begin
  process(sel,A,B,C)
  begin
    if(sel = "00") then
      result <= A;
    elsif (sel = "01") then
      result <= B;
    else
      result <= C;
    end if;
  end process;
end mux;
