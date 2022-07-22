actor_vbuff = undefined;
texture = sprite_get_texture(sAct_Slime, 0);
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_colour();
actor_format = vertex_format_end();

res = 256;
uvpix = 1 / 256;
u = 0;
v = 0;
s = 64 * uvpix;

moveCounter = 0;
moveCounterMax = 60;

facing = __DIR.LEFT;