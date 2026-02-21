function Event() constructor{
	__type = "";
	
	static get_type = function(){
		return self.__type;
	}
}

function TestEvent(_arg) : Event() constructor{
	__type = "test_event";
	test = _arg;
}
