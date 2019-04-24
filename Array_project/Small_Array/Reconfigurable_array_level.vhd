library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;
use IEEE.numeric_std.all;

use work.data.all;

entity Reconfigurable_Array_level is
  port (
    input_regs : in reg_bank;

    bitstream : in std_logic_vector(409 downto 0);
    
    clk : in std_logic;

    ram_i : in ram_t;
    ram_o : out ram_t;
    
    output_regs : out reg_bank
  );
end Reconfigurable_Array_level;

architecture Reconfigurable_Array_level of Reconfigurable_Array_level is
  subtype sel_stream is std_logic_vector(29 downto 0);
  subtype op_stream is std_logic_vector(8 downto 0);
  subtype line_sel_stream is std_logic_vector(63 downto 0);

  Component ALUs_line
    port(
    input_regs: in reg_bank;
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
      input_regs: in reg_bank;
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
      ram_i : in ram_t;
      ram_o : out ram_t;
      data_o : out data
    );
  end Component;
  
 -- input muxes for the ALUs
  signal sel_stream_1 : sel_stream;
  signal sel_stream_2 : sel_stream;
  signal sel_stream_3 : sel_stream;

  --operations

  signal op_stream_1 : op_stream;
  signal op_stream_2 : op_stream;
  signal op_stream_3 : op_stream;
  
  -- first line output mux signals
  signal line_1_mux_sel_stream : line_sel_stream;

  --first line of output signals
  signal output_1_1 : data;
  signal output_1_2 : data;
  signal output_1_3 : data;

  --first line of operations

  -- second line output mux signals
  signal line_2_mux_sel_stream : line_sel_stream;
  

  --second line of output signals
  signal output_2_1 : data;
  signal output_2_2 : data;
  signal output_2_3 : data;

  --second line of operations

  --------------------THIRD LINE--------------------------
  
  -- third line output mux signals
  signal line_3_mux_sel_stream : line_sel_stream;


  signal final_mux_sel_stream : line_sel_stream;
  

 signal output_mux : reg_bank;


  --third line of output signals
  signal output_3_1 : data;
  signal output_3_2 : data;
  signal output_3_3 : data;


  --------------------MULTIPLIER DATA--------------------------
  

  --Multiplier input muxes
  signal sel_mult_A : selector5;
  signal sel_mult_B : selector5;
  
  signal mult_in_A : data;
  signal mult_in_B : data;

  -- output of multiplier
  signal mult_output : data;

  -------------------MEMORY UNIT DATA---------------------------
  signal address :  selector5;
  signal temp_addr: data;
  signal addr_register : data;
  signal position : data;
  signal write_enabled :  std_logic;
  signal memory_out : data;

  signal sel_memory :  selector5;
  signal memory_mux_out :  data;

  --------------------REGISTER BANK--------------------------


  signal reg_input_2 : reg_bank;
  signal reg_input_3 : reg_bank;


begin
  
