extends GridLiver
class_name PlayerWT

@export var facing_direction: Vector2i = Vector2i.DOWN
@export var available_tools : Array[Tool]
var current_tool_index: int = 0

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
	if event.is_action_pressed("change_tool") and available_tools != null:
		current_tool_index = (current_tool_index+1)%available_tools.size()
	if event.is_action_pressed("tool") and available_tools != null and available_tools[current_tool_index]!=null:
		available_tools[current_tool_index].use_tool(global_position, facing_direction, height)
	if event.is_action_pressed("undo"):
		levelgrid.revert()
