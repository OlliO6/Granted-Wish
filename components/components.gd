class_name Components
extends Node

static func get_killable(node: Node) -> Killable:
	for i in node.get_child_count():
		var c = node.get_child(i)
		if c is Killable:
			return c
	return null

static func get_health(node: Node) -> Health:
	for i in node.get_child_count():
		var c = node.get_child(i)
		if c is Health:
			return c
	return null

static func get_damage_receiver(node: Node) -> DamageReceiver:
	for i in node.get_child_count():
		var c = node.get_child(i)
		if c is DamageReceiver:
			return c
	return null

static func get_damage_dealer(node: Node) -> DamageDealer:
	for i in node.get_child_count():
		var c = node.get_child(i)
		if c is DamageDealer:
			return c
	return null