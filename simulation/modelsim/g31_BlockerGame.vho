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

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 15.0.0 Build 145 04/22/2015 SJ Web Edition"

-- DATE "10/27/2016 13:59:10"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	g31_VGA IS
    PORT (
	CLOCK : IN std_logic;
	RST : IN std_logic;
	BLANKING : OUT std_logic;
	ROW : OUT IEEE.NUMERIC_STD.unsigned(9 DOWNTO 0);
	COLUMN : OUT IEEE.NUMERIC_STD.unsigned(9 DOWNTO 0);
	HSYNC : OUT std_logic;
	VSYNC : OUT std_logic
	);
END g31_VGA;

-- Design Ports Information
-- RST	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- BLANKING	=>  Location: PIN_AH30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[0]	=>  Location: PIN_AA26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[1]	=>  Location: PIN_AE29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[2]	=>  Location: PIN_AD29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[3]	=>  Location: PIN_AA28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[4]	=>  Location: PIN_AC29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[5]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[6]	=>  Location: PIN_AA30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[7]	=>  Location: PIN_AB28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[8]	=>  Location: PIN_Y23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ROW[9]	=>  Location: PIN_AB30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[0]	=>  Location: PIN_AG30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[1]	=>  Location: PIN_AD26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[2]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[3]	=>  Location: PIN_AG28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[4]	=>  Location: PIN_AF28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[5]	=>  Location: PIN_W24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[6]	=>  Location: PIN_AF30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[7]	=>  Location: PIN_Y24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[8]	=>  Location: PIN_V23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- COLUMN[9]	=>  Location: PIN_AC27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HSYNC	=>  Location: PIN_AF29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VSYNC	=>  Location: PIN_W25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLOCK	=>  Location: PIN_AB27,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF g31_VGA IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_CLOCK : std_logic;
SIGNAL ww_RST : std_logic;
SIGNAL ww_BLANKING : std_logic;
SIGNAL ww_ROW : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_COLUMN : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_HSYNC : std_logic;
SIGNAL ww_VSYNC : std_logic;
SIGNAL \RST~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK~input_o\ : std_logic;
SIGNAL \CLOCK~inputCLKENA0_outclk\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita6~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita7~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita7~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita8~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita8~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita9~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_reg_bit[8]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita9~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita10~sumout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita4~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita4~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita5~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita5~COUT\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_comb_bita6~sumout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ : std_logic;
SIGNAL \BLANKING~0_combout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita0~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita1~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita3~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita4~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita4~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita5~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita5~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita6~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita6~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita7~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita7~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita8~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita8~COUT\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita9~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_reg_bit[8]~DUPLICATE_q\ : std_logic;
SIGNAL \Equal1~2_combout\ : std_logic;
SIGNAL \Equal1~1_combout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_comb_bita2~sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_reg_bit[2]~DUPLICATE_q\ : std_logic;
SIGNAL \LessThan4~0_combout\ : std_logic;
SIGNAL \LessThan5~0_combout\ : std_logic;
SIGNAL \Equal1~0_combout\ : std_logic;
SIGNAL \counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE_q\ : std_logic;
SIGNAL \BLANKING~2_combout\ : std_logic;
SIGNAL \BLANKING~1_combout\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \ROW~0_combout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \ROW~1_combout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \ROW~2_combout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \ROW~3_combout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \ROW~4_combout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \ROW~5_combout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \ROW~6_combout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \ROW~7_combout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \ROW~8_combout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \ROW~9_combout\ : std_logic;
SIGNAL \COLUMN~0_combout\ : std_logic;
SIGNAL \COLUMN~1_combout\ : std_logic;
SIGNAL \COLUMN~2_combout\ : std_logic;
SIGNAL \COLUMN~3_combout\ : std_logic;
SIGNAL \COLUMN~4_combout\ : std_logic;
SIGNAL \COLUMN~5_combout\ : std_logic;
SIGNAL \LessThan6~0_combout\ : std_logic;
SIGNAL \COLUMN~6_combout\ : std_logic;
SIGNAL \COLUMN~7_combout\ : std_logic;
SIGNAL \LessThan6~1_combout\ : std_logic;
SIGNAL \COLUMN~8_combout\ : std_logic;
SIGNAL \COLUMN~9_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \LessThan8~0_combout\ : std_logic;
SIGNAL \LessThan9~0_combout\ : std_logic;
SIGNAL \LessThan9~1_combout\ : std_logic;
SIGNAL \counter_X|auto_generated|counter_reg_bit\ : std_logic_vector(10 DOWNTO 0);
SIGNAL \counter_Y|auto_generated|counter_reg_bit\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \counter_Y|auto_generated|ALT_INV_counter_reg_bit[6]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_Y|auto_generated|ALT_INV_counter_reg_bit[7]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_Y|auto_generated|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_Y|auto_generated|ALT_INV_counter_reg_bit[2]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_Y|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_Y|auto_generated|ALT_INV_counter_reg_bit[8]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_X|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\ : std_logic;
SIGNAL \counter_X|auto_generated|ALT_INV_counter_reg_bit[8]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_Equal1~2_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~2_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan9~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan8~0_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan6~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan6~0_combout\ : std_logic;
SIGNAL \ALT_INV_BLANKING~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan5~0_combout\ : std_logic;
SIGNAL \ALT_INV_Equal1~0_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan9~0_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan4~0_combout\ : std_logic;
SIGNAL \ALT_INV_BLANKING~0_combout\ : std_logic;
SIGNAL \ALT_INV_BLANKING~2_combout\ : std_logic;
SIGNAL \counter_X|auto_generated|ALT_INV_counter_reg_bit\ : std_logic_vector(10 DOWNTO 0);
SIGNAL \ALT_INV_Add0~37_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~33_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~29_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~25_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~21_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~17_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~13_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~9_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~5_sumout\ : std_logic;
SIGNAL \ALT_INV_Add0~1_sumout\ : std_logic;
SIGNAL \counter_Y|auto_generated|ALT_INV_counter_reg_bit\ : std_logic_vector(9 DOWNTO 0);

BEGIN

