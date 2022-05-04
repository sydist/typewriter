function write(_x, _y, _str, _spd, _fnt, _snd, _clr = 0xffffff, _xyscale = [1, 1], _hvsep = [0, 0], _mono = false, _func = [], _endfunc = function(){}, _page = 0) {
	var _inst = instance_create_depth(_x, _y, depth, obj_writer);
	
	with(_inst) {
		pages = _str;
		page = _page;
		message = _str[_page];
		
		queueCommands();
		
		progress = 0;
		length = string_length(message);
		spd = _spd;
		
		xScale = _xyscale[0];
		yScale = _xyscale[1];
		monoSpace = _mono;
		hSep = _hvsep[0];
		vSep = _hvsep[1];
		
		sound = _snd;
		font = _fnt.font;
		sprite = _fnt.sprite;
		color = _clr;
		
		functions = _func;
		endFunction = _endfunc
		
		commandCheck();	
	}
	
	return _inst;
}

