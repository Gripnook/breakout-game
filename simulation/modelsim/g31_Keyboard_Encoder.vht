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
-- Generated on "10/06/2016 14:08:29"
                                                            
-- Vhdl Test Bench template for design  :  g31_Keyboard_Encoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g31_Keyboard_Encoder_vhd_tst IS
END g31_Keyboard_Encoder_vhd_tst;
ARCHITECTURE g31_Keyboard_Encoder_arch OF g31_Keyboard_Encoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL ASCII_CODE : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL KEYS : STD_LOGIC_VECTOR(63 DOWNTO 0);
COMPONENT g31_Keyboard_Encoder
	PORT (
	ASCII_CODE : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	KEYS : IN STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g31_Keyboard_Encoder
	PORT MAP (
-- list connections between master ports and signals
	ASCII_CODE => ASCII_CODE,
	KEYS => KEYS
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
	-- Error test case
	KEYS <= "0000000000000000000000000000000000000000000000000000000000000000";
	WAIT FOR 10 ns;
	
	-- SPACE character
	KEYS <= "0000000000000000000000000000000000000000000000000000000000000001";
	WAIT FOR 10 ns;
		
	-- A - Z characters
	FOR i in 33 to 58 LOOP
		FOR j in 0 to 63 LOOP
			IF i = j THEN
				KEYS(j) <= '1';
			ELSE
				KEYS(j) <= '0';
			END IF;
		END LOOP;
		WAIT FOR 10 ns;
	END LOOP;
	
	-- 0 - 9 characters
	FOR i in 16 to 25 LOOP
		FOR j in 0 to 63 LOOP
			IF i = j THEN
				KEYS(j) <= '1';
			ELSE
				KEYS(j) <= '0';
			END IF;
		END LOOP;
		WAIT FOR 10 ns;
	END LOOP;
	
WAIT;                                                        
END PROCESS always;                                          
END g31_Keyboard_Encoder_arch;
