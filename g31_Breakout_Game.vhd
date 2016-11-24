--
-- entity name: g31_Breakout_Game
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus, Vlastimil Lacina
-- Date: November 21st, 2016

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;

entity g31_Breakout_Game is
	port (
		clock          : in  std_logic; -- 50MHz
		rst_n          : in  std_logic; -- negated reset
		paddle_right_n : in  std_logic; -- move paddle to the right when low
		paddle_left_n  : in  std_logic; -- move paddle to the left when low
		r, g, b        : out std_logic_vector(7 downto 0); -- 8-bit color output
		hsync          : out std_logic; -- horizontal sync signal
		vsync          : out std_logic; -- vertical sync signal
		clock_vga      : out std_logic  -- output clock to drive the ADV7123 DAC
	);
end g31_Breakout_Game;

architecture bdf_type of g31_Breakout_Game is

-- returns the index of the block at the position (col,row) or "111111" if there is no block
function find_block_index(blocks : std_logic_vector(59 downto 0);
			col, row : std_logic_vector(6 downto 0)) return std_logic_vector is
	variable row_pos : std_logic_vector(6 downto 0);
	variable col_pos : std_logic_vector(6 downto 0);
	variable index   : integer;
	begin
	if (unsigned(row) < 2 or unsigned(row) > 21 or unsigned(col) < 2 or unsigned(col) >= 98) then
		return "111111";
	end if;
	
	-- address of a block = 12 * ((game_row - 2)/4) + ((game_col - 2)/8)
	row_pos := (std_logic_vector(unsigned(row) - to_unsigned(2, 7)));
	col_pos := (std_logic_vector(unsigned(col) - to_unsigned(2, 7)));
	index   := 12 * to_integer(unsigned(row_pos(6 downto 2))) + to_integer(unsigned(col_pos(6 downto 3)));
	if (blocks(index) = '1') then
		return std_logic_vector(to_unsigned(index, 6));
	end if;
	
	return "111111";
end find_block_index;

function all_blocks_broken(blocks : std_logic_vector(59 downto 0)) return std_logic is
variable result : std_logic := '0';
begin
	for i in 0 to blocks'length - 1 loop
		result := result or blocks(i);
	end loop;
	return not result;
end all_blocks_broken;

signal score : std_logic_vector(15 downto 0) := x"0000";
signal level : std_logic_vector( 2 downto 0) := "001";
signal life  : std_logic_vector( 2 downto 0) := "101";

signal frame_counter : std_logic_vector(25 downto 0);
signal clear_frame_counter : std_logic;

signal ball_col : std_logic_vector(6 downto 0) := "0110001"; -- 49
signal ball_row : std_logic_vector(6 downto 0) := "1000001"; -- 65
-- increment coordinate = "01"; same = "00"; decrement coordinate = "11";
signal ball_vertical_speed : std_logic_vector(1 downto 0) := "11";
signal ball_horizontal_speed : std_logic_vector(1 downto 0) := "11";

signal blocks : std_logic_vector(59 downto 0) := (others => '1');

signal paddle_counter : std_logic_vector(25 downto 0);
signal clear_paddle_counter : std_logic;

signal paddle_col : std_logic_vector(6 downto 0) := "0101010";

component g31_VGA_Generator is
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
end component;

begin

VGA_Generator : g31_VGA_Generator port map (clock => clock, score => score, level => level, life => life,
								ball_col => ball_col, ball_row => ball_row, paddle_col => paddle_col, blocks => blocks,
								r => r, g => g, b => b, hsync => hsync, vsync => vsync, clock_vga => clock_vga);

counter_frame : lpm_counter
		generic map (lpm_width => 26)
		port map (clock => clock, sclr => clear_frame_counter, q => frame_counter);
-- clear frame counter when equal to 50e6/32 - 1 for a frame every 1/32 seconds
clear_frame_counter <= '1' when frame_counter = "00000101111101011110000011" else 
	'0';

