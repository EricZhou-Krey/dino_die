extends Tool
class_name Torch


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func use_tool(player_position: Vector2, facing_direction: Vector2i) -> void:
	var current_tile = levelgrid.local_to_map(player_position)
	var entity = levelgrid.get_back_entity_at_tile(current_tile + facing_direction)
	if entity != null and entity.has_method("burn"):
		entity.burn()
	levelgrid.progress_time()
