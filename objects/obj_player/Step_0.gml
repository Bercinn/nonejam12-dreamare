inputs = {
	up: keyboard_check(ord("W")),
	left: keyboard_check(ord("A")),
	down: keyboard_check(ord("S")),
	right: keyboard_check(ord("D")),
	dash: keyboard_check_pressed(vk_space),
	interact: keyboard_check_pressed(ord("F")),
	attack: mouse_check_button_pressed(mb_left),
	switch_mode: mouse_check_button_pressed(mb_right)
};

center_y = y - sprite_get_height(sprite_index) / 2;
mouse_dir = point_direction(x, center_y, mouse_x, mouse_y);

xscale = lerp(xscale, 1, 0.1);
yscale = lerp(yscale, 1, 0.1);

knockback_x = lerp(knockback_x, 0, 0.2); 
knockback_y = lerp(knockback_y, 0, 0.2);

dash_push_x = lerp(dash_push_x, 0, 0.2);
dash_push_y = lerp(dash_push_y, 0, 0.2);

// Trocar modo
if(inputs.switch_mode){
	global.nightmare = !global.nightmare;
}

// Dash
dash_timer--;
if(dash_timer <= 0){
	if(inputs.dash){
		dash_push_x = lengthdir_x(dash_force, mouse_dir);
		dash_push_y = lengthdir_y(dash_force, mouse_dir);
	
		xscale = 1.2;
		yscale = 0.7;
		
		dash_timer = dash_delay;
	}
}

// Movimento
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

hor_speed += dash_push_x;
ver_speed += dash_push_y;

hor_speed += knockback_x;
ver_speed += knockback_y;

move_and_collide(hor_speed, ver_speed, obj_solid);

// Coletar
var _collectable = collision_circle(x, center_y, 20, obj_throwable, false, true);
if(_collectable){
	if(item_held == undefined && inputs.interact){
		item_held = _collectable;
		interact_timer = interact_delay;
	}
}

var _hole_filler = collision_circle(x, center_y, 20, obj_hole_filler, false, true);
if(_hole_filler && _hole_filler.collectable){
	if(item_held == undefined && inputs.interact){
		item_held = _hole_filler;
		interact_timer = interact_delay;
	}
}

if(item_held != undefined){
	item_held.x = x;
	item_held.y = center_y + 8;
	
	item_held.image_angle = 0;
	
	interact_timer--;
	if(interact_timer <= 0){
		interact_timer = 0;
		if(inputs.interact){
			item_held = undefined;
			interact_timer = interact_delay;
		}
	}
	
	if(object_get_parent(item_held.object_index) == obj_throwable && inputs.attack){
		item_held.force = 0;
		item_held.dir = 0;
		
		item_held.thrown = true;
		item_held.dir = mouse_dir;
		item_held.force = launch_force;
		item_held = undefined;
		
		knockback_x = lengthdir_x(2, mouse_dir + 180);
		knockback_y = lengthdir_y(2, mouse_dir + 180);
		
		xscale = 1.1;
		yscale = 0.8;
	}
}

// Visuais
if(moving){
	anim_yscale = lerp(anim_yscale, 1, 0.1);
	rotation = Wave(0, -10 * image_xscale, 0.5);
}else{
	anim_yscale = Wave(1, 0.85, 2);
	rotation = lerp(rotation, 0, 0.1);
}

var _s = sign(dcos(mouse_dir));
if(_s != 0){
	image_xscale = _s;
}
