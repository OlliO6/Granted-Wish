@tool
class_name RandomSpawner
extends Spawner

signal failed_to_spawn

@export_range(0, 1) var chance_to_spawn: float = 1.0
@export var use_spawn_data: bool = true
@export var spawn_data: Array[RandomSpawnData]

func _get_configuration_warnings() -> PackedStringArray:
	if specified_parent.is_empty() and child_of == ChildOfEnum.SpecifiedParent:
		return ["Parent not specified"]
	if spawn_data.size() == 0 and use_spawn_data:
		return ["Set Spawn Data"]
	return []

func spawn() -> Node:
	
	if randf() > chance_to_spawn:
		failed_to_spawn.emit()
		return null
	
	if use_spawn_data:
		scene = _get_random_scene_from_data()
	
	return super.spawn()

func _get_random_scene_from_data() -> PackedScene:
	
	var total_prio := 0
	for data: RandomSpawnData in spawn_data:
		total_prio += data.priority;
	
	var rand_prio := randi_range(0, total_prio)
	var current_prio_idx := 0;

	for data: RandomSpawnData in spawn_data:
		current_prio_idx += data.priority;

		if rand_prio <= current_prio_idx:
			return data.scene;
		
	return scene
