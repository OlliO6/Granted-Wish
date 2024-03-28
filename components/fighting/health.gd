class_name Health
extends Node

const NODE_NAME = "Health"

signal health_changed(health: int)
signal healed(amount: int)
signal took_damage(amount: int)
signal died
signal revived

@export var max_health: int = 10

var health: int:
	set(v):
		if is_dead:
			return
		health = v
		if health <= 0:
			die()
		health_changed.emit(health)

var is_dead: bool

func _ready() -> void:
	health = max_health

func take_damage(dmg: int) -> void:
	if is_dead:
		return
	health -= dmg
	took_damage.emit(dmg)

func heal(amount: int) -> void:
	if is_dead:
		return
	health = amount
	healed.emit(amount)

func die() -> void:
	if is_dead:
		return
	is_dead = true
	health = 0
	died.emit()

func revive(health_amount: int=- 1) -> bool:
	if !is_dead:
		return false
	
	is_dead = false
	health = health_amount if health_amount > 0 else max_health
	revived.emit()
	return true
