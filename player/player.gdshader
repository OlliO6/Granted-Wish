shader_type canvas_item;

uniform vec3 magic_color : source_color;
uniform bool invis;
uniform float invis_blink_speed = 10;
uniform vec4 invis_blink_color : source_color = vec4(1, 1, 1, 1);
uniform float flash : hint_range(0.0, 1.0);
uniform vec4 flash_color : source_color = vec4(1, 1, 1, 1);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	if (color == vec4(1,1,1,1)) {
		color = vec4(magic_color, 1);
	}
	float a = color.a;
	color = mix(color, flash_color, flash);
	if (invis) {
		float blink = sin(TIME * invis_blink_speed);
		blink = (blink + 1.0) * 0.5;
		color = mix(color, invis_blink_color, blink);
	}
	color.a = min(color.a, a);
	COLOR = color;
}
