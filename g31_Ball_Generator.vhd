library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;

entity g31_Ball_Generator is
	port (
		column   : in  unsigned(9 downto 0); -- column 0 to 799
		row      : in  unsigned(9 downto 0); -- row 0 to 599
		ball_col : in  std_logic_vector( 9 downto 0); -- ball col address 0 to 799
		ball_row : in  std_logic_vector( 9 downto 0); -- ball row address 0 to 599
		rgb      : out std_logic_vector(23 downto 0); -- 24-bit color to display
		show_bit : out std_logic -- should the pixel be colored or not
	);
end g31_Ball_Generator;

architecture bdf_type of g31_Ball_Generator is

	type rom_type is array (0 to 7) of std_logic_vector(7 downto 0);

	constant ROM : rom_type := (
		"00111100", --   ****  
		"01111110", --  ****** 
		"11111111", -- ********
		"11111111", -- ********
		"11111111", -- ********
		"11111111", -- ********
		"01111110", --  ****** 
		"00111100"  --   ****  
	);
	
	signal addr_col, addr_row : unsigned(2 downto 0);

begin

	addr_col <= to_unsigned(7, 3) - unsigned((std_logic_vector(column - unsigned(ball_col))(2 downto 0)));
	addr_row <= unsigned(std_logic_vector(row - unsigned(ball_row))(2 downto 0));

	Display_Ball : process (column, row, ball_col, ball_row, addr_col, addr_row)
	begin
		show_bit <= '0';
		rgb <= x"000000";
		if (column >= unsigned(ball_col) and column < unsigned(ball_col) + 8 and
			 row >= unsigned(ball_row) and row < unsigned(ball_row) + 8) then
			show_bit <= ROM(to_integer(addr_row))(to_integer(addr_col));
			rgb <= x"FFFFFF";
		end if;
	end process;

end bdf_type;

