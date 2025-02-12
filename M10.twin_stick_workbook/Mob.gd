class_name Mob extends CharacterBody2D


@export var max_speed := 344
@export var acceleration := 1000
@export var health := 40: set = set_health
@onready var timer: Timer = $Timer

var _player: Player = null

var damage := 30

@onready var detection_area: Area2D = $DetectionArea
@onready var take_do: Area2D = $take_do





func _ready() -> void:
	detection_area.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
	)
	detection_area.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player = null
	)
	take_do.body_entered.connect(func (body: Node) -> void:
		if body is Bullet:
			health -= damage
	)
	take_do.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			body.health -= damage
	)


func set_health(new_health:int) -> void:
	health = new_health
	if health <= 0:
		die()

func die() -> void:
	queue_free()


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
