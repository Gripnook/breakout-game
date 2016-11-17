--
-- entity name: g31_Text_Generator
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus Vlastimil Lacina
-- Date: November 7th, 2016

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.g31_blocker_game.all;

ENTITY g31_Text_Generator IS
	PORT (
		text_col : IN STD_LOGIC_VECTOR(5 DOWNTO 0); -- character column 0 to 49
		text_row : IN STD_LOGIC_VECTOR(4 DOWNTO 0); -- character row 0 to 18
		score    : IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- score 0 to 65,535
		level    : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- level 0 to 7
		life     : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- lives left 0 to 7
		rgb      : OUT STD_LOGIC_VECTOR(23 DOWNTO 0); -- 24-bit color to display
		ascii    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- ascii code of the character to display
	);
END g31_Text_Generator;

ARCHITECTURE bdf_type OF g31_Text_Generator IS
BEGIN
	text_gen : PROCESS (text_col, text_row, score, level, life)
	variable ascii_8bit : std_logic_vector(7 downto 0); -- we use 8-bit hex notation throughout, then convert to 7-bits.
	BEGIN
		IF TO_INTEGER(UNSIGNED(text_row)) = 17 THEN
			CASE TO_INTEGER(UNSIGNED(text_col)) IS
				WHEN 0 =>
					ascii_8bit := x"53";
					rgb <= x"FF0000";
				WHEN 1 =>
					ascii_8bit := x"43";
					rgb <= x"FF0000";
				WHEN 2 =>
					ascii_8bit := x"4F";
					rgb <= x"FF0000";
				WHEN 3 =>
					ascii_8bit := x"52";
					rgb <= x"FF0000";
				WHEN 4 =>
					ascii_8bit := x"45";
					rgb <= x"FF0000";
				WHEN 5 =>
					ascii_8bit := x"3A";
					rgb <= x"FF0000";
				WHEN 6 =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN 7 =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(score)(19 downto 16));
					rgb <= x"FFFFFF";
				WHEN 8 =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(score)(15 downto 12));
					rgb <= x"FFFFFF";
				WHEN 9 =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(score)(11 downto 8));
					rgb <= x"FFFFFF";
				WHEN 10 =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(score)(7 downto 4));
					rgb <= x"FFFFFF";
				WHEN 11 =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(score)(3 downto 0));
					rgb <= x"FFFFFF";
				WHEN 12 =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN 13 =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN 14 =>
					ascii_8bit := x"4C";
					rgb <= x"FFFF00";
				WHEN 15 =>
					ascii_8bit := x"45";
					rgb <= x"FFFF00";
				WHEN 16 =>
					ascii_8bit := x"56";
					rgb <= x"FFFF00";
				WHEN 17 =>
					ascii_8bit := x"45";
					rgb <= x"FFFF00";
				WHEN 18 =>
					ascii_8bit := x"4C";
					rgb <= x"FFFF00";
				WHEN 19 =>
					ascii_8bit := x"3A";
					rgb <= x"FFFF00";
				WHEN 20 =>
					ascii_8bit := "0" & bcd_to_ascii("0" & level);
					rgb <= x"FFFFFF";
				WHEN 21 =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN 22 =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN 23 =>
					if (unsigned(life) >= 7) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN 24 =>
					if (unsigned(life) >= 6) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN 25 =>
					if (unsigned(life) >= 5) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN 26 =>
					if (unsigned(life) >= 4) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN 27 =>
					if (unsigned(life) >= 3) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN 28 =>
					if (unsigned(life) >= 2) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN 29 =>
					if (unsigned(life) >= 1) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN OTHERS =>
					ascii_8bit := x"20";
					rgb <= x"000000";
			END CASE;
		ELSE
			ascii_8bit := x"20";
			rgb <= x"000000";
		END IF;
		ascii <= ascii_8bit(6 downto 0);
	END PROCESS;
END bdf_type;

