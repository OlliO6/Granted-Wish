extends Node2D

@onready var spawn_sprite: Sprite2D = $SpawnSprite
@onready var character_body: CharacterBody2D = $CharacterBody2D
@onready var health: Health = $Health

@onready var state_machine: StateMachine = $StateMachine
@onready var spawning_state: State = $StateMachine/Spawning
@onready var fighting_state: State = $StateMachine/Fighting

func _ready() -> void:
	spawn_sprite.show()

func is_phase_2() -> bool:
	return health.health < health.max_health * 0.5

func _on_spawn_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn":
		spawn_sprite.hide()
		state_machine.switch_state(fighting_state)
