class_name SpellCaster
extends Node2D

signal spell_casted(spell: Node2D, spell_data: SpellData)
signal selected_spell_changed(spell_data: SpellData)

@export var spell_data_list: Array[SpellData]

@onready var audio_player: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")

var _time_elapsed: float

var current_spell_idx: int:
	set(v):
		if v >= 0 and v < spell_data_list.size():
			current_spell_idx = v
			_current_spell = spell_data_list[v]

var _current_spell: SpellData:
	set(v):
		_current_spell = v
		selected_spell_changed.emit(v)

func _ready() -> void:
	current_spell_idx = 0

	Events.event_fired.connect(_on_event)
	InputManager.attack_pressed.connect(_on_attack_pressed)
	InputManager.spell_selected.connect(func(i): current_spell_idx=i - 1)
	InputManager.next_spell_pressed.connect(func(): current_spell_idx += 1)
	InputManager.previous_spell_pressed.connect(func(): current_spell_idx -= 1)

func _process(delta: float) -> void:
	
	if !_current_spell:
		return
	
	_time_elapsed += delta
	
	if _time_elapsed > _current_spell.cast_delay and _current_spell.allow_hold and InputManager.is_attack_pressed():
		cast_spell(_current_spell)

func cast_spell(data: SpellData) -> void:

	# Spawn Spell
	var spell := data.spell_scene.instantiate() as Node2D
	get_tree().current_scene.add_child(spell)
	spell.position = global_position
	if data.rotated:
		spell.rotation = (get_global_mouse_position() - global_position).angle()
	
	# Play cast sound
	audio_player.stream = data.cast_sfx
	audio_player.pitch_scale = UtilFunctions.rand_range(data.sfx_pitch_range)
	audio_player.play()

	spell_casted.emit(spell, data)
	_time_elapsed = 0

func get_current_spell_data() -> SpellData:
	return _current_spell

func _on_attack_pressed() -> void:
	if  _current_spell and _time_elapsed > _current_spell.cast_delay:
		cast_spell(_current_spell)

func _on_event(event: Event) -> void:
	if event is UnlockSpellEvent:
		spell_data_list.append(event.spell_to_unlock)
