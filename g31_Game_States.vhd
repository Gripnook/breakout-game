--
-- entity name: g31_Game_States
--
-- Copyright (C) 2016 g31
-- Version 1.0
-- Author: Andrei Purcarus, Vlastimil Lacina
-- Date: November 27th, 2016

package g31_Game_States is
	type t_game_state is (s_playing, s_paused, s_reset, s_level_cleared, s_game_over, s_game_won);
end package;

