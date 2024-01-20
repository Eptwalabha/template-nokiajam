shader_type canvas_item;

uniform sampler2D screen : hint_default_black, filter_nearest;
uniform vec4 color_white : source_color = vec4(0.78, 0.941, 0.847, 1.0); // #9bc700;
uniform vec4 color_black : source_color = vec4(0.263, 0.322, 0.239, 1.0); // #2b3f09;
uniform float gap_width : hint_range(0.0, 1.0) = 0.1;
uniform float noise_amount : hint_range(0.0, 1.0) = 0.07;

// from https://thebookofshaders.com/10/
float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// TODO
// - LCD ghosting
// - pixel shadow
void fragment() {
	vec2 uv = fract(vec2(UV.x * 84.0, UV.y * 48.0));
	vec2 pix = texture(screen, UV).ar;
	float lit = smoothstep(0.5, 0.5, pix.x * (1.0 -pix.y));
	float grid = min(smoothstep(0.0, gap_width, uv.x),  smoothstep(0.0, gap_width, uv.y));
	//float grid = 1.0 - max(smoothstep(gap_width, gap_width, uv.x), smoothstep(gap_width, gap_width, uv.y));
	float noise = noise_amount * random(UV) - noise_amount / 2.0;
	//COLOR = mix(color_white, color_black, clamp(lit - grid, 0.0, 1.0)) + noise;
	COLOR = mix(color_white, color_black, lit * grid) + noise;
	//COLOR = texture(screen, UV);
}
