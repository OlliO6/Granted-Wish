extends Area2D

@export var damage: int = 10
@export var active: bool = true:
	set(v):
		active = v
		if v:
			rescan()

func _ready() -> void:
	body_entered.connect(_apply_damage)

func rescan() -> void:
	for b in get_overlapping_bodies():
		_apply_damage(b)

func _apply_damage(body: Node2D) -> void:
	if !active:
		return

	var dmg := body.get_node_or_null("DamageReceiver") as DamageReceiver
	if dmg and !dmg.is_invincible():
		dmg.take_damage(damage)
