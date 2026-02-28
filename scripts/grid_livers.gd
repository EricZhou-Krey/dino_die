extends Node2D
class_name GridLiver

@onready var levelgrid: LevelGrid = $"../LevelGrid"
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	var current_tile: Vector2i = levelgrid.local_to_map(global_position) 
	levelgrid.set_entity_at_tile(current_tile, self)

func _physics_process(delta):
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 2)
	
func move(direction: Vector2i) -> bool:
	var current_tile: Vector2i = levelgrid.local_to_map(global_position)
	var target_tile: Vector2i = current_tile + direction
	
	var tile_data: TileData = levelgrid.get_cell_tile_data(0, target_tile)
	
	if tile_data == null or tile_data.get_custom_data("walkable") == false:
		return false
	
	var entity_at_target = levelgrid.get_entity_at_tile(target_tile)
	if entity_at_target != null:
		var tile_behind_target = target_tile + direction
		var entity_behind_target = levelgrid.get_entity_at_tile(tile_behind_target)
		
		if entity_behind_target != null:
			return false
			
		if not(entity_at_target.move(direction)):
			return false
		
	levelgrid.set_entity_at_tile(current_tile, null)
	levelgrid.set_entity_at_tile(target_tile, self)
	
	global_position = levelgrid.map_to_local(target_tile)
	sprite_2d.global_position = levelgrid.map_to_local(current_tile)
	
	return true
