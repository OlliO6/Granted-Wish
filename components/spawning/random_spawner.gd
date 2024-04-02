@tool
class_name RandomSpawner
extends Spawner

signal failed_to_spawn

@export_range(0, 1) var chance_to_spawn: float = 0.5

func spawn() -> Node:
	
	if randf() > chance_to_spawn:
		failed_to_spawn.emit()
		return null
	
	return super.spawn()
