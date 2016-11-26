--
-- entity name: g31_VGA
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus, Vlastimil Lacina
-- Date: October 24th, 2016

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;

entity g31_VGA is
	port (
		clock    : in  std_logic; -- 50MHz
		rst      : in  std_logic; -- reset
		blanking : out std_logic; -- blank display when zero
		row      : out unsigned(9 downto 0); -- line 0 to 599
		column   : out unsigned(9 downto 0); -- column 0 to 799
		hsync    : out std_logic; -- horizontal sync signal
		vsync    : out std_logic  -- vertical sync signal
	);
end g31_VGA;

architecture bdf_type of g31_VGA is

	signal clear_x, clear_y : std_logic;
	signal count_x : std_logic_vector(10 downto 0);
	signal count_x_int : integer;
	signal count_y : std_logic_vector( 9 downto 0);
	signal count_y_int : integer;
	signal count_en_y : std_logic;

begin

	counter_x : lpm_counter
		generic map (lpm_width => 11)
		port map (clock => clock, sclr => clear_x, q => count_x);
	counter_y : lpm_counter
		generic map (lpm_width => 10)
		port map (clock => clock, cnt_en => count_en_y, sclr => clear_y, q => count_y);
	
	with count_x select
		clear_x <= '1' when "10000001111", -- 1039
			'0' when others;
	with count_y select
		clear_y <= '1' when "1010011001", -- 665
			'0' when others;
	with count_x select
		count_en_y <= '1' when "10000001111", -- 1039
			'0' when others;
	
	count_x_int <= to_integer(unsigned(count_x));
	count_y_int <= to_integer(unsigned(count_y));
	
	row <= to_unsigned(count_y_int - 43, 10) when (count_y_int >= 43 and count_y_int <= 642) else
		to_unsigned(599, 10);
	column <= to_unsigned(count_x_int - 176, 10) when (count_x_int >= 176 and count_x_int <= 975) else
		to_unsigned(799, 10);
	
	blanking <= '0' when ((count_y_int < 43 or count_y_int > 642) or ((count_x_int < 176 or count_x_int > 975))) else
		'1';
	
	hsync <= '0' when (count_x_int < 120) else
		'1';
	vsync <= '0' when (count_y_int < 6) else
		'1';
	
end bdf_type;

