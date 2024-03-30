shader_type canvas_item;

uniform float flash : hint_range(0.0, 1.0);
uniform vec4 flash_color : source_color = vec4(1, 1, 1, 1);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 final_col = mix(color, flash_color, flash);
	final_col.a = min(final_col.a, color.a);
	COLOR = final_col;
}
