--
-- entity name: g31_Block_Generator
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

entity g31_Block_Generator is
	port (
		column   : in  unsigned(9 downto 0); -- column 0 to 799
		row      : in  unsigned(9 downto 0); -- row 0 to 599
		blocks   : in  std_logic_vector(59 downto 0); -- blocks present or not bitmask
		rgb      : out std_logic_vector(23 downto 0); -- 24-bit color to display
		show_bit : out std_logic -- should the pixel be colored or not
	);
end g31_Block_Generator;

architecture bdf_type of g31_Block_Generator is

	signal row_relative, col_relative : std_logic_vector(9 downto 0);
	signal index : unsigned(5 downto 0);

begin

	-- index of a block = 12 * ((row - 16)/32) + ((column - 16)/64)
	row_relative <= (std_logic_vector(row - to_unsigned(16, 10)));
	col_relative <= (std_logic_vector(column - to_unsigned(16, 10)));
	index <= unsigned(row_relative(7 downto 5) & "000") +
				unsigned(row_relative(7 downto 5) & "00") +
				unsigned(col_relative(9 downto 6)) when (row >= 16 and row < 176 and column >= 16 and column < 784) else "111111";

	Display_Block : process (blocks, row_relative, col_relative, index)
	begin
		rgb <= x"000000";
		show_bit <= '0';
		if not (index = "111111") then
			if (blocks(to_integer(index)) = '1') then
				-- do not draw the border
				if not (row_relative(4 downto 0) = "00000" or
						  row_relative(4 downto 0) = "11111" or
						  col_relative(5 downto 0) = "000000" or
						  col_relative(5 downto 0) = "111111") then
					if (index < 12) then
						rgb <= x"FF0000";
					elsif (index < 24) then
						rgb <= x"FFFF00";
					elsif (index < 36) then
						rgb <= x"00FFFF";
					elsif (index < 48) then
						rgb <= x"00FF00";
					else
						rgb <= x"7F00FF";
					end if;
					show_bit <= '1';
				end if;
			end if;
		end if;
	end process;

end bdf_type;

