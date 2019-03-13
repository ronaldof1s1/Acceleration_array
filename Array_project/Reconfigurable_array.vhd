library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

entity Reconfigurable_Array is
  port (
    bitstream : in std_logic_vector(1277 downto 0);
    clk : in std_logic;
    out0, out1, out2, out3, out4, out5, out6, out7, 
    out8, out9, out10, out11, out12, out13, out14, out15, 
    out16, out17, out18, out19, out20, out21, out22, out23, 
    out24, out25, out26, out27, out28, out29, out30, out31 : out std_logic_vector(31 downto 0)
  );
end Reconfigurable_Array;

architecture Reconfigurable_Array of Reconfigurable_Array is

subtype data is std_logic_vector(31 downto 0);

component Reconfigurable_Array_level is
	port (
	in0, in1, in2, in3, in4, in5, in6, in7, 
    in8, in9, in10, in11, in12, in13, in14, in15, 
    in16, in17, in18, in19, in20, in21, in22, in23, 
    in24, in25, in26, in27, in28, in29, in30, in31 : in data;

    bitstream : in std_logic_vector(425 downto 0);
    
    clk : in std_logic;
    
    out0, out1, out2, out3, out4, out5, out6, out7, 
    out8, out9, out10, out11, out12, out13, out14, out15, 
    out16, out17, out18, out19, out20, out21, out22, out23, 
    out24, out25, out26, out27, out28, out29, out30, out31 : out data
		
	);
end component Reconfigurable_Array_level;

Component Register_Bank
    port(
  	  in0, in1, in2, in3, in4, in5, in6, in7, 
      in8, in9, in10, in11, in12, in13, in14, in15, 
      in16, in17, in18, in19, in20, in21, in22, in23, 
      in24, in25, in26, in27, in28, in29, in30, in31 : data;
      clk: in std_logic;
      out0, out1, out2, out3, out4, out5, out6, out7, 
      out8, out9, out10, out11, out12, out13, out14, out15, 
      out16, out17, out18, out19, out20, out21, out22, out23, 
      out24, out25, out26, out27, out28, out29, out30, out31 : out data
  	);
  end Component;

signal first_level_input_00 : data;
signal first_level_input_01 : data;
signal first_level_input_02 : data;
signal first_level_input_03 : data;
signal first_level_input_04 : data;
signal first_level_input_05 : data;
signal first_level_input_06 : data;
signal first_level_input_07 : data;
signal first_level_input_08 : data;
signal first_level_input_09 : data;
signal first_level_input_10 : data;
signal first_level_input_11 : data;
signal first_level_input_12 : data;
signal first_level_input_13 : data;
signal first_level_input_14 : data;
signal first_level_input_15 : data;
signal first_level_input_16 : data;
signal first_level_input_17 : data;
signal first_level_input_18 : data;
signal first_level_input_19 : data;
signal first_level_input_20 : data;
signal first_level_input_21 : data;
signal first_level_input_22 : data;
signal first_level_input_23 : data;
signal first_level_input_24 : data;
signal first_level_input_25 : data;
signal first_level_input_26 : data;
signal first_level_input_27 : data;
signal first_level_input_28 : data;
signal first_level_input_29 : data;
signal first_level_input_30 : data;
signal first_level_input_31 : data;

signal second_level_input_00 : data;
signal second_level_input_01 : data;
signal second_level_input_02 : data;
signal second_level_input_03 : data;
signal second_level_input_04 : data;
signal second_level_input_05 : data;
signal second_level_input_06 : data;
signal second_level_input_07 : data;
signal second_level_input_08 : data;
signal second_level_input_09 : data;
signal second_level_input_10 : data;
signal second_level_input_11 : data;
signal second_level_input_12 : data;
signal second_level_input_13 : data;
signal second_level_input_14 : data;
signal second_level_input_15 : data;
signal second_level_input_16 : data;
signal second_level_input_17 : data;
signal second_level_input_18 : data;
signal second_level_input_19 : data;
signal second_level_input_20 : data;
signal second_level_input_21 : data;
signal second_level_input_22 : data;
signal second_level_input_23 : data;
signal second_level_input_24 : data;
signal second_level_input_25 : data;
signal second_level_input_26 : data;
signal second_level_input_27 : data;
signal second_level_input_28 : data;
signal second_level_input_29 : data;
signal second_level_input_30 : data;
signal second_level_input_31 : data;

signal third_level_input_00 : data;
signal third_level_input_01 : data;
signal third_level_input_02 : data;
signal third_level_input_03 : data;
signal third_level_input_04 : data;
signal third_level_input_05 : data;
signal third_level_input_06 : data;
signal third_level_input_07 : data;
signal third_level_input_08 : data;
signal third_level_input_09 : data;
signal third_level_input_10 : data;
signal third_level_input_11 : data;
signal third_level_input_12 : data;
signal third_level_input_13 : data;
signal third_level_input_14 : data;
signal third_level_input_15 : data;
signal third_level_input_16 : data;
signal third_level_input_17 : data;
signal third_level_input_18 : data;
signal third_level_input_19 : data;
signal third_level_input_20 : data;
signal third_level_input_21 : data;
signal third_level_input_22 : data;
signal third_level_input_23 : data;
signal third_level_input_24 : data;
signal third_level_input_25 : data;
signal third_level_input_26 : data;
signal third_level_input_27 : data;
signal third_level_input_28 : data;
signal third_level_input_29 : data;
signal third_level_input_30 : data;
signal third_level_input_31 : data;

