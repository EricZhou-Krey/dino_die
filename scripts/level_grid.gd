extends TileMap
class_name LevelGrid

var entities: Array[GridLiver] = []
var grid_size: Vector2i
var offset: Vector2i

signal update

func _ready():
	var used_rect = get_used_rect()
	grid_size = used_rect.size
	offset = used_rect.position
	
	entities.resize(grid_size.x * grid_size.y)
	
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var coords = Vector2i(x, y) + offset
			entities[x + (grid_size.x * y)] = null

func get_entity_at_tile(tile: Vector2i):
	return entities[tile.x + (grid_size.x * tile.y)]

func set_entity_at_tile(tile: Vector2i, entity: GridLiver):
	entities[tile.x + (grid_size.x * tile.y)] = entity
