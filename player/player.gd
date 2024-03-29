extends CharacterBody2D

@export var movement_speed: float

@onready var anim_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var sm: StateMachine = get_node("StateMachine")
@onready var idle_state: State = get_node("StateMachine/IdleState")
@onready var run_state: State = get_node("StateMachine/RunState")

func _physics_process(_delta: float) -> void:

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

func _on_selected_spell_changed(spell: SpellData) -> void:
	var spell_color: Color
	if spell:
		spell_color = spell.color
	else:
		spell_color = Color.WHITE_SMOKE
	
	anim_sprite.material.set("shader_parameter/magic_color", spell_color)
