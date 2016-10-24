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
-- Generated on "10/06/2016 14:45:54"
                                                            
-- Vhdl Test Bench template for design  :  g31_7_Segment_Decoder
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g31_7_Segment_Decoder_vhd_tst IS
END g31_7_Segment_Decoder_vhd_tst;
ARCHITECTURE g31_7_Segment_Decoder_arch OF g31_7_Segment_Decoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL ASCII_CODE : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL SEGMENTS : STD_LOGIC_VECTOR(6 DOWNTO 0);
COMPONENT g31_7_Segment_Decoder
	PORT (
	ASCII_CODE : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	SEGMENTS : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g31_7_Segment_Decoder
	PORT MAP (
-- list connections between master ports and signals
	ASCII_CODE => ASCII_CODE,
	SEGMENTS => SEGMENTS
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
	FOR i6 in 0 to 1 LOOP
	FOR i5 in 0 to 1 LOOP
	FOR i4 in 0 to 1 LOOP
	FOR i3 in 0 to 1 LOOP
	FOR i2 in 0 to 1 LOOP
	FOR i1 in 0 to 1 LOOP
	FOR i0 in 0 to 1 LOOP
		IF (i0 = 1) THEN
			ASCII_CODE(0) <= '1';
		ELSE
			ASCII_CODE(0) <= '0';
		END IF;
		IF (i1 = 1) THEN
			ASCII_CODE(1) <= '1';
		ELSE
			ASCII_CODE(1) <= '0';
		END IF;
		IF (i2 = 1) THEN
			ASCII_CODE(2) <= '1';
		ELSE
			ASCII_CODE(2) <= '0';
		END IF;
		IF (i3 = 1) THEN
			ASCII_CODE(3) <= '1';
		ELSE
			ASCII_CODE(3) <= '0';
		END IF;
		IF (i4 = 1) THEN
			ASCII_CODE(4) <= '1';
		ELSE
			ASCII_CODE(4) <= '0';
		END IF;
		IF (i5 = 1) THEN
			ASCII_CODE(5) <= '1';
		ELSE
			ASCII_CODE(5) <= '0';
		END IF;
		IF (i6 = 1) THEN
			ASCII_CODE(6) <= '1';
		ELSE
			ASCII_CODE(6) <= '0';
		END IF;
		WAIT FOR 10 ns;
	END LOOP;
	END LOOP;
	END LOOP;
	END LOOP;
	END LOOP;
	END LOOP;
	END LOOP;
WAIT;                                                        
END PROCESS always;                                          
END g31_7_Segment_Decoder_arch;
