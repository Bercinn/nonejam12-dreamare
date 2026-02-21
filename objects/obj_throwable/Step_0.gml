if(thrown){
	image_angle+=force;
	
	lifetime--;
	if(lifetime <= 0){
		force = lerp(force, 0, 0.05);
		if(force <= 0.2){
			force = 0;
			lifetime = game_get_speed(gamespeed_fps) * mass;
			thrown = false;
		}
	}
}

push_x = lengthdir_x(force, dir);
push_y = lengthdir_y(force, dir);
move_and_collide(push_x, push_y, obj_solid);