process(bitstream,clk)
begin
if rising_edge(clk) then
  sel_stream_1 <= bitstream(29 downto 0);
  sel_stream_2 <= bitstream(59 downto 30);
  sel_stream_3 <= bitstream(89 downto 60);

  --operations

  op_stream_1 <= bitstream(98 downto 90);
  op_stream_2 <= bitstream(107 downto 99);
  op_stream_3 <= bitstream(116 downto 108);
  
  -- first line output mux signals
  line_1_mux_sel_stream <= bitstream(180 downto 117);

  line_2_mux_sel_stream <= bitstream(244 downto 181);
  
  line_3_mux_sel_stream <= bitstream(308 downto 245);

  final_mux_sel_stream <= bitstream(372 downto 309);
  

  
  sel_mult_A <= bitstream(377 downto 373);
  sel_mult_B <= bitstream(382 downto 378);
  

  address <= bitstream(387 downto 383);
  position <= "0000000000000000" & bitstream(403 downto 388);
  write_enabled <= bitstream(404);
  
  sel_memory <= bitstream(409 downto 405);
  end if;
  end process;
  
  --instantiate multiplier
  Mult_mux_A : Multiplexer_32
  port map (input_regs=> input_regs,
            sel => sel_mult_A,
            result => mult_in_A);

  Mult_mux_B : Multiplexer_32
  port map (input_regs=> input_regs,
            sel => sel_mult_B,
            result => mult_in_B);

  Mult : Multiplier
    Port Map (A => mult_in_A,
              B => mult_in_B,
              result => mult_output
              );

  --instantiate memory access unit

  RAM_mux : Multiplexer_32
  port map (input_regs=> input_regs,
            sel => sel_memory,
            result => memory_mux_out);

  RAM_mux_addr : Multiplexer_32
  port map (input_regs=> input_regs,
            sel => address,
            result => temp_addr);

  
  addr_register <= temp_addr + position;
  
    RAM_acess_unity : ram_access
    Port Map(Clk => clk,
            address => addr_register,
            we => write_enabled,
            data_i => memory_mux_out,
            ram_i => ram_i,
            ram_o => ram_o,
            data_o => memory_out

    );

  --------------------FIRST LINE--------------------------

  -- instantiate first line of ALUs
  line_1 : ALUs_line
    Port Map (input_regs=> input_regs,
              sel_bitstream => sel_stream_1,
              operation_bitstream => op_stream_1,
              output_1 => output_1_1,
              output_2 => output_1_2,
              output_3 => output_1_3 );

  --instantiate first line multiplexers
  
  LINE1_MUX:
  for i in 0 to bank_len generate
    MUX: Multiplexer_4
    port map(
    A => output_1_1,
    B => output_1_2,
    C => output_1_3,
    D => input_regs(i),
    sel => line_1_mux_sel_stream(i*2+1 downto i*2),
    result => reg_input_2(i));
  end generate LINE1_MUX;

  

  --------------------SECOND LINE--------------------------

  --instantiate second line of ALUs
  line_2 : ALUs_line
  Port Map (input_regs=> input_regs,
            sel_bitstream => sel_stream_2,
            operation_bitstream => op_stream_2,
            output_1 => output_2_1,
            output_2 => output_2_2,
            output_3 => output_2_3 );

  --instantiate second line multiplexer

  LINE2_MUX:
  for i in 0 to bank_len generate
    MUX: Multiplexer_4
    port map(
    A => output_2_1,
    B => output_2_2,
    C => output_2_3,
    D => reg_input_2(i),
    sel => line_2_mux_sel_stream(i*2+1 downto i*2),
    result => reg_input_3(i));
  end generate LINE2_MUX;
              


  --------------------THIRD LINE--------------------------

  --instantiate third line of ALUs
  line_3 : ALUs_line
  Port Map (input_regs=> input_regs,
            sel_bitstream => sel_stream_3,
            operation_bitstream => op_stream_3,
            output_1 => output_3_1,
            output_2 => output_3_2,
            output_3 => output_3_3 );
 
 
--instantiate third line multiplexer
  LINE3_MUX:
  for i in 0 to bank_len generate
    MUX: Multiplexer_4
    port map(
    A => output_3_1,
    B => output_3_2,
    C => output_3_3,
    D => reg_input_3(i),
    sel => line_3_mux_sel_stream(i*2+1 downto i*2),
    result => output_mux(i));
  end generate LINE3_MUX;
              


-----------------------------------------------------------------------------------------------------------------------
FINAL_MUX:
  for i in 0 to bank_len generate
    MUX: Multiplexer_4
    port map(
      A => mult_output,
      B => memory_out,
      C => output_mux(i),
      D => reg_input_3(i),
      sel => final_mux_sel_stream(i*2+1 downto i*2),
      result => output_regs(i));
  end generate FINAL_MUX; 

end architecture;
