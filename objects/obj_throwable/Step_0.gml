if(thrown){
	image_angle+=force;
	
	hspeed = lengthdir_x(force, dir);
	vspeed = lengthdir_y(force, dir);
	
	var _en = instance_place(x, y, obj_enemy);
	if(_en && !_en.dead){
		var _kdir = point_direction(x, y, _en.x, _en.y);
	
		var _nx = x - _en.x;
		var _ny = y - _en.y;
	
		_en.dead = true;
	
		var _len = point_distance(0, 0, _nx, _ny);
		if(_len != 0){
			_nx /= _len;
			_ny /= _len;
		}
	
		var _dot = hspeed * _nx + vspeed * _ny;
		hspeed -= 2 * _dot * _nx;
		vspeed -= 2 * _dot * _ny;
	}
	
	lifetime--;
	if(lifetime <= 0){
		force = lerp(force, 0, 0.05);
		if(force <= 0){
			force = 0;
			lifetime = game_get_speed(gamespeed_fps) * mass;
			thrown = false;
		}
	}
}

if(place_meeting(x + hspeed, y, obj_solid)) hspeed = -hspeed;
if(place_meeting(x, y + vspeed, obj_solid)) vspeed = -vspeed;

dir = point_direction(0, 0, hspeed, vspeed);
