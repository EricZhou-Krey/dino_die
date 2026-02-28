extends GridLiver
class_name DinoWS

@export var facing_direction: Vector2i = Vector2i.RIGHT
var eat_directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

func _ready():
	super._ready()
	_set_facing_direction(facing_direction)
	state["facing_direction"] = facing_direction
	
func _set_facing_direction(direction: Vector2i):
	facing_direction = direction
	match facing_direction:
		Vector2i.RIGHT:
			rotation = 90
		Vector2i.LEFT:
			rotation = 180
		Vector2i.DOWN:
			rotation = 270
		_:
			rotation = 0


func set_state(new_state: Dictionary):
	super.set_state(new_state)
	_set_facing_direction(state["facing_direction"])

func _update():
	check_sight()
	super._update()
	state["facing_direction"] = facing_direction
	if not(move(facing_direction)):
		_set_facing_direction(-facing_direction)
	#there is a bug here with some edge cases
	check_sight()
	eat_entities()

func eat_entities():
	var current_tile = levelgrid.local_to_map(global_position)
	for direction in eat_directions:
		var entities = levelgrid.get_entities_at_tile(current_tile + direction)
		for entity in entities:
			if levelgrid.unreachable(entity.height, height): continue
			if entity != null and (entity is Player or entity is Food):
				print(self, "has eaten", entity)
				
func check_sight()-> bool:
	var directions: Array[Vector2i] = [facing_direction]
	var leftDir : Vector2i = Vector2i(facing_direction.y, facing_direction.x)
	var rightDir: Vector2i = Vector2i(-facing_direction.y, -facing_direction.x)
	directions.append(leftDir)
	directions.append(rightDir)
	for direction in directions:
		if check_sight_direction(direction):
			print("player spotted by dino")
			return true
	return false
	
	
func check_sight_direction(direction: Vector2i)-> bool:
	var start_tile: Vector2i = levelgrid.local_to_map(global_position)
	var current_tile: Vector2i = start_tile
	var blocked : bool= false
	var loop_count : int = 11
	while not blocked and loop_count>0:
		loop_count-=1
		var target_tile: Vector2i = current_tile + direction
		current_tile = target_tile
		var tile_data: TileData = levelgrid.get_cell_tile_data(0, target_tile)
		if tile_data == null:
			return false
		else:
			print(target_tile)
			var entities_at_target = levelgrid.get_entities_at_tile(target_tile)
			for entity in entities_at_target:
				if entity !=null:
					if entity.height > height-2 and entity.height<= height:
						if entity is Player:
							print("seen")
							return true
						return false
	return false
