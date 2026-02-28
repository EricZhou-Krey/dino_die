extends Tool
class_name Torch


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func use_tool(player_position: Vector2, facing_direction: Vector2i, height: int) -> void:
	var current_tile = levelgrid.local_to_map(player_position)
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
