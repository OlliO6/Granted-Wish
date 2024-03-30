shader_type canvas_item;

uniform float min_a : hint_range(0.0, 1.0);
uniform vec4 spec_intensity: source_color = vec4(1000.0,1000.0,1000.0,1000.0);

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	vec4 color = tex_color;
	color.a = color.a * step(min_a, color.a);
	vec4 tex_color_up = texture(TEXTURE, UV + vec2(0, -1));
	COLOR = color;
}
