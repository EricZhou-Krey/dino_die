extends GridLiver
class_name Rock

@onready var player: Player = $"../Player"

func _ready():
	player.connect("push", pushed)
	
func pushed(tile: Vector2i, direction: Vector2i):
	if tile == levelgrid.local_to_map(global_position):
		move(direction)
