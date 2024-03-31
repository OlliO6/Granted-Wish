shader_type canvas_item;

uniform float amplitude = 1;
uniform float speed = 100;
uniform float amp_sine_speed = 10;
uniform float amplitude_2 = 0;

void vertex() {
	float amp = (sin(TIME * amp_sine_speed) + 1.0) * 0.5;
	amp *= amplitude;
	float offset = sin(TIME * speed) * amp;
	offset += sin(TIME * speed) * amplitude_2;
	VERTEX = VERTEX + vec2(offset, 0);
}
