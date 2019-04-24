library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package data is

constant bank_len : integer := 31;
constant data_len : integer := 31;
constant mem_len : integer := 255;
subtype data is std_logic_vector(data_len downto 0);
type ram_t is array (0 to mem_len) of data;
subtype operation is std_logic_vector(2 downto 0);
subtype selector2 is std_logic_vector(1 downto 0);
subtype selector5 is std_logic_vector(4 downto 0);
type reg_bank is array(0 to bank_len) of data;
end package data;