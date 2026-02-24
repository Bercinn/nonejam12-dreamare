if(!dead){
	image_yscale = Wave(1.1, 0.85, 1.5);
	image_xscale = Wave(1, 0.9, 1.5);
	
	if(instance_exists(obj_player)){
		var _dir = point_direction(x, y, obj_player.x, obj_player.y);
		
		var _h = lengthdir_x(1, _dir);
		var _v = lengthdir_y(1, _dir);
		
		hor_speed = lerp(hor_speed, _h, 0.15);
		ver_speed = lerp(ver_speed, _v, 0.15);
	}
	
	move_and_collide(hor_speed, ver_speed, obj_solid);
}else{
	image_xscale = lerp(image_xscale, 0, 0.15);
	image_yscale = lerp(image_yscale, 0, 0.15);
	
	if(image_xscale <= 0 && image_yscale <= 0){
		instance_destroy();
	}
}
