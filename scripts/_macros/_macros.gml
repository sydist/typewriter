
#macro CMD_START "["
#macro CMD_BREAK "]"
#macro ASCII " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"

global.FNT_8BITOPERATOR_JVE = {
	font: font_add_sprite_ext(spr_8BitoperatorJVE, ASCII, true, 1),
	sprite: spr_8BitoperatorJVE,
};

show_debug_overlay(true);

