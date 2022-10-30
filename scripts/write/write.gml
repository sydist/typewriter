/// @param {real} x
/// @param {real} y
/// @param {Array<String>} strings 
/// @param {real} speed
/// @param {struct.font} font_struct
/// @param {asset.GMSound} voice
/// @param {real} [color]=0xffffff
/// @param {array<real>} [scale]=[1, 1]
/// @param {array<real>} [seperation]=[0, 0]
/// @param {bool} [monospace]=false
/// @param {array<function>} [functions]=[] 
/// @param {function} [end_function]=function(){}
/// @param {real} [page]=0
/// @returns {Id.Instance}
function write(x, y, strings, speed, font_struct, voice, color = 0xffffff, scale = [1, 1], seperation = [0, 0], monospace = false, functions = [], end_function = function(){}, page = 0) 
{
	return instance_create_depth(x, y, depth, obj_writer, 
	{
		book: strings,
		page: page,
		spd: speed,
		
		xscale: scale[0],
		yscale: scale[1],
		monospace: monospace,
		hsep: seperation[0],
		vsep: seperation[1],
		
		sound: voice ?? snd_nothing,
		font: font_struct.font,
		sprite: font_struct.sprite,
		color: color,
		
		functions: functions,
		endfunction: end_function,
	});
}

#macro CMD_START "["
#macro CMD_BREAK "]"
#macro ASCII " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"

/// @param {asset.GMSprite} sprite_map
/// @param {bool} proportional
/// @param {real} seperation
/// @param {string} [character_map]
function Font(sprite_map, proportional, seperation, character_map = ASCII) constructor 
{
	font = font_add_sprite_ext(sprite_map, character_map, proportional, seperation);
	sprite = sprite_map;
}

global.fonts = 
{
	main: new Font(spr_8bitoperator_jve, true, 1),
};

