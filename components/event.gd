class_name Event
extends Node

signal fired

func fire() -> void:
	fired.emit()
	Events.event_fired.emit(self)
