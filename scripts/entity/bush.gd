extends GridLiver
class_name Bush

var burning_bush: Resource = load("res://scripts/entity/flaming_bush.gd")

func move(_direction: Vector2i):
	return true

func burn():
	set_script(burning_bush)
