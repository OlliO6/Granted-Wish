extends State

signal fire_attack

func _entered() -> void:
	fire_attack.emit()
