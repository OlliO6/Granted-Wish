extends Node

signal event_fired(event: Event)

signal player_health_changed(health: int)
signal player_damaged(damage: int, dealer: DamageDealer)
signal player_died

signal something_died(died: Node, killable: Killable)
