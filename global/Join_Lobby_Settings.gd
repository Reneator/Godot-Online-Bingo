extends Reference
class_name Join_Lobby_Settings

var username = ""
var address_line = "127.0.0.1:37256"

func load_state(save_dict):
	if not save_dict:
		return
	var saved_username = save_dict.get("username")
	if saved_username:
		username = saved_username
	var saved_address_line = save_dict.get("address_line")
	if saved_address_line:
		address_line = saved_address_line

func save_state():
	var save_dict = {}
	save_dict["username"] = username
	save_dict["address_line"] = address_line
	return save_dict
