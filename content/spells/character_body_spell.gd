extends CharacterBody2D

@export var speed: float

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(transform.x * delta * speed)
	if collision:
		queue_free()