shader_type canvas_item;

uniform float flash : hint_range(0.0, 1.0);
uniform vec4 flash_color : source_color = vec4(1, 1, 1, 1);
uniform float teleport;
uniform vec4 teleport_color : source_color;

float tp_uv_x_offset(vec2 uv, float size) {
	
	float uv_y =  round(uv.y / size) * size;
	
	float rand = fract(sin(dot(vec2(uv_y),
		vec2(12.9898,78.233))) * 43758.5453123);
	
	rand = rand * 2.0 - 1.0;
	
	return rand;
}

void fragment() {
	vec2 uv = UV;
	uv.x += tp_uv_x_offset(UV, TEXTURE_PIXEL_SIZE.y) * teleport;
	vec4 color = texture(TEXTURE, uv);
	vec4 final_col = mix(color, flash_color, flash);
	final_col = mix(final_col, teleport_color, smoothstep(0.0, 0.2, teleport));
	final_col.a = min(final_col.a, color.a);
	COLOR = final_col;
}
