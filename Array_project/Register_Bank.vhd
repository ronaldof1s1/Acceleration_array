library ieee;
use ieee.std_logic_1164.ALL;

entity Register_Bank is
  port(
		in0, in1, in2, in3, in4, in5, in6, in7, 
    in8, in9, in10, in11, in12, in13, in14, in15, 
    in16, in17, in18, in19, in20, in21, in22, in23, 
    in24, in25, in26, in27, in28, in29, in30, in31 : in std_logic_vector (31 downto 0);
    clk: in std_logic;
    out0, out1, out2, out3, out4, out5, out6, out7, 
    out8, out9, out10, out11, out12, out13, out14, out15, 
    out16, out17, out18, out19, out20, out21, out22, out23, 
    out24, out25, out26, out27, out28, out29, out30, out31 : out std_logic_vector(31 downto 0)
	);
end Register_Bank;

architecture bank of Register_Bank is
  
  subtype data is std_logic_vector(31 downto 0);
  
  Component Generic_Register
    Port (
      input	: in data
  		clk	: in std_logic;
  		store	: in std_logic;
  		clr	: in std_logic;
  		output	: out data
    );
  end component;
  
  begin
     Reg0 : Generic_Register
      Port map(
        input => in0,
        clk => clk,
        store => '1',
        clr => '0',
        output => out0
      );
      Reg1 : Generic_Register
      Port map(
        input => in1,
        clk => clk,
        store => '1',
        clr => '0',
        output => out1
      );
      Reg2 : Generic_Register
      Port map(
        input => in2,
        clk => clk,
        store => '1',
        clr => '0',
        output => out2
      );
      Reg3 : Generic_Register
      Port map(
        input => in3,
        clk => clk,
        store => '1',
        clr => '0',
        output => out3
      );
      Reg4 : Generic_Register
      Port map(
        input => in4,
        clk => clk,
        store => '1',
        clr => '0',
        output => out4
      );
      Reg5 : Generic_Register
      Port map(
        input => in5,
        clk => clk,
        store => '1',
        clr => '0',
        output => out5
      );
      Reg6 : Generic_Register
      Port map(
        input => in6,
        clk => clk,
        store => '1',
        clr => '0',
        output => out6
      );
      Reg7 : Generic_Register
      Port map(
        input => in7,
        clk => clk,
        store => '1',
        clr => '0',
        output => out7
      );
      Reg8 : Generic_Register
      Port map(
        input => in8,
        clk => clk,
        store => '1',
        clr => '0',
        output => out8
      );
      Reg9 : Generic_Register
      Port map(
        input => in9,
        clk => clk,
        store => '1',
        clr => '0',
        output => out9
      );
      Reg10 : Generic_Register
      Port map(
        input => in10,
        clk => clk,
        store => '1',
        clr => '0',
        output => out10
      );
      Reg11 : Generic_Register
      Port map(
        input => in11,
        clk => clk,
        store => '1',
        clr => '0',
        output => out11
      );
      Reg12 : Generic_Register
      Port map(
        input => in12,
        clk => clk,
        store => '1',
        clr => '0',
        output => out12
      );
      Reg13 : Generic_Register
      Port map(
        input => in13,
        clk => clk,
        store => '1',
        clr => '0',
        output => out13
      );
      Reg14 : Generic_Register
      Port map(
        input => in14,
        clk => clk,
        store => '1',
        clr => '0',
        output => out14
      );
      Reg15 : Generic_Register
      Port map(
        input => in15,
        clk => clk,
        store => '1',
        clr => '0',
        output => out15
      );
      Reg16 : Generic_Register
      Port map(
        input => in16,
        clk => clk,
        store => '1',
        clr => '0',
        output => out16
      );
      Reg17 : Generic_Register
      Port map(
        input => in17,
        clk => clk,
        store => '1',
        clr => '0',
        output => out17
      );
      Reg18 : Generic_Register
      Port map(
        input => in18,
        clk => clk,
        store => '1',
        clr => '0',
        output => out18
      );
      Reg19 : Generic_Register
      Port map(
        input => in19
        clk => clk,
        store => '1',
        clr => '0',
        output => out19
      );
      Reg20 : Generic_Register
      Port map(
        input => in20,
        clk => clk,
        store => '1',
        clr => '0',
        output => out20
      );
      Reg21 : Generic_Register
      Port map(
        input => in21,
        clk => clk,
        store => '1',
        clr => '0',
        output => out21
      );
      Reg22 : Generic_Register
      Port map(
        input => in22,
        clk => clk,
        store => '1',
        clr => '0',
        output => out22
      );
      Reg23 : Generic_Register
      Port map(
        input => in23,
        clk => clk,
        store => '1',
        clr => '0',
        output => out23
      );
      Reg24 : Generic_Register
      Port map(
        input => in24,
        clk => clk,
        store => '1',
        clr => '0',
        output => out24
      );
      Reg25 : Generic_Register
      Port map(
        input => in25,
        clk => clk,
        store => '1',
        clr => '0',
        output => out25
      );
      Reg26 : Generic_Register
      Port map(
        input => in26,
        clk => clk,
        store => '1',
        clr => '0',
        output => out26
      );
      Reg27 : Generic_Register
      Port map(
        input => in27,
        clk => clk,
        store => '1',
        clr => '0',
        output => out27
      );
      Reg28 : Generic_Register
      Port map(
        input => in28,
        clk => clk,
        store => '1',
        clr => '0',
        output => out28
      );
      Reg29 : Generic_Register
      Port map(
        input => in29,
        clk => clk,
        store => '1',
        clr => '0',
        output => out29
      );
      Reg30 : Generic_Register
      Port map(
        input => in30,
        clk => clk,
        store => '1',
        clr => '0',
        output => out30
      );
      Reg31 : Generic_Register
      Port map(
        input => in31,
        clk => clk,
        store => '1',
        clr => '0',
        output => out31
      );
end bank;
