class_name Game
extends Node2D

@export var blood_viewport: SubViewport

func _init() -> void:
	Globals.game = self

func _ready() -> void:
	clear_blood()

func get_player() -> Player:
	return get_node("%Player")

func clear_blood() -> void:
	blood_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
