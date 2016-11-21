--
-- entity name: g31_Breakout_Game
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus Vlastimil Lacina
-- Date: November 21st, 2016

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
LIBRARY lpm;
USE lpm.lpm_components.all;
USE work.g31_blocker_game.all;

ENTITY g31_Breakout_Game IS
	PORT (
		CLOCK     : IN  STD_LOGIC; -- 50MHz
		RST_N     : IN  STD_LOGIC; -- negated reset
		level     : IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- level 0 to 7
		life      : IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- life 0 to 7
		R, G, B   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		HSYNC     : OUT STD_LOGIC; -- horizontal sync signal
		VSYNC     : OUT STD_LOGIC; -- vertical sync signal
		CLOCK_OUT : OUT STD_LOGIC -- output clock to drive the ADV7123 DAC
	);
END g31_Breakout_Game;

ARCHITECTURE bdf_type OF g31_Breakout_Game IS

SIGNAL RST : STD_LOGIC;

SIGNAL COLUMN   : UNSIGNED(9 DOWNTO 0);
SIGNAL ROW      : UNSIGNED(9 DOWNTO 0);
SIGNAL BLANKING : STD_LOGIC;
SIGNAL font_col, font_col_delayed : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL font_row, font_row_delayed : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL text_col : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL text_row : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rgb, rgb_delayed : STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL ascii    : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL score    : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL score_interval : STD_LOGIC_VECTOR(25 DOWNTO 0);
SIGNAL clear_interval : STD_LOGIC;
SIGNAL font_bit : STD_LOGIC;

SIGNAL game_col : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL game_row : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL pixel_col : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL pixel_row : STD_LOGIC_VECTOR(2 DOWNTO 0);

SIGNAL ball_row : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000001";
SIGNAL ball_col : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110001";
-- increment coordinate = "01"; same = "00"; decrement coordinate = "11";
SIGNAL ball_vertical_speed : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";
SIGNAL ball_horizontal_speed : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";

SIGNAL frame_counter : STD_LOGIC_VECTOR(25 DOWNTO 0);
SIGNAL clear_frame_counter : STD_LOGIC;

SIGNAL blocks : STD_LOGIC_VECTOR(59 DOWNTO 0) := (others => '1');

COMPONENT g31_VGA
	 PORT (
		CLOCK    : IN  STD_LOGIC; -- 50MHz
		RST      : IN  STD_LOGIC; -- reset
		BLANKING : OUT STD_LOGIC; -- blank display when zero
		ROW      : OUT UNSIGNED(9 DOWNTO 0); -- line 0 to 599
		COLUMN   : OUT UNSIGNED(9 DOWNTO 0); -- column 0 to 799
		HSYNC    : OUT STD_LOGIC; -- horizontal sync signal
		VSYNC    : OUT STD_LOGIC -- vertical sync signal
	);
END COMPONENT;

COMPONENT g31_Text_Address_Generator IS
	PORT (
		COLUMN   : IN  UNSIGNED(9 DOWNTO 0); -- column 0 to 799
		ROW      : IN  UNSIGNED(9 DOWNTO 0); -- row 0 to 599
		text_col : OUT STD_LOGIC_VECTOR(5 DOWNTO 0); -- character column 0 to 49
		text_row : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); -- character row 0 to 18
		font_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- pixel column 0 to 7
		font_row : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- pixel row 0 to 15
	);
END COMPONENT;

COMPONENT g31_Text_Generator IS
	PORT (
		text_col : IN STD_LOGIC_VECTOR(5 DOWNTO 0); -- character column 0 to 49
		text_row : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- character row 0 to 18
		score    : IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- score 0 to 65,535
		level    : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- level 0 to 7
		life     : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- lives left 0 to 7
		rgb      : OUT STD_LOGIC_VECTOR(23 DOWNTO 0); -- 24-bit color to display
		ascii    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- ascii code of the character to display
	);
END COMPONENT;

COMPONENT fontROM is
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
end COMPONENT;

COMPONENT g31_Game_Address_Generator IS
	PORT (
		COLUMN   : IN  UNSIGNED(9 DOWNTO 0); -- column 0 to 799
		ROW      : IN  UNSIGNED(9 DOWNTO 0); -- row 0 to 599
		game_col : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- game column 0 to 99
		game_row : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- game row 0 to 67
		pixel_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- pixel column 0 to 7
		pixel_row : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- pixel row 0 to 7
	);
END COMPONENT;

BEGIN
RST <= NOT RST_N;

CLOCK_OUT <= CLOCK;

VGA : g31_VGA PORT MAP (CLOCK => CLOCK, RST => RST, BLANKING => BLANKING,
								ROW => ROW, COLUMN => COLUMN, HSYNC => HSYNC, VSYNC => VSYNC);
Text_Address_Generator : g31_Text_Address_Generator PORT MAP (COLUMN => COLUMN, ROW => ROW, text_col => text_col, text_row => text_row,
								font_col => font_col, font_row => font_row);
Text_Generator : g31_Text_Generator PORT MAP (text_col => text_col, text_row => text_row, score => score, level => level, life => life,
								rgb => rgb, ascii => ascii);
