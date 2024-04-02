class_name StateMachine
extends Node

signal state_switched(to_state: State, from_state: State)

@export var start_state: State

var state: State
var prev_state: State

func _ready() -> void:
	_enter_start_state()
	
func _enter_start_state() -> void:
	if is_instance_valid(state):
		return
	if start_state:
		switch_state(start_state)
	else:
		switch_state(get_child(0))

func switch_state(to_state: State):
	prev_state = state
	state = to_state
	if prev_state:
		prev_state.exit()
	state.enter()
	state_switched.emit(to_state, prev_state)

func switch_state_str(state_node_path: NodePath):
	switch_state(get_node(state_node_path))
