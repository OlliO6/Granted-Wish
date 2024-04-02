class_name DamageDealer
extends Node2D

signal dealed_damage(receiver: DamageReceiver)

@export var damage: int = 10
@export var directional_impact: bool = true
# Increases knockback and stuff
@export var impact_velocity_magnitude: float = 10
# Influences how knockback works
@export var force_away: bool = false
@export var knockback: KnockbackData
# Wont deal damage if dead
@export var killable: Killable

func apply_damage(node: Node) -> bool:

	if killable and killable.is_dead():
		return false

	var dmg := Components.get_damage_receiver(node)
	if dmg and !dmg.is_invincible():
		if force_away and node is Node2D:
			global_transform = global_transform.looking_at(node.global_position)
		dmg.take_damage(damage, self)
		dealed_damage.emit(damage)
		return true
	
	return false

func set_impact_velocity_magnitude(v: float):
	impact_velocity_magnitude = v
