extends Node2D

func load_menu() -> void:
	get_tree().change_scene_to_packed(preload ("res://ui/main_menu/main_menu.tscn"))
