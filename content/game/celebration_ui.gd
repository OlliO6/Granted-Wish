extends Control

func celebrate(text: String) -> void:
	$Label.text = text
	$AnimationPlayer.play("celebrate")
