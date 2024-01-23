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

## Set your viewport in `portrait` instead of `landscape`

By default, this project is setup in `landscape` (ie: 84x48). If you want to set your game to `portrait` (ie: 48x84), you need to:
- set the main scene's orientation as `PORTRAIT`
- update the project window's width and height accordingly

## How does it works ?

// TODO

## No dithering ?

No, I don't plan to add it to this project.  
But if you need this effect for your game, you can find a simple dithering shader in one my [other project](https://github.com/Eptwalabha/godot-shaders/tree/main/2D/dithering)
