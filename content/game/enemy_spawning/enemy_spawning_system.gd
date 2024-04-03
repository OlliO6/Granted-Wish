class_name EnemySpawningSystem
extends Node2D

signal celebrated_wave_cleared
signal all_waves_cleared

var _current_phase_idx: int
var _phase: Node

func _ready() -> void:
	_start_phase()

func _start_phase() -> void:
	_phase = get_child(_current_phase_idx)
	if _phase is EnemyWave:
		_phase.start_wave()
		_phase.wave_cleared.connect(_next_phase, CONNECT_ONE_SHOT)
	elif _phase is Timer:
		_phase.start()
		_phase.timeout.connect(_next_phase, CONNECT_ONE_SHOT)
	else:
		if _phase is Event:
			_phase.fire()
		_next_phase()

func _next_phase() -> void:
	if _phase is EnemyWave and _phase.celebrated:
		celebrated_wave_cleared.emit()
	_current_phase_idx += 1
	if _current_phase_idx >= get_child_count():
		all_waves_cleared.emit()
		print("cleared all phases")
	else:
		_start_phase()
