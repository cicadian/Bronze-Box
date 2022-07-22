/// @func actor_build
/// @desc {void} builds the actors in the world
function actor_build(){
	if (actor_vbuff == undefined){
		actor_vbuff = vertex_create_buffer();
	}
	actor_texture = texture;
	vertex_begin(actor_vbuff, actor_format);
	var _gridX = x div CELL_SIZE_WORLD;
	var _gridY = y div CELL_SIZE_WORLD;
	var _x = x - 4;
	var _y = y - 4;
	var _z = 0;
	var _x2 = x + 4;
	var _y2 = y + 4;
	var _z2 = _z + 8;
	var _colour = c_white;
	var _umod = 0;
	var _vmod = 0;
	if (facing == __DIR.RIGHT){
		_umod = 0;
		_vmod = 0;
	}
	else if (facing == __DIR.UP){
		_umod = 1 * s;
		_vmod = 0;
	}
	else if (facing == __DIR.LEFT){
		_umod = 2 * s;
		_vmod = 0;
	}
	else if (facing == __DIR.DOWN){
		_umod = 3 * s;
		_vmod = 0;
	}
	// Tri 1
	vertex_position_3d(actor_vbuff, _x, _y, _z2);
	vertex_texcoord(actor_vbuff, u + _umod, v + _vmod);
	vertex_colour(actor_vbuff, _colour, 1);
	vertex_position_3d(actor_vbuff, _x, _y2, _z2);
	vertex_texcoord(actor_vbuff, u + _umod + s, v + _vmod);
	vertex_colour(actor_vbuff, _colour, 1);
	vertex_position_3d(actor_vbuff, _x, _y2, _z);
	vertex_texcoord(actor_vbuff, u + _umod + s, v + _vmod + s);
	vertex_colour(actor_vbuff, _colour, 1);
	// Tri 2
	vertex_position_3d(actor_vbuff, _x, _y, _z2);
	vertex_texcoord(actor_vbuff, u + _umod, v + _vmod);
	vertex_colour(actor_vbuff, _colour, 1);
	vertex_position_3d(actor_vbuff, _x, _y2, _z);
	vertex_texcoord(actor_vbuff, u + _umod + s, v + _vmod + s);
	vertex_colour(actor_vbuff, _colour, 1);
	vertex_position_3d(actor_vbuff, _x, _y, _z);
	vertex_texcoord(actor_vbuff, u + _umod, v + _vmod + s);
	vertex_colour(actor_vbuff, _colour, 1);

	vertex_end(actor_vbuff);
	vertex_freeze(actor_vbuff);
}

/// @func actor_destroy
/// @desc {void} destroys the actor
function actor_destroy(){
	vertex_delete_buffer(actor_vbuff);
	actor_vbuff = undefined;
}