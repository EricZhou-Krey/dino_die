extends Node2D
class_name MuseumScroll

@onready var museumgrid: LevelGrid = $"../LevelGrid"
@onready var sprite_2d: AnimatedSprite2D = $"AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_tile: Vector2i = museumgrid.local_to_map(global_position) 
	#pass # Replace with function body.

func _input(event):
	var movement = {
		"left": Vector2i.RIGHT,
		"right": Vector2i.LEFT,
	}
	for label in movement:
		if event.is_action_pressed(label):
			move(movement[label])

func _update():
	if get_parent() == null: return
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 2)

func move(direction: Vector2i):
	var current_tile: Vector2i = museumgrid.local_to_map(global_position)
	var target_tile: Vector2i = current_tile + direction
	
	global_position = museumgrid.map_to_local(target_tile)
	sprite_2d.global_position = museumgrid.map_to_local(current_tile)
