class_name UtilFunctions
extends Node

static func rand_range(v_range: Vector2, rng: RandomNumberGenerator=null) -> float:
	if rng:
		return rng.randf_range(v_range.x, v_range.y)
	return randf_range(v_range.x, v_range.y)

static func get_all_children(node: Node) -> Array[Node]:
	var nodes: Array = []

	for n in node.get_children():
		if n.get_child_count() > 0:
			nodes.append(n)
			nodes.append_array(get_all_children(n))
		else:
			nodes.append(n)

	return nodes