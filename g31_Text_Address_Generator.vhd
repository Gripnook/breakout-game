--
-- entity name: g31_Text_Address_Generator
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus Vlastimil Lacina
-- Date: November 7th, 2016

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY g31_Text_Address_Generator IS
	PORT (
		COLUMN   : IN  UNSIGNED(9 DOWNTO 0); -- column 0 to 799
		ROW      : IN  UNSIGNED(9 DOWNTO 0); -- row 0 to 599
		text_col : OUT STD_LOGIC_VECTOR(5 DOWNTO 0); -- character column 0 to 49
		text_row : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); -- character row 0 to 18
		font_col : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- pixel column 0 to 7
		font_row : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- pixel row 0 to 15
	);
END g31_Text_Address_Generator;

ARCHITECTURE bdf_type OF g31_Text_Address_Generator IS
BEGIN
	text_col <= STD_LOGIC_VECTOR(COLUMN(9 DOWNTO 4));
	text_row <= STD_LOGIC_VECTOR(ROW(9 DOWNTO 5));
	font_col <= STD_LOGIC_VECTOR(COLUMN(3 DOWNTO 1));
	font_row <= STD_LOGIC_VECTOR(ROW(4 DOWNTO 1));
END bdf_type;

