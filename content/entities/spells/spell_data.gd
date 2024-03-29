class_name SpellData
extends Resource

@export var spell_scene: PackedScene
@export var rotated: bool = true
@export var cast_delay: float = 1
@export var allow_hold: bool = false
@export var color: Color
@export var cast_sfx: AudioStream
@export var sfx_pitch_range: Vector2 = Vector2.ONE
