function Event() constructor{
	__type = "";
	
	static get_type = function(){
		return self.__type;
	}
}

function CollectEvent(_target, _item) : Event() constructor{
	__type = "collect_event";
	target = _target;
	item = _item;
}

