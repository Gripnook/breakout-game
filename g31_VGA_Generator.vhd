--
-- entity name: g31_VGA_Generator
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus, Vlastimil Lacina
-- Date: November 23rd, 2016

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;

entity g31_VGA_Generator is
	port (
		clock      : in  std_logic; -- 50MHz
		score      : in  std_logic_vector(15 downto 0); -- score 0 to 65,535
		level      : in  std_logic_vector( 2 downto 0); -- level 0 to 7
		life       : in  std_logic_vector( 2 downto 0); -- lives left 0 to 7
		ball_col   : in  std_logic_vector( 6 downto 0); -- ball col address 0 to 99
		ball_row   : in  std_logic_vector( 6 downto 0); -- ball row address 0 to 67
		paddle_col : in  std_logic_vector( 6 downto 0); -- paddle col address 0 to 99
		blocks     : in  std_logic_vector(59 downto 0); -- blocks present or not bitmask
		r, g, b    : out std_logic_vector( 7 downto 0); -- 8-bit color output
		hsync      : out std_logic; -- horizontal sync signal
		vsync      : out std_logic; -- vertical sync signal
		clock_vga  : out std_logic  -- output clock to drive the ADV7123 DAC
	);
end g31_VGA_Generator;

architecture bdf_type of g31_VGA_Generator is

function display_block(blocks : std_logic_vector(59 downto 0);
			game_col, game_row : std_logic_vector(6 downto 0);
			pixel_col, pixel_row : std_logic_vector(2 downto 0)) return std_logic is
	variable row_pos : std_logic_vector(6 downto 0);
	variable col_pos : std_logic_vector(6 downto 0);
	begin
	if (unsigned(game_row) < 2 or unsigned(game_row) > 21 or unsigned(game_col) < 2 or unsigned(game_col) >= 98) then
		return '0';
	end if;
	
	-- address of a block = 12 * ((game_row - 2)/4) + ((game_col - 2)/8)
	row_pos := (std_logic_vector(unsigned(game_row) - to_unsigned(2, 7)));
	col_pos := (std_logic_vector(unsigned(game_col) - to_unsigned(2, 7)));
	if (blocks(12 * to_integer(unsigned(row_pos(6 downto 2))) + to_integer(unsigned(col_pos(6 downto 3)))) = '1') then
		-- check if the pixel is on the edge of the block (border)
		if ((row_pos(1 downto 0) =  "00" and pixel_row = "000") or
			 (row_pos(1 downto 0) =  "11" and pixel_row = "111") or
			 (col_pos(2 downto 0) = "000" and pixel_col = "000") or
			 (col_pos(2 downto 0) = "111" and pixel_col = "111")) then
			return '0';
		else
			return '1';
		end if;
	end if;
	
	return '0';
end display_block;

signal rst      : std_logic;
signal column   : unsigned(9 downto 0);
signal row      : unsigned(9 downto 0);
signal blanking : std_logic;
signal font_col, font_col_delayed : std_logic_vector(2 downto 0);
signal font_row, font_row_delayed : std_logic_vector(3 downto 0);
signal text_col : std_logic_vector(5 downto 0);
signal text_row : std_logic_vector(4 downto 0);
signal text_rgb, text_rgb_delayed : std_logic_vector(23 downto 0);
signal ascii    : std_logic_vector(6 downto 0);
signal text_font_bit : std_logic;
signal game_col : std_logic_vector(6 downto 0);
signal game_row : std_logic_vector(6 downto 0);
signal pixel_col : std_logic_vector(2 downto 0);
signal pixel_row : std_logic_vector(2 downto 0);

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
		text_col : in  std_logic_vector( 5 downto 0); -- character column 0 to 49
		text_row : in  std_logic_vector( 4 downto 0); -- character row 0 to 18
		score    : in  std_logic_vector(15 downto 0); -- score 0 to 65,535
		level    : in  std_logic_vector( 2 downto 0); -- level 0 to 7
		life     : in  std_logic_vector( 2 downto 0); -- lives left 0 to 7
		rgb      : out std_logic_vector(23 downto 0); -- 24-bit color to display
		ascii    : out std_logic_vector( 6 downto 0)  -- ascii code of the character to display
	);
end component;

component fontROM is
	generic(
		addrWidth: integer := 11;
		dataWidth: integer := 8
	);
	port(
		clkA: in std_logic;
		char_code : in std_logic_vector(6 downto 0); -- 7-bit ASCII character code
		font_row : in std_logic_vector(3 downto 0); -- 0-15 row address in single character
		font_col : in std_logic_vector(2 downto 0); -- 0-7 column address in single character
		font_bit : out std_logic -- pixel value at the given row and column for the selected character code
	);
end component;

component g31_Game_Address_Generator is
	port (
		column   :  in  unsigned(9 downto 0); -- column 0 to 799
		row      :  in  unsigned(9 downto 0); -- row 0 to 599
		game_col :  out std_logic_vector(6 downto 0); -- game column 0 to 99
		game_row :  out std_logic_vector(6 downto 0); -- game row 0 to 67
		pixel_col : out std_logic_vector(2 downto 0); -- pixel column 0 to 7
		pixel_row : out std_logic_vector(2 downto 0)  -- pixel row 0 to 7
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
								score => score, level => level, life => life, rgb => text_rgb, ascii => ascii);
CharacterROM : fontROM port map(clkA => clock, char_code => ascii, font_row => font_row_delayed, font_col => font_col_delayed,
								font_bit => text_font_bit);
Game_Address_Generator : g31_Game_Address_Generator port map(column => column, row => row,
								game_col => game_col, game_row => game_row, pixel_col => pixel_col, pixel_row => pixel_row);

Output_RGB : process (blanking, text_font_bit, ball_col, ball_row, game_col, game_row, pixel_col, pixel_row, blocks)
begin
	r <= x"00";
	g <= x"00";
	b <= x"00";
	if (blanking = '0') then
		r <= x"00";
		g <= x"00";
		b <= x"00";
	elsif (text_font_bit = '1') then 
		r <= text_rgb_delayed(23 downto 16);
		g <= text_rgb_delayed(15 downto 8);
		b <= text_rgb_delayed(7 downto 0);
	elsif ((unsigned(game_col) < 2 or unsigned(game_col) >= 98) and unsigned(game_row) < 68) or (unsigned(game_row) < 2) then
		r <= x"7F";
		g <= x"00";
		b <= x"FF";
	elsif (ball_col = game_col and ball_row = game_row) then
		r <= x"FF";
		g <= x"FF";
		b <= x"FF";
	elsif (display_block(blocks, game_col, game_row, pixel_col, pixel_row) = '1') then
		r <= x"00";
		g <= x"00";
		b <= x"FF";
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
