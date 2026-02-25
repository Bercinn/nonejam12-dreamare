var _hole = collision_circle(x, y, 32, obj_hole, false, true);
if(_hole){
	if(instance_exists(obj_player)){
		if(obj_player.item_held != undefined){
			obj_player.item_held = undefined;
		}
		
		depth = obj_player.depth + 1;
	}
	
	collectable = false;
	
	x = _hole.center_x;
	y = _hole.center_y;
	
	var _col = instance_place(_hole.x, _hole.y, obj_solid);
	if(_col){
		instance_destroy(_col);
	}
	
	instance_destroy(_hole);
}
