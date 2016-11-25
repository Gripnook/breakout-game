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
-- Generated on "11/24/2016 17:53:48"
                                                            
-- Vhdl Test Bench template for design  :  g31_Breakout_Game
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g31_Breakout_Game_vhd_tst IS
END g31_Breakout_Game_vhd_tst;
ARCHITECTURE g31_Breakout_Game_arch OF g31_Breakout_Game_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL b : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL clock : STD_LOGIC;
SIGNAL clock_vga : STD_LOGIC;
SIGNAL g : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL hsync : STD_LOGIC;
SIGNAL paddle_left_n : STD_LOGIC;
SIGNAL paddle_right_n : STD_LOGIC;
SIGNAL r : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL rst_n : STD_LOGIC;
SIGNAL vsync : STD_LOGIC;
COMPONENT g31_Breakout_Game
	PORT (
	b : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	clock : IN STD_LOGIC;
	clock_vga : OUT STD_LOGIC;
	g : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	hsync : OUT STD_LOGIC;
	paddle_left_n : IN STD_LOGIC;
	paddle_right_n : IN STD_LOGIC;
	r : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	rst_n : IN STD_LOGIC;
	vsync : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g31_Breakout_Game
	PORT MAP (
-- list connections between master ports and signals
	b => b,
	clock => clock,
	clock_vga => clock_vga,
	g => g,
	hsync => hsync,
	paddle_left_n => paddle_left_n,
	paddle_right_n => paddle_right_n,
	r => r,
	rst_n => rst_n,
	vsync => vsync
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
	FOR i IN 0 TO 692640*72*10 LOOP
		clock <= '1';
		WAIT FOR 10 ns;
		clock <= '0';
		WAIT FOR 10 ns;
	END LOOP;
WAIT;                                                        
END PROCESS always;                                          
END g31_Breakout_Game_arch;
