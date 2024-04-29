extends Node

@export var shaders: Array[Shader]
@export var materials: Array[Material]

func  _ready() -> void:
	return
	for m in materials:
		var sprite := Node2D.new()
		sprite.material = m
		add_child(sprite)
