extends RichTextLabel
class_name RichTextLabelAnimated

@export var text_to_display :Array[String]=[]
var index :int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("next"):
			if text_to_display==null or index == text_to_display.size():
				get_tree().change_scene_to_file("res://scenes/example_level.tscn")
			else:
				display_next_line()
			

func display_next_line():
	if text_to_display != null:
		if index<text_to_display.size():
			self.clear()
			self.add_text(text_to_display[index])
	index+=1
