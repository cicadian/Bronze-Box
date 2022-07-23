/// @func player_get_in_motion
/// @desc {bool} gets if the player object is moving
function player_get_in_motion(){
	var _inMotion = moving || turning;

	return _inMotion;
}

/// @func player_turn_rigid
/// @desc {void} runs turning behaviour for player
function player_turn_rigid(){
	if (keyboard_check_pressed(KEY_RIGHT)){
		dir -= 90; // Right...
		if (dir < 0){
			dir = 270;
		}
	}
	if (keyboard_check_pressed(KEY_LEFT)){
		dir += 90; // Left...
		if (dir >= 360){
			dir = 0;
		}
	}
}

/// @func player_move_rigid
/// @desc {void} runs moving behavior for the player
function player_move_rigid(){
	/*
	 We need to set a vector to determine which way to move when pressing forward or backward.
	 A not very helpful mnemonic for this is "x, cos y not sin?"
	*/
	var _vecX = dcos(dir);
	var _vecY = -dsin(dir);
	var _gridX = x div CELL_SIZE_WORLD;
	var _gridY = y div CELL_SIZE_WORLD;
	var _moveX = false;
	var _moveY = false;

	if (keyboard_check_pressed(KEY_FORWARD)){
		// Make sure we're not trying to leave the grid
		_moveX = (_gridX + _vecX) < ds_grid_width(global.world_grid) && (_gridX + _vecX) >= 0;
		_moveY = (_gridY + _vecY) < ds_grid_height(global.world_grid) && (_gridY + _vecY) >= 0;

		if (_moveX && _moveY){
			// Make sure we're not trying to enter a wall
			var _empty = global.world_grid[# _gridX + _vecX, _gridY + _vecY] == __CELL.EMPTY;
			if (_empty){
				x += CELL_SIZE_WORLD * _vecX;
				y += CELL_SIZE_WORLD * _vecY;
			}
		}
	}
	else if (keyboard_check_pressed(KEY_BACKWARD)){
		// Make sure we're not trying to leave the grid
		_moveX = (_gridX - _vecX) < ds_grid_width(global.world_grid) && (_gridX - _vecX) >= 0;
		_moveY = (_gridY - _vecY) < ds_grid_height(global.world_grid) && (_gridY - _vecY) >= 0;

		if (_moveX && _moveY){
			// Make sure we're not trying to enter a wall
			var _empty = global.world_grid[# _gridX - _vecX, _gridY - _vecY] == __CELL.EMPTY;
			if (_empty){
				x -= CELL_SIZE_WORLD * _vecX;
				y -= CELL_SIZE_WORLD * _vecY;
			}
		}
	}
	oController_World.rebuild = true;
}

/// @func player_turn_smooth
/// @desc {void} runs smooth turning behaviour for player
function player_turn_smooth(){
	var _inMotion = player_get_in_motion();

	if (!_inMotion){
		if (keyboard_check(KEY_RIGHT)){
			startDir = dir;
			nextDir = dir - 90; // Right...
			turning = true;
		}
		if (keyboard_check(KEY_LEFT)){
			startDir = dir;
			nextDir = dir + 90; // Left...
			turning = true;
		}
	}
	var _goAgain = false;

	if (turning){
		if (dir != nextDir){
			// Turn towards next dir
			var _turnCounterPercent = turnCounter / turnCounterMax;
			var _lerpDir = lerp(startDir, nextDir, _turnCounterPercent);
			dir = _lerpDir;
			turnCounter += turnCounterInc;
			// Wrap our dir
			if (dir == 360 || dir == -360){
				dir = 0;
				nextDir = 0;
			}
		}
		else{
			_goAgain = keyboard_check(KEY_RIGHT) || keyboard_check(KEY_LEFT);
			turning = false;
			turnCounter = 1;
		}
	}
	// Remove 1 frame pause when moving to next tile while holding
	if (_goAgain){
		if (keyboard_check(KEY_RIGHT)){
			startDir = dir;
			nextDir = dir - 90; // Right...
			turning = true;
		}
		if (keyboard_check(KEY_LEFT)){
			startDir = dir;
			nextDir = dir + 90; // Left...
			turning = true;
		}
		if (x != nextX || y != nextY){
			// Turn towards next dir
			var _turnCounterPercent = turnCounter / turnCounterMax;
			dir = lerp(startDir, nextDir, _turnCounterPercent);
			turnCounter += turnCounterInc;
			// Wrap our dir
			if (dir == 360 || dir == -360){
				dir = 0;
				nextDir = 0;
			}
		}
	}
}

/// @func player_move_smooth
/// @desc {void} runs smooth moving behavior for the player
function player_move_smooth(){
	/*
	 We need to set a vector to determine which way to move when pressing forward or backward.
	 A not very helpful mnemonic for this is "x, cos y not sin?"
	*/
	var _vecX = dcos(dir);
	var _vecY = -dsin(dir);
	var _gridX = x div CELL_SIZE_WORLD;
	var _gridY = y div CELL_SIZE_WORLD;
	var _moveX = false;
	var _moveY = false;
	var _inMotion = player_get_in_motion();

	if (!_inMotion){
		if (keyboard_check(KEY_FORWARD)){
			// Make sure we're not trying to leave the grid
			_moveX = (_gridX + _vecX) < ds_grid_width(global.world_grid) && (_gridX + _vecX) >= 0;
			_moveY = (_gridY + _vecY) < ds_grid_height(global.world_grid) && (_gridY + _vecY) >= 0;
			if (_moveX && _moveY){
				// Make sure we're not trying to enter a wall
				var _empty = global.world_grid[# _gridX + _vecX, _gridY + _vecY] == __CELL.EMPTY;
				if (_empty){
					startX = x;
					startY = y;
					nextX += CELL_SIZE_WORLD * _vecX;
					nextY += CELL_SIZE_WORLD * _vecY;
					moving = true;
				}
			}
		}
		else if (keyboard_check(KEY_BACKWARD)){
			// Make sure we're not trying to leave the grid
			_moveX = (_gridX - _vecX) < ds_grid_width(global.world_grid) && (_gridX - _vecX) >= 0;
			_moveY = (_gridY - _vecY) < ds_grid_height(global.world_grid) && (_gridY - _vecY) >= 0;
			if (_moveX && _moveY){
				// Make sure we're not trying to enter a wall
				var _empty = global.world_grid[# _gridX - _vecX, _gridY - _vecY] == __CELL.EMPTY;
				if (_empty){
					startX = x;
					startY = y;
					nextX -= CELL_SIZE_WORLD * _vecX;
					nextY -= CELL_SIZE_WORLD * _vecY;
					moving = true;
				}
			}
		}
	}
	var _goAgain = false;
	if (moving){
		if (x != nextX || y != nextY){
			// Move towards next position
			var _moveCounterPercent = moveCounter / moveCounterMax;
			var _lerpX = lerp(startX, nextX, _moveCounterPercent);
			var _lerpY = lerp(startY, nextY, _moveCounterPercent);
			x = _lerpX;
			y = _lerpY;
			moveCounter += moveCounterInc;
		}
		else{
			_goAgain = keyboard_check(KEY_FORWARD) || keyboard_check(KEY_BACKWARD);
			moving = false;
			moveCounter = 1;
			oController_World.rebuild = true;
		}
	}
	// Remove 1 frame pause when moving to next tile while holding
	if (_goAgain){
		if (keyboard_check(KEY_FORWARD)){
			// Make sure we're not trying to leave the grid
			_moveX = (_gridX + _vecX) < ds_grid_width(global.world_grid) && (_gridX + _vecX) >= 0;
			_moveY = (_gridY + _vecY) < ds_grid_height(global.world_grid) && (_gridY + _vecY) >= 0;

			if (_moveX && _moveY){
				// Make sure we're not trying to enter a wall
				var _empty = global.world_grid[# _gridX + _vecX, _gridY + _vecY] == __CELL.EMPTY;
				if (_empty){
					startX = x;
					startY = y;
					nextX += CELL_SIZE_WORLD * _vecX;
					nextY += CELL_SIZE_WORLD * _vecY;
					moving = true;
				}
			}
		}
		else if (keyboard_check(KEY_BACKWARD)){
			// Make sure we're not trying to leave the grid
			_moveX = (_gridX - _vecX) < ds_grid_width(global.world_grid) && (_gridX - _vecX) >= 0;
			_moveY = (_gridY - _vecY) < ds_grid_height(global.world_grid) && (_gridY - _vecY) >= 0;

			if (_moveX && _moveY){
				// Make sure we're not trying to enter a wall
				var _empty = global.world_grid[# _gridX - _vecX, _gridY - _vecY] == __CELL.EMPTY;
				if (_empty){
					startX = x;
					startY = y;
					nextX -= CELL_SIZE_WORLD * _vecX;
					nextY -= CELL_SIZE_WORLD * _vecY;
					moving = true;
				}
			}
		}
		if (x != nextX || y != nextY){
			// Move towards next position
			var _moveCounterPercent = moveCounter / moveCounterMax;
			var _lerpX = lerp(startX, nextX, _moveCounterPercent);
			var _lerpY = lerp(startY, nextY, _moveCounterPercent);
			x = _lerpX;
			y = _lerpY;
			moveCounter += moveCounterInc;
		}
	}
}