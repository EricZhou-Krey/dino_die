extends Tool
class_name Torch

func use_tool(player: GridLiver) -> void:
	var current_tile = levelgrid.local_to_map(player.global_position)
	var entities = levelgrid.get_entities_at_tile(current_tile + player.facing_direction)
	for entity in entities:
			if not(player.levelgrid.unreachable(entity.height, player.height)):
				if entity != null and entity.has_method("burn"):
					entity.burn()
	
	levelgrid.progress_time()
