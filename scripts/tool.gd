extends Node2D
class_name Tool

@onready var levelgrid: LevelGrid = $"/root/ExampleLevel/LevelGrid"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func use_tool(global_position: Vector2, facing_direction: Vector2i, height: int) -> void:
	pass
