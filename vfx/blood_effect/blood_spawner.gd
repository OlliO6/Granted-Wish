class_name BloodSpawner
extends Node2D

@export var effect_scn: PackedScene

func spawn() -> void:
	var effect := effect_scn.instantiate() as Node2D
	Globals.get_blood_viewport().add_child(effect)
	effect.transform = global_transform
