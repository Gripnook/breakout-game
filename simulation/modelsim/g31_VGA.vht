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
-- Generated on "10/27/2016 13:47:07"
                                                            
-- Vhdl Test Bench template for design  :  g31_VGA
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
USE ieee.numeric_std.all;

ENTITY g31_VGA_vhd_tst IS
END g31_VGA_vhd_tst;
ARCHITECTURE g31_VGA_arch OF g31_VGA_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL BLANKING : STD_LOGIC;
SIGNAL CLOCK : STD_LOGIC;
SIGNAL COLUMN : UNSIGNED(9 DOWNTO 0);
SIGNAL HSYNC : STD_LOGIC;
SIGNAL ROW : UNSIGNED(9 DOWNTO 0);
SIGNAL RST : STD_LOGIC;
SIGNAL VSYNC : STD_LOGIC;
COMPONENT g31_VGA
	PORT (
	BLANKING : OUT STD_LOGIC;
	CLOCK : IN STD_LOGIC;
	COLUMN : OUT UNSIGNED(9 DOWNTO 0);
	HSYNC : OUT STD_LOGIC;
	ROW : OUT UNSIGNED(9 DOWNTO 0);
	RST : IN STD_LOGIC;
	VSYNC : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g31_VGA
	PORT MAP (
-- list connections between master ports and signals
	BLANKING => BLANKING,
	CLOCK => CLOCK,
	COLUMN => COLUMN,
	HSYNC => HSYNC,
	ROW => ROW,
	RST => RST,
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
END g31_VGA_arch;
