@tool
extends Node2D
class_name FacingVector

func _process(_delta):
	queue_redraw()

func _draw():
	var parent = get_parent()
	if parent and "facing_direction" in parent:
		var dir = parent.facing_direction
		var start_point = Vector2.ZERO
		var end_point = Vector2(dir.x, dir.y) * 20.0 
		
		draw_line(start_point, end_point, Color.CHARTREUSE, 2.0)

