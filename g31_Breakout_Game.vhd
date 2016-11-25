--
-- entity name: g31_Breakout_Game
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus, Vlastimil Lacina
-- Date: November 21st, 2016

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;

entity g31_Breakout_Game is
	port (
		clock          : in  std_logic; -- 50MHz
		rst_n          : in  std_logic; -- negated reset
		continue_n     : in  std_logic; -- unpauses the game
		paddle_right_n : in  std_logic; -- move paddle to the right when low
		paddle_left_n  : in  std_logic; -- move paddle to the left when low
		cheats         : in  std_logic; -- enables invisible bottom wall
		r, g, b        : out std_logic_vector(7 downto 0); -- 8-bit color output
		hsync          : out std_logic; -- horizontal sync signal
		vsync          : out std_logic; -- vertical sync signal
		clock_vga      : out std_logic  -- output clock to drive the ADV7123 DAC
	);
end g31_Breakout_Game;

architecture bdf_type of g31_Breakout_Game is

-- returns the index of the block at the position (col,row) or "111111" if there is no block
function find_block_index(blocks : std_logic_vector(59 downto 0);
			col, row : std_logic_vector(6 downto 0)) return std_logic_vector is
	variable row_pos : std_logic_vector(6 downto 0);
	variable col_pos : std_logic_vector(6 downto 0);
	variable index   : integer;
	begin
	if (unsigned(row) < 2 or unsigned(row) > 21 or unsigned(col) < 2 or unsigned(col) >= 98) then
		return "111111";
	end if;
	
	-- address of a block = 12 * ((game_row - 2)/4) + ((game_col - 2)/8)
	row_pos := (std_logic_vector(unsigned(row) - to_unsigned(2, 7)));
	col_pos := (std_logic_vector(unsigned(col) - to_unsigned(2, 7)));
	index   := 12 * to_integer(unsigned(row_pos(6 downto 2))) + to_integer(unsigned(col_pos(6 downto 3)));
	if (blocks(index) = '1') then
		return std_logic_vector(to_unsigned(index, 6));
	end if;
	
	return "111111";
end find_block_index;

function all_blocks_broken(blocks : std_logic_vector(59 downto 0)) return std_logic is
variable result : std_logic := '0';
begin
	for i in 0 to blocks'length - 1 loop
		result := result or blocks(i);
	end loop;
	return not result;
end all_blocks_broken;

function points_per_block(block_index : std_logic_vector(5 downto 0);
			level : std_logic_vector(2 downto 0)) return unsigned is
variable index : integer := 60;
variable accumulator : unsigned(5 downto 0) := (others => '0');
begin
	while (unsigned(block_index) < index) loop
		accumulator := accumulator + unsigned(level);
		index := index - 12;
	end loop;
	return accumulator;
end points_per_block;

signal continue : std_logic := '0';
signal pause_set : std_logic := '1';
signal pause_in : std_logic_vector(0 downto 0) := "1";
signal pause_out : std_logic_vector(0 downto 0) := "1";
signal pause : std_logic := '1';
signal pause_n : std_logic := '0';

signal message_id_set : std_logic_vector(2 downto 0) := "001"; -- START?
signal message_id : std_logic_vector(2 downto 0) := "001"; -- START?

signal score : std_logic_vector(15 downto 0) := x"0000";
signal level : std_logic_vector( 2 downto 0) := "001";
signal life  : std_logic_vector( 2 downto 0) := "101";

constant BALL_COL_DEFAULT : std_logic_vector(6 downto 0) := "0110001"; -- 49
constant BALL_ROW_DEFAULT : std_logic_vector(6 downto 0) := "1000001"; -- 65

-- the ball update period decreses with each level to increase difficulty
-- level 1 = 28 ms
-- level 2 = 26 ms
-- level 3 = 24 ms
-- level 4 = 22 ms
-- level 5 = 20 ms
-- level 6 = 18 ms
-- level 7 = 16 ms
constant BALL_UPDATE_PERIOD_BASE : std_logic_vector(25 downto 0) := "00000000011000011010100000"; -- 2 ms
signal ball_update_period : integer;
signal ball_col_update_period, ball_row_update_period : std_logic_vector(25 downto 0);
signal clear_ball_col_update, clear_ball_row_update : std_logic;
signal ball_col_update_counter, ball_row_update_counter : std_logic_vector(25 downto 0);
signal reset_ball_position : std_logic := '0';
signal enable_ball_col, enable_ball_row : std_logic;

signal ball_col : std_logic_vector(6 downto 0) := "0110001"; -- 49
signal ball_row : std_logic_vector(6 downto 0) := "1000001"; -- 65
signal ball_col_up : std_logic := '0';
signal ball_row_up : std_logic := '0';

signal blocks : std_logic_vector(59 downto 0) := (others => '1');

signal paddle_counter : std_logic_vector(25 downto 0);
signal clear_paddle_counter : std_logic;

signal paddle_col : std_logic_vector(6 downto 0) := "0101010";

