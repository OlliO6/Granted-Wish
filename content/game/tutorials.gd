extends Node2D

@export var move_tutorial: CanvasItem
@export var cast_spells_tutorial: CanvasItem
@export var switch_spell_tutorial: CanvasItem

func _ready() -> void:

	move_tutorial.modulate.a = 0
	cast_spells_tutorial.modulate.a = 0
	switch_spell_tutorial.modulate.a = 0
	show_tutorial(move_tutorial)

func show_tutorial(tutorial: CanvasItem) -> void:

	var tween = create_tween()
	tween.tween_property(tutorial, "modulate:a", 1.0, 0.5)
	tween.tween_interval(5)
	tween.tween_property(tutorial, "modulate:a", 0.0, 3).set_trans(Tween.TRANS_SINE)
