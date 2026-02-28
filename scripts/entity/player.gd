extends GridLiver
class_name Player


func _input(event):
	var actions = {
		"left": Vector2i.LEFT,
		"right": Vector2i.RIGHT,
		"up": Vector2i.UP,
		"down": Vector2i.DOWN,
	}

	for action in actions:
		if event.is_action_pressed(action):
			levelgrid.update.emit()
			move(actions[action])
		if event.is_action_pressed("wait"):
			levelgrid.update.emit()

