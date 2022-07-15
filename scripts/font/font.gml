#macro CMD_START "["
#macro CMD_BREAK "]"
#macro ASCII " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"

function Font(_sprite, _prop, _sep, _charmap = ASCII) constructor {
	font = font_add_sprite_ext(_sprite, _charmap, _prop, _sep);
	sprite = _sprite;
}

global.FONTS = {
	main: new Font(spr_8BitoperatorJVE, true, 1),
};
