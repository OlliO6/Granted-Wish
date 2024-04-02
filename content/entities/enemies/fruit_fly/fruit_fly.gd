extends CharacterBody2D

@export var idle_time_range: Vector2
@export var animated_rush_speed: float

@onready var knockback: Knockback = $Knockback
@onready var sm: StateMachine = $StateMachine
@onready var idle_state: State = $StateMachine/IdleState
@onready var rush_state: State = $StateMachine/RushState
@onready var dead_state: State = $StateMachine/DeadState

var rush_dir: Vector2

func _physics_process(_delta: float) -> void:
	
	match sm.state:
		idle_state:
			velocity = Vector2.ZERO
		
		rush_state:
			velocity = rush_dir * animated_rush_speed
		
		dead_state:
			velocity = Vector2.ZERO
	
	velocity = knockback.compute_velocity(velocity)
	
	move_and_slide()

func _on_rush_state_entered() -> void:
	var player := Globals.game.get_player() as Player
	rush_dir = (player.global_position - global_position).normalized()

func _on_idle_state_entered() -> void:
	$StateMachine/IdleState/Timer.start(UtilFunctions.rand_range(idle_time_range))


func _on_knockback_knockback_started() -> void:
	pass # Replace with function body.
