class_name Player
extends CharacterBody2D

const INVIS_COLL_LAYER = 10

@export var movement_speed: float

@onready var anim_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var dmg_receiver: DamageReceiver = get_node("DamageReceiver")
@onready var health_component: Health = get_node("Health")
@onready var knockback_component: Knockback = get_node("Knockback")
@onready var sm: StateMachine = get_node("StateMachine")
@onready var idle_state: State = get_node("StateMachine/IdleState")
@onready var run_state: State = get_node("StateMachine/RunState")
@onready var knockback_state: State = get_node("StateMachine/KnockbackState")
@onready var spell_casted_stun_state: State = get_node("StateMachine/SpellCastedStun")

var _spell_casted_stun_time: float

func _process(_delta: float) -> void:
	anim_sprite.material.set("shader_parameter/invis", dmg_receiver.is_invincible())

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
		
		knockback_state:
			velocity = knockback_component.velocity + \
				knockback_component.unrepress_movement * move_input * movement_speed

		spell_casted_stun_state:
			velocity = Vector2.ZERO
			_spell_casted_stun_time -= delta
			if _spell_casted_stun_time <= 0:
				sm.switch_state(idle_state)

	move_and_slide()

func _on_selected_spell_changed(spell_data: SpellData) -> void:

	var spell_color: Color
	
	if spell_data:
		spell_color = spell_data.color
	else:
		spell_color = Color.WHITE_SMOKE
	
	anim_sprite.material.set("shader_parameter/magic_color", spell_color)

func _on_spell_casted(_spell: Node2D, spell_data: SpellData) -> void:
	
	_spell_casted_stun_time = spell_data.player_stun_time
	sm.switch_state(spell_casted_stun_state)

func _on_damage_taken(amount: int, dealer: DamageDealer) -> void:
	Events.player_damaged.emit(amount, dealer)
	set_collision_layer_value(INVIS_COLL_LAYER, true)

func _on_knockback_started() -> void:
	sm.switch_state(knockback_state)

func _on_knockback_ended() -> void:
	if knockback_state.is_active():
		sm.switch_state(idle_state)

func _on_health_changed(health: int) -> void:
	Events.player_health_changed.emit(health)

func _on_died() -> void:
	Events.player_died.emit()
	get_tree().change_scene_to_file.call_deferred("res://ui/main_menu/main_menu.tscn")

func _on_invis_time_ended() -> void:
	set_collision_layer_value(INVIS_COLL_LAYER, false)
