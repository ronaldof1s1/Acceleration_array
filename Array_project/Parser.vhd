library ieee;
use ieee.std_logic_1164.ALL;

entity Parser is
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
end Parser;

architecture Parse of Parser is
begin
	-- first line of input muxss
	 sel_mux_1_1_A <= bitstream(1 downto 0);
	 sel_mux_1_1_B <= bitstream(3 downto 2);
	 sel_mux_1_2_A <= bitstream(5 downto 4);
	 sel_mux_1_2_B <= bitstream(7 downto 6);
	 sel_mux_1_3_A <= bitstream(9 downto 8);
	 sel_mux_1_3_B <= bitstream(11 downto 10);

	-- first line output mux signals
	 line_1_mux_sel_1 <= bitstream(13 downto 12);
	 line_1_mux_sel_2 <= bitstream(15 downto 14);
	 line_1_mux_sel_3 <= bitstream(17 downto 16);

	--first line of operations
	 op_1_1 <= bitstream(20 downto 18);
	 op_1_2 <= bitstream(23 downto 21);
	 op_1_3 <= bitstream(26 downto 24);

	--------------------SECOND LINE--------------------------
	-- second line of input muxs
	 sel_mux_2_1_A <= bitstream(28 downto 27);
	 sel_mux_2_1_B <= bitstream(30 downto 29);
	 sel_mux_2_2_A <= bitstream(32 downto 31);
	 sel_mux_2_2_B <= bitstream(34 downto 33);
	 sel_mux_2_3_A <= bitstream(36 downto 35);
	 sel_mux_2_3_B <= bitstream(38 downto 37);

	-- second line output mux signals
	 line_2_mux_sel_1 <= bitstream(40 downto 39);
	 line_2_mux_sel_2 <= bitstream(42 downto 41);
	 line_2_mux_sel_3 <= bitstream(44 downto 43);

	--second line of operations
	 op_2_1 <= bitstream(47 downto 45);
	 op_2_2 <= bitstream(50 downto 48);
	 op_2_3 <= bitstream(53 downto 51);

	--------------------THIRD LINE--------------------------
	-- third line of input muxs
	 sel_mux_3_1_A <= bitstream(55 downto 54);
	 sel_mux_3_1_B <= bitstream(57 downto 56);
	 sel_mux_3_2_A <= bitstream(59 downto 58);
	 sel_mux_3_2_B <= bitstream(61 downto 60);
	 sel_mux_3_3_A <= bitstream(63 downto 62);
	 sel_mux_3_3_B <= bitstream(65 downto 64);

	-- third line output mux signals
	 line_3_4mux_sel_1 <= bitstream(67 downto 66);
	 line_3_4mux_sel_2 <= bitstream(69 downto 68);
	 line_3_4mux_sel_3 <= bitstream(71 downto 70);
	 line_3_mux_sel_1 <= bitstream(72);
	 line_3_mux_sel_2 <= bitstream(73);
	 line_3_mux_sel_3 <= bitstream(74);

	-- Third line of operations
	 op_3_1 <= bitstream(77 downto 75);
	 op_3_2 <= bitstream(80 downto 78);
	 op_3_3 <= bitstream(83 downto 81);


	--------------------MULTIPLIER DATA--------------------------
	--input muxes selectors for multiplier
	 sel_mux_mult_A <= bitstream(85 downto 84);
	 sel_mux_mult_B <= bitstream(87 downto 86);

	--------------------REGISTER BANK--------------------------

	--store signals of registers
	 Register_1_store <= bitstream(88);
	 Register_2_store <= bitstream(89);
	 Register_3_store <= bitstream(90);

	-- clear signals of registers
	 Register_1_clr  <= bitstream(91);
	 Register_2_clr  <= bitstream(92);
	 Register_3_clr  <= bitstream(93);

end Parse;
