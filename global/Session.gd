extends RefCounted
class_name Session

var username
var ip_address
var lobby_key
var creation_date 
var bingo_entries = [] # for initialization
var bingo_entries_states = [] # for the current state of the bingo-field
var bingo_entries_validation = [] # for validation with the bingo-log
var grid_size
var peer_id
var is_connected = false : set = set_connected

func set_connected(_connected):
	is_connected = _connected

func as_json():
	var dict = self.as_dict()
	var json_string = JSON.stringify(dict)
	return json_string

func from_json(json_string):
	var json = JSON.new()
	var json_result = json.parse(json_string)
	var dict = json.get_data()
	return from_dict(dict)

func as_dict():
	var dict = {}
	dict["username"] = username
	dict["ip_address"] = ip_address
	dict["lobby_key"] = lobby_key
	dict["bingo_entries"] = bingo_entries
	dict["bingo_entries_states"] = bingo_entries_states	
	dict["grid_size"] = grid_size
	dict["peer_id"] = peer_id
	return dict

func from_dict(dict):
	username = dict.get("username")
	lobby_key = dict.get("lobby_key")
	bingo_entries = dict.get("bingo_entries")
	bingo_entries_states = dict.get("bingo_entries_states")
	ip_address = dict.get("ip_address")
	var grid_size_string = dict.get("grid_size")
	if grid_size_string:
		grid_size = int(grid_size_string)
	else:
		grid_size = 0
	var peer_id_string = dict.get("peer_id")
	if peer_id_string:
		peer_id = int(peer_id_string)
	return self
