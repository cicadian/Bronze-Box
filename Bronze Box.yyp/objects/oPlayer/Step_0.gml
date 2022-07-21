if (MOVE_SMOOTH){
	player_turn_smooth();
	player_move_smooth();
}
else{
	player_turn_rigid();
	player_move_rigid();
}

image_angle = dir;

player_freelook();