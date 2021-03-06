library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;

entity g31_Wall_Generator is
	port (
		column   : in  unsigned(9 downto 0); -- column 0 to 799
		row      : in  unsigned(9 downto 0); -- row 0 to 599
		rgb      : out std_logic_vector(23 downto 0); -- 24-bit color to display
		show_bit : out std_logic -- should the pixel be colored or not
	);
end g31_Wall_Generator;

architecture bdf_type of g31_Wall_Generator is
begin

	Display_Wall : process (column, row)
	begin
		show_bit <= '0';
		rgb <= x"000000";
		if (((column < 16 or column >= 784) and row < 544) or (row < 16)) then
			show_bit <= '1';
			rgb <= x"7F7F7F";
		end if;
	end process;

end bdf_type;

