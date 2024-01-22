# NokiaJam6

https://itch.io/jam/nokiajam6

Base project for the nokia game jam 6

![Nokia's startup](./assets/doc/nokia-startup.gif)

## Shader

The "NOKIA 3310" effect is archive with the shader located in `./assets/shaders/nokial-3310.gdshader`

![the shader in action](./assets/doc/shader-main.png)

This shader can be customized:
- color palette
- screen-door effect *
- pixel shadow *
- LCD noise level *

*: these can be deactivate

## Change the color palette

The jam only allows three palettes: `ORIGINAL`, `HARSH` and `GREY`. You can set the desired one directly from the `Main` node with the parameter `palette`. You need to reload the scene in order to see the changes.

![all the palettes](./assets/doc/color-palettes.png)

## If you want your game to be in `portrait`

By default, this project is setup in `landscape` (ie: 84x48). If you want to set your game to `portrait` (ie: 48x84), you need to update:
- the shader params `screen_resolution` to `vec2(48.0, 84.0)`
- the project's viewport width and height
- in the main scene, change the size the `SubViewport` node "`Screen`" in the main scene

I'll try to simplify the process in the future

