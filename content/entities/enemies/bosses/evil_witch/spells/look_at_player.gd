extends Node2D

@onready var player: Player = Globals.get_player()

func _physics_process(delta: float) -> void:
	global_transform = global_transform.looking_at(player.global_position)
