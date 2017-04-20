library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;
use WORK.g31_Game_Types.ALL;

entity g31_Update_Blocks is
	port (
		clock          : in  std_logic; -- 50MHz
		rst            : in  std_logic; -- synchronous reset
		enable         : in  std_logic; -- enables the component
		ball_col       : in  std_logic_vector(9 downto 0); -- ball col address 0 to 799
		ball_row       : in  std_logic_vector(9 downto 0); -- ball row address 0 to 599
		ball_col_up    : in  std_logic; -- direction of ball_col
		ball_row_up    : in  std_logic; -- direction of ball_row
		level          : in  std_logic_vector(2 downto 0); -- current level 1 to 7
		blocks         : out t_block_array; -- block array
		blocks_cleared : out std_logic; -- all blocks cleared
		col_bounce     : out std_logic; -- the ball has hit a block in the col direction
		row_bounce     : out std_logic; -- the ball has hit a block in the row direction
		score_gained   : out std_logic_vector(15 downto 0) -- the score gained this clock cycle
	);
end g31_Update_Blocks;

architecture bdf_type of g31_Update_Blocks is

	-- returns the index of the block at the position (col,row) or "1111111" if there is no block
	function find_block_index(blocks : t_block_array;
				col, row : unsigned(9 downto 0)) return unsigned is
		variable row_relative : std_logic_vector(9 downto 0);
		variable col_relative : std_logic_vector(9 downto 0);
		variable index : unsigned(6 downto 0);
		begin
		if (row < 16 or row >= 272 or col < 16 or col >= 784) then
			return "1111111";
		end if;
		
		-- index of a block = 12 * ((row - 16)/32) + ((column - 16)/64)
		row_relative := (std_logic_vector(row - to_unsigned(16, 10)));
		col_relative := (std_logic_vector(col - to_unsigned(16, 10)));
		index := unsigned(row_relative(8 downto 5) & '0' & '0' & '0') +
					unsigned(row_relative(8 downto 5) & '0' & '0') +
					unsigned(col_relative(9 downto 6));
		if (not (blocks(to_integer(index)) = "00")) then
			return index;
		end if;
		
		return "1111111";
	end find_block_index;

	function points_per_block(block_index : unsigned(6 downto 0)) return unsigned is
	begin
		return to_unsigned(1, 16);
	end points_per_block;

	signal enable_delayed, rst_delayed : std_logic;
	
	signal default_blocks : t_block_array;
	signal blocks_buffer : t_block_array;
	
	signal col_bounce_buffer, row_bounce_buffer : std_logic;
	signal col_bounce_delayed, row_bounce_delayed : std_logic;
	
	signal ball_col_next, ball_col_min, ball_col_max : unsigned(9 downto 0);
	signal ball_row_next, ball_row_min, ball_row_max : unsigned(9 downto 0);
	
	signal block_index1, block_index2, block_index3, block_index4 : unsigned(6 downto 0);
	signal same_col_indices, same_row_indices : std_logic;
	
	signal block_index1_delayed, block_index2_delayed, block_index3_delayed, block_index4_delayed : unsigned(6 downto 0);
	signal same_col_indices_delayed, same_row_indices_delayed : std_logic;
	
	component g31_Block_ROM is
		port (
			level  : in  std_logic_vector(2 downto 0); -- current level 1 to 7
			blocks : out t_block_array -- block array
		);
	end component;
	
