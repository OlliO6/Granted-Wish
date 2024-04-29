extends Control

@export var move_tutorial: CanvasItem
@export var cast_spells_tutorial: CanvasItem
@export var switch_spell_tutorial: CanvasItem

func _ready() -> void:

	move_tutorial.modulate.a = 0
	cast_spells_tutorial.modulate.a = 0
	switch_spell_tutorial.modulate.a = 0
	show_tutorial(move_tutorial, 2.8)

func show_tutorial(tutorial: CanvasItem, duration: float) -> void:

	var tween := create_tween()
	tween.tween_property(tutorial, "modulate:a", 1.0, 0.5)
	tween.tween_interval(duration)
	tween.tween_property(tutorial, "modulate:a", 0.0, 3).set_trans(Tween.TRANS_SINE)

func _on_first_enemy_wave_started() -> void:
	show_tutorial(cast_spells_tutorial, 3)

func _on_unlock_ice_spells_event_fired() -> void:
	show_tutorial(switch_spell_tutorial, 5)
