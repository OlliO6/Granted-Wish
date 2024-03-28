class_name AttackArea
extends Area2D

@export var damage_dealer: DamageDealer
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

	damage_dealer.apply_damage(body)