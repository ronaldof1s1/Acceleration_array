library ieee;
use ieee.std_logic_1644.ALL;

entity Parser is
	port(
		  bitstream : in std_logic_vector(99 downto 0);
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
			line_2_4mux_sel_1 : out std_logic_vector(1 downto 0);
			line_2_4mux_sel_2 : out std_logic_vector(1 downto 0);
			line_2_4mux_sel_3 : out std_logic_vector(1 downto 0);

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
end Parser;

architecture Parse of Parser is
begin

	

end Parse;