Update_Ball : process (clock, rst_n)
variable ball_next_col, ball_next_row : unsigned(6 downto 0);
variable block_index : std_logic_vector(5 downto 0);
variable score_increase : integer;
begin
	if (rst_n = '0') then
		score <= x"0000";
		level <= "001";
		life <= "101";
		ball_col <= "0110001"; -- 49
		ball_row <= "1000001"; -- 65
		ball_horizontal_speed <= "11";
		ball_vertical_speed <= "11";
		blocks <= (others => '1');
	elsif (rising_edge(clock) and clear_frame_counter = '1') then
		if (ball_horizontal_speed = "01") then
			ball_next_col := unsigned(ball_col) + 1;
			block_index := find_block_index(blocks, std_logic_vector(ball_next_col + to_unsigned(1, 7)), std_logic_vector(ball_next_row));
			if (ball_next_col + 1 >= 98) then
				ball_horizontal_speed <= "11";
			elsif (not (block_index = "111111")) then
				blocks(to_integer(unsigned(block_index))) <= '0';
				score_increase := (5 - to_integer(unsigned(block_index)) / 12) * to_integer(unsigned(level));
				score <= std_logic_vector(unsigned(score) + to_unsigned(score_increase, 16));
				ball_horizontal_speed <= "11";
			end if;
		elsif (ball_horizontal_speed = "11") then
			ball_next_col := unsigned(ball_col) - 1;
			block_index := find_block_index(blocks, std_logic_vector(ball_next_col - to_unsigned(1, 7)), std_logic_vector(ball_next_row));
			if (ball_next_col - 1 < 2) then
				ball_horizontal_speed <= "01";
			elsif (not (block_index = "111111")) then
				blocks(to_integer(unsigned(block_index))) <= '0';
				score_increase := (5 - to_integer(unsigned(block_index)) / 12) * to_integer(unsigned(level));
				score <= std_logic_vector(unsigned(score) + to_unsigned(score_increase, 16));
				ball_horizontal_speed <= "01";
			end if;
		end if;
		
		if (ball_vertical_speed = "01") then
			ball_next_row := unsigned(ball_row) + 1;
			block_index := find_block_index(blocks, std_logic_vector(ball_next_col), std_logic_vector(ball_next_row + to_unsigned(1, 7)));
			if (ball_next_row + 1 >= 67) then
				if (life = "001") then
					score <= x"0000";
					level <= "001";
					life <= "101";
					ball_next_col := "0110001"; -- 49
					ball_next_row := "1000001"; -- 65
					ball_horizontal_speed <= "11";
					ball_vertical_speed <= "11";
					blocks <= (others => '1');
				else
					life <= std_logic_vector(unsigned(life) - to_unsigned(1, 3));
					ball_next_col := "0110001"; -- 49
					ball_next_row := "1000001"; -- 65
					ball_horizontal_speed <= "11";
					ball_vertical_speed <= "11";
				end if;
			elsif (not (block_index = "111111")) then
				blocks(to_integer(unsigned(block_index))) <= '0';
				score_increase := (5 - to_integer(unsigned(block_index)) / 12) * to_integer(unsigned(level));
				score <= std_logic_vector(unsigned(score) + to_unsigned(score_increase, 16));
				ball_vertical_speed <= "11";
			elsif ((ball_next_col >= unsigned(paddle_col) and ball_next_col < unsigned(paddle_col) + 16) and ball_next_row + 1 = 66) then
				ball_vertical_speed <= "11";
			end if;
		elsif (ball_vertical_speed = "11") then
			ball_next_row := unsigned(ball_row) - 1;
			block_index := find_block_index(blocks, std_logic_vector(ball_next_col), std_logic_vector(ball_next_row - to_unsigned(1, 7)));
			if (ball_next_row - 1 < 2) then
				ball_vertical_speed <= "01";
			elsif (not (block_index = "111111")) then
				blocks(to_integer(unsigned(block_index))) <= '0';
				score_increase := (5 - to_integer(unsigned(block_index)) / 12) * to_integer(unsigned(level));
				score <= std_logic_vector(unsigned(score) + to_unsigned(score_increase, 16));
				ball_vertical_speed <= "01";
			end if;
		end if;
		
		if (all_blocks_broken(blocks) = '1') then
			if (level = "111") then
				score <= x"0000";
				level <= "001";
				life <= "101";
				ball_next_col := "0110001"; -- 49
				ball_next_row := "1000001"; -- 65
				ball_horizontal_speed <= "11";
				ball_vertical_speed <= "11";
				blocks <= (others => '1');
			else
				level <= std_logic_vector(unsigned(level) + to_unsigned(1, 3));
				ball_next_col := "0110001"; -- 49
				ball_next_row := "1000001"; -- 65
				ball_horizontal_speed <= "11";
				ball_vertical_speed <= "11";
				blocks <= (others => '1');
			end if;
		end if;
		
		ball_col <= std_logic_vector(ball_next_col);
		ball_row <= std_logic_vector(ball_next_row);
	end if;
end process;

counter_paddle : lpm_counter
		generic map (lpm_width => 26)
		port map (clock => clock, sclr => clear_paddle_counter, q => paddle_counter);
-- clear frame counter when equal to 50e6/64 - 1 for a frame every 1/64 seconds
clear_paddle_counter <= '1' when paddle_counter = "00000010111110101111000001" else 
	'0';
	
Update_Paddle : process (clock)
begin
	if (rising_edge(clock) and clear_paddle_counter = '1') then
		if (paddle_right_n = '0' and paddle_left_n = '0') then
			-- do nothing
		elsif (paddle_right_n = '0' and unsigned(paddle_col) < 98 - 16) then
			paddle_col <= std_logic_vector(unsigned(paddle_col) + to_unsigned(1, 7));
		elsif (paddle_left_n = '0' and unsigned(paddle_col) >= 2) then
			paddle_col <= std_logic_vector(unsigned(paddle_col) - to_unsigned(1, 7));
		end if;
	end if;
end process;

end bdf_type;

