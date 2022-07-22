/// @func world_build
/// @desc {void} builds the world
function world_build(){
	global.world_grid = ds_grid_create(world_width, world_height);
	ds_grid_clear(global.world_grid, __CELL.FULL);
	world_texture = choose(tex_room_0, tex_room_1);
	tile_to_grid(LAYER_NAME, global.world_grid, __CELL.EMPTY);

	world_vbuff = vertex_create_buffer();
	vertex_begin(world_vbuff, world_format);

	for (var _gridY = 0; _gridY < world_height; _gridY++){
		for (var _gridX = 0; _gridX < world_width; _gridX++){
			world_build_cell(_gridX, _gridY);
		}
	}

	vertex_end(world_vbuff);
	vertex_freeze(world_vbuff);
}

/// @func world_build_cell
/// @desc {void}
/// @arg {real} gridX
/// @arg {real} gridY
function world_build_cell(_gridX, _gridY){
	for (var _i = 0; _i < __WALL.SIZE; _i++){
		var _empty = global.world_grid[# _gridX, _gridY] == __CELL.EMPTY;
		if (_empty){
			world_build_wall(_gridX, _gridY, _i);
		}
	}
}

/// @func world_build_wall
/// @desc {void} builds the wall of a cell at given coordinates from a given side
/// @arg {real} gridX
/// @arg {real} gridY
/// @arg {real} wall
function world_build_wall(_gridX, _gridY, _wall){
	var _x = _gridX * CELL_SIZE_WORLD;
	var _y = _gridY * CELL_SIZE_WORLD;
	var _z = 0;
	var _x2 = _x + CELL_SIZE_WORLD;
	var _y2 = _y + CELL_SIZE_WORLD;
	var _z2 = _z + CELL_SIZE_WORLD * 0.8125;

	var _lightLevel = global.light_grid[# _gridX, _gridY] + global.light_ambient;
	var _colour = make_colour_rgb(_lightLevel * 255, _lightLevel * 255, _lightLevel * 255);
	if (_lightLevel > 1){
		_colour = c_white;
	}

	var _build = false;
	// NOTE Each triangle pair shares 2 verts with identical positions
	// TODO West and South have horizontally flipped textures
	switch(_wall){
		case __WALL.EAST:
			if (_gridX + 1 < ds_grid_width(global.world_grid)){
				_build = global.world_grid[# _gridX + 1, _gridY] == __CELL.FULL;
			}
			else{
				_build = true;
			}
			if (_build){
				// Tri 1
				vertex_position_3d(world_vbuff, _x2, _y, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x2, _y2, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x2, _y2, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				// Tri 2
				vertex_position_3d(world_vbuff, _x2, _y, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x2, _y2, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x2, _y, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
			}
		break;
		case __WALL.NORTH:
			if (_gridY - 1 >= 0){
				_build = global.world_grid[# _gridX, _gridY - 1] == __CELL.FULL;
			}
			else{
				_build = true;
			}
			if (_build){
				// Tri 1
				vertex_position_3d(world_vbuff, _x, _y, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x2, _y, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x, _y, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				// Tri 2
				vertex_position_3d(world_vbuff, _x2, _y, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x2, _y, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x, _y, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
			}
		break;
		case __WALL.WEST:
			if (_gridX - 1 >= 0){
				_build = global.world_grid[# _gridX - 1, _gridY] == __CELL.FULL;
			}
			else{
				_build = true;
			}
			if (_build){
				// Tri 1
				vertex_position_3d(world_vbuff, _x, _y2, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x, _y2, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x, _y, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				// Tri 2
				vertex_position_3d(world_vbuff, _x, _y, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x, _y2, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x, _y, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
			}
		break;
		case __WALL.SOUTH:
			if (_gridY + 1 < ds_grid_height(global.world_grid)){
				_build = global.world_grid[# _gridX, _gridY + 1] == __CELL.FULL;
			}
			else{
				_build = true;
			}
			if (_build){
				// Tri 1
				vertex_position_3d(world_vbuff, _x2, _y2, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x2, _y2, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x, _y2, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
				// Tri 2
				vertex_position_3d(world_vbuff, _x, _y2, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x2, _y2, _z);
				vertex_texcoord(world_vbuff, texcoord_wall_u, texcoord_wall_v + texcoord_wall_s);
				vertex_colour(world_vbuff, _colour, 1);
				vertex_position_3d(world_vbuff, _x, _y2, _z2);
				vertex_texcoord(world_vbuff, texcoord_wall_u + texcoord_wall_s, texcoord_wall_v);
				vertex_colour(world_vbuff, _colour, 1);
			}
		break;
		case __WALL.FLOOR:
			// Tri 1
			vertex_position_3d(world_vbuff, _x, _y, _z); // Top Left
			vertex_texcoord(world_vbuff, texcoord_floor_u, texcoord_floor_v);
			vertex_colour(world_vbuff, _colour, 1);
			vertex_position_3d(world_vbuff, _x2, _y, _z); // Top Right
			vertex_texcoord(world_vbuff, texcoord_floor_u + texcoord_size, texcoord_floor_v);
			vertex_colour(world_vbuff, _colour, 1);
			vertex_position_3d(world_vbuff, _x2, _y2, _z); // Bot Right
			vertex_texcoord(world_vbuff, texcoord_floor_u + texcoord_size, texcoord_floor_v + texcoord_size);
			vertex_colour(world_vbuff, _colour, 1);
			// Tri 2
			vertex_position_3d(world_vbuff, _x, _y, _z); // Top Left Again
			vertex_texcoord(world_vbuff, texcoord_floor_u, texcoord_floor_v);
			vertex_colour(world_vbuff, _colour, 1);
			vertex_position_3d(world_vbuff, _x2, _y2, _z); // Bot Right Again
			vertex_texcoord(world_vbuff, texcoord_floor_u + texcoord_size, texcoord_floor_v + texcoord_size);
			vertex_colour(world_vbuff, _colour, 1);
			vertex_position_3d(world_vbuff, _x, _y2, _z); // Bot Left
			vertex_texcoord(world_vbuff, texcoord_floor_u, texcoord_floor_v + texcoord_size);
			vertex_colour(world_vbuff, _colour, 1);
		break;
		case __WALL.CEILING:
			// Tri 1
			vertex_position_3d(world_vbuff, _x, _y2, _z2);
			vertex_texcoord(world_vbuff, texcoord_ceiling_u, texcoord_ceiling_v + texcoord_size);
			vertex_colour(world_vbuff, _colour, 1);
			vertex_position_3d(world_vbuff, _x2, _y2, _z2);
			vertex_texcoord(world_vbuff, texcoord_ceiling_u + texcoord_size, texcoord_ceiling_v + texcoord_size);
			vertex_colour(world_vbuff, _colour, 1);
			vertex_position_3d(world_vbuff, _x, _y, _z2);
			vertex_texcoord(world_vbuff, texcoord_ceiling_u, texcoord_ceiling_v);
			vertex_colour(world_vbuff, _colour, 1);
			// Tri 2
			vertex_position_3d(world_vbuff, _x2, _y2, _z2);
			vertex_texcoord(world_vbuff, texcoord_ceiling_u + texcoord_size, texcoord_ceiling_v + texcoord_size);
			vertex_colour(world_vbuff, _colour, 1);
			vertex_position_3d(world_vbuff, _x2, _y, _z2);
			vertex_texcoord(world_vbuff, texcoord_ceiling_u + texcoord_size, texcoord_ceiling_v);
			vertex_colour(world_vbuff, _colour, 1);
			vertex_position_3d(world_vbuff, _x, _y, _z2);
			vertex_texcoord(world_vbuff, texcoord_ceiling_u, texcoord_ceiling_v);
			vertex_colour(world_vbuff, _colour, 1);
		break;
	}
}

/// @func world_destroy
/// @desc {void} destroys the world
function world_destroy(){
	world_width = undefined;
	world_height = undefined

	vertex_delete_buffer(world_vbuff);
	world_vbuff = undefined;

	ds_grid_destroy(global.world_grid);

	world_texture = undefined;
}