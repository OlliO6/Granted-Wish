class_name DamageDealer
extends Node

@export var damage: int = 1

func apply_damage(node: Node) -> void:
	var dmg := Components.get_damage_receiver(node)
	if dmg and !dmg.is_invincible():
		dmg.take_damage(damage, self)
