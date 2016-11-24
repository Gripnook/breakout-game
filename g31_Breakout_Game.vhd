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
		clock        : in  std_logic; -- 50MHz
		rst_n        : in  std_logic; -- negated reset
		paddle_right : in  std_logic; -- move paddle to the right
		paddle_left  : in  std_logic; -- move paddle to the left
		r, g, b      : out std_logic_vector(7 downto 0); -- 8-bit color output
		hsync        : out std_logic; -- horizontal sync signal
		vsync        : out std_logic; -- vertical sync signal
		clock_vga    : out std_logic  -- output clock to drive the ADV7123 DAC
	);
end g31_Breakout_Game;

architecture bdf_type of g31_Breakout_Game is

signal score : std_logic_vector(15 downto 0) := x"0000"; -- placeholder
signal level : std_logic_vector( 2 downto 0) := "001"; -- placeholder
signal life  : std_logic_vector( 2 downto 0) := "001"; -- placeholder

signal frame_counter : std_logic_vector(25 downto 0);
signal clear_frame_counter : std_logic;

signal ball_col : std_logic_vector(6 downto 0) := "0110001"; -- 49
signal ball_row : std_logic_vector(6 downto 0) := "1000001"; -- 65
-- increment coordinate = "01"; same = "00"; decrement coordinate = "11";
signal ball_vertical_speed : std_logic_vector(1 downto 0) := "11";
signal ball_horizontal_speed : std_logic_vector(1 downto 0) := "11";

signal blocks : std_logic_vector(59 downto 0) := (others => '1');

signal paddle_col : std_logic_vector(6 downto 0) := "0110001"; -- placeholder

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

Update_Game : process (clock, rst_n)
variable ball_next_col, ball_next_row : unsigned(6 downto 0);
begin
	if (rst_n = '0') then
		ball_col <= "0110001"; -- 49
		ball_row <= "1000001"; -- 65
		ball_horizontal_speed <= "11";
		ball_vertical_speed <= "11";
	elsif (rising_edge(clock) and clear_frame_counter = '1') then
		if (ball_horizontal_speed = "01") then
			ball_next_col := unsigned(ball_col) + 1;
			if (ball_next_col + 1 >= 98) then
				ball_horizontal_speed <= "11";
			end if;
		elsif (ball_horizontal_speed = "11") then
			ball_next_col := unsigned(ball_col) - 1;
			if (ball_next_col - 1 < 2) then
				ball_horizontal_speed <= "01";
			end if;
		end if;
		
		if (ball_vertical_speed = "01") then
			ball_next_row := unsigned(ball_row) + 1;
			if (ball_next_row + 1 >= 65) then
				ball_vertical_speed <= "11"; -- should lose a life and reset
			end if;
		elsif (ball_vertical_speed = "11") then
			ball_next_row := unsigned(ball_row) - 1;
			if (ball_next_row - 1 < 2) then
				ball_vertical_speed <= "01";
			end if;
		end if;
		
		ball_col <= std_logic_vector(ball_next_col);
		ball_row <= std_logic_vector(ball_next_row);
	end if;
end process;

end bdf_type;