ww_CLOCK <= CLOCK;
ww_RST <= RST;
BLANKING <= ww_BLANKING;
ROW <= IEEE.NUMERIC_STD.UNSIGNED(ww_ROW);
COLUMN <= IEEE.NUMERIC_STD.UNSIGNED(ww_COLUMN);
HSYNC <= ww_HSYNC;
VSYNC <= ww_VSYNC;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\counter_Y|auto_generated|ALT_INV_counter_reg_bit[6]~DUPLICATE_q\ <= NOT \counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE_q\;
\counter_Y|auto_generated|ALT_INV_counter_reg_bit[7]~DUPLICATE_q\ <= NOT \counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE_q\;
\counter_Y|auto_generated|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\ <= NOT \counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\;
\counter_Y|auto_generated|ALT_INV_counter_reg_bit[2]~DUPLICATE_q\ <= NOT \counter_Y|auto_generated|counter_reg_bit[2]~DUPLICATE_q\;
\counter_Y|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\ <= NOT \counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\;
\counter_Y|auto_generated|ALT_INV_counter_reg_bit[8]~DUPLICATE_q\ <= NOT \counter_Y|auto_generated|counter_reg_bit[8]~DUPLICATE_q\;
\counter_X|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\ <= NOT \counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\;
\counter_X|auto_generated|ALT_INV_counter_reg_bit[8]~DUPLICATE_q\ <= NOT \counter_X|auto_generated|counter_reg_bit[8]~DUPLICATE_q\;
\ALT_INV_Equal1~2_combout\ <= NOT \Equal1~2_combout\;
\ALT_INV_Equal0~2_combout\ <= NOT \Equal0~2_combout\;
\ALT_INV_LessThan9~1_combout\ <= NOT \LessThan9~1_combout\;
\ALT_INV_LessThan8~0_combout\ <= NOT \LessThan8~0_combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
\ALT_INV_LessThan6~1_combout\ <= NOT \LessThan6~1_combout\;
\ALT_INV_LessThan6~0_combout\ <= NOT \LessThan6~0_combout\;
\ALT_INV_BLANKING~1_combout\ <= NOT \BLANKING~1_combout\;
\ALT_INV_LessThan5~0_combout\ <= NOT \LessThan5~0_combout\;
\ALT_INV_Equal1~0_combout\ <= NOT \Equal1~0_combout\;
\ALT_INV_LessThan9~0_combout\ <= NOT \LessThan9~0_combout\;
\ALT_INV_LessThan4~0_combout\ <= NOT \LessThan4~0_combout\;
\ALT_INV_BLANKING~0_combout\ <= NOT \BLANKING~0_combout\;
\ALT_INV_BLANKING~2_combout\ <= NOT \BLANKING~2_combout\;
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(3) <= NOT \counter_X|auto_generated|counter_reg_bit\(3);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(2) <= NOT \counter_X|auto_generated|counter_reg_bit\(2);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(1) <= NOT \counter_X|auto_generated|counter_reg_bit\(1);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(0) <= NOT \counter_X|auto_generated|counter_reg_bit\(0);
\ALT_INV_Add0~37_sumout\ <= NOT \Add0~37_sumout\;
\ALT_INV_Add0~33_sumout\ <= NOT \Add0~33_sumout\;
\ALT_INV_Add0~29_sumout\ <= NOT \Add0~29_sumout\;
\ALT_INV_Add0~25_sumout\ <= NOT \Add0~25_sumout\;
\ALT_INV_Add0~21_sumout\ <= NOT \Add0~21_sumout\;
\ALT_INV_Add0~17_sumout\ <= NOT \Add0~17_sumout\;
\ALT_INV_Add0~13_sumout\ <= NOT \Add0~13_sumout\;
\ALT_INV_Add0~9_sumout\ <= NOT \Add0~9_sumout\;
\ALT_INV_Add0~5_sumout\ <= NOT \Add0~5_sumout\;
\ALT_INV_Add0~1_sumout\ <= NOT \Add0~1_sumout\;
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(6) <= NOT \counter_Y|auto_generated|counter_reg_bit\(6);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(7) <= NOT \counter_Y|auto_generated|counter_reg_bit\(7);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(3) <= NOT \counter_Y|auto_generated|counter_reg_bit\(3);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(0) <= NOT \counter_Y|auto_generated|counter_reg_bit\(0);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(1) <= NOT \counter_Y|auto_generated|counter_reg_bit\(1);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(2) <= NOT \counter_Y|auto_generated|counter_reg_bit\(2);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(4) <= NOT \counter_Y|auto_generated|counter_reg_bit\(4);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(5) <= NOT \counter_Y|auto_generated|counter_reg_bit\(5);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(8) <= NOT \counter_Y|auto_generated|counter_reg_bit\(8);
\counter_Y|auto_generated|ALT_INV_counter_reg_bit\(9) <= NOT \counter_Y|auto_generated|counter_reg_bit\(9);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(4) <= NOT \counter_X|auto_generated|counter_reg_bit\(4);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(5) <= NOT \counter_X|auto_generated|counter_reg_bit\(5);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(6) <= NOT \counter_X|auto_generated|counter_reg_bit\(6);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(7) <= NOT \counter_X|auto_generated|counter_reg_bit\(7);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(8) <= NOT \counter_X|auto_generated|counter_reg_bit\(8);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(9) <= NOT \counter_X|auto_generated|counter_reg_bit\(9);
\counter_X|auto_generated|ALT_INV_counter_reg_bit\(10) <= NOT \counter_X|auto_generated|counter_reg_bit\(10);

-- Location: IOOBUF_X89_Y16_N39
\BLANKING~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_BLANKING~1_combout\,
	devoe => ww_devoe,
	o => ww_BLANKING);

-- Location: IOOBUF_X89_Y23_N5
\ROW[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~0_combout\,
	devoe => ww_devoe,
	o => ww_ROW(0));

-- Location: IOOBUF_X89_Y23_N39
\ROW[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~1_combout\,
	devoe => ww_devoe,
	o => ww_ROW(1));

-- Location: IOOBUF_X89_Y23_N56
\ROW[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~2_combout\,
	devoe => ww_devoe,
	o => ww_ROW(2));

