#region COMMANDS

commandsQueue = ds_queue_create();
commands = {};

commands[$ ">"] = function(_value) // Function
{ 
	functions[real(_value)]();
};
commands[$ "p"] = function(_value) // Pause
{ 
	pause = real(_value);
};
commands[$ "a"] = function(_value) // Angle
{ 
	angle = real(_value);
	nlAngle = -dsin(angle);
};
commands[$ "r"] = function(_value) // Reset Effects
{ 
	effect = "normal";
};
commands[$ "s"] = function(_value) // Shake Effect
{ 
	effect = "shake";
	shake = real(_value);
};
commands[$ "w"] = function(_value) // Wave Effect
{ 
	effect = "wave";
	wave = real(_value);
};
commands[$ "t"] = function(_value) // Speed
{ 
	spd = real(_value);
};
commands[$ "c"] = function(_value) // Color
{ 
	var c = real("0x" + _value);
	color = ((c >> 16) & 0xFF) | (c & 0xFF00) | ((c << 16) &  0xFF0000);
};
commands[$ "f"] = function(_value) // Font
{ 
	var f = variable_global_get(_value);
	font = f.font;
	sprite = f.sprite;
};
commands[$ "x"] = function(_value) // Scale
{ 
	xscale = real(_value);
	yscale = real(_value);
};
commands[$ "n"] = function(_value) // New Line
{ 
	var _indent = _value;
	var _indentLength = string_length(_indent);
	
	var _hsep = hsep * xscale;
	var _vsep = vsep * yscale;
	
	var _cosNlAngle = dcos(nlAngle);
	var _sinNlAngle = dsin(nlAngle);
	
	var _cosAngle = dcos(angle);
	var _sinAngle = dsin(angle);
	
	var _xScaleMono = xscale * !monospace;
	var _yScaleMono = yscale * !monospace;
	
	xOffset = ((xOffset + (string_width("0")  * _xScaleMono) + _hsep) * _cosNlAngle) + (((string_width(_indent) * _xScaleMono) + (_indentLength * _hsep)) * _cosAngle);
	yOffset = ((yOffset + (string_height("0") * _yScaleMono) + _vsep) * -_sinNlAngle) + (((string_height(_indent) * _indentLength * _yScaleMono) + (_indentLength * _vsep)) * -_sinAngle);
};

#endregion

#region FUNCTIONS

function queueCommands() 
{
	var _count = string_count(CMD_START, message);
	var _startPos = 0;
	
	var i = 0;
	while(i < _count)
	{
		var _cmdStart = string_pos_ext(CMD_START, message, _startPos);
		var _cmd = string_copy(message, _cmdStart + 1, 1);
		_startPos = _cmdStart - 1;
		
		i++;
		if (!variable_struct_exists(commands, _cmd))
		{
			if (_cmd == CMD_START)
			{
				message = string_delete(message, _cmdStart, 1);
				i++;
			}
			_startPos++
			continue;
		}
		
		var _length = string_pos_ext(CMD_BREAK, message, _cmdStart + 1) - _cmdStart + 1;
		var _input = string_copy(message, _cmdStart + 2, _length - 3);
		
		ds_queue_enqueue(commandsQueue, { pos: _cmdStart, name: _cmd, value: _input });
		
		message = string_delete(message, _cmdStart, _length);
	}
}
function commandCheck() 
{
	while (true)
	{
		if (ds_queue_empty(commandsQueue)) 
			return;
		
		head = ds_queue_head(commandsQueue);
		if ((progress + 1) != head.pos) 
			return;
		
		commands[$ head.name](head.value);
		ds_queue_dequeue(commandsQueue);	
	}
}
function setPos(_x, _y) 
{
	x = _x;
	y = _y;
	with(par_letter) {
		writerX = writerId.x;
		writerY = writerId.y;
		x = writerX + xOffset;
		y = writerY + yOffset;	
	}
}
function next(_page) 
{
	with(par_letter)
		if (writerId == other.id)
			instance_destroy();
	
	var _isLast = (_page == array_length(book));
	if (_isLast)
	{
		instance_destroy();
		exit;
	}
	
	isOver = false;
	progress = 0;
	xOffset = 0;
	yOffset = 0;

	ds_queue_clear(commandsQueue);
	
	message = book[_page];

	queueCommands();
	commandCheck();
	
	length = string_length(message);

	if (!pause)
		event_perform(ev_alarm, 0)
	else 
		alarm[0] = spd + pause
	
	alarm[1] = -1;
	alarm[2] = 1;
}
function skip() 
{
	pause = 0;
	alarm[0] = 0;
	
	repeat(length - progress) 
		event_perform(ev_alarm, 0);
		
	audio_stop_sound(sound);
	audio_play_sound(sound, 0, false);
	
	isOver = true;
}

#endregion

next(page);
