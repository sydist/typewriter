/// @desc Next Letter

pause = 0;
progress++;

var _char = string_copy(paragraph, progress, 1);
if (ord(_char) > 32) 
{
	instance_create_depth(x + x_offset, y + y_offset, depth, asset_get_index("obj_letter_" + effect), 
	{
		writer_x: other.x,
		writer_y: other.y,
		x_offset: other.x_offset,
		y_offset: other.y_offset,
		writer_id: other.id,
		shake: other.shake,
		wave: other.wave,
		index: other.progress,
		image_angle: other.character_angle,
		image_xscale: other.xscale,
		image_yscale: other.yscale,
		image_alpha: other.character_opacity,
		image_blend: other.color,
		sprite_index: other.sprite,
		image_index: string_pos(_char, ASCII) - 1,	
	});
	
	
	audio_play_sound(sound, 0, false);
}

draw_set_font(font);
var _char_width = string_width(_char) * xscale * !monospace;
var _char_height = string_height(_char) * yscale * !monospace;

x_offset += (_char_width + (hsep * xscale)) * dcos(angle);
y_offset += (_char_height + (vsep * yscale)) * -dsin(angle);

command_check();

is_over = (progress >= length);
alarm[0] = (spd + pause) * !is_over;
