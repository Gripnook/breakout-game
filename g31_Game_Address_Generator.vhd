--
-- entity name: g31_Game_Address_Generator
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus, Vlastimil Lacina
-- Date: November 21st, 2016

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity g31_Game_Address_Generator is
	port (
		column   :  in  unsigned(9 downto 0); -- column 0 to 799
		row      :  in  unsigned(9 downto 0); -- row 0 to 599
		game_col :  out std_logic_vector(6 downto 0); -- game column 0 to 99
		game_row :  out std_logic_vector(6 downto 0); -- game row 0 to 67
		pixel_col : out std_logic_vector(2 downto 0); -- pixel column 0 to 7
		pixel_row : out std_logic_vector(2 downto 0)  -- pixel row 0 to 7
	);
end g31_Game_Address_Generator;

architecture bdf_type of g31_Game_Address_Generator is
begin
	game_col <= std_logic_vector(column(9 downto 3));
	game_row <= std_logic_vector(row(9 downto 3));
	pixel_col <= std_logic_vector(column(2 downto 0));
	pixel_row <= std_logic_vector(row(2 downto 0));
end bdf_type;

