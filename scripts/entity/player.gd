extends GridLiver
class_name Player

@export var facing_direction: Vector2i = Vector2i.DOWN

func _input(event):
	var movement = {
		"left": Vector2i.LEFT,
		"right": Vector2i.RIGHT,
		"up": Vector2i.UP,
		"down": Vector2i.DOWN,
	}

	for label in movement:
		if event.is_action_pressed(label):
			facing_direction = movement[label]
			move(movement[label])
			levelgrid.progress_time()
	
	if event.is_action_pressed("wait"):
		levelgrid.progress_time()
	if event.is_action_pressed("burn"):
		var current_tile = levelgrid.local_to_map(global_position)
		var entities = levelgrid.get_entities_at_tile(current_tile + facing_direction)
		
		for entity in entities:
			if entity.height != height \
			and entity.height != height + 1 \
			and entity.height != height - 1:
				pass
			else:
				if entity != null and entity.has_method("burn"):
					entity.burn()
	
		levelgrid.progress_time()
		
	if event.is_action_pressed("undo"):
		levelgrid.revert()
