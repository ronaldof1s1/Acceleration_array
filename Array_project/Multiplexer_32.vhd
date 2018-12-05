library ieee;
use ieee.std_logic_1164.ALL;

entity Multiplexer_32 is
  port(
        in0, in1, in2, in3, in4, in5, in6, in7, 
        in8, in9, in10, in11, in12, in13, in14, in15, 
        in16, in17, in18, in19, in20, in21, in22, in23, 
        in24, in25, in26, in27, in28, in29, in30, in31	: in std_logic_vector (31 downto 0);
		sel	: in std_logic_vector(4 downto 0);
		result	: out std_logic_vector (31 downto 0)
	);
end Multiplexer_32;

architecture mux of Multiplexer_32 is
begin
  process(sel)
  begin
    if (sel = "00000") then
      result <= in0;
    elsif (sel = "00001") then
      result <= in1;
    elsif (sel = "00010") then
      result <= in2; 
    elsif (sel = "00011") then
      result <= in3;
    elsif (sel = "00100") then
      result <= in4;      
    elsif (sel = "00101") then
      result <= in5;
    elsif (sel = "00110") then
      result <= in6;      
    elsif (sel = "00111") then
      result <= in7;
    elsif (sel = "01000") then
      result <= in8;    
    elsif (sel = "01001") then
      result <= in9;
    elsif (sel = "01010") then
      result <= in10;      
    elsif (sel = "01011") then
      result <= in11;
    elsif (sel = "01100") then
      result <= in12;      
    elsif (sel = "01101") then
      result <= in13;
    elsif (sel = "01110") then
      result <= in14;      
    elsif (sel = "01111") then
      result <= in15;
    elsif (sel = "10000") then
      result <= in16;      
    elsif (sel = "10001") then
      result <= in17;
    elsif (sel = "10010") then
      result <= in18;      
    elsif (sel = "10011") then
      result <= in19;
    elsif (sel = "10100") then
      result <= in20;      
    elsif (sel = "10101") then
      result <= in21;
    elsif (sel = "10110") then
      result <= in22;      
    elsif (sel = "10111") then
      result <= in23;
    elsif (sel = "11000") then
      result <= in24;      
    elsif (sel = "11001") then
      result <= in25;
    elsif (sel = "11010") then
      result <= in26;      
    elsif (sel = "11011") then
      result <= in27;
    elsif (sel = "11100") then
      result <= in28;      
    elsif (sel = "11101") then
      result <= in29;
    elsif (sel = "11110") then
      result <= in30;
    else
      result <= in31;
    end if;
  end process;
end mux;
