class_name BloodEffect
extends Node2D

@export var impact_velocity_magnitude: float
@export var impact_velocity_magnitude_scale: float = 1

func _ready() -> void:
	var particles := get_node("GPUParticles2D") as GPUParticles2D
	particles.process_material.set("initial_velocity_min",
		particles.process_material.get("initial_velocity_min") + impact_velocity_magnitude * impact_velocity_magnitude_scale)
	particles.process_material.set("initial_velocity_max",
		particles.process_material.get("initial_velocity_max") + impact_velocity_magnitude * impact_velocity_magnitude_scale)
	particles.restart()