-- Location: IOOBUF_X89_Y21_N56
\ROW[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~3_combout\,
	devoe => ww_devoe,
	o => ww_ROW(3));

-- Location: IOOBUF_X89_Y20_N96
\ROW[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~4_combout\,
	devoe => ww_devoe,
	o => ww_ROW(4));

-- Location: IOOBUF_X89_Y20_N62
\ROW[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~5_combout\,
	devoe => ww_devoe,
	o => ww_ROW(5));

-- Location: IOOBUF_X89_Y21_N22
\ROW[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~6_combout\,
	devoe => ww_devoe,
	o => ww_ROW(6));

-- Location: IOOBUF_X89_Y21_N39
\ROW[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~7_combout\,
	devoe => ww_devoe,
	o => ww_ROW(7));

-- Location: IOOBUF_X89_Y13_N5
\ROW[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~8_combout\,
	devoe => ww_devoe,
	o => ww_ROW(8));

-- Location: IOOBUF_X89_Y21_N5
\ROW[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ROW~9_combout\,
	devoe => ww_devoe,
	o => ww_ROW(9));

-- Location: IOOBUF_X89_Y16_N56
\COLUMN[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~0_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(0));

-- Location: IOOBUF_X89_Y16_N5
\COLUMN[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~1_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(1));

-- Location: IOOBUF_X89_Y20_N79
\COLUMN[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~2_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(2));

-- Location: IOOBUF_X89_Y13_N39
\COLUMN[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~3_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(3));

-- Location: IOOBUF_X89_Y13_N56
\COLUMN[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~4_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(4));

-- Location: IOOBUF_X89_Y15_N22
\COLUMN[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~5_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(5));

-- Location: IOOBUF_X89_Y15_N56
\COLUMN[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~6_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(6));

-- Location: IOOBUF_X89_Y13_N22
\COLUMN[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~7_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(7));

-- Location: IOOBUF_X89_Y15_N5
\COLUMN[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~8_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(8));

-- Location: IOOBUF_X89_Y16_N22
\COLUMN[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \COLUMN~9_combout\,
	devoe => ww_devoe,
	o => ww_COLUMN(9));

-- Location: IOOBUF_X89_Y15_N39
\HSYNC~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_LessThan8~0_combout\,
	devoe => ww_devoe,
	o => ww_HSYNC);

-- Location: IOOBUF_X89_Y20_N45
\VSYNC~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_LessThan9~1_combout\,
	devoe => ww_devoe,
	o => ww_VSYNC);

-- Location: IOIBUF_X89_Y23_N21
\CLOCK~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK,
	o => \CLOCK~input_o\);

-- Location: CLKCTRL_G11
\CLOCK~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \CLOCK~input_o\,
	outclk => \CLOCK~inputCLKENA0_outclk\);

-- Location: MLABCELL_X87_Y17_N0
\counter_X|auto_generated|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita0~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \counter_X|auto_generated|counter_comb_bita0~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \counter_X|auto_generated|counter_comb_bita0~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita0~COUT\);

-- Location: MLABCELL_X87_Y17_N18
\counter_X|auto_generated|counter_comb_bita6\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita6~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(6) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita5~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita6~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(6) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita5~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(6),
	cin => \counter_X|auto_generated|counter_comb_bita5~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita6~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita6~COUT\);

-- Location: MLABCELL_X87_Y17_N21
\counter_X|auto_generated|counter_comb_bita7\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita7~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(7) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita6~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita7~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(7) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita6~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(7),
	cin => \counter_X|auto_generated|counter_comb_bita6~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita7~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita7~COUT\);

-- Location: FF_X87_Y17_N23
\counter_X|auto_generated|counter_reg_bit[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita7~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(7));

-- Location: MLABCELL_X87_Y17_N24
\counter_X|auto_generated|counter_comb_bita8\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita8~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(8) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita7~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita8~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(8) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita7~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(8),
	cin => \counter_X|auto_generated|counter_comb_bita7~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita8~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita8~COUT\);

-- Location: FF_X87_Y17_N25
\counter_X|auto_generated|counter_reg_bit[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita8~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(8));

-- Location: MLABCELL_X87_Y17_N27
\counter_X|auto_generated|counter_comb_bita9\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita9~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(9) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita8~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita9~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(9) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita8~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(9),
	cin => \counter_X|auto_generated|counter_comb_bita8~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita9~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita9~COUT\);

-- Location: FF_X87_Y17_N28
\counter_X|auto_generated|counter_reg_bit[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita9~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(9));

-- Location: FF_X87_Y17_N26
\counter_X|auto_generated|counter_reg_bit[8]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita8~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit[8]~DUPLICATE_q\);

-- Location: MLABCELL_X87_Y17_N30
\counter_X|auto_generated|counter_comb_bita10\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita10~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(10) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita9~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	cin => \counter_X|auto_generated|counter_comb_bita9~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita10~sumout\);

-- Location: FF_X87_Y17_N32
\counter_X|auto_generated|counter_reg_bit[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita10~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(10));

