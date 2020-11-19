extends Node

var entries

var user_name = ""

var lobby_key = ""

#clean up the session logic

var session : Session

var game_session: Session

var host_session: Session

var saved_ip_address = "127.0.0.1:37256"

var max_players = 100

var is_host = false

var is_connected = false


var save_path = "user://Multi_Bingo.save"

func _ready():
	load_game()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save()
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
	save_dict["user_name"] = user_name
	save_dict["entries"] = entries
	return save_dict

func load_from_dict(save_dict):
	user_name = save_dict.get("user_name")
	if not user_name:
		user_name = ""
	entries = save_dict.get("entries")
	if not entries:
		entries = []
