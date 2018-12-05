library ieee;
use ieee.std_logic_1164.ALL;

entity Reconfigurable_Array_level is
  port (
    bitstream : in std_logic_vector(102 downto 0);
    clk : in std_logic;
    out0, out1, out2, out3, out4, out5, out6, out7, 
    out8, out9, out10, out11, out12, out13, out14, out15, 
    out16, out17, out18, out19, out20, out21, out22, out23, 
    out24, out25, out26, out27, out28, out29, out30, out31 : out std_logic_vector(31 downto 0)
  );
end Reconfigurable_Array_level;

architecture Reconfigurable_Array_level of Reconfigurable_Array_level is

  subtype data is std_logic_vector(31 downto 0);
  subtype operation is std_logic_vector(2 downto 0);
  subtype selector2 is std_logic_vector(1 downto 0);
  subtype selector5 is std_logic_vector(4 downto 0);
  subtype sel_stream is std_logic_vector(29 downto 0);
  subtype op_stream is std_logic_vector(8 downto 0);

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

  Component ALUs_line
    port(
    in0, in1, in2, in3, in4, in5, in6, in7, 
    in8, in9, in10, in11, in12, in13, in14, in15, 
    in16, in17, in18, in19, in20, in21, in22, in23, 
    in24, in25, in26, in27, in28, in29, in30, in31 : in data;
    sel_bitstream : in sel_stream;
    operation_bitstream : in op_stream;
    output_1, output_2, output_3 : out data
    );
  end component;

  Component Multiplier
    port(
      A, B : in  data;
      result: out data
    );
  end Component;

  Component Multiplexer_4
    port(
  		A,B,C,D	: in data;
  		sel	: in selector2;
  		result	: out data
  	);
  end Component;

  Component Multiplexer_32
    port(
          in0, in1, in2, in3, in4, in5, in6, in7, 
          in8, in9, in10, in11, in12, in13, in14, in15, 
          in16, in17, in18, in19, in20, in21, in22, in23, 
          in24, in25, in26, in27, in28, in29, in30, in31	: in data;
      sel	: in selector5;
      result	: out data
    );
  end Component;
  
  Component Multiplexer is
    port(
  		A,B	: in data;
  		sel	: in std_logic;
  		result	: out data
    );
  end Component;

  Component ram_access is
    port(
      Clk : in std_logic;
      address : in data;
      we : in std_logic;
      data_i : in data;
      data_o : out data
    );
  end Component;
  
 -- input muxes for the ALUs
  signal sel_stream_1 : sel_stream := bitstream(29 downto 0);
  signal sel_stream_2 : sel_stream := bitstream(59 downto 30);
  signal sel_stream_3 : sel_stream := bitstream(89 downto 60);

  --operations

  signal op_stream_1 : op_stream := bitstream(98 downto 90);
  signal op_stream_2 : op_stream := bitstream(107 downto 99);
  signal op_stream_3 : op_stream := bitstream(116 downto 108);
  
  -- first line output mux signals
  signal line_1_mux_sel_1 : selector2 := bitstream(39 downto 38);
  signal line_1_mux_sel_2 : selector2 := bitstream(37 downto 36);
  signal line_1_mux_sel_3 : selector2 := bitstream(35 downto 34);

  --first line of output signals
  signal output_1_1 : data;
  signal output_1_2 : data;
  signal output_1_3 : data;

  --first line of operations

  -- second line output mux signals
  signal line_2_mux_sel_1 : selector2 := bitstream(33 downto 32);
  signal line_2_mux_sel_2 : selector2 := bitstream(31 downto 30);
  signal line_2_mux_sel_3 : selector2 := bitstream(29 downto 28);

  --second line of output signals
  signal output_2_1 : data;
  signal output_2_2 : data;
  signal output_2_3 : data;

  --second line of operations

  --------------------THIRD LINE--------------------------
  
  -- third line output mux signals
  signal line_3_mux_sel_1 : selector2 := bitstream(27 downto 26);
  signal line_3_mux_sel_2 : selector2 := bitstream(25 downto 24);
  signal line_3_mux_sel_3 : selector2 := bitstream(23 downto 22);


  signal final_mux_sel_1 : selector2 := bitstream(21 downto 20);
  signal final_mux_sel_2 : selector2 := bitstream(19 downto 18);
  signal final_mux_sel_3 : selector2 := bitstream(17 downto 16);


  signal output_mux_1 : data;
  signal output_mux_2  : data;
  signal output_mux_3  : data;

  --third line of output signals
  signal output_3_1 : data;
  signal output_3_2 : data;
  signal output_3_3 : data;


  --------------------MULTIPLIER DATA--------------------------
  

  --Multiplier input muxes
  signal sel_mult_A : selector5 := bitstream(15 downto 14);
  signal sel_mult_B : selector5 := bitstream(13 downto 12);
  
  signal mult_in_A : data;
  signal mult_in_B : data;

  -- output of multiplier
  signal mult_output : data;

  -------------------MEMORY UNIT DATA---------------------------
  signal address :  data := bitstream(11 downto 4);
  signal write_enabled :  std_logic := bitstream(3);
  signal memory_out : data;

  signal sel_memory :  selector5 := bitstream(2 downto 1);
  signal memory_mux_out :  data;

  --------------------REGISTER BANK--------------------------

  --inputs of registers
