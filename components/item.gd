class_name Item
extends Node

signal collected

@export var effects: Array[ItemEffect]

var _collected: bool

func collect() -> void:
	
	if _collected:
		return
	
	_collected = true
	collected.emit()

func is_collected() -> bool:
	return _collected
