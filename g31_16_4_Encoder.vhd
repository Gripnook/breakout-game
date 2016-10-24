--
-- entity name: g31_16_4_Encoder
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus Vlastimil Lacina
-- Date: September 26th, 2016

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY g31_16_4_Encoder IS
	PORT (
		BLOCK_COL : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		CODE      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ERROR     : OUT STD_LOGIC
	);
END g31_16_4_Encoder;

ARCHITECTURE bdf_type OF g31_16_4_Encoder IS
BEGIN
	CODE <=  "0000" WHEN BLOCK_COL(0)  = '1' ELSE
				"0001" WHEN BLOCK_COL(1)  = '1' ELSE
				"0010" WHEN BLOCK_COL(2)  = '1' ELSE
				"0011" WHEN BLOCK_COL(3)  = '1' ELSE
				"0100" WHEN BLOCK_COL(4)  = '1' ELSE
				"0101" WHEN BLOCK_COL(5)  = '1' ELSE
				"0110" WHEN BLOCK_COL(6)  = '1' ELSE
				"0111" WHEN BLOCK_COL(7)  = '1' ELSE
				"1000" WHEN BLOCK_COL(8)  = '1' ELSE
				"1001" WHEN BLOCK_COL(9)  = '1' ELSE
				"1010" WHEN BLOCK_COL(10) = '1' ELSE
				"1011" WHEN BLOCK_COL(11) = '1' ELSE
				"1100" WHEN BLOCK_COL(12) = '1' ELSE
				"1101" WHEN BLOCK_COL(13) = '1' ELSE
				"1110" WHEN BLOCK_COL(14) = '1' ELSE
				"1111" WHEN BLOCK_COL(15) = '1' ELSE
				"0000";
	ERROR <= NOT (BLOCK_COL(0) OR
				BLOCK_COL(1) OR
				BLOCK_COL(2) OR
				BLOCK_COL(3) OR
				BLOCK_COL(4) OR
				BLOCK_COL(5) OR
				BLOCK_COL(6) OR
				BLOCK_COL(7) OR
				BLOCK_COL(8) OR
				BLOCK_COL(9) OR
				BLOCK_COL(10) OR
				BLOCK_COL(11) OR
				BLOCK_COL(12) OR
				BLOCK_COL(13) OR
				BLOCK_COL(14) OR
				BLOCK_COL(15));
END bdf_type;
				
				