signal Register_0_input_1 : data := "00000000000000000000000000000001";
signal Register_1_input_1 : data := "00000000000000000000000000000001";
signal Register_2_input_1 : data := "00000000000000000000000000000001";
signal Register_3_input_1 : data := "00000000000000000000000000000001";
signal Register_4_input_1 : data := "00000000000000000000000000000001";
signal Register_5_input_1 : data := "00000000000000000000000000000001";
signal Register_6_input_1 : data := "00000000000000000000000000000001";
signal Register_7_input_1 : data := "00000000000000000000000000000001";
signal Register_8_input_1 : data := "00000000000000000000000000000001";
signal Register_9_input_1 : data := "00000000000000000000000000000001";
signal Register_10_input_1 : data := "00000000000000000000000000000001";
signal Register_11_input_1 : data := "00000000000000000000000000000001";
signal Register_12_input_1 : data := "00000000000000000000000000000001";
signal Register_13_input_1 : data := "00000000000000000000000000000001";
signal Register_14_input_1 : data := "00000000000000000000000000000001";
signal Register_15_input_1 : data := "00000000000000000000000000000001";
signal Register_16_input_1 : data := "00000000000000000000000000000001";
signal Register_17_input_1 : data := "00000000000000000000000000000001";
signal Register_18_input_1 : data := "00000000000000000000000000000001";
signal Register_19_input_1 : data := "00000000000000000000000000000001";
signal Register_20_input_1 : data := "00000000000000000000000000000001";
signal Register_21_input_1 : data := "00000000000000000000000000000001";
signal Register_22_input_1 : data := "00000000000000000000000000000001";
signal Register_23_input_1 : data := "00000000000000000000000000000001";
signal Register_24_input_1 : data := "00000000000000000000000000000001";
signal Register_25_input_1 : data := "00000000000000000000000000000001";
signal Register_26_input_1 : data := "00000000000000000000000000000001";
signal Register_27_input_1 : data := "00000000000000000000000000000001";
signal Register_28_input_1 : data := "00000000000000000000000000000001";
signal Register_29_input_1 : data := "00000000000000000000000000000001";
signal Register_30_input_1 : data := "00000000000000000000000000000001";
signal Register_31_input_1 : data := "00000000000000000000000000000001";

signal Register_0_input_2 : data;
signal Register_1_input_2 : data;
signal Register_2_input_2 : data;
signal Register_3_input_2 : data;
signal Register_4_input_2 : data;
signal Register_5_input_2 : data;
signal Register_6_input_2 : data;
signal Register_7_input_2 : data;
signal Register_8_input_2 : data;
signal Register_9_input_2 : data;
signal Register_10_input_2 : data;
signal Register_11_input_2 : data;
signal Register_12_input_2 : data;
signal Register_13_input_2 : data;
signal Register_14_input_2 : data;
signal Register_15_input_2 : data;
signal Register_16_input_2 : data;
signal Register_17_input_2 : data;
signal Register_18_input_2 : data;
signal Register_19_input_2 : data;
signal Register_20_input_2 : data;
signal Register_21_input_2 : data;
signal Register_22_input_2 : data;
signal Register_23_input_2 : data;
signal Register_24_input_2 : data;
signal Register_25_input_2 : data;
signal Register_26_input_2 : data;
signal Register_27_input_2 : data;
signal Register_28_input_2 : data;
signal Register_29_input_2 : data;
signal Register_30_input_2 : data;
signal Register_31_input_2 : data;

