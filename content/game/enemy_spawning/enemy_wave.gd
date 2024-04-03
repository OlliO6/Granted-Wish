class_name EnemyWave
extends Node2D

signal wave_started
signal wave_cleared

@export var celebrated: bool = true

var enemies_alive: int

var _enemy_spawners := [] as Array[EnemySpawner]

func _ready() -> void:
	
	for child in get_children():
		if child is EnemySpawner:
			_enemy_spawners.append(child)
			child.spawned.connect(_enemy_spawned)
			child.enemy_died.connect(_on_enemy_died)

func start_wave() -> void:
	
	for s in _enemy_spawners:
		s.start_spawning()
	wave_started.emit()

func _enemy_spawned(_enemy: Node) -> void:
	enemies_alive += 1

func _on_enemy_died(_enemy: Node2D) -> void:
	
	enemies_alive -= 1
	
	# clear wave only if nothing will be spawned
	if enemies_alive <= 0 and !_enemy_spawners.any(func(s): s.is_spawning()):
		wave_cleared.emit()
