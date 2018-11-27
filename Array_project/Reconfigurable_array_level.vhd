library ieee;
use ieee.std_logic_1164.ALL;

entity Reconfigurable_Array_level is
  port (
    bitstream : in std_logic_vector(102 downto 0);
    clk : in std_logic;
    result_1 : out std_logic_vector(7 downto 0);
    result_2 : out std_logic_vector(7 downto 0);
    result_3 : out std_logic_vector(7 downto 0)
  );
end Reconfigurable_Array_level;

architecture Reconfigurable_Array_level of Reconfigurable_Array_level is

  subtype data is std_logic_vector(7 downto 0);
  subtype operation is std_logic_vector(2 downto 0);
  subtype selector2 is std_logic_vector(1 downto 0);

  Component Register_Bank
    port(
  		input_1, input_2, input_3 : in data;
      clk: in std_logic;
      store_1, store_2, store_3: in std_logic;
      clr_1, clr_2, clr_3 : in std_logic;
      output_1, output_2, output_3 : out data
  	);
  end Component;

  Component ALUs_line
    port(
    input_1, input_2, input_3 : in data;
    sel_mux_1_A, sel_mux_1_B : in selector2;
    sel_mux_2_A, sel_mux_2_B : in selector2;
    sel_mux_3_A, sel_mux_3_B : in selector2;
    op_1, op_2, op_3 : in operation;
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
  signal sel_mux_1_1_A : selector2 := bitstream(102 downto 101);
  signal sel_mux_1_1_B : selector2 := bitstream(100 downto 99);
  signal sel_mux_1_2_A : selector2 := bitstream(98 downto 97);
  signal sel_mux_1_2_B : selector2 := bitstream(96 downto 95);
  signal sel_mux_1_3_A : selector2 := bitstream(94 downto 93);
  signal sel_mux_1_3_B : selector2 := bitstream(92 downto 91);

  signal sel_mux_2_1_A : selector2 := bitstream(90 downto 89);
  signal sel_mux_2_1_B : selector2 := bitstream(88 downto 87);
  signal sel_mux_2_2_A : selector2 := bitstream(86 downto 85);
  signal sel_mux_2_2_B : selector2 := bitstream(84 downto 83);
  signal sel_mux_2_3_A : selector2 := bitstream(82 downto 81);
  signal sel_mux_2_3_B : selector2 := bitstream(80 downto 79);

  signal sel_mux_3_1_A : selector2 := bitstream(78 downto 77);
  signal sel_mux_3_1_B : selector2 := bitstream(76 downto 75);
  signal sel_mux_3_2_A : selector2 := bitstream(74 downto 73);
  signal sel_mux_3_2_B : selector2 := bitstream(72 downto 71);
  signal sel_mux_3_3_A : selector2 := bitstream(70 downto 69);
  signal sel_mux_3_3_B : selector2 := bitstream(68 downto 67);


  --operations

  signal op_1_1: operation := bitstream(66 downto 64);
  signal op_1_2: operation := bitstream(63 downto 61);
  signal op_1_3: operation := bitstream(60 downto 58);

  signal op_2_1: operation := bitstream(57 downto 55);
  signal op_2_2: operation := bitstream(54 downto 52);
  signal op_2_3: operation := bitstream(51 downto 49);  

  signal op_3_1: operation := bitstream(48 downto 46);
  signal op_3_2: operation := bitstream(45 downto 43);
  signal op_3_3: operation := bitstream(42 downto 40);

  
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
  signal line_3_4mux_sel_1 : selector2 := bitstream(21 downto 20);
  signal line_3_4mux_sel_2 : selector2 := bitstream(19 downto 18);
  signal line_3_4mux_sel_3 : selector2 := bitstream(17 downto 16);
  signal output_mux_1 : data;
  signal output_mux_2  : data;
  signal output_mux_3  : data;

  --third line of output signals
  signal output_3_1 : data;
  signal output_3_2 : data;
  signal output_3_3 : data;


  --------------------MULTIPLIER DATA--------------------------
  

  --Multiplier input muxes
  signal sel_mux_mult_A : selector2 := bitstream(14 downto 13);
  signal sel_mux_mult_B : selector2 := bitstream(12 downto 11);
  
  signal mult_in_A : data;
  signal mult_in_B : data;

  -- output of multiplier
  signal mult_output : data;

  -------------------MEMORY UNIT DATA---------------------------
  signal address :  data := bitstream(10 downto 3);
  signal write_enabled :  std_logic := bitstream(2);
  signal memory_out : data;

  signal sel_mux_memory :  selector2 := bitstream(1 downto 0);
  signal memory_mux_out :  data;

  --------------------REGISTER BANK--------------------------

  --inputs of registers
  signal Register_1_input_1: data := "00000001";
  signal Register_2_input_1: data := "00000001";
  signal Register_3_input_1: data := "00000001";
  signal Register_1_input_2: data := "00000001";
  signal Register_2_input_2: data := "00000001";
  signal Register_3_input_2: data := "00000001";
  signal Register_1_input_3: data := "00000001";
  signal Register_2_input_3: data := "00000001";
  signal Register_3_input_3: data := "00000001";


  signal Register_final_input_1: data := "00000001";
  signal Register_final_input_2: data := "00000001";
  signal Register_final_input_3: data := "00000001";
  --OUTPUTS of registers
  signal Register_1_output: data;
  signal Register_2_output: data;
  signal Register_3_output: data;

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
  Mult_mux_A : Multiplexer_4
    Port Map (A => Register_1_input_1,
              B => Register_2_input_1,
              C => Register_3_input_1,
              D => "00000000",
              sel => sel_mux_mult_A,
              -- sel => "01",
              result => mult_in_A
              );

  Mult_mux_B : Multiplexer_4
    Port Map (A => Register_1_input_1,
              B => Register_2_input_1,
              C => Register_3_input_1,
              D => "00000000",
              sel => sel_mux_mult_B,
              -- sel => "01",
              result => mult_in_B
              );

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
              D => "00000000",
              sel => sel_mux_memory,
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
  mult_ALU_mux_1: Multiplexer_4
    Port Map (A => mult_output,
              B => memory_out,
              C => Register_1_input_3,
              D => "00000000",
              sel => line_3_mux_sel_1,
              result => output_mux_1
            );
  mult_ALU_mux_2: Multiplexer_4
      Port Map (A => mult_output,
                B => memory_out,
                C => Register_2_input_3,
                D => "00000000",
                sel => line_3_mux_sel_2,
                result => output_mux_2
                );
  mult_ALU_mux_3: Multiplexer_4
      Port Map (A => mult_output,
                B => memory_out,
                C => Register_3_input_3,
                D => "00000000",
                sel => line_3_mux_sel_3,
                result => output_mux_3
              );


  line_3_mux_1: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => output_mux_1,
              sel => line_3_4mux_sel_1,
              result => Register_final_input_1);
  line_3_mux_2: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => output_mux_2,
              sel => line_3_4mux_sel_2,
              result => Register_final_input_2);
  line_3_mux_3: Multiplexer_4
    Port Map (A => output_3_1,
              B => output_3_2,
              C => output_3_3,
              D => output_mux_3,
              sel => line_3_4mux_sel_3,
              result => Register_final_input_3);

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
