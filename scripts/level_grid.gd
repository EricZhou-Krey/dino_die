extends TileMap
class_name LevelGrid

var back_entities: Array[GridLiver] = []
var entities: Array[GridLiver] = []
var grid_size: Vector2i
var offset: Vector2i

var entity_history: Array[Dictionary] = [{}]
var entity_time: int = 0

signal update

func _ready():
	var used_rect = get_used_rect()
	grid_size = used_rect.size
	offset = used_rect.position
	
	back_entities.resize(grid_size.x * grid_size.y)
	entities.resize(grid_size.x * grid_size.y)

func progress_time():
	entity_time += 1
	entity_history.append({})
	update.emit()

func revert():
	if len(entity_history) < 1: return
	var previous_states = entity_history.pop_back()
	for entity in previous_states:
		# check if entity exists if it does not then create it beofre setting state
		entity.set_state(previous_states[entity])
	entity_time -= 1

func updated(entity: GridLiver, state: Dictionary):
	entity_history[entity_time][entity] = state


func get_back_entity_at_tile(tile: Vector2i):
	return back_entities[tile.x + (grid_size.x * tile.y)]

func set_back_entity_at_tile(tile: Vector2i, entity: GridLiver):
	back_entities[tile.x + (grid_size.x * tile.y)] = entity
	
func get_entity_at_tile(tile: Vector2i):
	return entities[tile.x + (grid_size.x * tile.y)]

func set_entity_at_tile(tile: Vector2i, entity: GridLiver):
	entities[tile.x + (grid_size.x * tile.y)] = entity