signal output_00 : data;
signal output_01 : data;
signal output_02 : data;
signal output_03 : data;
signal output_04 : data;
signal output_05 : data;
signal output_06 : data;
signal output_07 : data;
signal output_08 : data;
signal output_09 : data;
signal output_10 : data;
signal output_11 : data;
signal output_12 : data;
signal output_13 : data;
signal output_14 : data;
signal output_15 : data;
signal output_16 : data;
signal output_17 : data;
signal output_18 : data;
signal output_19 : data;
signal output_20 : data;
signal output_21 : data;
signal output_22 : data;
signal output_23 : data;
signal output_24 : data;
signal output_25 : data;
signal output_26 : data;
signal output_27 : data;
signal output_28 : data;
signal output_29 : data;
signal output_30 : data;
signal output_31 : data;


begin


first_level: Reconfigurable_Array_level
port map (
			in0 => first_level_input_00,
            in1 => first_level_input_01,
            in2 => first_level_input_02,
            in3 => first_level_input_03,
            in4 => first_level_input_04,
            in5 => first_level_input_05,
            in6 => first_level_input_06,
            in7 => first_level_input_07,
            in8 => first_level_input_08,
            in9 => first_level_input_09,
            in10 => first_level_input_10,
            in11 => first_level_input_11,
            in12 => first_level_input_12,
            in13 => first_level_input_13,
            in14 => first_level_input_14,
            in15 => first_level_input_15,
            in16 => first_level_input_16,
            in17 => first_level_input_17,
            in18 => first_level_input_18,
            in19 => first_level_input_19,
            in20 => first_level_input_20,
            in21 => first_level_input_21,
            in22 => first_level_input_22,
            in23 => first_level_input_23,
            in24 => first_level_input_24,
            in25 => first_level_input_25,
            in26 => first_level_input_26,
            in27 => first_level_input_27,
            in28 => first_level_input_28,
            in29 => first_level_input_29,
            in30 => first_level_input_30,
            in31 => first_level_input_31,

            bitstream => bitstream (425 downto 0),

            clk => clk,


		    out0 => second_level_input_00,
            out1 => second_level_input_01,
            out2 => second_level_input_02,
            out3 => second_level_input_03,
            out4 => second_level_input_04,
            out5 => second_level_input_05,
            out6 => second_level_input_06,
            out7 => second_level_input_07,
            out8 => second_level_input_08,
            out9 => second_level_input_09,
            out10 => second_level_input_10,
            out11 => second_level_input_11,
            out12 => second_level_input_12,
            out13 => second_level_input_13,
            out14 => second_level_input_14,
            out15 => second_level_input_15,
            out16 => second_level_input_16,
            out17 => second_level_input_17,
            out18 => second_level_input_18,
            out19 => second_level_input_19,
            out20 => second_level_input_20,
            out21 => second_level_input_21,
            out22 => second_level_input_22,
            out23 => second_level_input_23,
            out24 => second_level_input_24,
            out25 => second_level_input_25,
            out26 => second_level_input_26,
            out27 => second_level_input_27,
            out28 => second_level_input_28,
            out29 => second_level_input_29,
            out30 => second_level_input_30,
            out31 => second_level_input_31
);

second_level: Reconfigurable_Array_level
port map (
			in0 => second_level_input_00,
            in1 => second_level_input_01,
            in2 => second_level_input_02,
            in3 => second_level_input_03,
            in4 => second_level_input_04,
            in5 => second_level_input_05,
            in6 => second_level_input_06,
            in7 => second_level_input_07,
            in8 => second_level_input_08,
            in9 => second_level_input_09,
            in10 => second_level_input_10,
            in11 => second_level_input_11,
            in12 => second_level_input_12,
            in13 => second_level_input_13,
            in14 => second_level_input_14,
            in15 => second_level_input_15,
            in16 => second_level_input_16,
            in17 => second_level_input_17,
            in18 => second_level_input_18,
            in19 => second_level_input_19,
            in20 => second_level_input_20,
            in21 => second_level_input_21,
            in22 => second_level_input_22,
            in23 => second_level_input_23,
            in24 => second_level_input_24,
            in25 => second_level_input_25,
            in26 => second_level_input_26,
            in27 => second_level_input_27,
            in28 => second_level_input_28,
            in29 => second_level_input_29,
            in30 => second_level_input_30,
            in31 => second_level_input_31,

            bitstream => bitstream (851 downto 426),

            clk => clk,


		    out0 => third_level_input_00,
            out1 => third_level_input_01,
            out2 => third_level_input_02,
            out3 => third_level_input_03,
            out4 => third_level_input_04,
            out5 => third_level_input_05,
            out6 => third_level_input_06,
            out7 => third_level_input_07,
            out8 => third_level_input_08,
            out9 => third_level_input_09,
            out10 => third_level_input_10,
            out11 => third_level_input_11,
            out12 => third_level_input_12,
            out13 => third_level_input_13,
            out14 => third_level_input_14,
            out15 => third_level_input_15,
            out16 => third_level_input_16,
            out17 => third_level_input_17,
            out18 => third_level_input_18,
            out19 => third_level_input_19,
            out20 => third_level_input_20,
            out21 => third_level_input_21,
            out22 => third_level_input_22,
            out23 => third_level_input_23,
            out24 => third_level_input_24,
            out25 => third_level_input_25,
            out26 => third_level_input_26,
            out27 => third_level_input_27,
            out28 => third_level_input_28,
            out29 => third_level_input_29,
            out30 => third_level_input_30,
            out31 => third_level_input_31
);

