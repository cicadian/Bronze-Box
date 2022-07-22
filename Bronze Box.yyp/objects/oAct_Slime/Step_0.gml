if (moveCounter >= moveCounterMax){
	moveCounter = -1;
	var _gridX = x div CELL_SIZE_WORLD;
	var _gridY = y div CELL_SIZE_WORLD;
	var _gridW = ds_grid_width(global.world_grid);
	var _gridH = ds_grid_height(global.world_grid);
	var _dir = irandom(3);
	switch (_dir){
		case 0:
			if (_gridX + 1  < _gridW){
				if (global.world_grid[# _gridX + 1, _gridY] == __CELL.EMPTY){
					x += CELL_SIZE_WORLD;
					facing = __DIR.RIGHT;
				}
			}
			break;
		case 1:
			if (_gridY - 1  >= 0){
				if (global.world_grid[# _gridX, _gridY - 1] == __CELL.EMPTY){
					y -= CELL_SIZE_WORLD;
					facing = __DIR.UP;
				}
			}
			break;
		case 2:
			if (_gridX - 1  >= 0){
				if (global.world_grid[# _gridX - 1, _gridY] == __CELL.EMPTY){
					x -= CELL_SIZE_WORLD;
					facing = __DIR.LEFT;
				}
			}
			break;
		case 3:
			if (_gridY + 1  < _gridH){
				if (global.world_grid[# _gridX, _gridY + 1] == __CELL.EMPTY){
					y += CELL_SIZE_WORLD;
					facing = __DIR.DOWN;
				}
			}
			break;
	}
	actor_destroy();
	actor_build();
}
moveCounter++;