-- Location: MLABCELL_X87_Y17_N48
\Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = ( !\counter_X|auto_generated|counter_reg_bit\(7) & ( \counter_X|auto_generated|counter_reg_bit\(10) & ( (!\counter_X|auto_generated|counter_reg_bit\(6) & (!\counter_X|auto_generated|counter_reg_bit\(5) & 
-- (!\counter_X|auto_generated|counter_reg_bit\(3) & \counter_X|auto_generated|counter_reg_bit\(4)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000100000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(6),
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(5),
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(3),
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(4),
	datae => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(7),
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	combout => \Equal0~2_combout\);

-- Location: MLABCELL_X87_Y17_N42
\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( !\counter_X|auto_generated|counter_reg_bit\(1) & ( \Equal0~2_combout\ & ( (!\counter_X|auto_generated|counter_reg_bit\(0) & (!\counter_X|auto_generated|counter_reg_bit\(9) & 
-- (!\counter_X|auto_generated|counter_reg_bit[8]~DUPLICATE_q\ & !\counter_X|auto_generated|counter_reg_bit\(2)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(0),
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(9),
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit[8]~DUPLICATE_q\,
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(2),
	datae => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(1),
	dataf => \ALT_INV_Equal0~2_combout\,
	combout => \Equal0~1_combout\);

-- Location: FF_X87_Y17_N2
\counter_X|auto_generated|counter_reg_bit[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita0~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(0));

-- Location: MLABCELL_X87_Y17_N3
\counter_X|auto_generated|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita1~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(1) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita0~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita1~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(1) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(1),
	cin => \counter_X|auto_generated|counter_comb_bita0~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita1~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita1~COUT\);

-- Location: FF_X87_Y17_N5
\counter_X|auto_generated|counter_reg_bit[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita1~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(1));

-- Location: MLABCELL_X87_Y17_N6
\counter_X|auto_generated|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita2~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(2) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita1~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita2~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(2) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(2),
	cin => \counter_X|auto_generated|counter_comb_bita1~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita2~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita2~COUT\);

-- Location: FF_X87_Y17_N8
\counter_X|auto_generated|counter_reg_bit[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita2~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(2));

-- Location: MLABCELL_X87_Y17_N9
\counter_X|auto_generated|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita3~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(3) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita2~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita3~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(3) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(3),
	cin => \counter_X|auto_generated|counter_comb_bita2~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita3~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita3~COUT\);

-- Location: FF_X87_Y17_N10
\counter_X|auto_generated|counter_reg_bit[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita3~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(3));

-- Location: MLABCELL_X87_Y17_N12
\counter_X|auto_generated|counter_comb_bita4\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita4~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(4) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita3~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita4~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(4) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(4),
	cin => \counter_X|auto_generated|counter_comb_bita3~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita4~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita4~COUT\);

-- Location: FF_X87_Y17_N14
\counter_X|auto_generated|counter_reg_bit[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita4~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(4));

-- Location: MLABCELL_X87_Y17_N15
\counter_X|auto_generated|counter_comb_bita5\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_X|auto_generated|counter_comb_bita5~sumout\ = SUM(( \counter_X|auto_generated|counter_reg_bit\(5) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita4~COUT\ ))
-- \counter_X|auto_generated|counter_comb_bita5~COUT\ = CARRY(( \counter_X|auto_generated|counter_reg_bit\(5) ) + ( GND ) + ( \counter_X|auto_generated|counter_comb_bita4~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(5),
	cin => \counter_X|auto_generated|counter_comb_bita4~COUT\,
	sumout => \counter_X|auto_generated|counter_comb_bita5~sumout\,
	cout => \counter_X|auto_generated|counter_comb_bita5~COUT\);

-- Location: FF_X87_Y17_N17
\counter_X|auto_generated|counter_reg_bit[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita5~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(5));

-- Location: FF_X87_Y17_N20
\counter_X|auto_generated|counter_reg_bit[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita6~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit\(6));

-- Location: FF_X87_Y17_N16
\counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_X|auto_generated|counter_comb_bita5~sumout\,
	sclr => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y15_N12
\BLANKING~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \BLANKING~0_combout\ = ( \counter_X|auto_generated|counter_reg_bit\(9) & ( \counter_X|auto_generated|counter_reg_bit\(4) & ( (\counter_X|auto_generated|counter_reg_bit\(6) & (\counter_X|auto_generated|counter_reg_bit\(8) & 
-- \counter_X|auto_generated|counter_reg_bit\(7))) ) ) ) # ( !\counter_X|auto_generated|counter_reg_bit\(9) & ( \counter_X|auto_generated|counter_reg_bit\(4) & ( (!\counter_X|auto_generated|counter_reg_bit\(8) & 
-- ((!\counter_X|auto_generated|counter_reg_bit\(7)) # ((!\counter_X|auto_generated|counter_reg_bit\(6) & !\counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\)))) ) ) ) # ( \counter_X|auto_generated|counter_reg_bit\(9) & ( 
-- !\counter_X|auto_generated|counter_reg_bit\(4) & ( (\counter_X|auto_generated|counter_reg_bit\(6) & (\counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & (\counter_X|auto_generated|counter_reg_bit\(8) & 
-- \counter_X|auto_generated|counter_reg_bit\(7)))) ) ) ) # ( !\counter_X|auto_generated|counter_reg_bit\(9) & ( !\counter_X|auto_generated|counter_reg_bit\(4) & ( (!\counter_X|auto_generated|counter_reg_bit\(8) & 
-- ((!\counter_X|auto_generated|counter_reg_bit\(6)) # (!\counter_X|auto_generated|counter_reg_bit\(7)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000010100000000000000000000111110000100000000000000000000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(6),
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\,
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(8),
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(7),
	datae => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(9),
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(4),
	combout => \BLANKING~0_combout\);

-- Location: LABCELL_X88_Y17_N30
\counter_Y|auto_generated|counter_comb_bita0\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita0~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \counter_Y|auto_generated|counter_comb_bita0~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \counter_Y|auto_generated|counter_comb_bita0~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita0~COUT\);

-- Location: FF_X88_Y17_N31
\counter_Y|auto_generated|counter_reg_bit[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita0~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(0));

-- Location: LABCELL_X88_Y17_N33
\counter_Y|auto_generated|counter_comb_bita1\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita1~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(1) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita0~COUT\ ))
-- \counter_Y|auto_generated|counter_comb_bita1~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(1) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita0~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(1),
	cin => \counter_Y|auto_generated|counter_comb_bita0~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita1~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita1~COUT\);

-- Location: FF_X88_Y17_N35
\counter_Y|auto_generated|counter_reg_bit[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita1~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(1));

-- Location: LABCELL_X88_Y17_N36
\counter_Y|auto_generated|counter_comb_bita2\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita2~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(2) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita1~COUT\ ))
-- \counter_Y|auto_generated|counter_comb_bita2~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(2) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita1~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(2),
	cin => \counter_Y|auto_generated|counter_comb_bita1~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita2~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita2~COUT\);

