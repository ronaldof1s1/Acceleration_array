library ieee;
use ieee.std_logic_1164.ALL;

use work.data.all;

entity Multiplexer_4 is
  port(
		A,B,C,D	: in data;
		sel	: in selector2;
		result	: out data
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
