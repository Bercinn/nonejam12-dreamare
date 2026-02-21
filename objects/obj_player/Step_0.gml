inputs = {
	up: keyboard_check(ord("W")),
	left: keyboard_check(ord("A")),
	down: keyboard_check(ord("S")),
	right: keyboard_check(ord("D")),
};

if((inputs.right ^^ inputs.left) || (inputs.up ^^ inputs.down)){
	moving = 1;
	var _h = (inputs.right - inputs.left);
	var _v = (-inputs.up + inputs.down);
	
	move_dir = point_direction(0, 0, _h, _v);
}else{
	moving = 0;
}

var _hmove = lengthdir_x(moving * move_speed, move_dir);
var _vmove = lengthdir_y(moving * move_speed, move_dir);

hor_speed = lerp(hor_speed, _hmove, 0.15);
ver_speed = lerp(ver_speed, _vmove, 0.15);

move_and_collide(hor_speed, ver_speed, obj_solid);

if(moving){
	yscale = lerp(yscale, 1, 0.1);
	rotation = Wave(10, -10, 1.5);
}else{
	yscale = Wave(1, 0.85, 2);
	rotation = lerp(rotation, 0, 0.1);
}
