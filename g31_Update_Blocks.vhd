--
-- entity name: g31_Update_Blocks
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus, Vlastimil Lacina
-- Date: November 25th, 2016

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;

entity g31_Update_Blocks is
	port (
		clock          : in  std_logic; -- 50MHz
		rst            : in  std_logic; -- synchronous reset
		enable         : in  std_logic; -- enables the component
		ball_col       : in  std_logic_vector(9 downto 0); -- ball col address 0 to 799
		ball_row       : in  std_logic_vector(9 downto 0); -- ball row address 0 to 599
		ball_col_up    : in  std_logic; -- direction of ball_col
		ball_row_up    : in  std_logic; -- direction of ball_row
		blocks         : out std_logic_vector(59 downto 0); -- blocks present or not bitmask
		blocks_cleared : out std_logic; -- all blocks cleared
		col_bounce     : out std_logic; -- the ball has hit a block in the col direction
		row_bounce     : out std_logic; -- the ball has hit a block in the row direction
		score_gained   : out std_logic_vector(15 downto 0) -- the score gained this clock cycle
	);
end g31_Update_Blocks;

architecture bdf_type of g31_Update_Blocks is

	-- returns the index of the block at the position (col,row) or "111111" if there is no block
	function find_block_index(blocks : std_logic_vector(59 downto 0);
				col, row : unsigned(9 downto 0)) return unsigned is
		variable row_relative : std_logic_vector(9 downto 0);
		variable col_relative : std_logic_vector(9 downto 0);
		variable index : unsigned(5 downto 0);
		begin
		if (row < 16 or row >= 176 or col < 16 or col >= 784) then
			return "111111";
		end if;
		
		-- index of a block = 12 * ((row - 16)/32) + ((column - 16)/64)
		row_relative := (std_logic_vector(row - to_unsigned(16, 10)));
		col_relative := (std_logic_vector(col - to_unsigned(16, 10)));
		index := unsigned(row_relative(7 downto 5) & "000") +
					unsigned(row_relative(7 downto 5) & "00") +
					unsigned(col_relative(9 downto 6));
		if (blocks(to_integer(index)) = '1') then
			return index;
		end if;
		
		return "111111";
	end find_block_index;

	function points_per_block(block_index : unsigned(5 downto 0)) return unsigned is
		begin
			if (block_index < 12) then
				return to_unsigned(5, 16);
			elsif (block_index < 24) then
				return to_unsigned(4, 16);
			elsif (block_index < 36) then
				return to_unsigned(3, 16);
			elsif (block_index < 48) then
				return to_unsigned(2, 16);
			else
				return to_unsigned(1, 16);
			end if;
	end points_per_block;

	signal blocks_buffer : std_logic_vector(59 downto 0) := (others => '1');
	
	signal ball_col_next, ball_col_min, ball_col_max : unsigned(9 downto 0);
	signal ball_row_next, ball_row_min, ball_row_max : unsigned(9 downto 0);
	
	signal block_index1, block_index2, block_index3, block_index4 : unsigned(5 downto 0);
	
begin

	blocks <= blocks_buffer;

	ball_col_next <= unsigned(ball_col) - to_unsigned(1, 10) when ball_col_up = '0' else
						unsigned(ball_col) + to_unsigned(8, 10);
	ball_col_min <= unsigned(ball_col);
	ball_col_max <= unsigned(ball_col) + to_unsigned(7, 10);
	ball_row_next <= unsigned(ball_row) - to_unsigned(1, 10) when ball_row_up = '0' else
						unsigned(ball_row) + to_unsigned(8, 10);
	ball_row_min <= unsigned(ball_row);
	ball_row_max <= unsigned(ball_row) + to_unsigned(7, 10);
	
	block_index1 <= find_block_index(blocks_buffer, ball_col_next, ball_row_min);
	block_index2 <= find_block_index(blocks_buffer, ball_col_next, ball_row_max);
	block_index3 <= find_block_index(blocks_buffer, ball_col_min, ball_row_next);
	block_index4 <= find_block_index(blocks_buffer, ball_col_max, ball_row_next);

	Update_Blocks : process (clock)
	variable blocks_t : std_logic_vector(59 downto 0);
	variable score_accumulator : unsigned(15 downto 0);
	begin
		if (rising_edge(clock)) then
			if (enable = '1') then
				if (rst = '1') then
					blocks_buffer <= (others => '1');
					col_bounce <= '0';
					row_bounce <= '0';
					score_accumulator := (others => '0');
				else
					col_bounce <= '0';
					row_bounce <= '0';
					blocks_t := blocks_buffer;
					score_accumulator := (others => '0');
					if (not (block_index1 = "111111") and blocks_t(to_integer(block_index1)) = '1') then
						blocks_t(to_integer(block_index1)) := '0';
						score_accumulator := score_accumulator + points_per_block(block_index1);
						col_bounce <= '1';
					end if;
					if (not (block_index2 = "111111") and blocks_t(to_integer(block_index2)) = '1') then
						blocks_t(to_integer(block_index2)) := '0';
						score_accumulator := score_accumulator + points_per_block(block_index2);
						col_bounce <= '1';
					end if;
					if (not (block_index3 = "111111") and blocks_t(to_integer(block_index3)) = '1') then
						blocks_t(to_integer(block_index3)) := '0';
						score_accumulator := score_accumulator + points_per_block(block_index3);
						row_bounce <= '1';
					end if;
					if (not (block_index4 = "111111") and blocks_t(to_integer(block_index4)) = '1') then
						blocks_t(to_integer(block_index4)) := '0';
						score_accumulator := score_accumulator + points_per_block(block_index4);
						row_bounce <= '1';
					end if;
					blocks_buffer <= blocks_t;
					score_gained <= std_logic_vector(score_accumulator);
				end if;
			end if;
		end if;
	end process;
	
	Update_Blocks_Cleared : process (blocks_buffer, rst)
	variable result : std_logic;
	begin
		if (enable = '1' and rst = '1') then
			blocks_cleared <= '0';
		else
			result := '0';
			for i in 0 to 59 loop
				result := result or blocks_buffer(i);
			end loop;
			blocks_cleared <= not result;
		end if;
	end process;

end bdf_type;

