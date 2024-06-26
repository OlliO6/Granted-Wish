shader_type canvas_item;
render_mode unshaded;

#include "res://vfx/common_shaders/constants.gdshaderinc"

uniform vec4 line_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);//color line
uniform float line_scale : hint_range(0, 20) = 1.0;    // thickness of the line

uniform sampler2D screen_texture : hint_screen_texture;

vec4 get_downscaled_color(sampler2D tex, vec2 uv) {
	vec2 size = GAME_WINDOW_SIZE;
	vec2 px = ceil(uv*size);
	return texture(tex, (px) / size);
}

void fragment() 
{
	vec2 size = GAME_PIXEL_SIZE * line_scale;
	
	float outline = get_downscaled_color(screen_texture, SCREEN_UV + vec2(-size.x, 0)).a;
	outline += get_downscaled_color(screen_texture, SCREEN_UV + vec2(0, size.y)).a;
	outline += get_downscaled_color(screen_texture, SCREEN_UV + vec2(size.x, 0)).a;
	outline += get_downscaled_color(screen_texture, SCREEN_UV + vec2(0, -size.y)).a;
	outline = min(outline, 1.0);
	
	vec4 color = get_downscaled_color(screen_texture, SCREEN_UV);
	
	if (color.a > 0.0001) {
	    color.rgb /= color.a;
	}
	
	COLOR = mix(color, line_color, outline - color.a);
}

