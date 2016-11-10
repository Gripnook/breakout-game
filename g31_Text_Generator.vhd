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
		text_col : IN UNSIGNED(5 DOWNTO 0); -- character column 0 to 49
		text_row : IN UNSIGNED(4 DOWNTO 0); -- character row 0 to 18
		score    : IN UNSIGNED(15 DOWNTO 0); -- score 0 to 65,535
		level    : IN UNSIGNED(2 DOWNTO 0); -- level 0 to 7
		life     : IN UNSIGNED(2 DOWNTO 0); -- lives left 0 to 7
		rgb      : OUT STD_LOGIC_VECTOR(23 DOWNTO 0); -- 24-bit color to display
		ascii    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- ascii code of the character to display
	);
END g31_Text_Generator;

ARCHITECTURE bdf_type OF g31_Text_Generator IS
BEGIN
	text_gen : PROCESS (text_col, text_row, score, level, life)
	variable ascii_8bit : std_logic_vector(7 downto 0); -- we use 8-bit hex notation throughout, then convert to 7-bits.
	BEGIN
		IF text_row = 18 THEN
			CASE text_col IS
				WHEN TO_UNSIGNED(0, 6) =>
					ascii_8bit := x"53";
					rgb <= x"FF0000";
				WHEN TO_UNSIGNED(1, 6) =>
					ascii_8bit := x"43";
					rgb <= x"FF0000";
				WHEN TO_UNSIGNED(2, 6) =>
					ascii_8bit := x"4F";
					rgb <= x"FF0000";
				WHEN TO_UNSIGNED(3, 6) =>
					ascii_8bit := x"52";
					rgb <= x"FF0000";
				WHEN TO_UNSIGNED(4, 6) =>
					ascii_8bit := x"45";
					rgb <= x"FF0000";
				WHEN TO_UNSIGNED(5, 6) =>
					ascii_8bit := x"3A";
					rgb <= x"FF0000";
				WHEN TO_UNSIGNED(6, 6) =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN TO_UNSIGNED(7, 6) =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(std_logic_vector(score))(19 downto 16));
					rgb <= x"FFFFFF";
				WHEN TO_UNSIGNED(8, 6) =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(std_logic_vector(score))(15 downto 12));
					rgb <= x"FFFFFF";
				WHEN TO_UNSIGNED(9, 6) =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(std_logic_vector(score))(11 downto 8));
					rgb <= x"FFFFFF";
				WHEN TO_UNSIGNED(10, 6) =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(std_logic_vector(score))(7 downto 4));
					rgb <= x"FFFFFF";
				WHEN TO_UNSIGNED(11, 6) =>
					ascii_8bit := "0" & bcd_to_ascii(to_bcd(std_logic_vector(score))(3 downto 0));
					rgb <= x"FFFFFF";
				WHEN TO_UNSIGNED(12, 6) =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN TO_UNSIGNED(13, 6) =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN TO_UNSIGNED(14, 6) =>
					ascii_8bit := x"4C";
					rgb <= x"FFFF00";
				WHEN TO_UNSIGNED(15, 6) =>
					ascii_8bit := x"45";
					rgb <= x"FFFF00";
				WHEN TO_UNSIGNED(16, 6) =>
					ascii_8bit := x"56";
					rgb <= x"FFFF00";
				WHEN TO_UNSIGNED(17, 6) =>
					ascii_8bit := x"45";
					rgb <= x"FFFF00";
				WHEN TO_UNSIGNED(18, 6) =>
					ascii_8bit := x"4C";
					rgb <= x"FFFF00";
				WHEN TO_UNSIGNED(19, 6) =>
					ascii_8bit := x"3A";
					rgb <= x"FFFF00";
				WHEN TO_UNSIGNED(20, 6) =>
					ascii_8bit := "0" & bcd_to_ascii("0" & std_logic_vector(level));
					rgb <= x"FFFFFF";
				WHEN TO_UNSIGNED(21, 6) =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN TO_UNSIGNED(22, 6) =>
					ascii_8bit := x"20";
					rgb <= x"000000";
				WHEN TO_UNSIGNED(23, 6) =>
					if (unsigned(life) >= 7) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN TO_UNSIGNED(24, 6) =>
					if (unsigned(life) >= 6) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN TO_UNSIGNED(25, 6) =>
					if (unsigned(life) >= 5) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN TO_UNSIGNED(26, 6) =>
					if (unsigned(life) >= 4) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN TO_UNSIGNED(27, 6) =>
					if (unsigned(life) >= 3) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN TO_UNSIGNED(28, 6) =>
					if (unsigned(life) >= 2) then
						ascii_8bit := x"03";
						rgb <= x"FFC0CB";
					else
						ascii_8bit := x"20";
						rgb <= x"000000";
					end if;
				WHEN TO_UNSIGNED(29, 6) =>
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

