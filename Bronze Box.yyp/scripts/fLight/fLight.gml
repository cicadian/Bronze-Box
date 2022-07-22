/// @func lightmap_build
/// @desc {void} builds the lightmap
function lightmap_build(){
	var _gridWidth = ds_grid_width(global.world_grid);
	var _gridHeight = ds_grid_height(global.world_grid);
	if (global.light_grid == undefined){
		global.light_grid = ds_grid_create(_gridWidth, _gridHeight);
	}
	ds_grid_clear(global.light_grid, 0);
	with (oLight_Point){
		var _gridX = x div CELL_SIZE_WORLD;
		var _gridY = y div CELL_SIZE_WORLD;
		ds_grid_add_disk(global.light_grid, _gridX, _gridY, 2.5, 0.25);
		ds_grid_add_disk(global.light_grid, _gridX, _gridY, 2, 0.25);
		ds_grid_add_disk(global.light_grid, _gridX, _gridY, 1.5, 0.25);
		ds_grid_add_disk(global.light_grid, _gridX, _gridY, 1, 0.25);
	}
	var _tempSurf = surface_create(_gridWidth, _gridHeight);
	surface_set_target(_tempSurf);
	draw_clear_alpha(c_black, 1);
	
	for (var _h = 0; _h < _gridHeight; _h++){
		for (var _w = 0; _w < _gridWidth; _w++){
			var _lightLevel = global.light_grid[# _w, _h];
			if (_lightLevel >= 1){
				_lightLevel = 1;
			}
			draw_sprite_ext(sPoint, 0, _w, _h, 1, 1, 0, c_white, _lightLevel);
		}
	}
	surface_reset_target();
	var _lightmapSpr = sprite_create_from_surface(_tempSurf, 0, 0, _gridWidth, _gridHeight, false, false, 0, 0);
	sprite_save(_lightmapSpr, 0, working_directory + "lightmap.png");
	sprite_delete(_lightmapSpr);
	surface_free(_tempSurf);
}