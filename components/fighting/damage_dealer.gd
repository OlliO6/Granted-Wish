class_name DamageDealer
extends Node2D

@export var damage: int = 1
@export var directional: bool = true
# Increases knockback and stuff
@export var impact_velocity_magnitude: float = 10
@export var knockback: KnockbackData
# Wont deal damage if dead
@export var killable: Killable

func apply_damage(node: Node) -> bool:

	if killable and killable.is_dead:
		return false

	var dmg := Components.get_damage_receiver(node)
	if dmg and !dmg.is_invincible():
		dmg.take_damage(damage, self)
		return true
	
	return false

func set_impact_velocity_magnitude(v: float):
	impact_velocity_magnitude = v
