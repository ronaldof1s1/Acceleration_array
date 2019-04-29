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
        ram : in ram_t;
        data_o : out data;
        to_ram : out data
     );
end ram_access;

architecture Behavioral of ram_access is

begin
to_ram <= data_i;
data_o <= ram(to_integer(unsigned(address)));
end Behavioral;

--http://vhdlguru.blogspot.com.br/2011/01/block-and-distributed-rams-on-xilinx.html