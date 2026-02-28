extends Tool
class_name Hand

func use_tool(player: GridLiver) -> void:
	player.levelgrid.progress_time()
	
