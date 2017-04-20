library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package g31_Game_Types is

	type t_game_state is (s_playing, s_paused, s_reset, s_level_cleared, s_game_over, s_game_won);
	type t_block_array is array(0 to 95) of std_logic_vector(1 downto 0);

end g31_Game_Types;

