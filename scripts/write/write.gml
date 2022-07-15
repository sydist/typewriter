function write(_x, _y, _str, _spd, _fnt, _snd, _clr = 0xffffff, _xyscale = [1, 1], _hvsep = [0, 0], _mono = false, _func = [], _endfunc = function(){}, _page = 0, _depth = depth) {
	return instance_create_depth(_x, _y, _depth, obj_writer, {
		pages: _str,
		page: _page,
		spd: _spd,
		
		xscale: _xyscale[0],
		yscale: _xyscale[1],
		monospace: _mono,
		hsep: _hvsep[0],
		vsep: _hvsep[1],
		
		sound: _snd,
		fontstruct: _fnt,
		font: _fnt.font,
		sprite: _fnt.sprite,
		color: _clr,
		
		functions: _func,
		endfunction: _endfunc,
	});
}
