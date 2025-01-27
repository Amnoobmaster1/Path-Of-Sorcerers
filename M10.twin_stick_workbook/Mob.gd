class_name Mob extends CharacterBody2D


@export var max_speed := 444
@export var acceleration := 1600
@export var health := 3: set = set_health

var _player: Player = null

var damage := 1

@onready var detection_area: Area2D = $DetectionArea
@onready var heloo: Area2D = $HELOO
#@onready var damage_hitbox: CollisionShape2D = $HELOO/damage_hitbox

func _ready() -> void:
	detection_area.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
	)
	detection_area.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player = null
	)
	heloo.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			health -= damage
			
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
