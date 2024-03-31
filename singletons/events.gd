extends Node

signal player_health_changed(health: int)
signal player_damaged(damage: int, dealer: DamageDealer)
signal player_died

signal something_died(died: Node, killable: Killable)
