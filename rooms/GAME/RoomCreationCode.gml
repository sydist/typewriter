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
write(10, 30, [ "[s1]Hello [w1][p60][n]World!", "[w1]THE ONE PIEEECE...[p60][n][s1]THE ONE PIECE IS [s2][x2][cff0000]REAL!" ], 3, global.FONTS.main, v_default, c_white, [1, 1], [0, 0], false, [], function() {
	game_end();
});
