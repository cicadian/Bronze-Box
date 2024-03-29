#region Init
application_surface_draw_enable(false);
window_set_size(NATIVE_W * WINDOW_SCALE, NATIVE_H * WINDOW_SCALE);

world_format = undefined;
world_vbuff = undefined;
world_width = undefined;
world_height = undefined;
world_texture = undefined;
global.world_grid = undefined;
global.fov = 70;
global.fog_color = c_black;
global.fog_hue = 0;
global.fog_sat = 0;
global.fog_val = 0;
global.fog_start = CELL_SIZE_WORLD;
global.fog_end = CELL_SIZE_WORLD * 5;
global.debug_stats = true;
var _layer = layer_get_id(LAYER_NAME);
layer_set_visible(_layer, false);
#endregion

#region Vertex Format
/*
 A vertex format determines how the vertex buffer is built and interpreted by the renderer.
*/
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_colour();
world_format = vertex_format_end();
#endregion

#region Texture Coordinates
tex_room_0 = sprite_get_texture(sDungeon, 0);
tex_room_1 = sprite_get_texture(sDungeon, 1);

texcoord_size = 0.5; // normalised space our sprites take up on our texture
texcoord_wall_u = 0.5;
texcoord_wall_v = 0;
texcoord_floor_u = 0.5;
texcoord_floor_v = 0.5;
texcoord_ceiling_u = 0;
texcoord_ceiling_v = 0;
#endregion

surface_world = -1;