@tool
class_name Spawner
extends Node2D

signal about_to_spawn(node: Node)
signal spawned(node: Node)

enum ChildOfEnum {DirectChild, AsSibling, SiblingOfParent, Owner, SiblingOfOwner, ChildOfCurrentScene, SpecifiedParent}

@export var scene: PackedScene
@export var child_of := ChildOfEnum.SpecifiedParent
@export var specified_parent: NodePath

func _get_configuration_warnings() -> PackedStringArray:
	if !is_instance_valid(scene):
		return ["Scene not set"]
	if specified_parent.is_empty() and child_of == ChildOfEnum.SpecifiedParent:
		return ["Parent not specified"]
	return []

func _draw() -> void:
	if Engine.is_editor_hint():
		var clr = Color.SLATE_BLUE
		clr.a = 0.8
		draw_line(Vector2.ZERO, Vector2.RIGHT * 2, clr, 1)
		draw_circle(Vector2.ZERO, 1, clr)

func spawn() -> Node:

	var node := scene.instantiate()
	var parent: Node

	match child_of:
		ChildOfEnum.DirectChild:
			parent = self
		ChildOfEnum.AsSibling:
			parent = get_parent()
		ChildOfEnum.SiblingOfParent:
			parent = get_node("../..")
		ChildOfEnum.Owner:
			parent = owner
		ChildOfEnum.SiblingOfOwner:
			parent = owner.get_parent()
		ChildOfEnum.ChildOfCurrentScene:
			parent = get_tree().current_scene
		ChildOfEnum.SpecifiedParent:
			parent = get_node(specified_parent)

	assert(parent, "Couldnt find a parent.")

	about_to_spawn.emit(node)
	parent.add_child(node)

	if node is Node2D:
		node.global_transform = global_transform

	spawned.emit(node)
	return node
