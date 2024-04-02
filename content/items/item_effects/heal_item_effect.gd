class_name HealItemEffect
extends ItemEffect

@export var health_to_heal: int = 10

func use(node: Node) -> void:
	var health := Components.get_health(node)
	health.heal(health_to_heal)
