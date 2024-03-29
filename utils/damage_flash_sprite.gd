extends Sprite2D

func flash() -> void:
	var tween := create_tween()
	tween.tween_property(material, "shader_parameter/flash", 0.5, 0.1)
	tween.tween_property(material, "shader_parameter/flash", 0.0, 0.2)