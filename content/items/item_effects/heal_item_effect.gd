class_name HealItemEffect
extends ItemEffect

@export var health_to_heal: int = 10

func can_use(node: Node) -> bool:
	var health := Components.get_health(node)
	return health and !health.is_full_health()

func use(node: Node) -> void:
	var health := Components.get_health(node)
	health.heal(health_to_heal)
