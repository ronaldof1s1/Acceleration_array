library ieee;
use ieee.std_logic_1164.ALL;

entity Multiplexer is
  port(
		A,B	: in std_logic_vector (7 downto 0);
		sel	: in std_logic;
		result	: out std_logic_vector (7 downto 0)
	);
end Multiplexer;

architecture mux of Multiplexer is
begin
  process(sel,A,B)
  begin
    if(sel = '0') then
      result <= A;
    else
      result <= B;
    end if;
  end process;
end mux;
