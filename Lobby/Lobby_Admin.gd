extends Control

var session_manager = Session_Manager.new()

var full_ip_string

onready var create_lobby_settings: Create_Lobby_Settings = Global.create_lobby_settings

func _ready():
	Game.connect("client_ready", self, "on_client_ready")
	$HTTPRequest.connect("request_completed", self, "on_request_completed")
	$HTTPRequest.request("https://api.ipify.org")
	var user_name = Global.join_lobby_settings.user_name
	$HBoxContainer3/Username.text = Global.join_lobby_settings.user_name
	var session = Session.new()
	session.username = user_name
	session.ip_address = "host"
	session.peer_id = 1
	session.grid_size = create_lobby_settings.grid_size
	Global.game_session = session_manager.get_session(session, create_lobby_settings.grid_size)
	$Bingo.initialize(Global.game_session.bingo_entries, Global.game_session.grid_size)


func on_request_completed(result, response_code, headers, body):
	var string = body.get_string_from_utf8()
	var ip = string
	var port = str(Global.upnp_port)
	$HBoxContainer/HBoxContainer/IP_Address.text = ip
	$HBoxContainer/HBoxContainer/Port.text = port
	full_ip_string = ip+":"+port


func on_client_ready(request_session):
	print("on_client_ready!")

	var client_session = session_manager.get_session(request_session, create_lobby_settings.grid_size)
	var client_session_json = client_session.as_json()

	Game.rpc_id(client_session.peer_id, "start_game", client_session_json)


func _on_Copy_IP_Button_pressed():
	OS.set_clipboard(full_ip_string)
	
	var clip_board = OS.get_clipboard()
	if clip_board == full_ip_string:
		print("Copied successfully")
