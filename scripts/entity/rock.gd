extends GridLiver
class_name Rock

func _ready():
	super._ready()
	pushable_uphill = false

func _update():
	var current_tile = levelgrid.local_to_map(global_position)
	var entities = levelgrid.get_entities_at_tile(current_tile)
	for entity in entities:
		if entity is Dino:
			entity._update()
			get_parent().remove_child(entity)
			print("removed", entity)
	super._update()
