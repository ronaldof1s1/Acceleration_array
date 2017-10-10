library ieee;
use ieee.std_logic_1164.ALL;

entity Reconfigurable_Array is
  port (
    bitstream : in std_logic_vector(93 downto 0);
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
  Component Parser is
    port(
    bitstream : in std_logic_vector(93 downto 0);
    --------------------FIRST LINE--------------------------
    -- first line of input muxss
    sel_mux_1_1_A : out std_logic_vector(1 downto 0);
    sel_mux_1_1_B : out std_logic_vector(1 downto 0);
    sel_mux_1_2_A : out std_logic_vector(1 downto 0);
    sel_mux_1_2_B : out std_logic_vector(1 downto 0);
    sel_mux_1_3_A : out std_logic_vector(1 downto 0);
    sel_mux_1_3_B : out std_logic_vector(1 downto 0);

    -- first line output mux signals
    line_1_mux_sel_1 : out std_logic_vector(1 downto 0);
    line_1_mux_sel_2 : out std_logic_vector(1 downto 0);
    line_1_mux_sel_3 : out std_logic_vector(1 downto 0);

    --first line of operations
    op_1_1: out std_logic_vector(2 downto 0);
    op_1_2: out std_logic_vector(2 downto 0);
    op_1_3: out std_logic_vector(2 downto 0);

    --------------------SECOND LINE--------------------------
    -- second line of input muxs
    sel_mux_2_1_A : out std_logic_vector(1 downto 0);
    sel_mux_2_1_B : out std_logic_vector(1 downto 0);
    sel_mux_2_2_A : out std_logic_vector(1 downto 0);
    sel_mux_2_2_B : out std_logic_vector(1 downto 0);
    sel_mux_2_3_A : out std_logic_vector(1 downto 0);
    sel_mux_2_3_B : out std_logic_vector(1 downto 0);

    -- second line output mux signals
    line_2_mux_sel_1 : out std_logic_vector(1 downto 0);
    line_2_mux_sel_2 : out std_logic_vector(1 downto 0);
    line_2_mux_sel_3 : out std_logic_vector(1 downto 0);

    --second line of operations
    op_2_1: out std_logic_vector(2 downto 0);
    op_2_2: out std_logic_vector(2 downto 0);
    op_2_3: out std_logic_vector(2 downto 0);

    --------------------THIRD LINE--------------------------
    -- third line of input muxs
    sel_mux_3_1_A : out std_logic_vector(1 downto 0);
    sel_mux_3_1_B : out std_logic_vector(1 downto 0);
    sel_mux_3_2_A : out std_logic_vector(1 downto 0);
    sel_mux_3_2_B : out std_logic_vector(1 downto 0);
    sel_mux_3_3_A : out std_logic_vector(1 downto 0);
    sel_mux_3_3_B : out std_logic_vector(1 downto 0);

    -- third line output mux signals
    line_3_4mux_sel_1 : out std_logic_vector(1 downto 0);
    line_3_4mux_sel_2 : out std_logic_vector(1 downto 0);
    line_3_4mux_sel_3 : out std_logic_vector(1 downto 0);
    line_3_mux_sel_1 : out std_logic;
    line_3_mux_sel_2 : out std_logic;
    line_3_mux_sel_3 : out std_logic;

    -- Third line of operations
    op_3_1: out std_logic_vector(2 downto 0);
    op_3_2: out std_logic_vector(2 downto 0);
    op_3_3: out std_logic_vector(2 downto 0);


    --------------------MULTIPLIER DATA--------------------------
    --input muxes selectors for multiplier
    sel_mux_mult_A : out std_logic_vector(1 downto 0);
    sel_mux_mult_B : out std_logic_vector(1 downto 0);

    --------------------REGISTER BANK--------------------------

    --store signals of registers
    Register_1_store : out std_logic;
    Register_2_store : out std_logic;
    Register_3_store : out std_logic;

    -- clear signals of registers
    Register_1_clr : out std_logic;
    Register_2_clr : out std_logic;
    Register_3_clr : out std_logic
    );
  end Component;

  --------------------FIRST LINE--------------------------
  -- first line of input muxss
  signal sel_mux_1_1_A : std_logic_vector(1 downto 0);
  signal sel_mux_1_1_B : std_logic_vector(1 downto 0);
  signal sel_mux_1_2_A : std_logic_vector(1 downto 0);
  signal sel_mux_1_2_B : std_logic_vector(1 downto 0);
  signal sel_mux_1_3_A : std_logic_vector(1 downto 0);
  signal sel_mux_1_3_B : std_logic_vector(1 downto 0);

  -- first line output mux signals
  signal line_1_mux_sel_1 : std_logic_vector(1 downto 0);
  signal line_1_mux_sel_2 : std_logic_vector(1 downto 0);
  signal line_1_mux_sel_3 : std_logic_vector(1 downto 0);

  --first line of output signals
  signal output_1_1 : std_logic_vector(7 downto 0);
  signal output_1_2 : std_logic_vector(7 downto 0);
  signal output_1_3 : std_logic_vector(7 downto 0);


  --first line of operations
  signal op_1_1: std_logic_vector(2 downto 0);
  signal op_1_2: std_logic_vector(2 downto 0);
  signal op_1_3: std_logic_vector(2 downto 0);

  --------------------SECOND LINE--------------------------
  -- second line of input muxs
  signal sel_mux_2_1_A : std_logic_vector(1 downto 0);
  signal sel_mux_2_1_B : std_logic_vector(1 downto 0);
  signal sel_mux_2_2_A : std_logic_vector(1 downto 0);
  signal sel_mux_2_2_B : std_logic_vector(1 downto 0);
  signal sel_mux_2_3_A : std_logic_vector(1 downto 0);
  signal sel_mux_2_3_B : std_logic_vector(1 downto 0);

  -- second line output mux signals
  signal line_2_mux_sel_1 : std_logic_vector(1 downto 0);
  signal line_2_mux_sel_2 : std_logic_vector(1 downto 0);
  signal line_2_mux_sel_3 : std_logic_vector(1 downto 0);

  --second line of output signals
  signal output_2_1 : std_logic_vector(7 downto 0);
  signal output_2_2 : std_logic_vector(7 downto 0);
  signal output_2_3 : std_logic_vector(7 downto 0);

  --second line of operations
  signal op_2_1: std_logic_vector(2 downto 0);
  signal op_2_2: std_logic_vector(2 downto 0);
  signal op_2_3: std_logic_vector(2 downto 0);

  --------------------THIRD LINE--------------------------
  -- third line of input muxs
  signal sel_mux_3_1_A : std_logic_vector(1 downto 0);
  signal sel_mux_3_1_B : std_logic_vector(1 downto 0);
  signal sel_mux_3_2_A : std_logic_vector(1 downto 0);
  signal sel_mux_3_2_B : std_logic_vector(1 downto 0);
  signal sel_mux_3_3_A : std_logic_vector(1 downto 0);
  signal sel_mux_3_3_B : std_logic_vector(1 downto 0);

  -- third line output mux signals
  signal line_3_4mux_sel_1 : std_logic_vector(1 downto 0);
  signal line_3_4mux_sel_2 : std_logic_vector(1 downto 0);
  signal line_3_4mux_sel_3 : std_logic_vector(1 downto 0);
  signal line_3_mux_sel_1 : std_logic;
  signal line_3_mux_sel_2 : std_logic;
  signal line_3_mux_sel_3 : std_logic;
  signal output_mux_1 : std_logic_vector(7 downto 0);
  signal output_mux_2  : std_logic_vector(7 downto 0);
  signal output_mux_3  : std_logic_vector(7 downto 0);

  --third line of output signals
  signal output_3_1 : std_logic_vector(7 downto 0);
  signal output_3_2 : std_logic_vector(7 downto 0);
  signal output_3_3 : std_logic_vector(7 downto 0);

  -- Third line of operations
  signal op_3_1: std_logic_vector(2 downto 0);
  signal op_3_2: std_logic_vector(2 downto 0);
  signal op_3_3: std_logic_vector(2 downto 0);


  --------------------MULTIPLIER DATA--------------------------
  --input muxes selectors for multiplier
  signal sel_mux_mult_A : std_logic_vector(1 downto 0);
  signal sel_mux_mult_B : std_logic_vector(1 downto 0);

  signal mux_mult_A_output : std_logic_vector(7 downto 0);
  signal mux_mult_B_output : std_logic_vector(7 downto 0);

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
  signal Register_1_store : std_logic;
  signal Register_2_store : std_logic;
  signal Register_3_store : std_logic;

  -- clear signals of registers
  signal Register_1_clr : std_logic ;
  signal Register_2_clr : std_logic ;
  signal Register_3_clr : std_logic ;

begin
  Parsing : Parser
    Port Map  (bitstream =>bitstream,
              sel_mux_1_1_A =>sel_mux_1_1_A,
              sel_mux_1_1_B =>sel_mux_1_1_B,
              sel_mux_1_2_A =>sel_mux_1_2_A,
              sel_mux_1_2_B =>sel_mux_1_2_B,
              sel_mux_1_3_A =>sel_mux_1_3_A,
              sel_mux_1_3_B =>sel_mux_1_3_B,
              line_1_mux_sel_1 =>line_1_mux_sel_1,
              line_1_mux_sel_2 =>line_1_mux_sel_2,
              line_1_mux_sel_3 =>line_1_mux_sel_3,
              op_1_1=>op_1_1,
              op_1_2=>op_1_2,
              op_1_3=>op_1_3,
              sel_mux_2_1_A =>sel_mux_2_1_A,
              sel_mux_2_1_B =>sel_mux_2_1_B,
              sel_mux_2_2_A =>sel_mux_2_2_A,
              sel_mux_2_2_B =>sel_mux_2_2_B,
              sel_mux_2_3_A =>sel_mux_2_3_A,
              sel_mux_2_3_B =>sel_mux_2_3_B,
              line_2_mux_sel_1 =>line_2_mux_sel_1,
              line_2_mux_sel_2 =>line_2_mux_sel_2,
              line_2_mux_sel_3 =>line_2_mux_sel_3,
              op_2_1=>op_2_1,
              op_2_2=>op_2_2,
              op_2_3=>op_2_3,
              sel_mux_3_1_A =>sel_mux_3_1_A,
              sel_mux_3_1_B =>sel_mux_3_1_B,
              sel_mux_3_2_A =>sel_mux_3_2_A,
              sel_mux_3_2_B =>sel_mux_3_2_B,
              sel_mux_3_3_A =>sel_mux_3_3_A,
              sel_mux_3_3_B =>sel_mux_3_3_B,
              line_3_4mux_sel_1 =>line_3_4mux_sel_1,
              line_3_4mux_sel_2 =>line_3_4mux_sel_2,
              line_3_4mux_sel_3 =>line_3_4mux_sel_3,
              line_3_mux_sel_1 =>line_3_mux_sel_1 ,
              line_3_mux_sel_2 =>line_3_mux_sel_2 ,
              line_3_mux_sel_3 =>line_3_mux_sel_3 ,
              op_3_1=>op_3_1,
              op_3_2=>op_3_2,
              op_3_3=>op_3_3,
              sel_mux_mult_A =>sel_mux_mult_A,
              sel_mux_mult_B =>sel_mux_mult_B,
              Register_1_store =>Register_1_store ,
              Register_2_store =>Register_2_store ,
              Register_3_store =>Register_3_store ,
              Register_1_clr =>Register_1_clr ,
              Register_2_clr =>Register_2_clr ,
              Register_3_clr =>Register_3_clr
              );
  --instantiate multiplier
  Mult_mux_A : Multiplexer_4
    Port Map (A => Register_1_input,
              B => Register_2_input,
              C => Register_3_input,
              D => "00000000",
              sel => sel_mux_mult_A,
              result => mux_mult_A_output);
  mult_in_A <= mux_mult_A_output(7 downto 4);
  Mult_mux_B : Multiplexer_4
    Port Map (A => Register_1_input,
              B => Register_2_input,
              C => Register_3_input,
              D => "00000000",
              sel => sel_mux_mult_B,
              result => mux_mult_B_output);
  mult_in_B <= mux_mult_B_output(7 downto 4);

  Mult : Multiplier
    Port Map (A => mult_in_A,
              B => mult_in_B,
              result => mult_output);

  --------------------FIRST LINE--------------------------

  --instantiate first line of ALUs
  line_1 : ALUs_line
    Port Map (input_1 => Register_1_input,
              input_2 => Register_2_input,
              input_3 => Register_3_input,
              sel_mux_1_A => sel_mux_1_1_A,
              sel_mux_1_B => sel_mux_1_1_B,
              sel_mux_2_A => sel_mux_1_2_A,
              sel_mux_2_B => sel_mux_1_2_B,
              sel_mux_3_A => sel_mux_1_3_A,
              sel_mux_3_B => sel_mux_1_3_B,
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
              D => Register_1_input,
              sel => line_1_mux_sel_1,
              result => Register_1_input);
  line_1_mux_2: Multiplexer_4
    Port Map (A => output_1_1,
              B => output_1_2,
              C => output_1_3,
              D => Register_2_input,
              sel => line_1_mux_sel_1,
              result => Register_2_input);
  line_1_mux_3: Multiplexer_4
    Port Map (A => output_1_1,
              B => output_1_2,
              C => output_1_3,
              D => Register_3_input,
              sel => line_1_mux_sel_1,
              result => Register_3_input);

  --------------------SECOND LINE--------------------------

  --instantiate second line of ALUs
  line_2 : ALUs_line
    Port Map (input_1 => Register_1_input,
              input_2 => Register_2_input,
              input_3 => Register_3_input,
              sel_mux_1_A => sel_mux_2_1_A,
              sel_mux_1_B => sel_mux_2_1_B,
              sel_mux_2_A => sel_mux_2_2_A,
              sel_mux_2_B => sel_mux_2_2_B,
              sel_mux_3_A => sel_mux_2_3_A,
              sel_mux_3_B => sel_mux_2_3_B,
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
              D => Register_1_input,
              sel => line_2_mux_sel_1,
              result => Register_1_input);
  line_2_mux_2: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_2_input,
              sel => line_2_mux_sel_1,
              result => Register_2_input);
  line_2_mux_3: Multiplexer_4
    Port Map (A => output_2_1,
              B => output_2_2,
              C => output_2_3,
              D => Register_3_input,
              sel => line_2_mux_sel_1,
              result => Register_3_input);



  --------------------THIRD LINE--------------------------

  --instantiate third line of ALUs
  line_3 : ALUs_line
    Port Map (input_1 => Register_1_input,
              input_2 => Register_2_input,
              input_3 => Register_3_input,
              sel_mux_1_A => sel_mux_3_1_A,
              sel_mux_1_B => sel_mux_3_1_B,
              sel_mux_2_A => sel_mux_3_2_A,
              sel_mux_2_B => sel_mux_3_2_B,
              sel_mux_3_A => sel_mux_3_3_A,
              sel_mux_3_B => sel_mux_3_3_B,
              op_1 => op_3_1,
              op_2 => op_3_2,
              op_3 => op_3_3,
              output_1 => output_3_1,
              output_2 => output_3_2,
              output_3 => output_3_3 );

  --instantiate third line multiplexer
  mult_ALU_mux_1: Multiplexer
    Port Map (A => mult_output,
              B => Register_1_input,
              sel => line_3_mux_sel_1,
              result => output_mux_1
            );
  mult_ALU_mux_2: Multiplexer
      Port Map (A => mult_output,
                B => Register_2_input,
                sel => line_3_mux_sel_2,
                result => output_mux_2
                );
  mult_ALU_mux_3: Multiplexer
      Port Map (A => mult_output,
                B => Register_3_input,
                sel => line_3_mux_sel_3,
                result => output_mux_3
              );


  line_3_mux_1: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => output_mux_1,
              sel => line_3_4mux_sel_1,
              result => Register_1_input);
  line_3_mux_2: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => output_mux_2,
              sel => line_3_4mux_sel_2,
              result => Register_2_input);
  line_3_mux_3: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => output_mux_3,
              sel => line_3_4mux_sel_3,
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
