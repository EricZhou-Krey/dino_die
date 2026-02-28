extends TileMap
class_name LevelGrid

var entities: Array[Array] = []
var grid_size: Vector2i
var offset: Vector2i

var entity_history: Array[Dictionary] = [{}]
var entity_time: int = 0

signal update

func _ready():
	var used_rect = get_used_rect()
	grid_size = used_rect.size
	offset = used_rect.position
	
	entities.resize(grid_size.x * grid_size.y)
	
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var coords = Vector2i(x, y) + offset
			entities[x + (grid_size.x * y)] = []

func progress_time():
	entity_time += 1
	entity_history.append({})
	update.emit()

func revert():
	if len(entity_history) < 1: return
	var previous_states = entity_history.pop_back()
	for entity in previous_states:
		var parent = get_parent()
		if not(entity in parent.get_children()):
			parent.add_child(entity)
		entity.set_state(previous_states[entity])
	entity_time -= 1

func updated(entity: GridLiver, state: Dictionary):
	entity_history[entity_time][entity] = state

func get_entities_at_tile(tile: Vector2i):
	return entities[tile.x + (grid_size.x * tile.y)]

func add_entity_at_tile(tile: Vector2i, entity: GridLiver):
	entities[tile.x + (grid_size.x * tile.y)].append(entity)

func remove_entity_at_tile(tile: Vector2i, entity: GridLiver):
	entities[tile.x + (grid_size.x * tile.y)].erase(entity)

func unreachable(h_a: int, h_b: int):
	return h_a != h_b and h_a != h_b + 1 and h_a != h_b - 1
