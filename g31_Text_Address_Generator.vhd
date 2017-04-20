library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity g31_Text_Address_Generator is
	port (
		column   : in  unsigned(9 downto 0); -- column 0 to 799
		row      : in  unsigned(9 downto 0); -- row 0 to 599
		text_col : out std_logic_vector(5 downto 0); -- character column 0 to 49
		text_row : out std_logic_vector(4 downto 0); -- character row 0 to 18
		font_col : out std_logic_vector(2 downto 0); -- pixel column 0 to 7
		font_row : out std_logic_vector(3 downto 0)  -- pixel row 0 to 15
	);
end g31_Text_Address_Generator;

architecture bdf_type of g31_Text_Address_Generator is
begin
	text_col <= std_logic_vector(column(9 downto 4));
	text_row <= std_logic_vector(row(9 downto 5));
	font_col <= std_logic_vector(column(3 downto 1));
	font_row <= std_logic_vector(row(4 downto 1));
end bdf_type;

