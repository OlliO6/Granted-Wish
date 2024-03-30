class_name DamageReceiver
extends Node

signal damage_taken(amount: int, dealer: DamageDealer)
signal took_damage
signal hit_direction_update(rotation: float)

@export var invincible: bool
@export var invis_time: float = 0.0
@export var health: Health

var invis_timer: float

func _process(delta: float) -> void:
	if invis_timer > 0:
		invis_timer -= delta

func take_damage(dmg: int, dealer: DamageDealer) -> void:

	invis_timer = invis_time

	if dealer.directional:
		hit_direction_update.emit(dealer.global_rotation)
	damage_taken.emit(dmg, dealer)
	took_damage.emit()
	if health:
		health.take_damage(dmg)

func is_invincible() -> bool:
	return invincible or invis_timer > 0
