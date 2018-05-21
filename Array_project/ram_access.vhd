library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ram_access is
port (  
        Clk : in std_logic;
        address : in std_logic_vector(7 downto 0);
        we : in std_logic;
        data_i : in std_logic_vector(7 downto 0);
        data_o : out std_logic_vector(7 downto 0)
     );
end ram_access;

architecture Behavioral of ram_access is

--Declaration of type and signal of a 256 element RAM
--with each element being 8 bit wide.
type ram_t is array (0 to 255) of std_logic_vector(7 downto 0);
signal ram : ram_t := (others => (others => '0'));

begin

--process for read and write operation.
PROCESS(Clk)
BEGIN
    if(rising_edge(Clk)) then
        if(we='1') then
            ram(address) <= data_i;
        end if;
        data_o <= ram(address);
    end if; 
END PROCESS;

end Behavioral;

--http://vhdlguru.blogspot.com.br/2011/01/block-and-distributed-rams-on-xilinx.html