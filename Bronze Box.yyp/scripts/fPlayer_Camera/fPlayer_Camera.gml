/// @func player_freelook
/// @desc {type} runs freelook mouse aiming for the player, clamped to a cone
/// @arg {type}
function player_freelook(){
	var _press_aim = mouse_check_button_pressed(mb_right);
	var _hold_aim = mouse_check_button(mb_right);
	var _release_aim = mouse_check_button_released(mb_right);

	if (_press_aim){
		yawStart = mouse_x - (NATIVE_W / 2);
		pitchStart = mouse_y - (NATIVE_H / 2);
		mouseStartX = window_mouse_get_x();
		mouseStartY = window_mouse_get_y();
		window_set_cursor(cr_none);
	}
	if (_hold_aim){
		var _tempPointX = clamp(mouse_x - yawStart, 0, NATIVE_W);
		var _tempPointY = clamp(mouse_y - pitchStart, 0, NATIVE_H);
		yaw = range_convert(0, NATIVE_W, -FREELOOK_RADIUS, FREELOOK_RADIUS, _tempPointX);
		pitch = range_convert(0, NATIVE_H, -FREELOOK_RADIUS, FREELOOK_RADIUS, _tempPointY);
	}
	if (_release_aim){
		window_set_cursor(cr_default);
		window_mouse_set(mouseStartX, mouseStartY);
		resetAim = true;
	}
	if (resetAim){
		if (yaw != 0 && pitch != 0){
			var _aimCounterPercent = aimCounter / aimCounterMax;
			yaw = lerp(yaw, 0, _aimCounterPercent);
			pitch = lerp(pitch, 0, _aimCounterPercent);
			aimCounter += aimCounterInc;
		}
		else{
			resetAim = false;
			aimCounter = 0;
		}
	}
}
