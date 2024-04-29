class_name Knockback
extends Node2D

signal knockback_started
signal knockback_ended

@export var strenght_multiplier: float = 1

var velocity: Vector2
var unrepress_movement: float

var _knocking: bool
var _time_passed: float
var _current_data: KnockbackData
var _strenght: float

func _process(delta: float) -> void:
	
	if _knocking:
		_time_passed += delta
		_process_knockback()
		if !_knocking:
			knockback_ended.emit()

func is_knocking() -> bool:
	return _knocking

func _on_impact(direction: float, velocity_magnitude: float, trigger: Node) -> void:

	var data: KnockbackData
	if trigger is DamageDealer:
		data = trigger.knockback
	else:
		data = preload ("uid://bj02h8vlqos0j") # small_knockback.tres
	
	start_knockback(direction, velocity_magnitude, data)

func start_knockback(direction: float, strenght: float, data: KnockbackData) -> void:
	
	if !data:
		data = preload ("uid://bj02h8vlqos0j") # small_knockback.tres
	
	_knocking = true
	_current_data = data
	_strenght = strenght
	_time_passed = 0
	global_rotation = direction

	knockback_started.emit()

func compute_velocity(old_velocity: Vector2) -> Vector2:
	if not is_knocking():
		return old_velocity
	return (old_velocity * unrepress_movement) + velocity

func _process_knockback() -> void:

	var progress := clampf(_time_passed / _current_data.duration, 0, 1)
	velocity = ((_current_data.base_strenght + (_strenght * _current_data.dynamic_strenght_impact)) * _current_data.velocity_curve.sample(progress)) * transform.x * strenght_multiplier
	unrepress_movement = _current_data.unrepress_movement_curve.sample(progress)

	if _time_passed >= _current_data.duration:
		_knocking = false

func _on_damage_receiver_damage_taken(_amount: int, dealer: DamageDealer) -> void:
	if dealer.directional_impact:
		start_knockback(dealer.global_rotation, dealer.impact_velocity_magnitude, dealer.knockback)
