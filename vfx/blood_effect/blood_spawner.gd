class_name BloodSpawner
extends Node2D

@export var effect_scn: PackedScene

func spawn() -> void:
	var effect := effect_scn.instantiate() as Node2D
	Globals.get_blood_viewport().add_child(effect)
	effect.transform = global_transform

func _on_damage_receiver_damage_taken(_amount: int, dealer: DamageDealer) -> void:
	global_rotation = dealer.global_rotation
