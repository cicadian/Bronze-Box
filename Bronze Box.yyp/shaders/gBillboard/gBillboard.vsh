attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	mat4 world_view = gm_Matrices[MATRIX_WORLD_VIEW];
	world_view[0][0] = 1.0;
	world_view[0][1] = 0.0;
	world_view[0][2] = 0.0;
	world_view[1][0] = 0.0;
	world_view[1][1] = -1.0;
	world_view[1][2] = 0.0;
	world_view[2][0] = 0.0;
	world_view[2][1] = 0.0;
	world_view[2][2] = 1.0;
	
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * (world_view * object_space_pos);
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
