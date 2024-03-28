class_name DamageReceiver
extends Node

const NODE_NAME = "DamageReceiver"

signal damage_taken(amount: int)
signal took_damage

@export var invincible: bool
@export var invis_time: float = 0.5
@export var health: Health

var invis_timer: float

func _process(delta: float) -> void:
	if invis_timer > 0:
		invis_timer -= delta

func take_damage(dmg: int) -> void:
	damage_taken.emit(dmg)
	took_damage.emit()
	invis_timer = invis_time
	if health:
		health.take_damage(dmg)

func is_invincible() -> bool:
	return invincible or invis_timer > 0
