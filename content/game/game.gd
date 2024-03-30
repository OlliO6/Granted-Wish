class_name Game
extends Node2D

@export var blood_viewport: SubViewport

func _ready() -> void:
	Globals.game = self
	clear_blood()

func clear_blood() -> void:
	blood_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
