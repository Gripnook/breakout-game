library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;
use WORK.g31_Game_Types.ALL;

entity g31_VGA_Generator is
	port (
		clock      : in  std_logic; -- 50MHz
		score      : in  std_logic_vector(15 downto 0); -- score 0 to 65,535
		level      : in  std_logic_vector( 2 downto 0); -- level 1 to 7
		life       : in  std_logic_vector( 2 downto 0); -- lives left 0 to 7
		ball_col   : in  std_logic_vector( 9 downto 0); -- ball col address 0 to 799
		ball_row   : in  std_logic_vector( 9 downto 0); -- ball row address 0 to 599
		paddle_col : in  std_logic_vector( 9 downto 0); -- paddle col address 0 to 799
		blocks     : in  t_block_array; -- block array
		game_state : in  t_game_state; -- current game state
		r, g, b    : out std_logic_vector( 7 downto 0); -- 8-bit color output
		hsync      : out std_logic; -- horizontal sync signal
		vsync      : out std_logic; -- vertical sync signal
		clock_vga  : out std_logic  -- output clock to drive the ADV7123 DAC
	);
end g31_VGA_Generator;

architecture bdf_type of g31_VGA_Generator is

	signal rst      : std_logic;
	signal column   : unsigned(9 downto 0);
	signal row      : unsigned(9 downto 0);
	signal blanking : std_logic;
	signal font_col, font_col_delayed : std_logic_vector(2 downto 0);
	signal font_row, font_row_delayed : std_logic_vector(3 downto 0);
	signal text_col : std_logic_vector(5 downto 0);
	signal text_row : std_logic_vector(4 downto 0);
	signal ascii    : std_logic_vector(6 downto 0);
	signal text_rgb, text_rgb_delayed : std_logic_vector(23 downto 0);
	signal text_show_bit : std_logic;
	signal wall_rgb : std_logic_vector(23 downto 0);
	signal wall_show_bit : std_logic;
	signal ball_rgb : std_logic_vector(23 downto 0);
	signal ball_show_bit : std_logic;
	signal blocks_rgb : std_logic_vector(23 downto 0);
	signal blocks_show_bit : std_logic;
	signal paddle_rgb : std_logic_vector(23 downto 0);
	signal paddle_show_bit : std_logic;
	
	component g31_VGA is
		port (
			clock    : in  std_logic; -- 50MHz
			rst      : in  std_logic; -- reset
			blanking : out std_logic; -- blank display when zero
			row      : out unsigned(9 downto 0); -- line 0 to 599
			column   : out unsigned(9 downto 0); -- column 0 to 799
			hsync    : out std_logic; -- horizontal sync signal
			vsync    : out std_logic -- vertical sync signal
		);
	end component;

	component g31_Text_Address_Generator is
		port (
			column   : in  unsigned(9 downto 0); -- column 0 to 799
			row      : in  unsigned(9 downto 0); -- row 0 to 599
			text_col : out std_logic_vector(5 downto 0); -- character column 0 to 49
			text_row : out std_logic_vector(4 downto 0); -- character row 0 to 18
			font_col : out std_logic_vector(2 downto 0); -- pixel column 0 to 7
			font_row : out std_logic_vector(3 downto 0)  -- pixel row 0 to 15
		);
	end component;

	component g31_Text_Generator is
		port (
			text_col   : in  std_logic_vector( 5 downto 0); -- character column 0 to 49
			text_row   : in  std_logic_vector( 4 downto 0); -- character row 0 to 18
			score      : in  std_logic_vector(15 downto 0); -- score 0 to 65,535
			level      : in  std_logic_vector( 2 downto 0); -- level 1 to 7
			life       : in  std_logic_vector( 2 downto 0); -- lives left 0 to 7
			game_state : in  t_game_state; -- current game state
			rgb        : out std_logic_vector(23 downto 0); -- 24-bit color to display
			ascii      : out std_logic_vector( 6 downto 0)  -- ascii code of the character to display
		);
	end component;

	component fontROM is
		generic(
			addrWidth: integer := 11;
			dataWidth: integer := 8
		);
		port(
			clkA : in std_logic;
			char_code : in std_logic_vector(6 downto 0); -- 7-bit ASCII character code
			font_row : in std_logic_vector(3 downto 0); -- 0-15 row address in single character
			font_col : in std_logic_vector(2 downto 0); -- 0-7 column address in single character
			font_bit : out std_logic -- pixel value at the given row and column for the selected character code
		);
	end component;

	component g31_Wall_Generator is
		port (
			column   : in  unsigned(9 downto 0); -- column 0 to 799
			row      : in  unsigned(9 downto 0); -- row 0 to 599
			rgb      : out std_logic_vector(23 downto 0); -- 24-bit color to display
			show_bit : out std_logic -- should the pixel be colored or not
		);
	end component;
	
	component g31_Ball_Generator is
		port (
			column   : in  unsigned(9 downto 0); -- column 0 to 799
			row      : in  unsigned(9 downto 0); -- row 0 to 599
			ball_col : in  std_logic_vector( 9 downto 0); -- ball col address 0 to 799
			ball_row : in  std_logic_vector( 9 downto 0); -- ball row address 0 to 599
			rgb      : out std_logic_vector(23 downto 0); -- 24-bit color to display
			show_bit : out std_logic -- should the pixel be colored or not
		);
	end component;
	
	component g31_Block_Generator is
		port (
			column   : in  unsigned(9 downto 0); -- column 0 to 799
			row      : in  unsigned(9 downto 0); -- row 0 to 599
			blocks   : in  t_block_array; -- block array
			rgb      : out std_logic_vector(23 downto 0); -- 24-bit color to display
			show_bit : out std_logic -- should the pixel be colored or not
		);
	end component;
	
	component g31_Paddle_Generator is
		port (
			column     : in  unsigned(9 downto 0); -- column 0 to 799
			row        : in  unsigned(9 downto 0); -- row 0 to 599
			paddle_col : in  std_logic_vector( 9 downto 0); -- paddle col address 0 to 799
			rgb        : out std_logic_vector(23 downto 0); -- 24-bit color to display
			show_bit   : out std_logic -- should the pixel be colored or not
		);
	end component;

