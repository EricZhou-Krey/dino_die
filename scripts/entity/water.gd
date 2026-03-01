extends GridLiver
class_name Water

var full : bool = false
var contains : GridLiver = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	state["full"] = full
	state["contains"] = contains
	height = -2
	transparent = true
	can_push = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update():
	var current_tile = levelgrid.local_to_map(global_position)
	var entities = levelgrid.get_entities_at_tile(current_tile)
	for entity in entities:
		if entity is Rock and entity.get_parent() != null and not full:
			entity._update()
			set_contains(entity)
			get_parent().remove_child(entity)
	super._update()
	state["full"] = full
	state["contains"] = contains

func set_state(new_state: Dictionary):
	super.set_state(new_state)
	contains = state["contains"]
	full = state["full"]
	if not full:
		sprite_2d.frame = 0
	#revert appearance here


func isTransparent(entity: GridLiver):
	if full or entity is Rock:
		return true
	return false

func set_contains(obj : GridLiver):
	contains = obj
	full = true
	#change appearance here
	sprite_2d.frame = 1
	#transparent = true

func remove_from_contains():
	full = false
	#transparent = false
	var temp = contains
	contains = null
	return temp
