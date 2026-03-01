extends Tool
class_name Bucket
var full : bool = false

func use_tool(player: GridLiver) -> void:
	print(full)
	var current_tile = player.levelgrid.local_to_map(player.global_position)
	var entities = player.levelgrid.get_entities_at_tile(current_tile + player.facing_direction)
	for entity in entities:
			if not(player.levelgrid.unreachable_down(entity.height, player.height)):
				if entity is Water:
					full = true
				elif entity != null and entity.has_method("quench"):
					full = false
					entity.quench()
	
	player.levelgrid.progress_time()
