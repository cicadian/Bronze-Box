// Changing rooms for debugging TODO remove this
if (keyboard_check_pressed(vk_tab)){
	if (room_next(room) != -1){
		room_goto_next();
	}
	else{
		room_goto(0);
	}
}

// RENDER DEBUGGING FOR ENVIRONMENTAL DESIGN
if (keyboard_check_pressed(vk_return)){
	global.debug_stats = !global.debug_stats;
}
if (DEBUG_FOV){
	if (keyboard_check(vk_f1)){
		global.fov++;
		if (global.fov >= 160){
			global.fov = 160;
		}
		trace(global.fov);
	}
	if (keyboard_check(vk_f2)){
		global.fov--;
		if (global.fov <= 0){
			global.fov = 1;
		}
		trace(global.fov);
	}
	if (keyboard_check(vk_escape)){
		global.fov = 60;
		trace(global.fov);
	}
}

if (DEBUG_FOG_DISTANCE){
	if (keyboard_check_pressed(vk_f3)){
		global.fog_start -= 16;
		if (global.fog_start < 0){
			global.fog_start = 0;
		}
		trace(global.fog_start);
	}
	if (keyboard_check_pressed(vk_f4)){
		global.fog_start += 16;
		if (global.fog_start >= global.fog_end - 16){
			global.fog_start = global.fog_end - 16;
		}
		trace(global.fog_start);
	}
	if (keyboard_check_pressed(vk_f5)){
		global.fog_end -= 16;
		if (global.fog_end <= global.fog_start + 16){
			global.fog_end = global.fog_start + 16;
		}
		trace(global.fog_end);
	}
	if (keyboard_check_pressed(vk_f6)){
			global.fog_end += 16;
		trace(global.fog_end);
	}
	if (keyboard_check(vk_escape)){
		global.fog_start = 32;
		global.fog_end = 32 * 5;
		trace(global.fog_start, global.fog_end);
	}
}

if (DEBUG_FOG_COLOR){
	if (keyboard_check(vk_f7)){
		if (keyboard_check(vk_lshift)){
			global.fog_sat--;
			if (global.fog_sat <= 0){
				global.fog_sat = 0;
			}
			trace(global.fog_sat);
		}
		else if (keyboard_check(vk_lcontrol)){
			global.fog_hue--;
			if (global.fog_hue <= 0){
				global.fog_hue = 0;
			}
			trace(global.fog_hue);
		}
		else{
			global.fog_val--;
			if (global.fog_val <= 0){
				global.fog_val = 0;
			}
			trace(global.fog_val);
		}
	}
	if (keyboard_check(vk_f8)){
		if (keyboard_check(vk_lshift)){
			global.fog_sat++;
			if (global.fog_sat >= 255){
				global.fog_sat = 255;
			}
			trace(global.fog_sat);
		}
		else if (keyboard_check(vk_lcontrol)){
			global.fog_hue++;
			if (global.fog_hue >= 255){
				global.fog_hue = 255;
			}
			trace(global.fog_hue);
		}
		else{
			global.fog_val++;
			if (global.fog_val >= 255){
				global.fog_val = 255;
			}
			trace(global.fog_val);
		}		
	}
	if (keyboard_check(vk_escape)){
		global.fog_hue = 0;
		global.fog_sat = 0;
		global.fog_val = 0;
		trace(global.fog_hue, global.fog_sat, global.fog_val);
	}
	global.fog_color = make_colour_hsv(global.fog_hue, global.fog_sat, global.fog_val);
}