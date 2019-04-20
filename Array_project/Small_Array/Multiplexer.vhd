library ieee;
use ieee.std_logic_1164.ALL;

use work.data.all;
entity Multiplexer is
  port(
		A,B	: in data;
		sel	: in std_logic;
		result	: out data
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
