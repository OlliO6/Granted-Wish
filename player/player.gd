extends CharacterBody2D

@export var movement_speed: float

@onready var sm: StateMachine = get_node("StateMachine")
@onready var idle_state: State = get_node("StateMachine/IdleState")
@onready var run_state: State = get_node("StateMachine/RunState")

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:

	var move_input := InputManager.get_movement_input_vector()

	match sm.state:

		idle_state:
			velocity = Vector2.ZERO
			if move_input != Vector2.ZERO:
				sm.switch_state(run_state)
		
		run_state:
			velocity = move_input * movement_speed
			if move_input == Vector2.ZERO:
				sm.switch_state(idle_state)

	move_and_slide()
