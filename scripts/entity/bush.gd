extends GridLiver
class_name Bush

@export var burn_timer = 3
var burn_directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
enum State { FRESH, PRE_BURNING, BURNING, BURNT }
var bush_state = State.FRESH

func _ready():
	var current_tile: Vector2i = levelgrid.local_to_map(global_position) 
	levelgrid.set_back_entity_at_tile(current_tile, self)
	levelgrid.connect("update", _update)
	
	state["position"] = global_position
	state["height"] = height
	state["burn_timer"] = burn_timer
	state["bush_state"] = bush_state#
	state["rotation"] = rotation

func set_state(new_state: Dictionary):
	var current_tile: Vector2i = levelgrid.local_to_map(global_position)
	levelgrid.set_back_entity_at_tile(current_tile, null)
	
	state = new_state
	global_position = state["position"]
	
	var new_tile: Vector2i = levelgrid.local_to_map(global_position)
	levelgrid.set_back_entity_at_tile(new_tile, self)
	
	sprite_2d.global_position = state["position"]
	height = state["height"]
	
	burn_timer = state["burn_timer"]
	bush_state = state["bush_state"]
	rotation = state["rotation"]
	
func move(_direction: Vector2i):
	return true

func burn():
	if bush_state == State.FRESH:
		bush_state = State.PRE_BURNING
		#change visual
		rotation = 15

func _update():
	super._update()
	state["burn_timer"] = burn_timer
	state["bush_state"] = bush_state
	state["rotation"] = rotation
	
	match bush_state:
		State.PRE_BURNING:
			bush_state = State.BURNING
			rotation = 25
		State.BURNING:
			var current_tile = levelgrid.local_to_map(global_position)
			for direction in burn_directions:
				var entity = levelgrid.get_back_entity_at_tile(current_tile + direction)
				if entity != null and entity.has_method("burn"):
					entity.burn()
			
			burn_timer -= 1
			if burn_timer == 0:
				bush_state = State.BURNT
				rotation = 45
	
