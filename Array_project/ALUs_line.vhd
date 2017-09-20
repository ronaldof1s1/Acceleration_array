library ieee;
use ieee.std_logic_1164.ALL;

entity ALUs_line is
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
end entity;

architecture ALine of ALUs_line is

  Component ALU
    Generic (N : integer);
    port(
      A : in  std_logic_vector(N-1 downto 0);
      B : in  std_logic_vector(N-1 downto 0);
      control : in  std_logic_vector(2 downto 0);
      result  : out std_logic_vector(N-1 downto 0)
    );
  end Component;

  Component Multiplexer_3
    generic (N : integer);
    port(
      A,B,C	: in std_logic_vector (N-1 downto 0);
      sel	: in std_logic_vector(1 downto 0);
      result	: out std_logic_vector (N-1 downto 0)
    );
  end component;

  signal input_1_A : std_logic_vector (bits-1 downto 0);
  signal input_1_B : std_logic_vector (bits-1 downto 0);
  signal input_2_A : std_logic_vector (bits-1 downto 0);
  signal input_2_B : std_logic_vector (bits-1 downto 0);
  signal input_3_A : std_logic_vector (bits-1 downto 0);
  signal input_3_B : std_logic_vector (bits-1 downto 0);

  signal result_1 : std_logic_vector (bits-1 downto 0);
  signal result_2 : std_logic_vector (bits-1 downto 0);
  signal result_3 : std_logic_vector (bits-1 downto 0);


begin
  Mux_1_A : Multiplexer_3
    generic map (N => bits)
    port map (A => input_1,
              B => input_2,
              c => input_3,
              sel => sel_mux_1_A,
              result => input_1_A);
  Mux_1_B : Multiplexer_3
    generic map (N => bits)
    port map (A => input_1,
              B => input_2,
              c => input_3,
              sel => sel_mux_1_B,
              result => input_1_B);
  Mux_2_A : Multiplexer_3
    generic map (N => bits)
    port map (A => input_1,
              B => input_2,
              c => input_3,
              sel => sel_mux_2_A,
              result => input_2_A);
  Mux_2_B : Multiplexer_3
    generic map (N => bits)
    port map (A => input_1,
              B => input_2,
              c => input_3,
              sel => sel_mux_2_B,
              result => input_2_B);
  Mux_3_A : Multiplexer_3
    generic map (N => bits)
    port map (A => input_1,
              B => input_2,
              c => input_3,
              sel => sel_mux_3_A,
              result => input_3_A);
  Mux_3_B : Multiplexer_3
    generic map (N => bits)
    port map (A => input_1,
              B => input_2,
              c => input_3,
              sel => sel_mux_3_B,
              result => input_3_B);

  ALU_1 : ALU
    generic map (N => bits)
    port map (A => input_1_A,
              B => input_1_B,
              control => op_1,
              result => result_1
    );
  ALU_2 : ALU
    generic map (N => bits)
    port map (A => input_2_A,
              B => input_2_B,
              control => op_2,
              result => result_2
    );
  ALU_3 : ALU
    generic map (N => bits)
    port map (A => input_3_A,
              B => input_3_B,
              control => op_3,
              result => result_3
    );

  End_mux_1 : Multiplexer_3
    generic map (N => bits)
    port map (A => result_1,
              B => result_2,
              c => result_3,
              sel => sel_end_mux_1,
              result => output_1);
  End_mux_2 : Multiplexer_3
    generic map (N => bits)
    port map (A => result_1,
              B => result_2,
              c => result_3,
              sel => sel_end_mux_2,
              result => output_2);
  End_mux_3 : Multiplexer_3
    generic map (N => bits)
    port map (A => result_1,
              B => result_2,
              c => result_3,
              sel => sel_end_mux_3,
              result => output_3);



end architecture;
