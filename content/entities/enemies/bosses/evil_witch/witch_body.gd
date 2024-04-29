extends CharacterBody2D

@export var idle_time_range: Vector2
@export_range(0, 1) var attack_tp_ratio: float

@onready var sprite: Sprite2D = $Sprite2D
@onready var fighting_main_state: State = $"../StateMachine/Fighting"
@onready var idle_timer: Timer = $StateMachine/Idle/Timer
@onready var knockback: Knockback = $Knockback
@onready var spells: Node2D = $Spells

@onready var state_machine: StateMachine = $StateMachine
@onready var idle_state: State = $StateMachine/Idle
@onready var attack_state: State = $StateMachine/Attack
@onready var teleporting_state: State = $StateMachine/Teleporting
@onready var knocked_state: State = $StateMachine/Knocked

var player: Player

func _ready() -> void:
	player = Globals.get_player()
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	fighting_main_state.state_entered.connect(_fight_started)

func _physics_process(delta: float) -> void:
	
	if idle_state.is_active():
		sprite.flip_h = player.global_position.x > global_position.x
	
	velocity = Vector2.ZERO
	if !teleporting_state.is_active():
		velocity = knockback.compute_velocity(velocity)
	
	move_and_slide()

func teleport() -> void:
	if owner.is_phase_2():
		var spawner := $Spells/EnemySpawner as Spawner
		spawner.global_rotation = 0
		spawner.spawn()
	teleporting_state.enter()

func attack() -> void:
	spells.global_transform = spells.global_transform.looking_at(player.global_position)
	attack_state.enter()

func _fight_started() -> void:
	show()
	process_mode = Node.PROCESS_MODE_INHERIT

func _on_idle_state_entered() -> void:
	idle_timer.start(UtilFunctions.rand_range(idle_time_range))

func _on_idle_timer_timeout() -> void:
	if randf() > attack_tp_ratio:
		teleport()
	else:
		attack()

func _on_animation_finished(anim_name: StringName) -> void:
	idle_state.enter()

func _tp_to_rand_postion() -> void:
	var positions := Globals.game.get_node("%EnemySpawnPositions")
	var pos := positions.get_child(randi_range(0, positions.get_child_count() - 1)) as Node2D
	global_position = pos.global_position
