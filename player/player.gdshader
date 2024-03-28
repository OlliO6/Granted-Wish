shader_type canvas_item;

uniform vec3 magic_color : source_color;


void fragment() {
	vec4 color = texture(TEXTURE, UV);
	if (color == vec4(1,1,1,1)) {
		color = vec4(magic_color, 1);
	}
	COLOR = color;
}
