extends GridLiver
class_name Dino

@export var target = false
var eat_directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
enum Size { SMALL, MID, BIG }

@export var dino_size = Size.SMALL


func _ready():
	super._ready()
	if dino_size == Size.SMALL: transparent = true
	can_push = false
	_set_facing_direction(facing_direction)
	state["facing_direction"] = facing_direction
	
func _set_facing_direction(direction: Vector2i):
	facing_direction = direction

func set_state(new_state: Dictionary):
	super.set_state(new_state)
	_set_facing_direction(state["facing_direction"])

func _update():
	super._update()
	state["facing_direction"] = facing_direction
	match facing_direction:
		Vector2i.LEFT:
			sprite_2d.frame = 1
			sprite_2d.scale.x = 1
		Vector2i.RIGHT:
			sprite_2d.frame = 1
			sprite_2d.scale.x = -1
		Vector2i.UP:
			sprite_2d.frame = 2
		Vector2i.DOWN:
			sprite_2d.frame = 0

	check_sight_player()
	if not(move(facing_direction)):
		_set_facing_direction(-facing_direction)
	check_sight_player()
	check_sight_entity()
	eat_entities()

func eat_entities():
	var current_tile = levelgrid.local_to_map(global_position)
	for direction in eat_directions:
		var target_tile = current_tile + direction
		if target_tile.x >= levelgrid.grid_size.x or target_tile.y >= levelgrid.grid_size.y or \
			target_tile.x < 0 or target_tile.y < 0:
				continue
		var entities = levelgrid.get_entities_at_tile(current_tile + direction)
		for entity in entities:
			if levelgrid.unreachable(entity.height, height): continue
			if entity != null and (entity is Player or entity is Food):
				print(self, "has eaten", entity)
				
func check_sight_player():
	var directions: Array[Vector2i] = [facing_direction]
	var leftDir : Vector2i = Vector2i(facing_direction.y, facing_direction.x)
	var rightDir: Vector2i = Vector2i(-facing_direction.y, -facing_direction.x)
	directions.append(leftDir)
	directions.append(rightDir)
	for direction in directions:
		var seen_entity = check_sight_direction(direction)
		if seen_entity is Player:
			print("player spotted by dino")
			return
			
func check_sight_entity():
	var directions: Array[Vector2i] = [facing_direction]
	var leftDir : Vector2i = Vector2i(facing_direction.y, facing_direction.x)
	var rightDir: Vector2i = Vector2i(-facing_direction.y, -facing_direction.x)
	directions.append(leftDir)
	directions.append(rightDir)
	for direction in directions:
		var seen_entity = check_sight_direction(direction)
		if seen_entity is Bush and seen_entity.bush_state == seen_entity.State.BURNING:
			_set_facing_direction(-direction)
		if seen_entity is Dino and seen_entity.dino_size == Size.SMALL and dino_size != Size.SMALL:
			_set_facing_direction(direction)
		if seen_entity is Dino and seen_entity.dino_size == Size.MID and dino_size == Size.BIG:
			_set_facing_direction(direction)
	
	
func check_sight_direction(direction: Vector2i)-> GridLiver:
	var start_tile: Vector2i = levelgrid.local_to_map(global_position)
	var current_tile: Vector2i = start_tile
	var blocked: bool = false
	while not blocked:
		var target_tile: Vector2i = current_tile + direction
		current_tile = target_tile
		var tile_data: TileData = levelgrid.get_cell_tile_data(0, target_tile)
		if tile_data == null:
			return null
		else:
			if tile_data.get_custom_data("height") != height:
				return null
			var entities_at_target = levelgrid.get_entities_at_tile(target_tile)
			for entity in entities_at_target:
				if entity !=null:
					if entity.height > height-2 and entity.height<= height:
						return entity
	return null
