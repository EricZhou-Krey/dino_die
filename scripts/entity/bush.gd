extends GridLiver
class_name Bush

@export var burn_timer = 3
@export var random_bush = true
var burn_directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
enum State { FRESH, PRE_BURNING, BURNING, BURNT }
var bush_state = State.FRESH

func _ready():
	super._ready()
	transparent = true
	state["burn_timer"] = burn_timer
	state["bush_state"] = bush_state
	if random_bush: sprite_2d.frame = randi_range(0, 4)

func set_state(new_state: Dictionary):
	super.set_state(new_state)
	burn_timer = state["burn_timer"]
	bush_state = state["bush_state"]
	
func move(_direction: Vector2i):
	return true

func burn():
	if bush_state == State.FRESH:
		bush_state = State.PRE_BURNING

func _update():
	super._update()
	state["burn_timer"] = burn_timer
	state["bush_state"] = bush_state
	
	match bush_state:
		State.PRE_BURNING:
			bush_state = State.BURNING
			sprite_2d.play("burning")
			
		State.BURNING:
			var current_tile = levelgrid.local_to_map(global_position)
			for direction in burn_directions:
				var entities = levelgrid.get_entities_at_tile(current_tile + direction)
				for entity in entities:
					if levelgrid.unreachable(entity.height, height): continue
					if entity != null and entity.has_method("burn"):
						entity.burn()
			
			burn_timer -= 1
			if burn_timer == 0:
				bush_state = State.BURNT
				sprite_2d.play("default")
				sprite_2d.stop()
				sprite_2d.frame = 5
				
	
