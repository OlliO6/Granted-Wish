extends Node2D

@onready var spawn_sprite: Sprite2D = $SpawnSprite
@onready var character_body: CharacterBody2D = $CharacterBody2D

func _ready() -> void:
	character_body.process_mode = Node.PROCESS_MODE_DISABLED
	character_body.hide()

func _on_spawn_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn":
		spawn_sprite.hide()
		character_body.process_mode = Node.PROCESS_MODE_INHERIT
		character_body.show()
