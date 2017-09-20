library ieee;
use ieee.std_logic_1164.ALL;

entity Reconfigurable_Array is
  generic (Number_of_bits : integer := 8);
  port (
    clk : in std_logic
  );
end Reconfigurable_Array;

architecture Reconfigurable_Array of Reconfigurable_Array is

  Component Register_Bank
    Generic (bits: integer);
  	port(
  		input_1, input_2, input_3 : in std_logic_vector (bits-1 downto 0);
      clk: in std_logic;
      store_1, store_2, store_3: in std_logic;
      clr_1, clr_2, clr_3 : in std_logic;
      output_1, output_2, output_3 : out std_logic_vector(bits-1 downto 0)
  	);
  end Component;

  Component ALUs_line
    generic (bits : integer);
    port(
    input_1, input_2, input_3 : in std_logic_vector(bits-1 downto 0);
    sel_mux_1_A, sel_mux_1_B : in std_logic_vector(1 downto 0);
    sel_mux_2_A, sel_mux_2_B : in std_logic_vector(1 downto 0);
    sel_mux_3_A, sel_mux_3_B : in std_logic_vector(1 downto 0);
    sel_end_mux_1, sel_end_mux_2, sel_end_mux_3 : in std_logic_vector(1 downto 0);
    op_1, op_2, op_3 : in std_logic_vector(2 downto 0);
    output_1, output_2, output_3 : out std_logic_vector (bits-1 downto 0)
    );
  end component;

  Component Multiplier
    Generic (N : integer);
    port(
      A, B : in  std_logic_vector(N/2 downto 0);
      result: out std_logic_vector(N-1 downto 0)
    );
  end Component;

  Component Multiplexer_3
    generic (N : integer);
  	port(
  		A,B,C	: in std_logic_vector (N-1 downto 0);
  		sel	: in std_logic_vector(1 downto 0);
  		result	: out std_logic_vector (N-1 downto 0)
  	);
  end Component;

  Component Multiplexer is
    generic (N : integer);
  	port(
  		A,B	: in std_logic_vector (N-1 downto 0);
  		sel	: in std_logic;
  		result	: out std_logic_vector (N-1 downto 0)
  	);
  end Component;

  --------------------FIRST LINE--------------------------
  -- first line of input muxs
  signal sel_mux_1_1_A, sel_mux_1_1_B : std_logic_vector(1 downto 0);
  signal sel_mux_1_2_A, sel_mux_1_2_B : std_logic_vector(1 downto 0);
  signal sel_mux_1_3_A, sel_mux_1_3_B : std_logic_vector(1 downto 0);

  -- first line output mux signals
  signal line_1_3mux_sel_1 : std_logic_vector(1 downto 0);
  signal line_1_3mux_sel_2 : std_logic_vector(1 downto 0);
  signal line_1_3mux_sel_3 : std_logic_vector(1 downto 0);
  signal line_1_mux_sel_1 : std_logic;
  signal line_1_mux_sel_2 : std_logic;
  signal line_1_mux_sel_3 : std_logic;
  signal output_3mux_1 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_mux_1 : std_logic_vector(Number_of_bits-1 downto 0);

  --first line of output signals
  signal output_1_1 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_1_2 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_1_3 : std_logic_vector(Number_of_bits-1 downto 0);


  --first line of operations
  signal op_1_1: std_logic_vector(2 downto 0) := "000";
  signal op_1_2: std_logic_vector(2 downto 0) := "000";
  signal op_1_3: std_logic_vector(2 downto 0) := "000";

  --------------------SECOND LINE--------------------------
  -- second line of input muxs
  signal sel_mux_2_1_A, sel_mux_2_1_B : std_logic_vector(1 downto 0);
  signal sel_mux_2_2_A, sel_mux_2_2_B : std_logic_vector(1 downto 0);
  signal sel_mux_2_3_A, sel_mux_2_3_B : std_logic_vector(1 downto 0);

  -- second line output mux signals
  signal line_2_3mux_sel_1 : std_logic_vector(1 downto 0);
  signal line_2_3mux_sel_2 : std_logic_vector(1 downto 0);
  signal line_2_3mux_sel_3 : std_logic_vector(1 downto 0);
  signal line_2_mux_sel_1 : std_logic;
  signal line_2_mux_sel_2 : std_logic;
  signal line_2_mux_sel_3 : std_logic;
  signal output_3mux_2 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_mux_2 : std_logic_vector(Number_of_bits-1 downto 0);

  --second line of output signals
  signal output_2_1 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_2_2 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_2_3 : std_logic_vector(Number_of_bits-1 downto 0);

  --second line of operations
  signal op_2_1: std_logic_vector(2 downto 0) := "000";
  signal op_2_2: std_logic_vector(2 downto 0) := "000";
  signal op_2_3: std_logic_vector(2 downto 0) := "000";

  --------------------THIRD LINE--------------------------
  -- third line of input muxs
  signal sel_mux_3_1_A, sel_mux_3_1_B : std_logic_vector(1 downto 0);
  signal sel_mux_3_2_A, sel_mux_3_2_B : std_logic_vector(1 downto 0);
  signal sel_mux_3_3_A, sel_mux_3_3_B : std_logic_vector(1 downto 0);

  -- third line output mux signals
  signal line_3_3mux_sel_1 : std_logic_vector(1 downto 0);
  signal line_3_3mux_sel_2 : std_logic_vector(1 downto 0);
  signal line_3_3mux_sel_3 : std_logic_vector(1 downto 0);
  signal line_3_mux_sel_1 : std_logic;
  signal line_3_mux_sel_2 : std_logic;
  signal line_3_mux_sel_3 : std_logic;
  signal output_3mux_3 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_mux_3  : std_logic_vector(Number_of_bits-1 downto 0);

  --third line of output signals
  signal output_3_1 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_3_2 : std_logic_vector(Number_of_bits-1 downto 0);
  signal output_3_3 : std_logic_vector(Number_of_bits-1 downto 0);

  -- Third line of operations
  signal op_3_1: std_logic_vector(2 downto 0) := "000";
  signal op_3_2: std_logic_vector(2 downto 0) := "000";
  signal op_3_3: std_logic_vector(2 downto 0) := "000";


  --------------------MULTIPLIER DATA--------------------------
  --input muxes selectors for multiplier
  signal sel_3mux_mult_A : std_logic_vector(1 downto 0);
  signal sel_3mux_mult_B : std_logic_vector(1 downto 0);

  signal mult_in_A : std_logic_vector(Number_of_bits-1 downto 0);
  signal mult_in_B : std_logic_vector(Number_of_bits-1 downto 0);

  -- output of multiplier
  signal mult_output : std_logic_vector(Number_of_bits-1 downto 0);

  --------------------REGISTER BANK--------------------------

  --inputs of registers
  signal Register_1_input: std_logic_vector(Number_of_bits-1 downto 0) := x"00000001";
  signal Register_2_input: std_logic_vector(Number_of_bits-1 downto 0) := x"00000001";
  signal Register_3_input: std_logic_vector(Number_of_bits-1 downto 0) := x"00000001";

  --OUTPUTS of registers
  signal Register_1_output: std_logic_vector(Number_of_bits-1 downto 0);
  signal Register_2_output: std_logic_vector(Number_of_bits-1 downto 0);
  signal Register_3_output: std_logic_vector(Number_of_bits-1 downto 0);

  --store signals of registers
  signal Register_1_store : std_logic := '1';
  signal Register_2_store : std_logic := '1';
  signal Register_3_store : std_logic := '1';

  -- clear signals of registers
  signal Register_1_clr : std_logic := '0';
  signal Register_2_clr : std_logic := '0';
  signal Register_3_clr : std_logic := '0';

