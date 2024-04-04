extends CharacterBody2D

@export var speed: float

@onready var knockback: Knockback = $Knockback
@onready var sm: StateMachine = $StateMachine
@onready var idle_state: State = $StateMachine/IdleState
@onready var dead_state: State = $StateMachine/DeadState

var rush_dir: Vector2

func _physics_process(_delta: float) -> void:
	if sm.state:
		print(sm.state.name)
	
	match sm.state:
		idle_state:
			var player := Globals.game.get_player() as Player
			rush_dir = (player.global_position - global_position).normalized()
			velocity = rush_dir * speed
		
		dead_state:
			velocity = Vector2.ZERO
	
	velocity = knockback.compute_velocity(velocity)
	
	move_and_slide()

func _on_rush_state_entered() -> void:
	var player := Globals.game.get_player() as Player
	rush_dir = (player.global_position - global_position).normalized()

func _on_idle_state_entered() -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn":
		idle_state.enter()
