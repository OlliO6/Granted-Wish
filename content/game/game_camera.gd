class_name GameCamera
extends Camera2D

@export var shake_noise: Noise

var _shake_amplitude: float
var _shake_duration: float

func shake(amplitude: float, duration: float) -> void:
	
	_shake_amplitude = max(_shake_amplitude, amplitude)
	_shake_duration = max(_shake_duration, duration)

func _process(delta: float) -> void:
	
	if _shake_duration <= 0:
		_shake_duration = 0
		_shake_amplitude = 0
		offset = Vector2.ZERO
		return
	
	_shake_duration -= delta
	
	# Magic Value Party
	offset = _shake_amplitude * lerpf(0, 1, clampf(_shake_duration * 2, 0, 1)) * Vector2(
		shake_noise.get_noise_2d(Time.get_ticks_msec() * 0.1, 0),
		shake_noise.get_noise_2d(Time.get_ticks_msec() * 0.1, 100))