signal Register_0_input_3 : data;
signal Register_1_input_3 : data;
signal Register_2_input_3 : data;
signal Register_3_input_3 : data;
signal Register_4_input_3 : data;
signal Register_5_input_3 : data;
signal Register_6_input_3 : data;
signal Register_7_input_3 : data;
signal Register_8_input_3 : data;
signal Register_9_input_3 : data;
signal Register_10_input_3 : data;
signal Register_11_input_3 : data;
signal Register_12_input_3 : data;
signal Register_13_input_3 : data;
signal Register_14_input_3 : data;
signal Register_15_input_3 : data;
signal Register_16_input_3 : data;
signal Register_17_input_3 : data;
signal Register_18_input_3 : data;
signal Register_19_input_3 : data;
signal Register_20_input_3 : data;
signal Register_21_input_3 : data;
signal Register_22_input_3 : data;
signal Register_23_input_3 : data;
signal Register_24_input_3 : data;
signal Register_25_input_3 : data;
signal Register_26_input_3 : data;
signal Register_27_input_3 : data;
signal Register_28_input_3 : data;
signal Register_29_input_3 : data;
signal Register_30_input_3 : data;
signal Register_31_input_3 : data;

signal Register_final_input_0 : data;
signal Register_final_input_1 : data;
signal Register_final_input_2 : data;
signal Register_final_input_3 : data;
signal Register_final_input_4 : data;
signal Register_final_input_5 : data;
signal Register_final_input_6 : data;
signal Register_final_input_7 : data;
signal Register_final_input_8 : data;
signal Register_final_input_9 : data;
signal Register_final_input_10 : data;
signal Register_final_input_11 : data;
signal Register_final_input_12 : data;
signal Register_final_input_13 : data;
signal Register_final_input_14 : data;
signal Register_final_input_15 : data;
signal Register_final_input_16 : data;
signal Register_final_input_17 : data;
signal Register_final_input_18 : data;
signal Register_final_input_19 : data;
signal Register_final_input_20 : data;
signal Register_final_input_21 : data;
signal Register_final_input_22 : data;
signal Register_final_input_23 : data;
signal Register_final_input_24 : data;
signal Register_final_input_25 : data;
signal Register_final_input_26 : data;
signal Register_final_input_27 : data;
signal Register_final_input_28 : data;
signal Register_final_input_29 : data;
signal Register_final_input_30 : data;
signal Register_final_input_31 : data;
  
  --OUTPUTS of registerssignal Register_0_output : data;
