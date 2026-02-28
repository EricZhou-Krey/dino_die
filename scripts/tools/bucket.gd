extends Tool
class_name Bucket

func use_tool(player: GridLiver) -> void:
	player.levelgrid.progress_time()

