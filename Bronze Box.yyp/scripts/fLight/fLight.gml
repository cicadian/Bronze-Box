/// @func lightmap_build
/// @desc {void} builds the lightmap
function lightmap_build(){
	global.light_grid = ds_grid_create(world_width, world_height);
	ds_grid_clear(global.light_grid, 0);
	var _openset = ds_grid_create(world_width, world_height);
	ds_grid_clear(_openset, true);
	with (oLight_Point){
		var _gridX = x div CELL_SIZE_WORLD;
		var _gridY = y div CELL_SIZE_WORLD;
		lightmap_search(_gridX, _gridY, radius, _openset);
	}
	ds_grid_destroy(_openset);
}

/// @func lightmap_search
/// @desc {void} moves along the world grid leaving light values behind
/// @arg {real} gridX
/// @arg {real} gridX
/// @arg {real} distanceRemaining
/// @arg {grid} openSet
function lightmap_search(_gridX, _gridY, _distanceRemaining, _openset){
	global.light_grid[# _gridX, _gridY] += _distanceRemaining / radius;
	_openset[# _gridX, _gridY] = false;
	_distanceRemaining--;
	if (_distanceRemaining > 0){
		if (_gridX - 1 >= 0){
			var _freeLeft = global.world_grid[# _gridX - 1, _gridY] == __CELL.EMPTY && _openset[# _gridX - 1, _gridY];
			if (_freeLeft){
				lightmap_search(_gridX - 1, _gridY, _distanceRemaining, _openset);
			}
		}
		if (_gridX + 1 < ds_grid_width(global.world_grid)){
			var _freeRight = global.world_grid[# _gridX + 1, _gridY] == __CELL.EMPTY && _openset[# _gridX + 1, _gridY];
			if (_freeRight){
				lightmap_search(_gridX + 1, _gridY, _distanceRemaining, _openset);
			}
		}
		if (_gridY - 1 >= 0){
			var _freeUp = global.world_grid[# _gridX, _gridY - 1] == __CELL.EMPTY && _openset[# _gridX, _gridY - 1];
			if (_freeUp){
				lightmap_search(_gridX, _gridY - 1, _distanceRemaining, _openset);
			}
		}
		if (_gridY + 1 < ds_grid_height(global.world_grid)){
			var _freeDown = global.world_grid[# _gridX, _gridY + 1] == __CELL.EMPTY && _openset[# _gridX, _gridY + 1];
			if (_freeDown){
				lightmap_search(_gridX, _gridY + 1, _distanceRemaining, _openset);
			}
		}
	}
}

/// @func lightmap_destroy
/// @desc {void} destroys the lightmap
function lightmap_destroy(){
	ds_grid_destroy(global.light_grid);
}