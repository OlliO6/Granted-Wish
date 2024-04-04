extends Sprite2D

@export var flip_h_to_player: bool

var tween: Tween

func _physics_process(delta: float) -> void:
	if flip_h_to_player:
		flip_h = Globals.get_player().global_position.x > global_position.x

func flash() -> void:
	if tween and tween.is_valid():
		tween.kill()
	tween = create_tween()
	tween.tween_property(material, "shader_parameter/flash", 0.5, 0.1)
	tween.tween_property(material, "shader_parameter/flash", 0.0, 0.2)