begin

	rst <= '0';
	clock_vga <= clock;

	VGA : g31_VGA port map (clock => clock, rst => rst, blanking => blanking, row => row, column => column,
									hsync => hsync, vsync => vsync);
	Text_Address_Generator : g31_Text_Address_Generator port map (column => column, row => row,
									text_col => text_col, text_row => text_row, font_col => font_col, font_row => font_row);
	Text_Generator : g31_Text_Generator port map (text_col => text_col, text_row => text_row,
									score => score, level => level, life => life, game_state => game_state,
									rgb => text_rgb, ascii => ascii);
	CharacterROM : fontROM port map(clkA => clock, char_code => ascii,
									font_row => font_row_delayed, font_col => font_col_delayed,
									font_bit => text_show_bit);
	Wall_Generator : g31_Wall_Generator port map (column => column, row => row, rgb => wall_rgb, show_bit => wall_show_bit);
	Ball_Generator : g31_Ball_Generator port map (column => column, row => row,
									ball_col => ball_col, ball_row => ball_row, rgb => ball_rgb, show_bit => ball_show_bit);
	Block_Generator :  g31_Block_Generator port map (column => column, row => row, blocks => blocks,
									rgb => blocks_rgb, show_bit => blocks_show_bit);
	Paddle_Generator : g31_Paddle_Generator port map (column => column, row => row, paddle_col => paddle_col,
									rgb => paddle_rgb, show_bit => paddle_show_bit);

	Output_RGB : process (blanking, text_show_bit, wall_show_bit, ball_show_bit, blocks_show_bit, paddle_show_bit,
						text_rgb_delayed, wall_rgb, ball_rgb, blocks_rgb, paddle_rgb)
	begin
		r <= x"00";
		g <= x"00";
		b <= x"00";
		if (blanking = '0') then
			r <= x"00";
			g <= x"00";
			b <= x"00";
		elsif (text_show_bit = '1') then 
			r <= text_rgb_delayed(23 downto 16);
			g <= text_rgb_delayed(15 downto  8);
			b <= text_rgb_delayed( 7 downto  0);
		elsif (wall_show_bit = '1') then
			r <= wall_rgb(23 downto 16);
			g <= wall_rgb(15 downto  8);
			b <= wall_rgb( 7 downto  0);
		elsif (ball_show_bit = '1') then
			r <= ball_rgb(23 downto 16);
			g <= ball_rgb(15 downto  8);
			b <= ball_rgb( 7 downto  0);
		elsif (blocks_show_bit = '1') then
			r <= blocks_rgb(23 downto 16);
			g <= blocks_rgb(15 downto  8);
			b <= blocks_rgb( 7 downto  0);
		elsif (paddle_show_bit = '1') then
			r <= paddle_rgb(23 downto 16);
			g <= paddle_rgb(15 downto  8);
			b <= paddle_rgb( 7 downto  0);
		end if;
	end process;

	reg1 : lpm_ff
		generic map (lpm_width => 3)
		port map (clock => clock, data => font_col, q => font_col_delayed);
	reg2 : lpm_ff
		generic map (lpm_width => 4)
		port map (clock => clock, data => font_row, q => font_row_delayed);
	reg3 : lpm_ff
		generic map (lpm_width => 24)
		port map (clock => clock, data => text_rgb, q => text_rgb_delayed);
		
end bdf_type;