third_level: Reconfigurable_Array_level
port map (
			in0 => third_level_input_00,
            in1 => third_level_input_01,
            in2 => third_level_input_02,
            in3 => third_level_input_03,
            in4 => third_level_input_04,
            in5 => third_level_input_05,
            in6 => third_level_input_06,
            in7 => third_level_input_07,
            in8 => third_level_input_08,
            in9 => third_level_input_09,
            in10 => third_level_input_10,
            in11 => third_level_input_11,
            in12 => third_level_input_12,
            in13 => third_level_input_13,
            in14 => third_level_input_14,
            in15 => third_level_input_15,
            in16 => third_level_input_16,
            in17 => third_level_input_17,
            in18 => third_level_input_18,
            in19 => third_level_input_19,
            in20 => third_level_input_20,
            in21 => third_level_input_21,
            in22 => third_level_input_22,
            in23 => third_level_input_23,
            in24 => third_level_input_24,
            in25 => third_level_input_25,
            in26 => third_level_input_26,
            in27 => third_level_input_27,
            in28 => third_level_input_28,
            in29 => third_level_input_29,
            in30 => third_level_input_30,
            in31 => third_level_input_31,

            bitstream => bitstream (1277 downto 852),

            clk => clk,


		    out0 => output_00,
            out1 => output_01,
            out2 => output_02,
            out3 => output_03,
            out4 => output_04,
            out5 => output_05,
            out6 => output_06,
            out7 => output_07,
            out8 => output_08,
            out9 => output_09,
            out10 => output_10,
            out11 => output_11,
            out12 => output_12,
            out13 => output_13,
            out14 => output_14,
            out15 => output_15,
            out16 => output_16,
            out17 => output_17,
            out18 => output_18,
            out19 => output_19,
            out20 => output_20,
            out21 => output_21,
            out22 => output_22,
            out23 => output_23,
            out24 => output_24,
            out25 => output_25,
            out26 => output_26,
            out27 => output_27,
            out28 => output_28,
            out29 => output_29,
            out30 => output_30,
            out31 => output_31
);

BANK : Register_Bank
  Port Map( in0 => output_00,
            in1 => output_01,
            in2 => output_02,
            in3 => output_03,
            in4 => output_04,
            in5 => output_05,
            in6 => output_06,
            in7 => output_07,
            in8 => output_08,
            in9 => output_09,
            in10 => output_10,
            in11 => output_11,
            in12 => output_12,
            in13 => output_13,
            in14 => output_14,
            in15 => output_15,
            in16 => output_16,
            in17 => output_17,
            in18 => output_18,
            in19 => output_19,
            in20 => output_20,
            in21 => output_21,
            in22 => output_22,
            in23 => output_23,
            in24 => output_24,
            in25 => output_25,
            in26 => output_26,
            in27 => output_27,
            in28 => output_28,
            in29 => output_29,
            in30 => output_30,
            in31 => output_31,

            clk => clk,

            out0 => first_level_input_00,
            out1 => first_level_input_01,
            out2 => first_level_input_02,
            out3 => first_level_input_03,
            out4 => first_level_input_04,
            out5 => first_level_input_05,
            out6 => first_level_input_06,
            out7 => first_level_input_07,
            out8 => first_level_input_08,
            out9 => first_level_input_09,
            out10 => first_level_input_10,
            out11 => first_level_input_11,
            out12 => first_level_input_12,
            out13 => first_level_input_13,
            out14 => first_level_input_14,
            out15 => first_level_input_15,
            out16 => first_level_input_16,
            out17 => first_level_input_17,
            out18 => first_level_input_18,
            out19 => first_level_input_19,
            out20 => first_level_input_20,
            out21 => first_level_input_21,
            out22 => first_level_input_22,
            out23 => first_level_input_23,
            out24 => first_level_input_24,
            out25 => first_level_input_25,
            out26 => first_level_input_26,
            out27 => first_level_input_27,
            out28 => first_level_input_28,
            out29 => first_level_input_29,
            out30 => first_level_input_30,
            out31 => first_level_input_31          
          );


end architecture;