component g31_VGA_Generator is
	port (
		clock      : in  std_logic; -- 50MHz
		score      : in  std_logic_vector(15 downto 0); -- score 0 to 65,535
		level      : in  std_logic_vector( 2 downto 0); -- level 0 to 7
		life       : in  std_logic_vector( 2 downto 0); -- lives left 0 to 7
		ball_col   : in  std_logic_vector( 6 downto 0); -- ball col address 0 to 99
		ball_row   : in  std_logic_vector( 6 downto 0); -- ball row address 0 to 67
		paddle_col : in  std_logic_vector( 6 downto 0); -- paddle col address 0 to 99
		blocks     : in  std_logic_vector(59 downto 0); -- blocks present or not bitmask
		message_id : in  std_logic_vector( 2 downto 0); -- message to display for the player
		r, g, b    : out std_logic_vector( 7 downto 0); -- 8-bit color output
		hsync      : out std_logic; -- horizontal sync signal
		vsync      : out std_logic; -- vertical sync signal
		clock_vga  : out std_logic  -- output clock to drive the ADV7123 DAC
	);
end component;

begin

VGA_Generator : g31_VGA_Generator port map (clock => clock, score => score, level => level, life => life,
								ball_col => ball_col, ball_row => ball_row, paddle_col => paddle_col, blocks => blocks, message_id => message_id,
								r => r, g => g, b => b, hsync => hsync, vsync => vsync, clock_vga => clock_vga);

counter_ball_col_update : lpm_counter
		generic map (lpm_width => 26)
		port map (clock => clock, sclr => clear_ball_col_update, q => ball_col_update_counter);
clear_ball_col_update <= '1' when ball_col_update_counter = ball_col_update_period else 
	pause;

counter_ball_row_update : lpm_counter
		generic map (lpm_width => 26)
		port map (clock => clock, sclr => clear_ball_row_update, q => ball_row_update_counter);
clear_ball_row_update <= '1' when ball_row_update_counter = ball_row_update_period else 
	pause;

counter_ball_col : lpm_counter
		generic map (lpm_width => 7)
		port map (clock => clock, sload => reset_ball_position, data => BALL_COL_DEFAULT,
			cnt_en => enable_ball_col, updown => ball_col_up, q => ball_col);
enable_ball_col <= clear_ball_col_update and (not pause);

counter_ball_row : lpm_counter
		generic map (lpm_width => 7)
		port map (clock => clock, sload => reset_ball_position, data => BALL_ROW_DEFAULT,
			cnt_en => enable_ball_row, updown => ball_row_up, q => ball_row);
enable_ball_row <= clear_ball_row_update and (not pause);

reg_pause : lpm_ff
	generic map (lpm_width => 1)
	port map (clock => clock, data => pause_in, aclr => continue, q => pause_out);
continue <= not continue_n;
pause_in <= (0 => (pause or pause_set));
pause <= pause_out(0);
pause_n <= not pause;

reg_message_id : lpm_ff
	generic map (lpm_width => 3)
	port map (clock => clock, data => message_id_set, sclr => pause_n, q => message_id);

ball_update_period <= ((15 - to_integer(unsigned(level))) * to_integer(unsigned(BALL_UPDATE_PERIOD_BASE))) - 1;
ball_col_update_period <= std_logic_vector(to_unsigned(ball_update_period, 26));
ball_row_update_period <= std_logic_vector(to_unsigned(ball_update_period, 26));

