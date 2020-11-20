extends Reference
class_name Join_Lobby_Settings

var user_name = ""
var address_line = "127.0.0.1:37256"

func load_state(save_dict):
	if not save_dict:
		return
	var saved_user_name = save_dict.get("user_name")
	if saved_user_name:
		user_name = saved_user_name
	var saved_address_line = save_dict.get("address_line")
	if saved_address_line:
		address_line = saved_address_line

func save_state():
	var save_dict = {}
	save_dict["user_name"] = user_name
	save_dict["address_line"] = address_line
	return save_dict
