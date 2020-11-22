extends Node

#constants
const save_path = "user://Multi_Bingo.save"

#global permanent data
var bingo_entries = []

var create_lobby_settings : Create_Lobby_Settings = Create_Lobby_Settings.new()

var join_lobby_settings : Join_Lobby_Settings = Join_Lobby_Settings.new()

#temporary data
var game_session: Session

var upnp
var upnp_port

var is_host = false
var is_connected = false

var bingo_score = 0


func _ready():
	randomize()
	load_game()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save()
		if upnp:
			upnp.delete_port_mapping(upnp_port)

		get_tree().quit()

func save():
	var save_dict = get_save_dict()
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_var(save_dict)
	file.close()

func load_game():
	var save_dict = load_save_dict()
	if not save_dict:
		return
	load_from_dict(save_dict)

func load_save_dict():
	var file = File.new()
	if not file.file_exists(save_path):
		return
	file.open(save_path, File.READ)
	var save_dict = file.get_var(true)
	file.close()
	return save_dict

func get_save_dict():
	var save_dict = {}
	save_dict["create_lobby_settings"] = create_lobby_settings.save_state()
	save_dict["join_lobby_settings"] = join_lobby_settings.save_state()
	save_dict["bingo_entries"] = bingo_entries
	save_dict["bingo_score"] = bingo_score
	return save_dict

func load_from_dict(save_dict):
	create_lobby_settings.load_state(save_dict.get("create_lobby_settings"))
	join_lobby_settings.load_state(save_dict.get("join_lobby_settings"))
	var saved_entries = save_dict.get("bingo_entries")
	if saved_entries:
		bingo_entries = saved_entries
	var saved_score = save_dict.get("bingo_score")
	if saved_score:
		bingo_score = saved_score

var save_dict = {}

func get_save_state(save_key):
	return save_dict.get(save_key)

func save_state(save_key, _save_dict):
	save_dict[save_key] = _save_dict
	
	

