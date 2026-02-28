extends Node2D
class_name GridLiver

@onready var levelgrid: LevelGrid = $"../LevelGrid"
@onready var sprite_2d: AnimatedSprite2D = $"AnimatedSprite2D"
@export var facing_direction: Vector2i = Vector2i.RIGHT
@export var height = 0

var transparent: bool = false
var pushable_uphill: bool = true
var pushable_downhill = false
var can_push: bool = true
signal updated(this: GridLiver, state: Dictionary)


var state = {}

func _ready():
	var current_tile: Vector2i = levelgrid.local_to_map(global_position) 
	levelgrid.add_entity_at_tile(current_tile, self)
	levelgrid.connect("update", _update)
	
	state["position"] = global_position
	state["height"] = height

func _update():
	if get_parent() == null: return
	levelgrid.updated(self, state.duplicate(true))
	state["position"] = global_position
	state["height"] = height

func set_state(new_state: Dictionary):
	var current_tile: Vector2i = levelgrid.local_to_map(global_position)
	levelgrid.remove_entity_at_tile(current_tile, self)
	
	state = new_state
	global_position = state["position"]
	
	var new_tile: Vector2i = levelgrid.local_to_map(global_position)
	levelgrid.add_entity_at_tile(new_tile, self)
	
	sprite_2d.global_position = state["position"]
	height = state["height"]

func _physics_process(delta):
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 2)
	
func move(direction: Vector2i) -> bool:
	var current_tile: Vector2i = levelgrid.local_to_map(global_position)
	var target_tile: Vector2i = current_tile + direction
	print(levelgrid)
	
	var tile_data: TileData = levelgrid.get_cell_tile_data(0, target_tile)
	
	if tile_data == null or tile_data.get_custom_data("walkable") == false:
		return false
	
	var new_height = height
	var tile_height = tile_data.get_custom_data("height")
	if tile_height != height:
		if pushable_uphill:
			var from_tile = levelgrid.get_cell_tile_data(0, current_tile)
			var slope_from = from_tile.get_custom_data("slope_direction")
			var slope_to = tile_data.get_custom_data("slope_direction")

			if height + 1 == tile_height and (slope_to == direction or slope_from == direction):
				new_height += 1
			elif height - 1 == tile_height and (slope_to == -direction or slope_from == -direction):
				new_height -= 1
			else:
				return false
		elif pushable_downhill and tile_height < height:
			new_height = tile_height
		else:
			return false
	
	var entities_at_target = levelgrid.get_entities_at_tile(target_tile)
	for entity_at_target in entities_at_target:
		var tile_behind_target = target_tile + direction
		var entities_behind_target = levelgrid.get_entities_at_tile(tile_behind_target)

		for entity_behind_target in entities_behind_target:
			if levelgrid.unreachable(entity_behind_target.height, entity_at_target.height): continue
			if entity_behind_target != null and not entity_behind_target.transparent and not entity_at_target.transparent:
				return false
		
		if not(entity_at_target.transparent):
			if not(can_push) or not(entity_at_target.move(direction)):
				return false
	
	height = new_height
	levelgrid.remove_entity_at_tile(current_tile, self)
	levelgrid.add_entity_at_tile(target_tile, self)
	
	global_position = levelgrid.map_to_local(target_tile)
	sprite_2d.global_position = levelgrid.map_to_local(current_tile)
	
	return true
