extends GridLiver
class_name Rock

@onready var bloodgrid: TileMap = $"../BloodGrid"

func _ready():
	super._ready()
	pushable_uphill = false
	pushable_downhill = true

func _update():
	var current_tile = levelgrid.local_to_map(global_position)
	var entities = levelgrid.get_entities_at_tile(current_tile)
	for entity in entities:
		if entity is Dino and entity.get_parent() != null and entity.dino_size == entity.Size.SMALL:
			entity._update()
			get_parent().remove_child(entity)
			bloodgrid.set_cell(0, current_tile, -1, Vector2i(0,0))
	super._update()
