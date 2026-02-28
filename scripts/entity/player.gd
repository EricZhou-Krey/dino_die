extends GridLiver
class_name Player

@export var available_tools : Array[Tool] = []
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
	if event.is_action_pressed("burn"):
		var current_tile = levelgrid.local_to_map(global_position)
		var entities = levelgrid.get_entities_at_tile(current_tile + facing_direction)
		for entity in entities:
			if entity != null and not(levelgrid.unreachable(entity.height, height)) and entity.has_method("burn"):
				entity.burn()
	
		levelgrid.progress_time()
	if event.is_action_pressed("change_tool"):
		current_tool_index = (current_tool_index+1)%available_tools.size()
	if event.is_action_pressed("tool"):
		available_tools[current_tool_index].use_tool(self)
	if event.is_action_pressed("undo"):
		levelgrid.revert()
	if event.is_action_pressed("reset"):
		levelgrid.reset()

func _update():
	super._update()
	var current_tile = levelgrid.local_to_map(global_position)
	var tile_data = levelgrid.get_cell_tile_data(0, current_tile)
	if tile_data.get_custom_data("win_tile"):
		var won = true
		var parent = get_parent()
		for entity in parent.get_children():
			if entity is Dino and entity.target:
				won = false
		if won:
			print("win")
