class_name AttackArea
extends Area2D

signal damage_applied(body: Node2D)

@export var damage_dealer: DamageDealer
@export var deactivate_on_damage_dealed: bool
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

	if damage_dealer:
		damage_dealer.apply_damage(body)
	
	if deactivate_on_damage_dealed:
		active = false

	damage_applied.emit(body)
