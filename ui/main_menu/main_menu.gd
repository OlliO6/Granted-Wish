extends CanvasLayer

@export var game_scn: PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		load_game()

func load_game() -> void:
	get_tree().change_scene_to_packed(game_scn)
