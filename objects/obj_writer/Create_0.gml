#region COMMANDS

commandsQueue = ds_queue_create();
commands = ds_map_create();

commands[? ">"] = function() { // Function
	functions[real(getInput())]();
};
commands[? "p"] = function() { // Pause
	pause = real(getInput());
};
commands[? "a"] = function() { // Angle
	angle = real(getInput());
	nlAngle = angle + 270;
};
commands[? "r"] = function() { // Reset Effects
	effect = "normal";
};
commands[? "s"] = function() { // Shake Effect
	effect = "shake";
	shake = real(getInput());
};
commands[? "w"] = function() { // Wave Effect
	effect = "wave";
	wave = real(getInput());
};
commands[? "t"] = function() { // Speed
	spd = real(getInput());
};
commands[? "c"] = function() { // Color
	var c = real("0x" + getInput());
	return ((c >> 16) & 0xFF) | (c & 0xFF00) | ((c << 16) &  0xFF0000);
};
commands[? "f"] = function() { // Font
	var f = variable_global_get(getInput());
	font = f.font;
	sprite = f.sprite;
};
commands[? "x"] = function() { // Scale
	xscale = real(getInput());
	yscale = real(getInput());
};
commands[? "n"] = function() { // New Line
	var _indent = getInput();
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

function queueCommands() {
	var _count = string_count(CMD_START, message);
	if (_count == 0) exit;
	
	var _index = 0;
	repeat(_count) {
		var _start = string_pos_ext(CMD_START, message, _index);
		if (_start == 0) exit;

		var _cmd = string_copy(message, _start + 1, 1);
		if (_cmd == CMD_START) { 
			message = string_delete(message, _start + 1, 1); 
			_index = _start;
			continue;
		}
		
		if (!ds_map_exists(commands, _cmd)) continue;

		var _length = string_pos_ext(CMD_BREAK, message, _start + 1) - _start + 1;
		var _input = string_copy(message, _start + 2, _length - 3);
		
		ds_queue_enqueue(commandsQueue, [_start, _cmd, _input]);
		
		message = string_delete(message, _start, _length);
	}
}
function commandCheck() {
	if (ds_queue_empty(commandsQueue)) exit;

	head = ds_queue_head(commandsQueue);
	if ((progress + 1) != head[0]) exit;

	commands[? head[1]]();
	ds_queue_dequeue(commandsQueue);

	commandCheck();
}
function getInput() {
	return head[2];	
}
function setPos(_x, _y) {
	x = _x;
	y = _y;
	with(par_letter) {
		writerX = writerId.x;
		writerY = writerId.y;
		x = writerX + xOffset;
		y = writerY + yOffset;	
	}
}
function next() {
	instance_destroy();
	write(x, y, pages, spd, fontstruct, sound, color, [xscale, yscale], [hsep, vsep,], monospace, functions, endfunction, page + 1, depth)
}

#endregion

message = pages[page];

queueCommands();
commandCheck();

isLast = (page >= array_length(pages) - 1);
length = string_length(message);
