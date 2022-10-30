var _time = current_time / 100;
var _variation = index / 5;

x = (writer_x + x_offset) + (wave *  cos(_time + _variation));
y = (writer_y + y_offset) + (wave * -sin(_time + _variation));
