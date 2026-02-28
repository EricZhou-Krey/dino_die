extends GridLiver
class_name Player

@export var starting_tools: Array[String] = []
var available_tools: Array[Tool] = []
@export var sprite_sheet_offsets: Array[int] = []
var sprite_animate_index: int = 0
var current_tool_index: int = 0

func _ready():
	super._ready()
	for tool_label in starting_tools:
		available_tools.append(find_child(tool_label))

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
	if event.is_action_pressed("change_tool"):
		current_tool_index = (current_tool_index+1)%available_tools.size()
		_update_sprite()
	if event.is_action_pressed("use_tool"):
		available_tools[current_tool_index].use_tool(self)
	if event.is_action_pressed("undo"):
		levelgrid.revert()
	if event.is_action_pressed("reset"):
		levelgrid.reset()

func _update_sprite():
	var offset = sprite_sheet_offsets[current_tool_index]
	sprite_animate_index = (sprite_animate_index + 1) % 2
	offset += sprite_animate_index
	match facing_direction:
		Vector2i.LEFT:
			sprite_2d.frame = offset + 2
			sprite_2d.scale.x = 1
		Vector2i.RIGHT:
			sprite_2d.frame = offset + 2
			sprite_2d.scale.x = -1
		Vector2i.DOWN:
			sprite_2d.frame = offset
		Vector2i.UP:
			sprite_2d.frame = offset + 4

func _update():
	super._update()
	_update_sprite()
	
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
