class_name Item
extends Node

signal collected

@export var effects: Array[ItemEffect]

var _collected: bool

func try_collect(collector: Node) -> bool:
	
	if can_collect(collector):
		collect(collector)
		return true
	else:
		return false

func collect(collector: Node) -> void:
	
	if _collected:
		return
	
	for effect in effects:
		if effect.can_use(collector):
			effect.use(collector)
	
	_collected = true
	collected.emit()

func can_collect(collector: Node) -> bool:
	
	for effect in effects:
		if effect.can_use(collector):
			return true
	
	return false

func is_collected() -> bool:
	return _collected
