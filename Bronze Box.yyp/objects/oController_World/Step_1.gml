if (rebuild){
	lightmap_destroy();
	world_destroy();
	world_init();
	lightmap_build();
	world_build();
	rebuild = false;
}