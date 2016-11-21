--
-- entity name: g31_Game_Address_Generator
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus Vlastimil Lacina
-- Date: November 21st, 2016

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY g31_Game_Address_Generator IS
	PORT (
		COLUMN   : IN  UNSIGNED(9 DOWNTO 0); -- column 0 to 799
		ROW      : IN  UNSIGNED(9 DOWNTO 0); -- row 0 to 599
		game_col : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- game column 0 to 99
		game_row : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- game row 0 to 67
		pixel_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- pixel column 0 to 7
		pixel_row : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- pixel row 0 to 7
	);
END g31_Game_Address_Generator;

ARCHITECTURE bdf_type OF g31_Game_Address_Generator IS
BEGIN
	game_col <= STD_LOGIC_VECTOR(COLUMN(9 DOWNTO 3));
	game_row <= STD_LOGIC_VECTOR(ROW(9 DOWNTO 3));
	pixel_col <= STD_LOGIC_VECTOR(COLUMN(2 DOWNTO 0));
	pixel_row <= STD_LOGIC_VECTOR(ROW(2 DOWNTO 0));
END bdf_type;

