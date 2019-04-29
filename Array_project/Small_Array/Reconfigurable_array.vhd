library IEEE;
use ieee.std_logic_1164.ALL;
--use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;
use IEEE.numeric_std.all;


use work.data.all;

entity Reconfigurable_Array is
  port (
    bitstream : in std_logic_vector(409 downto 0);
    output : out std_logic
    );
end Reconfigurable_Array;

architecture Reconfigurable_Array of Reconfigurable_Array is

component Reconfigurable_Array_level is
	port (
            input_regs : in reg_bank;

            bitstream : in std_logic_vector(409 downto 0);
            
            clk : in std_logic;
        
            ram : in ram_t;
        
            ram_addr : out data;

            ram_we : out std_logic;

            ram_data : out data;

            output_regs : out reg_bank
		
	);
end component Reconfigurable_Array_level;

component Multiplexer_4 is
      port(
		A,B,C,D	: in data;
		sel	: in selector2;
		result	: out data
	);
end component Multiplexer_4;

signal clk : std_logic := '0';

signal first_bitstream : std_logic_vector(409 downto 0);
signal second_bitstream : std_logic_vector(409 downto 0);
signal third_bitstream : std_logic_vector(409 downto 0);

signal default_bitstream : std_logic_vector(409 downto 0) := (others => 'U');

signal ram_addr_1 : data := (others => '0');
signal ram_addr_2 : data := (others => '0');
signal ram_addr_3 : data := (others => '0');
signal ram_we_1 : std_logic;
signal ram_we_2 : std_logic;
signal ram_we_3 : std_logic;
signal ram_data_1 : data := (others => '0');
signal ram_data_2 : data := (others => '0');
signal ram_data_3 : data := (others => '0');

signal ram : ram_t := ((others=> (others=>'0')));

signal first_level_input : reg_bank := (
"00000000000000000000000000000000",
"00000000000000000000000000000001",
"00000000000000000000000000000010",
"00000000000000000000000000000011",
"00000000000000000000000000000100",
"00000000000000000000000000000101",
"00000000000000000000000000000110",
"00000000000000000000000000000111",
"00000000000000000000000000001000",
"00000000000000000000000000001001",
"00000000000000000000000000001010",
"00000000000000000000000000001011",
"00000000000000000000000000001100",
"00000000000000000000000000001101",
"00000000000000000000000000001110",
"00000000000000000000000000001111",
"00000000000000000000000000010000",
"00000000000000000000000000010001",
"00000000000000000000000000010010",
"00000000000000000000000000010011",
"00000000000000000000000000010100",
"00000000000000000000000000010101",
"00000000000000000000000000010110",
"00000000000000000000000000010111",
"00000000000000000000000000011000",
"00000000000000000000000000011001",
"00000000000000000000000000011010",
"00000000000000000000000000011011",
"00000000000000000000000000011100",
"00000000000000000000000000011101",
"00000000000000000000000000011110",
"00000000000000000000000000011111");

signal first_level_output : reg_bank := ((others=> (others=>'0')));

signal second_level_input : reg_bank := (
      "00000000000000000000000000000000",
      "00000000000000000000000000000001",
      "00000000000000000000000000000010",
      "00000000000000000000000000000011",
      "00000000000000000000000000000100",
      "00000000000000000000000000000101",
      "00000000000000000000000000000110",
      "00000000000000000000000000000111",
      "00000000000000000000000000001000",
      "00000000000000000000000000001001",
      "00000000000000000000000000001010",
      "00000000000000000000000000001011",
      "00000000000000000000000000001100",
      "00000000000000000000000000001101",
      "00000000000000000000000000001110",
      "00000000000000000000000000001111",
      "00000000000000000000000000010000",
      "00000000000000000000000000010001",
      "00000000000000000000000000010010",
      "00000000000000000000000000010011",
      "00000000000000000000000000010100",
      "00000000000000000000000000010101",
      "00000000000000000000000000010110",
      "00000000000000000000000000010111",
      "00000000000000000000000000011000",
      "00000000000000000000000000011001",
      "00000000000000000000000000011010",
      "00000000000000000000000000011011",
      "00000000000000000000000000011100",
      "00000000000000000000000000011101",
      "00000000000000000000000000011110",
      "00000000000000000000000000011111");

