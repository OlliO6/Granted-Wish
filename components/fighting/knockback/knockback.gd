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

func start_knockback(direction: float, strenght: float, data: KnockbackData) -> void:
	
	_knocking = true
	_current_data = data
	_strenght = strenght
	_time_passed = 0
	global_rotation = direction

	knockback_started.emit()

func _process_knockback() -> void:

	var progress = clampf(_time_passed / _current_data.duration, 0, 1)
	velocity = ((_current_data.base_strenght * _current_data.velocity_curve.sample(progress)) + (_strenght * _current_data.dynamic_strenght_impact)) * transform.x * strenght_multiplier
	unrepress_movement = _current_data.unrepress_movement_curve.sample(progress)

	if _time_passed >= _current_data.duration:
		_knocking = false
