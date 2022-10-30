#region COMMANDS

commands_queue = ds_queue_create();
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
	new_line_angle = -dsin(angle);
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
	var _color = real("0x" + _value);
	color = ((_color >> 16) & 0xFF) | (_color & 0xFF00) | ((_color << 16) &  0xFF0000);
};
commands[$ "f"] = function(_value) // Font
{ 
	var _font = variable_global_get(_value);
	font = _font.font;
	sprite = _font.sprite;
};
commands[$ "x"] = function(_value) // Scale
{ 
	xscale = real(_value);
	yscale = real(_value);
};
commands[$ "n"] = function(_value) // New Line
{ 
	var _indent = _value;
	var _indent_length = string_length(_indent);
	
	var _horizontal_seperation = hsep * xscale;
	var _vertical_seperation = vsep * yscale;
	
	var _cos_new_line_angle = dcos(new_line_angle);
	var _sin_new_line_angle = dsin(new_line_angle);
	
	var _cos_angle = dcos(angle);
	var _sin_angle = dsin(angle);
	
	var _x_scale_mono = xscale * !monospace;
	var _y_scale_mono = yscale * !monospace;
	
	x_offset = ((x_offset + (string_width("0")  * _x_scale_mono) + _horizontal_seperation) * _cos_new_line_angle) + (((string_width(_indent) * _x_scale_mono) + (_indent_length * _horizontal_seperation)) * _cos_angle);
	y_offset = ((y_offset + (string_height("0") * _y_scale_mono) + _vertical_seperation) * -_sin_new_line_angle) + (((string_height(_indent) * _indent_length * _y_scale_mono) + (_indent_length * _vertical_seperation)) * -_sin_angle);
};

#endregion

#region FUNCTIONS

function queue_commands() 
{
	var _count = string_count(CMD_START, paragraph);
	var _start_position = 0;
	
	var _i = 0;
	while(_i < _count)
	{
		var _command_start = string_pos_ext(CMD_START, paragraph, _start_position);
		var _command = string_copy(paragraph, _command_start + 1, 1);
		_start_position = _command_start - 1;
		
		_i++;
		if (!variable_struct_exists(commands, _command))
		{
			if (_command == CMD_START)
			{
				paragraph = string_delete(paragraph, _command_start, 1);
				_i++;
			}
			_start_position++
			continue;
		}
		
		var _length = string_pos_ext(CMD_BREAK, paragraph, _command_start + 1) - _command_start + 1;
		var _input = string_copy(paragraph, _command_start + 2, _length - 3);
		
		ds_queue_enqueue(commands_queue, { pos: _command_start, name: _command, value: _input });
		
		paragraph = string_delete(paragraph, _command_start, _length);
	}
}
function command_check() 
{
	while (true)
	{
		if (ds_queue_empty(commands_queue)) 
			return;
		
		head = ds_queue_head(commands_queue);
		if ((progress + 1) != head.pos) 
			return;
		
		commands[$ head.name](head.value);
		ds_queue_dequeue(commands_queue);	
	}
}
function set_position(_x, _y) 
{
	x = _x;
	y = _y;
	with(obj_letter) {
		writer_x = writer_id.x;
		writer_y = writer_id.y;
		x = writer_x + x_offset;
		y = writer_y + y_offset;	
	}
}
function next_page(_page) 
{
	with(obj_letter)
		if (writer_id == other.id)
			instance_destroy();
	
	var _is_last = (_page == array_length(book));
	if (_is_last)
	{
		instance_destroy();
		exit;
	}
	
	is_over = false;
	progress = 0;
	x_offset = 0;
	y_offset = 0;

	ds_queue_clear(commands_queue);
	
	paragraph = book[_page];

	queue_commands();
	command_check();
	
	length = string_length(paragraph);

	if (!pause)
		event_perform(ev_alarm, 0);
	else 
		alarm_set(0, pause);
}
function skip() 
{
	pause = 0;
	alarm_set(0, -1);
	
	repeat(length - progress) 
		event_perform(ev_alarm, 0);
		
	audio_stop_sound(sound);
	audio_play_sound(sound, 0, false);
	
	is_over = true;
}

#endregion

next_page(page);
