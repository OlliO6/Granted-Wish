class_name State
extends Node

signal state_entered
signal state_exited

@export var disallow_switching: bool
@export var tags: PackedStringArray

func get_state_machine() -> StateMachine:
	return get_parent() as StateMachine

func is_active() -> bool:
	return get_state_machine().state == self

func enter() -> void:
	get_state_machine().switch_state(self)

func _sm_enter() -> void:
	state_entered.emit()
	_entered()

func _sm_exit() -> void:
	state_exited.emit()
	_exited()

func _entered() -> void:
	pass
	
func _exited() -> void:
	pass

func _allow_switch_to(state: State) -> bool:
	return not disallow_switching
