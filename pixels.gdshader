shader_type canvas_item;

uniform sampler2D screen : hint_default_black, filter_nearest;
uniform vec2 screen_size = vec2(84.0, 48.0);
uniform vec4 color_white : source_color = vec4(0.78, 0.941, 0.847, 1.0); // #9bc700;
uniform vec4 color_black : source_color = vec4(0.263, 0.322, 0.239, 1.0); // #2b3f09;
uniform float door_effect : hint_range(0.0, 1.0) = 0.1;
uniform float door_intensity : hint_range(0.0, 2.0) = 0.1;
uniform float noise_amount : hint_range(0.0, 1.0) = 0.07;

uniform vec2 shadow_offset = vec2(0.25, 0.25);
uniform float shadow_intesity : hint_range(0.0, 1.0);

// from https://thebookofshaders.com/10/
float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// TODO
// - LCD ghosting
void fragment() {
	vec2 uv = fract(vec2(UV.x * screen_size.x, UV.y * screen_size.y));
	vec2 pix = texture(screen, UV).ar;
	vec2 pix_shadow = texture(screen, UV - shadow_offset / screen_size).ar;
	float lit = smoothstep(0.5, 0.5, pix.x * (1.0 -pix.y));
	float screen_door = min(
		min(smoothstep(0.0, door_effect, uv.x), smoothstep(1.0, 1.0 - door_effect, uv.x)),
		min(smoothstep(0.0, door_effect, uv.y), smoothstep(1.0, 1.0 - door_effect, uv.y))
	);
	lit = lit * screen_door;
	screen_door = pow(screen_door, door_intensity);
	float lit_shadow = smoothstep(0.5, 0.5, pix_shadow.x * (1.0 -pix_shadow.y)) * (1.0 - lit);
	float noise = noise_amount * random(UV) - noise_amount / 2.0;
	COLOR = mix(color_white, color_black, lit + lit_shadow * shadow_intesity) + noise;
}
