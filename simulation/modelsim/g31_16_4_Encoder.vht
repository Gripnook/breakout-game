-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "10/03/2016 14:28:04"
                                                            
-- Vhdl Test Bench template for design  :  g31_16_4_Encoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g31_16_4_Encoder_vhd_tst IS
END g31_16_4_Encoder_vhd_tst;
ARCHITECTURE g31_16_4_Encoder_arch OF g31_16_4_Encoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL BLOCK_COL : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL CODE : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL ERROR : STD_LOGIC;
COMPONENT g31_16_4_Encoder
	PORT (
	BLOCK_COL : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	CODE : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	ERROR : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g31_16_4_Encoder
	PORT MAP (
-- list connections between master ports and signals
	BLOCK_COL => BLOCK_COL,
	CODE => CODE,
	ERROR => ERROR
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
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END g31_16_4_Encoder_arch;
