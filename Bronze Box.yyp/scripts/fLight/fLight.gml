/// @func lightmap_build
/// @desc {void} builds the lightmap
function lightmap_build(){
	global.light_grid = ds_grid_create(world_width, world_height);
	ds_grid_clear(global.light_grid, 0);
	with (oLight_Point){
		var _gridX = x div CELL_SIZE_WORLD;
		var _gridY = y div CELL_SIZE_WORLD;
		ds_grid_add_disk(global.light_grid, _gridX, _gridY, 2.5, 0.25);
		ds_grid_add_disk(global.light_grid, _gridX, _gridY, 2, 0.25);
		ds_grid_add_disk(global.light_grid, _gridX, _gridY, 1.5, 0.25);
		ds_grid_add_disk(global.light_grid, _gridX, _gridY, 1, 0.25);
	}
}

/// @func lightmap_destroy
/// @desc {void} destroys the lightmap
function lightmap_destroy(){
	ds_grid_destroy(global.light_grid);
}