begin

	Block_ROM : g31_Block_ROM port map (level => level, blocks => default_blocks);

	blocks <= blocks_buffer;

	col_bounce <= col_bounce_buffer;
	row_bounce <= row_bounce_buffer;
	
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
	
	same_col_indices <= '1' when (block_index1 xor block_index2) = "0000000" else '0';
	same_row_indices <= '1' when (block_index3 xor block_index4) = "0000000" else '0';

	Update_Blocks : process (clock)
	variable blocks_t : t_block_array;
	variable score_accumulator : unsigned(15 downto 0);
	begin
		if (rising_edge(clock)) then
			if (enable_delayed = '1') then
				if (rst_delayed = '1') then
					blocks_buffer <= default_blocks;
					col_bounce_buffer <= '0';
					row_bounce_buffer <= '0';
					score_gained <= (others => '0');
				else
					blocks_t := blocks_buffer;
					score_accumulator := (others => '0');
					
					-- wait for two more clock cycles for the game to update
					if (col_bounce_buffer = '1' or row_bounce_buffer = '1') then
						col_bounce_buffer <= '0';
						row_bounce_buffer <= '0';
					elsif (col_bounce_delayed = '1' or row_bounce_delayed = '1') then
						-- do nothing
					else
						if (not (block_index1_delayed = "1111111")) then
							if (blocks_t(to_integer(block_index1_delayed)) = "01") then
								blocks_t(to_integer(block_index1_delayed)) := "00";
								score_accumulator := score_accumulator + points_per_block(block_index1_delayed);
							elsif (blocks_t(to_integer(block_index1_delayed)) = "10") then
								blocks_t(to_integer(block_index1_delayed)) := "01";
							end if;
							col_bounce_buffer <= '1';
						end if;
						if ((not (block_index2_delayed = "1111111")) and same_col_indices_delayed = '0') then
							if (blocks_t(to_integer(block_index2_delayed)) = "01") then
								blocks_t(to_integer(block_index2_delayed)) := "00";
								score_accumulator := score_accumulator + points_per_block(block_index2_delayed);
							elsif (blocks_t(to_integer(block_index2_delayed)) = "10") then
								blocks_t(to_integer(block_index2_delayed)) := "01";
							end if;
							col_bounce_buffer <= '1';
						end if;
						
						if (not (block_index3_delayed = "1111111")) then
							if (blocks_t(to_integer(block_index3_delayed)) = "01") then
								blocks_t(to_integer(block_index3_delayed)) := "00";
								score_accumulator := score_accumulator + points_per_block(block_index3_delayed);
							elsif (blocks_t(to_integer(block_index3_delayed)) = "10") then
								blocks_t(to_integer(block_index3_delayed)) := "01";
							end if;
							row_bounce_buffer <= '1';
						end if;
						if ((not (block_index4_delayed = "1111111")) and same_row_indices_delayed = '0') then
							if (blocks_t(to_integer(block_index4_delayed)) = "01") then
								blocks_t(to_integer(block_index4_delayed)) := "00";
								score_accumulator := score_accumulator + points_per_block(block_index4_delayed);
							elsif (blocks_t(to_integer(block_index4_delayed)) = "10") then
								blocks_t(to_integer(block_index4_delayed)) := "01";
							end if;
							row_bounce_buffer <= '1';
						end if;
					end if;
					
					blocks_buffer <= blocks_t;
					score_gained <= std_logic_vector(score_accumulator);
				end if;
			end if;
		end if;
	end process;
	
	Update_Blocks_Cleared : process (blocks_buffer, enable, rst, enable_delayed, rst_delayed)
	begin
		-- clear the blocks for two clock cycles after reset
		if ((enable = '1' and rst = '1') or (enable_delayed = '1' and rst_delayed = '1')) then
			blocks_cleared <= '0';
		else
			blocks_cleared <= '1';
			for i in 0 to 95 loop
				if (blocks_buffer(i) = "01" or blocks_buffer(i) = "10") then
					blocks_cleared <= '0';
				end if;
			end loop;
		end if;
	end process;
	
	Delay_Indices : process (clock)
	begin
		if (rising_edge(clock)) then
			block_index1_delayed <= block_index1;
			block_index2_delayed <= block_index2;
			block_index3_delayed <= block_index3;
			block_index4_delayed <= block_index4;
			same_col_indices_delayed <= same_col_indices;
			same_row_indices_delayed <= same_row_indices;
		end if;
	end process;
	
	-- resetting the blocks requires the level to update first
	Delay_Enable_Rst : process (clock)
	begin
		if (rising_edge(clock)) then
			enable_delayed <= enable;
			rst_delayed <= rst;
		end if;
	end process;
	
	Delay_Bounce : process (clock)
	begin
		if (rising_edge(clock)) then
			col_bounce_delayed <= col_bounce_buffer;
			row_bounce_delayed <= row_bounce_buffer;
		end if;
	end process;

end bdf_type;

