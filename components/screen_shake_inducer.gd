class_name ScreenShakeInducer
extends Node

@export var amplitude: float = 2
@export var duration: float = 0.5

func induce_shake() -> void:
	
	var cam = Globals.game.get_camera() as GameCamera
	
	if cam:
		cam.shake(amplitude, duration)
