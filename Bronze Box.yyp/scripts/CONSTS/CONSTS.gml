// Dev
#macro TRACE_WHOIS false
#macro TRACE_NOTCH false
#macro TRACE_ALLOW true
#macro DEBUG_FOV false
#macro DEBUG_FOG_DISTANCE true
#macro DEBUG_FOG_COLOR true
// Game
#macro FREELOOK_RADIUS 60 // 120 degree angle on view cone

// World
#macro NATIVE_W 320
#macro NATIVE_H 180
#macro WINDOW_SCALE 4
#macro LAYER_NAME "cells" // name of the layer we paint our maps on
#macro CELL_SIZE_WORLD 32 // size of the cells in world space
#macro GAME_ASPECT_DEFAULT NATIVE_W / NATIVE_H // 1.7~

enum __CELL{ // used to quickly reference map cells
	FULL, // this is a wall
	EMPTY // this is walkable space
}

enum __WALL{ // used to quickly reference the sides(faces/walls) of our world cells
	EAST,
	NORTH,
	WEST,
	SOUTH,
	
	FLOOR,
	CEILING,
	
	SIZE // used to get how long this enum is, __WALL.SIZE - 1
}

// Player
#macro MOVE_SMOOTH true
#macro KEY_FORWARD ord("W")
#macro KEY_BACKWARD ord("S")
#macro KEY_RIGHT ord("D")
#macro KEY_LEFT ord("A")