signal Register_1_output : data;
signal Register_2_output : data;
signal Register_3_output : data;
signal Register_4_output : data;
signal Register_5_output : data;
signal Register_6_output : data;
signal Register_7_output : data;
signal Register_8_output : data;
signal Register_9_output : data;
signal Register_10_output : data;
signal Register_11_output : data;
signal Register_12_output : data;
signal Register_13_output : data;
signal Register_14_output : data;
signal Register_15_output : data;
signal Register_16_output : data;
signal Register_17_output : data;
signal Register_18_output : data;
signal Register_19_output : data;
signal Register_20_output : data;
signal Register_21_output : data;
signal Register_22_output : data;
signal Register_23_output : data;
signal Register_24_output : data;
signal Register_25_output : data;
signal Register_26_output : data;
signal Register_27_output : data;
signal Register_28_output : data;
signal Register_29_output : data;
signal Register_30_output : data;
signal Register_31_output : data;
begin
  --instantiate multiplier
  Mult_mux_A : Multiplexer_32
  port map (in0 => Register_0_input_1,
            in1 => Register_1_input_1,
            in2 => Register_2_input_1,
            in3 => Register_3_input_1,
            in4 => Register_4_input_1,
            in5 => Register_5_input_1,
            in6 => Register_6_input_1,
            in7 => Register_7_input_1,
            in8 => Register_8_input_1,
            in9 => Register_9_input_1,
            in10 => Register_10_input_1,
            in11 => Register_11_input_1,
            in12 => Register_12_input_1,
            in13 => Register_13_input_1,
            in14 => Register_14_input_1,
            in15 => Register_15_input_1,
            in16 => Register_16_input_1,
            in17 => Register_17_input_1,
            in18 => Register_18_input_1,
            in19 => Register_19_input_1,
            in20 => Register_20_input_1,
            in21 => Register_21_input_1,
            in22 => Register_22_input_1,
            in23 => Register_23_input_1,
            in24 => Register_24_input_1,
            in25 => Register_25_input_1,
            in26 => Register_26_input_1,
            in27 => Register_27_input_1,
            in28 => Register_28_input_1,
            in29 => Register_29_input_1,
            in30 => Register_30_input_1,
            in31 => Register_31_input_1,
            sel => sel_mult_A,
            result => mult_in_A);

  Mult_mux_B : Multiplexer_32
  port map (in0 => Register_0_input_1,
            in1 => Register_1_input_1,
            in2 => Register_2_input_1,
            in3 => Register_3_input_1,
            in4 => Register_4_input_1,
            in5 => Register_5_input_1,
            in6 => Register_6_input_1,
            in7 => Register_7_input_1,
            in8 => Register_8_input_1,
            in9 => Register_9_input_1,
            in10 => Register_10_input_1,
            in11 => Register_11_input_1,
            in12 => Register_12_input_1,
            in13 => Register_13_input_1,
            in14 => Register_14_input_1,
            in15 => Register_15_input_1,
            in16 => Register_16_input_1,
            in17 => Register_17_input_1,
            in18 => Register_18_input_1,
            in19 => Register_19_input_1,
            in20 => Register_20_input_1,
            in21 => Register_21_input_1,
            in22 => Register_22_input_1,
            in23 => Register_23_input_1,
            in24 => Register_24_input_1,
            in25 => Register_25_input_1,
            in26 => Register_26_input_1,
            in27 => Register_27_input_1,
            in28 => Register_28_input_1,
            in29 => Register_29_input_1,
            in30 => Register_30_input_1,
            in31 => Register_31_input_1,
            sel => sel_mult_B,
            result => mult_in_B);

  Mult : Multiplier
    Port Map (A => mult_in_A,
              B => mult_in_B,
              result => mult_output
              );

  --instantiate memory access unit

  RAM_mux: Multiplexer_4
    Port Map (A => Register_1_input_1,
              B => Register_2_input_1,
              C => Register_3_input_1,
              D => "00000000000000000000000000000000",
              sel => sel_memory,
              result => memory_mux_out
              );
  RAM : ram_access
    Port Map(Clk => clk,
            address =>address,
            we => write_enabled,
            data_i => memory_mux_out,
            data_o => memory_out

    );

  --------------------FIRST LINE--------------------------

  -- instantiate first line of ALUs
  line_1 : ALUs_line
    Port Map (input_1 => Register_1_input_1,
              input_2 => Register_2_input_1,
              input_3 => Register_3_input_1,
              sel_1_A => sel_1_1_A,
              sel_1_B => sel_1_1_B,
              sel_2_A => sel_1_2_A,
              sel_2_B => sel_1_2_B,
              sel_3_A => sel_1_3_A,
              sel_3_B => sel_1_3_B,
              op_1 => op_1_1,
              op_2 => op_1_2,
              op_3 => op_1_3,
              output_1 => output_1_1,
              output_2 => output_1_2,
              output_3 => output_1_3 );

  --instantiate first line multiplexers

  line_1_mux_1: Multiplexer_4
    Port Map (A => output_1_1,
              B => output_1_2,
              C => output_1_3,
              D => Register_1_input_1,
              sel => line_1_mux_sel_1,
              result => Register_1_input_2);
  line_1_mux_2: Multiplexer_4
    Port Map (A => output_1_1,
              B => output_1_2,
              C => output_1_3,
              D => Register_2_input_1,
              sel => line_1_mux_sel_2,
              result => Register_2_input_2);
  line_1_mux_3: Multiplexer_4
    Port Map (A => output_1_1,
              B => output_1_2,
              C => output_1_3,
              D => Register_3_input_1,
              sel => line_1_mux_sel_3,
              result => Register_3_input_2);

  --------------------SECOND LINE--------------------------

  --instantiate second line of ALUs
  line_2 : ALUs_line
    Port Map (input_1 => Register_1_input_2,
              input_2 => Register_2_input_2,
              input_3 => Register_3_input_2,
              sel_1_A => sel_2_1_A,
              sel_1_B => sel_2_1_B,
              sel_2_A => sel_2_2_A,
              sel_2_B => sel_2_2_B,
              sel_3_A => sel_2_3_A,
              sel_3_B => sel_2_3_B,
              op_1 => op_2_1,
              op_2 => op_2_2,
              op_3 => op_2_3,
              output_1 => output_2_1,
              output_2 => output_2_2,
              output_3 => output_2_3 );

  --instantiate second line multiplexer

  line_2_mux_1: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_1_input_2,
              sel => line_2_mux_sel_1,
              result => Register_1_input_3);
  line_2_mux_2: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_2_input_2,
              sel => line_2_mux_sel_2,
              result => Register_2_input_3);
  line_2_mux_3: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_3_input_2,
              sel => line_2_mux_sel_3,
              result => Register_3_input_3);



  --------------------THIRD LINE--------------------------

  --instantiate third line of ALUs
  line_3 : ALUs_line
    Port Map (input_1 => Register_1_input_3,
              input_2 => Register_2_input_3,
              input_3 => Register_3_input_3,
              sel_1_A => sel_3_1_A,
              sel_1_B => sel_3_1_B,
              sel_2_A => sel_3_2_A,
              sel_2_B => sel_3_2_B,
              sel_3_A => sel_3_3_A,
              sel_3_B => sel_3_3_B,
              op_1 => op_3_1,
              op_2 => op_3_2,
              op_3 => op_3_3,
              output_1 => output_3_1,
              output_2 => output_3_2,
              output_3 => output_3_3 );

  --instantiate third line multiplexer
  
  line_3_mux_1: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_1_input_3,
              sel => line_3_mux_sel_1,
              result => output_mux_1);
  line_3_mux_2: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_2_input_3,
              sel => line_3_mux_sel_2,
              result => output_mux_2);
  line_3_mux_3: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => Register_3_input_3,
              sel => line_3_mux_sel_3,
              result => output_mux_3);

  mult_ALU_mux_1: Multiplexer_4
    Port Map (A => mult_output,
              B => memory_out,
              C => output_mux_1,
              D => Register_1_input_3,
              sel => final_mux_sel_1,
              result => Register_final_input_1
            );
  mult_ALU_mux_2: Multiplexer_4
      Port Map (A => mult_output,
                B => memory_out,
                C => output_mux_2,
                D => Register_2_input_3,
                sel => final_mux_sel_2,
                result => Register_final_input_2
                );
  mult_ALU_mux_3: Multiplexer_4
      Port Map (A => mult_output,
                B => memory_out,
                C => output_mux_3,
                D => Register_3_input_3,
                sel => final_mux_sel_3,
                result => Register_final_input_3
              );


  
--------------------REGISTER BANK--------------------------

  BANK : Register_Bank
  Port Map( input_1 => Register_final_input_1,
            input_2 => Register_final_input_2,
            input_3 => Register_final_input_3,
            clk => clk,
            store_1 => Register_1_store,
            store_2 => Register_2_store,
            store_3 => Register_3_store,
            clr_1 => Register_1_clr,
            clr_2 => Register_2_clr,
            clr_3 => Register_3_clr,
            output_1 => Register_1_output,
            output_2 => Register_2_output,
            output_3 => Register_3_output
          );

  result_1 <= Register_1_output;
  result_2 <= Register_2_output;
  result_3 <= Register_3_output;
end architecture;
