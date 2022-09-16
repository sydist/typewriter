// unnecessary
show_debug_overlay(true);
surface_depth_disable(true);
gml_release_mode(true);
gml_pragma("PNGCrush");
randomize();

// -------
// example
// -------
write(10, 30, [ "[s1]Hello [r][w1][p60]World!" ], 3, global.FONTS.main, undefined, c_white)
