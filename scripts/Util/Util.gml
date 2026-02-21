function Wave(_from, _to, _duration, _offset = 0){
	var _half = (_to - _from) * 0.5;
	return _from + _half + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi*2)) * _half;
}
