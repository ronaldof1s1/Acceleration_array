library ieee;
use ieee.std_logic_1164.ALL;

use work.data.all;

entity ALUs_line is
  port(
  in0, in1, in2, in3, in4, in5, in6, in7, 
  in8, in9, in10, in11, in12, in13, in14, in15, 
  in16, in17, in18, in19, in20, in21, in22, in23, 
  in24, in25, in26, in27, in28, in29, in30, in31 : in data;
  sel_bitstream : in std_logic_vector(29 downto 0);
  operation_bitstream : in std_logic_vector(8 downto 0);
  output_1, output_2, output_3 : out data
  );
end entity;

architecture ALine of ALUs_line is

  Component ALU
    port(
      A : in  data;
      B : in  data;
      operation : in  operation;
      result  : out data
    );
  end Component;

  Component Multiplexer_32
    port(
      in0, in1, in2, in3, in4, in5, in6, in7, 
      in8, in9, in10, in11, in12, in13, in14, in15, 
      in16, in17, in18, in19, in20, in21, in22, in23, 
      in24, in25, in26, in27, in28, in29, in30, in31	: in data;
      sel	: selector5;
      result	: out data
    );
  end component;

  signal sel_1_A : selector5;
  signal sel_1_B : selector5;
  signal sel_2_A : selector5;
  signal sel_2_B : selector5;
  signal sel_3_A : selector5;
  signal sel_3_B : selector5;

  signal op_1 : operation;
  signal op_2 : operation;
  signal op_3 : operation;
  
  signal input_1_A : data;
  signal input_1_B : data;
  signal input_2_A : data;
  signal input_2_B : data;
  signal input_3_A : data;
  signal input_3_B : data;

begin
  sel_1_A  <= sel_bitstream(4 downto 0);
  sel_1_B  <= sel_bitstream(9 downto 5);
  sel_2_A  <= sel_bitstream(14 downto 10);
  sel_2_B  <= sel_bitstream(19 downto 15);
  sel_3_A  <= sel_bitstream(24 downto 20);
  sel_3_B  <= sel_bitstream(29 downto 25);

  op_1 <= operation_bitstream(2 downto 0);
  op_2 <= operation_bitstream(5 downto 3);
  op_3 <= operation_bitstream(8 downto 6);
  


Mux_1_A : Multiplexer_32
    port map (in0 => in0,
              in1 => in1,
              in2 => in2,
              in3 => in3,
              in4 => in4,
              in5 => in5,
              in6 => in6,
              in7 => in7,
              in8 => in8,
              in9 => in9,
              in10 => in10,
              in11 => in11,
              in12 => in12,
              in13 => in13,
              in14 => in14,
              in15 => in15,
              in16 => in16,
              in17 => in17,
              in18 => in18,
              in19 => in19,
              in20 => in20,
              in21 => in21,
              in22 => in22,
              in23 => in23,
              in24 => in24,
              in25 => in25,
              in26 => in26,
              in27 => in27,
              in28 => in28,
              in29 => in29,
              in30 => in30,
              in31 => in31,
              sel => sel_1_A,
              result => input_1_A);
Mux_1_B : Multiplexer_32
    port map (in0 => in0,
              in1 => in1,
              in2 => in2,
              in3 => in3,
              in4 => in4,
              in5 => in5,
              in6 => in6,
              in7 => in7,
              in8 => in8,
              in9 => in9,
              in10 => in10,
              in11 => in11,
              in12 => in12,
              in13 => in13,
              in14 => in14,
              in15 => in15,
              in16 => in16,
              in17 => in17,
              in18 => in18,
              in19 => in19,
              in20 => in20,
              in21 => in21,
              in22 => in22,
              in23 => in23,
              in24 => in24,
              in25 => in25,
              in26 => in26,
              in27 => in27,
              in28 => in28,
              in29 => in29,
              in30 => in30,
              in31 => in31,
              sel => sel_1_B,
              result => input_1_B);
Mux_2_A : Multiplexer_32
    port map (in0 => in0,
              in1 => in1,
              in2 => in2,
              in3 => in3,
              in4 => in4,
              in5 => in5,
              in6 => in6,
              in7 => in7,
              in8 => in8,
              in9 => in9,
              in10 => in10,
              in11 => in11,
              in12 => in12,
              in13 => in13,
              in14 => in14,
              in15 => in15,
              in16 => in16,
              in17 => in17,
              in18 => in18,
              in19 => in19,
              in20 => in20,
              in21 => in21,
              in22 => in22,
              in23 => in23,
              in24 => in24,
              in25 => in25,
              in26 => in26,
              in27 => in27,
              in28 => in28,
              in29 => in29,
              in30 => in30,
              in31 => in31,
              sel => sel_2_A,
              result => input_2_A);
Mux_2_B : Multiplexer_32
    port map (in0 => in0,
              in1 => in1,
              in2 => in2,
              in3 => in3,
              in4 => in4,
              in5 => in5,
              in6 => in6,
              in7 => in7,
              in8 => in8,
              in9 => in9,
              in10 => in10,
              in11 => in11,
              in12 => in12,
              in13 => in13,
              in14 => in14,
              in15 => in15,
              in16 => in16,
              in17 => in17,
              in18 => in18,
              in19 => in19,
              in20 => in20,
              in21 => in21,
              in22 => in22,
              in23 => in23,
              in24 => in24,
              in25 => in25,
              in26 => in26,
              in27 => in27,
              in28 => in28,
              in29 => in29,
              in30 => in30,
              in31 => in31,
              sel => sel_2_B,
              result => input_2_B);
Mux_3_A : Multiplexer_32
    port map (in0 => in0,
              in1 => in1,
              in2 => in2,
              in3 => in3,
              in4 => in4,
              in5 => in5,
              in6 => in6,
              in7 => in7,
              in8 => in8,
              in9 => in9,
              in10 => in10,
              in11 => in11,
              in12 => in12,
              in13 => in13,
              in14 => in14,
              in15 => in15,
              in16 => in16,
              in17 => in17,
              in18 => in18,
              in19 => in19,
              in20 => in20,
              in21 => in21,
              in22 => in22,
              in23 => in23,
              in24 => in24,
              in25 => in25,
              in26 => in26,
              in27 => in27,
              in28 => in28,
              in29 => in29,
              in30 => in30,
              in31 => in31,
              sel => sel_3_A,
              result => input_3_A);
Mux_3_B : Multiplexer_32
    port map (in0 => in0,
              in1 => in1,
              in2 => in2,
              in3 => in3,
              in4 => in4,
              in5 => in5,
              in6 => in6,
              in7 => in7,
              in8 => in8,
              in9 => in9,
              in10 => in10,
              in11 => in11,
              in12 => in12,
              in13 => in13,
              in14 => in14,
              in15 => in15,
              in16 => in16,
              in17 => in17,
              in18 => in18,
              in19 => in19,
              in20 => in20,
              in21 => in21,
              in22 => in22,
              in23 => in23,
              in24 => in24,
              in25 => in25,
              in26 => in26,
              in27 => in27,
              in28 => in28,
              in29 => in29,
              in30 => in30,
              in31 => in31,
              sel => sel_3_B,
              result => input_3_B);

ALU_1 : ALU
  port map (A => input_1_A,
            B => input_1_B,
            operation => op_1,
            result => output_1    );
ALU_2 : ALU
  port map (A => input_2_A,
            B => input_2_B,
            operation => op_2,
            result => output_2
  );
ALU_3 : ALU
  port map (A => input_3_A,
            B => input_3_B,
            operation => op_3,
            result => output_3
  );

end architecture;