-- Location: LABCELL_X88_Y17_N39
\counter_Y|auto_generated|counter_comb_bita3\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita3~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(3) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita2~COUT\ ))
-- \counter_Y|auto_generated|counter_comb_bita3~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(3) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita2~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(3),
	cin => \counter_Y|auto_generated|counter_comb_bita2~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita3~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita3~COUT\);

-- Location: FF_X88_Y17_N40
\counter_Y|auto_generated|counter_reg_bit[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita3~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(3));

-- Location: LABCELL_X88_Y17_N42
\counter_Y|auto_generated|counter_comb_bita4\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita4~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(4) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita3~COUT\ ))
-- \counter_Y|auto_generated|counter_comb_bita4~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(4) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita3~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(4),
	cin => \counter_Y|auto_generated|counter_comb_bita3~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita4~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita4~COUT\);

-- Location: FF_X88_Y17_N44
\counter_Y|auto_generated|counter_reg_bit[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita4~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(4));

-- Location: LABCELL_X88_Y17_N45
\counter_Y|auto_generated|counter_comb_bita5\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita5~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(5) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita4~COUT\ ))
-- \counter_Y|auto_generated|counter_comb_bita5~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(5) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita4~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(5),
	cin => \counter_Y|auto_generated|counter_comb_bita4~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita5~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita5~COUT\);

-- Location: FF_X88_Y17_N46
\counter_Y|auto_generated|counter_reg_bit[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita5~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(5));

-- Location: LABCELL_X88_Y17_N48
\counter_Y|auto_generated|counter_comb_bita6\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita6~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(6) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita5~COUT\ ))
-- \counter_Y|auto_generated|counter_comb_bita6~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(6) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita5~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(6),
	cin => \counter_Y|auto_generated|counter_comb_bita5~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita6~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita6~COUT\);

-- Location: FF_X88_Y17_N49
\counter_Y|auto_generated|counter_reg_bit[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita6~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(6));

-- Location: LABCELL_X88_Y17_N51
\counter_Y|auto_generated|counter_comb_bita7\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita7~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(7) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita6~COUT\ ))
-- \counter_Y|auto_generated|counter_comb_bita7~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(7) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita6~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(7),
	cin => \counter_Y|auto_generated|counter_comb_bita6~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita7~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita7~COUT\);

-- Location: FF_X88_Y17_N53
\counter_Y|auto_generated|counter_reg_bit[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita7~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(7));

-- Location: FF_X88_Y17_N47
\counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita5~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y17_N54
\counter_Y|auto_generated|counter_comb_bita8\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita8~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(8) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita7~COUT\ ))
-- \counter_Y|auto_generated|counter_comb_bita8~COUT\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(8) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita7~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(8),
	cin => \counter_Y|auto_generated|counter_comb_bita7~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita8~sumout\,
	cout => \counter_Y|auto_generated|counter_comb_bita8~COUT\);

-- Location: FF_X88_Y17_N55
\counter_Y|auto_generated|counter_reg_bit[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita8~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(8));

-- Location: LABCELL_X88_Y17_N57
\counter_Y|auto_generated|counter_comb_bita9\ : cyclonev_lcell_comb
-- Equation(s):
-- \counter_Y|auto_generated|counter_comb_bita9~sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(9) ) + ( GND ) + ( \counter_Y|auto_generated|counter_comb_bita8~COUT\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(9),
	cin => \counter_Y|auto_generated|counter_comb_bita8~COUT\,
	sumout => \counter_Y|auto_generated|counter_comb_bita9~sumout\);

-- Location: FF_X88_Y17_N58
\counter_Y|auto_generated|counter_reg_bit[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita9~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(9));

-- Location: FF_X88_Y17_N32
\counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita0~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\);

-- Location: FF_X88_Y17_N50
\counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita6~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE_q\);

