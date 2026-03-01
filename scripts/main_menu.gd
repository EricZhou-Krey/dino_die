extends Node

var button_pressed = ""

func _ready() -> void:
	$fade_transition.show()
	$fade_transition/AnimationPlayer.play("fade_in")
	$fade_transition/fade_in.start()

func fade_out () -> void:
	$fade_transition.show()
	$fade_transition/AnimationPlayer.play("fade_out")
	$fade_transition/fade_out.start()

func _on_start_pressed() -> void:
	button_pressed = "start"
	fade_out()


func _on_options_pressed() -> void:
	button_pressed = "options"
	fade_out()


func _on_quit_pressed() -> void:
	button_pressed = "quit"
	fade_out()


func _on_fade_in_timeout() -> void:
	$fade_transition.hide()
	


func _on_fade_out_timeout() -> void:
	match button_pressed:
		"start":
			get_tree().change_scene_to_file("res://scenes/level_select.tscn")
		"options":
			get_tree().change_scene_to_file("res://scenes/options.tscn")
		"quit":
			get_tree().quit()
	
