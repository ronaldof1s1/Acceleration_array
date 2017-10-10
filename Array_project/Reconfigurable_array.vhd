library ieee;
use ieee.std_logic_1164.ALL;

entity Reconfigurable_Array is
  port (
    bitstream : in std_logic_vector(99 downto 0);
    clk : in std_logic
  );
end Reconfigurable_Array;

architecture Reconfigurable_Array of Reconfigurable_Array is

  Component Register_Bank
    port(
  		input_1, input_2, input_3 : in std_logic_vector (7 downto 0);
      clk: in std_logic;
      store_1, store_2, store_3: in std_logic;
      clr_1, clr_2, clr_3 : in std_logic;
      output_1, output_2, output_3 : out std_logic_vector(7 downto 0)
  	);
  end Component;

  Component ALUs_line
    port(
    input_1, input_2, input_3 : in std_logic_vector(7 downto 0);
    sel_mux_1_A, sel_mux_1_B : in std_logic_vector(1 downto 0);
    sel_mux_2_A, sel_mux_2_B : in std_logic_vector(1 downto 0);
    sel_mux_3_A, sel_mux_3_B : in std_logic_vector(1 downto 0);
    sel_end_mux_1, sel_end_mux_2, sel_end_mux_3 : in std_logic_vector(1 downto 0);
    op_1, op_2, op_3 : in std_logic_vector(2 downto 0);
    output_1, output_2, output_3 : out std_logic_vector (7 downto 0)
    );
  end component;

  Component Multiplier
    port(
      A, B : in  std_logic_vector(3 downto 0);
      result: out std_logic_vector(7 downto 0)
    );
  end Component;

  Component Multiplexer_4
    port(
  		A,B,C,D	: in std_logic_vector (7 downto 0);
  		sel	: in std_logic_vector(1 downto 0);
  		result	: out std_logic_vector (7 downto 0)
  	);
  end Component;

  Component Multiplexer is
    port(
  		A,B	: in std_logic_vector (7 downto 0);
  		sel	: in std_logic;
  		result	: out std_logic_vector (7 downto 0)
  	);
  end Component;

  --------------------FIRST LINE--------------------------
  -- first line of input muxss
  signal sel_mux_1_1_A : std_logic_vector(1 downto 0) := bitstream(1 downto 0);
  signal sel_mux_1_1_B : std_logic_vector(1 downto 0) := bitstream(3 downto 2);
  signal sel_mux_1_2_A : std_logic_vector(1 downto 0) := bitstream(5 downto 4);
  signal sel_mux_1_2_B : std_logic_vector(1 downto 0) := bitstream(7 downto 6);
  signal sel_mux_1_3_A : std_logic_vector(1 downto 0) := bitstream(9 downto 8);
  signal sel_mux_1_3_B : std_logic_vector(1 downto 0) := bitstream(11 downto 10);

  -- first line output mux signals
  signal line_1_mux_sel_1 : std_logic_vector(1 downto 0) := bitstream(13 downto 12);
  signal line_1_mux_sel_2 : std_logic_vector(1 downto 0) := bitstream(15 downto 14);
  signal line_1_mux_sel_3 : std_logic_vector(1 downto 0) := bitstream(17 downto 16);
  signal output_mux_1 : std_logic_vector(7 downto 0);
  
  --first line of output signals
  signal output_1_1 : std_logic_vector(7 downto 0);
  signal output_1_2 : std_logic_vector(7 downto 0);
  signal output_1_3 : std_logic_vector(7 downto 0);


  --first line of operations
  signal op_1_1: std_logic_vector(2 downto 0) := bitstream(23 downto 21);
  signal op_1_2: std_logic_vector(2 downto 0) := bitstream(26 downto 24);
  signal op_1_3: std_logic_vector(2 downto 0) := bitstream(29 downto 27);

  --------------------SECOND LINE--------------------------
  -- second line of input muxs
  signal sel_mux_2_1_A : std_logic_vector(1 downto 0) := bitstream(31 downto 30);
  signal sel_mux_2_1_B : std_logic_vector(1 downto 0) := bitstream(33 downto 32);
  signal sel_mux_2_2_A : std_logic_vector(1 downto 0) := bitstream(35 downto 34);
  signal sel_mux_2_2_B : std_logic_vector(1 downto 0) := bitstream(37 downto 36);
  signal sel_mux_2_3_A : std_logic_vector(1 downto 0) := bitstream(39 downto 38);
  signal sel_mux_2_3_B : std_logic_vector(1 downto 0) := bitstream(41 downto 40);

  -- second line output mux signals
  signal line_2_4mux_sel_1 : std_logic_vector(1 downto 0) := bitstream(43 downto 42);
  signal line_2_4mux_sel_2 : std_logic_vector(1 downto 0) := bitstream(45 downto 44);
  signal line_2_4mux_sel_3 : std_logic_vector(1 downto 0) := bitstream(47 downto 46);
  signal output_mux_2 : std_logic_vector(7 downto 0);

  --second line of output signals
  signal output_2_1 : std_logic_vector(7 downto 0);
  signal output_2_2 : std_logic_vector(7 downto 0);
  signal output_2_3 : std_logic_vector(7 downto 0);

  --second line of operations
  signal op_2_1: std_logic_vector(2 downto 0) := bitstream(53 downto 51);
  signal op_2_2: std_logic_vector(2 downto 0) := bitstream(56 downto 54);
  signal op_2_3: std_logic_vector(2 downto 0) := bitstream(59 downto 57);

  --------------------THIRD LINE--------------------------
  -- third line of input muxs
  signal sel_mux_3_1_A : std_logic_vector(1 downto 0) := bitstream(61 downto 60);
  signal sel_mux_3_1_B : std_logic_vector(1 downto 0) := bitstream(63 downto 62);
  signal sel_mux_3_2_A : std_logic_vector(1 downto 0) := bitstream(65 downto 64);
  signal sel_mux_3_2_B : std_logic_vector(1 downto 0) := bitstream(67 downto 66);
  signal sel_mux_3_3_A : std_logic_vector(1 downto 0) := bitstream(69 downto 68);
  signal sel_mux_3_3_B : std_logic_vector(1 downto 0) := bitstream(71 downto 70);

  -- third line output mux signals
  signal line_3_4mux_sel_1 : std_logic_vector(1 downto 0) := bitstream(73 downto 72);
  signal line_3_4mux_sel_2 : std_logic_vector(1 downto 0) := bitstream(75 downto 74);
  signal line_3_4mux_sel_3 : std_logic_vector(1 downto 0) := bitstream(77 downto 76);
  signal line_3_mux_sel_1 : std_logic := bitstream(78);
  signal line_3_mux_sel_2 : std_logic := bitstream(79);
  signal line_3_mux_sel_3 : std_logic := bitstream(80);
  signal output_4mux_3 : std_logic_vector(7 downto 0);
  signal output_mux_3  : std_logic_vector(7 downto 0);

  --third line of output signals
  signal output_3_1 : std_logic_vector(7 downto 0);
  signal output_3_2 : std_logic_vector(7 downto 0);
  signal output_3_3 : std_logic_vector(7 downto 0);

  -- Third line of operations
  signal op_3_1: std_logic_vector(2 downto 0) := bitstream(83 downto 81);
  signal op_3_2: std_logic_vector(2 downto 0) := bitstream(86 downto 84);
  signal op_3_3: std_logic_vector(2 downto 0) := bitstream(89 downto 87);


  --------------------MULTIPLIER DATA--------------------------
  --input muxes selectors for multiplier
  signal sel_3mux_mult_A : std_logic_vector(1 downto 0) := bitstream(91 downto 90);
  signal sel_3mux_mult_B : std_logic_vector(1 downto 0) := bitstream(93 downto 92);

  signal mux3_mult_A_output : std_logic_vector(7 downto 0);
  signal mux3_mult_B_output : std_logic_vector(7 downto 0);

  signal mult_in_A : std_logic_vector(3 downto 0);
  signal mult_in_B : std_logic_vector(3 downto 0);

  -- output of multiplier
  signal mult_output : std_logic_vector(7 downto 0);

  --------------------REGISTER BANK--------------------------

  --inputs of registers
  signal Register_1_input: std_logic_vector(7 downto 0) := "00000001";
  signal Register_2_input: std_logic_vector(7 downto 0) := "00000001";
  signal Register_3_input: std_logic_vector(7 downto 0) := "00000001";

  --OUTPUTS of registers
  signal Register_1_output: std_logic_vector(7 downto 0);
  signal Register_2_output: std_logic_vector(7 downto 0);
  signal Register_3_output: std_logic_vector(7 downto 0);

  --store signals of registers
  signal Register_1_store : std_logic := bitstream(94);
  signal Register_2_store : std_logic := bitstream(95);
  signal Register_3_store : std_logic := bitstream(96);

  -- clear signals of registers
  signal Register_1_clr : std_logic  := bitstream(97);
  signal Register_2_clr : std_logic  := bitstream(98);
  signal Register_3_clr : std_logic  := bitstream(99);

