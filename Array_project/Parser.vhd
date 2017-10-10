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
		 op_1_1: out std_logic_vector(2 downto 0) := bitstream(23 downto 21);
		 op_1_2: std_logic_vector(2 downto 0) := bitstream(26 downto 24);
		 op_1_3: std_logic_vector(2 downto 0) := bitstream(29 downto 27);

		  --------------------SECOND LINE--------------------------
		  -- second line of input muxs
		 sel_mux_2_1_A : std_logic_vector(1 downto 0) := bitstream(31 downto 30);
		 sel_mux_2_1_B : std_logic_vector(1 downto 0) := bitstream(33 downto 32);
		 sel_mux_2_2_A : std_logic_vector(1 downto 0) := bitstream(35 downto 34);
		 sel_mux_2_2_B : std_logic_vector(1 downto 0) := bitstream(37 downto 36);
		 sel_mux_2_3_A : std_logic_vector(1 downto 0) := bitstream(39 downto 38);
		 sel_mux_2_3_B : std_logic_vector(1 downto 0) := bitstream(41 downto 40);

		  -- second line output mux signals
		 line_2_4mux_sel_1 : std_logic_vector(1 downto 0) := bitstream(43 downto 42);
		 line_2_4mux_sel_2 : std_logic_vector(1 downto 0) := bitstream(45 downto 44);
		 line_2_4mux_sel_3 : std_logic_vector(1 downto 0) := bitstream(47 downto 46);
		 output_mux_2 : std_logic_vector(7 downto 0);

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

		);
end Parser;

architecture Parse of Parser is

	

end Parse;