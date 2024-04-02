class_name Health
extends Killable

signal health_changing(from: int, to_health: int)
signal health_changed(health: int)
signal healed(amount: int)
signal took_damage(amount: int)

@export var max_health: int = 10
@export var cap_to_max: bool

var health: int:
	set(v):
		if _dead:
			return

		health_changing.emit(health, v)
		health = v

		if health <= 0:
			die()
		elif cap_to_max and health > max_health:
			health = max_health

		health_changed.emit(health)
	get:
		return max(0, health)

func _ready() -> void:
	health = max_health

func take_damage(dmg: int) -> void:
	if _dead:
		return
	health -= dmg
	took_damage.emit(dmg)

func heal(amount: int, ignore_max_health:=false) -> void:
	if _dead:
		return
	if ignore_max_health:
		health += amount
	else:
		health = min(health + amount, max_health)
	healed.emit(amount)

func is_full_health() -> bool:
	return health >= max_health

# returns 1 if full live and 0 if dead
func get_ratio() -> float:
	return float(health) / float(max_health)

func die() -> void:
	super.die()
	health = 0

func revive() -> bool:
	health = max_health
	return super.revive()