begin
  --------------------FIRST LINE--------------------------
  -- first line of input muxss
   sel_mux_1_1_A <= bitstream(1 downto 0);
   sel_mux_1_1_B <= bitstream(3 downto 2);
   sel_mux_1_2_A <= bitstream(5 downto 4);
   sel_mux_1_2_B <= bitstream(7 downto 6);
   sel_mux_1_3_A <= bitstream(9 downto 8);
   sel_mux_1_3_B <= bitstream(11 downto 10);

  -- first line output mux signals
   line_1_3mux_sel_1 <= bitstream(13 downto 12);
   line_1_3mux_sel_2 <= bitstream(15 downto 14);
   line_1_3mux_sel_3 <= bitstream(17 downto 16);
   
  --first line of operations
   op_1_1 <= bitstream(23 downto 21);
   op_1_2 <= bitstream(26 downto 24);
   op_1_3 <= bitstream(29 downto 27);

  --------------------SECOND LINE--------------------------
  -- second line of input muxs
   sel_mux_2_1_A <= bitstream(31 downto 30);
   sel_mux_2_1_B <= bitstream(33 downto 32);
   sel_mux_2_2_A <= bitstream(35 downto 34);
   sel_mux_2_2_B <= bitstream(37 downto 36);
   sel_mux_2_3_A <= bitstream(39 downto 38);
   sel_mux_2_3_B <= bitstream(41 downto 40);

  -- second line output mux signals
   line_2_3mux_sel_1 <= bitstream(43 downto 42);
   line_2_3mux_sel_2 <= bitstream(45 downto 44);
   line_2_3mux_sel_3 <= bitstream(47 downto 46);
   line_2_mux_sel_1 <= bitstream(48);
   line_2_mux_sel_2 <= bitstream(49);
   line_2_mux_sel_3 <= bitstream(50);

  --second line of operations
   op_2_1 <= bitstream(53 downto 51);
   op_2_2 <= bitstream(56 downto 54);
   op_2_3 <= bitstream(59 downto 57);

  --------------------THIRD LINE--------------------------
  -- third line of input muxs
   sel_mux_3_1_A <= bitstream(61 downto 60);
   sel_mux_3_1_B <= bitstream(63 downto 62);
   sel_mux_3_2_A <= bitstream(65 downto 64);
   sel_mux_3_2_B <= bitstream(67 downto 66);
   sel_mux_3_3_A <= bitstream(69 downto 68);
   sel_mux_3_3_B <= bitstream(71 downto 70);

  -- third line output mux signals
   line_3_3mux_sel_1 <= bitstream(73 downto 72);
   line_3_3mux_sel_2 <= bitstream(75 downto 74);
   line_3_3mux_sel_3 <= bitstream(77 downto 76);
   line_3_mux_sel_1 <= bitstream(78);
   line_3_mux_sel_2 <= bitstream(79);
   line_3_mux_sel_3 <= bitstream(80);

  -- Third line of operations
   op_3_1 <= bitstream(83 downto 81);
   op_3_2 <= bitstream(86 downto 84);
   op_3_3 <= bitstream(89 downto 87);


  --------------------MULTIPLIER DATA--------------------------
  --input muxes selectors for multiplier
   sel_3mux_mult_A <= bitstream(91 downto 90);
   sel_3mux_mult_B <= bitstream(93 downto 92);

  --------------------REGISTER BANK--------------------------

  --inputs of registers
   Register_1_input <= "00000001";
   Register_2_input <= "00000001";
   Register_3_input <= "00000001";

  --store signals of registers
   Register_1_store <= bitstream(94);
   Register_2_store <= bitstream(95);
   Register_3_store <= bitstream(96);

  -- clear signals of registers
   Register_1_clr  <= bitstream(97);
   Register_2_clr  <= bitstream(98);
   Register_3_clr  <= bitstream(99);

  --instantiate multiplier
  Mult_mux_A : Multiplexer_3
    Port Map (A => Register_1_output,
              B => Register_2_output,
              C => Register_3_output,
              sel => sel_3mux_mult_A,
              result => mux3_mult_A_output);
  mult_in_A <= mux3_mult_A_output(3 downto 0);
  Mult_mux_B : Multiplexer_3
    Port Map (A => Register_1_output,
              B => Register_2_output,
              C => Register_3_output,
              sel => sel_3mux_mult_B,
              result => mux3_mult_B_output);
  mult_in_B <= mux3_mult_B_output(3 downto 0);

  Mult : Multiplier
    Port Map (A => mult_in_A,
              B => mult_in_B,
              result => mult_output);

  --------------------FIRST LINE--------------------------

  --instantiate first line of ALUs
  line_1 : ALUs_line
    Port Map (input_1 => Register_1_output,
              input_2 => Register_2_output,
              input_3 => Register_3_output,
              sel_mux_1_A => sel_mux_1_1_A,
              sel_mux_1_B => sel_mux_1_1_B,
              sel_mux_2_A => sel_mux_1_2_A,
              sel_mux_2_B => sel_mux_1_2_B,
              sel_mux_3_A => sel_mux_1_3_A,
              sel_mux_3_B => sel_mux_1_3_B,
              sel_end_mux_1 => line_1_3mux_sel_1,
              sel_end_mux_2 => line_1_3mux_sel_2,
              sel_end_mux_3 => line_1_3mux_sel_3,
              op_1 => op_1_1,
              op_2 => op_1_2,
              op_3 => op_1_3,
              output_1 => output_1_1,
              output_2 => output_1_2,
              output_3 => output_1_3 );

  --instantiate first line multiplexers

  line_1_mux_1: Multiplexer
    Port Map (A => output_1_1,
              B => mult_output,
              sel => line_1_mux_sel_1,
              result => Register_1_input);
  line_1_mux_2: Multiplexer
    Port Map (A => output_1_2,
              B => mult_output,
              sel => line_1_mux_sel_2,
              result => Register_2_input);
  line_1_mux_3: Multiplexer
    Port Map (A => output_1_3,
              B => mult_output,
              sel => line_1_mux_sel_3,
              result => Register_3_input);

  --------------------SECOND LINE--------------------------

  --instantiate second line of ALUs
  line_2 : ALUs_line
    Port Map (input_1 => Register_1_output,
              input_2 => Register_2_output,
              input_3 => Register_3_output,
              sel_mux_1_A => sel_mux_2_1_A,
              sel_mux_1_B => sel_mux_2_1_B,
              sel_mux_2_A => sel_mux_2_2_A,
              sel_mux_2_B => sel_mux_2_2_B,
              sel_mux_3_A => sel_mux_2_3_A,
              sel_mux_3_B => sel_mux_2_3_B,
              sel_end_mux_1 => line_2_3mux_sel_1,
              sel_end_mux_2 => line_2_3mux_sel_2,
              sel_end_mux_3 => line_2_3mux_sel_3,
              op_1 => op_2_1,
              op_2 => op_2_2,
              op_3 => op_2_3,
              output_1 => output_2_1,
              output_2 => output_2_2,
              output_3 => output_2_3 );

  --instantiate second line multiplexer

  line_2_mux_1: Multiplexer
    Port Map (A => output_2_1,
              B => mult_output,
              sel => line_2_mux_sel_1,
              result => Register_1_input);
  line_2_mux_2: Multiplexer
    Port Map (A => output_2_2,
              B => mult_output,
              sel => line_2_mux_sel_2,
              result => Register_2_input);
  line_2_mux_3: Multiplexer
    Port Map (A => output_2_3,
              B => mult_output,
              sel => line_2_mux_sel_3,
              result => Register_3_input);

  --------------------THIRD LINE--------------------------

  --instantiate third line of ALUs
  line_3 : ALUs_line
    Port Map (input_1 => Register_1_output,
              input_2 => Register_2_output,
              input_3 => Register_3_output,
              sel_mux_1_A => sel_mux_3_1_A,
              sel_mux_1_B => sel_mux_3_1_B,
              sel_mux_2_A => sel_mux_3_2_A,
              sel_mux_2_B => sel_mux_3_2_B,
              sel_mux_3_A => sel_mux_3_3_A,
              sel_mux_3_B => sel_mux_3_3_B,
              sel_end_mux_1 => line_3_3mux_sel_1,
              sel_end_mux_2 => line_3_3mux_sel_2,
              sel_end_mux_3 => line_3_3mux_sel_3,
              op_1 => op_3_1,
              op_2 => op_3_2,
              op_3 => op_3_3,
              output_1 => output_3_1,
              output_2 => output_3_2,
              output_3 => output_3_3 );

  --instantiate third line multiplexer

  line_3_mux_1: Multiplexer
    Port Map (A => output_3_1,
              B => mult_output,
              sel => line_3_mux_sel_1,
              result => Register_1_input);
  line_3_mux_2: Multiplexer
    Port Map (A => output_3_2,
              B => mult_output,
              sel => line_3_mux_sel_2,
              result => Register_2_input);
  line_3_mux_3: Multiplexer
    Port Map (A => output_3_3,
              B => mult_output,
              sel => line_3_mux_sel_3,
              result => Register_3_input);


--------------------REGISTER BANK--------------------------

  BANK : Register_Bank
  Port Map( input_1 => Register_1_input,
            input_2 => Register_2_input,
            input_3 => Register_3_input,
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
end architecture;
