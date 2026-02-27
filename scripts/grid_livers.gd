extends Node2D
class_name GridLiver

@onready var levelgrid: LevelGrid = $"../LevelGrid"
@onready var sprite_2d: Sprite2D = $Sprite2D

signal push(tile: Vector2i, direction: Vector2i)

func _physics_process(delta):
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 2)
	
func move(direction: Vector2i):
	var current_tile: Vector2i = levelgrid.local_to_map(global_position)
	var target_tile: Vector2i = current_tile + direction
	
	var tile_data: TileData = levelgrid.get_cell_tile_data(0, target_tile)
	
	push.emit(target_tile, direction)
	if tile_data.get_custom_data("walkable") == false or levelgrid.blocked[target_tile.x + (target_tile.y * levelgrid.grid_size.x)]:
		return
			
	levelgrid.blocked[current_tile.x + (current_tile.y * levelgrid.grid_size.x)] = true
	
	global_position = levelgrid.map_to_local(target_tile)
	sprite_2d.global_position = levelgrid.map_to_local(current_tile)