Update_Game : process (clock, rst_n)
variable reset_score : std_logic := '0';
variable reset_level : std_logic := '0';
variable reset_life  : std_logic := '0';
variable reset_ball  : std_logic := '0';
variable reset_blocks : std_logic := '0';
variable score_accumulator : unsigned(6 downto 0) := (others => '0');
variable blocks_t : std_logic_vector(59 downto 0);
variable block_index : std_logic_vector(5 downto 0);
begin
	if (pause = '1') then
		pause_set <= '0';
	elsif (rst_n = '0') then
		score <= x"0000";
		level <= "001";
		life <= "101";
		reset_ball_position <= '1';
		ball_col_up <= '0';
		ball_row_up <= '0';
		blocks <= (others => '1');
		pause_set <= '1';
		message_id_set <= "001"; -- START?
	elsif (rising_edge(clock)) then
		reset_score := '0';
		reset_level := '0';
		reset_life  := '0';
		reset_ball  := '0';
		reset_blocks := '0';
		score_accumulator := (others => '0');
		blocks_t := blocks;
		
		-- update the counter directions after the positions are updated
		if (ball_col_update_counter = "00000000000000000000000000" or ball_row_update_counter = "00000000000000000000000000") then
			if (ball_col_up = '0') then
				block_index := find_block_index(blocks_t, std_logic_vector(unsigned(ball_col) - to_unsigned(1, 7)), ball_row);
				if (unsigned(ball_col) = to_unsigned(2, 7)) then
					ball_col_up <= '1';
				elsif (not (block_index = "111111")) then
					blocks_t(to_integer(unsigned(block_index))) := '0';
					score_accumulator := score_accumulator + points_per_block(block_index, level);
					ball_col_up <= '1';
				end if;
			elsif (ball_col_up = '1') then
				block_index := find_block_index(blocks_t, std_logic_vector(unsigned(ball_col) + to_unsigned(1, 7)), ball_row);
				if (unsigned(ball_col) = to_unsigned(97, 7)) then
					ball_col_up <= '0';
				elsif (not (block_index = "111111")) then
					blocks_t(to_integer(unsigned(block_index))) := '0';
					score_accumulator := score_accumulator + points_per_block(block_index, level);
					ball_col_up <= '0';
				end if;
			end if;
			if (ball_row_up = '0') then
				block_index := find_block_index(blocks_t, ball_col, std_logic_vector(unsigned(ball_row) - to_unsigned(1, 7)));
				if (unsigned(ball_row) = to_unsigned(2, 7)) then
					ball_row_up <= '1';
				elsif (not (block_index = "111111")) then
					blocks_t(to_integer(unsigned(block_index))) := '0';
					score_accumulator := score_accumulator + points_per_block(block_index, level);
					ball_row_up <= '1';
				end if;
			elsif (ball_row_up = '1') then
				block_index := find_block_index(blocks_t, ball_col, std_logic_vector(unsigned(ball_row) + to_unsigned(1, 7)));
				if (unsigned(ball_row) = to_unsigned(67, 7)) then
					if (cheats = '1') then
						ball_row_up <= '0';
					elsif (life = "001") then
						reset_score := '1';
						reset_level := '1';
						reset_life  := '1';
						reset_ball  := '1';
						reset_blocks := '1';
						pause_set <= '1';
						message_id_set <= "011"; -- GAME OVER!
					else
						life <= std_logic_vector(unsigned(life) - to_unsigned(1, 3));
						reset_ball := '1';
					end if;
				elsif (not (block_index = "111111")) then
					blocks_t(to_integer(unsigned(block_index))) := '0';
					score_accumulator := score_accumulator + points_per_block(block_index, level);
					ball_row_up <= '0';
				elsif ((unsigned(ball_col) >= unsigned(paddle_col) - 1 and unsigned(ball_col) < unsigned(paddle_col) + 17) and
						 (unsigned(ball_row) = to_unsigned(65, 7))) then
					case to_integer(unsigned(ball_col)) - to_integer(unsigned(paddle_col)) is
						when -1 =>
							if (ball_col_up = '1') then
								ball_col_up <= '0';
								ball_row_up <= '0';
							end if;
						when 16 =>
							if (ball_col_up = '0') then
								ball_col_up <= '1';
								ball_row_up <= '0';
							end if;
						when others =>
							ball_row_up <= '0';
					end case;
				end if;
			end if;
		end if;
		
		if (all_blocks_broken(blocks_t) = '1') then
			if (level = "111") then
				reset_score := '1';
				reset_level := '1';
				reset_life  := '1';
				reset_ball  := '1';
				reset_blocks := '1';
				pause_set <= '1';
				message_id_set <= "100"; -- WINNER!
			else
				level <= std_logic_vector(unsigned(level) + to_unsigned(1, 3));
				reset_ball := '1';
				reset_blocks := '1';
				pause_set <= '1';
				message_id_set <= "010"; -- CONTINUE?
			end if;
		end if;
		
		score <= std_logic_vector(unsigned(score) + score_accumulator);
		blocks <= blocks_t;
		
		if (reset_score = '1') then
			score <= x"0000";
		end if;
		if (reset_level = '1') then
			level <= "001";
		end if;
		if (reset_life = '1') then
			life <= "101";
		end if;
		if (reset_ball = '1') then
			reset_ball_position <= '1';
			ball_col_up <= '0';
			ball_row_up <= '0';
		else
			reset_ball_position <= '0';
		end if;
		if (reset_blocks = '1') then
			blocks <= (others => '1');
		end if;
	end if;
end process;

counter_paddle : lpm_counter
		generic map (lpm_width => 26)
		port map (clock => clock, sclr => clear_paddle_counter, q => paddle_counter);
-- the paddle is updated every 1/64 s
clear_paddle_counter <= '1' when paddle_counter = "00000010111110101111000001" else 
	pause;

Update_Paddle : process (clock)
begin
	if (rising_edge(clock)) then
		if (pause = '0' and clear_paddle_counter = '1') then
			if (paddle_right_n = '0' and paddle_left_n = '0') then
				-- do nothing
			elsif (paddle_right_n = '0' and unsigned(paddle_col) < 98 - 16) then
				paddle_col <= std_logic_vector(unsigned(paddle_col) + to_unsigned(1, 7));
			elsif (paddle_left_n = '0' and unsigned(paddle_col) >= 2) then
				paddle_col <= std_logic_vector(unsigned(paddle_col) - to_unsigned(1, 7));
			end if;
		end if;
	end if;
end process;

end bdf_type;

