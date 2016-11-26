--
-- entity name: g31_Paddle_Generator
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

entity g31_Paddle_Generator is
	port (
		column     : in  unsigned(9 downto 0); -- column 0 to 799
		row        : in  unsigned(9 downto 0); -- row 0 to 599
		paddle_col : in  std_logic_vector( 9 downto 0); -- paddle col address 0 to 799
		rgb        : out std_logic_vector(23 downto 0); -- 24-bit color to display
		show_bit   : out std_logic -- should the pixel be colored or not
	);
end g31_Paddle_Generator;

architecture bdf_type of g31_Paddle_Generator is
begin

	Display_Wall : process (column, row, paddle_col)
	begin
		show_bit <= '0';
		rgb <= x"000000";
		if ((row >= 528 and row < 544) and (column >= unsigned(paddle_col) and column < unsigned(paddle_col) + 128)) then
			show_bit <= '1';
			rgb <= x"7F7FFF";
		end if;
	end process;

end bdf_type;

