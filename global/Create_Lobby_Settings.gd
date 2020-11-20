extends Reference
class_name Create_Lobby_Settings

#var max_players = 100

var grid_size = 4

var port = 37256

func load_state(save_dict):
	if not save_dict:
		return
	var saved_grid_size = save_dict.get("grid_size")
	if saved_grid_size:
		grid_size = int(saved_grid_size)
	var saved_port = save_dict.get("port")
	if saved_port:
		port = int(saved_port)

func save_state():
	var save_dict = {}
	save_dict["grid_size"] = grid_size
	save_dict["port"] = port
	return save_dict
