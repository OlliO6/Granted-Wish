class_name BloodSpawner
extends Node2D

@export var effect_scn: PackedScene

func spawn(impact_velocity_magnitude: float=0) -> Node2D:

	var effect := effect_scn.instantiate() as Node2D
	if effect is BloodEffect:
		effect.impact_velocity_magnitude = impact_velocity_magnitude
	Globals.get_blood_viewport().add_child(effect)
	effect.transform = global_transform
	return effect

func _on_damage_receiver_damage_taken(_amount: int, dealer: DamageDealer) -> void:
	global_rotation = dealer.global_rotation
	spawn(dealer.impact_velocity_magnitude)
