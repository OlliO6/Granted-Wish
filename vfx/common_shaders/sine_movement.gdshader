shader_type canvas_item;

uniform float amp = 2;
uniform float speed = 1.5;
uniform vec2 dir = vec2(0, 1);

void vertex() {
	VERTEX = VERTEX + dir * sin(TIME * speed) * amp;
}
