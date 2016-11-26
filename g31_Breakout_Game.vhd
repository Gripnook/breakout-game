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
		pause          : in  std_logic; -- pauses the game
		cheats         : in  std_logic; -- enables invisible bottom wall and a faster ball for quick level clearing
		r, g, b        : out std_logic_vector(7 downto 0); -- 8-bit color output
		hsync          : out std_logic; -- horizontal sync signal
		vsync          : out std_logic; -- vertical sync signal
		clock_vga      : out std_logic  -- output clock to drive the ADV7123 DAC
	);
end g31_Breakout_Game;

architecture bdf_type of g31_Breakout_Game is

	signal startup : std_logic := '0';
	signal startup_enable : std_logic := '1';
	signal startup_counter : std_logic_vector(27 downto 0) := (others => '0');
	signal game_started : std_logic := '0';
	
	signal message_id : std_logic_vector(2 downto 0) := "001"; -- START?
	signal message_id_displayed : std_logic_vector(2 downto 0);

	signal score : std_logic_vector(15 downto 0) := (others => '0');
	signal level : std_logic_vector( 2 downto 0) := "001";
	signal life  : std_logic_vector( 2 downto 0) := "101";

	signal ball_col : std_logic_vector(9 downto 0);
	signal ball_row : std_logic_vector(9 downto 0);
	signal ball_col_up : std_logic;
	signal ball_row_up : std_logic;
	signal paddle_col : std_logic_vector(9 downto 0);
	signal blocks : std_logic_vector(59 downto 0);
	signal blocks_cleared : std_logic;
	signal col_bounce, col_bounce_blocks, col_bounce_paddle, col_bounce_wall : std_logic;
	signal row_bounce, row_bounce_blocks, row_bounce_paddle, row_bounce_wall : std_logic;
	signal score_gained : std_logic_vector(15 downto 0);
	signal col_period_base : std_logic_vector(3 downto 0);
	signal row_period_base : std_logic_vector(3 downto 0);
	signal col_period : std_logic_vector(7 downto 0);
	signal row_period : std_logic_vector(7 downto 0);
	signal ball_lost : std_logic;
	
	signal enable : std_logic := '1';
	signal enable_pause : std_logic := '1';
	signal rst : std_logic := '1';
	
	signal rst_score, rst_level, rst_life, rst_blocks, rst_ball, rst_paddle, rst_wall : std_logic := '0';
	
	signal game_over, game_over_delayed : std_logic := '0';
	signal winner, winner_delayed : std_logic := '0';
	signal life_lost : std_logic := '0';
	signal next_level : std_logic := '0';

	component g31_VGA_Generator is
		port (
			clock      : in  std_logic; -- 50MHz
			score      : in  std_logic_vector(15 downto 0); -- score 0 to 65,535
			level      : in  std_logic_vector( 2 downto 0); -- level 0 to 7
			life       : in  std_logic_vector( 2 downto 0); -- lives left 0 to 7
			ball_col   : in  std_logic_vector( 9 downto 0); -- ball col address 0 to 799
			ball_row   : in  std_logic_vector( 9 downto 0); -- ball row address 0 to 599
			paddle_col : in  std_logic_vector( 9 downto 0); -- paddle col address 0 to 799
			blocks     : in  std_logic_vector(59 downto 0); -- blocks present or not bitmask
			message_id : in  std_logic_vector( 2 downto 0); -- message to display to the player
			r, g, b    : out std_logic_vector( 7 downto 0); -- 8-bit color output
			hsync      : out std_logic; -- horizontal sync signal
			vsync      : out std_logic; -- vertical sync signal
			clock_vga  : out std_logic  -- output clock to drive the ADV7123 DAC
		);
	end component;
	
	component g31_Update_Blocks is
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
	end component;
	
	component g31_Update_Ball is
		port (
			clock          : in  std_logic; -- 50MHz
			rst            : in  std_logic; -- synchronous reset
			enable         : in  std_logic; -- enables the component
			cheats         : in  std_logic; -- enables super speed
			col_bounce     : in  std_logic; -- the ball has hit something in the col direction
			row_bounce     : in  std_logic; -- the ball has hit something in the row direction
			col_period     : in  std_logic_vector(7 downto 0); -- relative period of the ball in the col direction
			row_period     : in  std_logic_vector(7 downto 0); -- relative period of the ball in the row direction
			ball_col       : out std_logic_vector(9 downto 0); -- ball col address 0 to 799
			ball_row       : out std_logic_vector(9 downto 0); -- ball row address 0 to 599
			ball_col_up    : out std_logic; -- direction of ball_col
			ball_row_up    : out std_logic  -- direction of ball_row
		);
	end component;
	
	component g31_Update_Paddle is
		port (
			clock          : in  std_logic; -- 50MHz
			rst            : in  std_logic; -- synchronous reset
			enable         : in  std_logic; -- enables the component
			ball_col       : in  std_logic_vector(9 downto 0); -- ball col address 0 to 799
			ball_row       : in  std_logic_vector(9 downto 0); -- ball row address 0 to 599
			ball_col_up    : in  std_logic; -- direction of ball_col
			ball_row_up    : in  std_logic; -- direction of ball_row
			paddle_right_n : in  std_logic; -- move paddle to the right when low
			paddle_left_n  : in  std_logic; -- move paddle to the left when low
			paddle_col     : out std_logic_vector(9 downto 0); -- paddle col address 0 to 799
			col_bounce     : out std_logic; -- the ball has hit the paddle in the col direction
			row_bounce     : out std_logic; -- the ball has hit the paddle in the row direction
			col_period     : out std_logic_vector(3 downto 0); -- relative period of the ball in the col direction
			row_period     : out std_logic_vector(3 downto 0)  -- relative period of the ball in the row direction
		);
	end component;
	
	component g31_Update_Wall is
		port (
			clock          : in  std_logic; -- 50MHz
			rst            : in  std_logic; -- synchronous reset
			enable         : in  std_logic; -- enables the component
			cheats         : in  std_logic; -- enables an invisible wall at the bottom
			ball_col       : in  std_logic_vector(9 downto 0); -- ball col address 0 to 799
			ball_row       : in  std_logic_vector(9 downto 0); -- ball row address 0 to 599
			ball_col_up    : in  std_logic; -- direction of ball_col
			ball_row_up    : in  std_logic; -- direction of ball_row
			col_bounce     : out std_logic; -- the ball has hit the wall in the col direction
			row_bounce     : out std_logic; -- the ball has hit the wall in the row direction
			ball_lost      : out std_logic  -- the ball fell in the bottom hole
		);
	end component;

