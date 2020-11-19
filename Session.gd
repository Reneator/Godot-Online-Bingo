extends Reference
class_name Session

var username
var lobby_key
var entries = []
var grid_size
var peer_id

func as_json():
	var dict = self.as_dict()
	return to_json(dict)

func from_json(json_string):
	var dict = JSON.parse(json_string).result
	return from_dict(dict)

func as_dict():
	var dict = {}
	dict["username"] = username
	dict["lobby_key"] = lobby_key
	dict["entries"] = entries
	dict["grid_size"] = grid_size
	dict["peer_id"] = peer_id
	return dict

func from_dict(dict):
	username = dict.get("username")
	lobby_key = dict.get("lobby_key")
	entries = dict.get("entries")
	var grid_size_string = dict.get("grid_size")
	if grid_size_string:
		grid_size = int(grid_size_string)
	else:
		grid_size = 0
	var peer_id_string = dict.get("peer_id")
	if peer_id_string:
		peer_id = int(peer_id_string)
	return self
