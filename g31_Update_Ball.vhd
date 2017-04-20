library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;

entity g31_Update_Ball is
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
end g31_Update_Ball;

architecture bdf_type of g31_Update_Ball is

	constant BALL_COL_DEFAULT : std_logic_vector(9 downto 0) := "0110001100"; -- 396
	constant BALL_ROW_DEFAULT : std_logic_vector(9 downto 0) := "1000001000"; -- 520

	signal ball_col_buffer : std_logic_vector(9 downto 0);
	signal ball_row_buffer : std_logic_vector(9 downto 0);
	signal ball_col_up_buffer, ball_row_up_buffer : std_logic;
	
	signal ball_col_update_period, ball_row_update_period : std_logic_vector(17 downto 0);
	signal clear_ball_col_update, clear_ball_row_update : std_logic;
	signal ball_col_update_counter, ball_row_update_counter : std_logic_vector(17 downto 0);
	signal enable_ball_col, enable_ball_row : std_logic;
	
begin

	ball_col <= ball_col_buffer;
	ball_row <= ball_row_buffer;
	ball_col_up <= ball_col_up_buffer;
	ball_row_up <= ball_row_up_buffer;

	ball_col_update_period <= std_logic_vector(unsigned(col_period) - to_unsigned(1, 8)) & 
										(9 downto 0 => '1') when (cheats = '0') else -- period = col_period * 20.48 us
									  "0000" & std_logic_vector(unsigned(col_period) - to_unsigned(1, 8)) & 
										(5 downto 0 => '1'); -- 16 times the speed with cheats
	ball_row_update_period <= std_logic_vector(unsigned(row_period) - to_unsigned(1, 8)) & 
										(9 downto 0 => '1') when (cheats = '0') else -- period = row_period * 20.48 us
									  "0000" & std_logic_vector(unsigned(row_period) - to_unsigned(1, 8)) & 
										(5 downto 0 => '1'); -- 16 times the speed with cheats

	counter_ball_col_update : lpm_counter
			generic map (lpm_width => 18)
			port map (clock => clock, sclr => clear_ball_col_update, q => ball_col_update_counter);
	clear_ball_col_update <= '1' when ball_col_update_counter = ball_col_update_period else 
		not enable;

	counter_ball_row_update : lpm_counter
			generic map (lpm_width => 18)
			port map (clock => clock, sclr => clear_ball_row_update, q => ball_row_update_counter);
	clear_ball_row_update <= '1' when ball_row_update_counter = ball_row_update_period else 
		not enable;

	Counter_Ball_Col : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable = '1') then
				if (rst = '1') then
					ball_col_buffer <= BALL_COL_DEFAULT;
				elsif (clear_ball_col_update = '1') then
					if (ball_col_up_buffer = '0') then
						ball_col_buffer <= std_logic_vector(unsigned(ball_col_buffer) - to_unsigned(1, 10));
					else
						ball_col_buffer <= std_logic_vector(unsigned(ball_col_buffer) + to_unsigned(1, 10));
					end if;
				end if;
			end if;
		end if;
	end process;
	
	Counter_Ball_Row : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable = '1') then
				if (rst = '1') then
					ball_row_buffer <= BALL_ROW_DEFAULT;
				elsif (clear_ball_row_update = '1') then
					if (ball_row_up_buffer = '0') then
						ball_row_buffer <= std_logic_vector(unsigned(ball_row_buffer) - to_unsigned(1, 10));
					else
						ball_row_buffer <= std_logic_vector(unsigned(ball_row_buffer) + to_unsigned(1, 10));
					end if;
				end if;
			end if;
		end if;
	end process;
	
	Bounce_Ball : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable = '1') then
				if (rst = '1') then
					ball_col_up_buffer <= '0';
					ball_row_up_buffer <= '0';
				else
					if (col_bounce = '1') then
						ball_col_up_buffer <= not ball_col_up_buffer;
					end if;
					if (row_bounce = '1') then
						ball_row_up_buffer <= not ball_row_up_buffer;
					end if;
				end if;
			end if;
		end if;
	end process;
	
end bdf_type;

