function instance_create(_x, _y, _depth, _object, _argsStruct = {}) {
	var _inst = instance_create_depth(_x, _y, _depth, obj_blank);
	with(_inst) {
		args = _argsStruct;
		instance_change(_object, true);
		delete args;
	}
	return _inst;
}

