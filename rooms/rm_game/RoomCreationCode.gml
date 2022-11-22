// Opts & Debug
surface_depth_disable(true);
gpu_set_blendenable(false);
gpu_set_zwriteenable(false);
gpu_set_cullmode(cull_counterclockwise);
gml_release_mode(true);
gml_pragma("PNGCrush");

randomize();
show_debug_overlay(true);



// -------
// example
// -------
texts = [ "[x2]L[r][x1]orem ipsum dolor sit amet,[n00][p30][s1]consectetur adipiscing elit.[r][p60][n][w1]Ut ut nisl nibh.[p60]  Nunc auctor ipsum ex,[p30][n][r][cff0000][t15]non [t3][cffffff]condimentum nunc rutrum et.[p60][n]Aliquam moll-  [>0]" ];
write(
	10, 30, 
	texts, 3, 
	global.fonts.main, 
	snd_voice_default, 
	c_white, 
	[1, 1], 
	[0, 0], false, 
	[game_end]
);
