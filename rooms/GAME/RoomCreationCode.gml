// unnecessary
show_debug_overlay(true);
surface_depth_disable(true);
gml_release_mode(true);
gml_pragma("PNGCrush");
randomize();

// -------
// example
// -------
write(10, 30, [ "[s1]Hello [w1][p60][n]World!", "[w1]AMONG US...[p60][n][r]is [s2][x2][cff0000]FOR REAL!" ], 3, global.FONTS.main, v_default, c_white, [1, 1], [0, 0], false, [], function() {
	game_end();
})
