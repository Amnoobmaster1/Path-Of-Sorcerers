@tool
class_name Pickup extends Area2D

@export var item: Item = null: set = set_item
@onready var _sprite_2d: Sprite2D = %Sprite2D
@onready var _audio_stream_player: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	set_item(item)
	body_entered.connect(func (body: Node2D) -> void:
		if body is Player:
			_animation_player.play("new_animation")
			item.use(body)
			set_deferred("monitoring", false)
			_audio_stream_player.play()
			_animation_player.animation_finished.connect(func (_animation_name: String) -> void:
				queue_free()
			)
	)



func set_item(value: Item) -> void:
	item = value
	if _sprite_2d != null:
		_sprite_2d.texture = item.texture
	if _audio_stream_player != null:
		_audio_stream_player.stream = item.sound_on_pickup
