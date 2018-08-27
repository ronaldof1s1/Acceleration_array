library ieee;
use ieee.std_logic_1164.ALL;

entity Reconfigurable_Array_level is
  port (
    bitstream : in std_logic_vector(101 downto 0);
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
  signal sel_mux_1_1_A : selector2 := bitstream(101 downto 100);
  signal sel_mux_1_1_B : selector2 := bitstream(99 downto 98);
  signal sel_mux_1_2_A : selector2 := bitstream(97 downto 96);
  signal sel_mux_1_2_B : selector2 := bitstream(95 downto 94);
  signal sel_mux_1_3_A : selector2 := bitstream(93 downto 92);
  signal sel_mux_1_3_B : selector2 := bitstream(91 downto 90);

  signal sel_mux_2_1_A : selector2 := bitstream(89 downto 88);
  signal sel_mux_2_1_B : selector2 := bitstream(87 downto 86);
  signal sel_mux_2_2_A : selector2 := bitstream(85 downto 84);
  signal sel_mux_2_2_B : selector2 := bitstream(83 downto 82);
  signal sel_mux_2_3_A : selector2 := bitstream(81 downto 80);
  signal sel_mux_2_3_B : selector2 := bitstream(79 downto 78);

  signal sel_mux_3_1_A : selector2 := bitstream(77 downto 76);
  signal sel_mux_3_1_B : selector2 := bitstream(75 downto 74);
  signal sel_mux_3_2_A : selector2 := bitstream(73 downto 72);
  signal sel_mux_3_2_B : selector2 := bitstream(71 downto 70);
  signal sel_mux_3_3_A : selector2 := bitstream(69 downto 68);
  signal sel_mux_3_3_B : selector2 := bitstream(67 downto 66);


  --operations

  signal op_1_1: operation := bitstream(65 downto 63);
  signal op_1_2: operation := bitstream(62 downto 60);
  signal op_1_3: operation := bitstream(59 downto 57);

  signal op_2_1: operation := bitstream(56 downto 54);
  signal op_2_2: operation := bitstream(53 downto 51);
  signal op_2_3: operation := bitstream(50 downto 48);  

  signal op_3_1: operation := bitstream(47 downto 45);
  signal op_3_2: operation := bitstream(44 downto 42);
  signal op_3_3: operation := bitstream(41 downto 39);

  --Multiplier input muxes
  signal sel_mux_mult_A : selector2 := bitstream(38 downto 37);
  signal sel_mux_mult_B : selector2 := bitstream(36 downto 35);


  
  -- first line output mux signals
  signal line_1_mux_sel_1 : selector2 := bitstream(34 downto 33);
  signal line_1_mux_sel_2 : selector2 := bitstream(32 downto 31);
  signal line_1_mux_sel_3 : selector2 := bitstream(30 downto 29);

  --first line of output signals
  signal output_1_1 : data;
  signal output_1_2 : data;
  signal output_1_3 : data;


  --first line of operations

  -- second line output mux signals
  signal line_2_mux_sel_1 : selector2 := bitstream(28 downto 27);
  signal line_2_mux_sel_2 : selector2 := bitstream(26 downto 25);
  signal line_2_mux_sel_3 : selector2 := bitstream(24 downto 23);

  --second line of output signals
  signal output_2_1 : data;
  signal output_2_2 : data;
  signal output_2_3 : data;

  --second line of operations

  --------------------THIRD LINE--------------------------
  -- third line of input muxs


  -- third line output mux signals
  signal line_3_4mux_sel_1 : selector2 := bitstream(22 downto 21);
  signal line_3_4mux_sel_2 : selector2 := bitstream(20 downto 19);
  signal line_3_4mux_sel_3 : selector2 := bitstream(18 downto 17);
  signal line_3_mux_sel_1 : selector2 := bitstream(16 downto 15);
  signal line_3_mux_sel_2 : selector2 := bitstream(14 downto 13);
  signal line_3_mux_sel_3 : selector2 := bitstream(12 downto 11);
  signal output_mux_1 : data;
  signal output_mux_2  : data;
  signal output_mux_3  : data;

  --third line of output signals
  signal output_3_1 : data;
  signal output_3_2 : data;
  signal output_3_3 : data;

  -- Third line of operations


  --------------------MULTIPLIER DATA--------------------------
  --input muxes selectors for multiplier
  
  signal mult_in_A : data;
  signal mult_in_B : data;

  -- output of multiplier
  signal mult_output : data;

  -------------------MEMORY UNIT DATA---------------------------
  signal address :  data := bitstream(10 downto 3);
  signal write_enabled :  std_logic := bitstream(2);
  signal memory_out :  data;

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