-- Location: FF_X88_Y17_N56
\counter_Y|auto_generated|counter_reg_bit[8]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita8~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit[8]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y17_N24
\Equal1~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal1~2_combout\ = ( !\counter_Y|auto_generated|counter_reg_bit[8]~DUPLICATE_q\ & ( (!\counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE_q\ & (\counter_Y|auto_generated|counter_reg_bit\(4) & (\counter_Y|auto_generated|counter_reg_bit\(1) & 
-- \counter_Y|auto_generated|counter_reg_bit\(3)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[6]~DUPLICATE_q\,
	datab => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(4),
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(1),
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(3),
	dataf => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[8]~DUPLICATE_q\,
	combout => \Equal1~2_combout\);

-- Location: LABCELL_X88_Y17_N6
\Equal1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal1~1_combout\ = ( !\counter_Y|auto_generated|counter_reg_bit[2]~DUPLICATE_q\ & ( \Equal1~2_combout\ & ( (\counter_Y|auto_generated|counter_reg_bit\(7) & (!\counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & 
-- (\counter_Y|auto_generated|counter_reg_bit\(9) & !\counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000100000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(7),
	datab => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\,
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(9),
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\,
	datae => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[2]~DUPLICATE_q\,
	dataf => \ALT_INV_Equal1~2_combout\,
	combout => \Equal1~1_combout\);

-- Location: FF_X88_Y17_N37
\counter_Y|auto_generated|counter_reg_bit[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita2~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit\(2));

-- Location: FF_X88_Y17_N38
\counter_Y|auto_generated|counter_reg_bit[2]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita2~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit[2]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y17_N0
\LessThan4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan4~0_combout\ = ( \counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & ( \counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\ & ( (!\counter_Y|auto_generated|counter_reg_bit\(4) & ((!\counter_Y|auto_generated|counter_reg_bit\(3)) # 
-- ((!\counter_Y|auto_generated|counter_reg_bit[2]~DUPLICATE_q\ & !\counter_Y|auto_generated|counter_reg_bit\(1))))) ) ) ) # ( !\counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & ( \counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\ ) ) # ( 
-- \counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & ( !\counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\ & ( (!\counter_Y|auto_generated|counter_reg_bit\(4) & ((!\counter_Y|auto_generated|counter_reg_bit[2]~DUPLICATE_q\) # 
-- (!\counter_Y|auto_generated|counter_reg_bit\(3)))) ) ) ) # ( !\counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & ( !\counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111011100000000011111111111111111110110000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[2]~DUPLICATE_q\,
	datab => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(3),
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(1),
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(4),
	datae => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\,
	dataf => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\,
	combout => \LessThan4~0_combout\);

-- Location: LABCELL_X88_Y17_N21
\LessThan5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan5~0_combout\ = ( \counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\ & ( ((\counter_Y|auto_generated|counter_reg_bit\(3)) # (\counter_Y|auto_generated|counter_reg_bit\(4))) # (\counter_Y|auto_generated|counter_reg_bit\(1)) ) ) # ( 
-- !\counter_Y|auto_generated|counter_reg_bit[0]~DUPLICATE_q\ & ( (\counter_Y|auto_generated|counter_reg_bit\(3)) # (\counter_Y|auto_generated|counter_reg_bit\(4)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111111111111000011111111111101011111111111110101111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(1),
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(4),
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(3),
	dataf => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[0]~DUPLICATE_q\,
	combout => \LessThan5~0_combout\);

-- Location: LABCELL_X88_Y17_N27
\Equal1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal1~0_combout\ = (!\counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE_q\ & (!\counter_Y|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & !\counter_Y|auto_generated|counter_reg_bit[2]~DUPLICATE_q\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010000000000000101000000000000010100000000000001010000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[6]~DUPLICATE_q\,
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\,
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[2]~DUPLICATE_q\,
	combout => \Equal1~0_combout\);

-- Location: FF_X88_Y17_N52
\counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputCLKENA0_outclk\,
	d => \counter_Y|auto_generated|counter_comb_bita7~sumout\,
	sclr => \Equal1~1_combout\,
	ena => \Equal0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE_q\);

-- Location: LABCELL_X88_Y17_N12
\BLANKING~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \BLANKING~2_combout\ = ( !\counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE_q\ & ( ((!\counter_Y|auto_generated|counter_reg_bit\(8) & ((!\LessThan4~0_combout\) # ((\counter_Y|auto_generated|counter_reg_bit\(9)) # 
-- (\counter_Y|auto_generated|counter_reg_bit\(6))))) # (\counter_Y|auto_generated|counter_reg_bit\(8) & (((!\counter_Y|auto_generated|counter_reg_bit\(9)))))) ) ) # ( \counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE_q\ & ( 
-- ((!\counter_Y|auto_generated|counter_reg_bit\(9)) # ((!\LessThan5~0_combout\ & (\Equal1~0_combout\ & !\counter_Y|auto_generated|counter_reg_bit\(8))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "on",
	lut_mask => "1010111111111111111111111111111111111111000000000000110000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_LessThan4~0_combout\,
	datab => \ALT_INV_LessThan5~0_combout\,
	datac => \ALT_INV_Equal1~0_combout\,
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(8),
	datae => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[7]~DUPLICATE_q\,
	dataf => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(9),
	datag => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(6),
	combout => \BLANKING~2_combout\);

-- Location: LABCELL_X88_Y15_N6
\BLANKING~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \BLANKING~1_combout\ = ( \BLANKING~2_combout\ & ( \counter_X|auto_generated|counter_reg_bit\(10) ) ) # ( !\BLANKING~2_combout\ & ( \counter_X|auto_generated|counter_reg_bit\(10) ) ) # ( \BLANKING~2_combout\ & ( 
-- !\counter_X|auto_generated|counter_reg_bit\(10) & ( \BLANKING~0_combout\ ) ) ) # ( !\BLANKING~2_combout\ & ( !\counter_X|auto_generated|counter_reg_bit\(10) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111001100110011001111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_BLANKING~0_combout\,
	datae => \ALT_INV_BLANKING~2_combout\,
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	combout => \BLANKING~1_combout\);

-- Location: LABCELL_X88_Y19_N0
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))
-- \Add0~2\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(0),
	cin => GND,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: LABCELL_X88_Y19_N57
\ROW~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~0_combout\ = (!\BLANKING~2_combout\) # (\Add0~1_sumout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101011111111101010101111111110101010111111111010101011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~2_combout\,
	datad => \ALT_INV_Add0~1_sumout\,
	combout => \ROW~0_combout\);

-- Location: LABCELL_X88_Y19_N3
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(1) ) + ( GND ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(1) ) + ( GND ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(1),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: LABCELL_X88_Y19_N39
\ROW~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~1_combout\ = (!\BLANKING~2_combout\) # (\Add0~5_sumout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101011111111101010101111111110101010111111111010101011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~2_combout\,
	datad => \ALT_INV_Add0~5_sumout\,
	combout => \ROW~1_combout\);

-- Location: LABCELL_X88_Y19_N6
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(2) ) + ( VCC ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(2) ) + ( VCC ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(2),
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: LABCELL_X88_Y19_N30
\ROW~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~2_combout\ = ( \Add0~9_sumout\ ) # ( !\Add0~9_sumout\ & ( !\BLANKING~2_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~2_combout\,
	dataf => \ALT_INV_Add0~9_sumout\,
	combout => \ROW~2_combout\);

-- Location: LABCELL_X88_Y19_N9
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(3) ) + ( GND ) + ( \Add0~10\ ))
-- \Add0~14\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(3) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(3),
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: LABCELL_X88_Y19_N51
\ROW~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~3_combout\ = ( \Add0~13_sumout\ & ( \BLANKING~2_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000001010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~2_combout\,
	dataf => \ALT_INV_Add0~13_sumout\,
	combout => \ROW~3_combout\);

-- Location: LABCELL_X88_Y19_N12
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(4) ) + ( VCC ) + ( \Add0~14\ ))
-- \Add0~18\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(4) ) + ( VCC ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(4),
	cin => \Add0~14\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: LABCELL_X88_Y19_N54
\ROW~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~4_combout\ = ( \Add0~17_sumout\ ) # ( !\Add0~17_sumout\ & ( !\BLANKING~2_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~2_combout\,
	dataf => \ALT_INV_Add0~17_sumout\,
	combout => \ROW~4_combout\);

