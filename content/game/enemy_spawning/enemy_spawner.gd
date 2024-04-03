@tool
class_name EnemySpawner
extends RandomSpawner

signal started_spawning
signal spawning_ended
signal enemy_died(enemy: Node2D)

@export var enemy_count_range := Vector2i.ONE
@export var spawn_delay_range := Vector2(1, 2)
@export_range(16, 100) var min_player_dist: float = 46

@onready var spawn_positions_parent = get_node("%EnemySpawnPositions")

var _target_enemy_count: int
var _enemies_spawned: int
var _enemies_died: int
var _spawning: bool
var _timer: Timer

func _ready() -> void:
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_timer.timeout.connect(_on_timeout)
	started_spawning.emit()

func start_spawning() -> void:
	_spawning = true
	_enemies_spawned = 0
	_target_enemy_count = UtilFunctions.rand_range_i(enemy_count_range)
	_timer.start()

func is_spawning() -> bool:
	return _spawning

func spawn() -> Node:
	var position_nodes: Array[Node2D]
	position_nodes.assign(spawn_positions_parent.get_children())
	position_nodes.shuffle()
	
	for pos in position_nodes:
		var player := Globals.get_player() as Player
		if !_in_player_dist(pos.global_position):
			global_transform = pos.global_transform
			break
	
	var enemy := super.spawn()
	if !enemy:
		return
	
	var killable_component = Components.get_killable(enemy)
	assert(killable_component, "Enemies need to be Killable. '" + enemy.name + "' is not Killable.")
	killable_component.death_confirmed.connect(func(): enemy_died.emit(enemy))
	return enemy

func _in_player_dist(pos: Vector2) -> bool:
	var player := Globals.get_player() as Player
	return player.global_position.distance_to(pos) < min_player_dist

func _start_timer() -> void:
	_timer.start(UtilFunctions.rand_range(spawn_delay_range))

func _on_timeout() -> void:
	spawn()
	_enemies_spawned += 1
	if _enemies_spawned < _target_enemy_count:
		_start_timer()
	else:
		spawning_ended.emit()
