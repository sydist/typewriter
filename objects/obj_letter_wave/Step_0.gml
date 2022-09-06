var _time = current_time / 100;
var _variation = index / 5;

x = (writerX + xOffset) + (wave *  cos(_time + _variation));
y = (writerY + yOffset) + (wave * -sin(_time + _variation));