begin

  --instantiate multiplier
  Mult_mux_A : Multiplexer_3
    Generic Map (N => Number_of_bits)
    Port Map (A => Register_1_output,
              B => Register_2_output,
              C => Register_3_output,
              sel => sel_3mux_mult_A,
              result => mult_in_A);
  Mult_mux_B : Multiplexer_3
    Generic Map (N => Number_of_bits)
    Port Map (A => Register_1_output,
              B => Register_2_output,
              C => Register_3_output,
              sel => sel_3mux_mult_B,
              result => mult_in_B);

  Mult : Multiplier
    Generic Map (N => Number_of_bits)
    Port Map (A => mult_in_A,
              B => mult_in_B,
              result => mult_output);

  --------------------FIRST LINE--------------------------

  --instantiate first line of ALUs
  line_1 : ALUs_line
    Generic Map(bits => Number_of_bits)
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
    Generic Map (N => Number_of_bits)
    Port Map (A => output_1_1,
              B => mult_output,
              sel => line_1_mux_sel_1,
              result => Register_1_input);
  line_1_mux_2: Multiplexer
    Generic Map (N => Number_of_bits)
    Port Map (A => output_1_2,
              B => mult_output,
              sel => line_1_mux_sel_2,
              result => Register_2_input);
  line_1_mux_3: Multiplexer
    Generic Map (N => Number_of_bits)
    Port Map (A => output_1_3,
              B => mult_output,
              sel => line_1_mux_sel_3,
              result => Register_3_input);

  --------------------SECOND LINE--------------------------

  --instantiate second line of ALUs
  line_2 : ALUs_line
    Generic Map(bits => Number_of_bits)
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
    Generic Map (N => Number_of_bits)
    Port Map (A => output_2_1,
              B => mult_output,
              sel => line_2_mux_sel_1,
              result => Register_1_input);
  line_2_mux_2: Multiplexer
    Generic Map (N => Number_of_bits)
    Port Map (A => output_2_2,
              B => mult_output,
              sel => line_2_mux_sel_2,
              result => Register_2_input);
  line_2_mux_3: Multiplexer
    Generic Map (N => Number_of_bits)
    Port Map (A => output_2_3,
              B => mult_output,
              sel => line_2_mux_sel_3,
              result => Register_3_input);

  --------------------THIRD LINE--------------------------

  --instantiate third line of ALUs
  line_3 : ALUs_line
    Generic Map(bits => Number_of_bits)
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
    Generic Map (N => Number_of_bits)
    Port Map (A => output_3_1,
              B => mult_output,
              sel => line_3_mux_sel_1,
              result => Register_1_input);
  line_3_mux_2: Multiplexer
    Generic Map (N => Number_of_bits)
    Port Map (A => output_3_2,
              B => mult_output,
              sel => line_3_mux_sel_2,
              result => Register_2_input);
  line_3_mux_3: Multiplexer
    Generic Map (N => Number_of_bits)
    Port Map (A => output_3_3,
              B => mult_output,
              sel => line_3_mux_sel_3,
              result => Register_3_input);


--------------------REGISTER BANK--------------------------

  BANK : Register_Bank
  Generic Map (bits => Number_of_bits)
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
