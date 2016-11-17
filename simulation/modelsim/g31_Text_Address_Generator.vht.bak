-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "11/07/2016 15:15:56"
                                                            
-- Vhdl Test Bench template for design  :  g31_Text_Address_Generator
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
USE ieee.numeric_std.all;

ENTITY g31_Text_Address_Generator_vhd_tst IS
END g31_Text_Address_Generator_vhd_tst;
ARCHITECTURE g31_Text_Address_Generator_arch OF g31_Text_Address_Generator_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL COLUMN : UNSIGNED(9 DOWNTO 0);
SIGNAL font_col : UNSIGNED(2 DOWNTO 0);
SIGNAL font_row : UNSIGNED(3 DOWNTO 0);
SIGNAL ROW : UNSIGNED(9 DOWNTO 0);
SIGNAL text_col : UNSIGNED(5 DOWNTO 0);
SIGNAL text_row : UNSIGNED(4 DOWNTO 0);
SIGNAL CLOCK    : STD_LOGIC;
SIGNAL RST      : STD_LOGIC;
SIGNAL BLANKING : STD_LOGIC;
SIGNAL HSYNC    : STD_LOGIC;
SIGNAL VSYNC    : STD_LOGIC;
COMPONENT g31_Text_Address_Generator
	PORT (
	COLUMN : IN UNSIGNED(9 DOWNTO 0);
	font_col : OUT UNSIGNED(2 DOWNTO 0);
	font_row : OUT UNSIGNED(3 DOWNTO 0);
	ROW : IN UNSIGNED(9 DOWNTO 0);
	text_col : OUT UNSIGNED(5 DOWNTO 0);
	text_row : OUT UNSIGNED(4 DOWNTO 0)
	);
END COMPONENT;
COMPONENT g31_VGA IS
	PORT (
		CLOCK    : IN  STD_LOGIC;
		RST      : IN  STD_LOGIC;
		BLANKING : OUT STD_LOGIC;
		ROW      : OUT UNSIGNED(9 DOWNTO 0);
		COLUMN   : OUT UNSIGNED(9 DOWNTO 0);
		HSYNC    : OUT STD_LOGIC;
		VSYNC    : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g31_Text_Address_Generator
	PORT MAP (
-- list connections between master ports and signals
	COLUMN => COLUMN,
	font_col => font_col,
	font_row => font_row,
	ROW => ROW,
	text_col => text_col,
	text_row => text_row
	);
	i2 : g31_VGA
	PORT MAP (
	CLOCK => CLOCK,
	RST => RST,
	BLANKING => BLANKING,
	ROW => ROW,
	COLUMN => COLUMN,
	HSYNC => HSYNC,
	VSYNC => VSYNC
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
	CLOCK <= '1';
	WAIT FOR 10 ns;
	RST <= '1';
	CLOCK <= '0';
	WAIT FOR 10 ns;
	CLOCK <= '1';
	WAIT FOR 10 ns;
	RST <= '0';
	CLOCK <= '0';
	WAIT FOR 10 ns;
	FOR i IN 0 TO 692640 LOOP
		CLOCK <= '1';
		WAIT FOR 10 ns;
		CLOCK <= '0';
		WAIT FOR 10 ns;
	END LOOP;
WAIT;                                                        
END PROCESS always;                                          
END g31_Text_Address_Generator_arch;
