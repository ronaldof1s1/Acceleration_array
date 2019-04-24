library ieee;
use ieee.std_logic_1164.ALL;
use IEEE.numeric_std.all;

use work.data.all;

entity Multiplexer_32 is
  port(
    input_reg: in reg_bank;
		sel	: in selector5;
		result	: out data
	);
end Multiplexer_32;

architecture mux_32 of Multiplexer_32 is
begin
  process(sel,input_reg)
  begin
    result <= input_reg(to_integer(unsigned(sel)));
  end process;
end mux_32;