CharacterROM : fontROM PORT MAP(clkA => CLOCK, char_code => ascii, font_row => font_row_delayed, font_col => font_col_delayed, font_bit => font_bit);
Game_Address_Generator : g31_Game_Address_Generator PORT MAP(COLUMN => COLUMN, ROW => ROW,
								game_col => game_col, game_row => game_row, pixel_col => pixel_col, pixel_row => pixel_row);

counter_score_interval : lpm_counter -- counts up to 1 second to only increment score every second.
		GENERIC MAP (LPM_WIDTH => 26)
		PORT MAP (CLOCK => CLOCK, SCLR => clear_interval, Q => score_interval);
counter_score : lpm_counter
		GENERIC MAP (LPM_WIDTH => 16)
		PORT MAP (CLOCK => CLOCK, CNT_EN => clear_interval, Q => score);

-- 49,999,999 clock cycles
clear_interval <= '1' WHEN score_interval = "10111110101111000001111111" ELSE
	'0';

Output_Color : PROCESS (BLANKING, rgb_delayed, font_bit, ball_col, ball_row, game_col, game_row, pixel_col, pixel_row)
BEGIN
	R <= x"00";
	G <= x"00";
	B <= x"00";
	IF (BLANKING = '0') THEN
		R <= x"00";
		G <= x"00";
		B <= x"00";
	ELSIF (font_bit = '1') THEN 
		R <= rgb_delayed(23 DOWNTO 16);
		G <= rgb_delayed(15 DOWNTO 8);
		B <= rgb_delayed(7 DOWNTO 0);
	ELSIF ((UNSIGNED(game_col) < 2 OR UNSIGNED(game_col) >= 98) AND UNSIGNED(game_row) < 68) OR (UNSIGNED(game_row) < 2) THEN
		R <= x"7F";
		G <= x"00";
		B <= x"FF";
	ELSIF (ball_col = game_col AND ball_row = game_row) THEN
		R <= x"FF";
		G <= x"FF";
		B <= x"FF";
	ELSIF (display_block(blocks, game_col, game_row, pixel_col, pixel_row) = '1') THEN
		R <= x"00";
		G <= x"00";
		B <= x"FF";
	END IF;
END PROCESS;

counter_frame : lpm_counter -- counts up to 1/32 second to only update the ball frame every 1/32s.
		GENERIC MAP (LPM_WIDTH => 26)
		PORT MAP (CLOCK => CLOCK, SCLR => clear_frame_counter, Q => frame_counter);
clear_frame_counter <= '1' WHEN frame_counter = "00000101111101011110000011" ELSE
	'0';

Update_Ball : PROCESS (CLOCK, RST, frame_counter, ball_col, ball_row)
VARIABLE ball_next_col, ball_next_row : UNSIGNED(6 DOWNTO 0);
BEGIN
	IF (RST = '1') THEN
		ball_row <= "1000001";
		ball_col <= "0110001";
		ball_vertical_speed <= "11";
		ball_horizontal_speed <= "11";
	ELSIF (rising_edge(CLOCK) AND clear_frame_counter = '1') THEN
		IF (ball_horizontal_speed = "01") THEN
			ball_next_col := UNSIGNED(ball_col) + 1;
		ELSIF (ball_horizontal_speed = "11") THEN
			ball_next_col := UNSIGNED(ball_col) - 1;
		END IF;
		
		IF (ball_vertical_speed = "01") THEN
			ball_next_row := UNSIGNED(ball_row) + 1;
		ELSIF (ball_vertical_speed = "11") THEN
			ball_next_row := UNSIGNED(ball_row) - 1;
		END IF;
		
		IF (ball_horizontal_speed = "01" AND (ball_next_col + 1 >= 98)) THEN
			ball_horizontal_speed <= "11";
		ELSIF (ball_horizontal_speed = "11" AND (ball_next_col - 1 < 2)) THEN
			ball_horizontal_speed <= "01";
		END IF;
		
		IF (ball_vertical_speed = "01" AND (ball_next_row + 1 >= 65)) THEN
			ball_vertical_speed <= "11"; -- should lose a life and reset
		ELSIF (ball_vertical_speed = "11" AND (ball_next_row - 1 < 2)) THEN
			ball_vertical_speed <= "01";
		END IF;
		
		ball_col <= STD_LOGIC_VECTOR(ball_next_col);
		ball_row <= STD_LOGIC_VECTOR(ball_next_row);
	END IF;
END PROCESS;

reg1 : lpm_ff
	GENERIC MAP (LPM_WIDTH => 3)
	PORT MAP (CLOCK => CLOCK, data => font_col, q => font_col_delayed);
reg2 : lpm_ff
	GENERIC MAP (LPM_WIDTH => 4)
	PORT MAP (CLOCK => CLOCK, data => font_row, q => font_row_delayed);
reg3 : lpm_ff
	GENERIC MAP (LPM_WIDTH => 24)
	PORT MAP (CLOCK => CLOCK, data => rgb, q => rgb_delayed);

END bdf_type;
