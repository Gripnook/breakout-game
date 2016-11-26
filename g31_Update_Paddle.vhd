--
-- entity name: g31_Update_Paddle
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

entity g31_Update_Paddle is
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
		col_period     : out std_logic_vector(3 downto 0) := "1001"; -- relative period of the ball in the col direction
		row_period     : out std_logic_vector(3 downto 0) := "1001"  -- relative period of the ball in the row direction
	);
end g31_Update_Paddle;

architecture bdf_type of g31_Update_Paddle is

	constant PADDLE_COL_DEFAULT : std_logic_vector(9 downto 0) := "0101010000"; -- 336
	
	signal paddle_col_buffer : std_logic_vector(9 downto 0) := PADDLE_COL_DEFAULT;
	signal col_bounce_buffer, row_bounce_buffer : std_logic := '0';
	
	signal paddle_counter : std_logic_vector(17 downto 0);
	signal clear_paddle_counter : std_logic;
	
	signal ball_col_next : unsigned(9 downto 0);
	signal ball_row_next : unsigned(9 downto 0);
	signal ball_col_relative : integer;

begin

	paddle_col <= paddle_col_buffer;
	col_bounce <= col_bounce_buffer;
	row_bounce <= row_bounce_buffer;

	counter_paddle : lpm_counter
			generic map (lpm_width => 18)
			port map (clock => clock, sclr => clear_paddle_counter, q => paddle_counter);
	-- the paddle is updated every 1.6384 ms
	clear_paddle_counter <= '1' when paddle_counter = "010011111111111111" else 
		not enable;

	Update_Paddle : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable = '1') then
				if (rst = '1') then
					paddle_col_buffer <= PADDLE_COL_DEFAULT;
				elsif (clear_paddle_counter = '1') then
					if (paddle_right_n = '0' and paddle_left_n = '0') then
						-- do nothing
					elsif (paddle_right_n = '0' and unsigned(paddle_col_buffer) + 127 < 784) then
						paddle_col_buffer <= std_logic_vector(unsigned(paddle_col_buffer) + to_unsigned(1, 10));
					elsif (paddle_left_n = '0' and unsigned(paddle_col_buffer) >= 16) then
						paddle_col_buffer <= std_logic_vector(unsigned(paddle_col_buffer) - to_unsigned(1, 10));
					end if;
				end if;
			end if;
		end if;
	end process;
	
	-- we use the bottom left corner for coordinates
	ball_col_next <= unsigned(ball_col) - to_unsigned(1, 10) when ball_col_up = '0' else
						unsigned(ball_col) + to_unsigned(1, 10);
	ball_row_next <= unsigned(ball_row) + to_unsigned(6, 10) when ball_row_up = '0' else
						unsigned(ball_row) + to_unsigned(8, 10);
	ball_col_relative <= to_integer(ball_col_next) - to_integer(unsigned(paddle_col_buffer));
	
	Update_Collisions : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable = '1') then
				if (rst = '1') then
					col_bounce_buffer <= '0';
					row_bounce_buffer <= '0';
					col_period <= "1001";
					row_period <= "1001";
				else
					-- wait for one more clock cycle for the ball to update
					if (col_bounce_buffer = '1' or row_bounce_buffer = '1') then
						col_bounce_buffer <= '0';
						row_bounce_buffer <= '0';
					else
						if (ball_row_next = 528) then
							if (ball_col_relative >= -7 and ball_col_relative <= 15) then
								col_bounce_buffer <= ball_col_up;
								row_bounce_buffer <= '1';
								col_period <= "0111";
								row_period <= "1011";
							elsif (ball_col_relative >= 16 and ball_col_relative <= 47) then
								col_bounce_buffer <= ball_col_up;
								row_bounce_buffer <= '1';
								col_period <= "1001";
								row_period <= "1001";
							elsif (ball_col_relative >= 48 and ball_col_relative <= 59) then
								col_bounce_buffer <= not ball_col_up;
								row_bounce_buffer <= '1';
								col_period <= "1011";
								row_period <= "0111";
							elsif (ball_col_relative = 60) then
								row_bounce_buffer <= '1';
								col_period <= "1001";
								row_period <= "1001";
							elsif (ball_col_relative >= 61 and ball_col_relative <= 72) then
								col_bounce_buffer <= ball_col_up;
								row_bounce_buffer <= '1';
								col_period <= "1011";
								row_period <= "0111";
							elsif (ball_col_relative >= 73 and ball_col_relative <= 104) then
								col_bounce_buffer <= not ball_col_up;
								row_bounce_buffer <= '1';
								col_period <= "1001";
								row_period <= "1001";
							elsif (ball_col_relative >= 105 and ball_col_relative <= 127) then
								col_bounce_buffer <= not ball_col_up;
								row_bounce_buffer <= '1';
								col_period <= "0111";
								row_period <= "1011";
							end if;
						elsif (ball_row_next > 528 and ball_row_next < 528 + 16) then
							if (ball_col_up = '0' and ball_col_next = unsigned(paddle_col_buffer) + 127) then
								col_bounce_buffer <= '1';
							elsif (ball_col_up = '1' and ball_col_next + 7 = unsigned(paddle_col_buffer)) then
								col_bounce_buffer <= '1';
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
end bdf_type;

