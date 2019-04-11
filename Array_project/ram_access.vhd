library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use work.data.all;

entity ram_access is
port (  
        Clk : in std_logic;
        address : in data;
        we : in std_logic;
        data_i : in data;
        ram_i : in ram_t;
        ram_o : out ram_t; 
        data_o : out data
     );
end ram_access;

architecture Behavioral of ram_access is

--Declaration of type and signal of a 256 element RAM
----with each element being 32 bit wide.
--type ram_t is array (0 to 255) of data;
--signal ram : ram_t := (others => (others => '0'));
signal int_addr : integer;

begin
int_addr <= to_integer(unsigned(address));
--process for read and write operation.
PROCESS(Clk)
BEGIN
    ram_o <= ram_i;
    if(rising_edge(Clk)) then
        if(we='1') then
            ram_o(int_addr) <= data_i;
        end if;
        data_o <= ram_i(int_addr);
    end if; 
END PROCESS;

end Behavioral;

--http://vhdlguru.blogspot.com.br/2011/01/block-and-distributed-rams-on-xilinx.html