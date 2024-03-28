extends Node

const DEADZONE = 0.2

func get_movement_input_vector() -> Vector2:

    var input := Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
    var lenght := input.length()

    if lenght < DEADZONE:
        return Vector2.ZERO

    if lenght > 1:
        input = input.normalized()

    return input
