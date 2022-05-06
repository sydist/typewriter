
pause = 0;
progress++;

var _char = string_copy(message, progress, 1);
var _charCode = ord(_char);

if (_charCode > 32) {
	if (shake != 0) var _inst = instance_create_depth(x + xOffset, y + yOffset, depth, obj_letter_shake);
	else if (wave != 0) var _inst = instance_create_depth(x + xOffset, y + yOffset, depth, obj_letter_wave);
	else var _inst = instance_create_depth(x + xOffset, y + yOffset, depth, obj_letter_normal);
	
	with(_inst) {
		writerX = other.x;
		writerY = other.y;
		xOffset	= other.xOffset;
		yOffset	= other.yOffset;
		writerId = other.id;
		shake = other.shake;
		wave = other.wave;
		index = other.progress;
		image_angle	= other.charAngle;
		image_xscale = other.xScale;
		image_yscale = other.yScale;
		image_alpha	= other.charOpacity;
		image_blend	= other.color;
		sprite_index = other.sprite;	
		image_index	= string_pos(_char, ASCII) - 1;
	}
	
	if (sound != undefined) audio_play_sound(sound, 0, false);
}

draw_set_font(font);
xOffset += (((string_width(_char) * xScale) * !monoSpace) + (hSep * xScale)) * dcos(angle)
yOffset += (((string_height(_char) * yScale) * !monoSpace) + (vSep * yScale)) * -dsin(angle)

commandCheck();
isOver = (progress >= length);

