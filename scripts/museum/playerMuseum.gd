extends Node2D

#@export var sprite_sheet_offsets: Array[int] = []
var sprite_animate_index: int = 0
@onready var levelgrid: LevelGrid = $"../LevelGrid"
@onready var sprite_2d: AnimatedSprite2D = $"AnimatedSprite2D"
@export var facing_direction: Vector2i = Vector2i.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_sprite()

func _update_sprite():
	var offset = 0
	sprite_animate_index = (sprite_animate_index + 1) % 2
	offset += sprite_animate_index
	match facing_direction:
		Vector2i.LEFT:
			sprite_2d.frame = offset + 2
			sprite_2d.scale.x = 1
		Vector2i.RIGHT:
			sprite_2d.frame = offset + 2
			sprite_2d.scale.x = -1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	var movement = {
		"left": Vector2i.LEFT,
		"right": Vector2i.RIGHT,
	}
	
	for label in movement:
		if event.is_action_pressed(label):
			facing_direction = movement[label]
			_update_sprite()
