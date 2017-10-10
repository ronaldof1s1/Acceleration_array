library ieee;
use ieee.std_logic_1164.ALL;

entity Generic_Register is
  port(
		input	: in std_logic_vector (7 downto 0);
		clk	: in std_logic;
		store	: in std_logic;
		clr	: in std_logic;
		output	: out std_logic_vector (7 downto 0)
	);
end Generic_Register;

architecture reg of Generic_Register is
	signal in_buffer	: std_logic_vector(7 downto 0);
begin
	in_buffer <= input;

	process(clk, clr)
	begin
    if clr = '1' then
      output <= "00000000";
    elsif rising_edge(clk) and clr = '0' then
		  if store = '1' then
			  output <= in_buffer;
			end if;
		end if;
	end process;
end reg;
