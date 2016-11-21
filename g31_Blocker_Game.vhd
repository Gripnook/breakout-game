--
-- entity name: g31_Blocker_Game
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus Vlastimil Lacina
-- Date: November 10th, 2016

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

package g31_blocker_game is
	function to_bcd (bin : std_logic_vector(15 downto 0)) return std_logic_vector;
	function bcd_to_ascii (bcd : std_logic_vector(3 downto 0)) return std_logic_vector;
	function display_block(blocks : std_logic_vector(59 downto 0);
			game_col, game_row : std_logic_vector(6 downto 0);
			pixel_col, pixel_row : std_logic_vector(2 downto 0)) return std_logic;
end g31_blocker_game;

package body g31_blocker_game is

	function to_bcd (bin : std_logic_vector(15 downto 0)) return std_logic_vector is
	variable i : integer := 0;
	variable j : integer := 1;
	variable bcd : std_logic_vector(19 downto 0) := (others => '0');
	variable bint : std_logic_vector(15 downto 0) := bin;

	begin
	for i in 0 to 15 loop
		bcd(19 downto 1) := bcd(18 downto 0); -- shift the bcd bits.
		bcd(0) := bint(15);
		
		bint(15 downto 1) := bint(14 downto 0); -- shift the input bits.
		bint(0) := '0';
		
		for j in 1 to 5 loop -- for each BCD digit add 3 if it is greater than 4.
			if (i < 15 and bcd ((4*j-1) downto (4*j-4)) > "0100") then
				bcd((4*j-1) downto (4*j-4)) := std_logic_vector(unsigned(bcd((4*j-1) downto (4*j-4))) + "0011");
			end if;
		end loop;
	end loop;
	return bcd;
	end to_bcd;
	
	function bcd_to_ascii (bcd : std_logic_vector(3 downto 0)) return std_logic_vector is
	variable ascii : std_logic_vector(6 downto 0) := (others => '0');
	begin
	ascii := std_logic_vector(("000" & unsigned(bcd)) + "0110000"); -- add the character 0 in ascii.
	return ascii;
	end bcd_to_ascii;
	
	function display_block(blocks : std_logic_vector(59 downto 0);
			game_col, game_row : std_logic_vector(6 downto 0);
			pixel_col, pixel_row : std_logic_vector(2 downto 0)) return std_logic is
	variable row_pos : std_logic_vector(6 downto 0);
	variable col_pos : std_logic_vector(6 downto 0);
	begin
	if (UNSIGNED(game_row) < 2 or UNSIGNED(game_row) > 21 or UNSIGNED(game_col) < 2 or UNSIGNED(game_col) >= 98) then
		return '0';
	end if;
	
	row_pos := (std_logic_vector(UNSIGNED(game_row) - TO_UNSIGNED(2, 7)));
	col_pos := (std_logic_vector(UNSIGNED(game_col) - TO_UNSIGNED(2, 7)));
	if (blocks(12 * to_integer(UNSIGNED(row_pos(6 downto 2))) + to_integer(UNSIGNED(col_pos(6 downto 3)))) = '1') then
		if ((row_pos(1 downto 0) = "00" and pixel_row = "000") or
		(row_pos(1 downto 0) = "11" and pixel_row = "111") or
		(col_pos(2 downto 0) = "000" and pixel_col = "000") or
		(col_pos(2 downto 0) = "111" and pixel_col = "111")) then
			return '0';
		else	
			return '1';
		end if;
	end if;
	
	return '0';
	
	end display_block;

end g31_blocker_game;
