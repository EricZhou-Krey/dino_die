extends TileMap
class_name LevelGrid

var blocked: Array[bool] = []
var grid_size: Vector2i
var offset: Vector2i

func _ready():
	var used_rect = get_used_rect()
	grid_size = used_rect.size
	offset = used_rect.position
	
	blocked.resize(grid_size.x * grid_size.y)
	
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var coords = Vector2i(x, y) + offset
			var tile_data = get_cell_tile_data(0, coords)
			
			var is_blocked = false
			if tile_data and tile_data.get_custom_data("walkable") == false:
				is_blocked = true
				
			blocked[x + (grid_size.x * y)] = is_blocked

func get_blocked(tile: Vector2i):
	pass

func toggle_blocked(tile: Vector2i):
	blocked[tile.x + (tile.y * grid_size.x)] = not(blocked[tile.x + (tile.y * grid_size.x)])
