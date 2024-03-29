extends Node

const DEADZONE = 0.2

signal attack_pressed

func _unhandled_input(event: InputEvent) -> void:

    if event.is_echo():
        return

    if event.is_action_pressed("attack"):
        attack_pressed.emit()

func is_attack_pressed() -> bool:
    return Input.is_action_pressed("attack")

func get_movement_input_vector() -> Vector2:

    var input := Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
    var lenght := input.length()

    if lenght < DEADZONE:
        return Vector2.ZERO

    if lenght > 1:
        input = input.normalized()

    return input
