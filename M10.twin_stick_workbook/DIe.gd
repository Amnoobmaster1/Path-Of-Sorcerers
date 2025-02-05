extends Item
class_name Die

@export var healing_amount := -50

func use(player: Player) -> void:
	player.health += healing_amount
