--
-- entity name: g31_VGA_Test_Pattern
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus Vlastimil Lacina
-- Date: October 31st, 2016

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY g31_VGA_Test_Pattern IS
	PORT (
		CLOCK     : IN  STD_LOGIC; -- 50MHz
		RST       : IN  STD_LOGIC; -- reset
		R, G, B   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		HSYNC     : OUT STD_LOGIC; -- horizontal sync signal
		VSYNC     : OUT STD_LOGIC; -- vertical sync signal
		CLOCK_OUT : OUT STD_LOGIC -- output clock to drive the ADV7123 DAC
	);
END g31_VGA_Test_Pattern;

ARCHITECTURE bdf_type OF g31_VGA_Test_Pattern IS

SIGNAL COLUMN   : UNSIGNED(9 DOWNTO 0);
SIGNAL ROW      : UNSIGNED(9 DOWNTO 0);
SIGNAL BLANKING : STD_LOGIC;

COMPONENT g31_VGA
	 PORT (
		CLOCK    : IN  STD_LOGIC; -- 50MHz
		RST      : IN  STD_LOGIC; -- reset
		BLANKING : OUT STD_LOGIC; -- blank display when zero
		ROW      : OUT UNSIGNED(9 DOWNTO 0); -- line 0 to 599
		COLUMN   : OUT UNSIGNED(9 DOWNTO 0); -- column 0 to 799
		HSYNC    : OUT STD_LOGIC; -- horizontal sync signal
		VSYNC    : OUT STD_LOGIC -- vertical sync signal
	);
END COMPONENT;

BEGIN

CLOCK_OUT <= CLOCK;

VGA: g31_VGA PORT MAP (CLOCK => CLOCK, RST => RST, BLANKING => BLANKING,
								ROW => ROW, COLUMN => COLUMN, HSYNC => HSYNC, VSYNC => VSYNC);

R <=  "00000000" WHEN BLANKING = '0' ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED( 99, 10) ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED(199, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(299, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(399, 10) ELSE	
		"11111111" WHEN COLUMN <= TO_UNSIGNED(499, 10) ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED(599, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(699, 10) ELSE
		"00000000";
		
G <=  "00000000" WHEN BLANKING = '0' ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED( 99, 10) ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED(199, 10) ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED(299, 10) ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED(399, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(499, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(599, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(699, 10) ELSE
		"00000000";
		
B <=  "00000000" WHEN BLANKING = '0' ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED( 99, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(199, 10) ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED(299, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(399, 10) ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED(499, 10) ELSE
		"00000000" WHEN COLUMN <= TO_UNSIGNED(599, 10) ELSE
		"11111111" WHEN COLUMN <= TO_UNSIGNED(699, 10) ELSE
		"00000000";

END bdf_type;
