shader_type canvas_item;

uniform sampler2D screen : hint_default_black, filter_nearest;
uniform vec2 screen_resolution = vec2(84.0, 48.0);
uniform vec4 color_white : source_color = vec4(0.78, 0.941, 0.847, 1.0); // #c7f0d8;
uniform vec4 color_black : source_color = vec4(0.263, 0.322, 0.239, 1.0); // #43523d;
uniform float door_effect : hint_range(0.0, 1.0) = 0.1;
uniform float door_intensity : hint_range(0.001, 2.0) = 0.8;
uniform float noise_amount : hint_range(0.0, 1.0) = 0.07;

uniform vec2 shadow_offset = vec2(0.2, 0.2);
uniform float shadow_intesity : hint_range(0.0, 1.0) = 0.2;

// from https://thebookofshaders.com/10/
float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// TODO
// - LCD ghosting
void fragment() {
	vec2 uv = fract(vec2(UV.x * screen_resolution.x, UV.y * screen_resolution.y));
	vec2 pixel = texture(screen, UV).ar;
	vec2 pix_shadow = texture(screen, UV - shadow_offset / screen_resolution).ar;
	float pixel_mask = smoothstep(0.5, 0.5, pixel.x * (1.0 -pixel.y));
	float screen_door = min(
		min(smoothstep(0.0, door_effect, uv.x), smoothstep(1.0, 1.0 - door_effect, uv.x)),
		min(smoothstep(0.0, door_effect, uv.y), smoothstep(1.0, 1.0 - door_effect, uv.y))
	);
	pixel_mask *= pow(screen_door, 1.0 / door_intensity);
	float shadow_mask = smoothstep(0.5, 0.5, pix_shadow.x * (1.0 -pix_shadow.y)) * (1.0 - pixel_mask);
	float noise = noise_amount * random(UV) - noise_amount / 2.0;
	COLOR = mix(color_white, color_black, pixel_mask + shadow_mask * shadow_intesity) + noise;
}
