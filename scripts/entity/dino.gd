extends GridLiver
class_name Dino

@export var facing_direction: Vector2i = Vector2i.RIGHT
var eat_directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

func _ready():
	super._ready()
	_set_facing_direction(facing_direction)
	state["facing_direction"] = facing_direction
	
func _set_facing_direction(direction: Vector2i):
	facing_direction = direction
	match facing_direction:
		Vector2i.RIGHT:
			rotation = 90
		Vector2i.LEFT:
			rotation = 180
		Vector2i.DOWN:
			rotation = 200
		_:
			rotation = 0


func set_state(new_state: Dictionary):
	super.set_state(new_state)
	_set_facing_direction(state["facing_direction"])

func _update():
	super._update()
	state["facing_direction"] = facing_direction
	if not(move(facing_direction)):
		_set_facing_direction(-facing_direction)
	
	var current_tile = levelgrid.local_to_map(global_position)
	for direction in eat_directions:
		var entity = levelgrid.get_entity_at_tile(current_tile + direction)
		if entity != null and (entity is Player or entity is Food):
			print(self, "has eaten", entity)
	
