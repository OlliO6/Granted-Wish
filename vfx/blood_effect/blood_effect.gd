class_name BloodEffect
extends GPUParticles2D

@export var impact_velocity_magnitude: float
@export var impact_velocity_magnitude_scale: float = 1

func _ready() -> void:

	finished.connect(queue_free)
	process_material.set("initial_velocity_min",
		process_material.get("initial_velocity_min") + impact_velocity_magnitude * impact_velocity_magnitude_scale)
	process_material.set("initial_velocity_max",
		process_material.get("initial_velocity_max") + impact_velocity_magnitude * impact_velocity_magnitude_scale)
	restart()
