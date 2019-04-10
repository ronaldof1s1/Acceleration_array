library ieee;
use ieee.std_logic_1164.ALL;

package data is

constant data_len : integer := 32;
constant mem_len : integer := 256;
subtype data is std_logic_vector(data_len-1 downto 0);
type ram_t is array ((mem_len-1) downto 0) of data;
subtype operation is std_logic_vector(2 downto 0);
subtype selector2 is std_logic_vector(1 downto 0);
subtype selector5 is std_logic_vector(4 downto 0);

end package data;