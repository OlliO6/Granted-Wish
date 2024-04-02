shader_type canvas_item;

#include "res://vfx/common_shaders/constants.gdshaderinc"

uniform vec4 line_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);//color line
uniform float line_scale : hint_range(0, 20) = 1.0;    // thickness of the line

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() 
{
	vec2 size = GAME_PIXEL_SIZE * line_scale;
	
	float outline = texture(screen_texture, SCREEN_UV + vec2(-size.x, 0)).a;
	outline += texture(screen_texture, SCREEN_UV + vec2(0, size.y)).a;
	outline += texture(screen_texture, SCREEN_UV + vec2(size.x, 0)).a;
	outline += texture(screen_texture, SCREEN_UV + vec2(0, -size.y)).a;
	outline += texture(screen_texture, SCREEN_UV + vec2(size.x, size.y)).a;
	outline += texture(screen_texture, SCREEN_UV + vec2(size.x, -size.y)).a;
	outline += texture(screen_texture, SCREEN_UV + vec2(-size.x, size.y)).a;
	outline += texture(screen_texture, SCREEN_UV + vec2(-size.x, -size.y)).a;
	outline = min(outline, 1.0);
	
	vec4 color = texture(screen_texture, SCREEN_UV);
	
	COLOR = mix(color, line_color, outline - color.a);
}
