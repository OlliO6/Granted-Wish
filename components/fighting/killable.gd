class_name Killable
extends Node

signal died
signal revived

@export var allow_revival: bool

var _dead: bool

func die() -> void:
	if _dead:
		return
	_dead = true
	died.emit()
	Events.something_died.emit(get_parent(), self)

func revive() -> bool:
	if !_dead or !allow_revival:
		return false
	
	_dead = false
	revived.emit()
	return true

func is_dead() -> bool:
	return _dead
