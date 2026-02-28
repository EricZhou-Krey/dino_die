extends GridLiver
class_name BurningBush

@export var burn_timer = 3
var burnt_bush: Resource = load("res://scripts/entity/burnt_bush.gd")
var burn_directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

func burnout():
	set_script(burnt_bush)

func _update():
	var current_tile = levelgrid.local_to_map(global_position)
	for direction in burn_directions:
		var entity = levelgrid.get_entity_at_tile(current_tile + direction)
		if entity is Bush:
			entity.burn
	
	burn_timer -= 1
	if burn_timer == 0:
		burnout()
