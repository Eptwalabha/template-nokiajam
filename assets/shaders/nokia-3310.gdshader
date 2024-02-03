shader_type canvas_item;

//#define DISABLE_DOOR_EFFECT
//#define DISABLE_PIXEL_GRAIN
//#define DISABLE_PIXEL_SHADOWS

global uniform vec2 screen_resolution;
global uniform vec4 color_palette_dark : source_color;
global uniform vec4 color_palette_light : source_color;

uniform sampler2D screen : hint_default_black, filter_nearest;

group_uniforms Pixel.DoorEffect;
uniform float door_effect : hint_range(0.0001, 1.0) = 0.1;
uniform float door_intensity : hint_range(0.0001, 2.0) = 0.8;

group_uniforms Pixel.Grain;
uniform float grain_amount : hint_range(0.0, 1.0) = 0.07;

group_uniforms Pixel.Shadows;
uniform vec2 shadow_offset = vec2(0.2, 0.2);
uniform float shadow_intensity : hint_range(0.0, 1.0) = 0.2;

// from https://thebookofshaders.com/10/
float random(vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

float pixel_value(vec4 color) {
	return (1.0 - (0.3 * color.r + 0.59 * color.g + 0.11 * color.b)) * color.a;
}

// TODO
// - LCD ghosting
// - blur shadow
void fragment() {
	vec2 uv = fract(vec2(UV.x * screen_resolution.x, UV.y * screen_resolution.y));
	float pixel_mask = step(0.5, pixel_value(texture(screen, UV)));

#ifndef DISABLE_DOOR_EFFECT
	float screen_door = min(
		min(smoothstep(0.0, door_effect, uv.x), smoothstep(1.0, 1.0 - door_effect, uv.x)),
		min(smoothstep(0.0, door_effect, uv.y), smoothstep(1.0, 1.0 - door_effect, uv.y))
	);
	pixel_mask *= pow(screen_door, 1.0 / door_intensity);
#endif

#ifndef DISABLE_PIXEL_SHADOWS
	float pixel_shadow = pixel_value(texture(screen, UV - shadow_offset / screen_resolution));
	float shadow_mask = step(0.5, pixel_shadow) * (1.0 - pixel_mask);
	COLOR = mix(color_palette_light, color_palette_dark, clamp(shadow_mask * shadow_intensity + pixel_mask, 0.0, 1.0));
#else
	COLOR = mix(color_palette_light, color_palette_dark, pixel_mask);
#endif

#ifndef DISABLE_PIXEL_GRAIN
	float screen_grain = grain_amount * random(UV) - grain_amount / 2.0;
	COLOR.rgb += screen_grain;
#endif
}