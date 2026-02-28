extends GridLiver
class_name Bush


@export var burn_timer = 3
var burn_directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
enum State { FRESH, PRE_BURNING, BURNING, BURNT }
var current_state = State.FRESH

func move(_direction: Vector2i):
	return true

func burn():
	if current_state == State.FRESH:
		current_state = State.PRE_BURNING
		#change visual
		rotation = 15

func _update():
	match current_state:
		State.PRE_BURNING:
			current_state = State.BURNING
			rotation = 25
		State.BURNING:
			var current_tile = levelgrid.local_to_map(global_position)
			for direction in burn_directions:
				var entity = levelgrid.get_entity_at_tile(current_tile + direction)
				if entity != null and entity.has_method("burn"):
					entity.burn()
			
			burn_timer -= 1
			if burn_timer == 0:
				current_state = State.BURNT
				rotation = 45
