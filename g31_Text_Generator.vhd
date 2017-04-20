library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use WORK.g31_Game_Types.ALL;

entity g31_Text_Generator is
	port (
		text_col   : in  std_logic_vector( 5 downto 0); -- character column 0 to 49
		text_row   : in  std_logic_vector( 4 downto 0); -- character row 0 to 18
		score      : in  std_logic_vector(15 downto 0); -- score 0 to 65,535
		level      : in  std_logic_vector( 2 downto 0); -- level 1 to 7
		life       : in  std_logic_vector( 2 downto 0); -- lives left 0 to 7
		game_state : in  t_game_state; -- current game state
		rgb        : out std_logic_vector(23 downto 0); -- 24-bit color to display
		ascii      : out std_logic_vector( 6 downto 0)  -- ascii code of the character to display
	);
end g31_Text_Generator;

architecture bdf_type of g31_Text_Generator is

	function to_bcd (bin : std_logic_vector(15 downto 0)) return std_logic_vector is
		variable i : integer := 0;
		variable j : integer := 1;
		variable bcd :  std_logic_vector(19 downto 0) := (others => '0');
		variable bint : std_logic_vector(15 downto 0) := bin;

		begin
		for i in 0 to 15 loop
			bcd(19 downto 1) := bcd(18 downto 0); -- shift the bcd bits
			bcd(0) := bint(15);
			
			bint(15 downto 1) := bint(14 downto 0); -- shift the input bits
			bint(0) := '0';
			
			for j in 1 to 5 loop -- for each bcd digit add 3 if it is greater than 4
				if (i < 15 and bcd ((4*j-1) downto (4*j-4)) > "0100") then
					bcd((4*j-1) downto (4*j-4)) := std_logic_vector(unsigned(bcd((4*j-1) downto (4*j-4))) + "0011");
				end if;
			end loop;
		end loop;
		return bcd;
	end to_bcd;

	function bcd_to_ascii (bcd : std_logic_vector(3 downto 0)) return std_logic_vector is
		variable ascii : std_logic_vector(6 downto 0) := (others => '0');
		begin
		ascii := std_logic_vector(("000" & unsigned(bcd)) + "0110000"); -- add the character 0 in ascii
		return ascii;
	end bcd_to_ascii;

	constant message0 : std_logic_vector(79 downto 0) := x"20202020202020202020";
	constant message1 : std_logic_vector(79 downto 0) := x"202053544152543f2020"; -- START?
	constant message2 : std_logic_vector(79 downto 0) := x"434f4e54494e55453f20"; -- CONTINUE?
	constant message3 : std_logic_vector(79 downto 0) := x"47414d45204f56455221"; -- GAME OVER!
	constant message4 : std_logic_vector(79 downto 0) := x"202057494e4e45522120"; -- WINNER!
	constant message5 : std_logic_vector(79 downto 0) := x"2020524553554d453f20"; -- RESUME?
	
	signal message : std_logic_vector(79 downto 0);

begin
	with game_state select
		message <= message1 when s_reset,
					  message2 when s_level_cleared,
					  message3 when s_game_over,
					  message4 when s_game_won,
					  message5 when s_paused,
					  message0 when others;

	text_gen : process (text_col, text_row, score, level, life, message)
	begin
		ascii <= "0100000";
		rgb <= x"000000";
		if to_integer(unsigned(text_row)) = 17 then
			case to_integer(unsigned(text_col)) is
				when 0 =>
					ascii <= "1010011"; -- S
					rgb <= x"FF0000";
				when 1 =>
					ascii <= "1000011"; -- C
					rgb <= x"FF0000";
				when 2 =>
					ascii <= "1001111"; -- O
					rgb <= x"FF0000";
				when 3 =>
					ascii <= "1010010"; -- R
					rgb <= x"FF0000";
				when 4 =>
					ascii <= "1000101"; -- E
					rgb <= x"FF0000";
				when 5 =>
					ascii <= "0111010"; -- :
					rgb <= x"FF0000";
				
				when 7 =>
					ascii <= bcd_to_ascii(to_bcd(score)(19 downto 16));
					rgb <= x"FFFFFF";
				when 8 =>
					ascii <= bcd_to_ascii(to_bcd(score)(15 downto 12));
					rgb <= x"FFFFFF";
				when 9 =>
					ascii <= bcd_to_ascii(to_bcd(score)(11 downto  8));
					rgb <= x"FFFFFF";
				when 10 =>
					ascii <= bcd_to_ascii(to_bcd(score)( 7 downto  4));
					rgb <= x"FFFFFF";
				when 11 =>
					ascii <= bcd_to_ascii(to_bcd(score)( 3 downto  0));
					rgb <= x"FFFFFF";
				
				when 14 =>
					ascii <= "1001100"; -- L
					rgb <= x"FFFF00";
				when 15 =>
					ascii <= "1000101"; -- E
					rgb <= x"FFFF00";
				when 16 =>
					ascii <= "1010110"; -- V
					rgb <= x"FFFF00";
				when 17 =>
					ascii <= "1000101"; -- E
					rgb <= x"FFFF00";
				when 18 =>
					ascii <= "1001100"; -- L
					rgb <= x"FFFF00";
				when 19 =>
					ascii <= "0111010"; -- :
					rgb <= x"FFFF00";
				when 20 =>
					ascii <= bcd_to_ascii("0" & level);
					rgb <= x"FFFFFF";
				
				when 23 =>
					if (unsigned(life) >= 7) then
						ascii <= "0000011";
						rgb <= x"FF7FFF";
					end if;
				when 24 =>
					if (unsigned(life) >= 6) then
						ascii <= "0000011";
						rgb <= x"FF7FFF";
					end if;
				when 25 =>
					if (unsigned(life) >= 5) then
						ascii <= "0000011";
						rgb <= x"FF7FFF";
					end if;
				when 26 =>
					if (unsigned(life) >= 4) then
						ascii <= "0000011";
						rgb <= x"FF7FFF";
					end if;
				when 27 =>
					if (unsigned(life) >= 3) then
						ascii <= "0000011";
						rgb <= x"FF7FFF";
					end if;
				when 28 =>
					if (unsigned(life) >= 2) then
						ascii <= "0000011";
						rgb <= x"FF7FFF";
					end if;
				when 29 =>
					if (unsigned(life) >= 1) then
						ascii <= "0000011";
						rgb <= x"FF7FFF";
					end if;
				
				when others =>
					-- do nothing
			end case;
		elsif (to_integer(unsigned(text_row)) = 12) then
			case to_integer(unsigned(text_col)) is
				when 20 =>
					ascii <= message(78 downto 72);
					rgb <= x"FFFFFF";
				when 21 =>
					ascii <= message(70 downto 64);
					rgb <= x"FFFFFF";
				when 22 =>
					ascii <= message(62 downto 56);
					rgb <= x"FFFFFF";
				when 23 =>
					ascii <= message(54 downto 48);
					rgb <= x"FFFFFF";
				when 24 =>
					ascii <= message(46 downto 40);
					rgb <= x"FFFFFF";
				when 25 =>
					ascii <= message(38 downto 32);
					rgb <= x"FFFFFF";
				when 26 =>
					ascii <= message(30 downto 24);
					rgb <= x"FFFFFF";
				when 27 =>
					ascii <= message(22 downto 16);
					rgb <= x"FFFFFF";
				when 28 =>
					ascii <= message(14 downto 8);
					rgb <= x"FFFFFF";
				when 29 =>
					ascii <= message(6 downto 0);
					rgb <= x"FFFFFF";
				when others =>
					-- do nothing
			end case;
		end if;
	end process;
end bdf_type;

