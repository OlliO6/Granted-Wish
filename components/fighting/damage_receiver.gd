class_name DamageReceiver
extends Node

signal damage_taken(amount: int, dealer: DamageDealer)
signal took_damage
signal invis_time_ended

@export var invincible: bool
@export var invis_time: float = 0.05
@export var health: Health

var invis_timer: float

func _process(delta: float) -> void:

	if invis_timer > 0:
		invis_timer -= delta
		if invis_timer <= 0:
			invis_time_ended.emit()

func take_damage(dmg: int, dealer: DamageDealer) -> void:

	if is_invincible():
		return

	invis_timer = invis_time

	if health:
		health.take_damage(dmg)
	
	damage_taken.emit(dmg, dealer)
	took_damage.emit()

func is_invincible() -> bool:
	return invincible or invis_timer > 0