begin

	-- initializes the game properly once loaded onto the board (4 s)
	counter_game_start : lpm_counter
			generic map (lpm_width => 28)
			port map (clock => clock, cnt_en => startup_enable, q => startup_counter);
	startup_enable <= game_started when startup_counter = "1011111010111100000111111111" else '1';
	Initialize_Game : process (clock)
	begin
		if (rising_edge(clock)) then
			if (startup = '1') then
				startup <= '0';
				game_started <= '1';
			elsif (startup_enable = '0') then
				startup <= '1';
			end if;
		end if;
	end process;
	
	enable_pause <= enable and not pause;
	
	Update_Enable : process (clock)
	begin
		if (rising_edge(clock)) then
			if (pause = '0') then
				if (enable = '0' and (continue_n = '0' or (rst = '1' and not (message_id = "001")))) then
					enable <= '1';
				else
					if (startup = '1' or rst = '1' or next_level = '1' or game_over = '1' or winner = '1') then
						enable <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;
	
	rst <= not rst_n;
	
	rst_score <= startup or rst or winner_delayed or game_over_delayed;
	rst_level <= startup or rst or winner_delayed or game_over_delayed;
	rst_life <= startup or rst or winner_delayed or game_over_delayed;
	rst_blocks <= startup or rst or winner_delayed or game_over_delayed or next_level;
	rst_ball <= startup or rst or winner_delayed or game_over_delayed or next_level or life_lost;
	rst_paddle <= startup or rst or winner_delayed or game_over_delayed or next_level or life_lost;
	rst_wall <= startup or rst or winner_delayed or game_over_delayed or next_level or life_lost;

	Update_Game_Over : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable_pause = '1') then
				game_over_delayed <= game_over;
			end if;
		end if;
	end process;
	
	Update_Winner : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable_pause = '1') then
				winner_delayed <= winner;
			end if;
		end if;
	end process;
	
	VGA_Generator : g31_VGA_Generator port map (clock => clock, score => score, level => level, life => life,
									ball_col => ball_col, ball_row => ball_row, paddle_col => paddle_col, blocks => blocks, message_id => message_id_displayed,
									r => r, g => g, b => b, hsync => hsync, vsync => vsync, clock_vga => clock_vga);
	Update_Blocks : g31_Update_Blocks port map (clock => clock, rst => rst_blocks, enable => enable_pause, ball_col => ball_col, ball_row => ball_row,
									ball_col_up => ball_col_up, ball_row_up => ball_row_up, blocks => blocks, blocks_cleared => blocks_cleared,
									col_bounce => col_bounce_blocks, row_bounce => row_bounce_blocks, score_gained => score_gained);
	Update_Ball : g31_Update_Ball port map (clock => clock, rst => rst_ball, enable => enable_pause, cheats => cheats, col_bounce => col_bounce, row_bounce => row_bounce,
									col_period => col_period, row_period => row_period, ball_col => ball_col, ball_row => ball_row,
									ball_col_up => ball_col_up, ball_row_up => ball_row_up);
	Update_Paddle : g31_Update_Paddle port map (clock => clock, rst => rst_paddle, enable => enable_pause, ball_col => ball_col, ball_row => ball_row,
									ball_col_up => ball_col_up, ball_row_up => ball_row_up, paddle_right_n => paddle_right_n, paddle_left_n => paddle_left_n,
									paddle_col => paddle_col, col_bounce => col_bounce_paddle, row_bounce => row_bounce_paddle, col_period => col_period_base, row_period => row_period_base);
	Update_Wall : g31_Update_Wall port map (clock => clock, rst => rst_wall, enable => enable_pause, cheats => cheats, ball_col => ball_col, ball_row => ball_row,
									ball_col_up => ball_col_up, ball_row_up => ball_row_up, col_bounce => col_bounce_wall, row_bounce => row_bounce_wall, ball_lost => ball_lost);
	
	col_bounce <= col_bounce_blocks or col_bounce_paddle or col_bounce_wall;
	row_bounce <= row_bounce_blocks or row_bounce_paddle or row_bounce_wall;
	
	-- period = relative_period * (15 - level)
	col_period <= std_logic_vector(to_unsigned(to_integer(unsigned(col_period_base)) * (15 - to_integer(unsigned(level))), 8));
	row_period <= std_logic_vector(to_unsigned(to_integer(unsigned(row_period_base)) * (15 - to_integer(unsigned(level))), 8));
	
	Update_Score : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable_pause = '1') then
				if (rst_score = '1') then
					score <= (others => '0');
				else
					score <= std_logic_vector(unsigned(score) + to_unsigned(to_integer(unsigned(level)) * to_integer(unsigned(score_gained)), 16));
				end if;
			end if;
		end if;
	end process;
	
	Update_Level : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable_pause = '1') then
				if (rst_level = '1') then
					level <= "001";
					winner <= '0';
					next_level <= '0';
				else
					winner <= '0';
					next_level <= '0';
					if (blocks_cleared = '1') then
						if (level = "111") then
							winner <= '1';
						else
							level <= std_logic_vector(unsigned(level) + to_unsigned(1, 3));
							next_level <= '1';
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	Update_Life : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable_pause = '1') then
				if (rst_life = '1') then
					life <= "101";
					game_over <= '0';
					life_lost <= '0';
				else
					game_over <= '0';
					life_lost <= '0';
					if (ball_lost = '1') then
						if (life = "001") then
							life <= "000";
							game_over <= '1';
						else
							life <= std_logic_vector(unsigned(life) - to_unsigned(1, 3));
							life_lost <= '1';
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	Update_Message : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable = '1' and pause = '1') then
				message_id <= "101";
			elsif (rst = '1') then
				message_id <= "001";
			elsif (next_level = '1') then
				message_id <= "010";
			elsif (game_over = '1') then
				message_id <= "011";
			elsif (winner = '1') then
				message_id <= "100";
			end if;
		end if;
	end process;
	
	reg_message : lpm_ff
		generic map (lpm_width => 3)
		port map (clock => clock, sclr => enable_pause, data => message_id, q => message_id_displayed);
	
end bdf_type;

