extends Item
class_name healthHeal

@export var healing_amount := 75

func use(player: Player) -> void:
	player.health += healing_amount
	
