extends Node


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/example_level.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
