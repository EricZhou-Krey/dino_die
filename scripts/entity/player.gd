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
			levelgrid.update.emit()
			facing_direction = movement[label]
			move(movement[label])
	
	if event.is_action_pressed("wait"):
		levelgrid.update.emit()
	if event.is_action_pressed("burn"):
		var current_tile = levelgrid.local_to_map(global_position)
		var entity = levelgrid.get_entity_at_tile(current_tile + facing_direction)
		if entity != null and entity.has_method("burn"):
			entity.burn()
		levelgrid.update.emit()
