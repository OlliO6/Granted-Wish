class_name Killable
extends Node

signal died
signal revived
signal death_confirmed

@export var allow_revival: bool

var _dead: bool
var _death_confirmed: bool

func _ready() -> void:
	tree_exiting.connect(_on_exiting_tree)

func die() -> void:
	
	if _dead:
		return
	_dead = true
	died.emit()
	Events.something_died.emit(get_parent(), self)

func revive() -> bool:
	
	if !_dead or !allow_revival or _death_confirmed:
		return false
	
	_dead = false
	revived.emit()
	return true

func confirm_death() -> void:
	
	if !_dead:
		die()
	_death_confirmed = true
	death_confirmed.emit()

func is_death_confirmed() -> bool:
	return _death_confirmed

func is_dead() -> bool:
	return _dead

func _on_exiting_tree() -> void:
	if !_death_confirmed and is_queued_for_deletion():
		confirm_death()
