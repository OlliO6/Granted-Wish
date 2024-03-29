class_name UtilFunctions
extends Node

static func rand_range(v_range: Vector2, rng: RandomNumberGenerator=null) -> float:
	if rng:
		return rng.randf_range(v_range.x, v_range.y)
	return randf_range(v_range.x, v_range.y)