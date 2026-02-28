extends GridLiver
class_name Rock

func move(direction: Vector2i) -> bool:
	var current_tile: Vector2i = levelgrid.local_to_map(global_position)
	var target_tile: Vector2i = current_tile + direction
	
	var tile_data: TileData = levelgrid.get_cell_tile_data(0, target_tile)
	
	if tile_data == null or tile_data.get_custom_data("walkable") == false:
		return false
	
	var entities_at_target = levelgrid.get_entities_at_tile(target_tile)
	
	var tile_height = tile_data.get_custom_data("height")
	
	if tile_height != height:
		return false
	
	for entity_at_target in entities_at_target:
		var tile_behind_target = target_tile + direction
		var entities_behind_target = levelgrid.get_entities_at_tile(tile_behind_target)

		for entity_behind_target in entities_behind_target:
			if levelgrid.unreachable(entity_behind_target.height, entity_at_target.height): continue
			if entity_behind_target != null and not entity_behind_target.transparent and not entity_at_target.transparent:
				return false
		
		if not(entity_at_target.move(direction)):
			return false
	
	levelgrid.remove_entity_at_tile(current_tile, self)
	levelgrid.add_entity_at_tile(target_tile, self)
	
	global_position = levelgrid.map_to_local(target_tile)
	sprite_2d.global_position = levelgrid.map_to_local(current_tile)
	
	return true
