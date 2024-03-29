extends Node2D

signal spell_casted(spell: Node2D)

@export var spell_data: SpellData

@onready var timer: Timer = get_node("Timer")

func _ready() -> void:
	InputManager.attack_pressed.connect(_on_attack_pressed)
	timer.timeout.connect(_on_timeout)

func cast_spell(data: SpellData):
	var spell := data.spell_scene.instantiate() as Node2D
	get_tree().current_scene.add_child(spell)
	spell.position = global_position
	if data.rotated:
		spell.rotation = (get_global_mouse_position() - global_position).angle()
	
	spell_casted.emit(spell)
	timer.start(data.cast_delay)

func _on_attack_pressed() -> void:
	if !timer.is_stopped():
		return
	cast_spell(spell_data)

func _on_timeout() -> void:
	if spell_data.allow_hold and InputManager.is_attack_pressed():
		cast_spell(spell_data)