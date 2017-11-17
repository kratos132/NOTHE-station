/datum/game_mode/extended
	name = "extended"
	config_tag = "extended"
	required_players = 0

/datum/game_mode/extended/announce()
	..("<B>The current game mode is - Extended Role-Playing!</B><br><B>Just have fun and role-play!</B>")

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/post_setup()
	..()