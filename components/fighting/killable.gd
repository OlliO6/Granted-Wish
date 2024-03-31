class_name Killable
extends Node

signal died
signal revived

@export var allow_revival: bool

var is_dead: bool

func die() -> void:
	if is_dead:
		return
	is_dead = true
	died.emit()
	Events.something_died.emit(get_parent(), self)

func revive() -> bool:
	if !is_dead or !allow_revival:
		return false
	
	is_dead = false
	revived.emit()
	return true
