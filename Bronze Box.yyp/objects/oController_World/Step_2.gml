if (!is_undefined(world_vbuff)){
	if (!surface_exists(surface_world)){
		surface_world = surface_create(NATIVE_W, NATIVE_H);
	}
	surface_set_target(surface_world);
	draw_clear_alpha(c_black, 1);
	var _playerDir = oPlayer.dir;
	var _playerYaw = oPlayer.yaw;
	var _playerPitch = oPlayer.pitch;
	
	var _camX = oPlayer.x;
	var _camY = oPlayer.y;
	var _camZ = oPlayer.z;
	var _camDX = dcos(_playerDir + -_playerYaw);
	var _camDY = -dsin(_playerDir + -_playerYaw);
	var _camDZ = -dsin(_playerPitch);
	
	var _aspect = GAME_ASPECT_DEFAULT;

	gpu_set_alphatestenable(true);
	gpu_set_ztestenable(true);
	gpu_set_zwriteenable(true);
	gpu_set_tex_repeat(true);
	
	var _viewPrev = matrix_get(matrix_view);
	var _projPrev = matrix_get(matrix_projection);
	
	matrix_set(matrix_view, matrix_build_lookat(_camX, _camY, _camZ,
												_camX + _camDX, _camY + _camDY, _camZ + _camDZ,
												0, 0, 1));
	matrix_set(matrix_projection, matrix_build_projection_perspective_fov(global.fov, _aspect,  1, 2000));
	gpu_set_fog(DEBUG_FOG_ENABLE, global.fog_color, global.fog_start, global.fog_end);
	
	vertex_submit(world_vbuff, pr_trianglelist, world_texture);
	surface_reset_target();
	
	gpu_set_fog(false, global.fog_color, global.fog_start, global.fog_end);
	matrix_set(matrix_world, matrix_build_identity());
	matrix_set(matrix_view, _viewPrev);
	matrix_set(matrix_projection, _projPrev);
	
	gpu_set_ztestenable(false);
	gpu_set_zwriteenable(false);
	gpu_set_cullmode(cull_noculling);
	gpu_set_tex_repeat(false);
}