function StateMachine(_states) constructor{
	__current_state = undefined;
	
	var _len = array_length(_states);
	for(var _i = 0; _i < _len; _i++){
		var _state = _states[_i];
		var _state_name = _state.name;
		
		self[$ _state_name] = _state;
	}
	
	static update = function(){
		if(__current_state != undefined){
			if(__current_state.update != undefined){
				__current_state.update();
			}
		}
	}
	
	static set_state = function(_new_state){
		var _state = self[$ _new_state];
		
		if(__current_state != _state){
			if(__current_state.on_exit != undefined) __current_state.on_exit();
			__current_state = _state;
			if(__current_state.on_enter != undefined) __current_state.on_enter();
		}
	}
}

function State(_name, _on_enter, _update, _on_exit) constructor{
	name = _name;
	on_enter = _on_enter;
	update = _update;
	on_exit = _on_exit;
}
