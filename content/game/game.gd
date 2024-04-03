class_name Game
extends Node2D

@export var blood_viewport: SubViewport

var celebrated_waves_cleared: int

func _init() -> void:
	Globals.game = self

func _ready() -> void:
	randomize()
	clear_blood()
	get_node("BloodLayer").show()

func get_player() -> Player:
	return get_node("%Player")

func get_camera() -> GameCamera:
	return get_node("%Camera")

func clear_blood() -> void:
	blood_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE

func _on_enemy_spawning_celebrated_wave_cleared() -> void:
	celebrated_waves_cleared += 1
