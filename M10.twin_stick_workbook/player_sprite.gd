extends Sprite2D

const GODOT_BOTTOM = preload("res://player/godot_bottom.png")
const GODOT_BOTTOM_RIGHT = preload("res://player/godot_bottom_right.png")
const GODOT_RIGHT = preload("res://player/godot_right.png")
const GODOT_UP = preload("res://player/godot_up.png")
const GODOT_UP_RIGHT = preload("res://player/godot_up_right.png")

const UP_RIGHT = Vector2.UP + Vector2.RIGHT
const UP_LEFT = Vector2.UP + Vector2.LEFT
const DOWN_RIGHT = Vector2.DOWN + Vector2.RIGHT
const DOWN_LEFT = Vector2.DOWN + Vector2.LEFT


func _process(delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var direction_discrete := input_direction.sign()
	match direction_discrete:
		Vector2.RIGHT, Vector2.LEFT:
			texture = GODOT_RIGHT
		Vector2.UP:
			texture = GODOT_UP
		Vector2.DOWN:
			texture = GODOT_BOTTOM
		UP_RIGHT, UP_LEFT:
			texture = GODOT_UP_RIGHT
		DOWN_RIGHT, DOWN_LEFT:
			texture = GODOT_BOTTOM_RIGHT
	if direction_discrete.length() > 0:
		flip_h = direction_discrete.x < 0.0
