extends CharacterBody2D


@export var max_speed := 444
@export var acceleration := 1600
var _player: Player = null
@onready var detection_area: Area2D = $DetectionArea


func _ready() -> void:
	detection_area.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
	)
	detection_area.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player = null
	)

func _physics_process(delta: float) -> void:
	if _player == null:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	else:
		var direction := global_position.direction_to(_player.global_position)
		var distance := global_position.distance_to(_player.global_position)
		var speed := max_speed if distance > 120 else max_speed 
		var desired_velocity := direction * speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)

	move_and_slide()
