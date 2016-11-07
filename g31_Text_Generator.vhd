--
-- entity name: g31_Text_Generator
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus Vlastimil Lacina
-- Date: November 7th, 2016

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY g31_Text_Generator IS
	PORT (
	-- todo : comments
		text_col : IN UNSIGNED(5 DOWNTO 0);
		text_row : IN UNSIGNED(4 DOWNTO 0);
		score    : IN UNSIGNED(15 DOWNTO 0);
		level    : IN UNSIGNED(2 DOWNTO 0);
		life     : IN UNSIGNED(2 DOWNTO 0);
		r, g, b  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		ascii    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END g31_Text_Generator;

ARCHITECTURE bdf_type OF g31_Text_Generator IS
BEGIN
	-- pseudocode ahead
	text_gen : PROCESS (text_col, text_row, score, level, life)
	BEGIN
		IF text_row = 18 THEN
			CASE text_col IS
				WHEN TO_UNSIGNED(0, 6) =>
					ascii <= S
				WHEN TO_UNSIGNED(1, 6) =>
					ascii <= C
				WHEN TO_UNSIGNED(2, 6) =>
					ascii <= O
				WHEN TO_UNSIGNED(3, 6) =>
					ascii <= R
				WHEN TO_UNSIGNED(4, 6) =>
					ascii <= E
				WHEN TO_UNSIGNED(5, 6) =>
					ascii <= :
				WHEN TO_UNSIGNED(6, 6) =>
					ascii <= space
				WHEN TO_UNSIGNED(7, 6) =>
					ascii <= to_bcd(score)(4)
				WHEN TO_UNSIGNED(8, 6) =>
					ascii <= to_bcd(score)(3)
				WHEN TO_UNSIGNED(9, 6) =>
					ascii <= to_bcd(score)(2)
				WHEN TO_UNSIGNED(10, 6) =>
					ascii <= to_bcd(score)(1)
				WHEN TO_UNSIGNED(11, 6) =>
					ascii <= to_bcd(score)(0)
				WHEN TO_UNSIGNED(12, 6) =>
					ascii <= space
				WHEN TO_UNSIGNED(13, 6) =>
					ascii <= space
				WHEN TO_UNSIGNED(14, 6) =>
					ascii <= L
				WHEN TO_UNSIGNED(15, 6) =>
					ascii <= E
				WHEN TO_UNSIGNED(16, 6) =>
					ascii <= V
				WHEN TO_UNSIGNED(17, 6) =>
					ascii <= E
				WHEN TO_UNSIGNED(18, 6) =>
					ascii <= L
				WHEN TO_UNSIGNED(19, 6) =>
					ascii <= :
				WHEN TO_UNSIGNED(20, 6) =>
					ascii <= level
				WHEN TO_UNSIGNED(21, 6) =>
					ascii <= space
				WHEN TO_UNSIGNED(22, 6) =>
					ascii <= space
				WHEN TO_UNSIGNED(23, 6) =>
					ascii <= heart_if(7)
				WHEN TO_UNSIGNED(24, 6) =>
					ascii <= heart_if(6,7)
				WHEN TO_UNSIGNED(25, 6) =>
					ascii <= ...
				WHEN TO_UNSIGNED(26, 6) =>
					ascii <= ...
				WHEN TO_UNSIGNED(27, 6) =>
					ascii <= ...
				WHEN TO_UNSIGNED(28, 6) =>
					ascii <= ...
				WHEN TO_UNSIGNED(29, 6) =>
					ascii <= ...
				WHEN OTHERS =>
					ascii <= "0100000";
			END CASE;
		ELSE
			ascii <= "0100000";
		END IF;
	END PROCESS;
END bdf_type;

