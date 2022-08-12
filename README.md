# Typewriter (for GameMaker)

Creates an object for every letter seperately to give a "talking" effect.

## How to use: 
1. Get a sprite map of the font you want to use in ascii order. [Why and how](#how-do-i-get-a-sprite-map-of-my-font)
2. Add the font using the `Font` consturctor.
3. Use the `write` script.

### Why not use font files
That would require using the built in `draw_text` function, which would run *waaaaaaaay* slower than creating an object with a sprite.

### How do I get a sprite map of my font?
I struggled with this at first, until i found a program called [BabelMap](https://www.babelstone.co.uk/Software/BabelMap.html), it lets you generate each character as a seperate png file, very useful.