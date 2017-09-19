library ieee;
use ieee.std_logic_1164.ALL;

entity Register_Bank is
  Generic (bits: integer);
	port(
		input_1, input_2, input_3 : in std_logic_vector (bits-1 downto 0);
    clk: in std_logic;
    store_1, store_2, store_3: in std_logic;
    clr_1, clr_2, clr_3 : in std_logic;
    output_1, output_2, output_3 : out std_logic_vector(bits-1 downto 0)
	);
end Register_Bank;

architecture bank of Register_Bank is
  Component Generic_Register
    Generic (N : integer);
    Port (
      input	: in std_logic_vector (N-1 downto 0);
  		clk	: in std_logic;
  		store	: in std_logic;
  		clr	: in std_logic;
  		output	: out std_logic_vector (N-1 downto 0)
    );
  end component;
  begin
    Reg_1 : Generic_Register
      Generic map (N => bits)
      Port map(
        input => input_1,
        clk => clk,
        store => store_1,
        clr => clr_1,
        output => output_1
      );
    Reg_2 : Generic_Register
      Generic map (N => bits)
      Port map(
        input => input_2,
        clk => clk,
        store => store_2,
        clr => clr_2,
        output => output_2
      );
    Reg_3 : Generic_Register
      Generic map (N => bits)
      Port map(
        input => input_3,
        clk => clk,
        store => store_3,
        clr => clr_3,
        output => output_3
      );
end bank;