-- Location: LABCELL_X88_Y19_N15
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(5) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(5) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(5),
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: MLABCELL_X87_Y19_N24
\ROW~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~5_combout\ = ( \Add0~21_sumout\ & ( \BLANKING~2_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_Add0~21_sumout\,
	dataf => \ALT_INV_BLANKING~2_combout\,
	combout => \ROW~5_combout\);

-- Location: LABCELL_X88_Y19_N18
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE_q\ ) + ( VCC ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE_q\ ) + ( VCC ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[6]~DUPLICATE_q\,
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: LABCELL_X88_Y19_N48
\ROW~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~6_combout\ = ( \Add0~25_sumout\ ) # ( !\Add0~25_sumout\ & ( !\BLANKING~2_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~2_combout\,
	dataf => \ALT_INV_Add0~25_sumout\,
	combout => \ROW~6_combout\);

-- Location: LABCELL_X88_Y19_N21
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE_q\ ) + ( VCC ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE_q\ ) + ( VCC ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[7]~DUPLICATE_q\,
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: LABCELL_X88_Y19_N36
\ROW~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~7_combout\ = (\BLANKING~2_combout\ & \Add0~29_sumout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010100000101000001010000010100000101000001010000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~2_combout\,
	datac => \ALT_INV_Add0~29_sumout\,
	combout => \ROW~7_combout\);

-- Location: LABCELL_X88_Y19_N24
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(8) ) + ( VCC ) + ( \Add0~30\ ))
-- \Add0~34\ = CARRY(( \counter_Y|auto_generated|counter_reg_bit\(8) ) + ( VCC ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(8),
	cin => \Add0~30\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: LABCELL_X88_Y15_N27
\ROW~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~8_combout\ = ( \BLANKING~2_combout\ & ( \Add0~33_sumout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_BLANKING~2_combout\,
	dataf => \ALT_INV_Add0~33_sumout\,
	combout => \ROW~8_combout\);

-- Location: LABCELL_X88_Y19_N27
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( \counter_Y|auto_generated|counter_reg_bit\(9) ) + ( VCC ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(9),
	cin => \Add0~34\,
	sumout => \Add0~37_sumout\);

-- Location: LABCELL_X88_Y19_N33
\ROW~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROW~9_combout\ = (!\BLANKING~2_combout\) # (\Add0~37_sumout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101011111111101010101111111110101010111111111010101011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~2_combout\,
	datad => \ALT_INV_Add0~37_sumout\,
	combout => \ROW~9_combout\);

-- Location: MLABCELL_X87_Y17_N54
\COLUMN~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~0_combout\ = ( \counter_X|auto_generated|counter_reg_bit\(0) & ( \BLANKING~0_combout\ ) ) # ( !\counter_X|auto_generated|counter_reg_bit\(0) & ( \BLANKING~0_combout\ ) ) # ( \counter_X|auto_generated|counter_reg_bit\(0) & ( !\BLANKING~0_combout\ ) 
-- ) # ( !\counter_X|auto_generated|counter_reg_bit\(0) & ( !\BLANKING~0_combout\ & ( \counter_X|auto_generated|counter_reg_bit\(10) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011111111111111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	datae => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(0),
	dataf => \ALT_INV_BLANKING~0_combout\,
	combout => \COLUMN~0_combout\);

-- Location: MLABCELL_X87_Y17_N36
\COLUMN~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~1_combout\ = ((\counter_X|auto_generated|counter_reg_bit\(1)) # (\counter_X|auto_generated|counter_reg_bit\(10))) # (\BLANKING~0_combout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111111101111111011111110111111101111111011111110111111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~0_combout\,
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(1),
	combout => \COLUMN~1_combout\);

-- Location: MLABCELL_X87_Y17_N39
\COLUMN~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~2_combout\ = ( \counter_X|auto_generated|counter_reg_bit\(2) ) # ( !\counter_X|auto_generated|counter_reg_bit\(2) & ( (\counter_X|auto_generated|counter_reg_bit\(10)) # (\BLANKING~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011101110111011101110111011111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_BLANKING~0_combout\,
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(2),
	combout => \COLUMN~2_combout\);

-- Location: LABCELL_X88_Y15_N30
\COLUMN~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~3_combout\ = ( \BLANKING~0_combout\ ) # ( !\BLANKING~0_combout\ & ( (\counter_X|auto_generated|counter_reg_bit\(10)) # (\counter_X|auto_generated|counter_reg_bit\(3)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100111111001111110011111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(3),
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	dataf => \ALT_INV_BLANKING~0_combout\,
	combout => \COLUMN~3_combout\);

-- Location: LABCELL_X88_Y15_N36
\COLUMN~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~4_combout\ = ( \counter_X|auto_generated|counter_reg_bit\(10) ) # ( !\counter_X|auto_generated|counter_reg_bit\(10) & ( (!\counter_X|auto_generated|counter_reg_bit\(4)) # (\BLANKING~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111001111110011111100111111001111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_BLANKING~0_combout\,
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(4),
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	combout => \COLUMN~4_combout\);

