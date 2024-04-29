extends Control

func celebrate(text: String) -> void:
	$Label.text = text
	$AnimationPlayer.play("celebrate")
	
	if text == "finish":
		($AnimationPlayer as AnimationPlayer).animation_finished.connect(func(_a) -> void:
			get_tree().change_scene_to_file.call_deferred("res://ui/main_menu/main_menu.tscn"))
