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
-- Generated on "10/03/2016 14:30:47"
                                                            
-- Vhdl Test Bench template for design  :  g31_64_6_Encoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g31_64_6_Encoder_vhd_tst IS
END g31_64_6_Encoder_vhd_tst;
ARCHITECTURE g31_64_6_Encoder_arch OF g31_64_6_Encoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CODE : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL ERROR : STD_LOGIC;
SIGNAL INPUTS : STD_LOGIC_VECTOR(63 DOWNTO 0);
COMPONENT g31_64_6_Encoder
	PORT (
	CODE : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	ERROR : OUT STD_LOGIC;
	INPUTS : IN STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g31_64_6_Encoder
	PORT MAP (
-- list connections between master ports and signals
	CODE => CODE,
	ERROR => ERROR,
	INPUTS => INPUTS
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
   -- ERROR CONDITION
	INPUTS <= "0000000000000000000000000000000000000000000000000000000000000000";
	WAIT FOR 10 ns;
	
	-- 64 MAIN TEST CASES
	FOR i in 0 to 63 LOOP
		FOR j in 0 to 63 LOOP
			IF i = j THEN
				INPUTS(j) <= '1';
			ELSE
				INPUTS(j) <= '0';
			END IF;
		END LOOP;
		WAIT FOR 10 ns;
	END LOOP;
	
	-- OTHER TEST CASES
	INPUTS <= "0000000011000000110000000000111100000000100000000000100110000001";
	WAIT FOR 10 ns;
	INPUTS <= "0000011111100000000000000000010001000000011100110000000000000000";
	WAIT FOR 10 ns;
	INPUTS <= "0000000001010000111000011000010100000000000000000000000000000000";
	WAIT FOR 10 ns;
	INPUTS <= "0001001000101001000000000000000000000000000000000000000000000000";
	WAIT FOR 10 ns;
WAIT;                                                        
END PROCESS always;                                          
END g31_64_6_Encoder_arch;
