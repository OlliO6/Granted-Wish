class_name DamageDealer
extends Node

const NODE_NAME = "DamageDealer"

@export var damage: int = 1

func apply_damage(node: Node) -> void:
	var dmg := node.get_node_or_null(DamageReceiver.NODE_NAME) as DamageReceiver
	if dmg and !dmg.is_invincible():
		dmg.take_damage(damage, self)
