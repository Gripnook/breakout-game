--
-- entity name: g31_Update_Wall
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

entity g31_Update_Wall is
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
end g31_Update_Wall;

architecture bdf_type of g31_Update_Wall is

	signal col_bounce_buffer, row_bounce_buffer, ball_lost_buffer : std_logic := '0';

	signal ball_col_next : unsigned(9 downto 0);
	signal ball_row_next : unsigned(9 downto 0);

begin

	col_bounce <= col_bounce_buffer;
	row_bounce <= row_bounce_buffer;
	ball_lost <= ball_lost_buffer;
	
	ball_col_next <= unsigned(ball_col) - to_unsigned(1, 10) when ball_col_up = '0' else
						unsigned(ball_col) + to_unsigned(8, 10);
	ball_row_next <= unsigned(ball_row) - to_unsigned(1, 10) when ball_row_up = '0' else
						unsigned(ball_row) + to_unsigned(8, 10);
	
	Update_Collisions : process (clock)
	begin
		if (rising_edge(clock)) then
			if (enable = '1') then
				if (rst = '1') then
					col_bounce_buffer <= '0';
					row_bounce_buffer <= '0';
					ball_lost_buffer <= '0';
				else
					-- wait for one more clock cycle for the game to update
					if (col_bounce_buffer = '1' or row_bounce_buffer = '1' or ball_lost_buffer = '1') then
						col_bounce_buffer <= '0';
						row_bounce_buffer <= '0';
						ball_lost_buffer <= '0';
					else
						if (ball_row_next = 544) then
							if (cheats = '1') then
								row_bounce_buffer <= '1';
							else
								ball_lost_buffer <= '1';
							end if;
						elsif (ball_row_next = 15) then
							row_bounce_buffer <= '1';
						end if;
						if (ball_col_next = 784) then
							col_bounce_buffer <= '1';
						elsif (ball_col_next = 15) then
							col_bounce_buffer <= '1';
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
end bdf_type;

