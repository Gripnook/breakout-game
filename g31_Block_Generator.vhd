library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;
use WORK.g31_Game_Types.ALL;

entity g31_Block_Generator is
	port (
		column   : in  unsigned(9 downto 0); -- column 0 to 799
		row      : in  unsigned(9 downto 0); -- row 0 to 599
		blocks   : in  t_block_array; -- block array
		rgb      : out std_logic_vector(23 downto 0); -- 24-bit color to display
		show_bit : out std_logic -- should the pixel be colored or not
	);
end g31_Block_Generator;

architecture bdf_type of g31_Block_Generator is

	function block_rgb_single(block_index : unsigned(6 downto 0)) return std_logic_vector is
	begin
		if (block_index < 12) then
			return x"FF0000";
		elsif (block_index < 24) then
			return x"FFAF00";
		elsif (block_index < 36) then
			return x"FFFF00";
		elsif (block_index < 48) then
			return x"00FF00";
		elsif (block_index < 60) then
			return x"00FFFF";
		elsif (block_index < 72) then
			return x"0000FF";
		elsif (block_index < 84) then
			return x"BF00FF";
		else
			return x"FF00BF";
		end if;
	end block_rgb_single;
	
	function block_rgb_double(block_index : unsigned(6 downto 0)) return std_logic_vector is
	begin
		if (block_index < 12) then
			return x"BF0000";
		elsif (block_index < 24) then
			return x"DF6F00";
		elsif (block_index < 36) then
			return x"DFCF00";
		elsif (block_index < 48) then
			return x"00BF00";
		elsif (block_index < 60) then
			return x"00BFBF";
		elsif (block_index < 72) then
			return x"0000BF";
		elsif (block_index < 84) then
			return x"7F00BF";
		else
			return x"BF007F";
		end if;
	end block_rgb_double;

	signal row_relative, col_relative : std_logic_vector(9 downto 0);
	signal index : unsigned(6 downto 0);

begin

	-- index of a block = 12 * ((row - 16)/32) + ((column - 16)/64)
	row_relative <= std_logic_vector(row - to_unsigned(16, 10));
	col_relative <= std_logic_vector(column - to_unsigned(16, 10));
	index <= unsigned(row_relative(8 downto 5) & '0' & '0' & '0') +
				unsigned(row_relative(8 downto 5) & '0' & '0') +
				unsigned(col_relative(9 downto 6)) when (row >= 16 and row < 272 and column >= 16 and column < 784) else "1111111";

	Display_Block : process (blocks, row_relative, col_relative, index)
	begin
		rgb <= x"000000";
		show_bit <= '0';
		if not (index = "1111111") then
			-- do not draw the border
			if not (row_relative(4 downto 0) = "00000" or
					  row_relative(4 downto 0) = "11111" or
					  col_relative(5 downto 0) = "000000" or
					  col_relative(5 downto 0) = "111111") then
				if (blocks(to_integer(index)) = "01") then
					rgb <= block_rgb_single(index);
					show_bit <= '1';
				elsif (blocks(to_integer(index)) = "10") then
					rgb <= block_rgb_double(index);
					show_bit <= '1';
				elsif (blocks(to_integer(index)) = "11") then
					rgb <= x"7F7F7F";
					show_bit <= '1';
				end if;
			end if;
		end if;
	end process;

end bdf_type;

