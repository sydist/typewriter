
#region INIT

pages = []
page = 0;
message = "";
length = 0;
spd = 3;
progress = 0;
sound = v_default;
font = global.FNT_8BITOPERATOR_JVE.font;
sprite = global.FNT_8BITOPERATOR_JVE.sprite;
isOver = false;

monoSpace = false;
xOffset = 0;
yOffset = 0;
hSep = 0;
vSep = 0;
angle = 0;
nlAngle = 270;
pause = 0;
functions = [];
endFunction = function(){};
canSkip = true;
canContinue = true;

xScale = 1;
yScale = 1;
charOpacity = 1;
shake = 0;
wave = 0;
charAngle = 0;
color = #ffffff

commandsQueue = ds_queue_create();
commands = ds_map_create();

#endregion

#region COMMANDS

var c = commands;

ds_map_set(c, "!", function() { functions[real(getInput())]()});

ds_map_set(c, "g", function() { nlAngle= real(getInput())});

ds_map_set(c, "p", function() { pause = real(getInput())});

ds_map_set(c, "a", function() { angle = real(getInput())});

ds_map_set(c, "s", function() { shake = real(getInput())});

ds_map_set(c, "w", function() { wave = real(getInput())});

ds_map_set(c, "t", function() { spd = real(getInput())});

ds_map_set(c, "c", function() { color = bgr(real("0x" + getInput())) });


ds_map_set(c, "f", function() { 
	var f = variable_global_get(getInput())
	font = f.font;
	sprite = f.sprite;
});

ds_map_set(c, "x", function() { 
	xScale = real(getInput())
	yScale = real(getInput())
});

ds_map_set(c, "n", function() {
	var _indent = getInput();
	var _indentLength = string_length(_indent);
	
	var _hsep = hSep * xScale;
	var _vsep = vSep * yScale;
	
	var _cosNlAngle = dcos(nlAngle);
	var _sinNlAngle = dsin(nlAngle);
	
	var _cosAngle = dcos(angle);
	var _sinAngle = dsin(angle);
	
	var _xScaleMono = xScale * !monoSpace;
	var _yScaleMono = yScale * !monoSpace;
	
	xOffset = ((xOffset + (string_width("0")  * _xScaleMono) + _hsep) * _cosNlAngle) + (((string_width(_indent) * _xScaleMono) + (_indentLength * _hsep)) * _cosAngle);
	yOffset = ((yOffset + (string_height("0") * _yScaleMono) + _vsep) * -_sinNlAngle) + (((string_height(_indent) * _indentLength * _yScaleMono) + (_indentLength * _vsep)) * -_sinAngle);
});

#endregion

#region FUNCTIONS

function queueCommands() {
	var _count = string_count(CMD_START, message);
	if (_count == 0) exit;
	
	var _index = 0;
	repeat(_count) {
		var _start = string_pos_ext(CMD_START, message, _index);

		var _cmd = string_copy(message, _start + 1, 1);
		if (_cmd == CMD_START) { 
			message = string_delete(message, _start + 1, 1); 
			length--; 
			_index = _start;
			continue;
		}
		
		if (!ds_map_exists(commands, _cmd)) continue;

		var _length = string_pos_ext(CMD_BREAK, message, _start + 1) - _start + 1;
		var _input = string_copy(message, _start + 2, _length - 3);
		
		ds_queue_enqueue(commandsQueue, [_start, _cmd, _input]);
		
		message = string_delete(message, _start, _length);
		length -= _length;
	}
}

function commandCheck() {
	if (ds_queue_empty(commandsQueue)) exit;

	var _head = ds_queue_head(commandsQueue);
	if ((progress + 1) != _head[0]) exit;
	
	commands[? _head[1]]();
	ds_queue_dequeue(commandsQueue);
	
	commandCheck();
}

function getInput() {
	return ds_queue_head(commandsQueue)[2];	
}

function bgr(c) {
    return ((c >> 16) & 0xFF) | (c & 0xFF00) | ((c << 16) &  0xFF0000);
}

#endregion

