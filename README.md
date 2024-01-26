# NokiaJam6

https://itch.io/jam/nokiajam6

Starter for the nokia game jam 6 made for Godot 4.2

This is best suited for a 2D game.

# How to use it ?

This project is set to run `main.tscn` on startup. The `Main` scene's structure is as followed:
<p style="text-align:center;">
    <img alt="the main scene tree" src="./assets/doc/main-scene-tree.png" />
</p>

The idea is to create your game in a scene like you would normally do.
Instead of running it directly, you simply set it as a child of the `Screen` node.

You only have to focus on your game and nothing else.

I provided a simple example with the Nokia's animated splash-screen.

<p style="text-align:center;">
    <img alt="Nokia's startup" src="./assets/doc/nokia-startup.gif" />
</p>

## How does it work ?

`Scene` is a `Subviewport` where your game will be rendered. This viewport's resolution is set as 84x48 (or 48x84) pixels.

`NokiaShader` is a `ColorRect` with a shader material that will take the rendered image of `Scene` and apply a filter to make it look like a Nokia 3310's screen.

# Customizing the project

## Change the color palette

This jam only allows three palettes: `ORIGINAL`, `HARSH` and `GREY`. You can set the desired one directly from the `Main` node with the parameter `palette`.

<p style="text-align:center;">
    <img src="./assets/doc/color-palettes.png" alt="all the palettes" width="100%"/>
</p>

> You need to reload the scene to see the changes.

## Set your viewport in `portrait` instead of `landscape`

By default, this project is setup in `landscape` (ie: 84x48). If you want to set your game to `portrait` (ie: 48x84), you need to:
- set the main scene's orientation as `PORTRAIT`
- update the project window's width and height accordingly

> Nokia's pixels are not square but rather rectangular. Their aspect ratio is 3:4 meaning they are taller than they are wide in landscape mode. Therefore, please ensure that the aspect ratio of the `NokiaShader` remains the same. Keep this in mind if you set your game to portrait.

## Change the resolution of your game window

Because the SubViewport `Screen` will be rendered directly in `NokiaShader`. You can set the resolution directly in your project's settings.

> 💡: You can resize the `NokiaShader` however you like. For example: you can scale it down and place a background image of a nokia 3310 behind it.

## No dithering ?

No, I don't plan to add it to this project.  
But if you need this effect for your game, you can find a complete ordered dithering shader in one my [other repo](https://github.com/Eptwalabha/godot-shaders/tree/main/2D/dithering)

## The `Nokia 3310` shader

The "NOKIA 3310" effect is archived with the shader located in `./assets/shaders/nokial-3310.gdshader`

<p style="text-align:center;">
    <img alt="the shader in action" src="./assets/doc/shader-main.png" />
</p>

### Color palette

The shader will render any pixel "lit" with the color set in `Color White` and all other pixels with the color set in `Color Black`.

A pixel is considered "lit" when:
- its alpha value is not zero
- its grayscale color is over 0.5

> 💡: The grayscale value of a color is: `Red * 0.3 + Green * 0.59 + Blue * 0.11`

### LCD "screen-door" effect

This replicate the gap between pixels:
- `Door Effect`: the gap between pixels (`0`: no gap, `1`: big gap)
- `Door Intensity`: feathered the pixels (`0`: hard edge, `1`: soft edge)

### Pixel shadow

When lit, LCD pixel cast tiny shadows below.
- `Shadow Offset`: the offset of the shadow (eg: `Vector(-0.2, 0.3)` means that the shadow will be on the bottom right of the pixel)
- `Shadow Intensity`: `0`: no shadow, `1`: shadow as dark as a "lit" pixel

### LCD grain

The grainy effect of LCD screen.
- `Grain Amount` to increase/decrease the effect (`0`: no effect, `1.0`: full effect)

> ⚠️ This effect could be a rule-breaker: This add a tiny amount of noise to the pixel, thus not complying 100% with the "fixed palette" rule. I'll check with the host of the jam to see if this is allowed.

# Credits

The font [nokia.ttf](./assets/fonts/nokia/nokia.ttf) was made by [Zeh Fernando](https://portfolio.zehfernando.com/) and is available on [dafont.com](https://www.dafont.com/nokia-cellphone.font) for free.  
If you use this font in your project please credit its author.

All the other assets, including the font [lowrez.png](./assets/fonts/lowrez/lowrez.png) and the images, were created/recreated by me. You are free to use them in any way you like without crediting me, but if you choose to do so… thanks ;)
