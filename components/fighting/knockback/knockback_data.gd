class_name KnockbackData
extends Resource

@export var duration: float
@export var base_strenght: float
@export_range(0, 2) var dynamic_strenght_impact: float = 1
@export var velocity_curve: Curve
@export var unrepress_movement_curve: Curve
