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
		if is_dead:
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
	died.connect(_on_died)
	revived.connect(_on_revived)

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

# returns 1 if full live and 0 if dead
func get_ratio() -> float:
	return float(health) / float(max_health)

func _on_died() -> void:
	health = 0

func _on_revived() -> void:
	health = max_health
