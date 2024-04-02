extends Sprite2D

var tween: Tween

func flash() -> void:
	if tween and tween.is_valid():
		tween.kill()
	tween = create_tween()
	tween.tween_property(material, "shader_parameter/flash", 0.5, 0.1)
	tween.tween_property(material, "shader_parameter/flash", 0.0, 0.2)
