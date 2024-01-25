# NokiaJam6

https://itch.io/jam/nokiajam6

Base project for the nokia game jam 6


## How does it works ?

The main scene's tree:

<p style="text-align:center;">
    <img alt="the main scene tree" src="./assets/doc/main-scene-tree.png" />
</p>

- `Scene` (type: `Subviewport`) is the 84x48 (or 48x84) viewport where your game scene must be a child of.
- `ColorRect` is the node that will display the content of `Scene` and run the `nokia` shader.

I provided an example of scene with the Nokia's animated splash-screen.

<p style="text-align:center;">
    <img alt="Nokia's startup" src="./assets/doc/nokia-startup.gif" />
</p>

## The `Nokia 3310` shader

The "NOKIA 3310" effect is archive with the shader located in `./assets/shaders/nokial-3310.gdshader`

<p style="text-align:center;">
    <img alt="the shader in action" src="./assets/doc/shader-main.png" />
</p>

This shader can be customized:
- color palette
- screen-door effect *
- pixel shadow *
- LCD noise level *

\* can be deactivate

## Change the color palette

The jam only allows three palettes: `ORIGINAL`, `HARSH` and `GREY`. You can set the desired one directly from the `Main` node with the parameter `palette`. You need to reload the scene in order to see the changes.

<p style="text-align:center;">
    <img src="./assets/doc/color-palettes.png" alt="all the palettes" width="100%"/>
</p>

## Set your viewport in `portrait` instead of `landscape`

By default, this project is setup in `landscape` (ie: 84x48). If you want to set your game to `portrait` (ie: 48x84), you need to:
- set the main scene's orientation as `PORTRAIT`
- update the project window's width and height accordingly

## No dithering ?

No, I don't plan to add it to this project.  
But if you need this effect for your game, you can find a simple dithering shader in one my [other project](https://github.com/Eptwalabha/godot-shaders/tree/main/2D/dithering)
