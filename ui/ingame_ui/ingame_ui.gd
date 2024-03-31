extends Control

signal health_progress_changed(progress: float)

@onready var health_bar: HealthBar = get_node("%HealthBar")

func _enter_tree() -> void:
	Events.player_health_changed.connect(_on_player_health_changed, CONNECT_DEFERRED)

func _on_player_health_changed(_health: int) -> void:
	var progress := Globals.game.get_player().health_component.get_ratio()
	_set_health_progress(progress)

func _set_health_progress(progress: float) -> void:
	health_bar.value = ceil(progress * health_bar.max_value)
	health_bar.health_progress_changed(progress)
