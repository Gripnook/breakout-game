library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library LPM;
use LPM.LPM_COMPONENTS.ALL;
use WORK.g31_Game_Types.ALL;

entity g31_Block_ROM is
	port (
		level  : in  std_logic_vector(2 downto 0); -- current level 1 to 7
		blocks : out t_block_array -- block array
	);
end g31_Block_ROM;

architecture bdf_type of g31_Block_ROM is

	constant n : std_logic_vector(1 downto 0) := "00"; -- no block
	constant s : std_logic_vector(1 downto 0) := "01"; -- single block
	constant d : std_logic_vector(1 downto 0) := "10"; -- double block
	constant u : std_logic_vector(1 downto 0) := "11"; -- unbreakable block

begin
	
	with level select
	blocks <=
		(s, s, s, s, s, s, s, s, s, s, s, s,
		 s, s, s, s, s, s, s, s, s, s, s, s,
		 s, s, s, s, s, s, s, s, s, s, s, s,
		 s, s, s, s, s, s, s, s, s, s, s, s,
		 s, s, s, s, s, s, s, s, s, s, s, s,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n)
			when "001",
		(s, s, s, s, s, s, s, s, s, s, s, s,
		 s, s, d, d, s, s, s, s, d, d, s, s,
		 s, s, d, d, s, s, s, s, d, d, s, s,
		 s, s, s, s, s, s, s, s, s, s, s, s,
		 d, d, d, d, d, d, d, d, d, d, d, d,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n)
			when "010",
		(n, d, s, s, s, s, s, s, s, s, d, n,
		 d, s, s, s, s, s, s, s, s, s, s, d,
		 s, s, s, s, s, s, s, s, s, s, s, s,
		 d, s, s, s, s, s, s, s, s, s, s, d,
		 n, d, d, d, d, d, d, d, d, d, d, n,
		 n, n, d, d, n, n, n, n, d, d, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n)
			when "011",
		(d, d, s, s, s, s, s, s, s, s, d, d,
		 d, s, s, d, d, d, d, d, d, s, s, d,
		 s, s, s, d, d, d, d, d, d, s, s, s,
		 s, s, s, s, s, s, s, s, s, s, s, s,
		 s, s, d, d, s, s, s, s, d, d, s, s,
		 n, n, u, u, n, n, n, n, u, u, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n)
			when "100",
		(s, s, s, s, s, s, s, s, s, s, s, s,
		 s, s, s, s, s, s, s, s, s, s, s, s,
		 s, s, s, s, s, d, d, s, s, s, s, s,
		 s, s, s, s, d, n, n, d, s, s, s, s,
		 d, d, d, d, n, n, n, n, d, d, d, d,
		 u, u, u, u, n, n, n, n, u, u, u, u,
		 d, d, d, u, n, n, n, n, u, d, d, d,
		 n, n, n, n, n, n, n, n, n, n, n, n)
			when "101",
		(n, s, s, s, s, s, s, s, s, s, s, n,
		 s, s, d, d, s, s, s, s, d, d, s, s,
		 s, d, u, u, d, s, s, d, u, u, d, s,
		 s, s, d, d, s, s, s, s, d, d, s, s,
		 n, s, s, s, s, s, s, s, s, s, s, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, d, d, d, d, n, n, d, d, d, d, n,
		 n, u, u, u, u, n, n, u, u, u, u, n)
			when "110",
		(s, s, d, d, d, d, d, d, d, d, s, s,
		 s, s, u, d, d, d, d, d, d, u, s, s,
		 s, s, u, d, d, d, d, d, d, u, s, s,
		 s, u, u, u, d, d, d, d, u, u, u, s,
		 s, u, u, u, d, d, d, d, u, u, u, s,
		 n, s, u, d, d, d, d, d, d, u, s, n,
		 n, s, u, d, d, d, d, d, d, u, s, n,
		 n, n, n, n, n, u, u, n, n, n, n, n)
			when "111",
		(n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n,
		 n, n, n, n, n, n, n, n, n, n, n, n)
			when others;
	
end bdf_type;