signal second_level_output : reg_bank := ((others=> (others=>'0')));

signal third_level_input : reg_bank := (
      "00000000000000000000000000000000",
      "00000000000000000000000000000001",
      "00000000000000000000000000000010",
      "00000000000000000000000000000011",
      "00000000000000000000000000000100",
      "00000000000000000000000000000101",
      "00000000000000000000000000000110",
      "00000000000000000000000000000111",
      "00000000000000000000000000001000",
      "00000000000000000000000000001001",
      "00000000000000000000000000001010",
      "00000000000000000000000000001011",
      "00000000000000000000000000001100",
      "00000000000000000000000000001101",
      "00000000000000000000000000001110",
      "00000000000000000000000000001111",
      "00000000000000000000000000010000",
      "00000000000000000000000000010001",
      "00000000000000000000000000010010",
      "00000000000000000000000000010011",
      "00000000000000000000000000010100",
      "00000000000000000000000000010101",
      "00000000000000000000000000010110",
      "00000000000000000000000000010111",
      "00000000000000000000000000011000",
      "00000000000000000000000000011001",
      "00000000000000000000000000011010",
      "00000000000000000000000000011011",
      "00000000000000000000000000011100",
      "00000000000000000000000000011101",
      "00000000000000000000000000011110",
      "00000000000000000000000000011111");

signal output_regs : reg_bank := ((others=> (others=>'0')));


constant clock_frequency : integer := 1e9;
constant clock_time : time := 1000 ms/clock_frequency;

begin
  clk <= not clk after clock_time/2;

first_level: Reconfigurable_Array_level
port map (
            input_regs=> first_level_input,

            bitstream => first_bitstream,

            clk => clk,

            ram => ram,

            ram_addr => ram_addr_1,

            ram_we => ram_we_1,

            ram_data => ram_data_1,

		output_regs=> first_level_output
);

second_level: Reconfigurable_Array_level
port map (
      input_regs=> second_level_input,

      bitstream => second_bitstream,

      clk => clk,

      ram => ram,

      ram_addr => ram_addr_2,

      ram_we => ram_we_2,

      ram_data => ram_data_2,

      output_regs=> second_level_output
);

third_level: Reconfigurable_Array_level
port map (
      input_regs=> third_level_input,

      bitstream => third_bitstream,

      clk => clk,

      ram => ram,

      ram_addr => ram_addr_3,

      ram_we => ram_we_3,

      ram_data => ram_data_3,

      output_regs=> output_regs
);    


process(clk)
variable counter : integer := 0;
variable int_addr : integer;
begin
if rising_edge(clk) then
      output <= output_regs(0)(0);

      if (counter = 0) then
     
            int_addr := to_integer(unsigned(ram_addr_3));
            first_level_input <= output_regs;

            first_bitstream <= bitstream;
            second_bitstream <= default_bitstream;
            third_bitstream <= default_bitstream;

            if (ram_we_3 = '1') then
                  ram(int_addr) <= ram_data_3;
            end if;
            
            counter := 1;
      elsif (counter = 1) then

            int_addr := to_integer(unsigned(ram_addr_1));
            second_level_input <= first_level_output;
            
            first_bitstream <= default_bitstream;
            second_bitstream <= bitstream;
            third_bitstream <= default_bitstream;

            if (ram_we_1 = '1') then
                  ram(int_addr) <= ram_data_1;
            end if;
            counter := 2;
      elsif(counter = 2) then

            int_addr := to_integer(unsigned(ram_addr_2));
            third_level_input <= second_level_output;
            first_bitstream <= default_bitstream;
            second_bitstream <= default_bitstream;
            third_bitstream <= bitstream;

            if (ram_we_2 = '1') then
                  ram(int_addr) <= ram_data_2;
            end if;

            counter := 0;
      end if;       

end if;
end process;
end architecture;