-- Location: LABCELL_X88_Y15_N57
\COLUMN~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~5_combout\ = ( !\BLANKING~0_combout\ & ( (!\counter_X|auto_generated|counter_reg_bit\(10) & (!\counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ $ (!\counter_X|auto_generated|counter_reg_bit\(4)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010100000101000001010000010100000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\,
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(4),
	dataf => \ALT_INV_BLANKING~0_combout\,
	combout => \COLUMN~5_combout\);

-- Location: LABCELL_X88_Y15_N48
\LessThan6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan6~0_combout\ = ( \counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & ( \counter_X|auto_generated|counter_reg_bit\(4) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(4),
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\,
	combout => \LessThan6~0_combout\);

-- Location: LABCELL_X88_Y15_N18
\COLUMN~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~6_combout\ = ( !\BLANKING~0_combout\ & ( (!\counter_X|auto_generated|counter_reg_bit\(10) & (!\counter_X|auto_generated|counter_reg_bit\(6) $ (\LessThan6~0_combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000001010000010100000101000001000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(6),
	datac => \ALT_INV_LessThan6~0_combout\,
	dataf => \ALT_INV_BLANKING~0_combout\,
	combout => \COLUMN~6_combout\);

-- Location: LABCELL_X88_Y15_N39
\COLUMN~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~7_combout\ = ( \LessThan6~0_combout\ & ( (!\counter_X|auto_generated|counter_reg_bit\(10) & (!\BLANKING~0_combout\ & !\counter_X|auto_generated|counter_reg_bit\(7))) ) ) # ( !\LessThan6~0_combout\ & ( 
-- (!\counter_X|auto_generated|counter_reg_bit\(10) & (!\BLANKING~0_combout\ & (!\counter_X|auto_generated|counter_reg_bit\(7) $ (!\counter_X|auto_generated|counter_reg_bit\(6))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000100010000000000010001000000010000000100000001000000010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	datab => \ALT_INV_BLANKING~0_combout\,
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(7),
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(6),
	dataf => \ALT_INV_LessThan6~0_combout\,
	combout => \COLUMN~7_combout\);

-- Location: LABCELL_X88_Y15_N0
\LessThan6~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan6~1_combout\ = ( \counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & ( (\counter_X|auto_generated|counter_reg_bit\(7) & ((\counter_X|auto_generated|counter_reg_bit\(4)) # (\counter_X|auto_generated|counter_reg_bit\(6)))) ) ) # ( 
-- !\counter_X|auto_generated|counter_reg_bit[5]~DUPLICATE_q\ & ( (\counter_X|auto_generated|counter_reg_bit\(7) & \counter_X|auto_generated|counter_reg_bit\(6)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001100000011000000110000001100000011001100110000001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(7),
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(6),
	datad => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(4),
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit[5]~DUPLICATE_q\,
	combout => \LessThan6~1_combout\);

-- Location: LABCELL_X88_Y15_N42
\COLUMN~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~8_combout\ = ( \counter_X|auto_generated|counter_reg_bit\(8) & ( ((\LessThan6~1_combout\) # (\counter_X|auto_generated|counter_reg_bit\(10))) # (\BLANKING~0_combout\) ) ) # ( !\counter_X|auto_generated|counter_reg_bit\(8) & ( 
-- ((!\LessThan6~1_combout\) # (\counter_X|auto_generated|counter_reg_bit\(10))) # (\BLANKING~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111100111111111111110011111100111111111111110011111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_BLANKING~0_combout\,
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	datad => \ALT_INV_LessThan6~1_combout\,
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(8),
	combout => \COLUMN~8_combout\);

-- Location: LABCELL_X88_Y15_N45
\COLUMN~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \COLUMN~9_combout\ = ( \counter_X|auto_generated|counter_reg_bit\(8) & ( ((\counter_X|auto_generated|counter_reg_bit\(9)) # (\BLANKING~0_combout\)) # (\counter_X|auto_generated|counter_reg_bit\(10)) ) ) # ( !\counter_X|auto_generated|counter_reg_bit\(8) & 
-- ( ((!\counter_X|auto_generated|counter_reg_bit\(9) $ (\LessThan6~1_combout\)) # (\BLANKING~0_combout\)) # (\counter_X|auto_generated|counter_reg_bit\(10)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111011101111111111101110111111101111111011111110111111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	datab => \ALT_INV_BLANKING~0_combout\,
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(9),
	datad => \ALT_INV_LessThan6~1_combout\,
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(8),
	combout => \COLUMN~9_combout\);

-- Location: LABCELL_X88_Y15_N3
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( !\counter_X|auto_generated|counter_reg_bit\(8) & ( (!\counter_X|auto_generated|counter_reg_bit\(7) & !\counter_X|auto_generated|counter_reg_bit\(9)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100000011000000110000001100000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(7),
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(9),
	dataf => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(8),
	combout => \Equal0~0_combout\);

-- Location: LABCELL_X88_Y15_N21
\LessThan8~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan8~0_combout\ = ( \LessThan6~0_combout\ & ( (!\counter_X|auto_generated|counter_reg_bit\(10) & (\Equal0~0_combout\ & ((!\counter_X|auto_generated|counter_reg_bit\(6)) # (!\counter_X|auto_generated|counter_reg_bit\(3))))) ) ) # ( 
-- !\LessThan6~0_combout\ & ( (!\counter_X|auto_generated|counter_reg_bit\(10) & \Equal0~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010101010000000001010101000000000101010000000000010101000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(10),
	datab => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(6),
	datac => \counter_X|auto_generated|ALT_INV_counter_reg_bit\(3),
	datad => \ALT_INV_Equal0~0_combout\,
	dataf => \ALT_INV_LessThan6~0_combout\,
	combout => \LessThan8~0_combout\);

-- Location: LABCELL_X88_Y17_N18
\LessThan9~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan9~0_combout\ = ( !\counter_Y|auto_generated|counter_reg_bit\(9) & ( (!\counter_Y|auto_generated|counter_reg_bit\(8) & (!\counter_Y|auto_generated|counter_reg_bit[6]~DUPLICATE_q\ & !\counter_Y|auto_generated|counter_reg_bit[7]~DUPLICATE_q\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100000000000000110000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(8),
	datac => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[6]~DUPLICATE_q\,
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit[7]~DUPLICATE_q\,
	dataf => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(9),
	combout => \LessThan9~0_combout\);

-- Location: LABCELL_X88_Y19_N42
\LessThan9~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan9~1_combout\ = ( !\counter_Y|auto_generated|counter_reg_bit\(5) & ( !\counter_Y|auto_generated|counter_reg_bit\(3) & ( (\LessThan9~0_combout\ & (!\counter_Y|auto_generated|counter_reg_bit\(4) & ((!\counter_Y|auto_generated|counter_reg_bit\(2)) # 
-- (!\counter_Y|auto_generated|counter_reg_bit\(1))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(2),
	datab => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(1),
	datac => \ALT_INV_LessThan9~0_combout\,
	datad => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(4),
	datae => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(5),
	dataf => \counter_Y|auto_generated|ALT_INV_counter_reg_bit\(3),
	combout => \LessThan9~1_combout\);

-- Location: IOIBUF_X18_Y81_N41
\RST~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RST,
	o => \RST~input_o\);

-- Location: LABCELL_X57_Y5_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


