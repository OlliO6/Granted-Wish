class_name AttackArea
extends Area2D

signal damage_applied(body: Node2D)

@export var damage_dealer: DamageDealer
@export var active: bool = true:
	set(v):
		active = v
		if v:
			rescan()

func _ready() -> void:
	body_entered.connect(_apply_damage)
	Globals.game.get_player().dmg_receiver.invis_time_ended.connect(rescan)

func rescan() -> void:
	for b in get_overlapping_bodies():
		_apply_damage(b)

func set_active(a: bool):
	active = a

func _apply_damage(body: Node2D) -> void:
	if !active:
		return

	if damage_dealer and damage_dealer.apply_damage(body):
		damage_applied.emit(body)
